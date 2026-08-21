-- ***************************************************** Doctor Order  *****************************************************
select 	bs.site_code as "BU"
		, oi.order_item_id as "OrderID"
		, oi.patient_id as "PatientID"
		, oi.visit_id as "VisitID"
		, v.visit_date || ' ' || v.visit_time as "VisitDate"
		, format_vn(v.vn) as "VN"
		, coalesce(ap.attending_physician_id, ap2."PrescriptionNo", ap3."PrescriptionNo") as "PrescriptionNo"
		, coalesce(ap.base_department_id, ap2."ClinicCode", ap3."ClinicCode") as "ClinicCode"
		, coalesce(bd2.description, ap2."ClinicNameTH", ap3."ClinicNameTH") as "ClinicNameTH"
		, '' as "ClinicNameEN"
		, coalesce(ap.employee_id, ap2."DoctorCode", ap3."DoctorCode") as "DoctorCode"
		, coalesce(e2.prename || e2.firstname || ' ' || e2.firstname, ap2."DoctorNameTH", ap3."DoctorNameTH") as "DoctorNameTH"
		, coalesce(e2.intername, ap2."DoctorNameEN", ap3."DoctorNameEN") as "DoctorNameEN"
		, oi.verify_date || ' ' || oi.verify_time as "MakeDateTime"
		, case 
		  when oi.fix_item_type_id = '0' then 'Medicine'
		  when oi.fix_item_type_id = '1' then 'Lab'
		  when oi.fix_item_type_id = '2' then 'Xray'
		  WHEN oi.fix_item_type_id = '3' and i.base_order_category_id in ('05STK', '27', '28', '29', '37', 'HEAR') then 'Usage' --PLD
		  WHEN oi.fix_item_type_id = '3' and i.base_category_group_id = '01' and i.item_code not like 'MEDC%' then 'Medicine' --PLD
		  WHEN oi.fix_item_type_id = '3' AND  i.fix_set_type_id != '1' and i.item_code  LIKE ANY (ARRAY['%X', '%N']) AND i.base_category_group_id = '004' THEN 'Usage' --PLR
		  WHEN oi.fix_item_type_id = '3' AND  i.fix_set_type_id != '1' and i.item_code  LIKE ANY (ARRAY['%X', '%N']) AND i.base_category_group_id = '003' then 'Medicine' --PLR
		  when oi.fix_item_type_id = '3' THEN 'ServiceCharge'
		  when oi.fix_item_type_id = '4' then 'Usage'
		  when oi.fix_item_type_id = '6' then 'Dental'
		  when oi.fix_item_type_id = '7' then 'Treatment'
		  when oi.fix_item_type_id = '8' then 'Food'
		  when oi.fix_item_type_id = '10' then 'Treatment'
		  when oi.fix_item_type_id = '11' then 'BloodBank'
	      end as "ItemType"
	    , i.item_code as "ItemCode"
	    , case when i.print_name != '' then i.print_name else i.common_name end as "ItemNameTH"
	    , i.common_name as "ItemNameEN"
	    , oi.base_order_sub_category_id as "ActivityCode"
	    , bosc.description as "ActivityNameTH"
	    , '' as "ActivityNameEN"
	    , oi.base_unit_id as "UnitCode"
	    , bu.description_th as "UnitNameTH"
	    , bu.description_en as "UnitNameEN"
	    , oi.quantity as "QTY"
	    , case when oi.fix_set_type_id = '0' 
	      then oi.unit_price_sale 
	      else oi.original_unit_price end as "UnitPrice"
	    , case when oi.fix_set_type_id = '0' 
	      then oi.unit_price_sale::decimal * oi.quantity::decimal 
	      else oi.original_unit_price::decimal * oi.quantity::decimal  end as "ChargeAmt"
	    , case when oi.fix_order_status_id = '5' then 'Return' else 'Charge' end as "ChargeType"
	    , oi.verify_date as "ChargeDateTime"
	    , case when oi.op_registered_id != '' then 'OR'
	      when oi.base_lab_type_id != '' then oi.base_lab_type_id
	      when oi.base_xray_type_id != '' then oi.base_xray_type_id
	      else '' end as "EntryByFacility"
	    , case when oi.op_registered_id != '' then op.or_number
	      else oi.assigned_ref_no end as "RefNo"
	    , oi.verify_eid as "EntryByUserCode"
	    , e.prename || e.firstname || ' ' || e.lastname as "EntryByUserNameTH"
	    , e.intername as "EntryByUserNameEN"
	    , '' as "CancelByUserCode"
	    , '' as "CancelByUserNameTH"
	    , '' as "CancelByUserNameEN"
	    , '' as "CancelDateTime"
	    , '' as "TreatmentDateTimeFrom"
	    , '' as "TreatmentDateTimeTo"
	    , oi.doctor_fee_eid as "DFDoctor"
	    , p.plan_code as "RightCode"
	    , p.description as "RightNameTH"
	    , p.description as "RightNameEN"
	    , s.stock_id as "StoreCode"
	    , s.stock_name as "StoreNameTH"
	    , s.stock_name as "StoreNameEN"
	    , '' as "DoseTypeCode"
		, '' as "DoseTypeNameTH"
		, '' as "DoseTypeNameEN"
		, oi.base_drug_usage_code as "DoseCode"
		, '' as "DoseNameTH"
		, '' as "DoseNameEN"
		, oi.dose_quantity as "DoseQTYCode"
		, '' as "DoseQTYNameTH"
		, '' as "DoseQTYNameEN"
		, oi.base_dose_unit_id as "DoseUnitCode"
		, bdu.description_th as "DoseUnitNameTH"
		, bdu.description_en as "DoseUnitNameEN"
		, oi.base_drug_frequency_id as "DoseFreqCode"
		, bdf.description_th as "DoseFreqNameTH"
		, bdf.description_en as "DoseFreqNameEN"
		, '' as "AuxLabel1Code"
		, oi.description as "AuxLabel1NameTH"
		, '' as "AuxLabel1NameEN"
		, '' as "AuxLabel2Code"
		, i.caution as "AuxLabel2NameTH"
		, '' as "AuxLabel2NameEN"
		, '' as "AuxLabel3Code"
		, '' as "AuxLabel3NameTH"
		, '' as "AuxLabel3NameEN"
		, oi.instruction_text_line1 ||' '|| oi.instruction_text_line2||' '|| oi.instruction_text_line3  as "DoseMemo"
		, i2.item_code as "EntryByFacilityMethodCode" --Edit 2026-03-04 >> เน€เธ�เธดเน�เธก EntryByFacilityMethodCode, EntryByFacilityMethodNameTH, EntryByFacilityMethodNameEN
		, case when i2.print_name != '' then i2.print_name else i2.common_name end as "EntryByFacilityMethodNameTH" --Edit 2026-03-04 >> เน€เธ�เธดเน�เธก EntryByFacilityMethodCode, EntryByFacilityMethodNameTH, EntryByFacilityMethodNameEN
		, i2.common_name as "EntryByFacilityMethodNameEN" --Edit 2026-03-04 >> เน€เธ�เธดเน�เธก EntryByFacilityMethodCode, EntryByFacilityMethodNameTH, EntryByFacilityMethodNameEN
		,'' as "Checkup"
		, case when i.fix_item_type_id = '10' then '1' else '0' end as "FlagDF"
		, i.base_order_category_id as "ActivityCategoryCode"
		, boc.description as "ActivityCategoryNameTH"
		, boc.description as "ActivityCategoryNameEN"
		, di.icd10_code as "PrimaryDiagnosisCode"	--Edit 2026-03-04 >> เน€เธ�เธดเน�เธก Diagnosis
		, di.icd10_description as "PrimaryDiagnosisNameTH"	--Edit 2026-03-04 >> เน€เธ�เธดเน�เธก Diagnosis	
		, di.icd10_description as "PrimaryDiagnosisNameEN"	--Edit 2026-03-04 >> เน€เธ�เธดเน�เธก Diagnosis	
from 	order_item oi 
		inner join visit v on oi.visit_id = v.visit_id 
		inner join item i on oi.item_id = i.item_id 
		inner join plan p on oi.plan_id = p.plan_id
		inner join base_service_point bsp on oi.verify_spid = bsp.base_service_point_id
		left join attending_physician ap on oi.visit_id = ap.visit_id and bsp.base_department_id = ap.base_department_id and oi.order_doctor_eid = ap.employee_id
		left join employee e2 on ap.employee_id = e2.employee_id
		left join base_department bd2 on ap.base_department_id = bd2.base_department_id
		left join base_department bd on bsp.base_department_id = bd.base_department_id 
		left join base_order_sub_category bosc on i.base_order_sub_category_id = bosc.base_order_sub_category_id
		left join base_order_category boc on i.base_order_category_id = boc.base_order_category_id
		left join base_unit bu on oi.base_unit_id = bu.base_unit_id
		left join op_registered op on oi.op_registered_id = op.op_registered_id
		left join employee e on oi.verify_eid = e.employee_id
		left join base_service_point bsp2 on oi.dispense_spid = bsp2.base_service_point_id
		left join stock s on bsp2.stock_id = s.stock_id
		-- *************************************** Setup Dose Med *************************************** 
		left join base_dose_unit bdu on oi.base_dose_unit_id = bdu.base_dose_unit_id 
		left join base_drug_frequency bdf on oi.base_drug_frequency_id = bdf.base_drug_frequency_id 
		left join base_drug_instruction bdi on split_part(oi.base_drug_usage_code,' ', 1) = bdi.base_drug_instruction_id
		left join order_item oi2 on oi.visit_id = oi2.visit_id and oi.set_order_id = oi2.order_item_id
		left join item i2 on oi2.item_id = i2.item_id
		left join lateral 
		(
			select  di.icd10_code 
					, di.icd10_description 
			from 	diagnosis_icd10 di 
			where 	di.visit_id = oi.visit_id
					and di.fix_diagnosis_type_id = '1'
			order by di.diagnosis_date || di.diagnosis_time asc 
			limit 1
		)di on true
		-- ********************************* กรณี Map ใบยาไม่ได้ *********************************
		left join lateral
		(
			select 	distinct on (ap.visit_id, ap.base_department_id)
					ap.attending_physician_id as "PrescriptionNo"
					, ap.base_department_id as "ClinicCode"
					, bd.description as "ClinicNameTH"
					, '' as "ClinicNameEN"
					, ap.employee_id as "DoctorCode"
					, e.prename || e.firstname || ' ' || e.lastname as "DoctorNameTH"
					, e.intername as "DoctorNameEN"
			from 	attending_physician ap 
					inner join employee e on ap.employee_id = e.employee_id
					inner join base_department bd on ap.base_department_id = bd.base_department_id
			where 	ap.visit_id = oi.visit_id
					and ap.employee_id = oi.order_doctor_eid
			limit 1
		)ap2 on TRUE
		left join lateral
		(
			select 	distinct on (ap.visit_id, ap.base_department_id)
					ap.attending_physician_id as "PrescriptionNo"
					, ap.base_department_id as "ClinicCode"
					, bd.description as "ClinicNameTH"
					, '' as "ClinicNameEN"
					, ap.employee_id as "DoctorCode"
					, e.prename || e.firstname || ' ' || e.lastname as "DoctorNameTH"
					, e.intername as "DoctorNameEN"
			from 	attending_physician ap 
					inner join employee e on ap.employee_id = e.employee_id
					inner join base_department bd on ap.base_department_id = bd.base_department_id
			where 	ap.visit_id = oi.visit_id
--					and ap.employee_id = oi.order_doctor_eid
					and ap.priority = '1' 
			limit 1
		)ap3 on true
		, base_site bs
where 	1=1
		and oi.verify_date = (current_date -1)::text
		and oi.fix_set_type_id != '1'
		and v.fix_visit_type_id = '0'
		and oi.order_doctor_eid != ''
union all 
-- ***************************************************** Non Doctor Order  *****************************************************
select 	bs.site_code as "BU"
		, oi.order_item_id as "OrderID"
		, oi.patient_id as "PatientID"
		, oi.visit_id as "VisitID"
		, v.visit_date || ' ' || v.visit_time as "VisitDate"
		, format_vn(v.vn) as "VN"
		, coalesce(ap2."PrescriptionNo",ap.attending_physician_id) as "PrescriptionNo"
		, coalesce(ap2."ClinicCode", ap.base_department_id) as "ClinicCode"
		, coalesce(ap2."ClinicNameTH", bd2.description) as "ClinicNameTH"
		, '' as "ClinicNameEN"
		, coalesce(ap2."DoctorCode", ap.employee_id) as "DoctorCode"
		, coalesce(ap2."DoctorNameTH", e2.prename || e2.firstname || ' ' || e2.firstname) as "DoctorNameTH"
		, coalesce(ap2."DoctorNameEN", e2.intername) as "DoctorNameEN"
		, oi.verify_date || ' ' || oi.verify_time as "MakeDateTime"
		, case 
		  when oi.fix_item_type_id = '0' then 'Medicine'
		  when oi.fix_item_type_id = '1' then 'Lab'
		  when oi.fix_item_type_id = '2' then 'Xray'
		  WHEN oi.fix_item_type_id = '3' and i.base_order_category_id in ('05STK', '27', '28', '29', '37', 'HEAR') then 'Usage' --PLD
		  WHEN oi.fix_item_type_id = '3' and i.base_category_group_id = '01' and i.item_code not like 'MEDC%' then 'Medicine' --PLD
		  WHEN oi.fix_item_type_id = '3' AND  i.fix_set_type_id != '1' and i.item_code  LIKE ANY (ARRAY['%X', '%N']) AND i.base_category_group_id = '004' THEN 'Usage' --PLR
		  WHEN oi.fix_item_type_id = '3' AND  i.fix_set_type_id != '1' and i.item_code  LIKE ANY (ARRAY['%X', '%N']) AND i.base_category_group_id = '003' then 'Medicine' --PLR
		  when oi.fix_item_type_id = '3' THEN 'ServiceCharge'
		  when oi.fix_item_type_id = '4' then 'Usage'
		  when oi.fix_item_type_id = '6' then 'Dental'
		  when oi.fix_item_type_id = '7' then 'Treatment'
		  when oi.fix_item_type_id = '8' then 'Food'
		  when oi.fix_item_type_id = '10' then 'Treatment'
		  when oi.fix_item_type_id = '11' then 'BloodBank'
	      end as "ItemType"
	    , i.item_code as "ItemCode"
	    , case when i.print_name != '' then i.print_name else i.common_name end as "ItemNameTH"
	    , i.common_name as "ItemNameEN"
	    , oi.base_order_sub_category_id as "ActivityCode"
	    , bosc.description as "ActivityNameTH"
	    , '' as "ActivityNameEN"
	    , oi.base_unit_id as "UnitCode"
	    , bu.description_th as "UnitNameTH"
	    , bu.description_en as "UnitNameEN"
	    , oi.quantity as "QTY"
	    , case when oi.fix_set_type_id = '0' 
	      then oi.unit_price_sale 
	      else oi.original_unit_price end as "UnitPrice"
	    , case when oi.fix_set_type_id = '0' 
	      then oi.unit_price_sale::decimal * oi.quantity::decimal 
	      else oi.original_unit_price::decimal * oi.quantity::decimal  end as "ChargeAmt"
	    , case when oi.fix_order_status_id = '5' then 'Return' else 'Charge' end as "ChargeType"
	    , oi.verify_date as "ChargeDateTime"
	    , case when oi.op_registered_id != '' then 'OR'
	      when oi.base_lab_type_id != '' then oi.base_lab_type_id
	      when oi.base_xray_type_id != '' then oi.base_xray_type_id
	      else '' end as "EntryByFacility"
	    , case when oi.op_registered_id != '' then op.or_number
	      else oi.assigned_ref_no end as "RefNo"
	    , oi.verify_eid as "EntryByUserCode"
	    , e.prename || e.firstname || ' ' || e.lastname as "EntryByUserNameTH"
	    , e.intername as "EntryByUserNameEN"
	    , '' as "CancelByUserCode"
	    , '' as "CancelByUserNameTH"
	    , '' as "CancelByUserNameEN"
	    , '' as "CancelDateTime"
	    , '' as "TreatmentDateTimeFrom"
	    , '' as "TreatmentDateTimeTo"
	    , oi.doctor_fee_eid as "DFDoctor"
	    , p.plan_code as "RightCode"
	    , p.description as "RightNameTH"
	    , p.description as "RightNameEN"
	    , s.stock_id as "StoreCode"
	    , s.stock_name as "StoreNameTH"
	    , s.stock_name as "StoreNameEN"
	    , '' as "DoseTypeCode"
		, '' as "DoseTypeNameTH"
		, '' as "DoseTypeNameEN"
		, oi.base_drug_usage_code as "DoseCode"
		, '' as "DoseNameTH"
		, '' as "DoseNameEN"
		, oi.dose_quantity as "DoseQTYCode"
		, '' as "DoseQTYNameTH"
		, '' as "DoseQTYNameEN"
		, oi.base_dose_unit_id as "DoseUnitCode"
		, bdu.description_th as "DoseUnitNameTH"
		, bdu.description_en as "DoseUnitNameEN"
		, oi.base_drug_frequency_id as "DoseFreqCode"
		, bdf.description_th as "DoseFreqNameTH"
		, bdf.description_en as "DoseFreqNameEN"
		, '' as "AuxLabel1Code"
		, oi.description as "AuxLabel1NameTH"
		, '' as "AuxLabel1NameEN"
		, '' as "AuxLabel2Code"
		, i.caution as "AuxLabel2NameTH"
		, '' as "AuxLabel2NameEN"
		, '' as "AuxLabel3Code"
		, '' as "AuxLabel3NameTH"
		, '' as "AuxLabel3NameEN"
		, oi.instruction_text_line1 ||' '|| oi.instruction_text_line2||' '|| oi.instruction_text_line3  as "DoseMemo"
		, i2.item_code as "EntryByFacilityMethodCode" --Edit 2026-03-04 >> เน€เธ�เธดเน�เธก EntryByFacilityMethodCode, EntryByFacilityMethodNameTH, EntryByFacilityMethodNameEN
		, case when i2.print_name != '' then i2.print_name else i2.common_name end as "EntryByFacilityMethodNameTH" --Edit 2026-03-04 >> เน€เธ�เธดเน�เธก EntryByFacilityMethodCode, EntryByFacilityMethodNameTH, EntryByFacilityMethodNameEN
		, i2.common_name as "EntryByFacilityMethodNameEN" --Edit 2026-03-04 >> เน€เธ�เธดเน�เธก EntryByFacilityMethodCode, EntryByFacilityMethodNameTH, EntryByFacilityMethodNameEN
		,'' as "Checkup"
		, case when i.fix_item_type_id = '10' then '1' else '0' end as "FlagDF"
		, i.base_order_category_id as "ActivityCategoryCode"
		, boc.description as "ActivityCategoryNameTH"
		, boc.description as "ActivityCategoryNameEN"
		, di.icd10_code as "PrimaryDiagnosisCode"	--Edit 2026-03-04 >> เน€เธ�เธดเน�เธก Diagnosis
		, di.icd10_description as "PrimaryDiagnosisNameTH"	--Edit 2026-03-04 >> เน€เธ�เธดเน�เธก Diagnosis	
		, di.icd10_description as "PrimaryDiagnosisNameEN"	--Edit 2026-03-04 >> เน€เธ�เธดเน�เธก Diagnosis	
from 	order_item oi 
		inner join visit v on oi.visit_id = v.visit_id 
		inner join item i on oi.item_id = i.item_id 
		inner join plan p on oi.plan_id = p.plan_id
		inner join base_service_point bsp on oi.verify_spid = bsp.base_service_point_id
		left join attending_physician ap on oi.visit_id = ap.visit_id and ap.priority = '1'
		left join employee e2 on ap.employee_id = e2.employee_id
		left join base_department bd2 on ap.base_department_id = bd2.base_department_id
		left join base_department bd on bsp.base_department_id = bd.base_department_id 
		left join base_order_sub_category bosc on i.base_order_sub_category_id = bosc.base_order_sub_category_id
		left join base_order_category boc on i.base_order_category_id = boc.base_order_category_id
		left join base_unit bu on oi.base_unit_id = bu.base_unit_id
		left join op_registered op on oi.op_registered_id = op.op_registered_id
		left join employee e on oi.verify_eid = e.employee_id
		left join base_service_point bsp2 on oi.dispense_spid = bsp2.base_service_point_id
		left join stock s on bsp2.stock_id = s.stock_id
		-- *************************************** Setup Dose Med *************************************** 
		left join base_dose_unit bdu on oi.base_dose_unit_id = bdu.base_dose_unit_id 
		left join base_drug_frequency bdf on oi.base_drug_frequency_id = bdf.base_drug_frequency_id 
		left join base_drug_instruction bdi on split_part(oi.base_drug_usage_code,' ', 1) = bdi.base_drug_instruction_id
		left join order_item oi2 on oi.visit_id = oi2.visit_id and oi.set_order_id = oi2.order_item_id
		left join item i2 on oi2.item_id = i2.item_id
		left join lateral 
		(
			select  di.icd10_code 
					, di.icd10_description 
			from 	diagnosis_icd10 di 
			where 	di.visit_id = oi.visit_id
					and di.fix_diagnosis_type_id = '1'
			order by di.diagnosis_date || di.diagnosis_time asc 
			limit 1
		)di on true
		left join lateral
		(
			select 	distinct on (ap.visit_id, ap.base_department_id)
					ap.attending_physician_id as "PrescriptionNo"
					, ap.base_department_id as "ClinicCode"
					, bd.description as "ClinicNameTH"
					, '' as "ClinicNameEN"
					, ap.employee_id as "DoctorCode"
					, e.prename || e.firstname || ' ' || e.firstname as "DoctorNameTH"
					, e.intername as "DoctorNameEN"
			from 	attending_physician ap 
					inner join employee e on ap.employee_id = e.employee_id
					inner join base_department bd on ap.base_department_id = bd.base_department_id
			where 	ap.visit_id = oi.visit_id
					and ap.base_department_id = bsp.base_department_id
			limit 1
		)ap2 on true
		, base_site bs
where 	1=1
		and oi.verify_date = (current_date -1)::text
		and oi.fix_set_type_id != '1'
		and v.fix_visit_type_id = '0'
		and oi.order_doctor_eid = ''
union all 
-- ***************************************************** Cancel Doctor Order  *****************************************************
select 	bs.site_code as "BU"
		, toi.order_item_id as "OrderID"
		, toi.patient_id as "PatientID"
		, toi.visit_id as "VisitID"
		, v.visit_date || ' ' || v.visit_time as "VisitDate"
		, format_vn(v.vn) as "VN"
		, coalesce(ap.attending_physician_id, ap2."PrescriptionNo") as "PrescriptionNo"
		, coalesce(ap.base_department_id, ap2."ClinicCode") as "ClinicCode"
		, coalesce(bd2.description, ap2."ClinicNameTH") as "ClinicNameTH"
		, '' as "ClinicNameEN"
		, coalesce(ap.employee_id, ap2."DoctorCode") as "DoctorCode"
		, coalesce(e2.prename || e2.firstname || ' ' || e2.firstname, ap2."DoctorNameTH") as "DoctorNameTH"
		, coalesce(e2.intername, ap2."DoctorNameEN") as "DoctorNameEN"
		, toi.verify_date || ' ' || toi.verify_time as "MakeDateTime"
		, case 
		  when toi.fix_item_type_id = '0' then 'Medicine'
		  when toi.fix_item_type_id = '1' then 'Lab'
		  when toi.fix_item_type_id = '2' then 'Xray'
		  WHEN toi.fix_item_type_id = '3' and i.base_order_category_id in ('05STK', '27', '28', '29', '37', 'HEAR') then 'Usage' --PLD
		  WHEN toi.fix_item_type_id = '3' and i.base_category_group_id = '01' and i.item_code not like 'MEDC%' then 'Medicine' --PLD
		  WHEN toi.fix_item_type_id = '3' AND  i.fix_set_type_id != '1' and i.item_code  LIKE ANY (ARRAY['%X', '%N']) AND i.base_category_group_id = '004' THEN 'Usage' --PLR
		  WHEN toi.fix_item_type_id = '3' AND  i.fix_set_type_id != '1' and i.item_code  LIKE ANY (ARRAY['%X', '%N']) AND i.base_category_group_id = '003' then 'Medicine' --PLR
		  when toi.fix_item_type_id = '3' THEN 'ServiceCharge'
		  when toi.fix_item_type_id = '4' then 'Usage'
		  when toi.fix_item_type_id = '6' then 'Dental'
		  when toi.fix_item_type_id = '7' then 'Treatment'
		  when toi.fix_item_type_id = '8' then 'Food'
		  when toi.fix_item_type_id = '10' then 'Treatment'
		  when toi.fix_item_type_id = '11' then 'BloodBank'
	      end as "ItemType"
	    , i.item_code as "ItemCode"
	    , case when i.print_name != '' then i.print_name else i.common_name end as "ItemNameTH"
	    , i.common_name as "ItemNameEN"
	    , toi.base_order_sub_category_id as "ActivityCode"
	    , bosc.description as "ActivityNameTH"
	    , '' as "ActivityNameEN"
	    , toi.base_unit_id as "UnitCode"
	    , bu.description_th as "UnitNameTH"
	    , bu.description_en as "UnitNameEN"
	    , toi.quantity as "QTY"
	    , case when toi.fix_set_type_id = '0' 
	      then toi.unit_price_sale 
	      else toi.original_unit_price end as "UnitPrice"
	    , case when toi.fix_set_type_id = '0' 
	      then toi.unit_price_sale::decimal * toi.quantity::decimal 
	      else toi.original_unit_price::decimal * toi.quantity::decimal  end as "ChargeAmt"
	    , case when toi.fix_order_status_id = '5' then 'Return' else 'Charge' end as "ChargeType"
	    , toi.verify_date as "ChargeDateTime"
	    , case when toi.op_registered_id != '' then 'OR'
	      when toi.base_lab_type_id != '' then toi.base_lab_type_id
	      when toi.base_xray_type_id != '' then toi.base_xray_type_id
	      else '' end as "EntryByFacility"
	    , case when toi.op_registered_id != '' then op.or_number
	      else toi.assigned_ref_no end as "RefNo"
	    , toi.verify_eid as "EntryByUserCode"
	    , e.prename || e.firstname || ' ' || e.lastname as "EntryByUserNameTH"
	    , e.intername as "EntryByUserNameEN"
	    , toi.track_actor as "CancelByUserCode"
	    , e3.prename || e3.firstname || ' ' || e3.firstname as "CancelByUserNameTH"
	    , e3.intername as "CancelByUserNameEN"
	    , toi.track_date || ' ' || toi.track_time as "CancelDateTime"
	    , '' as "TreatmentDateTimeFrom"
	    , '' as "TreatmentDateTimeTo"
	    , toi.doctor_fee_eid as "DFDoctor"
	    , p.plan_code as "RightCode"
	    , p.description as "RightNameTH"
	    , p.description as "RightNameEN"
	    , s.stock_id as "StoreCode"
	    , s.stock_name as "StoreNameTH"
	    , s.stock_name as "StoreNameEN"
	    , '' as "DoseTypeCode"
		, '' as "DoseTypeNameTH"
		, '' as "DoseTypeNameEN"
		, toi.base_drug_usage_code as "DoseCode"
		, '' as "DoseNameTH"
		, '' as "DoseNameEN"
		, toi.dose_quantity as "DoseQTYCode"
		, '' as "DoseQTYNameTH"
		, '' as "DoseQTYNameEN"
		, toi.base_dose_unit_id as "DoseUnitCode"
		, bdu.description_th as "DoseUnitNameTH"
		, bdu.description_en as "DoseUnitNameEN"
		, toi.base_drug_frequency_id as "DoseFreqCode"
		, bdf.description_th as "DoseFreqNameTH"
		, bdf.description_en as "DoseFreqNameEN"
		, '' as "AuxLabel1Code"
		, toi.description as "AuxLabel1NameTH"
		, '' as "AuxLabel1NameEN"
		, '' as "AuxLabel2Code"
		, i.caution as "AuxLabel2NameTH"
		, '' as "AuxLabel2NameEN"
		, '' as "AuxLabel3Code"
		, '' as "AuxLabel3NameTH"
		, '' as "AuxLabel3NameEN"
		, toi.instruction_text_line1 ||' '|| toi.instruction_text_line2||' '|| toi.instruction_text_line3  as "DoseMemo"
		, i2.item_code as "EntryByFacilityMethodCode" --Edit 2026-03-04 >> เน€เธ�เธดเน�เธก EntryByFacilityMethodCode, EntryByFacilityMethodNameTH, EntryByFacilityMethodNameEN
		, case when i2.print_name != '' then i2.print_name else i2.common_name end as "EntryByFacilityMethodNameTH" --Edit 2026-03-04 >> เน€เธ�เธดเน�เธก EntryByFacilityMethodCode, EntryByFacilityMethodNameTH, EntryByFacilityMethodNameEN
		, i2.common_name as "EntryByFacilityMethodNameEN" --Edit 2026-03-04 >> เน€เธ�เธดเน�เธก EntryByFacilityMethodCode, EntryByFacilityMethodNameTH, EntryByFacilityMethodNameEN
		,'' as "Checkup"
		, case when i.fix_item_type_id = '10' then '1' else '0' end as "FlagDF"
		, i.base_order_category_id as "ActivityCategoryCode"
		, boc.description as "ActivityCategoryNameTH"
		, boc.description as "ActivityCategoryNameEN"
		, di.icd10_code as "PrimaryDiagnosisCode"	--Edit 2026-03-04 >> เน€เธ�เธดเน�เธก Diagnosis
		, di.icd10_description as "PrimaryDiagnosisNameTH"	--Edit 2026-03-04 >> เน€เธ�เธดเน�เธก Diagnosis	
		, di.icd10_description as "PrimaryDiagnosisNameEN"	--Edit 2026-03-04 >> เน€เธ�เธดเน�เธก Diagnosis	
from 	track_order_item toi 
		inner join visit v on toi.visit_id = v.visit_id 
		inner join item i on toi.item_id = i.item_id 
		inner join plan p on toi.plan_id = p.plan_id
		inner join base_service_point bsp on toi.verify_spid = bsp.base_service_point_id
		left join attending_physician ap on toi.visit_id = ap.visit_id and bsp.base_department_id = ap.base_department_id and toi.order_doctor_eid = ap.employee_id
		left join base_department bd2 on ap.base_department_id = bd2.base_department_id
		left join base_department bd on bsp.base_department_id = bd.base_department_id 
		left join base_order_sub_category bosc on i.base_order_sub_category_id = bosc.base_order_sub_category_id
		left join base_order_category boc on i.base_order_category_id = boc.base_order_category_id
		left join base_unit bu on toi.base_unit_id = bu.base_unit_id
		left join op_registered op on toi.op_registered_id = op.op_registered_id
		left join employee e on toi.verify_eid = e.employee_id
		left join employee e2 on ap.employee_id = e2.employee_id
		left join employee e3 on toi.track_actor = e3.employee_id
		left join base_service_point bsp2 on toi.dispense_spid = bsp2.base_service_point_id
		left join stock s on bsp2.stock_id = s.stock_id
		-- *************************************** Setup Dose Med *************************************** 
		left join base_dose_unit bdu on toi.base_dose_unit_id = bdu.base_dose_unit_id 
		left join base_drug_frequency bdf on toi.base_drug_frequency_id = bdf.base_drug_frequency_id 
		left join base_drug_instruction bdi on split_part(toi.base_drug_usage_code,' ', 1) = bdi.base_drug_instruction_id
		left join order_item oi2 on toi.visit_id = oi2.visit_id and toi.set_order_id = oi2.order_item_id
		left join item i2 on oi2.item_id = i2.item_id
		left join lateral 
		(
			select  di.icd10_code 
					, di.icd10_description 
			from 	diagnosis_icd10 di 
			where 	di.visit_id = toi.visit_id
					and di.fix_diagnosis_type_id = '1'
			order by di.diagnosis_date || di.diagnosis_time asc 
			limit 1
		)di on true
		-- ********************************* กรณี Map ใบยาไม่ได้ *********************************
		left join lateral
		(
			select 	distinct on (ap.visit_id, ap.base_department_id)
					ap.attending_physician_id as "PrescriptionNo"
					, ap.base_department_id as "ClinicCode"
					, bd.description as "ClinicNameTH"
					, '' as "ClinicNameEN"
					, ap.employee_id as "DoctorCode"
					, e.prename || e.firstname || ' ' || e.firstname as "DoctorNameTH"
					, e.intername as "DoctorNameEN"
			from 	attending_physician ap 
					inner join employee e on ap.employee_id = e.employee_id
					inner join base_department bd on ap.base_department_id = bd.base_department_id
			where 	ap.visit_id = toi.visit_id
					and ap.employee_id = toi.order_doctor_eid
			limit 1
		)ap2 on true
		, base_site bs
where 	1=1
		and toi.track_date = (current_date -1)::text
		and toi.fix_set_type_id != '1'
		and v.fix_visit_type_id = '0'
		and toi.order_doctor_eid != ''
union all 
-- ***************************************************** Cancel Non Doctor Order  *****************************************************
select 	bs.site_code as "BU"
		, toi.order_item_id as "OrderID"
		, toi.patient_id as "PatientID"
		, toi.visit_id as "VisitID"
		, v.visit_date || ' ' || v.visit_time as "VisitDate"
		, format_vn(v.vn) as "VN"
		, coalesce(ap2."PrescriptionNo",ap.attending_physician_id) as "PrescriptionNo"
		, coalesce(ap2."ClinicCode", ap.base_department_id) as "ClinicCode"
		, coalesce(ap2."ClinicNameTH", bd2.description) as "ClinicNameTH"
		, '' as "ClinicNameEN"
		, coalesce(ap2."DoctorCode", ap.employee_id) as "DoctorCode"
		, coalesce(ap2."DoctorNameTH", e2.prename || e2.firstname || ' ' || e2.firstname) as "DoctorNameTH"
		, coalesce(ap2."DoctorNameEN", e2.intername) as "DoctorNameEN"
		, toi.verify_date || ' ' || toi.verify_time as "MakeDateTime"
		, case 
		  when toi.fix_item_type_id = '0' then 'Medicine'
		  when toi.fix_item_type_id = '1' then 'Lab'
		  when toi.fix_item_type_id = '2' then 'Xray'
		  WHEN toi.fix_item_type_id = '3' and i.base_order_category_id in ('05STK', '27', '28', '29', '37', 'HEAR') then 'Usage' --PLD
		  WHEN toi.fix_item_type_id = '3' and i.base_category_group_id = '01' and i.item_code not like 'MEDC%' then 'Medicine' --PLD
		  WHEN toi.fix_item_type_id = '3' AND  i.fix_set_type_id != '1' and i.item_code  LIKE ANY (ARRAY['%X', '%N']) AND i.base_category_group_id = '004' THEN 'Usage' --PLR
		  WHEN toi.fix_item_type_id = '3' AND  i.fix_set_type_id != '1' and i.item_code  LIKE ANY (ARRAY['%X', '%N']) AND i.base_category_group_id = '003' then 'Medicine' --PLR
		  when toi.fix_item_type_id = '3' THEN 'ServiceCharge'
		  when toi.fix_item_type_id = '4' then 'Usage'
		  when toi.fix_item_type_id = '6' then 'Dental'
		  when toi.fix_item_type_id = '7' then 'Treatment'
		  when toi.fix_item_type_id = '8' then 'Food'
		  when toi.fix_item_type_id = '10' then 'Treatment'
		  when toi.fix_item_type_id = '11' then 'BloodBank'
	      end as "ItemType"
	    , i.item_code as "ItemCode"
	    , case when i.print_name != '' then i.print_name else i.common_name end as "ItemNameTH"
	    , i.common_name as "ItemNameEN"
	    , toi.base_order_sub_category_id as "ActivityCode"
	    , bosc.description as "ActivityNameTH"
	    , '' as "ActivityNameEN"
	    , toi.base_unit_id as "UnitCode"
	    , bu.description_th as "UnitNameTH"
	    , bu.description_en as "UnitNameEN"
	    , toi.quantity as "QTY"
	    , case when toi.fix_set_type_id = '0' 
	      then toi.unit_price_sale 
	      else toi.original_unit_price end as "UnitPrice"
	    , case when toi.fix_set_type_id = '0' 
	      then toi.unit_price_sale::decimal * toi.quantity::decimal 
	      else toi.original_unit_price::decimal * toi.quantity::decimal  end as "ChargeAmt"
	    , case when toi.fix_order_status_id = '5' then 'Return' else 'Charge' end as "ChargeType"
	    , toi.verify_date as "ChargeDateTime"
	    , case when toi.op_registered_id != '' then 'OR'
	      when toi.base_lab_type_id != '' then toi.base_lab_type_id
	      when toi.base_xray_type_id != '' then toi.base_xray_type_id
	      else '' end as "EntryByFacility"
	    , case when toi.op_registered_id != '' then op.or_number
	      else toi.assigned_ref_no end as "RefNo"
	    , toi.verify_eid as "EntryByUserCode"
	    , e.prename || e.firstname || ' ' || e.lastname as "EntryByUserNameTH"
	    , e.intername as "EntryByUserNameEN"
	    , toi.track_actor as "CancelByUserCode"
	    , e3.prename || e3.firstname || ' ' || e3.firstname as "CancelByUserNameTH"
	    , e3.intername as "CancelByUserNameEN"
	    , toi.track_date || ' ' || toi.track_time as "CancelDateTime"
	    , '' as "TreatmentDateTimeFrom"
	    , '' as "TreatmentDateTimeTo"
	    , toi.doctor_fee_eid as "DFDoctor"
	    , p.plan_code as "RightCode"
	    , p.description as "RightNameTH"
	    , p.description as "RightNameEN"
	    , s.stock_id as "StoreCode"
	    , s.stock_name as "StoreNameTH"
	    , s.stock_name as "StoreNameEN"
	    , '' as "DoseTypeCode"
		, '' as "DoseTypeNameTH"
		, '' as "DoseTypeNameEN"
		, toi.base_drug_usage_code as "DoseCode"
		, '' as "DoseNameTH"
		, '' as "DoseNameEN"
		, toi.dose_quantity as "DoseQTYCode"
		, '' as "DoseQTYNameTH"
		, '' as "DoseQTYNameEN"
		, toi.base_dose_unit_id as "DoseUnitCode"
		, bdu.description_th as "DoseUnitNameTH"
		, bdu.description_en as "DoseUnitNameEN"
		, toi.base_drug_frequency_id as "DoseFreqCode"
		, bdf.description_th as "DoseFreqNameTH"
		, bdf.description_en as "DoseFreqNameEN"
		, '' as "AuxLabel1Code"
		, toi.description as "AuxLabel1NameTH"
		, '' as "AuxLabel1NameEN"
		, '' as "AuxLabel2Code"
		, i.caution as "AuxLabel2NameTH"
		, '' as "AuxLabel2NameEN"
		, '' as "AuxLabel3Code"
		, '' as "AuxLabel3NameTH"
		, '' as "AuxLabel3NameEN"
		, toi.instruction_text_line1 ||' '|| toi.instruction_text_line2||' '|| toi.instruction_text_line3  as "DoseMemo"
		, i2.item_code as "EntryByFacilityMethodCode" --Edit 2026-03-04 >> เน€เธ�เธดเน�เธก EntryByFacilityMethodCode, EntryByFacilityMethodNameTH, EntryByFacilityMethodNameEN
		, case when i2.print_name != '' then i2.print_name else i2.common_name end as "EntryByFacilityMethodNameTH" --Edit 2026-03-04 >> เน€เธ�เธดเน�เธก EntryByFacilityMethodCode, EntryByFacilityMethodNameTH, EntryByFacilityMethodNameEN
		, i2.common_name as "EntryByFacilityMethodNameEN" --Edit 2026-03-04 >> เน€เธ�เธดเน�เธก EntryByFacilityMethodCode, EntryByFacilityMethodNameTH, EntryByFacilityMethodNameEN
		,'' as "Checkup"
		, case when i.fix_item_type_id = '10' then '1' else '0' end as "FlagDF"
		, i.base_order_category_id as "ActivityCategoryCode"
		, boc.description as "ActivityCategoryNameTH"
		, boc.description as "ActivityCategoryNameEN"
		, di.icd10_code as "PrimaryDiagnosisCode"	--Edit 2026-03-04 >> เน€เธ�เธดเน�เธก Diagnosis
		, di.icd10_description as "PrimaryDiagnosisNameTH"	--Edit 2026-03-04 >> เน€เธ�เธดเน�เธก Diagnosis	
		, di.icd10_description as "PrimaryDiagnosisNameEN"	--Edit 2026-03-04 >> เน€เธ�เธดเน�เธก Diagnosis	
from 	track_order_item toi 
		inner join visit v on toi.visit_id = v.visit_id 
		inner join item i on toi.item_id = i.item_id 
		inner join plan p on toi.plan_id = p.plan_id
		inner join base_service_point bsp on toi.verify_spid = bsp.base_service_point_id
		left join attending_physician ap on toi.visit_id = ap.visit_id and ap.priority = '1'
		left join base_department bd2 on ap.base_department_id = bd2.base_department_id
		left join base_department bd on bsp.base_department_id = bd.base_department_id 
		left join base_order_sub_category bosc on i.base_order_sub_category_id = bosc.base_order_sub_category_id
		left join base_order_category boc on i.base_order_category_id = boc.base_order_category_id
		left join base_unit bu on toi.base_unit_id = bu.base_unit_id
		left join op_registered op on toi.op_registered_id = op.op_registered_id
		left join employee e on toi.verify_eid = e.employee_id
		left join employee e2 on ap.employee_id = e2.employee_id
		left join employee e3 on toi.track_actor = e3.employee_id
		left join base_service_point bsp2 on toi.dispense_spid = bsp2.base_service_point_id
		left join stock s on bsp2.stock_id = s.stock_id
		-- *************************************** Setup Dose Med *************************************** 
		left join base_dose_unit bdu on toi.base_dose_unit_id = bdu.base_dose_unit_id 
		left join base_drug_frequency bdf on toi.base_drug_frequency_id = bdf.base_drug_frequency_id 
		left join base_drug_instruction bdi on split_part(toi.base_drug_usage_code,' ', 1) = bdi.base_drug_instruction_id
		left join order_item oi2 on toi.visit_id = oi2.visit_id and toi.set_order_id = oi2.order_item_id
		left join item i2 on oi2.item_id = i2.item_id
		left join lateral 
		(
			select  di.icd10_code 
					, di.icd10_description 
			from 	diagnosis_icd10 di 
			where 	di.visit_id = toi.visit_id
					and di.fix_diagnosis_type_id = '1'
			order by di.diagnosis_date || di.diagnosis_time asc 
			limit 1
		)di on true
		left join lateral
		(
			select 	distinct on (ap.visit_id, ap.base_department_id)
					ap.attending_physician_id as "PrescriptionNo"
					, ap.base_department_id as "ClinicCode"
					, bd.description as "ClinicNameTH"
					, '' as "ClinicNameEN"
					, ap.employee_id as "DoctorCode"
					, e.prename || e.firstname || ' ' || e.firstname as "DoctorNameTH"
					, e.intername as "DoctorNameEN"
			from 	attending_physician ap 
					inner join employee e on ap.employee_id = e.employee_id
					inner join base_department bd on ap.base_department_id = bd.base_department_id
			where 	ap.visit_id = toi.visit_id
					and ap.base_department_id = bsp.base_department_id
			limit 1
		)ap2 on true
		, base_site bs
where 	1=1
		and toi.track_date = (current_date -1)::text
		and toi.fix_set_type_id != '1'
		and v.fix_visit_type_id = '0'
		and toi.order_doctor_eid = ''