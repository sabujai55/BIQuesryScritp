select 'PLD' as "BU"
, a.patient_id as "PatientID"
, a.admit_id as "AdmitID"
, a.admit_date ||' '||a.admit_time as "AdmitDateTime"
, format_an(a.an) as "AN"
, his_func_get_wardbed(a.admit_id,1) as "WardCode"
, his_func_get_wardbed(a.admit_id,2) as "WardNameTH"
, '' as "WardNameEN"
, a.base_department_id  as "WardDepartmentCode"
, bd.description as "WardDepartmentNameTH"
, bd.description as "WardDepartmentNameEN"
, a.admit_doctor_eid as "DoctorMasterCode"
, e.prename || e.firstname ||' '||e.lastname as "DoctorMasterNameTH"
, e.intername as "DoctorMasterNameEN"
, e.profession_code as "DoctorCertificate"
, bd3.base_department_id as "DoctorMasterClinicCode"
, bd3.description as "DoctorMasterClinicNameTH"
, '' as "DoctorMasterClinicNameEN"
, e.base_med_department_id as "DoctorMasterDepartmentCode"
, bmd.description as "DoctorMasterDepartmentNameTH"
, '' as "DoctorMasterDepartmentNameEN"
, e.base_clinic_id as "DoctorMasterSpecialtyCode"
, bmd.description as "DoctorMasterSpecialtyNameTH"
, '' as "DoctorMasterSpecialtyNameEN"
, ddi.fix_ipd_discharge_status_id as "DischargeCode"
, fids.description as "DischargeNameTH"
, '' as "DischargeNameEN"
, case when a.ipd_discharge = '0' then 'Active' else 'Inactive' end as "Status"
, a.times_admit as "AdmCount"
, '' as "AdmType"
, '' as "AdmTypeNameTH"
, '' as "AdmTypeNameEN"
, his_func_get_wardbed(a.admit_id,3) as "HNBedNo"
, '' as "HNBedNameTH"
, '' as "HNBedNameEN"
, his_func_get_wardbed(a.admit_id,1) as "ActiveWardCode"
, his_func_get_wardbed(a.admit_id,2) as "ActiveWardNameTH"
, '' as "ActiveWardNameEN"
, his_func_get_wardbed(a.admit_id,3) as "ActiveHNBedNo"
, '' as "ActiveHNBedNameTH"
, '' as "ActiveHNBedNameEN"
, a.doctor_allow_date ||' '|| a.doctor_allow_time as "DoctorDischargeDateTime"
, (select sts.stamp_date||' '||sts.stamp_time from service_time_stamp sts where sts.visit_id = a.visit_id and sts.fix_time_stamp_point_id = 'HOME_MED_APPROVE' limit 1) as "DrugTakeHomeDateTime"
, (select oi.verify_date||' '||oi.verify_time from order_item oi where oi.visit_id = a.visit_id order by oi.verify_date||' '||oi.verify_time desc limit 1) as "LastOrderDateTime"
, '' as "WardAllowDischargeDateTime"
, v.financial_discharge_date ||' '|| v.financial_discharge_time as "FinancialDateTime"
, a.ipd_discharge_date ||' '|| a.ipd_discharge_time as "WardDischargeDateTime"
--, CASE WHEN a.ipd_discharge_date != '' AND a.ipd_discharge_time != '' THEN a.ipd_discharge_date ||' '|| a.ipd_discharge_time WHEN ddi.discharge_date != '' and ddi.discharge_time != '' THEN ddi.discharge_date ||' '|| ddi.discharge_time ELSE '' end as "WardDischargeDateTime"
, ddi.fix_ipd_discharge_type_id as "DiagnosisStatusType"
, fidt.fix_ipd_discharge_type_name as "DiagnosisStatusName"
, vp.plan_code as "DefaultRightCode"
, p.description as "DefaultRightNameTH"
, p.description_en as "DefaultRightNameEN"
, '' as "ReAdmitCode"
, '' as "ReAdmitNameTH"
, '' as "ReAdmitNameEN"
, a.admit_spid as "AdmitLocationCode"
, bsp.description as "AdmitLocationNameTH"
, bsp.description as "AdmitLocationNameEN"
, v.base_office_agent_id as "AgencyCode"
, boa.description as "AgencyNameTH"
, '' as "AgencyNameEN"
from admit a 
left join doctor_discharge_ipd ddi on a.visit_id = ddi.visit_id 
left join fix_ipd_discharge_status fids on ddi.fix_ipd_discharge_status_id = fids.fix_ipd_discharge_status_id 
left join base_department bd on a.base_department_id = bd.base_department_id 
left join employee e on a.admit_doctor_eid = e.employee_id 
left join base_department bd2 on e.base_med_department_id = bd2.base_department_id 
left join visit_payment vp on vp.visit_id = a.visit_id and vp.priority = '1'
left join plan p on p.plan_id = vp.plan_id
left join base_service_point bsp on bsp.base_service_point_id = a.admit_spid
left join base_clinic bc on bc.base_clinic_id = e.base_clinic_id
left join base_department bmd on bmd.base_department_id = e.base_med_department_id
left join base_service_point bsp2 on e.base_service_point_id = bsp2.base_service_point_id 
left join base_department bd3 on bsp2.base_department_id = bd3.base_department_id 
left join visit v on v.visit_id = a.visit_id
left join base_office_agent boa on boa.base_office_agent_id = v.base_office_agent_id
left join fix_ipd_discharge_type fidt on fidt.fix_ipd_discharge_type_id = ddi.fix_ipd_discharge_type_id
--where a.admit_id = '125102010364524201'
--where a.admit_id = '125102018275550501'
--limit 1000








