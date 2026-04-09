Use
SSBHOSPITAL
Go

select
	'PLS' as 'BU'
	, st.STORE as StoreCode
	, dbo.sysconname(st.STORE,40010,2) as StoreNameTH
	, dbo.sysconname(st.STORE,40010,1) as StoreNameEN
	, st.STOCKCODE as StockCode
	, dbo.CutSortChar(sm.THAINAME) as StockNameTH
	, dbo.CutSortChar(sm.ENGLISHNAME) as StockNameEN
	, st.[LOCATION] as [Location]
	, st.NONITEM as NonItem
	, case when OFFSTOCK = 1 then 'InActive'
		   when OFFSTOCK = 0 then 'Active'
	  end as [Status]
		from SSBSTOCK.dbo.STOCK_STORE st
		left join SSBSTOCK.dbo.STOCK_MASTER sm on st.STOCKCODE=sm.STOCKCODE