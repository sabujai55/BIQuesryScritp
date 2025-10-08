

select 'PLC' as "BU"
, v.patient_id as "PatientID"
, '' as "FacilityRmsNo"
, '' as "RequestNo"
, oi.verify_date ||' '|| oi.verify_time as "ChargeDateTime"
, '1' as "SuffixTiny"
, i.item_code as "ItemCode"
, i.common_name as "ItemNameTH"
, i.common_name as "ItemNameEN"
, oi.base_order_sub_category_id as "ActivityCode"
, bosc.description as "ActivityNameTH"
, bosc.description as "ActivityNameEN"
, v.base_tariff_id as "ChargeType"
, oi.unit_price_sale as "UnitPrice"
, oi.quantity as "Qty"
, '' as "ChargeAmt"
, case when oi.fix_item_type_id = '7' then oi.verify_date ||' '|| oi.verify_time else '' end as "TreatmentDateTime"
, iap.employee_id as "Doctor"
, imed_get_employee_name(iap.employee_id) as "DoctorNameTH"
, imed_get_employee_name_en(iap.employee_id) as "DoctorNameEN"
, oi.doctor_fee_eid as "DFDoctor"
, imed_get_employee_name(oi.doctor_fee_eid) as "DFDoctorNameTH"
, imed_get_employee_name_en(oi.doctor_fee_eid) as "DFDoctorNameEN"
, p.plan_code as "RightCode"
, p.description as "RightNameTH"
, p.description as "RightNameEN"
, 'Y' as "Usage"
, v.visit_date ||' '|| v.visit_time as "ChargeVisitDate"
, format_vn(v.vn) as "ChargeVN"
, '1' as "PrescriptionNo"
, '' as "IPDChargeDateTime"
, format_vn(v.an) as "ChargeAN"
, '' as "ChargeVoucherNo"
from order_item oi 
left join visit v on oi.visit_id = v.visit_id
left join admit a on a.visit_id = oi.visit_id 
left join item i on i.item_id = oi.item_id
left join plan p on p.plan_id = oi.plan_id
left join base_order_sub_category bosc on bosc.base_order_sub_category_id = oi.base_order_sub_category_id
left join ipd_attending_physician iap on iap.admit_id = a.admit_id and iap.priority = '1'
--where oi.patient_id = '523122414144852401'
where oi.verify_spid = '150101'
and oi.verify_date BETWEEN '$P!{dBeginDate}' AND '$P!{dEndDate}'
--and oi.patient_id = '124050615221958801'
--limit 10


