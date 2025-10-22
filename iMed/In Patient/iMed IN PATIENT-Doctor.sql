select 'PLR' as "BU"
, a.visit_id 
, a.patient_id as "PatientID"
, a.admit_id as "AdmitID" 
, format_an(a.an) as "AN"
, to_char(a.admit_date ::timestamp,'dd/mm/yyyy')|| ' ' || substring(a.admit_time,0,6) as "MakeDateTime"
, iap.employee_id as "DoctorCode"
, imed_get_employee_name(iap.employee_id) as "DoctorNameTH"
, imed_get_employee_name_en(iap.employee_id) as "DoctorNameEN"	  
, e.profession_code as "DoctorCertificate"
, bd3.base_department_id as "DoctorClinicCode"
, bd3.description as "DoctorClinicNameTH"
, '' as "DoctorClinicNameEN"
, e.base_med_department_id as "DoctorDepartmentCode"
, bmd.description as "DoctorDepartmentNameTH"
, '' as "DoctorDepartmentNameEN"
, e.base_clinic_id as "DoctorSpecialtyCode"
, '' as "DoctorSpecialtyNameTH"
, bmd.description as "DoctorSpecialtyNameEN"  
, '' as "PrivateCase"
, e.doctor_type as "DoctorType"
, case when e.doctor_type ='1' then 'Part Time' 
	when e.doctor_type ='0' then 'Full Time'
  	else 'NULL' end as "DoctorTypeName"
, case when a.admit_doctor_eid = iap.employee_id then '1' else '0' end as "AdmitDoctor"
, case when iap.employee_id = ddi.discharge_doctor_eid then '1' else '0' end as "DischargeDoctor"
, '' as "RemarksMemo"
from admit a  
inner join ipd_attending_physician iap on a.admit_id = iap.admit_id 
--and iap.priority ='1'
left join doctor_discharge_ipd ddi on ddi.visit_id = a.visit_id
left join employee e on iap.employee_id = e.employee_id
--
left join base_clinic bc on bc.base_clinic_id = e.base_clinic_id
left join base_department bmd on bmd.base_department_id = e.base_med_department_id
left join base_service_point bsp on e.base_service_point_id = bsp.base_service_point_id 
left join base_department bd3 on bsp.base_department_id = bd3.base_department_id 
--where a.visit_id ='125030408553347001'
--where a.visit_id = '124031403191395101'
--where a.visit_id = '125060100402713801'
ORDER BY a.admit_id desc
limit 100






