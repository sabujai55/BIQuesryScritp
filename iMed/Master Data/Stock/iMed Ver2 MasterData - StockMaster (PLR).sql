select 	'PLR' as BU
		, i.item_code as "StockCode"
		, i.print_name as "StockNameTH"
		, i.common_name as "StockNameEN"
		, i.nick_name as "ShortName"
		, i.base_drug_group_id as "StockComposeCategory"
		, b.description as "StockComposeCategoryNameTH"
		, b.description as "StockComposeCategoryNameEN"
		, i.base_unit_id as "SmallestUnitCode"
		, b2.description_th as "SmallestUnitNameTH"
		, b2.description_en as "SmallestUnitNameEN"
		, '' as "FDANo"
		, '' as "GradeCode"
		, '' as "GradeNameTH"
		, '' as "GradeNameEN"
		, '' as "ColourCode"
		, '' as "ColourNameTH"
		, '' as "ColourNameEN"
		, '' as "Maker"
		, '' as MakerNameTH
		, '' as MakerNameEN
		, '' as "Tariff"
		, '' as "ModelCode"
		, '' as "QCDurationMinutes"
		, '' as "MinNoDayExpire"
		, '' as "NoDayLife"
		, '' as "StockInactiveCode"
		, '' as "StockInactiveNameTH"
		, '' as "StockInactiveNameEN"
		, '' as "PercentageOfOverPO"
		, '' as "SKNonDrugChargeType"
		, '' as "DefaultStockActivityCode"
		, '' as "DefaultStockActivityNameTH"
		, '' as "DefaultStockActivityNameEN"
		, '' as "AdditionStatStockCodeColl"
		, '' as "MakeDateTime"
		, '' as "DeletedDateTime"
		, '' as "DateLastClose"
		, '' as "CreateByUserCode"
		, '' as "CreateByUserNameTH"
		, '' as "CreateByUserNameEN"
		, '' as "SelfProduce"
		, '' as "ExpiryDateCheck"
		, '' as "NetPrice"
		, '0' as "NonItem"
		, case when i.active = '1' then '0' else '1' end as "Inactive"
		, '' as "NonVAT"
from 	item i 
		left join base_drug_group b on i.base_drug_group_id = b.base_drug_group_id
		left join base_unit b2 on b2.base_unit_id = i.base_unit_id
where 	i.fix_item_type_id in ('0', '4')
		and i.item_code != ''
union all 
select 	'PLR' as BU
		, i.item_code as "StockCode"
--		, i.base_category_group_id
--		, b3.description
		, i.print_name as "StockNameTH"
		, i.common_name as "StockNameEN"
		, i.nick_name as "ShortName"
		, i.base_drug_group_id as "StockComposeCategory"
		, b.description as "StockComposeCategoryNameTH"
		, b.description as "StockComposeCategoryNameEN"
		, i.base_unit_id as "SmallestUnitCode"
		, b2.description_th as "SmallestUnitNameTH"
		, b2.description_en as "SmallestUnitNameEN"
		, '' as "FDANo"
		, '' as "GradeCode"
		, '' as "GradeNameTH"
		, '' as "GradeNameEN"
		, '' as "ColourCode"
		, '' as "ColourNameTH"
		, '' as "ColourNameEN"
		, '' as "Maker"
		, '' as MakerNameTH
		, '' as MakerNameEN
		, '' as "Tariff"
		, '' as "ModelCode"
		, '' as "QCDurationMinutes"
		, '' as "MinNoDayExpire"
		, '' as "NoDayLife"
		, '' as "StockInactiveCode"
		, '' as "StockInactiveNameTH"
		, '' as "StockInactiveNameEN"
		, '' as "PercentageOfOverPO"
		, '' as "SKNonDrugChargeType"
		, '' as "DefaultStockActivityCode"
		, '' as "DefaultStockActivityNameTH"
		, '' as "DefaultStockActivityNameEN"
		, '' as "AdditionStatStockCodeColl"
		, '' as "MakeDateTime"
		, '' as "DeletedDateTime"
		, '' as "DateLastClose"
		, '' as "CreateByUserCode"
		, '' as "CreateByUserNameTH"
		, '' as "CreateByUserNameEN"
		, '' as "SelfProduce"
		, '' as "ExpiryDateCheck"
		, '' as "NetPrice"
		, '1' as "NonItem"
		, case when i.active = '1' then '0' else '1' end as "Inactive"
		, '' as "NonVAT"
from 	item i 
		left join base_drug_group b on i.base_drug_group_id = b.base_drug_group_id
		left join base_unit b2 on b2.base_unit_id = i.base_unit_id
		left join base_category_group b3 on b3.base_category_group_id = i.base_category_group_id
where 	i.fix_item_type_id = '3'
		and i.fix_set_type_id != '1'
--		and i.base_category_group_id ilike any (array['01%','04%','SMED'])
		and i.base_category_group_id in ('003','004')
		and (i.item_code like '%N' or i.item_code like '%X')