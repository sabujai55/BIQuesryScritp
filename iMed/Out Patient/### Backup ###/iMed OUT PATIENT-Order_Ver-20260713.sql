select 	oi.*
from 
(
select 	bs.site_code as "BU"
		, oi.order_item_id as "OrderID"
		, oi.patient_id as "PatientID"
		, oi.visit_id as "VisitID"
		, v.visit_date || ' ' || v.visit_time as "VisitDate"
		, format_vn(v.vn) as "VN"
		, coalesce(oid.attending_physician_id , oidep.attending_physician_id, oip.attending_physician_id ) as "PrescriptionNo"
		, coalesce(oid.employee_id , oidep.employee_id, oip.employee_id ) as "DoctorCode"
		, coalesce(oid.base_department_id , oidep.base_department_id, oip.base_department_id ) as "ClinicCode"
		, coalesce(oid.department_name , oidep.department_name, oip.department_name ) as "ClinicName"
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
		left join base_service_point bsp on oi.verify_spid = bsp.base_service_point_id
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
			select 	ap.attending_physician_id 
					, ap.employee_id 
					, ap.base_department_id 
					, bd2.description as department_name
			from 	attending_physician ap 
					inner join base_department bd2 on ap.base_department_id = bd2.base_department_id 
			where 	ap.visit_id = oi.visit_id 
					and ap.base_department_id = bsp.base_department_id 
					and ap.employee_id = oi.order_doctor_eid 
		)oid on true
		left join lateral 
		(
			select 	ap.attending_physician_id 
					, ap.employee_id 
					, ap.base_department_id 
					, bd2.description as department_name
			from 	attending_physician ap 
					inner join base_department bd2 on ap.base_department_id = bd2.base_department_id 
			where 	ap.visit_id = oi.visit_id 
					and ap.base_department_id = bsp.base_department_id 
		)oidep on true
		left join lateral 
		(
			select 	ap.attending_physician_id 
					, ap.employee_id 
					, ap.base_department_id
					, bd2.description as department_name
			from 	attending_physician ap 
					inner join base_department bd2 on ap.base_department_id = bd2.base_department_id 
			where 	ap.visit_id = oi.visit_id 
					and ap.priority = '1'
		)oip on true
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
		, base_site bs 
where 	1=1
		and oi.verify_date = (current_date -1)::text
		and oi.fix_set_type_id != '1'
union all 
select 	bs.site_code as "BU"
		, oi.order_item_id as "OrderID"
		, oi.patient_id as "PatientID"
		, oi.visit_id as "VisitID"
		, v.visit_date || ' ' || v.visit_time as "VisitDate"
		, format_vn(v.vn) as "VN"
		, coalesce(oid.attending_physician_id , oidep.attending_physician_id, oip.attending_physician_id ) as "PrescriptionNo"
		, coalesce(oid.employee_id , oidep.employee_id, oip.employee_id ) as "DoctorCode"
		, coalesce(oid.base_department_id , oidep.base_department_id, oip.base_department_id ) as "ClinicCode"
		, coalesce(oid.department_name , oidep.department_name, oip.department_name ) as "ClinicName"
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
	    , oi.track_actor as "CancelByUserCode"
	    , e2.prename || e2.firstname || ' ' || e2.lastname as "CancelByUserNameTH"
	    , e2.intername as "CancelByUserNameEN"
	    , oi.track_date || ' ' || oi.track_time as "CancelDateTime"
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
from 	track_order_item oi 
		inner join visit v on oi.visit_id = v.visit_id 
		inner join item i on oi.item_id = i.item_id 
		inner join plan p on oi.plan_id = p.plan_id
		left join base_service_point bsp on oi.verify_spid = bsp.base_service_point_id
		left join base_department bd on bsp.base_department_id = bd.base_department_id 
		left join base_order_sub_category bosc on i.base_order_sub_category_id = bosc.base_order_sub_category_id
		left join base_order_category boc on i.base_order_category_id = boc.base_order_category_id
		left join base_unit bu on oi.base_unit_id = bu.base_unit_id
		left join op_registered op on oi.op_registered_id = op.op_registered_id
		left join employee e on oi.verify_eid = e.employee_id
		left join employee e2 on oi.track_actor = e2.employee_id
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
			select 	ap.attending_physician_id 
					, ap.employee_id 
					, ap.base_department_id 
					, bd2.description as department_name
			from 	attending_physician ap 
					inner join base_department bd2 on ap.base_department_id = bd2.base_department_id 
			where 	ap.visit_id = oi.visit_id 
					and ap.base_department_id = bsp.base_department_id 
					and ap.employee_id = oi.order_doctor_eid 
		)oid on true
		left join lateral 
		(
			select 	ap.attending_physician_id 
					, ap.employee_id 
					, ap.base_department_id 
					, bd2.description as department_name
			from 	attending_physician ap 
					inner join base_department bd2 on ap.base_department_id = bd2.base_department_id 
			where 	ap.visit_id = oi.visit_id 
					and ap.base_department_id = bsp.base_department_id 
		)oidep on true
		left join lateral 
		(
			select 	ap.attending_physician_id 
					, ap.employee_id 
					, ap.base_department_id
					, bd2.description as department_name
			from 	attending_physician ap 
					inner join base_department bd2 on ap.base_department_id = bd2.base_department_id 
			where 	ap.visit_id = oi.visit_id 
					and ap.priority = '1'
		)oip on true
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
		, base_site bs 
where 	1=1
		and oi.verify_date = (current_date -1)::text
		and oi.fix_set_type_id != '1'
)oi
order by oi."VisitID", oi."PrescriptionNo", oi."OrderID"