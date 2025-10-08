-- '$P!{dBeginDate}'
-- '$P!{dEndDate}'
-- '$P!{cPlanGroup}'
-- '$P!{bPlan}'
-- '$P!{cWard}'
SELECT *
,CASE WHEN (nurse_receive_drug_date IS NULL OR nurse_receive_drug_time IS NULL OR receive_drug_date IS NULL OR receive_drug_time IS NULL)
			 or  (nurse_receive_drug_date = '' OR nurse_receive_drug_time = '' OR receive_drug_date = '' OR receive_drug_time = '') THEN '-'
           ELSE  cal_date_time_diff(nurse_receive_drug_date,nurse_receive_drug_time,receive_drug_date,receive_drug_time ) END AS ward_time
,CASE WHEN (receive_drug_date IS NULL OR receive_drug_time IS NULL OR pharm_approve_date IS NULL OR pharm_approve_time IS NULL)
			or (receive_drug_date = '' OR receive_drug_time = '' OR pharm_approve_date = '' OR pharm_approve_time = '') THEN '-'
           ELSE  cal_date_time_diff(receive_drug_date,receive_drug_time,pharm_approve_date,pharm_approve_time) END AS pharm_time
,CASE WHEN (pharm_approve_date IS NULL OR pharm_approve_time IS NULL OR send_ur_date IS NULL OR send_ur_time IS NULL)
			or (pharm_approve_date = '' OR pharm_approve_time = '' OR send_ur_date = '' OR send_ur_time = '') THEN '-'
           ELSE  cal_date_time_diff(pharm_approve_date,pharm_approve_time,cash2ur_date,cash2ur_time) END AS cash1_time
,CASE WHEN (send_ur_date IS NULL OR send_ur_time IS NULL OR send_ur_date IS NULL OR send_ur_time IS NULL)
			or (send_ur_date = '' OR send_ur_time = '' OR send_ur_date = '' OR send_ur_time = '') THEN '-'
           ELSE  cal_date_time_diff(cash2ur_date,cash2ur_time,send_ur_date,send_ur_time) END AS ur_time
,CASE WHEN (send_ur_date IS NULL OR send_ur_time IS NULL OR send_tqc_date IS NULL OR cut_receipt_time IS NULL)
			or (send_ur_date = '' OR send_ur_time = '' OR send_tqc_date = '' OR cut_receipt_time = '') THEN '-'
           ELSE  cal_date_time_diff(send_ur_date,send_ur_time,send_tqc_date,send_tqc_time) END AS cash2_time
,CASE WHEN (doctor_assign_time IS NULL OR send_tqc_time IS NULL OR doctor_assign_date IS NULL OR send_tqc_date IS NULL )
			or (doctor_assign_time = '' OR send_tqc_time = '' OR doctor_assign_date = '' OR send_tqc_date = '' ) THEN '-'
          ELSE  subtract_time_secs(doctor_assign_time,send_tqc_time,doctor_assign_date,send_tqc_date) END AS total_sec
,CASE WHEN (doctor_assign_date IS NULL OR doctor_assign_time IS NULL  OR send_tqc_date IS NULL  OR send_tqc_time IS NULL )
			or (doctor_assign_date = '' OR doctor_assign_time = ''  OR send_tqc_date = ''  OR send_tqc_time = '' ) THEN '-'
          ELSE  cal_date_time_diff(doctor_assign_date,doctor_assign_time,send_tqc_date,send_tqc_time) END  AS total_time
,CASE WHEN ( ur_wait_fax_date IS NULL OR ur_wait_fax_time IS NULL  OR send_ur_date IS null OR send_ur_time IS NULL  )
			or ( ur_wait_fax_date = '' OR ur_wait_fax_time = ''  OR send_ur_date = '' OR send_ur_time = ''  ) THEN '-'
					ELSE  cal_date_time_diff(ur_wait_fax_date,ur_wait_fax_time,send_ur_date,send_ur_time) END  AS sum_wait_insure
,CASE WHEN ( send_ur_date IS NULL OR send_ur_time IS NULL  OR nurse_receive_drug_date IS null OR nurse_receive_drug_time IS NULL  )
			or ( send_ur_date = '' OR send_ur_time = ''  OR nurse_receive_drug_date = '' OR nurse_receive_drug_time = ''  ) THEN '-'
          ELSE  cal_date_time_diff(nurse_receive_drug_date,nurse_receive_drug_time,ur_wait_fax_date,ur_wait_fax_time) END  AS internal_time
FROM (
SELECT admit.visit_id
,admit.admit_id
,format_an(admit.an) AS an
,find_employee_name(ipd_attending_physician.employee_id) AS doctor_attending_physician
,find_patient_name(admit.patient_id) AS patient_name
,imed_get_current_ward(admit.admit_id) AS ward_id
,imed_get_current_ward_name(admit.admit_id) AS ward_name
, sts.stamp_date as ur_wait_fax_date
, sts.stamp_time as ur_wait_fax_time
, rec2.receive_date
, rec2.receive_time
, rec.payer_name
,(SELECT   prescription.assign_date
                 FROM prescription
                 WHERE  prescription.take_home = '1' AND prescription.pn = ''
                 AND prescription.visit_id = admit.visit_id
                 ORDER BY prescription.assign_date||prescription.assign_time LIMIT 1  ) AS doctor_assign_date
,(SELECT   prescription.assign_time
                 FROM prescription
                 WHERE  prescription.take_home = '1' AND prescription.pn = ''
                 AND prescription.visit_id = admit.visit_id
                 ORDER BY prescription.assign_date||prescription.assign_time LIMIT 1  ) AS doctor_assign_time
-- พยาบาล กดรับยา
,(SELECT   order_doctor_accept.accept_date
                 FROM order_doctor_accept
                 WHERE order_doctor_accept.visit_id = admit.visit_id
                 AND  order_doctor_accept.order_id IN (SELECT order_item_id FROM order_item
                                                                             WHERE order_item.take_home = '1'
                                                                             AND order_item.visit_id = order_doctor_accept.visit_id
                                                                             ORDER BY order_item.verify_date||order_item.verify_time LIMIT 1)limit 1) AS  nurse_receive_drug_date
,(SELECT   order_doctor_accept.accept_time || ':00' as accept_time
                 FROM order_doctor_accept
                 WHERE order_doctor_accept.visit_id = admit.visit_id
                 AND  order_doctor_accept.order_id IN (SELECT order_item_id FROM order_item
                                                                             WHERE order_item.take_home = '1'
                                                                             AND order_item.visit_id = order_doctor_accept.visit_id
                                                                             ORDER BY order_item.verify_date||order_item.verify_time LIMIT 1)limit 1) AS  nurse_receive_drug_time
-- คืนยา - รับยา
,(SELECT return_drug.return_date
                 FROM return_drug
                 WHERE return_drug.visit_id = admit.visit_id
                 ORDER BY return_drug.return_drug_id DESC LIMIT 1) AS return_drug_date -- ORDER BY Desc
,(SELECT return_drug.return_time
                 FROM return_drug
                 WHERE return_drug.visit_id = admit.visit_id
                 ORDER BY return_drug.return_drug_id DESC LIMIT 1) AS return_drug_time -- ORDER BY Desc
,(SELECT CASE WHEN return_drug.receive_date = '' THEN Null ELSE return_drug.receive_date  END
                 FROM return_drug
                 WHERE return_drug.visit_id = admit.visit_id
                 ORDER BY return_drug.return_drug_id DESC  LIMIT 1) AS receive_drug_date
,(SELECT CASE WHEN return_drug.receive_time = '' THEN Null ELSE return_drug.receive_time END
                 FROM return_drug
                 WHERE return_drug.visit_id = admit.visit_id
                 ORDER BY return_drug.return_drug_id DESC LIMIT 1) AS receive_drug_time
-- ห้องยา Approve
,(SELECT   prescription.approve_date
                 FROM prescription
                 WHERE  prescription.take_home = '1' AND prescription.pn <> ''
                 AND prescription.visit_id = admit.visit_id
                 ORDER BY prescription.assign_date||prescription.assign_time LIMIT 1  ) AS pharm_approve_date
,(SELECT   prescription.approve_time
                 FROM prescription
                 WHERE  prescription.take_home = '1' AND prescription.pn <> ''
                 AND prescription.visit_id = admit.visit_id
                 ORDER BY prescription.assign_date||prescription.assign_time LIMIT 1  ) AS pharm_approve_time
,(SELECT  visit_queue.next_location_date
                FROM  visit_queue
                WHERE  visit_queue.assign_location_spid in ('03CASHIP', '03CASHOP')
                AND visit_queue.next_location_spid = '03TPI'
                AND visit_queue.visit_id = admit.visit_id
                ORDER BY visit_queue_id DESC LIMIT 1) AS cash2ur_date
,(SELECT  visit_queue.next_location_time
                FROM  visit_queue
                WHERE  visit_queue.assign_location_spid in ('03CASHIP', '03CASHOP')
                AND visit_queue.next_location_spid = '03TPI'
                AND visit_queue.visit_id = admit.visit_id
                ORDER BY visit_queue_id DESC LIMIT 1) AS cash2ur_time
,(SELECT  visit_queue.next_location_date
                FROM  visit_queue
                WHERE  visit_queue.assign_location_spid = '03TPI'
                AND visit_queue.next_location_spid  in ('03CASHIP', '03CASHOP')
                AND visit_queue.visit_id = admit.visit_id
                ORDER BY visit_queue_id DESC LIMIT 1) AS send_ur_date
,(SELECT  visit_queue.next_location_time
                FROM  visit_queue
                WHERE  visit_queue.assign_location_spid = '03TPI'
                AND visit_queue.next_location_spid  in ('03CASHIP', '03CASHOP')
                AND visit_queue.visit_id = admit.visit_id
                ORDER BY visit_queue_id DESC LIMIT 1) AS send_ur_time
-- การเงินตัดยอด
,(SELECT  visit_queue.next_location_date
                FROM  visit_queue
                WHERE  visit_queue.assign_location_spid = '03TPI'
                AND visit_queue.next_location_spid = '03CASHIP'
                AND visit_queue.visit_id = admit.visit_id
                ORDER BY visit_queue_id DESC LIMIT 1) AS cut_receipt_date
,(SELECT  visit_queue.next_location_time
                FROM  visit_queue
                WHERE  visit_queue.assign_location_spid = '03TPI'
                AND visit_queue.next_location_spid = '03CASHIP'
                AND visit_queue.visit_id = admit.visit_id
                ORDER BY visit_queue_id DESC LIMIT 1) AS cut_receipt_time
-- ส่ง TQC
,(SELECT  visit_queue.next_location_date
                FROM  visit_queue
                WHERE
								--visit_queue.assign_location_spid in ('03CASHIP','03CASHOP') // Ngamnuch Malangpootong request assign all spid 19/05/63
                --AND
								visit_queue.next_location_spid = '03TQC'
                AND visit_queue.visit_id = admit.visit_id
                ORDER BY visit_queue_id DESC LIMIT 1) AS send_tqc_date
,(SELECT  visit_queue.next_location_time
                FROM  visit_queue
                WHERE
								--visit_queue.assign_location_spid in ('03CASHIP','03CASHOP') // Ngamnuch Malangpootong request assign all spid 19/05/63
                --AND
								visit_queue.next_location_spid = '03TQC'
                AND visit_queue.visit_id = admit.visit_id
                ORDER BY visit_queue_id DESC LIMIT 1) AS send_tqc_time
FROM admit
LEFT JOIN ipd_attending_physician ON admit.admit_id = ipd_attending_physician.admit_id AND ipd_attending_physician.priority = '1' and is_current = '1'
INNER JOIN visit ON admit.visit_id = visit.visit_id
LEFT JOIN visit_payment ON visit.visit_id = visit_payment.visit_id AND visit_payment.priority = '1'
LEFT JOIN plan ON visit_payment.plan_id = plan.plan_id
LEFT JOIN base_plan_group ON plan.base_plan_group_id = base_plan_group.base_plan_group_id
left join service_time_stamp sts on sts.fix_time_stamp_point_id = 'WAIT_FAX_CLAIM' and admit.visit_id = sts.visit_id
left join
		(
			select	visit_id
					, max(r2.receive_date || ' ' || r2.receive_time) as receive_datetime
					, concatenate(distinct b.description || ' ') as payer_name
					, sum(case when c.group_type = 'IN' THEN 1 ELSE 0 END) as count_in
			from 	receipt r2 left join payer b on r2.payer_id = b.payer_id
						INNER JOIN base_plan_group c on b.base_plan_group_id = c.base_plan_group_id
			where 	r2.fix_receipt_type_id = '7'
							and r2.fix_receipt_status_id = '2'
							and c.group_type <> 'DISCOUNT'
			group by visit_id
		)rec on admit.visit_id = rec.visit_id
LEFT JOIN
		(
			select	"row_number"() over(PARTITION by visit_id ORDER BY receipt_id desc) as rowid
							, visit_id
							, r2.receive_date
							, r2.receive_time
			from 		receipt r2 left join payer b on r2.payer_id = b.payer_id
							INNER JOIN base_plan_group c on b.base_plan_group_id = c.base_plan_group_id
			where 	r2.fix_receipt_type_id = '7'
							and r2.fix_receipt_status_id = '2'
							and c.group_type <> 'DISCOUNT'
		)rec2 on rec2.rowid = 1 and admit.visit_id = rec2.visit_id
WHERE  visit.financial_discharge_date BETWEEN '$P!{dBeginDate}' AND '$P!{dEndDate}'
AND CASE WHEN '$P!{cPlanGroup}' = 'all' THEN '1' ELSE plan.base_plan_group_id = '$P!{cPlanGroup}' END
AND CASE WHEN '$P!{bPlan}' = 'all' THEN '1' ELSE plan.plan_code = '$P!{bPlan}' END
AND admit.active = '1'
--admit.admit_id = '319020508512952501'
)waiting_time_dc
WHERE  CASE WHEN '$P!{cWard}' ='all'  THEN '1' ELSE  waiting_time_dc.ward_id = '$P!{cWard}' END