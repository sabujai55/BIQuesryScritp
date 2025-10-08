select 'PLR' as "BU"
, p.patient_id as "PatientID"
, os.or_location_id as "FacilityRmsNo"
, or2.or_number as "RequestNo"
, '1' as "SuffixTiny"
, '' as "HNORPersonType"
, os.set_doctor_eid as "Doctor"
, e.prename || e.firstname ||' '|| e.lastname as "DoctorNameTH"
, e.intername as "DoctorNameEN"
, os.modify_eid as "NurseCode"
, e2.prename || e2.firstname ||' '|| e2.lastname as "NurseNameTH"
, e2.intername as "NurseNameEN"
, os.note as "Remarks"
from op_registered or2 
left join patient p on p.patient_id = or2.patient_id
left join op_set os on os.op_registered_id = or2.op_registered_id 
left join employee e on e.employee_id = os.set_doctor_eid 
left join employee e2 on e2.employee_id = os.modify_eid
where or2.registered_date between '$P!{dBeginDate}' and '$P!{dEndDate}'
--where or2.op_registered_id = '520092812554081401'



