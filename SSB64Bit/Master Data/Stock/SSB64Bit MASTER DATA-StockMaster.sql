select 
	'PT2' as BU
	, sm.StockCode
	, dbo.CutSortChar(sm.LocalName) as StockNameTH
	, dbo.CutSortChar(sm.EnglishName) as StockNameEN
	, sm.ShortName
	, sm.StockComposeCategory
	, dbo.sysconname(sm.StockComposeCategory,20045,2) as StockComposeCategoryNameTH
	, dbo.sysconname(sm.StockComposeCategory,20045,1) as StockComposeCategoryNameEN
	, sm.SmallestUnitCode
	, dbo.sysconname(sm.SmallestUnitCode,20021,2) as SmallestUnitNameTH
	, dbo.sysconname(sm.SmallestUnitCode,20021,1) as SmallestUnitNameEN
	, sm.FDANo
	, sm.GradeCode
	, dbo.sysconname(sm.GradeCode,20051,2) as GradeNameTH
	, dbo.sysconname(sm.GradeCode,20051,1) as GradeNameEN
	, sm.ColourCode
	, dbo.sysconname(sm.ColourCode,10151,2) as ColourNameTH
	, dbo.sysconname(sm.ColourCode,10151,1) as ColourNameEN
	, sm.Maker
	, dbo.sysconname(sm.Maker,20052,2) as MakerNameTH
	, dbo.sysconname(sm.Maker,20052,1) as MakerNameEN
	, sm.Tariff
	, sm.ModelCode
	, sm.QCDurationMinutes
	, sm.MinNoDayExpire
	, sm.NoDayLife
	, sm.StockInactiveCode
	, dbo.sysconname(sm.StockInactiveCode,20161,2) as StockInactiveNameTH
	, dbo.sysconname(sm.StockInactiveCode,20161,1) as StockInactiveNameEN
	, sm.PercentageOfOverPO
	, sm.SKNonDrugChargeType
	, sm.DefaultStockActivityCode
	, dbo.sysconname(sm.DefaultStockActivityCode,20032,2) as DefaultStockActivityNameTH
	, dbo.sysconname(sm.DefaultStockActivityCode,20032,1) as DefaultStockActivityNameEN
	, sm.AdditionStatStockCodeColl
	, sm.MakeDateTime
	, sm.DeletedDateTime
	, sm.DateLastClose
	, sm.CreateByUserCode
	, dbo.sysconname(sm.CreateByUserCode,10031,2) as CreateByUserNameTH
	, dbo.sysconname(sm.CreateByUserCode,10031,1) as CreateByUserNameEN
	, sm.SelfProduce
	, sm.ExpiryDateCheck
	, sm.NetPrice
	, sm.NonItem
	, sm.Inactive
	, sm.NonVAT
		from STOCKMASTER sm


		