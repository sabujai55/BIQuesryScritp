select 	bs.site_code as "BU"
		, oi.order_item_id as "OrderID"
		, oi.patient_id as "PatientID"
		, oi.visit_id as "VisitID"
		, v.visit_date ||' '|| v.visit_time as "VisitDate"
		, format_vn(v.vn) as "VN"
		, coalesce(ap.attending_physician_id, ap2."PrescriptionNo", ap3."PrescriptionNo") as "PrescriptionNo"	--> 2026-08-06	Add Prescription
		, coalesce(ap.base_department_id, ap2."ClinicCode", ap3."ClinicCode") as "ClinicCode"	--> 2026-08-06	Add Clinic Prescription
		, coalesce(bd.description, ap2."ClinicNameTH", ap3."ClinicNameTH") as "ClinicNameTH"	--> 2026-08-06	Add Clinic Prescription
		, '' as "ClinicNameEN"
		, coalesce(ap.employee_id, ap2."DoctorCode", ap3."DoctorCode") as "DoctorCode"	--> 2026-08-06	Add Doctor Prescription
		, coalesce(e.prename || e.firstname || ' ' || e.lastname, ap2."DoctorNameTH", ap3."DoctorNameTH") as "DoctorNameTH"	--> 2026-08-06	Add Doctor Prescription
		, coalesce(e.intername, ap2."DoctorNameEN", ap3."DoctorNameEN") as "DoctorNameEN" 	--> 2026-08-06	Add Doctor Prescription
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
		, case when oi.charge_complete = '1' then 'Charge' else 'None' end as "ChargeType"
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
		left join base_service_point bsp2 on bsp2.base_service_point_id = oi.verify_spid 
		left join stock s on bsp.stock_id = s.stock_id 
		left join base_unit bu on oi.base_unit_id = bu.base_unit_id 
		left join base_order_sub_category bosc on oi.base_order_sub_category_id = bosc.base_order_sub_category_id
		left join plan p on oi.plan_id = p.plan_id 
		left join base_drug_instruction bdi on split_part(oi.base_drug_usage_code,' ',1) = bdi.base_drug_instruction_id 
		left join base_drug_time bdt on (case when split_part(oi.base_drug_usage_code,' ',4) like 'once%' then split_part(oi.base_drug_usage_code,' ',6) else split_part(oi.base_drug_usage_code,' ',5) end) = bdt.base_drug_time_id 
		left join base_dose_unit bdu on split_part(oi.base_drug_usage_code,' ',3) = bdu.base_dose_unit_id 
		left join return_drug rd on oi.order_item_id = rd.dispense_order_id 
		left join attending_physician ap on ap.visit_id = oi.visit_id and ap.employee_id = oi.order_doctor_eid and ap.base_department_id = bsp2.base_department_id 	--> 2026-08-06	Add Prescription
		left join base_department bd on bd.base_department_id = ap.base_department_id	--> 2026-08-06	Add Clinic Prescription
		left join employee e on e.employee_id = ap.employee_id	--> 2026-08-06	Add Doctor Prescription
		left join lateral	--> 2026-08-06	Add Doctor Prescription
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
		)ap2 on true
		left join lateral	--> 2026-08-06	Add Doctor Prescription
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
		and oi.fix_item_type_id = '0'
		and v.visit_date = (current_date-1)::text