
select
'PLR' as "BU"
, i.item_code as "TreatmentCode"
, i.common_name as "TreatmentNameTH"
, '' as "TreatmentNameEN"
, '' as "TreatmentCategoryCode"
, '' as "TreatmentCategoryNameTH"
, '' as "TreatmentCategoryNameEN"
, '' as "HNActivityCode"
, '' as "HNActivityNameTH"
, '' as "HNActivityNameEN"
, '' as "UnitOfQtyOfWork"
, opd.unit_price as "DefaultPrice"
, '' as "TreatmentEntryStyleId"
, '' as "TreatmentEntryStyleName"
, '' as "TreatmentTimeTypeId"
, '' as "TreatmentTimeTypeName"
, '' as "QtyUnitNameText"
, '' as "QtyUnitNameTextNameTH"
, '' as "QtyUnitNameTextNameEN"
, '' as "DF"
, '' as "DoctorCannotEmpty"
, '' as "NurseActivity"
, '' as "CanBeZeroPrice"
, case when i.active = '0' then '1' else '0' end as "Off"
, '' as "Memo"
from item i 
LEFT JOIN --OPD
		(
				SELECT 	row_number() over(PARTITION by item_id ORDER BY active_date desc) as "row"
						, item_id
						, unit_price 
				FROM 	item_price 
				WHERE 	base_tariff_id = '1' 
		)opd on i.item_id = opd.item_id AND opd."row" = 1
where i.fix_item_type_id = '7' 
--and i.item_code = 'H0088'

