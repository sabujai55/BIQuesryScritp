select 	bs.site_code 
		, v.patient_id as "PatientID"
		, v.visit_id as "VisitID"
		, v.visit_date as "VisitDate"
		, format_vn(v.vn) as "VN"
		, ap.attending_physician_id as "PrescriptionNo"
		, bd.base_department_id as "ClinicCode"
		, bd.description as "ClinicNameTH"
		, bd.description_en as "ClinicNameEN"
		, bd.base_department_id as "ClinicDepartmentCode"
		, bd.description as "ClinicDepartmentNameTH"
		, bd.description_en as "ClinicDepartmentNameEN" 
		, ap.employee_id as "DoctorCode"
		, e.prename || e.firstname || ' ' || e.lastname  as "DoctorNameTH"
		, e.intername  as "DoctorNameEN"
		, e.profession_code  as "DoctorCertificate"
		, bd2.base_department_id   as "DoctorClinicCode"
		, bd2.description  as "DoctorClinicNameTH"
		, bd2.description_en as "DoctorClinicNameEN"
		, bd2.base_department_id as "DoctorDepartmentCode"
		, bd2.description as "DoctorDepartmentNameTH"
		, bd2.description_en as "DoctorDepartmentNameEN"
		, e.base_clinic_id AS "DoctorSpecialtyCode"
		, bc.description AS "DoctorSpecialtyNameTH"
		, nd."CloseVisitCode" as "CloseVisitCode"
		, coalesce(nd."CloseVisitNameTH",v.financial_discharge_reason) as "CloseVisitNameTH"
		, nd."CloseVisitNameEN" as "CloseVisitNameEN"
		, a.appointment_id as "AppointmentNo"
		, a.appoint_datetime as "AppointmentDateTime"
		, case when v.active in ('1','2') then 'Active' else 'Inactive' end as "Status"
		, v.visit_date ||' '|| v.visit_time as "RegInDateTime"
		, vq."DiagRms"
		, vq."DiagRmsName"
		, v.new_patient  as "NEWPATIENT"
		, nd."CloseVisitDateTime"  as "CloseVisitDateTime"
		, v.visit_date ||' '|| v.visit_time as "PrescriptionMakeDateTime"
		, vp.plan_code as "DefaultRightCode"
		, p2.description as "DefaultRightNameTH"
		, p2.description as "DefaultRightNameEN"
		, v.base_patient_group_id as "PatientType"
		, bpg.description as "PatientTypeNameTH"
		, '' as "PatientTypeNameEN"
		, '' as "AccidentCode"
		, '' as "AccidentNameTH"
		, '' as "AccidentNameEN"
		, '' as "ComposeDept"
		, v.base_patient_type_id as "VisitCode"
		, bpt.description as "VisitNameTH"
		, '' as "VisitNameEN"
		, '' as "EntryByUserCode"
		, '' as "EntryByUserNameTH"
		, '' as "EntryByUserNameEN"
		, '' as "ReVisitCode"
		, '' as "ReVisitNameTH"
		, '' as "ReVisitNameEN"
		, format_an(v.an) as "AN"
		, case when v.new_patient  = '1' and nn.visit_id is null then 'NewNew'
		  when v.new_patient = '0' and nn.visit_id is null then 'OldNew'
		  when v.new_patient = '0' and nn.visit_id is not null then 'OldOld' end as "OldNew"
		, '' as "PrivateCase"
		, v.base_office_agent_id as "AgencyCode"
		, boa.description as "AgencyNameTH"
		, '' as "AgencyNameEN"
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
from 	visit v 
		inner join attending_physician ap on v.visit_id = ap.visit_id
		inner join base_department bd on ap.base_department_id = bd.base_department_id and bd.account_product = 'COST'
		inner join patient p on v.patient_id = p.patient_id 
		inner join visit_payment vp on v.visit_id = vp.visit_id and vp.priority = '1'
		inner join plan p2 on vp.plan_id = p2.plan_id 
		left join employee e on ap.employee_id = e.employee_id 
		left join base_department bd2 on e.base_med_department_id = bd2.base_department_id 
		left join base_clinic bc on e.base_clinic_id = bc.base_clinic_id 
		left join base_patient_group bpg on v.base_patient_group_id = bpg.base_patient_group_id 
		left join base_patient_type bpt on v.base_patient_type_id = bpt.base_patient_type_id 
		left join base_office_agent boa on v.base_office_agent_id = boa.base_office_agent_id
		left join lateral
		(
			select 	string_agg(appoint_date||' '||appoint_time,',') as appoint_datetime
					, string_agg(appointment_id,',') as  appointment_id
			from 	appointment a 
			where 	a.visit_id = v.visit_id
		)a on true
		left join lateral 
		(
			select  fix_discharge_status as "CloseVisitCode"
					, vfds.description as "CloseVisitNameTH"
					, vfds.description as "CloseVisitNameEN"
					, nd.assess_date ||' '|| nd.assess_time as "CloseVisitDateTime"
			from 	nurse_discharge nd 
					inner join v_fix_discharge_status vfds on nd.fix_discharge_status = vfds.v_fix_discharge_status_id 
			where 	nd.visit_id = ap.visit_id 
					and nd.attending_physician_id = ap.attending_physician_id 
			order by nd.assess_date ||' '|| nd.assess_time desc 
			limit 1
		)nd on true
		left join lateral
		(
			select 	vq.next_location_spid as "DiagRms"
					, bsp.description as "DiagRmsName"
			from 	visit_queue vq 
					inner join base_service_point bsp on vq.next_location_spid = bsp.base_service_point_id and bsp.fix_service_point_group_id = '2'
			where 	vq.visit_id = ap.visit_id 
					and vq.next_department_id = ap.base_department_id
					and vq.next_operate_eid = ap.employee_id
			order by vq.visit_queue_id asc
			limit 1
		)vq on true
		left join lateral 
		(
			select 	vq.visit_id 
					, vq.next_department_id 
			from 	visit_queue vq 
			where 	vq.patient_id = v.patient_id 
					and vq.next_department_id = ap.base_department_id 
					and vq.visit_id < v.visit_id
			order by vq.visit_queue_id desc 
			limit 1
		)nn on true 
		left join lateral
		(
			select 	vso.measure_date as nurse_in_date
					, vso.measure_time as nurse_in_time
			from 	vital_sign_opd vso
			where 	vso.visit_id = v.visit_id
			order by vso.measure_date || ' ' || vso.measure_time asc 
			limit 1
		)vso on true
		left join lateral
		(
			select 	vq.next_location_date as in_date
					, vq.next_location_time as in_time
			from 	visit_queue vq 
					inner join base_service_point bsp on vq.next_location_spid = bsp.base_service_point_id
			where 	vq.visit_id = v.visit_id
					and bsp.base_department_id = ap.base_department_id
					and bsp.fix_service_point_group_id in ('1','8')
			order by vq.visit_queue_id asc 
			limit 1
		)nur on true
		left join lateral
		(
			select 	min(lr.start_date) as start_date
					, min(lr.start_time) as start_time
					, min(lr.finish_date) as finish_date
					, min(lr.finish_time) as finish_time
					, min(lr.approve_date) as approve_date
					, min(lr.approve_time) as approve_time
			from 	lab_result lr 
					inner join order_item oi3 on lr.order_item_id = oi3.order_item_id
			where 	lr.visit_id = ap.visit_id 
					and oi3.order_doctor_eid = ap.employee_id 
		)lab on true
		left join lateral 
		(
			select 	al.receive_specimen_date
					, al.receive_specimen_time
			from 	assign_lab al
			where 	al.visit_id = v.visit_id
			order by al.receive_specimen_date || al.receive_specimen_time asc 
			limit 1
		)al on true
		left join lateral
		(
			select 	min(ax.assign_date) as start_date
					, min(ax.assign_time) as start_time
					, min(ax.complete_date) as finish_date
					, min(ax.complete_time) as finish_time
			from 	assign_xray ax 
					inner join xray_result xr on ax.assign_xray_id = xr.assign_xray_id 
					inner join order_item oi on xr.visit_id = oi.visit_id and xr.order_item_id = oi.order_item_id 
			where 	ax.visit_id = ap.visit_id
					and oi.order_doctor_eid = ap.employee_id 
		)xr on true
		left join lateral
		(
			select 	min(oi2.execute_date) as execute_date
					, min(oi2.execute_time) as execute_time
					, min(oi2.dispense_date) as dispense_date
					, min(oi2.dispense_time) as dispense_time
			from 	order_item oi2 
			where 	oi2.visit_id = v.visit_id
					and oi2.order_doctor_eid = ap.employee_id
		)drug on true
		left join lateral 
		(
			select 	r.receive_date
					, r.receive_time
			from 	receipt r
			where 	r.visit_id = v.visit_id 
					and r.fix_receipt_type_id in ('1','6','7')
					and r.fix_receipt_status_id = '2'
			order by r.receive_date || r.receive_time asc
			limit 1
		)r on true
		, base_site bs 
where 	1=1 
		and v.visit_date = (current_date - 1)::text
--		(current_date -1)::text