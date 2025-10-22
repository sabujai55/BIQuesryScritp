--PLR
select
'PLR' as "BU"
, v.patient_id as "PatientID"
, v.visit_id as "VisitID"
, v.visit_date ||' '|| v.visit_time as "VisitDate"
, format_vn(v.vn) as "VN"
, '1' as "PrescriptionNo"
--เพิ่ม
, bd.base_department_id  as "ClinicCode"
, bd.description as "ClinicNameTH"
, '' as "ClinicNameEN"
, e.base_med_department_id as "ClinicDepartmentCode"
, bmd.description as "ClinicDepartmentNameTH"
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
--
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
--
left join base_clinic bc on bc.base_clinic_id = e.base_clinic_id
left join base_department bmd on bmd.base_department_id = e.base_med_department_id
left join base_service_point bsp on e.base_service_point_id = bsp.base_service_point_id 
left join base_department bd3 on bsp.base_department_id = bd3.base_department_id 
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
, '1' as "PrescriptionNo"
--เพิ่ม
, bd.base_department_id  as "ClinicCode"
, bd.description as "ClinicNameTH"
, '' as "ClinicNameEN"
, e.base_med_department_id as "ClinicDepartmentCode"
, bmd.description as "ClinicDepartmentNameTH"
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
--
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
--
left join base_clinic bc on bc.base_clinic_id = e.base_clinic_id
left join base_department bmd on bmd.base_department_id = e.base_med_department_id
left join base_service_point bsp on e.base_service_point_id = bsp.base_service_point_id 
left join base_department bd3 on bsp.base_department_id = bd3.base_department_id 
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
, '1' as "PrescriptionNo"
--เพิ่ม
, bd.base_department_id  as "ClinicCode"
, bd.description as "ClinicNameTH"
, '' as "ClinicNameEN"
, e.base_med_department_id as "ClinicDepartmentCode"
, bmd.description as "ClinicDepartmentNameTH"
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
--
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
--
left join base_clinic bc on bc.base_clinic_id = e.base_clinic_id
left join base_department bmd on bmd.base_department_id = e.base_med_department_id
left join base_service_point bsp on e.base_service_point_id = bsp.base_service_point_id 
left join base_department bd3 on bsp.base_department_id = bd3.base_department_id 
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
, '1' as "PrescriptionNo"
--เพิ่ม
, bd.base_department_id  as "ClinicCode"
, bd.description as "ClinicNameTH"
, '' as "ClinicNameEN"
, e.base_med_department_id as "ClinicDepartmentCode"
, bmd.description as "ClinicDepartmentNameTH"
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
--
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
--
left join base_clinic bc on bc.base_clinic_id = e.base_clinic_id
left join base_department bmd on bmd.base_department_id = e.base_med_department_id
left join base_service_point bsp on e.base_service_point_id = bsp.base_service_point_id 
left join base_department bd3 on bsp.base_department_id = bd3.base_department_id 
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
