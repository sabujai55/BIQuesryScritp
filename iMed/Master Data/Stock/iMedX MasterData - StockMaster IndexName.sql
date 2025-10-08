select 	'PTW' as BU
		, i.item_code as "StockCode"
		, i.print_name as "StockNameTH"
		, i.common_name as "StockNameEN"
		, i2.item_standard_code_type as "IndexNameKey"
		, '' as "IndexNameKeyTH"
		, i2.item_standard_code_type as "IndexNameKeyEN"
		, i2.item_code as "SimilarName"
from 	item i 
		join item_standard_code i2 on i2.item_id = i.item_id and i2.item_standard_code_type in ('TMT','UCEP')
where 	i.fix_item_type_id in ('0','4')
		and i.item_code != ''
		and i2.item_code != ''