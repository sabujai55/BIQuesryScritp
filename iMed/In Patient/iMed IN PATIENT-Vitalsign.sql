select 'PLC' as "BU"
, a.patient_id as "PatientID"
, a.admit_id as "AdmitID"
, a.admit_date ||' '|| a.admit_time as "AdmitDateTime"
, format_an(a.an) as "AN"
, vsi.measure_spid as "LocationCode"
, bsp.description as "LocationNameTH"
, '' as "LocationNameEN"
, vsi.measure_eid as "EntryByUserCode"
, e.prename || e.firstname || ' ' || e.lastname as "EntryByUserNameTH"
, e.intername as "EntryByUserNameEN"
, vsi.measure_date ||' '|| vsi.measure_time as "EntryDateTime"
, coalesce((select vs1.weight from vital_sign_ipd vs1 where vs1.weight <> '' and a.admit_id = vs1.admit_id order by vital_sign_ipd_id desc limit 1),'') as "BodyWeight"
, coalesce((select vs2.height from vital_sign_ipd vs2 where vs2.height <> '' and a.admit_id = vs2.admit_id order by vital_sign_ipd_id desc limit 1),'') as "height"
, '' as "BMI"
, '' as "PostBpSystolic"
, '' as "PostBpDiastolic"
, coalesce((select vs6.pressure_max from vital_sign_ipd vs6 where vs6.pressure_max <> '' and a.admit_id = vs6.admit_id order by vital_sign_ipd_id desc limit 1),'') as "BpSystolic"
, coalesce((select vs7.pressure_min from vital_sign_ipd vs7 where vs7.pressure_min <> '' and a.admit_id = vs7.admit_id order by vital_sign_ipd_id desc limit 1),'') as "BpDiastolic"
, coalesce((select vs8.temperature from vital_sign_ipd vs8 where vs8.temperature <> '' and a.admit_id = vs8.admit_id order by vital_sign_ipd_id desc limit 1),'') as "Temperature"
, coalesce((select vs9.pulse from vital_sign_ipd vs9 where vs9.pulse <> '' and a.admit_id = vs9.admit_id order by vital_sign_ipd_id desc limit 1),'') as "PulseRate"
, coalesce((select vs10.respiration from vital_sign_ipd vs10 where vs10.respiration <> '' and a.admit_id = vs10.admit_id order by vital_sign_ipd_id desc limit 1),'') as "RespirationRate"
, '' as "PainScale"
, coalesce((select vs12.sat_o2 from vital_sign_ipd vs12 where vs12.sat_o2 <> '' and a.admit_id = vs12.admit_id order by vital_sign_ipd_id desc limit 1),'') as "O2Sat"
, '' as "Remark"
from admit a
left join vital_sign_ipd vsi on vsi.admit_id = a.admit_id 
left join employee e on e.employee_code = vsi.measure_eid 
left join base_service_point bsp on bsp.base_service_point_id = vsi.measure_spid
--where format_an(a.an) = 'I16-68-000370'



