select	r."BU"
		, r."PatientID"
		, r."VisitID"
		, r."VisitDate"
		, r."VN"
		, r."PrescriptionNo"
		, r."ClinicCode"
		, r."ClinicNameTH"
		, r."ClinicNameEN"
		, r."DoctorCode"
		, r."DoctorNameTH"
		, r."DoctorNameEN"
		, r."InvoiceNo"
		, r."InvoiceSuffixSmall"
		, r."HNReceiptFormCode"
		, r."SuffixSmall"
		, r."TreatmentSuffixTiny"
		, r."MedcineSuffixTiny"
		, r."MakeDateTime"
		, r."ReceiveFormLineNo"
		, r."HNActivityCode"
		, r."ItemCode"
		, r."ItemName"
		, r."UnitPrice"
		, r."Qty"
		, r."ChargeAmt"
		, r."FromChargeAmt"
		, r."DiscountAmt"
		, r."BillingGroupId"
		, r."BillingGroupLocalName"
		, r."BillingGroupEnglishName"
		, r."BillingSubGroupId"
		, r."BillingSubGroupLocalName"
		, r."BillingSubGroupEnglishName"
		, r."FacilityReqMethodCode"
		, r."FacilityReqMethodNameTH"
		, r."FacilityReqMethodNameEN"
from 
(
--################################################################# Doctor Order #################################################################
--Order Non Package
select  bs.site_code as "BU"
		, r.patient_id as "PatientID"
		, r.visit_id as "VisitID"
		, v.visit_date as "VisitDate"
		, format_vn(v.vn) as "VN"
		, coalesce(ap.attending_physician_id, ap2."PrescriptionNo", ap3."PrescriptionNo", ap4."PrescriptionNo") as "PrescriptionNo"
		, coalesce(ap.base_department_id, ap2."ClinicCode", ap3."ClinicCode", ap4."ClinicCode") as "ClinicCode"
		, coalesce(bd.description_th, ap2."ClinicNameTH", ap3."ClinicNameTH", ap4."ClinicNameTH") as "ClinicNameTH"
		, coalesce(bd.description_en, ap2."ClinicNameEN", ap3."ClinicNameEN", ap4."ClinicNameEN") as "ClinicNameEN"
		, coalesce(ap.employee_id, ap2."DoctorCode", ap3."DoctorCode", ap4."DoctorCode") as "DoctorCode"
		, coalesce(e.prename || e.firstname || ' ' || e.lastname, ap2."DoctorNameTH", ap3."DoctorNameTH", ap4."DoctorNameTH") as "DoctorNameTH"
		, coalesce(e.intername, ap2."DoctorNameEN", ap3."DoctorNameEN", ap4."DoctorNameEN") as "DoctorNameEN"
		, 'A' as flag
		, r.receipt_id
		, oi.order_item_id
		, format_receipt(r.receipt_number ,r.fix_receipt_type_id ,r.fix_receipt_status_id ,'0') as "InvoiceNo"
		, dense_rank() over (partition by r.visit_id order by r.receipt_id) as "InvoiceSuffixSmall"
		, '' as "HNReceiptFormCode"
		, row_number() over(partition by r.receipt_id order by rro.order_item_id ) as "SuffixSmall"
		, '' as "TreatmentSuffixTiny"
		, '' as "MedcineSuffixTiny"
		, oi.verify_date || ' ' || oi.verify_time as "MakeDateTime"
		, '' as "ReceiveFormLineNo"
		, i.base_order_sub_category_id as "HNActivityCode"
		, i.item_code as "ItemCode"
		, i.common_name as "ItemName"
		, oi.unit_price_sale::decimal as "UnitPrice"
		, oi.quantity::decimal as "Qty"
		, (oi.unit_price_sale::decimal * oi.quantity::decimal) as "ChargeAmt"
		, rro.paid::decimal as "FromChargeAmt"
		, rro.discount::decimal as "DiscountAmt"
		, split_part(bbg.code,'.',1) || '.' || split_part(bbg.code,'.',2) as "BillingGroupId"
		, bbg2.description_th as "BillingGroupLocalName"
		, bbg2.description_en as "BillingGroupEnglishName"
		, bbg.code as "BillingSubGroupId"
		, bbg.description_th as "BillingSubGroupLocalName"
		, bbg.description_en as "BillingSubGroupEnglishName"
		, '' as "FacilityReqMethodCode"
		, '' as "FacilityReqMethodNameTH"
		, '' as "FacilityReqMethodNameEN"
from 	receipt r 
		inner join receipt_revenue_order rro on r.receipt_id = rro.receipt_id 
		inner join order_item oi on rro.order_item_id = oi.order_item_id
		inner join item i on oi.item_id = i.item_id 
		inner join base_billing_group bbg on oi.base_billing_group_id = bbg.base_billing_group_id 
		inner join visit v on r.visit_id = v.visit_id 
		inner join base_service_point bsp on oi.verify_spid = bsp.base_service_point_id 
		left join attending_physician ap on oi.visit_id = ap.visit_id and bsp.base_department_id = ap.base_department_id and oi.order_doctor_eid = ap.employee_id
		left join employee e on ap.employee_id = e.employee_id 
		left join base_department bd on ap.base_department_id = bd.base_department_id 
		left join lateral
		(
			select 	distinct on (ap.visit_id, ap.base_department_id)
					ap.attending_physician_id as "PrescriptionNo"
					, ap.base_department_id as "ClinicCode"
					, bd.description_th as "ClinicNameTH"
					, bd.description_en as "ClinicNameEN"
					, ap.employee_id as "DoctorCode"
					, e.prename || e.firstname || ' ' || e.lastname as "DoctorNameTH"
					, e.intername as "DoctorNameEN"
			from 	attending_physician ap 
					inner join employee e on ap.employee_id = e.employee_id
					inner join base_department bd on ap.base_department_id = bd.base_department_id
			where 	ap.visit_id = oi.visit_id
					and ap.employee_id = oi.order_doctor_eid
			limit 1
		)ap2 on true
		left join lateral
		(
			select 	distinct on (ap.visit_id, ap.base_department_id)
					ap.attending_physician_id as "PrescriptionNo"
					, ap.base_department_id as "ClinicCode"
					, bd.description_th as "ClinicNameTH"
					, bd.description_en as "ClinicNameEN"
					, ap.employee_id as "DoctorCode"
					, e.prename || e.firstname || ' ' || e.lastname as "DoctorNameTH"
					, e.intername as "DoctorNameEN"
			from 	attending_physician ap 
					left join employee e on ap.employee_id = e.employee_id
					inner join base_department bd on ap.base_department_id = bd.base_department_id
			where 	ap.visit_id = oi.visit_id
					and ap.base_department_id = bsp.base_department_id
--					and ap.priority = '1'
			limit 1
		)ap3 on true
		left join lateral
		(
			select 	distinct on (ap.visit_id, ap.base_department_id)
					ap.attending_physician_id as "PrescriptionNo"
					, ap.base_department_id as "ClinicCode"
					, bd.description_th as "ClinicNameTH"
					, bd.description_en as "ClinicNameEN"
					, ap.employee_id as "DoctorCode"
					, e.prename || e.firstname || ' ' || e.lastname as "DoctorNameTH"
					, e.intername as "DoctorNameEN"
			from 	attending_physician ap 
					left join employee e on ap.employee_id = e.employee_id
					inner join base_department bd on ap.base_department_id = bd.base_department_id
			where 	ap.visit_id = oi.visit_id
--					and ap.base_department_id = bsp.base_department_id
					and ap.priority = '1'
			limit 1
		)ap4 on true
		left join lateral
		(
			select 	split_part(bbg2.description_th, ' ', 1) as base_billing_group_id
					, bbg2.description_th 
					, bbg2.description_en 
			from 	base_billing_group bbg2 
			where 	1=1
					and bbg2.base_billing_group_id like '07.%'
					and split_part(bbg2.description_th, ' ', 1) ~ '^[0-9]+(\.[0-9]+)?$'
					and split_part(bbg2.description_th, ' ', 1) = (split_part(bbg.code,'.',1) || '.' || split_part(bbg.code,'.',2))
		)bbg2 on true
		, base_site bs 
where 	1=1
		and r.fix_receipt_type_id in ('1','6','7')
		and r.fix_receipt_status_id = '2'
		and r.fix_visit_type_id = '0'
		and oi.fix_set_type_id not in ('1','2')
		and oi.order_doctor_eid != ''
		and r.receive_date = (current_date-1)::text
--		and r.receipt_id = '526072901052405101'
--		and r.visit_id = '526072921132352401'
union all 
--Order Package
select  bs.site_code as "BU"
		, r.patient_id as "PatientID"
		, r.visit_id as "VisitID"
		, v.visit_date as "VisitDate"
		, format_vn(v.vn) as "VN"
		, coalesce(ap.attending_physician_id, ap2."PrescriptionNo", ap3."PrescriptionNo") as "PrescriptionNo"
		, coalesce(ap.base_department_id, ap2."ClinicCode", ap3."ClinicCode") as "ClinicCode"
		, coalesce(bd.description_th, ap2."ClinicNameTH", ap3."ClinicNameTH") as "ClinicNameTH"
		, coalesce(bd.description_en, ap2."ClinicNameEN", ap3."ClinicNameEN") as "ClinicNameEN"
		, coalesce(ap.employee_id, ap2."DoctorCode", ap3."DoctorCode") as "DoctorCode"
		, coalesce(e.prename || e.firstname || ' ' || e.lastname, ap2."DoctorNameTH", ap3."DoctorNameTH") as "DoctorNameTH"
		, coalesce(e.intername, ap2."DoctorNameEN", ap3."DoctorNameEN") as "DoctorNameEN"
		, 'B' as flag
		, r.receipt_id
		, oi2.order_item_id
		, format_receipt(r.receipt_number ,r.fix_receipt_type_id ,r.fix_receipt_status_id ,'0') as "InvoiceNo"
		, dense_rank() over (partition by r.visit_id order by r.receipt_id) as "InvoiceSuffixSmall"
		, '' as "HNReceiptFormCode"
		, row_number() over(partition by r.receipt_id order by rro.order_item_id ) as "SuffixSmall"
		, '' as "TreatmentSuffixTiny"
		, '' as "MedcineSuffixTiny"
		, oi.verify_date || ' ' || oi.verify_time as "MakeDateTime"
		, '' as "ReceiveFormLineNo"
		, i.base_order_sub_category_id as "HNActivityCode"
		, i.item_code as "ItemCode"
		, i.common_name as "ItemName"
		, oi2.original_unit_price::decimal  as "UnitPrice"
		, oi2.quantity::decimal as "Qty"
		, (oi2.original_unit_price::decimal * oi2.quantity::decimal) as "ChargeAmt"
		, (oi2.original_unit_price::decimal * oi2.quantity::decimal) as "FromChargeAmt"
		, '0'::decimal as "DiscountAmt"
		, split_part(bbg.code,'.',1) || '.' || split_part(bbg.code,'.',2) as "BillingGroupId"
		, bbg2.description_th as "BillingGroupLocalName"
		, bbg2.description_en as "BillingGroupEnglishName"
		, bbg.code as "BillingSubGroupId"
		, bbg.description_th as "BillingSubGroupLocalName"
		, bbg.description_en as "BillingSubGroupEnglishName"
		, i2.item_code  as "FacilityReqMethodCode"
		, i2.common_name  as "FacilityReqMethodNameTH"
		, i2.print_name_en  as "FacilityReqMethodNameEN"
from 	receipt r 
		inner join receipt_revenue_order rro on r.receipt_id = rro.receipt_id 
		inner join order_item oi on rro.order_item_id = oi.order_item_id
		inner join order_item oi2 on oi.visit_id = oi2.visit_id and oi.order_item_id = oi2.set_order_id and oi2.fix_set_type_id = '2'
		inner join item i on oi2.item_id = i.item_id
		inner join item i2 on oi.item_id = i2.item_id
		inner join base_billing_group bbg on oi2.base_billing_group_id = bbg.base_billing_group_id 
		inner join visit v on r.visit_id = v.visit_id 
		inner join base_service_point bsp on oi2.verify_spid = bsp.base_service_point_id 
		left join attending_physician ap on oi.visit_id = ap.visit_id and bsp.base_department_id = ap.base_department_id and oi.order_doctor_eid = ap.employee_id
		left join employee e on ap.employee_id = e.employee_id 
		left join base_department bd on ap.base_department_id = bd.base_department_id 
		left join lateral
		(
			select 	distinct on (ap.visit_id, ap.base_department_id)
					ap.attending_physician_id as "PrescriptionNo"
					, ap.base_department_id as "ClinicCode"
					, bd.description_th as "ClinicNameTH"
					, bd.description_en as "ClinicNameEN"
					, ap.employee_id as "DoctorCode"
					, e.prename || e.firstname || ' ' || e.lastname as "DoctorNameTH"
					, e.intername as "DoctorNameEN"
			from 	attending_physician ap 
					inner join employee e on ap.employee_id = e.employee_id
					inner join base_department bd on ap.base_department_id = bd.base_department_id
			where 	ap.visit_id = oi2.visit_id
					and ap.employee_id = oi2.order_doctor_eid
			limit 1
		)ap2 on true
		left join lateral
		(
			select 	distinct on (ap.visit_id, ap.base_department_id)
					ap.attending_physician_id as "PrescriptionNo"
					, ap.base_department_id as "ClinicCode"
					, bd.description_th as "ClinicNameTH"
					, bd.description_en as "ClinicNameEN"
					, ap.employee_id as "DoctorCode"
					, e.prename || e.firstname || ' ' || e.lastname as "DoctorNameTH"
					, e.intername as "DoctorNameEN"
			from 	attending_physician ap 
					left join employee e on ap.employee_id = e.employee_id
					inner join base_department bd on ap.base_department_id = bd.base_department_id
			where 	ap.visit_id = oi2.visit_id
--					and ap.base_department_id = bsp.base_department_id
					and ap.priority = '1'
			limit 1
		)ap3 on true
		left join lateral
		(
			select 	split_part(bbg2.description_th, ' ', 1) as base_billing_group_id
					, bbg2.description_th 
					, bbg2.description_en 
			from 	base_billing_group bbg2 
			where 	1=1
					and bbg2.base_billing_group_id like '07.%'
					and split_part(bbg2.description_th, ' ', 1) ~ '^[0-9]+(\.[0-9]+)?$'
					and split_part(bbg2.description_th, ' ', 1) = (split_part(bbg.code,'.',1) || '.' || split_part(bbg.code,'.',2))
		)bbg2 on true
		, base_site bs 
where 	1=1
		and r.fix_receipt_type_id in ('1','6','7')
		and r.fix_receipt_status_id = '2'
		and r.fix_visit_type_id = '0'
		and oi.fix_set_type_id = '1'
		and oi.order_doctor_eid != ''
		and r.receive_date = (current_date-1)::text
--		and r.receipt_id = '526072901052405101'
--		and r.visit_id = '526072921132352401'
--############################################################################################################################################
union all 
--############################################################# Non Doctor Order #############################################################
--Order Non Package
select  bs.site_code as "BU"
		, r.patient_id as "PatientID"
		, r.visit_id as "VisitID"
		, v.visit_date as "VisitDate"
		, format_vn(v.vn) as "VN"
		, coalesce(ap.attending_physician_id, ap2."PrescriptionNo") as "PrescriptionNo"
		, coalesce(ap.base_department_id, ap2."ClinicCode") as "ClinicCode"
		, coalesce(bd.description_th, ap2."ClinicNameTH") as "ClinicNameTH"
		, coalesce(bd.description_en, ap2."ClinicNameEN")  as "ClinicNameEN"
		, coalesce(ap.employee_id, ap2."DoctorCode") as "DoctorCode"
		, coalesce(e.prename || e.firstname || ' ' || e.lastname, ap2."DoctorNameTH") as "DoctorNameTH"
		, coalesce(e.intername, ap2."DoctorNameEN") as "DoctorNameEN"	
		, 'C' as flag
		, r.receipt_id
		, oi.order_item_id
		, format_receipt(r.receipt_number ,r.fix_receipt_type_id ,r.fix_receipt_status_id ,'0') as "InvoiceNo"
		, dense_rank() over (partition by r.visit_id order by r.receipt_id) as "InvoiceSuffixSmall"
		, '' as "HNReceiptFormCode"
		, row_number() over(partition by r.receipt_id order by rro.order_item_id ) as "SuffixSmall"
		, '' as "TreatmentSuffixTiny"
		, '' as "MedcineSuffixTiny"
		, oi.verify_date || ' ' || oi.verify_time as "MakeDateTime"
		, '' as "ReceiveFormLineNo"
		, i.base_order_sub_category_id as "HNActivityCode"
		, i.item_code as "ItemCode"
		, i.common_name as "ItemName"
		, oi.unit_price_sale::decimal as "UnitPrice"
		, oi.quantity::decimal as "Qty"
		, (oi.unit_price_sale::decimal * oi.quantity::decimal) as "ChargeAmt"
		, rro.paid::decimal as "FromChargeAmt"
		, rro.discount::decimal as "DiscountAmt"
		, split_part(bbg.code,'.',1) || '.' || split_part(bbg.code,'.',2) as "BillingGroupId"
		, bbg2.description_th as "BillingGroupLocalName"
		, bbg2.description_en as "BillingGroupEnglishName"
		, bbg.code as "BillingSubGroupId"
		, bbg.description_th as "BillingSubGroupLocalName"
		, bbg.description_en as "BillingSubGroupEnglishName"
		, '' as "FacilityReqMethodCode"
		, '' as "FacilityReqMethodNameTH"
		, '' as "FacilityReqMethodNameEN"
from 	receipt r 
		inner join receipt_revenue_order rro on r.receipt_id = rro.receipt_id 
		inner join order_item oi on rro.order_item_id = oi.order_item_id
		inner join item i on oi.item_id = i.item_id 
		inner join base_billing_group bbg on oi.base_billing_group_id = bbg.base_billing_group_id 
		inner join visit v on r.visit_id = v.visit_id 
		inner join base_service_point bsp on oi.verify_spid = bsp.base_service_point_id 
		left join attending_physician ap on oi.visit_id = ap.visit_id and ap.priority = '1'
		left join employee e on ap.employee_id = e.employee_id 
		left join base_department bd on ap.base_department_id = bd.base_department_id 
		left join lateral
		(
			select 	distinct on (ap.visit_id, ap.base_department_id)
					ap.attending_physician_id as "PrescriptionNo"
					, ap.base_department_id as "ClinicCode"
					, bd.description_th as "ClinicNameTH"
					, bd.description_en as "ClinicNameEN"
					, ap.employee_id as "DoctorCode"
					, e.prename || e.firstname || ' ' || e.lastname as "DoctorNameTH"
					, e.intername as "DoctorNameEN"
			from 	attending_physician ap 
					inner join employee e on ap.employee_id = e.employee_id
					inner join base_department bd on ap.base_department_id = bd.base_department_id
			where 	ap.visit_id = oi.visit_id
					and ap.employee_id = oi.order_doctor_eid
			limit 1
		)ap2 on true
		left join lateral
		(
			select 	split_part(bbg2.description_th, ' ', 1) as base_billing_group_id
					, bbg2.description_th 
					, bbg2.description_en 
			from 	base_billing_group bbg2 
			where 	1=1
					and bbg2.base_billing_group_id like '07.%'
					and split_part(bbg2.description_th, ' ', 1) ~ '^[0-9]+(\.[0-9]+)?$'
					and split_part(bbg2.description_th, ' ', 1) = (split_part(bbg.code,'.',1) || '.' || split_part(bbg.code,'.',2))
		)bbg2 on true
		, base_site bs 
where 	1=1
		and r.fix_receipt_type_id in ('1','6','7')
		and r.fix_receipt_status_id = '2'
		and r.fix_visit_type_id = '0'
		and oi.fix_set_type_id not in ('1','2')
		and oi.order_doctor_eid = ''
		and r.receive_date = (current_date-1)::text
--		and r.receipt_id = '526072901052405101'
--		and r.visit_id = '526072921132352401'
union all 
--Order Package
select  bs.site_code as "BU"
		, r.patient_id as "PatientID"
		, r.visit_id as "VisitID"
		, v.visit_date as "VisitDate"
		, format_vn(v.vn) as "VN"
		, coalesce(ap.attending_physician_id, ap2."PrescriptionNo") as "PrescriptionNo"
		, coalesce(ap.base_department_id, ap2."ClinicCode") as "ClinicCode"
		, coalesce(bd.description_th, ap2."ClinicNameTH") as "ClinicNameTH"
		, coalesce(bd.description_en, ap2."ClinicNameEN") as "ClinicNameEN"
		, coalesce(ap.employee_id, ap2."DoctorCode") as "DoctorCode"
		, coalesce(e.prename || e.firstname || ' ' || e.lastname, ap2."DoctorNameTH") as "DoctorNameTH"
		, coalesce(e.intername, ap2."DoctorNameEN") as "DoctorNameEN"
		, 'D' as flag
		, r.receipt_id
		, oi2.order_item_id
		, format_receipt(r.receipt_number ,r.fix_receipt_type_id ,r.fix_receipt_status_id ,'0') as "InvoiceNo"
		, dense_rank() over (partition by r.visit_id order by r.receipt_id) as "InvoiceSuffixSmall"
		, '' as "HNReceiptFormCode"
		, row_number() over(partition by r.receipt_id order by rro.order_item_id ) as "SuffixSmall"
		, '' as "TreatmentSuffixTiny"
		, '' as "MedcineSuffixTiny"
		, oi.verify_date || ' ' || oi.verify_time as "MakeDateTime"
		, '' as "ReceiveFormLineNo"
		, i.base_order_sub_category_id as "HNActivityCode"
		, i.item_code as "ItemCode"
		, i.common_name as "ItemName"
		, oi2.original_unit_price::decimal  as "UnitPrice"
		, oi2.quantity::decimal as "Qty"
		, (oi2.original_unit_price::decimal * oi2.quantity::decimal) as "ChargeAmt"
		, (oi2.original_unit_price::decimal * oi2.quantity::decimal) as "FromChargeAmt"
		, '0'::decimal as "DiscountAmt"
		, split_part(bbg.code,'.',1) || '.' || split_part(bbg.code,'.',2) as "BillingGroupId"
		, bbg2.description_th as "BillingGroupLocalName"
		, bbg2.description_en as "BillingGroupEnglishName"
		, bbg.code as "BillingSubGroupId"
		, bbg.description_th as "BillingSubGroupLocalName"
		, bbg.description_en as "BillingSubGroupEnglishName"
		, i2.item_code  as "FacilityReqMethodCode"
		, i2.common_name  as "FacilityReqMethodNameTH"
		, i2.print_name_en  as "FacilityReqMethodNameEN"
from 	receipt r 
		inner join receipt_revenue_order rro on r.receipt_id = rro.receipt_id 
		inner join order_item oi on rro.order_item_id = oi.order_item_id
		inner join order_item oi2 on oi.visit_id = oi2.visit_id and oi.order_item_id = oi2.set_order_id and oi2.fix_set_type_id = '2'
		inner join item i on oi2.item_id = i.item_id
		inner join item i2 on oi.item_id = i2.item_id
		inner join base_billing_group bbg on oi2.base_billing_group_id = bbg.base_billing_group_id 
		inner join visit v on r.visit_id = v.visit_id 
		inner join base_service_point bsp on oi2.verify_spid = bsp.base_service_point_id 
		left join attending_physician ap on oi.visit_id = ap.visit_id and ap.priority = '1'
		left join employee e on ap.employee_id = e.employee_id 
		left join base_department bd on ap.base_department_id = bd.base_department_id 
		left join lateral
		(
			select 	distinct on (ap.visit_id, ap.base_department_id)
					ap.attending_physician_id as "PrescriptionNo"
					, ap.base_department_id as "ClinicCode"
					, bd.description_th as "ClinicNameTH"
					, bd.description_en as "ClinicNameEN"
					, ap.employee_id as "DoctorCode"
					, e.prename || e.firstname || ' ' || e.lastname as "DoctorNameTH"
					, e.intername as "DoctorNameEN"
			from 	attending_physician ap 
					left join employee e on ap.employee_id = e.employee_id
					inner join base_department bd on ap.base_department_id = bd.base_department_id
			where 	ap.visit_id = oi.visit_id
					and ap.base_department_id = bsp.base_department_id
			limit 1
		)ap2 on true
		left join lateral
		(
			select 	distinct on (ap.visit_id, ap.base_department_id)
					ap.attending_physician_id as "PrescriptionNo"
					, ap.base_department_id as "ClinicCode"
					, bd.description_th as "ClinicNameTH"
					, bd.description_en as "ClinicNameEN"
					, ap.employee_id as "DoctorCode"
					, e.prename || e.firstname || ' ' || e.lastname as "DoctorNameTH"
					, e.intername as "DoctorNameEN"
			from 	attending_physician ap 
					inner join employee e on ap.employee_id = e.employee_id
					inner join base_department bd on ap.base_department_id = bd.base_department_id
			where 	ap.visit_id = oi.visit_id
					and ap.base_department_id = bsp.base_department_id
			limit 1
		)ap3 on true
		left join lateral
		(
			select 	split_part(bbg2.description_th, ' ', 1) as base_billing_group_id
					, bbg2.description_th 
					, bbg2.description_en 
			from 	base_billing_group bbg2 
			where 	1=1
					and bbg2.base_billing_group_id like '07.%'
					and split_part(bbg2.description_th, ' ', 1) ~ '^[0-9]+(\.[0-9]+)?$'
					and split_part(bbg2.description_th, ' ', 1) = (split_part(bbg.code,'.',1) || '.' || split_part(bbg.code,'.',2))
		)bbg2 on true
		, base_site bs 
where 	1=1
		and r.fix_receipt_type_id in ('1','6','7')
		and r.fix_receipt_status_id = '2'
		and r.fix_visit_type_id = '0'
		and oi.fix_set_type_id = '1'
		and oi.order_doctor_eid = ''
		and r.receive_date = (current_date-1)::text
--		and r.receipt_id = '526072901052405101'
--		and r.visit_id = '526072921132352401'
--############################################################################################################################################
)r 
order by r."VisitID", r.receipt_id , r.order_item_id 