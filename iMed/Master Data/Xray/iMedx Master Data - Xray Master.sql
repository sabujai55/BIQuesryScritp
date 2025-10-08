

select
'PLR' as "BU"
, i.item_code as "XrayCode"
, i.common_name as "XrayNameTH"
, '' as "XrayNameEN"
, '' as "DefaultXrayExposureMachine"
, '' as "DefaultXrayExposureMachineNameTH"
, '' as "DefaultXrayExposureMachineNameEN"
, i.base_xray_type_id as "TypeOfXrayId"
, bxt.description as "TypeOfXrayName"
, '' as "GroupOfXrayCode"
, '' as "GroupOfXrayNameTH"
, '' as "GroupOfXrayNameEN"
, '' as "Organ"
, '' as "OrganNameTH"
, '' as "OrganNameEN"
, '' as "OrganPosition"
, '' as "OrganPositionNameTH"
, '' as "OrganPositionNameEN"
, '' as "UsageMethod"
, '' as "UsageMethodNameTH"
, '' as "UsageMethodNameEN"
, '' as "FacilityRmsNo"
, '' as "FacilityRmsNoNameTH"
, '' as "FacilityRmsNoNameEN"
, '' as "HNActivityCodeOPD"
, '' as "HNActivityOPDNameTH"
, '' as "HNActivityOPDNameEN"
, '' as "HNActivityCodeIPD"
, '' as "HNActivityIPDNameTH"
, '' as "HNActivityIPDNameEN"
, '' as "HNActivityCodeCheckUp"
, '' as "HNActivityCheckUpNameTH"
, '' as "HNActivityCheckUpNameEN"
, '' as "DFOnResultTreatmentCode"
, '' as "DFOnResultTreatmentNameTH"
, '' as "DFOnResultTreatmentNameEN"
, '' as "DFOnSpecialResultTreatmentCode"
, '' as "DFOnSpecialResultTreatmentNameTH"
, '' as "DFOnSpecialResultTreatmentNameEN"
, '' as "XrayResultCategoryCode"
, '' as "XrayResultCategoryNameTH"
, '' as "XrayResultCategoryNameEN"
, opd.unit_price as "DefaultPrice"
, '' as "ResultDfAmt"
, '' as "DefaultPortableAdditionCharge"
, '' as "CGDTextCode"
, case when i.edit_price = '1' then '1' else '0' end as "OpenPrice"
, case when i.active = '0' then '1' else '0' end as "Off"
from item i 
left join base_xray_type bxt on bxt.base_xray_type_id = i.base_xray_type_id
LEFT JOIN --OPD
		(
				SELECT 	row_number() over(PARTITION by item_id ORDER BY active_date desc) as "row"
						, item_id
						, unit_price 
				FROM 	item_price 
				WHERE 	base_tariff_id = '1' 
		)opd on i.item_id = opd.item_id AND opd."row" = 1
where i.fix_item_type_id = '2' 
--and i.item_code = 'CT004'




