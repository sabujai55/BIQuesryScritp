select 
		 'PLS' as BU
		, ar.ARCODE as ARCode
		, dbo.CutSortChar(ar.THAINAME) as ARNameTH
		, dbo.CutSortChar(ar.ENGLISHNAME) as ARNameEN
		, ar.ARCATEGORY as ARComposeCategory
		, dbo.sysconname(ar.ARCATEGORY,110017,2) as ARComposeCategoryNameTH
		, dbo.sysconname(ar.ARCATEGORY,110017,1) as ARComposeCategoryNameEN
		, ar.DIVISION+'.'+ar.DEPT+'.'+ar.SECTION as ComposeDept
		, '' as ComposeDeptNameTH
		, '' as ComposeDeptNameEN
		, ar.GRADECODE as ARGradeCode
		, dbo.sysconname(ar.GRADECODE,110024,2) as ARGradeCodeNameTH
		, dbo.sysconname(ar.GRADECODE,110024,1) as ARGradeCodeNameEN
		, ar.MOTHERARCODE as ARMainCode
		, dbo.CutSortChar(arm.THAINAME) as ARMainNameTH
		, dbo.CutSortChar(arm.ENGLISHNAME) as ARMainNameEN
		, ar.SALESMAN as SalesPerson
		, dbo.sysconname(ar.SALESMAN,110010,2) as SalesPersonNameTH
		, dbo.sysconname(ar.SALESMAN,110010,1) as SalesPersonNameEN
		, ar.OTHERSYSTEMARCODE as OtherSystemARCode
		, ar.TAXID as TaxId
		, '' as StockActivityMethod
		, '' as StockActivityMethodNameTH
		, '' as StockActivityMethodNameEN
		, ar.CURRENCYCODE as Currency
		, dbo.sysconname(ar.CURRENCYCODE,10023,2) as CurrencyNameTH
		, dbo.sysconname(ar.CURRENCYCODE,10023,1) as CurrencyNameEN
		, ar.TERMOFPAYMENT as TermOfPayment
		, '' as TermOfPaymentNameTH
		, '' as TermOfPaymentNameEN
		, ar.MAKEDATETIME as MakeDateTime
		, ar.FIRSTDATETIME as FirstDateTime
		, ar.LASTUPDATEDATETIME as LastUpdateDateTime
		, ar.TERMINATEDATE as TerminateDate
		, '' as DeletedDateTime
		, '' as EffectiveDateFrom
		, '' as EffectiveDateTo
		, ar.REGISTERNO as RegisterNo
		, ar.BILLCOLLECTOR as BillCollector
		, dbo.sysconname(ar.BILLCOLLECTOR,110008,2) as BillCollectorNameTH
		, dbo.sysconname(ar.BILLCOLLECTOR,110008,1) as BillCollectorNameEN
		, '' as DeliveryByCode
		, '' as DeliveryByNameTH
		, '' as DeliveryByNameEN
		, '' as DeliveryRegion
		, '' as DeliveryRegionNameTH
		, '' as DeliveryRegionNameEN
		, ar.ADDRESS as Address1
		, ar.PROVINCE+'.'+ar.AMPHOE+'.'+ar.TAMBON as ProvinceComposeCode
		, dbo.Tambonname(ar.PROVINCE,ar.AMPHOE,ar.TAMBON,2)+' '+dbo.Amphoename(ar.PROVINCE,ar.AMPHOE,2)+' '+dbo.Provincename(ar.PROVINCE,2) as ProvinceComposeNameTH
		, dbo.Tambonname(ar.PROVINCE,ar.AMPHOE,ar.TAMBON,1)+' '+dbo.Amphoename(ar.PROVINCE,ar.AMPHOE,1)+' '+dbo.Provincename(ar.PROVINCE,1) as ProvinceComposeNameEN
		, ar.POSTALCODE as PostalCode
		, '' as CountryCode
		, '' as CountryNameTH
		, '' as CountryNameEN
		, '' as CommunicableNo
		, ar.TEL as TelephoneNo
		, ar.FAX as FaxNo
				from SSBBACKOFFICE.dbo.ARMASTER ar
				left join SSBBACKOFFICE.dbo.ARMASTER arm on ar.MOTHERARCODE=arm.ARCODE