

select 
'PLR' as "BU"
, v.patient_id as "PatientID"
, '' as "FacilityRmsNo"
, '' as "RequestNo"
, '' as "PTModeSuffixSmall"
, '' as "PTModeCode"
, '' as "PTModeNameTH"
, '' as "PTModeNameEN"
, '' as "NoOfVisitTobeDone"
, oi.unit_price_sale as "UnitPrice"
, '' as "ChargeAmt"
, '' as "PaidFromChargeAmt"
, '' as "ChargeDateTime"
, '' as "ChargeType"
, '' as "PTSystemCode"
, '' as "PTSystemNameTH"
, '' as "PTSystemNameEN"
, '' as "OrganCode"
, '' as "OrganNameTH"
, '' as "OrganNameEN"
, '' as "OrganPosition"
, '' as "OrganPositionNameTH"
, '' as "OrganPositionNameEN"
, ap.employee_id as "PTTherapistCode"
, imed_get_employee_name(ap.employee_id) as "PTTherapistNameTH"
, imed_get_employee_name_en(ap.employee_id) as "PTTherapistNameEN"
, case when v.fix_visit_type_id = '0' then '0' else '1' end as "AtWard"
, '' as "MinutePerVisit"
, '' as "VoidDateTime"
, '' as "Remarks"
from visit v 
left join order_item oi on oi.visit_id = v.visit_id
left join attending_physician ap on ap.visit_id = v.visit_id and ap.base_department_id like '2701%' 
left join visit_queue vq on vq.visit_id = v.visit_id 
left join base_service_point bsp on bsp.base_service_point_id = vq.next_location_spid
where bsp.base_department_id like '2701%' 
AND v.active = '1'
and v.visit_date BETWEEN '$P!{dBeginDate}' AND '$P!{dEndDate}'
ORDER BY v.visit_date, v.hn









