select * from 
(
select 'PLR' as "BU"
	,oi.order_item_id as "OrderID"
	,oi.patient_id as "PatientID"
	,oi.visit_id as "VisitID"
	,v.visit_date ||' '|| v.visit_time as "VisitDate"
	,format_vn(v.vn) as "VN"
	--,ROW_NUMBER() OVER (PARTITION BY v.visit_id ORDER BY (v.visit_id)) as "PrescriptionNo"
	,'1' as "PrescriptionNo"
	,oi.verify_date ||' '|| oi.verify_time as "MakeDateTime"
	,case 
		when fit.fix_item_type_id = '0' then 'Medicine'
		when fit.fix_item_type_id = '1' then 'Lab'
		when fit.fix_item_type_id = '2' then 'Xray'
		WHEN fit.fix_item_type_id = '3' and i.base_order_category_id in ('05STK', '27', '28', '29', '37', 'HEAR') then 'Usage' --PLD
		WHEN fit.fix_item_type_id = '3' and i.base_category_group_id = '01' and i.item_code not like 'MEDC%' then 'Medicine' --PLD
		WHEN fit.fix_item_type_id = '3' AND  i.fix_set_type_id != '1' and i.item_code  LIKE ANY (ARRAY['%X', '%N']) AND i.base_category_group_id = '004' THEN 'Usage' --PLR
		WHEN fit.fix_item_type_id = '3' AND  i.fix_set_type_id != '1' and i.item_code  LIKE ANY (ARRAY['%X', '%N']) AND i.base_category_group_id = '003' then 'Medicine' --PLR
		when fit.fix_item_type_id = '3' THEN 'ServiceCharge'
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
	,bosc.base_order_sub_category_id as "ActivityCode"
	,bosc.description as "ActivityNameTH"
	,'' as "ActivityNameEN"
	,oi.base_unit_id as "UnitCode"
	,bu.description_th as "UnitNameTH"
	,bu.description_en  as "UnitNameEN"
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
	,p.description as "RightNameEN"
	,oi.execute_spid as "StoreCode"
	,bsp.description as "StoreNameTH"
	,bsp.description as "StoreNameEN"
	--����
	, '' as "DoseTypeCode"
	, '' as "DoseTypeNameTH"
	, '' as "DoseTypeNameEN"
	, oi.base_drug_usage_code as "DoseCode"
	, '' as "DoseNameTH"
	, '' as "DoseNameEN"
	,oi.dose_quantity as "DoseQTYCode"
	,'' as "DoseQTYNameTH"
	,'' as "DoseQTYNameEN"
	, oi.base_dose_unit_id as "DoseUnitCode"
	,bdu.description_th as "DoseUnitNameTH"
	,bdu.description_en as "DoseUnitNameEN"
	,oi.base_drug_frequency_id as "DoseFreqCode"
	,bdf.description_th as "DoseFreqNameTH"
	,bdf.description_en as "DoseFreqNameEN"
	,'' as "AuxLabel1Code"
	,'' as "AuxLabel1NameTH"
	,'' as "AuxLabel1NameEN"
	,'' as "AuxLabel2Code"
	,'' as "AuxLabel2NameTH"
	,'' as "AuxLabel2NameEN"
	,'' as "AuxLabel3Code"
	,'' as "AuxLabel3NameTH"
	,'' as "AuxLabel3NameEN"
	--
	,oi.instruction_text_line1 ||' '|| oi.instruction_text_line2||' '|| oi.instruction_text_line3  as "DoseMemo"
	,'' as "EntryByFacilityMethodCode"
	,'' as "EntryByFacilityMethodNameTH"
	,'' as "EntryByFacilityMethodNameEN"
	,'' as "Checkup"
	,case when i.fix_item_type_id = '10' then '1' else '0' end as "FlagDF"
	,'' as "ActivityCategoryCode"
	,'' as "ActivityCategoryNameTH"
	,'' as "ActivityCategoryNameEN"
	--����
	,'' as "PrimaryDiagnosisCode"
	,'' as "PrimaryDiagnosisNameTH"
	,'' as "PrimaryDiagnosisNameEN"
	--
		from order_item oi 
		inner join visit v on oi.visit_id = v.visit_id 
		left join visit_payment vp on v.visit_id = vp.visit_id and oi.visit_payment_id = vp.visit_payment_id and oi.plan_id = vp.plan_id 
		left join plan p on vp.plan_code = p.plan_code  
		left join item i on oi.item_id = i.item_id 
		left join base_unit bu  on oi.base_unit_id = bu.base_unit_id 
		left join attending_physician ap on oi.visit_id = ap.visit_id and oi.order_doctor_eid = ap.employee_id 
		left join base_department bd on ap.base_department_id = bd.base_department_id and bd.account_product = 'COST'
		left join fix_item_type fit on oi.fix_item_type_id = fit.fix_item_type_id 
		left join base_order_sub_category bosc on oi.base_order_sub_category_id = bosc.base_order_category_id 
		left join base_service_point bsp on oi.execute_spid = bsp.base_service_point_id 
-- *************************************** Setup Dose Med *************************************** 
		left join base_dose_unit bdu on oi.base_dose_unit_id = bdu.base_dose_unit_id 
		left join base_drug_frequency bdf on oi.base_drug_frequency_id = bdf.base_drug_frequency_id 
		left join base_drug_instruction bdi on split_part(oi.base_drug_usage_code,' ', 1) = bdi.base_drug_instruction_id
WHERE 	oi.verify_date::date = current_date
union all
select 'PLR' as "BU"
	,toi.order_item_id as "OrderID"
	,toi.patient_id as "PatientID"
	,toi.visit_id as "VisitID"
	,v.visit_date ||' '|| v.visit_time as "VisitDate"
	,format_vn(v.vn) as "VN"
	,'1' as "PrescriptionNo"
	,toi.verify_date ||' '|| toi.verify_time as "MakeDateTime"
	,case 
		when fit.fix_item_type_id = '0' then 'Medicine'
		when fit.fix_item_type_id = '1' then 'Lab'
		when fit.fix_item_type_id = '2' then 'Xray'
		WHEN fit.fix_item_type_id = '3' AND  i.fix_set_type_id != '1' and i.item_code  LIKE ANY (ARRAY['%X', '%N']) AND i.base_category_group_id = '004' THEN 'Usage' --PLR
		WHEN fit.fix_item_type_id = '3' AND  i.fix_set_type_id != '1' and i.item_code  LIKE ANY (ARRAY['%X', '%N']) AND i.base_category_group_id = '003' then 'Medicine' --PLR
		WHEN fit.fix_item_type_id = '3' and i.base_order_category_id in ('05STK', '27', '28', '29', '37', 'HEAR') then 'Usage' --PLD
		WHEN fit.fix_item_type_id = '3' and i.base_category_group_id = '01' and i.item_code not like 'MEDC%' then 'Medicine' --PLD
		when fit.fix_item_type_id = '3' THEN 'ServiceCharge'
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
	,bosc.base_order_sub_category_id as "ActivityCode"
	,bosc.description as "ActivityNameTH"
	,'' as "ActivityNameEN"
	,toi.base_unit_id as "UnitCode"
	,bu.description_th as "UnitNameTH"
	,bu.description_en  as "UnitNameEN"
	,toi.quantity as "QTY"
	,toi.unit_price_sale as "UnitPrice"
	,toi.unit_price_sale::float * toi.quantity::float as "ChargeAmt"
	,case when toi.charge_complete = '1' then 'Charge' else 'None' end as "ChargeType"
	,toi.verify_date ||' '|| toi.verify_time as "ChargeDateTime"
	,'' as "EntryByFacility"
	,substring(toi.assigned_ref_no,2,length(toi.assigned_ref_no)) as "RefNo"
	,toi.track_actor as "CancelByUserCode"
	,e.prename||e.firstname||' '||e.lastname as "CancelByUserNameTH"
	,e.intername as "CancelByUserNameEN"
	,toi.verify_date ||' '||toi.verify_time as "CancelDateTime"
	,'' as "TreatmentDateTimeFrom"
	,'' as "TreatmentDateTimeTo"
	,toi.doctor_fee_eid as "DFDoctor"
	,vp.plan_code as "RightCode"
	,p.description as "RightNameTH"
	,p.description as "RightNameEN"
	,toi.execute_spid as "StoreCode"
	,bsp.description as "StoreNameTH"
	,bsp.description as "StoreNameEN"
	--����
	, '' as "DoseTypeCode"
	, '' as "DoseTypeNameTH"
	, '' as "DoseTypeNameEN"
	, toi.base_drug_usage_code as "DoseCode"
	, '' as "DoseNameTH"
	, '' as "DoseNameEN"
	,toi.dose_quantity as "DoseQTYCode"
	,'' as "DoseQTYNameTH"
	,'' as "DoseQTYNameEN"
	,toi.base_dose_unit_id as "DoseUnitCode"
	,bdu.description_th as "DoseUnitNameTH"
	,bdu.description_en as "DoseUnitNameEN"
	,toi.base_drug_frequency_id as "DoseFreqCode"
	,bdf.description_th as "DoseFreqNameTH"
	,bdf.description_en as "DoseFreqNameEN"
	,'' as "AuxLabel1Code"
	,'' as "AuxLabel1NameTH"
	,'' as "AuxLabel1NameEN"
	,'' as "AuxLabel2Code"
	,'' as "AuxLabel2NameTH"
	,'' as "AuxLabel2NameEN"
	,'' as "AuxLabel3Code"
	,'' as "AuxLabel3NameTH"
	,'' as "AuxLabel3NameEN"
	--
	,toi.instruction_text_line1 ||' '|| toi.instruction_text_line2||' '|| toi.instruction_text_line3  as "DoseMemo"
	,'' as "EntryByFacilityMethodCode"
	,'' as "EntryByFacilityMethodNameTH"
	,'' as "EntryByFacilityMethodNameEN"
	,'' as "Checkup"
	,case when i.fix_item_type_id = '10' then '1' else '0' end as "FlagDF"
	,'' as "ActivityCategoryCode"
	,'' as "ActivityCategoryNameTH"
	,'' as "ActivityCategoryNameEN"
	--����
	,'' as "PrimaryDiagnosisCode"
	,'' as "PrimaryDiagnosisNameTH"
	,'' as "PrimaryDiagnosisNameEN"
	--
		from track_order_item toi 
		inner join visit v on toi.visit_id = v.visit_id 
		left join visit_payment vp on v.visit_id = vp.visit_id and toi.visit_payment_id = vp.visit_payment_id and toi.plan_id = vp.plan_id 
		left join plan p on vp.plan_code = p.plan_code  
		left join employee e on toi.verify_eid = e.employee_id 
		left join item i on toi.item_id = i.item_id 
		left join base_unit bu  on toi.base_unit_id = bu.base_unit_id 
		left join attending_physician ap on toi.visit_id = ap.visit_id and toi.order_doctor_eid = ap.employee_id 
		left join base_department bd on ap.base_department_id = bd.base_department_id and bd.account_product = 'COST'
		left join fix_item_type fit on toi.fix_item_type_id = fit.fix_item_type_id 
		left join base_order_sub_category bosc on toi.base_order_sub_category_id = bosc.base_order_category_id 
		left join base_service_point bsp on toi.execute_spid = bsp.base_service_point_id 
-- *************************************** Setup Dose Med *************************************** 
		left join base_dose_unit bdu on toi.base_dose_unit_id = bdu.base_dose_unit_id 
		left join base_drug_frequency bdf on toi.base_drug_frequency_id = bdf.base_drug_frequency_id 
WHERE 	toi.track_date::date = current_date
) dataopd 
--where "CancelByUserCode" != ''  
--limit 100








