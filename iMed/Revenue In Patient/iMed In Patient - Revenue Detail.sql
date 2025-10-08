



    select 	rec_h."BU"
		, rec_h."PatientID"
		, rec_h."AdmitID"
		, rec_h."AdmitDateTime"
		, rec_h."AN"
		, rec_h."InvoiceNo"
		, rec_h."InvoiceSuffixSmall"
		, '' as "HNReceiptFormCode"
		, row_number() over(partition by rec_h.receipt_id order by rro.receipt_revenue_order_id) as "SuffixSmall"
		, '' as ChangeMedicineSuffixSmall
		, oi.verify_date || ' ' || oi.verify_time as "MakeDateTime"
		, '' as "ReceiveFormLineNo"
		, oi.base_order_sub_category_id as "HNActivityCode"
		, i.item_code as "ItemCode"
		, i.common_name as "ItemName"
		, oi.unit_price_sale::float as "UnitPrice"
		, oi.quantity as "Qty"
		, (oi.unit_price_sale::float * oi.quantity::float) as "ChargeAmt"
		, rro.paid::float as "FromChargeAmt"
		, rro.discount::float as "DiscountAmt"
		, bbg.billing_head as BillingGroupId
		, bbgh.description_th as "BillingGroupLocalName"
		, bbgh.description_en as "BillingGroupEnglishName"
		, bbg.billing_sub_head as "BillingSubGroupId"
		, bbg.description_th as "BillingSubGroupLocalName"
		, bbg.description_en as "BillingSubGroupEnglishName"
		, '' as "FacilityReqMethodCode"
		, '' as "FacilityReqMethodNameTH"
		, '' as "FacilityReqMethodNameEN"
from 	
(
	select 	'PLC' as "BU"
			, v.patient_id as "PatientID"
			, a.admit_id as "AdmitID"
			, a.admit_date || ' ' || a.admit_time as "AdmitDateTime"
			, format_an(a.an) as "AN"
			, format_receipt(r.receipt_number, r.fix_receipt_type_id, r.fix_receipt_status_id, r.credit_number) as "InvoiceNo"
			, row_number() over(partition by r.visit_id order by r.receipt_id) as "InvoiceSuffixSmall"
			, r.receive_date || '  ' || r.receive_time as "ReceiveDateTime"
			, r.payer_id as "ARCode"
			, p.description as "ARName"
			, r.plan_id as "RightCode"
			, p2.description as "RightName"
			, '' as "HNReceiptFormCode"
			, '' as "HNReceiptFormLocalName"
			, '' as "HNReceiptFormEnglishName"
			, r.template_discount_id as "HNDiscountCode"
			, coalesce(td.description,'') as "HNDiscountLocalName"
			, coalesce(td.description,'') as "HNDiscountEnglishName"
			, r.paid::decimal as "FromChargeAmt"
			, (r.discount::decimal + r.decimal_discount::decimal) as "DiscountAmt"
			, r.last_print_date || ' ' || r.last_print_time as "PrintDateTime"
			, coalesce(imed_get_employee_name(r.prepare_cancel_eid),'') as "CancelBy"
			, r.prepare_cancel_date || ' ' || r.prepare_cancel_time as "CancelDateTime"
			, r.receipt_id
	from 	receipt r 
			inner join visit v on r.visit_id = v.visit_id and v.fix_visit_type_id = '1'
			INNER JOIN admit a ON v.visit_id = a.visit_id
			inner join payer p on r.payer_id = p.payer_id 
			inner join plan p2 on r.plan_id = p2.plan_id
			left join template_discount td on r.template_discount_id = td.template_discount_id 
	where 	r.fix_receipt_type_id in ('1','6','7')
			and r.receive_date between '$P!{dBeginDate}' and '$P!{dEndDate}'
)rec_h 
inner join receipt_revenue_order rro on rec_h.receipt_id = rro.receipt_id 
inner join order_item oi on rro.order_item_id = oi.order_item_id 
inner join item i on oi.item_id = i.item_id 
inner join 
(
	select  split_part((case when position('.' in bbg.description_th) > 0 then 
			  split_part(bbg.description_th,' ',1)
			  else bbg.law_code end),'.',1)
			|| '.' || 
			split_part((case when position('.' in bbg.description_th) > 0 then 
			  split_part(bbg.description_th,' ',1)
			  else bbg.law_code end),'.',2) as billing_head
			, case when position('.' in bbg.description_th) > 0 then 
			  split_part(bbg.description_th,' ',1)
			  else bbg.law_code end as billing_sub_head
			, bbg.base_billing_group_id 
			, bbg.description_th 
			, bbg.description_en 
	from 	base_billing_group bbg 
	where 	bbg.base_billing_group_id like '07.%'
			and bbg.description_th not like '%(ยกเลิก)%'
)bbg on oi.base_billing_group_id = bbg.base_billing_group_id
left join 
(
	select  case when position('.' in bbg.description_th) > 0 then 
			  split_part(bbg.description_th,' ',1)
			  else bbg.law_code end as billing_head
			, bbg.description_th 
			, bbg.description_en 
	from 	base_billing_group bbg 
	where 	bbg.base_billing_group_id like '07.%'
			and bbg.description_th not like '%(ยกเลิก)%'
			and split_part(bbg.base_billing_group_id,'.',4) = '00' 
			and split_part((case when position('.' in bbg.description_th) > 0 then 
			  split_part(bbg.description_th,' ',1)
			  else bbg.law_code end),'.',3) = ''
)bbgh on bbg.billing_head = bbgh.billing_head
order by rec_h.receipt_id