select top 100
	'PT2' as BU
	, ar.ARCode
	, dbo.CutSortChar(ar.LocalName) as ARNameTH
	, dbo.CutSortChar(ar.EnglishName) as ARNameEN
	, ar.ARComposeCategory
	, dbo.sysconname(ar.ARComposeCategory,36042,2) as ARComposeCategoryNameTH
	, dbo.sysconname(ar.ARComposeCategory,36042,1) as ARComposeCategoryNameEN
	, ar.ComposeDept
	, dbo.sysconname(ar.ComposeDept,10145,2) as ComposeDeptNameTH
	, dbo.sysconname(ar.ComposeDept,10145,1) as ComposeDeptNameEN
	, ar.ARGradeCode
	, dbo.sysconname(ar.ARGradeCode,36038,2) as ARGradeCodeNameTH
	, dbo.sysconname(ar.ARGradeCode,36038,1) as ARGradeCodeNameEN
	, ar.MotherARCode as ARMainCode
	, dbo.CutSortChar(arm.LocalName) as ARMainNameTH
	, dbo.CutSortChar(arm.LocalName) as ARMainNameEN
	, ar.SalesmanCode as SalesPerson
	, dbo.sysconname(ar.SalesmanCode,36028,2) as SalesPersonNameTH
	, dbo.sysconname(ar.SalesmanCode,36028,1) as SalesPersonNameEN
	, ar.OtherSystemARCode
	, ar.TaxId
	, ar.StockActivityMethod
	, dbo.sysconname(ar.StockActivityMethod,20058,2) as StockActivityMethodNameTH
	, dbo.sysconname(ar.StockActivityMethod,20058,1) as StockActivityMethodNameEN
	, ar.Currency
	, dbo.sysconname(ar.Currency,10148,2) as CurrencyNameTH
	, dbo.sysconname(ar.Currency,10148,1) as CurrencyNameEN
	, ar.TermOfPayment
	, dbo.sysconname(ar.TermOfPayment,36136,2) as TermOfPaymentNameTH
	, dbo.sysconname(ar.TermOfPayment,36136,1) as TermOfPaymentNameEN
	, ar.MakeDateTime
	, ar.FirstDateTime
	, ar.LastUpdateDateTime
	, ar.TerminateDate
	, ar.DeletedDateTime
	, ar.EffectiveDateFrom
	, ar.EffectiveDateTo
	, ar.RegisterNo
	, ar.BillCollector 
	, dbo.sysconname(ar.BillCollector ,36025,2) as BillCollectorNameTH
	, dbo.sysconname(ar.BillCollector ,36025,1) as BillCollectorNameEN
	, ar.DeliveryByCode
	, dbo.sysconname(ar.DeliveryByCode,20086,2) as DeliveryByNameTH
	, dbo.sysconname(ar.DeliveryByCode,20086,1) as DeliveryByNameEN
	, ar.DeliveryRegion
	, dbo.sysconname(ar.DeliveryRegion,36158,2) as DeliveryRegionNameTH
	, dbo.sysconname(ar.DeliveryRegion,36158,1) as DeliveryRegionNameEN
	, ar.Address1
	, ar.ProvinceComposeCode
	, dbo.TambonnameNew(ar.ProvinceComposeCode,2)+' '+dbo.AmphoenameNew(ar.ProvinceComposeCode,2)+' '+dbo.ProvincenameNew(ar.ProvinceComposeCode,2) as ProvinceComposeNameTH
	, dbo.TambonnameNew(ar.ProvinceComposeCode,1)+' '+dbo.AmphoenameNew(ar.ProvinceComposeCode,1)+' '+dbo.ProvincenameNew(ar.ProvinceComposeCode,1) as ProvinceComposeNameEN
	, ar.PostalCode
	, ar.CountryCode
	, dbo.sysconname(ar.CountryCode,10115,2) as CountryNameTH
	, dbo.sysconname(ar.CountryCode,10115,1) as CountryNameEN
	, ar.CommunicableNo
	, ar.TelephoneNo
	, ar.FaxNo
		from ARMASTER ar 
		left join ARMASTER arm on ar.MotherARCode=arm.ARCode