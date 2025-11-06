select 'PLR' as "BU"
, p.patient_id as "PatientID"
, os.or_location_id as "FacilityRmsNo"
, or2.or_number as "RequestNo"
, '1' as "SuffixTiny"
, case when orp.base_op_role_id = 'SG' then 'Surgeon' else bor.description end as "HNORPersonType"
, orp.employee_id as "Doctor"
, e3.prename || e3.firstname ||' '|| e3.lastname as "DoctorNameTH"
, e3.intername as "DoctorNameEN"
, e3.profession_code as "DoctorCertificate"
, bd3.base_department_id as "DoctorClinicCode"
, bd3.description as "DoctorClinicNameTH"
, '' as "DoctorClinicNameEN"
, e3.base_med_department_id as "DoctorDepartmentCode"
, bmd.description as "DoctorDepartmentNameTH"
, '' as "DoctorDepartmentNameEN"
, e3.base_clinic_id as "DoctorSpecialtyCode"
, bmd.description as "DoctorSpecialtyNameTH"
, '' as "DoctorSpecialtyNameEN"  
, os.modify_eid as "NurseCode"
, e2.prename || e2.firstname ||' '|| e2.lastname as "NurseNameTH"
, e2.intername as "NurseNameEN"
, os.note as "Remarks"
from op_registered or2 
left join patient p on p.patient_id = or2.patient_id
left join op_set os on os.op_registered_id = or2.op_registered_id 
left join employee e on e.employee_id = os.set_doctor_eid 
left join employee e2 on e2.employee_id = os.modify_eid
--
left join op_registered_physician orp on orp.op_registered_id = or2.op_registered_id
left join base_op_role bor on bor.base_op_role_id = orp.base_op_role_id
left join employee e3 on e3.employee_id = orp.employee_id
--
left join base_clinic bc on bc.base_clinic_id = e3.base_clinic_id
left join base_department bmd on bmd.base_department_id = e3.base_med_department_id
left join base_service_point bsp on e3.base_service_point_id = bsp.base_service_point_id 
left join base_department bd3 on bsp.base_department_id = bd3.base_department_id 
where or2.registered_date between '$P!{dBeginDate}' and '$P!{dEndDate}'
--and or2.patient_id = '522062509300446401'
--where or2.op_registered_id = '520092812554081401'





