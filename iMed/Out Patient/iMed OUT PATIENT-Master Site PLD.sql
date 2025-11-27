select
'PLR' as "BU"
, v.patient_id  as "PatientID"
, v.visit_id  as "VisitID"
, v.visit_date  as "VisitDate"
, format_vn(v.vn) as "VN"
, '1' as "PrescriptionNo"
, bd.base_department_id  as "ClinicCode"
, bd.description as "ClinicNameTH"
, '' as "ClinicNameEN"
, e.base_med_department_id as "ClinicDepartmentCode"
, bd2.description as "ClinicDepartmentNameTH"
, '' as "ClinicDepartmentNameEN" 
, ap.employee_id  as "DoctorCode"
, e.prename || e.firstname || ' ' || e.lastname  as "DoctorNameTH"
, e.intername  as "DoctorNameEN"
, e.profession_code  as "DoctorCertificate"
, bd3.base_department_id  AS "DoctorClinicCode"
, bd3.description AS "DoctorClinicNameTH"
, '' AS "DoctorClinicNameEN"
, e.base_med_department_id AS "DoctorDepartmentCode"
, bmd.description AS "DoctorDepartmentNameTH"
, '' AS "DoctorDepartmentNameEN"
, e.base_clinic_id AS "DoctorSpecialtyCode"
, bmd.description AS "DoctorSpecialtyNameTH"
, '' AS "DoctorSpecialtyNameEN"
, nd."CloseVisitCode" as "CloseVisitCode"
, nd."CloseVisitNameTH" as "CloseVisitNameTH"
, nd."CloseVisitNameEN" as "CloseVisitNameEN"
, a.appointment_id as "AppointmentNo"
, a.appoint_datetime as "AppointmentDateTime"
, case when v.active in ('1','2') then 'Active' else 'Inactive' end as "Status"
, v.visit_date ||' '|| v.visit_time as "RegInDateTime"
, his_func_get_diagrms(v.visit_id, ap.employee_id,1) as "DiagRms"
, his_func_get_diagrms(v.visit_id, ap.employee_id,2) as "DiagRmsName"
, p.fix_new_in_year_id as "NEWPATIENT"
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
, case when v.new_patient  = '1' and his_func_get_lastvisitid(v.patient_id, ap.base_department_id, v.visit_id) is null then 'NewNew'
	when v.new_patient = '0' and his_func_get_lastvisitid(v.patient_id, ap.base_department_id, v.visit_id) is null then 'OldNew'
	when v.new_patient = '0' and his_func_get_lastvisitid(v.patient_id, ap.base_department_id, v.visit_id) is not null then 'OldOld' end as "OldNew"
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
		from visit v 
		INNER join attending_physician ap on v.visit_id = ap.visit_id and ap.priority = '1' --<< สำหรับ PLD
		INNER join base_department bd on ap.base_department_id = bd.base_department_id 
		left join employee e on ap.employee_id = e.employee_id 
		left join patient p on p.patient_id = v.patient_id 
		left join visit_payment vp on vp.visit_id = v.visit_id and vp.priority = '1'
		left join plan p2 on p2.plan_code = vp.plan_code
		left join employee e2 on e2.employee_code = v.visit_eid 
		left join base_department bd2 on bd2.base_department_id = e.base_med_department_id 
		left join base_patient_type bpt on bpt.base_patient_type_id = v.base_patient_type_id 
		left join base_patient_group bpg on bpg.base_patient_group_id = v.base_patient_group_id 
		left join (select row_number() over(partition by al.visit_id order by al.receive_specimen_date || ' ' || al.receive_specimen_time asc) rowid
					, al.visit_id
					, al.receive_specimen_date
					, al.receive_specimen_time
						from assign_lab al ) al on al.visit_id = v.visit_id and al.rowid = 1
		left join (select string_agg(appoint_date||' '||appoint_time,',') as appoint_datetime
					, string_agg(appointment_id,',') as  appointment_id
					, a.visit_id
					, a.base_department_id
						from appointment a
						group by a.visit_id , a.base_department_id) a on a.visit_id = ap.visit_id and a.base_department_id=ap.base_department_id 
		left join (select row_number() over(partition by r.visit_id order by r.receive_date || ' ' || r.receive_time asc) rowid
					, r.visit_id
					, r.receive_date
					, r.receive_time
							from receipt r  ) r on r.visit_id = v.visit_id and r.rowid = 1
		left join base_patient_unit bpu on bpu.base_patient_unit_id = p.base_patient_unit_id
		left join base_office_agent boa on boa.base_office_agent_id = v.base_office_agent_id
		left join base_clinic bc on bc.base_clinic_id = e.base_clinic_id
		left join base_department bmd on bmd.base_department_id = e.base_med_department_id
		left join base_service_point bsp on e.base_service_point_id = bsp.base_service_point_id 
		left join base_department bd3 on bsp.base_department_id = bd3.base_department_id 
		left join  -- NurseAcknowledge 2
				(
					select  
							nd.visit_id 
							, nd.attending_physician_id 
							, fix_discharge_status as "CloseVisitCode"
							, vfds.description as "CloseVisitNameTH"
							, vfds.description as "CloseVisitNameEN"
							, nd.assess_date ||' '|| nd.assess_time as "CloseVisitDateTime"
					from 	nurse_discharge nd 
							left join v_fix_discharge_status vfds on nd.fix_discharge_status = vfds.v_fix_discharge_status_id 
					where 	nd.visit_id in (select v.visit_id from visit v where v.visit_date between '$P!{dBeginDate}' and '$P!{dEndDate}'
					order by nd.assess_date desc
					limit 1)
				)nd on ap.visit_id = nd.visit_id and ap.attending_physician_id = nd.attending_physician_id
		left join  -- NurseAcknowledge
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
					)
					group by p2.visit_id , oi2.order_doctor_eid
				)drug on v.visit_id = drug.visit_id and ap.employee_id = drug.order_doctor_eid
where v.visit_date between '$P!{dBeginDate}' and '$P!{dEndDate}'

