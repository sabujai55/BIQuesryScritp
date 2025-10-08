select 'PLC' as "BU"
, p.patient_id as "PatientID"
, format_hn(p.hn) as "HN"
, a.appointment_id as "AppointmentNo"
, a.appoint_date ||' '|| a.appoint_time as "AppointmentDateTime"
, a.doctor_eid as "DoctorCode"
, e.prename || e.firstname ||' '|| e.lastname as "DoctorNameTH"
, e.intername as "DoctorNameEN"
, e.profession_code as "DoctorCertificate"
, a.base_department_id as "LocationCode"
, bd.description_th as "LocationNameTH"
, bd.description_en as "LocationNameEN"
, '' as "AppointmentTimeType"
, CASE
            WHEN a.estimate_hour::text = ''::text THEN '0'::character varying
            ELSE a.estimate_hour
        END::interval * 3600::double precision +
        CASE
            WHEN a.estimate_minute::text = ''::text THEN '0'::character varying
            ELSE a.estimate_minute
        END::interval * 60::double precision AS "NoMinuteDuration"
, a.modify_date ||' '||a.modify_time as "EntryDateTime"
, '' as "RightCode"
, '' as "RightNameTH"
, '' as "RightNameEN"
, '' as "AppointmentProcedureCode1"
, a.basic_advice as "AppointmentProcedureName1"
, '' as "AppointmentProcedureCode2"
, '' as "AppointmentProcedureName2"
, '' as "AppointmentProcedureCode3"
, '' as "AppointmentProcedureName3"
, '' as "AppointmentProcedureCode4"
, '' as "AppointmentProcedureName4"
, '' as "AppointmentProcedureCode5"
, '' as "AppointmentProcedureName5"
, e2.employee_code as "EntryByUserCode"
, e2.prename || e2.firstname ||' '|| e2.lastname as "EntryByUserNameTH"
, e2.intername as "EntryByUserNameEN"
, p.mobile as "MobilePhoneNo"
, p.telephone as "Telephone"
from patient p 
left join appointment a on a.patient_id = p.patient_id 
left join employee e on e.employee_code = a.doctor_eid 
left join base_department bd on bd.base_department_id = a.base_department_id
left join employee e2 on a.modify_eid = e2.employee_code 
--where format_hn(p.hn) = '16-67-002105'




