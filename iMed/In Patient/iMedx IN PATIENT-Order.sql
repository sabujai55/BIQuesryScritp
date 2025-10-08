select * from
(
select 'PLC' as "BU"
	,oi.order_item_id as "OrderID"
	,oi.patient_id as "PatientID"
	,v.admit_id as "AdmitID"
	,v.admit_date ||' '|| v.admit_time as "AdmitDate"
	,format_an(v.an) as "AN"
	--,ROW_NUMBER() OVER (PARTITION BY v.visit_id ORDER BY (v.visit_id)) as "PrescriptionNo"
	--,'1' as "PrescriptionNo"
	,oi.verify_date ||' '|| oi.verify_time as "MakeDateTime"
	,case 
		when fit.fix_item_type_id = '0' then 'Medicine'
		when fit.fix_item_type_id = '1' then 'Lab'
		when fit.fix_item_type_id = '2' then 'Xray'
		when fit.fix_item_type_id = '3' then 'ServiceCharge'
		when fit.fix_item_type_id = '4' then 'Usage'
		when fit.fix_item_type_id = '6' then 'Dental'
		when fit.fix_item_type_id = '7' then 'Treatment'
		when fit.fix_item_type_id = '8' then 'Food'
		when fit.fix_item_type_id = '10' then 'Treatment'
		when fit.fix_item_type_id = '11' then 'BloodBank'
	end
	as "ItemType"
	,i.item_code as "ItemCode"
	,i.common_name as "ItemNameTH"
	,'' as "ItemNameEN"
	,oi.base_order_sub_category_id as "ActivityCode"
	,bosc.description as "ActivityNameTH"
	,'' as "ActivityNameEN"
	,oi.base_unit_id as "UnitCode"
	,bu.description_th as "UnitNameTH"
	,bu.description_en as "UnitNameEN"
	,oi.quantity as "QTY"
	,oi.unit_price_sale as "UnitPrice"
	,oi.unit_price_sale::float * oi.quantity::float as "ChargeAmt"
	,case when oi.charge_complete = '1' then 'Charge' else 'None' end as "ChargeType"
	,oi.verify_date ||' '|| oi.verify_time as "ChargeDateTime"
	,'' as "EntryByFacility"
	,substring(oi.assigned_ref_no,2,length(oi.assigned_ref_no)) as "RefNo"
	,'' as "CancelByUserCode"
	,'' as "CancelByUserNameTH"
	,'' as "CancelByUserNameEN"
	,'' as "CancelDateTime"
	,'' as "TreatmentDateTimeFrom"
	,'' as "TreatmentDateTimeTo"
	,oi.doctor_fee_eid as "DFDoctor"
	,vp.plan_code as "RightCode"
	,p.description as "RightNameTH"
	,'' as "RightNameEN"
	,oi.execute_spid as "StoreCode"
	--,bsp.description as "StoreName"
	,bsp.description as "StoreNameTH"
	,bsp.description_en as "StoreNameEN"
	,'' as "DoseType"
	,'' as "DoseCode"
	,oi.dose_quantity as "DoseQTY"
	,bdu.description_th as "DoseUnit"
	,bdf.description_th as "DoseFreqCode"
	,'' as "AuxLabel1"
	,'' as "AuxLabel2"
	,'' as "AuxLabel3"
	,'' as "EntryByFacilityMethodCode"
	,'' as "EntryByFacilityMethodNameTH"
	,'' as "EntryByFacilityMethodNameEN"
	,'' as "Checkup"
	,oi.instruction_text_line1 ||' '|| oi.instruction_text_line2||' '|| oi.instruction_text_line3  as "DoseMemo"
	,case when i.fix_item_type_id = '10' then '1' else '' end as "FlagDF"
	,oi.base_order_sub_category_id as "ActivityCategoryCode"
	,bosc.description as "ActivityCategoryNameTH"
	,'' as "ActivityCategoryNameEN"
		from order_item oi 
		inner join admit v on oi.visit_id = v.visit_id 
		inner join visit_payment vp on v.visit_id = vp.visit_id and oi.visit_payment_id = vp.visit_payment_id and oi.plan_id = vp.plan_id 
		inner join plan p on vp.plan_code = p.plan_code 
		left join item i on oi.item_id = i.item_id 
		left join base_unit bu  on oi.base_unit_id = bu.base_unit_id 
		left join attending_physician ap on oi.visit_id = ap.visit_id and oi.order_doctor_eid = ap.employee_id 
		left join base_department bd on ap.base_department_id = bd.base_department_id and bd.account_product = 'COST'
		left join fix_item_type fit on oi.fix_item_type_id = fit.fix_item_type_id 
		left join base_order_sub_category bosc on oi.base_order_sub_category_id = bosc.base_order_sub_category_id  
		left join base_service_point bsp on oi.execute_spid = bsp.base_service_point_id 
		left join base_dose_unit bdu on oi.base_dose_unit_id = bdu.base_dose_unit_id 
		left join base_drug_frequency bdf on oi.base_drug_frequency_id = bdf.base_drug_frequency_id 
union all
select 'PLC' as "BU"
	,oi.order_item_id as "OrderID"
	,oi.patient_id as "PatientID"
	,v.admit_id as "AdmitID"
	,v.admit_date ||' '|| v.admit_time as "AdmitDate"
	,format_an(v.an) as "AN"
	--,ROW_NUMBER() OVER (PARTITION BY v.visit_id ORDER BY (v.visit_id)) as "PrescriptionNo"
	--,'1' as "PrescriptionNo"
	,oi.verify_date ||' '|| oi.verify_time as "MakeDateTime"
	,case 
		when fit.fix_item_type_id = '0' then 'Medicine'
		when fit.fix_item_type_id = '1' then 'Lab'
		when fit.fix_item_type_id = '2' then 'Xray'
		when fit.fix_item_type_id = '3' then 'ServiceCharge'
		when fit.fix_item_type_id = '4' then 'Usage'
		when fit.fix_item_type_id = '6' then 'Dental'
		when fit.fix_item_type_id = '7' then 'Treatment'
		when fit.fix_item_type_id = '8' then 'Food'
		when fit.fix_item_type_id = '10' then 'Treatment'
		when fit.fix_item_type_id = '11' then 'BloodBank'
	end
	as "ItemType"
	,i.item_code as "ItemCode"
	,i.common_name as "ItemNameTH"
	,'' as "ItemNameEN"
	,oi.base_order_sub_category_id as "ActivityCode"
	,bosc.description as "ActivityNameTH"
	,'' as "ActivityNameEN"
	,oi.base_unit_id as "UnitCode"
	,bu.description_th as "UnitNameTH"
	,bu.description_en as "UnitNameEN"
	,oi.quantity as "QTY"
	,oi.unit_price_sale as "UnitPrice"
	,oi.unit_price_sale::float * oi.quantity::float as "ChargeAmt"
	,case when oi.charge_complete = '1' then 'Charge' else 'None' end as "ChargeType"
	,oi.verify_date ||' '|| oi.verify_time as "ChargeDateTime"
	,'' as "EntryByFacility"
	,substring(oi.assigned_ref_no,2,length(oi.assigned_ref_no)) as "RefNo"
	,e.employee_code as "CancelByUserCode"
	,e.prename||e.firstname||' '||e.lastname as "CancelByUserNameTH"
	,e.intername as "CancelByUserNameEN"
	,oi.verify_date ||' '||oi.verify_time as "CancelDateTime"
	,'' as "TreatmentDateTimeFrom"
	,'' as "TreatmentDateTimeTo"
	,oi.doctor_fee_eid as "DFDoctor"
	,vp.plan_code as "RightCode"
	,p.description as "RightNameTH"
	,'' as "RightNameEN"
	,oi.execute_spid as "StoreCode"
	,bsp.description as "StoreName"
	,bsp.description as "StoreNameTH"
	,bsp.description_en as "StoreNameEN"
	,'' as "DoseType"
	,'' as "DoseCode"
	,oi.dose_quantity as "DoseQTY"
	,bdu.description_th as "DoseUnit"
	,bdf.description_th as "DoseFreqCode"
	,'' as "AuxLabel1"
	,'' as "AuxLabel2"
	,'' as "AuxLabel3"
	,'' as "EntryByFacilityMethodCode"
	,'' as "EntryByFacilityMethodName"
	,'' as "Checkup"
	,oi.instruction_text_line1 ||' '|| oi.instruction_text_line2||' '|| oi.instruction_text_line3  as "DoseMemo"
	,case when i.fix_item_type_id = '10' then '1' else '' end as "FlagDF"
	,oi.base_order_sub_category_id as "ActivityCategoryCode"
	,bosc.description as "ActivityCategoryNameTH"
	,'' as "ActivityCategoryNameEN"
		from track_order_item oi
		inner join admit v on oi.visit_id = v.visit_id 
		inner join visit_payment vp on v.visit_id = vp.visit_id and oi.visit_payment_id = vp.visit_payment_id and oi.plan_id = vp.plan_id 
		inner join plan p on vp.plan_code = p.plan_code 
		left join employee e on oi.verify_eid = e.employee_id 
		left join item i on oi.item_id = i.item_id 
		left join base_unit bu  on oi.base_unit_id = bu.base_unit_id 
		left join attending_physician ap on oi.visit_id = ap.visit_id and oi.order_doctor_eid = ap.employee_id 
		left join base_department bd on ap.base_department_id = bd.base_department_id and bd.account_product = 'COST'
		left join fix_item_type fit on oi.fix_item_type_id = fit.fix_item_type_id 
		left join base_order_sub_category bosc on oi.base_order_sub_category_id = bosc.base_order_sub_category_id 
		left join base_service_point bsp on oi.execute_spid = bsp.base_service_point_id 
		left join base_dose_unit bdu on oi.base_dose_unit_id = bdu.base_dose_unit_id 
		left join base_drug_frequency bdf on oi.base_drug_frequency_id = bdf.base_drug_frequency_id 
) dataipd 
limit 10
		