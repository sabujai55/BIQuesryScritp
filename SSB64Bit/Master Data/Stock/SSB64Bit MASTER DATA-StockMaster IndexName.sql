select
	  'PT2' as BU
	, si.StockCode
	, dbo.Stockname(si.StockCode,2) as StockNameTH
	, dbo.Stockname(si.StockCode,1) as StockNameEN
	, si.IndexNameKey
	, dbo.sysconname(si.IndexNameKey,20113,2) as IndexNameKeyTH
	, dbo.sysconname(si.IndexNameKey,20113,1) as IndexNameKeyEN
	, dbo.CutSortChar(si.SimilarName) as SimilarName
			from STOCKMASTER_INDEXNAME si