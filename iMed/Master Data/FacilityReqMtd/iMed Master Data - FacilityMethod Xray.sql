



select
'PLR' as "BU"
, coalesce(a.item_code, b.item_set_id) as "FacilityMethodCode" 
, coalesce((case when a.print_name != '' then a.print_name else a.common_name end), b.description) as "FacilityMethodNameTH"
, coalesce((case when a.print_name_en != '' then a.print_name_en else a.common_name end), b.description) as "FacilityMethodNameEN"
, d.item_code as "XrayCode"
, d.common_name as "XrayNameTH"
, d.print_name_en as "XrayNameEN"
, d.base_order_sub_category_id  as "HNActivityCodeOPD"
, bosc.description  as "HNActivityOPDNameTH"
, '' as "HNActivityOPDNameEN"
, d.base_order_sub_category_id as "HNActivityCodeIPD"
, bosc.description as "HNActivityIPDNameTH"
, '' as "HNActivityIPDNameEN"
, '' as "HNActivityCodeCheckup"
, '' as "HNActivityCheckupNameTH"
, '' as "HNActivityCheckupNameEN"
, opd.unit_price as "PriceOPD"
, ipd.unit_price as "PriceIPD"
, '1' as "DefaultCheck"
, '0' as "FreeOfCharge"
from item a
INNER JOIN item_set b on a.item_id = b.item_id 
LEFT JOIN df_order_item_set c on b.item_set_id = c.item_set_id 
LEFT JOIN item d on c.item_id = d.item_id
left join base_order_sub_category bosc on d.base_order_sub_category_id = bosc.base_order_sub_category_id 
LEFT JOIN --OPD
		(
				SELECT 	row_number() over(PARTITION by item_id ORDER BY active_date desc) as "row"
						, item_id
						, unit_price 
				FROM 	item_price 
				WHERE 	base_tariff_id = '1' 
		)opd on a.item_id = opd.item_id AND opd."row" = 1
LEFT JOIN --iPD
		(
				SELECT 	row_number() over(PARTITION by item_id ORDER BY active_date desc) as "row"
						, item_id
						, unit_price 
				FROM 	item_price 
				WHERE 	base_tariff_id = '2' 
		)ipd on a.item_id = ipd.item_id AND ipd."row" = 1
where b.fix_order_set_type_id in ('0','1','2','4')
and d.fix_item_type_id = '2'
order by coalesce(a.item_code, b.item_set_id) asc 




