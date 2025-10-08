


select
'PLR' as "BU"
, coalesce(i.item_code, is2.item_set_id) as "FacilityMethodCode" 
, coalesce((case when i.print_name != '' then i.print_name else i.common_name end), is2.description) as "FacilityMethodNameTH"
, coalesce((case when i.print_name_en != '' then i.print_name_en else i.common_name end), is2.description) as "FacilityMethodNameEN"
, d.item_code as "TreatmentCode"
, d.common_name as "TreatmentNameTH"
, d.print_name_en as "TreatmentNameEN"
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
from 	item_set is2 	
		left join item i on i.item_id = is2.item_id
		join df_order_item_set c on c.item_set_id = is2.item_set_id 
		join item d on c.item_id = d.item_id
		left join base_order_sub_category bosc on d.base_order_sub_category_id = bosc.base_order_sub_category_id 
		LEFT JOIN --OPD
				(
						SELECT 	row_number() over(PARTITION by item_id ORDER BY active_date desc) as "row"
								, item_id
								, unit_price 
						FROM 	item_price 
						WHERE 	base_tariff_id = '1' 
				)opd on d.item_id = opd.item_id AND opd."row" = 1
		LEFT JOIN --iPD
				(
						SELECT 	row_number() over(PARTITION by item_id ORDER BY active_date desc) as "row"
								, item_id
								, unit_price 
						FROM 	item_price 
						WHERE 	base_tariff_id = '2' 
				)ipd on d.item_id = ipd.item_id AND ipd."row" = 1
where 	is2.fix_order_set_type_id in ('0','1') 
		and d.fix_item_type_id not in ('0','1','2','4')
		and (d.fix_item_type_id != '3' and d.base_category_group_id not in ('003','004') and i.item_code not LIKE ANY (ARRAY['%X', '%N'])) --> For PLR
order by coalesce(i.item_code, is2.item_set_id) asc 





