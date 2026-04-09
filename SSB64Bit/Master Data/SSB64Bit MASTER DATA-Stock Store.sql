use SSBLIVE
go

select	'PT2' as BU
		, ss.Store as StoreCode
		, dbo.sysconname(ss.Store,20088, 2) as StoreNameTH
		, dbo.sysconname(ss.Store,20088, 1) as StoreNameEN
		, ss.StockCode
		, dbo.CutSortChar(sm.LocalName) as StockNameTH
		, dbo.CutSortChar(sm.EnglishName) as StockNameEN
		, coalesce(ss.[Location],'') as [Location]
		, ss.NonItem
		, case when ss.OffStock = 1 then 'Inactive' else 'Active' end as [Status]
from	STOCKSTORE ss 
		inner join STOCKMASTER sm on ss.StockCode = sm.StockCode
order by ss.Store, ss.StockCode;