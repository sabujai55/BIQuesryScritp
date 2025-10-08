select 'PLC' as "BU"
, v.patient_id as "PatientID"
, v.visit_id as "VisitID"
, v.visit_date as "VisitDate"
, format_vn(v.vn) as "VN"
, ROW_NUMBER() OVER (PARTITION BY v.visit_id ORDER BY (v.visit_id) ) as "Suffix"
, vso.measure_spid as "LocationCode"
, bsp.description as "LocationNameTH"
, '' as "LocationNameEN"
, vso.measure_eid as "EntryByUserCode"
, e.prename || e.firstname || ' ' || e.lastname as "EntryByUserNameTH"
, e.intername as "EntryByUserNameEN"
, vso.measure_date ||''|| vso.measure_time as "EntryDateTime"
, coalesce((select vs1.weight from vital_sign_opd vs1 where vs1.weight <> '' and v.visit_id = vs1.visit_id order by vital_sign_opd_id desc limit 1),'') as "BodyWeight"
, coalesce((select vs2.height from vital_sign_opd vs2 where vs2.height <> '' and v.visit_id = vs2.visit_id order by vital_sign_opd_id desc limit 1),'') as "height"
, coalesce((select vs3.bmi from vital_sign_opd vs3 where vs3.bmi <> '' and v.visit_id = vs3.visit_id order by vital_sign_opd_id desc limit 1),'') as "BMI"
, '' as "PostBpSystolic"
, '' as "PostBpDiastolic"
, coalesce((select vs6.pressure_max from vital_sign_opd vs6 where vs6.pressure_max <> '' and v.visit_id = vs6.visit_id order by vital_sign_opd_id desc limit 1),'') as "BpSystolic"
, coalesce((select vs7.pressure_min from vital_sign_opd vs7 where vs7.pressure_min <> '' and v.visit_id = vs7.visit_id order by vital_sign_opd_id desc limit 1),'') as "BpDiastolic"
, coalesce((select vs8.temperature from vital_sign_opd vs8 where vs8.temperature <> '' and v.visit_id = vs8.visit_id order by vital_sign_opd_id desc limit 1),'') as "Temperature"
, coalesce((select vs9.pulse from vital_sign_opd vs9 where vs9.pulse <> '' and v.visit_id = vs9.visit_id order by vital_sign_opd_id desc limit 1),'') as "PulseRate"
, coalesce((select vs10.respiration from vital_sign_opd vs10 where vs10.respiration <> '' and v.visit_id = vs10.visit_id order by vital_sign_opd_id desc limit 1),'') as "RespirationRate"
, coalesce((select vps.pain_score from vs_pain_score vps where v.visit_id = vps.visit_id order by vps.measure_date || vps.measure_time desc limit 1),'') as "PainScale"
, coalesce((select vs12.sat_o2 from vital_sign_opd vs12 where vs12.sat_o2 <> '' and v.visit_id = vs12.visit_id order by vital_sign_opd_id desc limit 1),'') as "O2Sat"
, '' as "Remark"
from visit v 
left join vital_sign_opd vso on vso.visit_id = v.visit_id 
left join employee e on e.employee_code = vso.measure_eid 
left join base_service_point bsp on bsp.base_service_point_id = vso.measure_spid
--where format_vn(v.vn) = 'O16-670704-0089'
--where format_vn(v.vn) = 'O16-670312-0171'