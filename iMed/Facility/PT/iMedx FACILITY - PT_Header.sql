
select 
'PLC' as "BU" 
, v.patient_id as "PatientID"
, '' as "FacilityRmsNo"
, '' as "RequestNo"
, '' as "EntryDateTime"
, ap.employee_id as "RequestDoctor"
, imed_get_employee_name(ap.employee_id) as "RequestDoctorNameTH"
, imed_get_employee_name_en(ap.employee_id) as "RequestDoctorNameEN"
, '' as "HNAlready"
, ap.employee_id as "PTTherapistCode"
, imed_get_employee_name(ap.employee_id) as "PTTherapistNameTH"
, imed_get_employee_name_en(ap.employee_id) as "PTTherapistNameEN"
, '' as "CaseCloseCode"
, '' as "CaseCloseNameTH"
, '' as "CaseCloseNameEN"
, '' as "CaseCloseDateTime"
, vp.base_plan_group_id as "PatientType"
, bpg.description as "PatientTypeNameTH"
, bpg.description as "PatientTypeNameEN"
, '' as "LastAttendDateTime"
, '' as "LastChargeDateTime"
, '' as "RequestByUserCode"
, '' as "RequestByUserNameTH"
, '' as "RequestByUserNameEN"
, p.plan_code as "RightCode"
, p.description as "RightNameTH"
, p.description as "RightNameEN"
, '' as "AppointmentNo"
, a.appoint_date ||' '|| a.appoint_time as "AppointmentDateTime"
, bsp.base_service_point_id as "Clinic"
, bsp.description as "ClinicNameTH"
, bsp.description as "ClinicNameEN"
, bm.base_service_point_id as "Ward"
, bsp2.description as "WardNameTH"
, bsp2.description as "WardNameEN"
, '' as "Remarks"
from visit v
left join visit_queue vq on vq.visit_id = v.visit_id 
left join base_service_point bsp on bsp.base_service_point_id = vq.next_location_spid
left join attending_physician ap on ap.visit_id = v.visit_id and ap.base_department_id like '2701%'
left join visit_payment vp on vp.visit_id = v.visit_id
left join base_plan_group bpg on bpg.base_plan_group_id = vp.base_plan_group_id
left join plan p on p.plan_id = vp.plan_id
left join appointment a on a.make_appointment_visit_id = v.visit_id
left join admit a2 on a2.visit_id = v.visit_id
left join bed_management bm on bm.admit_id = a2.admit_id
left join base_service_point bsp2 on bsp2.base_service_point_id = bm.base_service_point_id
WHERE bsp.base_department_id like '2701%' 
AND v.active = '1'
and v.visit_date BETWEEN '$P!{dBeginDate}' AND '$P!{dEndDate}'
ORDER BY v.visit_date, v.hn


