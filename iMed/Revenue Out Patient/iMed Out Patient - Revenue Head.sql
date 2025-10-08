select 	'PLC' as "BU"
		, v.patient_id as "PatientID"
		, v.visit_id as "VisitID"
		, v.visit_date as "VisitDate"
		, format_vn(v.vn) as "VN"
		, format_receipt(r.receipt_number, r.fix_receipt_type_id, r.fix_receipt_status_id, r.credit_number) as "InvoiceNo"
		, row_number() over(partition by r.visit_id order by r.receipt_id) as "InvoiceSuffixSmall"
		, r.receive_date || '  ' || r.receive_time as "ReceiveDateTime"
		, r.payer_id as "ARCode"
		, p.description as "ARNameTH"
		, p.description_en as "ARNameEN"
		, r.plan_id as "RightCode"
		, p2.description as "RightNameTH"
		, '' as "RightNameEN"
		, '' as "HNReceiptFormCode"
		, '' as "HNReceiptFormLocalName"
		, '' as "HNReceiptFormEnglishName"
		, r.template_discount_id as "HNDiscountCode"
		, coalesce(td.description,'') as "HNDiscountLocalName"
		, coalesce(td.description,'') as "HNDiscountEnglishName"
		, r.paid::decimal as "FromChargeAmt"
		, (r.discount::decimal + r.decimal_discount::decimal) as "DiscountAmt"
		, r.last_print_date || ' ' || r.last_print_time as "PrintDateTime"
		, r.cancel_eid as "CancelByUserCode"
		, e.prename ||''|| e.firstname ||' '|| e.lastname as "CancelByUserNameTH"
		, e.intername as "CancelByUserNameEN"
		, r.cancel_date || ' ' || r.cancel_time as "CancelDateTime"
		, '' as "HNPackage"
		, '' as "HNPackageNameTH"
		, '' as "HNPackageNameEN"
		, r.receive_eid as "ReceiveByUserCode"
		, e2.prename ||''|| e2.firstname ||' '|| e2.lastname  as "ReceiveByUserNameTH"
		, e2.intername as "ReceiveByUserNameEN"
		, '' as "HNReceiveCode"
		, '' as "HNReceiveNameTH"
		, '' as "HNReceiveNameEN"
from 	receipt r 
		left join visit v on r.visit_id = v.visit_id
		left join payer p on r.payer_id = p.payer_id 
		left join plan p2 on r.plan_id = p2.plan_id
		left join template_discount td on r.template_discount_id = td.template_discount_id 
		left join employee e on e.employee_id = r.cancel_eid 
		left join employee e2 on e2.employee_id = r.receive_eid 
where 	r.fix_receipt_type_id in ('1','6','7') and v.fix_visit_type_id = '0'
		--and r.receive_date between '$P!{dBeginDate}' and '$P!{dEndDate}' 
		--and r.visit_id = '124090907281521501'