select
		  'PLS' as BU
		, sti.STOCKCODE
		, dbo.StockName(sti.STOCKCODE,2) as StockNameTH
		, dbo.StockName(sti.STOCKCODE,1) as StockNameEN
		, sti.IndexNameKey as IndexNameKey
		, sti.THAINAME as IndexNameKeyTH
		, sti.ENGLISHNAME as IndexNameKeyEN
		, '' as SimilarName		
				from SSBSTOCK.dbo.STOCK_INXNAME sti		