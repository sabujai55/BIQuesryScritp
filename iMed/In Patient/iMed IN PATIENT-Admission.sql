


select 'PLD' as "BU"
,a.patient_id as "PatientID"
,a.admit_id as "AdmitID"
,a.admit_date ||' '||a.admit_time as "AdmitDateTime"
,'' as "AdmitCode"
,a.patient_relate_note as "AdmitName"
,format_an(a.an) as "AN"
,a.base_department_id as "WardCode"
,bd.description as "WardNameTH"
,bd.description as "WardNameEN"
,a.admit_doctor_eid as "DoctorCode"
,e.prename || e.firstname ||' '||e.lastname as "DoctorNameTH"
,e.intername as "DoctorNameEN"
,e.profession_code as "DoctorCertificate"
,a.base_department_id  as "WardDepartmentCode"
,bd.description as "WardDepartmentNameTH"
,bd.description as "WardDepartmentNameEN"
,ddi.fix_ipd_discharge_status_id as "DischargeCode"
,fids.description as "DischargeNameTH"
,'' as "DischargeNameEN"
,case when a.ipd_discharge = '0' then 'Active' else 'Inactive' end as "Status"
,'' as "AdmCount"
,'' as "AdmType"
,'' as "AdmTypeNameTH"
,'' as "AdmTypeNameEN"
,bm.room_number as "HNBedNo"
,bm.bed_number as "HNBedNameTH"
,'' as "HNBedNameEN"
,'' as "WardAllowDischargeDateTime"
,a.base_department_id as "ActiveWardCode"
,bd.description as "ActiveWardNameTH"
,bd.description as "ActiveWardNameEN"
,bm.bed_number as "ActiveHNBedNo"
,'' as "ActiveHNBedNameTH"
,'' as "ActiveHNBedNameEN"
,CASE WHEN a.ipd_discharge_date != '' AND a.ipd_discharge_time != '' THEN a.ipd_discharge_date ||' '|| a.ipd_discharge_time WHEN ddi.discharge_date != '' and ddi.discharge_time != '' THEN ddi.discharge_date ||' '|| ddi.discharge_time ELSE '' end as "DischargeDateTime"
,'' as "DiagnosisStatusType"
,'' as "DiagnosisStatusName"
,vp.plan_code as "DefaultRightCode"
,p.description as "DefaultRightNameTH"
,'' as "DefaultRightNameEN"
,'' as "ReAdmitCode"
,'' as "ReAdmitNameTH"
,'' as "ReAdmitNameEN"
,a.admit_spid as "AdmitLocationCode"
,bsp.description as "AdmitLocationNameTH"
,bsp.description as "AdmitLocationNameEN"
from admit a 
left join doctor_discharge_ipd ddi on a.visit_id = ddi.visit_id 
left join fix_ipd_discharge_status fids on ddi.fix_ipd_discharge_status_id = fids.fix_ipd_discharge_status_id 
left join base_department bd on a.base_department_id = bd.base_department_id 
left join employee e on a.admit_doctor_eid = e.employee_code 
left join base_department bd2 on e.base_med_department_id = bd2.base_department_id 
left join bed_management bm on bm.admit_id = a.admit_id and bm.current_bed = '1'
left join visit_payment vp on vp.visit_id = a.visit_id and vp.priority = '1'
left join plan p on p.plan_id = vp.plan_id
left join base_service_point bsp on bsp.base_service_point_id = a.admit_spid
--where format_an(a.an) = 'I16-68-000699'
order by a.admit_date desc
limit 10


