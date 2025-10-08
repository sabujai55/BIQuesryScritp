











select 
'PLC' as "BU"
, p.patient_id as "PatientID"
, format_hn(p.hn) as "HN"
, '' as "MessageType"
, pm.message as "Message"
, pm.message_date ||' '|| pm.message_time as "EntryDateTime"
, pm.message_eid as "EntryByUserCode"
, e.prename||e.firstname||' '||e.lastname as "EntryByUserNameTH"
, e.intername as "EntryByUserNameEN"
, case when pm.active = '1' then 'active'
  else 'inactive' end as "Status"
, pm.message_date ||' '|| pm.message_time as "EffectiveDateTimeForm"
, '' as "EffectiveDateTimeTo"
from patient p 
left join patient_message pm on pm.patient_id = p.patient_id
left join employee e on e.employee_id = pm.message_eid
--limit 10