select
'PLR' as "BU"
, i.item_code as "PTModeCode"
, case when i.print_name != '' then i.print_name else i.common_name end as "PTModeNameTH"
, case when i.print_name_en != '' then i.print_name_en else i.common_name end  as "PTModeNameEN"
, ip.unit_price as "DefaultPriceOPD"
, ip2.unit_price as "DefaultPriceIPD"
, i.base_order_sub_category_id  as "HNActivityOPDCode"
, b.description as "HNActivityOPDNameTH"
, '' as "HNActivityOPDNameEN"
, i.base_order_sub_category_id as "HNActivityIPDCode"
, b.description as "HNActivityIPDNameTH"
, '' as "HNActivityIPDNameEN"
, '' as "PTModeGroupCode"
, '' as "PTModeGroupNameTH"
, '' as "PTModeGroupNameEN"
, case when i.edit_price = '1' then '1' else '0' end as "OpenPrice"
, case when i.active = '0' then '1' else '0' end as "Off"
from item i 
left join base_order_sub_category b on b.base_order_sub_category_id = i.base_order_sub_category_id
left join 
		(
			select 	row_number() over(partition by i.item_id order by i.active_date desc) as rowid
					, i.item_id
					, i.unit_price
			from 	item_price i 
			where 	i.base_tariff_id = '1'
		)ip on ip.item_id = i.item_id and ip.rowid = 1
left join 
		(
			select 	row_number() over(partition by i.item_id order by i.active_date desc) as rowid
					, i.item_id
					, i.unit_price
			from 	item_price i 
			where 	i.base_tariff_id = '2'
		)ip2 on ip2.item_id = i.item_id and ip2.rowid = 1
where i.base_category_group_id = '015'
and i.fix_set_type_id <> '1'
union all 
select
'PLD' as "BU"
, i.item_code as "PTModeCode"
, case when i.print_name != '' then i.print_name else i.common_name end as "PTModeNameTH"
, case when i.print_name_en != '' then i.print_name_en else i.common_name end  as "PTModeNameEN"
, ip.unit_price as "DefaultPriceOPD"
, ip2.unit_price as "DefaultPriceIPD"
, i.base_order_sub_category_id as "HNActivityOPDCode"
, b.description as "HNActivityOPDNameTH"
, '' as "HNActivityOPDNameEN"
, i.base_order_sub_category_id as "HNActivityIPDCode"
, b.description as "HNActivityIPDNameTH"
, '' as "HNActivityIPDNameEN"
, '' as "PTModeGroupCode"
, '' as "PTModeGroupNameTH"
, '' as "PTModeGroupNameEN"
, case when i.edit_price = '1' then '1' else '0' end as "OpenPrice"
, case when i.active = '0' then '1' else '0' end as "Off"
from item i 
left join base_order_sub_category b on b.base_order_sub_category_id = i.base_order_sub_category_id
left join 
		(
			select 	row_number() over(partition by i.item_id order by i.active_date desc) as rowid
					, i.item_id
					, i.unit_price
			from 	item_price i 
			where 	i.base_tariff_id = '1'
		)ip on ip.item_id = i.item_id and ip.rowid = 1
left join 
		(
			select 	row_number() over(partition by i.item_id order by i.active_date desc) as rowid
					, i.item_id
					, i.unit_price
			from 	item_price i 
			where 	i.base_tariff_id = '2'
		)ip2 on ip2.item_id = i.item_id and ip2.rowid = 1
where i.base_category_group_id = '06PT'
and i.fix_set_type_id <> '1'



