select 'PLR' as "BU"
, p.patient_id as "PatientID"
, os.or_location_id as "FacilityRmsNo"
, or2.or_number as "RequestNo"
, '' as "EntryDateTime"
, '' as "ChargeDateTime"
, '1' as "SuffixSmall"
, '16' as "ChargeSuffix"
, i.item_code as "ItemCode"
, i.common_name as "ItemNameTH"
, '' as "ItemNameEN"
, oi.base_order_sub_category_id as "ActivityCode"
, bosc.description as "ActivityNameTH"
, '' as "ActivityNameEN"
--, bt.description as "ChargeType"
, oi.unit_price_sale as "UnitPrice"
, oi.quantity as "Qty"
, '' as "ChargeAmt"
, os.set_doctor_eid as "Doctor"
, imed_get_employee_name(os.set_doctor_eid) as "DoctorNameTH"
, oi.doctor_fee_eid as "DFDoctor"
, imed_get_employee_name(oi.doctor_fee_eid) as "DFDoctorNameTH"
, imed_get_employee_name_en(oi.doctor_fee_eid) as "DFDoctorNameEN"
, p2.plan_code as "RightCode"
, p2.description as "RightNameTH"
, '' as "RightNameEN"
, '' as "TreatmentDateTime"
, '' as "NoMinuteDuration"
, '' as "HNORPostByType"
, '' as "Usage"
, '' as "ChargeVisitDate"
, '' as "ChargeVN"
, '' as "PrescriptionNo"
, '' as "IPDChargeDateTime"
, '' as "ChargeAN"
, '' as "ChargeVoucherNo"
from op_registered or2 
left join op_set os on os.op_registered_id = or2.op_registered_id
left join patient p on p.patient_id = or2.patient_id
left join order_item oi on oi.visit_id = or2.visit_id 
left join item i on i.item_id = oi.item_id 
left join base_order_sub_category bosc on bosc.base_order_sub_category_id = oi.base_order_sub_category_id
left join visit_payment vp on vp.visit_id = or2.visit_id and vp.priority = '1'
left join plan p2 on p2.plan_id = oi.plan_id
left join employee e on e.employee_id = oi.doctor_fee_eid
--where or2.patient_id = 'R6006728'
and oi.verify_spid = 'OPRN001'
where or2.registered_date between '$P!{dBeginDate}' and '$P!{dEndDate}'

