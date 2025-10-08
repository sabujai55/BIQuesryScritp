select 	'PLR' as BU
		, i.item_code as "StockCode"
		, i.print_name as "StockNameTH"
		, i.common_name as "StockNameEN"
		, 'TMT' as "IndexNameKey"
		, '' as "IndexNameKeyTH"
		, 'TMT' as "IndexNameKeyEN"
		, i.tmt_code as "SimilarName"
from 	item i 
where 	i.fix_item_type_id in ('0', '4')
		and i.item_code != ''
		and i.tmt_code != ''
union all 
select 	'PLR' as BU
		, i.item_code as "StockCode"
		, i.print_name as "StockNameTH"
		, i.common_name as "StockNameEN"
		, 'UCEP' as "IndexNameKey"
		, '' as "IndexNameKeyTH"
		, 'UCEP' as "IndexNameKeyEN"
		, i.ucep_code  as "SimilarName"
from 	item i 
where 	i.fix_item_type_id in ('0', '4')
		and i.item_code != ''
		and i.ucep_code != ''
union all 
-- ***********************  Non Item  ***********************
select 	'PLR' as BU
		, i.item_code as "StockCode"
		, i.print_name as "StockNameTH"
		, i.common_name as "StockNameEN"
		, 'TMT' as "IndexNameKey"
		, '' as "IndexNameKeyTH"
		, 'TMT' as "IndexNameKeyEN"
		, i.tmt_code  as "SimilarName"
from 	item i 
where 	i.fix_item_type_id = '3'
		and i.fix_set_type_id != '1'
--		and i.base_category_group_id ilike any (array['01%','04%','SMED'])
		and i.base_category_group_id in ('003','004')
		and (i.item_code like '%N' or i.item_code like '%X')
		and i.tmt_code  != ''
union all
select 	'PLR' as BU
		, i.item_code as "StockCode"
		, i.print_name as "StockNameTH"
		, i.common_name as "StockNameEN"
		, 'UCEP' as "IndexNameKey"
		, '' as "IndexNameKeyTH"
		, 'UCEP' as "IndexNameKeyEN"
		, i.ucep_code  as "SimilarName"
from 	item i 
where 	i.fix_item_type_id = '3'
		and i.fix_set_type_id != '1'
--		and i.base_category_group_id ilike any (array['01%','04%','SMED'])
		and i.base_category_group_id in ('003','004')
		and (i.item_code like '%N' or i.item_code like '%X')
		and i.ucep_code != ''