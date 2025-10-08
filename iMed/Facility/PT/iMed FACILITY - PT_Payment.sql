

select 
'PLR' as "BU" 
, v.patient_id as "PatientID"
, '' as "FacilityRmsNo"
, '' as "RequestNo"
, '' as "PTModeCode"
, '' as "PTModeNameTH"
, '' as "PTModeNameEN"
, '' as "HNActivityCode"
, '' as "HNActivityNameTH"
, '' as "HNActivityNameEN"
, v.visit_date ||' '|| v.visit_time as "ChargeDateTime"
, v.visit_date ||' '|| v.visit_time as "ChargeVisitDate"
, '' as "IRNo"
, format_vn(v.vn) as "ChargeVN"
, format_an(v.an) as "ChargeAN"
, p.plan_code as "RightCode"
, p.description as "RightNameTH"
, p.description as "RightNameEN"
, '' as "ChargeAmt"
, '' as "ChargeType"
, '' as "EntryByUserCode"
, '' as "EntryByUserNameTH"
, '' as "EntryByUserNameEN"
, '' as "VoidByUserCode"
, '' as "VoidByUserNameTH"
, '' as "VoidByUserNameEN"
, '' as "VoidDateTime"
, '' as "VoidRemarks"
, '' as "ChargeVoucherNo"
, '' as "Remarks"
from visit v
left join visit_queue vq on vq.visit_id = v.visit_id 
left join base_service_point bsp on bsp.base_service_point_id = vq.next_location_spid
left join visit_payment vp on vp.visit_id = v.visit_id
left join plan p on p.plan_id = vp.plan_id
WHERE bsp.base_department_id like '2701%' 
AND v.active = '1'
and v.visit_date BETWEEN '$P!{dBeginDate}' AND '$P!{dEndDate}'
ORDER BY v.visit_date, v.hn



