

select 'PLC' as "BU"
, v.patient_id as "PatientID"
, v.visit_id as "VisitID"
, v.visit_date as "VisitDate"
, format_vn(v.vn) as "VN"
, ROW_NUMBER() OVER (PARTITION BY v.visit_id ORDER BY (v.visit_id) ) as "Suffix"
, vso.measure_eid as "EntryByUserCode"
, e.prename || e.firstname || ' ' || e.lastname as "EntryByUserNameTH"
, e.intername as "EntryByUserNameEN"
, vso.measure_date ||' '|| vso.measure_time as "EntryDateTime"
, vso.weight as "BodyWeight"
, vso.height as "height"
--, ROUND(NULLIF(vso.bmi, '')::numeric, 2) AS "bmi"
, TO_CHAR(NULLIF(vso.bmi, '')::numeric, 'FM999999999.00') AS "bmi"
, '' as "PostBpSystolic"
, '' as "PostBpDiastolic"
, vso.pressure_max as "BpSystolic"
, vso.pressure_min as "BpDiastolic"
, vso.temperature as "Temperature"
, vso.pulse as "PulseRate"
, vso.respiration as "RespirationRate"
, vps.pain_score as "PainScale"
, vso.sat_o2 as "O2Sat"
, '' as "Remark"
from visit v 
left join vital_sign_opd vso on vso.visit_id = v.visit_id 
left join employee e on e.employee_id = vso.measure_eid 
left join vs_pain_score vps on vps.vital_sign_id = vso.vital_sign_opd_id
--where vso.visit_id = '525101600125405601'
--limit 100
--where v.visit_date between '$P!{dBeginDate}' and '$P!{dEndDate}'



