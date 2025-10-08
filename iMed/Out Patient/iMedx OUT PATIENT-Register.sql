select
'PLC' as "BU"
,v.patient_id  as "PatientID"
,v.visit_id  as "VisitID"
,v.visit_date  as "VisitDate"
,format_vn(v.vn) as "VN"
,'1' as "PrescriptionNo"
,bd.base_department_id  as "LocationCode"
,bd.description_th as "LocationNameTH"
,bd.description_en as "LocationNameEN"
,ap.employee_id  as "DoctorCode"
,e.prename || e.firstname || ' ' || e.lastname  as "DoctorNameTH"
,e.intername  as "DoctorNameEN"
,e.profession_code  as "DoctorCertificate"
,e.base_med_department_id as "ClinicDepartmentCode"
,bd2.description_th as "ClinicDepartmentNameTH"
,bd2.description_en as "ClinicDepartmentNameEN"
,nd.fix_discharge_status  as "CloseVisitCode"
,vfds.description  as "CloseVisitNameTH"
,'' as "CloseVisitNameEN"
,'' as "AppointmentNo"
, case when v.active in ('1','2') then 'Active' else 'Inactive' end as "Status"
,v.visit_date ||' '|| v.visit_time as "RegInDateTime"
,bd.base_department_id as "DiagRms"
,bd.description_th  as "DiagRmsName"
,p.fix_new_in_year_id as "NEWPATIENT"
,nd.assess_date ||' '|| nd.assess_time  as "CloseVisitDateTime"
,v.visit_date ||' '|| v.visit_time as "MakeDateTime"
,vp.plan_code as "DefaultRightCode"
,p2.description as "DefaultRightNameTH"
,p2.description as "DefaultRightNameEN"
,'' as "AccidentCode"
,'' as "AccidentName"
,'' as "ComposeDept"
,v.base_patient_group_id as "VisitCode"
,bpg.description as "VisitNameTH"
,'' as "VisitNameEN"
,'' as "EntryByUserCode"
,'' as "EntryByUserNameTH"
,'' as "EntryByUserNameEN"
,'' as "ReVisitCode"
,'' as "ReVisitNameTH"
,'' as "ReVisitNameEN"
,case when v.active = '1' then 'Active' else 'InActive' end as "Status"
		from visit v 
		INNER join attending_physician ap on v.visit_id = ap.visit_id --and ap.priority = '1'
		INNER join base_department bd on ap.base_department_id = bd.base_department_id and bd.account_product = 'COST' 
		left join employee e on ap.employee_id = e.employee_id 
		left join nurse_discharge nd on v.visit_id = nd.visit_id
		left join v_fix_discharge_status vfds on nd.fix_discharge_status = vfds.v_fix_discharge_status_id 
		left join patient p on p.patient_id = v.patient_id 
		left join visit_payment vp on vp.visit_id = v.visit_id and vp.priority = '1'
		left join plan p2 on p2.plan_code = vp.plan_code 
		left join employee e2 on e2.employee_code = v.visit_eid 
		left join base_department bd2 on bd2.base_department_id = e.base_med_department_id 
		left join base_patient_group bpg on bpg.base_patient_group_id = v.base_patient_group_id
		