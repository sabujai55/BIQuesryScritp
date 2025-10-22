select 'PLC' as "BU"
, a.patient_id as "PatientID"
, a.admit_id as "AdmitID"
, a.admit_date ||' '|| a.admit_time as "AdmitDateTime"
, format_an(a.an) as "AN"
, vsi.measure_eid as "EntryByUserCode"
, e.prename || e.firstname || ' ' || e.lastname as "EntryByUserNameTH"
, e.intername as "EntryByUserNameEN"
, vsi.measure_date ||' '|| vsi.measure_time as "EntryDateTime"
, vsi.weight as "BodyWeight"
, vsi.height as "height"
, '' as "BMI"
, CASE WHEN LENGTH(vsi.weight) = 4 AND vsi.weight ~ '^[0-9]+$' AND vsi.weight != '' AND vsi.height IS NOT NULL AND vsi.height != '' 
  THEN TO_CHAR((vsi.weight::numeric / 1000.0) / POWER((vsi.height::numeric / 100.0), 2), 'FM9999990.00') ELSE null END AS "BMI"
, '' as "PostBpSystolic"
, '' as "PostBpDiastolic"
, vsi.pressure_max as "BpSystolic"
, vsi.pressure_min as "BpDiastolic"
, vsi.temperature as "Temperature"
, vsi.pulse as "PulseRate"
, vsi.respiration as "RespirationRate"
, vps.pain_score as "PainScale"
, vsi.sat_o2 as "O2Sat"
, '' as "Remark"
from admit a
left join vital_sign_ipd vsi on vsi.admit_id = a.admit_id 
left join employee e on e.employee_id = vsi.measure_eid 
left join base_service_point bsp on bsp.base_service_point_id = vsi.measure_spid
left join vs_pain_score vps on vps.vital_sign_id = vsi.vital_sign_ipd_id
--where format_an(a.an) = 'I16-68-000370'
--where vsi.weight like '____%' and vsi.height != '' and a.admit_date between '$P!{dBeginDate}' and '$P!{dEndDate}'
--WHERE LENGTH(vsi.weight) = 4 AND vsi.weight ~ '^[0-9]+$';
--where a.admit_id = '520101909441191701'
--limit 100



