
select 'PLR' as "BU"
, p.patient_id as "PatientID"
, os.or_location_id as "FacilityRmsNo"
, or2.or_number as "RequestNo"
, v.visit_date ||' '||v.visit_time as "VisitDateTime"
, '' as "HNORVisitLocation"
, '' as "HNORVisitType"
, '' as "ORAnesType"
, '' as "NurseCode"
, '' as "NurseNameTH"
, '' as "NurseNameEN"
, os.set_doctor_eid as "Doctor"
, e.prename || e.firstname ||' '|| e.lastname as "RequestDoctorNameTH"
, e.intername as "RequestDoctorNameEN"
from op_registered or2 
left join visit v on v.visit_id = or2.visit_id 
left join patient p on p.patient_id = or2.patient_id
left join op_set os on os.op_registered_id = or2.op_registered_id 
left join employee e on e.employee_id = os.set_doctor_eid 
left join employee e2 on e2.employee_id = os.modify_eid
where or2.registered_date between '$P!{dBeginDate}' and '$P!{dEndDate}'
and v.fix_visit_type_id = '0'
--where or2.op_registered_id = '520092812554081401'






