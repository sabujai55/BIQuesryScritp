--PLR
select
'PLR' as "BU"
, v.patient_id as "PatientID"
, v.visit_id as "VisitID"
, v.visit_date ||' '|| v.visit_time as "VisitDate"
, format_vn(v.vn) as "VN"
, '' as "PrescriptionNo"
, bd.base_department_id as "LocationCode"
, bd.description as "LocationNameTH"
, bd.description as "LocationNameEN"
, ap.employee_id as "DoctorCode"
, imed_get_employee_name(ap.employee_id) as "DoctorNameTH"
, imed_get_employee_name_en(ap.employee_id) as "DoctorNameEN"
, e.profession_code as "DoctorCertificate"
, e.base_med_department_id as "ClinicDepartmentCode"
, bd.description as "ClinicDepartmentNameTH"
, bd.description as "ClinicDepartmentNameEN"
, nd."CloseVisitCode" as "CloseVisitCode"
, nd."CloseVisitNameTH" as "CloseVisitNameTH"
, nd."CloseVisitNameEN" as "CloseVisitNameEN"
, '' as "AppointmentNo"
, case when v.active in ('1','2') then 'Active' else 'Inactive' end as "Status"
, v.visit_date ||' '|| v.visit_time as "RegInDateTime"
, bd.base_department_id as "DiagRms"
, bd.description as "DiagRmsName"
, p.fix_new_in_year_id as "NEWPATIENT"
, ''  as "CloseVisitDateTime"
, v.visit_date ||' '|| v.visit_time as "MakeDateTime"
, vp.plan_code as "DefaultRightCode"
, p2.description as "DefaultRightNameTH"
, p2.description as "DefaultRightNameEN"
, '' as "AccidentCode"
, '' as "AccidentNameTH"
, '' as "AccidentNameEN"
, '' as "ComposeDept"
, v.base_patient_group_id as "VisitCode"
, bpg.description as "VisitNameTH"
, bpg.description as "VisitNameEN"
, '' as "EntryByUserCode"
, '' as "EntryByUserNameTH"
, '' as "EntryByUserNameEN"
, '' as "ReVisitCode"
, '' as "ReVisitNameTH"
, '' as "ReVisitNameEN"
from visit v 
left join patient p on p.patient_id = v.patient_id
left join attending_physician ap on ap.visit_id = v.visit_id
left join base_department bd on bd.base_department_id = ap.base_department_id --and bd.base_department_id = '1018'
left join employee e on e.employee_id = ap.employee_id
left join visit_payment vp on vp.visit_id = v.visit_id and vp.priority = '1'
left join plan p2 on p2.plan_id = vp.plan_id
left join employee e2 on e2.employee_id = v.visit_eid
left join base_patient_group bpg on bpg.base_patient_group_id = v.base_patient_group_id
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
where 	v.visit_date between '$P!{dBeginDate}' and '$P!{dEndDate}'
		and v.active = '1'
		and v.visit_id in
		(
			select 	distinct
					vq.visit_id
			from 	visit_queue vq
					join base_service_point bsp on vq.next_location_spid = bsp.base_service_point_id
			where 	bsp.base_department_id = '1018'
		)--order by v.visit_date asc
union all
--PLD
select
'PLD' as "BU"
, v.patient_id as "PatientID"
, v.visit_id as "VisitID"
, v.visit_date ||' '|| v.visit_time as "VisitDate"
, format_vn(v.vn) as "VN"
, '' as "PrescriptionNo"
, bd.base_department_id as "LocationCode"
, bd.description as "LocationNameTH"
, bd.description as "LocationNameEN"
, ap.employee_id as "DoctorCode"
, imed_get_employee_name(ap.employee_id) as "DoctorNameTH"
, imed_get_employee_name_en(ap.employee_id) as "DoctorNameEN"
, e.profession_code as "DoctorCertificate"
, e.base_med_department_id as "ClinicDepartmentCode"
, bd.description as "ClinicDepartmentNameTH"
, bd.description as "ClinicDepartmentNameEN"
, nd."CloseVisitCode" as "CloseVisitCode"
, nd."CloseVisitNameTH" as "CloseVisitNameTH"
, nd."CloseVisitNameEN" as "CloseVisitNameEN"
, '' as "AppointmentNo"
, case when v.active in ('1','2') then 'Active' else 'Inactive' end as "Status"
, v.visit_date ||' '|| v.visit_time as "RegInDateTime"
, bd.base_department_id as "DiagRms"
, bd.description as "DiagRmsName"
, p.fix_new_in_year_id as "NEWPATIENT"
, ''  as "CloseVisitDateTime"
, v.visit_date ||' '|| v.visit_time as "MakeDateTime"
, vp.plan_code as "DefaultRightCode"
, p2.description as "DefaultRightNameTH"
, p2.description as "DefaultRightNameEN"
, '' as "AccidentCode"
, '' as "AccidentNameTH"
, '' as "AccidentNameEN"
, '' as "ComposeDept"
, v.base_patient_group_id as "VisitCode"
, bpg.description as "VisitNameTH"
, bpg.description as "VisitNameEN"
, '' as "EntryByUserCode"
, '' as "EntryByUserNameTH"
, '' as "EntryByUserNameEN"
, '' as "ReVisitCode"
, '' as "ReVisitNameTH"
, '' as "ReVisitNameEN"
from visit v 
left join patient p on p.patient_id = v.patient_id
left join attending_physician ap on ap.visit_id = v.visit_id
left join base_department bd on bd.base_department_id = ap.base_department_id --and bd.base_department_id = '1018'
left join employee e on e.employee_id = ap.employee_id
left join visit_payment vp on vp.visit_id = v.visit_id and vp.priority = '1'
left join plan p2 on p2.plan_id = vp.plan_id
left join employee e2 on e2.employee_id = v.visit_eid
left join base_patient_group bpg on bpg.base_patient_group_id = v.base_patient_group_id
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
where 	v.visit_date between '$P!{dBeginDate}' and '$P!{dEndDate}'
		and v.active = '1'
		and v.visit_id in
		(
			select 	distinct
					vq.visit_id
			from 	visit_queue vq
					join base_service_point bsp on vq.next_location_spid = bsp.base_service_point_id
			where 	bsp.description like '%Tele' limit 3
		)--order by v.visit_date asc
union all
--PLC
select
'PLC' as "BU"
, v.patient_id as "PatientID"
, v.visit_id as "VisitID"
, v.visit_date ||' '|| v.visit_time as "VisitDate"
, format_vn(v.vn) as "VN"
, '' as "PrescriptionNo"
, bd.base_department_id as "LocationCode"
, bd.description_th as "LocationNameTH"
, bd.description_en as "LocationNameEN"
--, bd.description as "LocationNameTH"
--, bd.description as "LocationNameEN"
, ap.employee_id as "DoctorCode"
, imed_get_employee_name(ap.employee_id) as "DoctorNameTH"
, imed_get_employee_name_en(ap.employee_id) as "DoctorNameEN"
, e.profession_code as "DoctorCertificate"
, e.base_med_department_id as "ClinicDepartmentCode"
, bd.description_th as "ClinicDepartmentNameTH"
, bd.description_en as "ClinicDepartmentNameEN"
, nd."CloseVisitCode" as "CloseVisitCode"
, nd."CloseVisitNameTH" as "CloseVisitNameTH"
, nd."CloseVisitNameEN" as "CloseVisitNameEN"
, '' as "AppointmentNo"
, case when v.active in ('1','2') then 'Active' else 'Inactive' end as "Status"
, v.visit_date ||' '|| v.visit_time as "RegInDateTime"
, bd.base_department_id as "DiagRms"
, bd.description_th as "DiagRmsName"
, p.fix_new_in_year_id as "NEWPATIENT"
, ''  as "CloseVisitDateTime"
, v.visit_date ||' '|| v.visit_time as "MakeDateTime"
, vp.plan_code as "DefaultRightCode"
, p2.description as "DefaultRightNameTH"
, p2.description as "DefaultRightNameEN"
, '' as "AccidentCode"
, '' as "AccidentNameTH"
, '' as "AccidentNameEN"
, '' as "ComposeDept"
, v.base_patient_group_id as "VisitCode"
, bpg.description as "VisitNameTH"
, bpg.description as "VisitNameEN"
, '' as "EntryByUserCode"
, '' as "EntryByUserNameTH"
, '' as "EntryByUserNameEN"
, '' as "ReVisitCode"
, '' as "ReVisitNameTH"
, '' as "ReVisitNameEN"
from visit v 
left join patient p on p.patient_id = v.patient_id
left join attending_physician ap on ap.visit_id = v.visit_id
left join base_department bd on bd.base_department_id = ap.base_department_id --and bd.base_department_id = '1018'
left join employee e on e.employee_id = ap.employee_id
left join visit_payment vp on vp.visit_id = v.visit_id and vp.priority = '1'
left join plan p2 on p2.plan_id = vp.plan_id
left join employee e2 on e2.employee_id = v.visit_eid
left join base_patient_group bpg on bpg.base_patient_group_id = v.base_patient_group_id
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
where 	v.visit_date between '$P!{dBeginDate}' and '$P!{dEndDate}'
		and v.active = '1'
		and v.visit_id in
		(
			select 	distinct
					vq.visit_id
			from 	visit_queue vq
					join base_service_point bsp on vq.next_location_spid = bsp.base_service_point_id
			where 	bsp.description like '%Tele%' limit 3
		)--order by v.visit_date asc
union all
--PLK
select
'PLK' as "BU"
, v.patient_id as "PatientID"
, v.visit_id as "VisitID"
, v.visit_date ||' '|| v.visit_time as "VisitDate"
, format_vn(v.vn) as "VN"
, '' as "PrescriptionNo"
, bd.base_department_id as "LocationCode"
, bd.description_th as  "LocationNameTH"
, bd.description_en as "LocationNameEN"
, ap.employee_id as "DoctorCode"
, imed_get_employee_name(ap.employee_id) as "DoctorNameTH"
, imed_get_employee_name_en(ap.employee_id) as "DoctorNameEN"
, e.profession_code as "DoctorCertificate"
, e.base_med_department_id as "ClinicDepartmentCode"
, bd.description_th as "ClinicDepartmentNameTH"
, bd.description_en as "ClinicDepartmentNameEN"
, nd."CloseVisitCode" as "CloseVisitCode"
, nd."CloseVisitNameTH" as "CloseVisitNameTH"
, nd."CloseVisitNameEN" as "CloseVisitNameEN"
, '' as "AppointmentNo"
, case when v.active in ('1','2') then 'Active' else 'Inactive' end as "Status"
, v.visit_date ||' '|| v.visit_time as "RegInDateTime"
, bd.base_department_id as "DiagRms"
, bd.description_th as "DiagRmsName"
, p.fix_new_in_year_id as "NEWPATIENT"
, ''  as "CloseVisitDateTime"
, v.visit_date ||' '|| v.visit_time as "MakeDateTime"
, vp.plan_code as "DefaultRightCode"
, p2.description as "DefaultRightNameTH"
, p2.description as "DefaultRightNameEN"
, '' as "AccidentCode"
, '' as "AccidentNameTH"
, '' as "AccidentNameEN"
, '' as "ComposeDept"
, v.base_patient_group_id as "VisitCode"
, bpg.description as "VisitNameTH"
, bpg.description as "VisitNameEN"
, '' as "EntryByUserCode"
, '' as "EntryByUserNameTH"
, '' as "EntryByUserNameEN"
, '' as "ReVisitCode"
, '' as "ReVisitNameTH"
, '' as "ReVisitNameEN"
from visit v 
left join patient p on p.patient_id = v.patient_id
left join attending_physician ap on ap.visit_id = v.visit_id
left join base_department bd on bd.base_department_id = ap.base_department_id --and bd.base_department_id = '1018'
left join employee e on e.employee_id = ap.employee_id
left join visit_payment vp on vp.visit_id = v.visit_id and vp.priority = '1'
left join plan p2 on p2.plan_id = vp.plan_id
left join employee e2 on e2.employee_id = v.visit_eid
left join base_patient_group bpg on bpg.base_patient_group_id = v.base_patient_group_id
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
where 	v.visit_date between '$P!{dBeginDate}' and '$P!{dEndDate}' and v.active = '1' and v.visit_id in
		(
			select 	distinct
					vq.visit_id
			from 	visit_queue vq
					join base_service_point bsp on vq.next_location_spid = bsp.base_service_point_id
			where 	bsp.description like '%Tele%' limit 3
		)--order by v.visit_date asc
