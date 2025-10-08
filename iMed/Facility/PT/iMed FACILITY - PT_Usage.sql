
select
'PLR' as "BU"
, oi.patient_id as "PatientID"
, '' as "FacilityRmsNo"
, '' as "RequestNo"
, '1' as "SuffixTiny"
, '' as "EntryDateTime"
, '' as "Store"
, '' as "StoreNameTH"
, '' as "StoreNameEN"
, i.item_code as "StockCode"
, i.common_name as "StockNameTH"
, i.common_name_en as "StockNameEN"
, oi.base_unit_id as "UnitCode"
, bu.description_th as "UnitNameTH"
, bu.description_en as "UnitNameEN"
, '' as "ReverseDrugControl"
, oi.quantity as "Qty"
, oi.unit_price_sale as "UnitPrice"
, '' as "Cost"
, '' as "ChargeAmt"
, p.plan_code as "RightCode"
, p.description as "RightNameTH"
, p.description_en as "RightNameEN"
, i.base_order_sub_category_id as "HNActivityCode"
, bosc.description as "HNActivityNameTH"
, bosc.description as "HNActivityNameEN"
, oi.verify_date ||' '|| oi.verify_time as "ChargeDateTime"
, '' as "ChargeType"
, case when v.fix_visit_type_id = '0' then 'OPD' else 'IPD' end as "IpdOpdType"
, '' as "EntryByUserCode"
, '' as "EntryByUserNameTH"
, '' as "EntryByUserNameEN"
, '' as "RemarksMemo"
, '' as "ComputerLocation"
, '' as "ImportParStock"
from order_item oi 
left join visit v on v.visit_id = oi.visit_id 
left join item i on i.item_id = oi.item_id
left join visit_payment vp on vp.visit_id = v.visit_id 
left join plan p on p.plan_id = vp.plan_id
left join base_unit bu on bu.base_unit_id = oi.base_unit_id
left join base_order_sub_category bosc on bosc.base_order_sub_category_id = i.base_order_sub_category_id
left join visit_queue vq on vq.visit_id = v.visit_id 
left join base_service_point bsp on bsp.base_service_point_id = vq.next_location_spid
WHERE bsp.base_department_id like '2701%' 
AND v.active = '1'
and v.visit_date BETWEEN '$P!{dBeginDate}' AND '$P!{dEndDate}'
ORDER BY v.visit_date, v.hn


