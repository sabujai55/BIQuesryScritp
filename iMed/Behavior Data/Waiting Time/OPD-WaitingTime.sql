select 	'PLD' as "BU"
		, v.patient_id as "PatientID"
		, format_hn(v.hn) as "HN"
		, v.visit_id as "VisitID"
		, v.visit_date as "VisitDate"
		, v.visit_date || ' ' || v.visit_time as "InDateTime"
		, format_vn(v.vn) as "VN"
		, row_number() over(partition by ap.visit_id, ap.attending_physician_id order by ap.attending_physician_id asc) as "PrescriptionNo"
		, ap.base_department_id as "LocationCode"
		, bd.description as "LocationNameTH"
		, bd.description as "LocationNameEN"
		, ap.employee_id as "DoctorCode"
		, e.prename || e.firstname || ' ' || e.lastname as "DoctorNameTH"
		, e.intername as "DoctorNameEN"
		, nd."CloseVisitCode"
		, nd."CloseVisitNameTH"
		, nd."CloseVisitNameEN"
		, a.appointment_id as "AppointmentNo"
		, coalesce(vso.nurse_in_date || ' ' || vso.nurse_in_time ,nur.in_date || ' ' || nur.in_time) as "NurseAcknowledge"
		, ap.begin_date || ' ' || ap.begin_time as "DiagRmsIn"
		, ap.finish_date || ' ' || ap.finish_time as "DiagRmsOut"
		, lab."LabReceiveSpecimenDateTime"
		, lab."LabApproveDateTime"
		, case when (lab."LabReceiveSpecimenDateTime" <> ' ' and lab."LabApproveDateTime" <> ' ') and (lab."LabReceiveSpecimenDateTime" is not null and lab."LabApproveDateTime" is not null)
		  then  cal_date_time_diff_2((lab."LabReceiveSpecimenDateTime"),(lab."LabApproveDateTime"))
		  else NULL end as "TotalTimeLabReceiveSpecimenToLabApprove"
		, xr."XrayAcknowledgeDateTime"
		, xr."XrayResultReadyDateTime"
		, case when (xr."XrayAcknowledgeDateTime" <> ' ' and xr."XrayResultReadyDateTime" <> ' ') and (xr."XrayAcknowledgeDateTime" is not null and xr."XrayResultReadyDateTime" is not null)
		  then  cal_date_time_diff_2((xr."XrayAcknowledgeDateTime"),(xr."XrayResultReadyDateTime"))
		  else NULL end as "TotalTimeXrayAcknowledgeToXrayResultReady"
		, drug.execute_date || ' ' || drug.execute_time  as "DrugAcknowledgeDateTime"
		, drug.approve_date || ' ' || drug.approve_time  as "DrugReadyDateTime"
		, v.financial_discharge_date || ' ' || v.financial_discharge_time as "CashierReceiveDateTime"
		, drug.dispense_date || ' ' || drug.dispense_time as "DrugCheckoutDateTime"
		, case when (drug.execute_date <> '' and drug.dispense_date <> '') and (drug.execute_date is not null and drug.dispense_date is not null)
		  then  cal_date_time_diff_2((drug.execute_date || ' ' || drug.execute_time),(drug.dispense_date || ' ' || drug.dispense_time))
		  else NULL end as "TotalTimeDrugAcknowledgeToDrugCheckout"
		, case when v.financial_discharge_date <> '' then
		   cal_date_time_diff_2((v.visit_date || ' ' || v.visit_time),(v.financial_discharge_date || ' ' || v.financial_discharge_time))
		  when  drug.dispense_date <> '' then
		  cal_date_time_diff_2((v.visit_date || ' ' || v.visit_time),(drug.dispense_date || ' ' || drug.dispense_time))
		  else null
		  end  as "TotalVisitTime"
from 	visit v inner join patient p on  v.patient_id = p.patient_id
		left join base_patient_group bpg on v.base_patient_group_id = bpg.base_patient_group_id
		inner join attending_physician ap on v.visit_id = ap.visit_id
		left join employee e on ap.employee_id = e.employee_id 
		left join visit_payment ON v.visit_id = visit_payment.visit_id AND visit_payment.priority = '1'
		left join plan ON visit_payment.plan_id = plan.plan_id
		left join base_plan_group ON plan.base_plan_group_id = base_plan_group.base_plan_group_id
		left join diagnosis_icd10 di on ap.visit_id = di.visit_id and di.fix_diagnosis_type_id = '1'
		inner join base_department bd on ap.base_department_id = bd.base_department_id and bd.account_product = 'COST'
		left join appointment a on v.visit_id = a.visit_id 
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
		left join  -- Nurse Time2
		(
			select 	row_number() over(partition by vso.visit_id order by vso.measure_date || ' ' || vso.measure_time asc) rowid
					, vso.visit_id
					, vso.measure_date as nurse_in_date
					, vso.measure_time as nurse_in_time
			from 	vital_sign_opd vso
			where 	vso.visit_id in (select visit_id from visit where visit_date between '$P!{dBeginDate}' and '$P!{dEndDate}')
		)vso on v.visit_id = vso.visit_id and vso.rowid = 1
		left join -- Nurse Time
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
		left join 
		(
			select 	row_number() over(partition by al.visit_id, al.assign_doctor_eid order by al.assign_lab_id asc) as rowid
					, al.visit_id 
					, al.assign_doctor_eid 
					, al.receive_specimen_date || ' ' || al.receive_specimen_time as "LabReceiveSpecimenDateTime"
					, al.complete_date || ' ' || al.complete_time as "LabApproveDateTime"
			from 	assign_lab al 
			where 	al.visit_id in (select v.visit_id from visit v where v.visit_date between '$P!{dBeginDate}' and '$P!{dEndDate}') 
		)lab on ap.visit_id = lab.visit_id and ap.employee_id = lab.assign_doctor_eid and lab.rowid = 1
		left join 
		(
			select 	row_number() over(partition by ax.visit_id, ax.assign_doctor_eid order by ax.assign_xray_id asc) as rowid
					, ax.visit_id 
					, ax.assign_doctor_eid 
					, ax.complete_execute_date || ' ' || ax.complete_execute_time as "XrayAcknowledgeDateTime"
					, ax.complete_date || ' ' || ax.complete_time as "XrayResultReadyDateTime"
			from 	assign_xray ax 
			where 	ax.visit_id in (select v.visit_id from visit v where v.visit_date between '$P!{dBeginDate}' and '$P!{dEndDate}')
		)xr on ap.visit_id = xr.visit_id and ap.employee_id = xr.assign_doctor_eid and xr.rowid = 1
		left join -- Drug Time
		(
			select 	p2.visit_id
					, oi2.order_doctor_eid
					, min(oi2.execute_date) as execute_date
					, min(oi2.execute_time) as execute_time
					, min(p2.approve_date) as approve_date
					, min(p2.approve_time) as approve_time
					, min(oi2.dispense_date) as dispense_date
					, min(oi2.dispense_time) as dispense_time
			from 	prescription p2 inner join order_item oi2 on p2.visit_id = oi2.visit_id and p2.pn = oi2.assigned_ref_no
			where 	p2.visit_id in (select visit_id from visit where visit_date between '$P!{dBeginDate}' and '$P!{dEndDate}')
					and p2.pn like 'O%'
			group by p2.visit_id , oi2.order_doctor_eid
		)drug on v.visit_id = drug.visit_id and ap.employee_id = drug.order_doctor_eid
		left join -- Receipt Time
		(
			select 	r2.visit_id
					, min(r2.receive_date) as receive_date
					, min(r2.receive_time) as receive_time
			from 	receipt r2
			where 	r2.visit_id in (select visit_id from visit where visit_date between '$P!{dBeginDate}' and '$P!{dEndDate}')
					and r2.fix_receipt_type_id in ('1','6','7')
					and r2.fix_receipt_status_id = '2'
			group by r2.visit_id
		)rec on v.visit_id = rec.visit_id
where 	v.visit_date between '$P!{dBeginDate}' and '$P!{dEndDate}'
		and v.active = '1'