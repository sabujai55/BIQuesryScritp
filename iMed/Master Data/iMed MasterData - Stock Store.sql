select 	ss."StoreCode"
		, ss."StoreNameTH"
		, ss."StoreNameEN"
		, ss."StockCode"
		, ss."StocKNameTH"
		, ss."StockNameEN"
		, ss."Location"
		, ss."NonItem"
		, ss."Status"
from
(
select 	row_number() over(partition by sm.stock_id , sm.item_id order by sm.stock_mgnt_id desc) as rowid
		, sm.stock_id as "StoreCode"
		, s.stock_name as "StoreNameTH"
		, s.stock_name as "StoreNameEN"
		, i.item_code as "StockCode"
		, case when i.print_name = '' then i.common_name else i.print_name end as "StocKNameTH"
		, i.print_name_en as "StockNameEN"
		, sm.place as "Location"
		, '' as "NonItem"
		, case when sm.active = '1' then 'Active' else 'Inactive' end as "Status"
from 	stock_mgnt sm 
		inner join stock s on sm.stock_id = s.stock_id
		inner join item i on sm.item_id = i.item_id 
		left join base_unit bu on sm.small_unit_id = bu.base_unit_id 
)ss
where ss.rowid = 1