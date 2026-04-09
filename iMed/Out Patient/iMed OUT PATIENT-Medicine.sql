select 	bs.site_code as "BU"
		, oi.order_item_id as "OrderID"
		, oi.patient_id as "PatientID"
		, oi.visit_id as "VisitID"
		, v.visit_date ||' '|| v.visit_time as "VisitDate"
		, format_vn(v.vn) as "VN"
		, '1' as "PrescriptionNo"
		, oi.verify_date ||' '|| oi.verify_time as "MakeDateTime"
		, s.stock_id as "StoreCode"
		, s.stock_name as "StoreNameTH"
		, s.stock_name as "StoreNameEN"
		, i.item_code as "ItemCode"
		, case when i.print_name != '' then i.print_name else i.common_name end as "ItemNameTH"
		, i.common_name as "ItemNameEN"
		, oi.quantity as "Qty"
		, oi.base_unit_id as "UnitCode"
		, bu.description_th as "UnitNameTH"
		, bu.description_en as "UnitNameEN"
		, oi.unit_price_sale::decimal as "UnitPrice"
		, oi.unit_price_sale::decimal * oi.quantity::decimal as "ChargeAmt"
		, oi.base_order_sub_category_id as "HNActivityCode"
		, bosc.description as "HNActivityNameTH"
		, bosc.description as "HNActivityNameEN"
		, oi.plan_id as "RightCode"
		, p.description as "RightNameTH"
		, null as "RightNameEN"
		, null as "DispendDrugReasonCode"
		, oi.order_drug_allergy_reason_id as "DispendDrugReasonNameTH"
		, null as "DispendDrugReasonNameEN"
--		, doi.base_drug_instruction_id as "DoseTypeCode"
		, split_part(oi.base_drug_usage_code,' ',1) as  "DoseTypeCode"
		, bdi.description_th as "DoseTypeNameTH"
		, bdi.description_en as "DoseTypeNameEN"
		--, oi.base_drug_usage_code
		, split_part(oi.base_drug_usage_code,' ',4) as "DoseCode"
		, null as "DoseNameTH"
		, null as "DoseNameEN"
		, case 
		  when oi.drug_times_per_day != '' then oi.drug_times_per_day::float
		  when split_part(oi.base_drug_usage_code,' ',4) like '%qid%' then 4::float
	      when split_part(oi.base_drug_usage_code,' ',4) like '%tid%' then 3::float
	      when split_part(oi.base_drug_usage_code,' ',4) like '%bid%' then 2::float
	      when split_part(oi.base_drug_usage_code,' ',4) like 'once%' then 1::float
	      when split_part(oi.base_drug_usage_code,' ',4) like 'q' then split_part(oi.base_drug_usage_code,' ',5)::float
		  else null end as "NumberDosePerDay"
		, case 
		  when bdt.base_drug_time_id is not null then (case when split_part(oi.base_drug_usage_code,' ',4) like 'once%' then split_part(oi.base_drug_usage_code,' ',6) else split_part(oi.base_drug_usage_code,' ',5) end) 
		  else null end as "BeforeAfterMealType"
		, bdt.description_th as "BeforeAfterMealTypeName"
		, case 
		  when oi.dose_quantity != '' then oi.dose_quantity
		  when isnumeric(split_part(oi.base_drug_usage_code,' ',2))='1'
		  then split_part(oi.base_drug_usage_code,' ',2) else null end as "DoseQtyCode"
		, case 
		  when oi.dose_quantity != '' then oi.dose_quantity
		  when isnumeric(split_part(oi.base_drug_usage_code,' ',2))='1'
		  then split_part(oi.base_drug_usage_code,' ',2) else null end as "DoseQtyNameTH"
		, null as "DoseQtyNameEN"
		, null as "StatDoseQtyCode"
		, null as "StatDoseQtyNameTH"
		, null as "StatDoseQtyNameEN"
		, case 
--		  when oi.base_dose_unit_id != '' then oi.base_dose_unit_id
		  when bdu.base_dose_unit_id is not null then split_part(oi.base_drug_usage_code,' ',3) 
		  else null end as "DoseUnitCode"
		, bdu.description_th as "DoseUnitNameTH"
		, bdu.description_en as "DoseUnitNameEN"
		, case 
		  when his_func_string_to_date(oi.cal_qty_start_date) is not null and his_func_string_to_date(oi.cal_qty_end_date) is not null 
		  then oi.cal_qty_end_date::date - oi.cal_qty_start_date::date else 0 end as "NumberDayDose"
		, null as "DoseFreqCode"
		, null as "DoseFreqNameTH"
		, null as "DoseFreqNameEN"
		, null as "AuxLabel1Code"
		, i.description as "AuxLabel1NameTH"
		, i.description_en  as "AuxLabel1NameEN"
		, null as "AuxLabel2Code"
		, i.caution as "AuxLabel2NameTH"
		, i.caution_en as "AuxLabel2NameEN"
		, null as "AuxLabel3Code"
		, null as "AuxLabel3NameTH"
		, null as "AuxLabel3NameEN"
		, oi.instruction_text_line1 || 
		  (case when oi.instruction_text_line2 != '' then ' ' || oi.instruction_text_line2 else '' end) ||
		  (case when oi.instruction_text_line3 != '' then ' ' || oi.instruction_text_line3 else '' end) ||
		  (case when oi.description != '' then ' ' || oi.description else '' end) ||
		  (case when oi.caution != '' then ' ' || oi.caution else '' end) as "DoseMemo"
		, null as "ReturnOpdDrugReasonCode"
		, rd.receive_note as "ReturnOpdDrugReasonnameTH"
		, null as "ReturnOpdDrugReasonNameEN"
		, null as "DoctorApproved"
		, null as "DrugRepeatType"
		, null as "DrugRepeatTypeName"
		, null as "HNDrugErrorCodeTypeCode"
		, null as "HNDrugErrorCodeTypeName"
		, null as "HNAllergicErrorCodeTypeCode"
		, null as "HNAllergicErrorCodeTypeName"
		, null as "NetPrice"
		, null as "OutsideHospitalDrug"
		, oi.cal_qty_start_date ||
		  case when oi.cal_qty_start_date != '' then 
		  (case when oi.cal_qty_start_time != '' then ' ' || oi.cal_qty_start_time else ' ' || '00:00:00' end)
		  else '' end as "StartDoseDateTime"
		, oi.cal_qty_end_date ||
		  case when oi.cal_qty_end_date != '' then 
		  (case when oi.cal_qty_end_time != '' then ' ' || oi.cal_qty_end_time else ' ' || '00:00:00' end)
		  else '' end as "FinishDoseDateTime"
from 	order_item oi 
		inner join visit v on oi.visit_id = v.visit_id and v.fix_visit_type_id = '0'
		inner join item i on oi.item_id = i.item_id
		left join base_service_point bsp on oi.dispense_spid = bsp.base_service_point_id 
		left join stock s on bsp.stock_id = s.stock_id 
		left join base_unit bu on oi.base_unit_id = bu.base_unit_id 
		left join base_order_sub_category bosc on oi.base_order_sub_category_id = bosc.base_order_sub_category_id
		left join plan p on oi.plan_id = p.plan_id 
		left join base_drug_instruction bdi on split_part(oi.base_drug_usage_code,' ',1) = bdi.base_drug_instruction_id 
		left join base_drug_time bdt on (case when split_part(oi.base_drug_usage_code,' ',4) like 'once%' then split_part(oi.base_drug_usage_code,' ',6) else split_part(oi.base_drug_usage_code,' ',5) end) = bdt.base_drug_time_id 
		left join base_dose_unit bdu on split_part(oi.base_drug_usage_code,' ',3) = bdu.base_dose_unit_id 
		left join return_drug rd on oi.order_item_id = rd.dispense_order_id 
		, base_site bs 
where 	1=1
		and oi.fix_item_type_id = '0'
		and v.visit_date = '2026-01-01'