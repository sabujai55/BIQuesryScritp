select * from
(
(
select 'PLC' as "BU"
	,oi.order_item_id as "OrderID"
	,oi.patient_id as "PatientID"
	,v.admit_id as "AdmitID"
	,v.admit_date ||' '|| v.admit_time as "AdmitDateTime"
	,format_an(v.an) as "AN"
	--,ROW_NUMBER() OVER (PARTITION BY v.visit_id ORDER BY (v.visit_id)) as "PrescriptionNo"
	--,'1' as "PrescriptionNo"
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
	,bsp.description as "StoreNameTH"
	,bsp.description as "StoreNameEN"
	,'' as "DoseTypeCode"
	,'' as "DoseTypeNameTH"
	,'' as "DoseTypeNameEN"
	,oi.base_drug_usage_code as "DoseCode"
	,'' as "DoseNameTH"
	,'' as "DoseNameEN"
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
	,oi.instruction_text_line1 ||' '|| oi.instruction_text_line2||' '|| oi.instruction_text_line3  as "DoseMemo"
	,i2.item_code as "EntryByFacilityMethodCode" --Edit 2026-03-04 >> เพิ่ม EntryByFacilityMethodCode, EntryByFacilityMethodNameTH, EntryByFacilityMethodNameEN
	,case when i2.print_name != '' then i2.print_name else i2.common_name end as "EntryByFacilityMethodNameTH" --Edit 2026-03-04 >> เพิ่ม EntryByFacilityMethodCode, EntryByFacilityMethodNameTH, EntryByFacilityMethodNameEN
	,i2.common_name as "EntryByFacilityMethodNameEN" --Edit 2026-03-04 >> เพิ่ม EntryByFacilityMethodCode, EntryByFacilityMethodNameTH, EntryByFacilityMethodNameEN
	,'' as "Checkup"
	,case when i.fix_item_type_id = '10' then '1' else '' end as "FlagDF"
	,i.base_order_category_id as "ActivityCategoryCode"	--Edit 2026-03-04 >> เพิ่ม ActivityCategoryCode, ActivityCategoryNameTH, ActivityCategoryNameEN
	,boc.description as "ActivityCategoryNameTH"	--Edit 2026-03-04 >> เพิ่ม ActivityCategoryCode, ActivityCategoryNameTH, ActivityCategoryNameEN
	,boc.description as "ActivityCategoryNameEN"	--Edit 2026-03-04 >> เพิ่ม ActivityCategoryCode, ActivityCategoryNameTH, ActivityCategoryNameEN
	,split_part(his_func_get_diagnosis(oi.visit_id, '1','1'),'|',1) as "PrimaryDiagnosisCode"		--Edit 2026-03-04 >> เพิ่ม Diagnosis
	,split_part(his_func_get_diagnosis(oi.visit_id, '1','2'),'|',1) as "PrimaryDiagnosisNameTH"	--Edit 2026-03-04 >> เพิ่ม Diagnosis
	,split_part(his_func_get_diagnosis(oi.visit_id, '1','2'),'|',1) as "PrimaryDiagnosisNameEN"	--Edit 2026-03-04 >> เพิ่ม Diagnosis
		from order_item oi 
		inner join admit v on oi.visit_id = v.visit_id 
		inner join visit_payment vp on v.visit_id = vp.visit_id and oi.visit_payment_id = vp.visit_payment_id and oi.plan_id = vp.plan_id 
		inner join plan p on vp.plan_code = p.plan_code 
		left join item i on oi.item_id = i.item_id 
		left join base_unit bu  on oi.base_unit_id = bu.base_unit_id 
		inner join attending_physician ap on oi.visit_id = ap.visit_id and oi.order_doctor_eid = ap.employee_id  --แก้ไขจาก left เป็น inner 4-2-69--
		left join base_department bd on ap.base_department_id = bd.base_department_id and bd.account_product = 'COST'
		left join fix_item_type fit on oi.fix_item_type_id = fit.fix_item_type_id 
		left join base_order_category boc on i.base_order_category_id = boc.base_order_category_id	--Edit 2026-03-04 >> เพิ่ม ActivityCategoryCode, ActivityCategoryNameTH, ActivityCategoryNameEN
		left join base_order_sub_category bosc on oi.base_order_sub_category_id = bosc.base_order_sub_category_id  
		left join base_service_point bsp on oi.execute_spid = bsp.base_service_point_id 
		left join base_dose_unit bdu on oi.base_dose_unit_id = bdu.base_dose_unit_id 
		left join base_drug_frequency bdf on oi.base_drug_frequency_id = bdf.base_drug_frequency_id 
		-- inner join diagnosis_icd10 di on di.visit_id = oi.visit_id and di.fix_diagnosis_type_id = '1' --Edit 2026-03-04 >> เปลี่ยนวิธีการดึงข้อมูล Diagnosis
-- *************************************** Get Package name *************************************** 
		left join order_item oi2 on oi.visit_id = oi2.visit_id and oi.set_order_id = oi2.order_item_id	 --Edit 2026-03-04 >> เพิ่ม EntryByFacilityMethodCode, EntryByFacilityMethodNameTH, EntryByFacilityMethodNameEN
		left join item i2 on oi2.item_id = i2.item_id	 --Edit 2026-03-04 >> เพิ่ม EntryByFacilityMethodCode, EntryByFacilityMethodNameTH, EntryByFacilityMethodNameEN
where 	oi.verify_date = current_date::text
order by oi.visit_id, oi.order_item_id
)
union all
(
select 'PLC' as "BU"
	,oi.order_item_id as "OrderID"
	,oi.patient_id as "PatientID"
	,v.admit_id as "AdmitID"
	,v.admit_date ||' '|| v.admit_time as "AdmitDateTime"
	,format_an(v.an) as "AN"
	--,ROW_NUMBER() OVER (PARTITION BY v.visit_id ORDER BY (v.visit_id)) as "PrescriptionNo"
	--,'1' as "PrescriptionNo"
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
	end as "ItemType"
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
	,bsp.description as "StoreNameTH"
	,bsp.description as "StoreNameEN"
	,'' as "DoseTypeCode"
	,'' as "DoseTypeNameTH"
	,'' as "DoseTypeNameTH"
	,oi.base_drug_usage_code as "DoseCode"
	,'' as "DoseNameTH"
	,'' as "DoseNameEN"
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
	,oi.instruction_text_line1 ||' '|| oi.instruction_text_line2||' '|| oi.instruction_text_line3  as "DoseMemo"
	,'' as "EntryByFacilityMethodCode"
	,'' as "EntryByFacilityMethodNameTH"
	,'' as "EntryByFacilityMethodNameEN"
	,'' as "Checkup"
	,case when i.fix_item_type_id = '10' then '1' else '' end as "FlagDF"
	,i.base_order_category_id as "ActivityCategoryCode"	--Edit 2026-03-04 >> เพิ่ม ActivityCategoryCode, ActivityCategoryNameTH, ActivityCategoryNameEN
	,boc.description as "ActivityCategoryNameTH"	--Edit 2026-03-04 >> เพิ่ม ActivityCategoryCode, ActivityCategoryNameTH, ActivityCategoryNameEN
	,boc.description as "ActivityCategoryNameEN"	--Edit 2026-03-04 >> เพิ่ม ActivityCategoryCode, ActivityCategoryNameTH, ActivityCategoryNameEN
	,split_part(his_func_get_diagnosis(oi.visit_id, '1','1'),'|',1) as "PrimaryDiagnosisCode"		--Edit 2026-03-04 >> เพิ่ม Diagnosis
	,split_part(his_func_get_diagnosis(oi.visit_id, '1','2'),'|',1) as "PrimaryDiagnosisNameTH"	--Edit 2026-03-04 >> เพิ่ม Diagnosis
	,split_part(his_func_get_diagnosis(oi.visit_id, '1','2'),'|',1) as "PrimaryDiagnosisNameEN"	--Edit 2026-03-04 >> เพิ่ม Diagnosis
		from track_order_item oi
		inner join admit v on oi.visit_id = v.visit_id 
		inner join visit_payment vp on v.visit_id = vp.visit_id and oi.visit_payment_id = vp.visit_payment_id and oi.plan_id = vp.plan_id 
		inner join plan p on vp.plan_code = p.plan_code 
		left join employee e on oi.verify_eid = e.employee_id 
		left join item i on oi.item_id = i.item_id 
		left join base_unit bu  on oi.base_unit_id = bu.base_unit_id 
		inner join attending_physician ap on oi.visit_id = ap.visit_id and oi.order_doctor_eid = ap.employee_id  --แก้ไขจาก left เป็น inner 4-2-69--
		left join base_department bd on ap.base_department_id = bd.base_department_id and bd.account_product = 'COST'
		left join fix_item_type fit on oi.fix_item_type_id = fit.fix_item_type_id 
		left join base_order_category boc on i.base_order_category_id = boc.base_order_category_id	--Edit 2026-03-04 >> เพิ่ม ActivityCategoryCode, ActivityCategoryNameTH, ActivityCategoryNameEN
		left join base_order_sub_category bosc on oi.base_order_sub_category_id = bosc.base_order_sub_category_id 
		left join base_service_point bsp on oi.execute_spid = bsp.base_service_point_id 
		left join base_dose_unit bdu on oi.base_dose_unit_id = bdu.base_dose_unit_id 
		left join base_drug_frequency bdf on oi.base_drug_frequency_id = bdf.base_drug_frequency_id 
		-- inner join diagnosis_icd10 di on di.visit_id = oi.visit_id and di.fix_diagnosis_type_id = '1' --Edit 2026-03-04 >> เปลี่ยนวิธีการดึงข้อมูล Diagnosis
where 	oi.track_date = current_date::text
order by oi.visit_id
)
) dataipd 
limit 100
		