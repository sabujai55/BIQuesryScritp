select	'PTS' as BU
		, a.Code as PackageCode
		, coalesce(dbo.CutSortChar(a.LocalName),'') as PackageNameTH
		, coalesce(dbo.CutSortChar(a.EnglishName),'') as PackageNameEN

		, b.HNPackageItemCategoryCode as HNPackageItemCategory --modify 2026-03-18
		, coalesce(dbo.sysconname(b.HNPackageItemCategoryCode,43540,2),'') as HNPackageItemCategoryNameTH --modify 2026-03-18
		, coalesce(dbo.sysconname(b.HNPackageItemCategoryCode,43540,1),'') as HNPackageItemCategoryNameEN --modify 2026-03-18

		, b.Qty --modify 2026-03-18
		--, Qty = SIGN(CAST(substring(b.Com,8-0,1)+substring(b.Com,8-1,1)+substring(b.Com,8-2,1)+substring(b.Com,8-3,1)+substring(b.Com,8-4,1)+substring(b.Com,8-5,1)+substring(b.Com,8-6,1)+substring(b.Com,8-7,1) AS BIGINT))
		--	  *(1.0 + (CAST(substring(b.Com,8-0,1)+substring(b.Com,8-1,1)+substring(b.Com,8-2,1)+substring(b.Com,8-3,1)+substring(b.Com,8-4,1)+substring(b.Com,8-5,1)+substring(b.Com,8-6,1)+substring(b.Com,8-7,1) AS BIGINT) & 0x000FFFFFFFFFFFFF) * POWER(CAST(2 AS FLOAT), -52))
		--	  * POWER(CAST(2 AS FLOAT), (CAST(substring(b.Com,8-0,1)+substring(b.Com,8-1,1)+substring(b.Com,8-2,1)+substring(b.Com,8-3,1)+substring(b.Com,8-4,1)+substring(b.Com,8-5,1)+substring(b.Com,8-6,1)+substring(b.Com,8-7,1) AS BIGINT) & 0x7ff0000000000000) / 0x0010000000000000 - 1023)

		, b.StockCode as StockCode --modify 2026-03-18
		, coalesce(dbo.Stockname(b.StockCode,2),'') as StockNameTH --modify 2026-03-18
		, coalesce(dbo.Stockname(b.StockCode,1),'') as StockNameEN --modify 2026-03-18

		, b.UnitCode as UnitCode --modify 2026-03-18
		, coalesce(dbo.sysconname(b.UnitCode,20021,2),'') as UnitNameTH --modify 2026-03-18
		, coalesce(dbo.sysconname(b.UnitCode,20021,1),'') as UnitNameEN --modify 2026-03-18

		, b.AlterStockCode_0 as AlterStock1 --modify 2026-03-18
		, coalesce(dbo.Stockname(b.AlterStockCode_0,2),'') as AlterStock1NameTH --modify 2026-03-18
		, coalesce(dbo.Stockname(b.AlterStockCode_0,1),'') as AlterStock1NameEN --modify 2026-03-18

		, b.AlterStockCode_1 as AlterStock2 --modify 2026-03-18
		, coalesce(dbo.Stockname(b.AlterStockCode_1,2),'') as AlterStock2NameTH --modify 2026-03-18
		, coalesce(dbo.Stockname(b.AlterStockCode_1,1),'') as AlterStock2NameEN --modify 2026-03-18

		, b.AlterStockCode_2 as AlterStock3 --modify 2026-03-18
		, coalesce(dbo.Stockname(b.AlterStockCode_2,2),'') as AlterStock3NameTH --modify 2026-03-18
		, coalesce(dbo.Stockname(b.AlterStockCode_2,1),'') as AlterStock3NameEN --modify 2026-03-18

		, b.AlterStockCode_3 as AlterStock4 --modify 2026-03-18
		, coalesce(dbo.Stockname(b.AlterStockCode_3,2),'') as AlterStock4NameTH --modify 2026-03-18
		, coalesce(dbo.Stockname(b.AlterStockCode_3,1),'') as AlterStock4NameEN --modify 2026-03-18

		, b.AlterStockCode_4 as AlterStock5 --modify 2026-03-18
		, coalesce(dbo.Stockname(b.AlterStockCode_4,2),'') as AlterStock5NameTH --modify 2026-03-18
		, coalesce(dbo.Stockname(b.AlterStockCode_4,1),'') as AlterStock5NameEN --modify 2026-03-18

		, b.AlterStockCode_5 as AlterStock6 --modify 2026-03-18
		, coalesce(dbo.Stockname(b.AlterStockCode_5,2),'') as AlterStock6NameTH --modify 2026-03-18
		, coalesce(dbo.Stockname(b.AlterStockCode_5,1),'') as AlterStock6NameEN --modify 2026-03-18

		, b.AlterStockCode_6 as AlterStock7 --modify 2026-03-18
		, coalesce(dbo.Stockname(b.AlterStockCode_6,2),'') as AlterStock7NameTH --modify 2026-03-18
		, coalesce(dbo.Stockname(b.AlterStockCode_6,1),'') as AlterStock7NameEN --modify 2026-03-18

		, b.AlterStockCode_7 as AlterStock8 --modify 2026-03-18
		, coalesce(dbo.Stockname(b.AlterStockCode_7,2),'') as AlterStock8NameTH --modify 2026-03-18
		, coalesce(dbo.Stockname(b.AlterStockCode_7,1),'') as AlterStock8NameEN --modify 2026-03-18

		, b.AlterStockCode_8 as AlterStock9 --modify 2026-03-18
		, coalesce(dbo.Stockname(b.AlterStockCode_8,2),'') as AlterStock9NameTH --modify 2026-03-18
		, coalesce(dbo.Stockname(b.AlterStockCode_8,1),'') as AlterStock9NameEN --modify 2026-03-18

		, b.AlterStockCode_9 as AlterStock10 --modify 2026-03-18
		, coalesce(dbo.Stockname(b.AlterStockCode_9,2),'') as AlterStock10NameTH --modify 2026-03-18
		, coalesce(dbo.Stockname(b.AlterStockCode_9,1),'') as AlterStock10NameEN --modify 2026-03-18
from	DNSYSCONFIG a 
		inner join DEVDECRYPT.dbo.PYTS_SETUP_HN_HN_PACKAGE_MEDICINE b on a.Code=b.Code --modify 2026-03-18
where	a.CtrlCode = 43541

