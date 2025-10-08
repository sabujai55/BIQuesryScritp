

select 
'PLR' as "BU"
, p.patient_id as "PatientID"
, format_hn(v.hn) as "HN"
, v.visit_id as "VisitID"
, v.visit_date ||' '|| v.visit_time as "VisitDate"
, v.visit_date ||' '|| v.visit_time as "InDateTime"
, format_vn(v.vn) as "VN"
, '' as "PrescriptionNo"
, bd.base_department_id as "LocationCode"
, bd.description as "LocationNameTH"
, bd.description as "LocationNameEN"
, ap.employee_id as "DoctorCode"
, imed_get_employee_name(ap.employee_id) as "DoctorNameTH"
, imed_get_employee_name_en(ap.employee_id) as "DoctorNameEN"
, nd."CloseVisitCode" as "CloseVisitCode"
, nd."CloseVisitNameTH" as "CloseVisitNameTH"
, nd."CloseVisitNameEN" as "CloseVisitNameEN"
, a.appointment_id as "AppointmentNo"
, coalesce(vso.nurse_in_date ,nur.in_date) ||' '|| coalesce(vso.nurse_in_time ,nur.in_time) as "NurseAcknowledge"
, ap.begin_date ||' '|| ap.begin_time as "DiagRmsIn"
, ap.finish_date ||' '|| ap.finish_time as "DiagRmsOut"
, al.receive_specimen_date ||' '|| al.receive_specimen_time as "LabReceiveSpecimenDateTime"
, lab.approve_date ||' '|| lab.approve_time as "LabApproveDateTime"
, case when (lab.start_date <> '' and lab.finish_date <> '') and (lab.start_date is not null and lab.finish_date is not null)
	then  cal_date_time_diff_2((lab.start_date || ' ' || lab.start_time),(lab.finish_date || ' ' || lab.finish_time)) else NULL end as "TotalTimeLabReceiveSpecimenToLabApprove"
, xr.start_date ||' '|| xr.start_time as "XrayAcknowledgeDateTime"
, xr.finish_date ||' '|| xr.finish_time as "XrayResultReadyDateTime"
, case when (xr.start_date <> '' and xr.finish_date <> '') and (xr.start_date is not null and xr.finish_date is not null)
	then  cal_date_time_diff_2((xr.start_date || ' ' || xr.start_time),(xr.finish_date || ' ' || xr.finish_time)) else NULL end as "TotalTimeXrayAcknowledgeToXrayResultReady"
, drug.execute_date ||' '|| drug.execute_time as "DrugAcknowledgeDateTime"
, drug.dispense_date ||' '|| drug.dispense_time as "DrugReadyDateTime"
, r.receive_date ||' '|| r.receive_time as "CashierReceiveDateTime"
, drug.dispense_date ||' '|| drug.dispense_time as "DrugCheckoutDateTime"
, case when (drug.execute_date <> '' and drug.dispense_date <> '') and (drug.execute_date is not null and drug.dispense_date is not null)
	then  cal_date_time_diff_2((drug.execute_date || ' ' || drug.execute_time),(drug.dispense_date || ' ' || drug.dispense_time)) else NULL end as "TotalTimeDrugAcknowledgeToDrugCheckout"
, case when v.financial_discharge_date <> '' then
	cal_date_time_diff_2((v.visit_date || ' ' || v.visit_time),(v.financial_discharge_date || ' ' || v.financial_discharge_time))
	when  drug.dispense_date <> '' then
	cal_date_time_diff_2((v.visit_date || ' ' || v.visit_time),(drug.dispense_date || ' ' || drug.dispense_time))
	else null end as "TotalVisitTime"
from visit v 
left join patient p on p.patient_id = v.patient_id and p.active = '1'
left join attending_physician ap on v.visit_id = ap.visit_id
left join assign_lab al on al.visit_id = v.visit_id
left join receipt r on r.visit_id = v.visit_id and r.fix_receipt_type_id in ('1','6','7') and r.fix_receipt_status_id = '2'
left join base_department bd on ap.base_department_id = bd.base_department_id and bd.account_product = 'COST'
left join appointment a on a.visit_id = v.visit_id
left join 
		(
			select 	distinct 
					nd.visit_id 
					, nd.attending_physician_id 
					, fix_discharge_status as "CloseVisitCode"
					, vfds.description as "CloseVisitNameTH"
					, vfds.description as "CloseVisitNameEN"
			from 	nurse_discharge nd 
					left join v_fix_discharge_status vfds on nd.fix_discharge_status = vfds.v_fix_discharge_status_id 
			where 	nd.visit_id in (select v.visit_id from visit v where v.visit_date between '$P!{dBeginDate}' and '$P!{dEndDate}')
		)nd on ap.visit_id = nd.visit_id and ap.attending_physician_id = nd.attending_physician_id
left join  -- Nurse 2
		(
			select 	row_number() over(partition by vso.visit_id order by vso.measure_date || ' ' || vso.measure_time asc) rowid
					, vso.visit_id
					, vso.measure_date as nurse_in_date
					, vso.measure_time as nurse_in_time
			from 	vital_sign_opd vso
			where 	vso.visit_id in (select visit_id from visit where visit_date between '$P!{dBeginDate}' and '$P!{dEndDate}')
		)vso on v.visit_id = vso.visit_id and vso.rowid = 1
left join -- Nurse
		(
			select 	row_number() over(partition by vq.visit_id, vq.next_department_id order by vq.visit_queue_id asc) as rowid
					, vq.visit_id
					, vq.next_location_spid
					, vq.next_department_id as department_id
					, vq.next_location_date as in_date
					, vq.next_location_time as in_time
			from 	visit_queue vq inner join base_service_point bsp on vq.next_location_spid = bsp.base_service_point_id
			where 	vq.visit_id in (select visit_id from visit where visit_date between '$P!{dBeginDate}' and '$P!{dEndDate}')
					and bsp.fix_service_point_group_id in ('1','8')
		)nur on v.visit_id = nur.visit_id and ap.base_department_id = nur.department_id and nur.rowid = 1
left join  --Lab
		(
			select 	lr.visit_id
					, oi3.order_doctor_eid
					, min(lr.start_date) as start_date
					, min(lr.start_time) as start_time
					, min(lr.finish_date) as finish_date
					, min(lr.finish_time) as finish_time
					, min(lr.approve_date) as approve_date
					, min(lr.approve_time) as approve_time
			from 	lab_result lr inner join order_item oi3 on lr.order_item_id = oi3.order_item_id
			where 	lr.visit_id in (select visit_id from visit where 
			visit_date between '$P!{dBeginDate}' and '$P!{dEndDate}'
			--patient_id = '525010103025142901'
			)
			group by lr.visit_id, oi3.order_doctor_eid
		)lab on v.visit_id = lab.visit_id and ap.employee_id = lab.order_doctor_eid
left join -- Xray
		(
			select 	oi.visit_id
					, oi.order_doctor_eid
					, min(oi.assigned_date) as start_date
					, min(oi.assigned_time) as start_time
					, min(oi.dispense_date) as finish_date
					, min(oi.dispense_time) as finish_time
			from 	order_item oi
			where 	oi.visit_id in (select visit_id from visit where 
			visit_date between '$P!{dBeginDate}' and '$P!{dEndDate}'
			--patient_id = '525010103025142901'
			) and oi.fix_item_type_id = '2'
			group by oi.visit_id, oi.order_doctor_eid
		)xr on v.visit_id = xr.visit_id and ap.employee_id = xr.order_doctor_eid
left join -- Drug 
		(
			select 	p2.visit_id
					, oi2.order_doctor_eid
					, min(oi2.execute_date) as execute_date
					, min(oi2.execute_time) as execute_time
					, min(p2.approve_date) as approve_date
					, min(p2.approve_time) as approve_time
					, min(oi2.dispense_date) as dispense_date
					, min(oi2.dispense_time) as dispense_time
			from 	prescription p2 
			inner join order_item oi2 on p2.visit_id = oi2.visit_id and p2.pn = oi2.assigned_ref_no
			where 	p2.visit_id in (select visit_id from visit where 
			visit_date between '$P!{dBeginDate}' and '$P!{dEndDate}'
			--patient_id = '525010103025142901'
			)
			group by p2.visit_id , oi2.order_doctor_eid
		)drug on v.visit_id = drug.visit_id and ap.employee_id = drug.order_doctor_eid
where v.visit_date between '$P!{dBeginDate}' and '$P!{dEndDate}'
--and 
--p.patient_id = '525010103025142901'
group by
p.patient_id
, format_hn(v.hn)
, v.visit_id 
, v.visit_date ||' '|| v.visit_time 
, v.visit_date ||' '|| v.visit_time
, format_vn(v.vn) 
, format_an(v.an)
--, row_number() over(partition by ap.visit_id, ap.attending_physician_id order by ap.attending_physician_id asc
, bd.base_department_id 
, bd.description 
, bd.description 
, ap.employee_id 
, imed_get_employee_name(ap.employee_id) 
, imed_get_employee_name_en(ap.employee_id) 
, nd."CloseVisitCode"
, nd."CloseVisitNameTH"
, nd."CloseVisitNameEN"
, a.appointment_id
, coalesce(vso.nurse_in_date ,nur.in_date) ||' '|| coalesce(vso.nurse_in_time ,nur.in_time) 
, ap.begin_date ||' '|| ap.begin_time 
, ap.finish_date ||' '|| ap.finish_time 
, al.receive_specimen_date ||' '|| al.receive_specimen_time 
, lab.approve_date ||' '|| lab.approve_time 
, case when (lab.start_date <> '' and lab.finish_date <> '') and (lab.start_date is not null and lab.finish_date is not null)
	then  cal_date_time_diff_2((lab.start_date || ' ' || lab.start_time),(lab.finish_date || ' ' || lab.finish_time)) else NULL end 
, xr.start_date ||' '|| xr.start_time 
, xr.finish_date ||' '|| xr.finish_time 
, case when (xr.start_date <> '' and xr.finish_date <> '') and (xr.start_date is not null and xr.finish_date is not null)
	then  cal_date_time_diff_2((xr.start_date || ' ' || xr.start_time),(xr.finish_date || ' ' || xr.finish_time)) else NULL end 
, drug.execute_date ||' '|| drug.execute_time 
, drug.dispense_date ||' '|| drug.dispense_time 
, r.receive_date ||' '|| r.receive_time 
, drug.dispense_date ||' '|| drug.dispense_time 
, case when (drug.execute_date <> '' and drug.dispense_date <> '') and (drug.execute_date is not null and drug.dispense_date is not null)
	then  cal_date_time_diff_2((drug.execute_date || ' ' || drug.execute_time),(drug.dispense_date || ' ' || drug.dispense_time)) else NULL end 
, case when v.financial_discharge_date <> '' then
	cal_date_time_diff_2((v.visit_date || ' ' || v.visit_time),(v.financial_discharge_date || ' ' || v.financial_discharge_time))
	when  drug.dispense_date <> '' then
	cal_date_time_diff_2((v.visit_date || ' ' || v.visit_time),(drug.dispense_date || ' ' || drug.dispense_time))
	else null end

	
	
	
	
	
	
	
