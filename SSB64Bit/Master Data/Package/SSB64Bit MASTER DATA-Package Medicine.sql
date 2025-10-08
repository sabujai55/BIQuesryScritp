use SSBLIVE
go
--20021

select	'PT2' as BU
		, a.Code as PackageCode
		, coalesce(dbo.CutSortChar(a.LocalName),'') as PackageNameTH
		, coalesce(dbo.CutSortChar(a.EnglishName),'') as PackageNameEN

		, CAST(SUBSTRING(b.Com,9,3) as varchar(3)) as HNPackageItemCategory
		, coalesce(dbo.sysconname(CAST(SUBSTRING(b.Com,9,3) as varchar(3)),43540,2),'') as HNPackageItemCategoryNameTH
		, coalesce(dbo.sysconname(CAST(SUBSTRING(b.Com,9,3) as varchar(3)),43540,1),'') as HNPackageItemCategoryNameEN

		, Qty = SIGN(CAST(substring(b.Com,8-0,1)+substring(b.Com,8-1,1)+substring(b.Com,8-2,1)+substring(b.Com,8-3,1)+substring(b.Com,8-4,1)+substring(b.Com,8-5,1)+substring(b.Com,8-6,1)+substring(b.Com,8-7,1) AS BIGINT))
			  *(1.0 + (CAST(substring(b.Com,8-0,1)+substring(b.Com,8-1,1)+substring(b.Com,8-2,1)+substring(b.Com,8-3,1)+substring(b.Com,8-4,1)+substring(b.Com,8-5,1)+substring(b.Com,8-6,1)+substring(b.Com,8-7,1) AS BIGINT) & 0x000FFFFFFFFFFFFF) * POWER(CAST(2 AS FLOAT), -52))
			  * POWER(CAST(2 AS FLOAT), (CAST(substring(b.Com,8-0,1)+substring(b.Com,8-1,1)+substring(b.Com,8-2,1)+substring(b.Com,8-3,1)+substring(b.Com,8-4,1)+substring(b.Com,8-5,1)+substring(b.Com,8-6,1)+substring(b.Com,8-7,1) AS BIGINT) & 0x7ff0000000000000) / 0x0010000000000000 - 1023)

		, CAST(SUBSTRING(b.Com,13,13) as varchar(13)) as StockCode
		, coalesce(dbo.Stockname(CAST(SUBSTRING(b.Com,13,13) as varchar(13)),2),'') as StockNameTH
		, coalesce(dbo.Stockname(CAST(SUBSTRING(b.Com,13,13) as varchar(13)),1),'') as StockNameEN

		, CAST(SUBSTRING(b.Com,365,3) as varchar(3)) as UnitCode
		, coalesce(dbo.sysconname(CAST(SUBSTRING(b.Com,365,3) as varchar(3)),20021,2),'') as UnitNameTH
		, coalesce(dbo.sysconname(CAST(SUBSTRING(b.Com,365,3) as varchar(3)),20021,1),'') as UnitNameEN

		, CAST(SUBSTRING(b.Com,45,13) as varchar(13)) as AlterStock1
		, coalesce(dbo.Stockname(CAST(SUBSTRING(b.Com,45,13) as varchar(13)),2),'') as AlterStock1NameTH
		, coalesce(dbo.Stockname(CAST(SUBSTRING(b.Com,45,13) as varchar(13)),1),'') as AlterStock1NameEN

		, CAST(SUBSTRING(b.Com,77,13) as varchar(13)) as AlterStock2
		, coalesce(dbo.Stockname(CAST(SUBSTRING(b.Com,77,13) as varchar(13)),2),'') as AlterStock2NameTH
		, coalesce(dbo.Stockname(CAST(SUBSTRING(b.Com,77,13) as varchar(13)),1),'') as AlterStock2NameEN

		, CAST(SUBSTRING(b.Com,109,13) as varchar(13)) as AlterStock3
		, coalesce(dbo.Stockname(CAST(SUBSTRING(b.Com,109,13) as varchar(13)),2),'') as AlterStock3NameTH
		, coalesce(dbo.Stockname(CAST(SUBSTRING(b.Com,109,13) as varchar(13)),1),'') as AlterStock3NameEN

		, CAST(SUBSTRING(b.Com,141,13) as varchar(13)) as AlterStock4
		, coalesce(dbo.Stockname(CAST(SUBSTRING(b.Com,141,13) as varchar(13)),2),'') as AlterStock4NameTH
		, coalesce(dbo.Stockname(CAST(SUBSTRING(b.Com,141,13) as varchar(13)),1),'') as AlterStock4NameEN

		, CAST(SUBSTRING(b.Com,173,13) as varchar(13)) as AlterStock5
		, coalesce(dbo.Stockname(CAST(SUBSTRING(b.Com,173,13) as varchar(13)),2),'') as AlterStock5NameTH
		, coalesce(dbo.Stockname(CAST(SUBSTRING(b.Com,173,13) as varchar(13)),1),'') as AlterStock5NameEN

		, CAST(SUBSTRING(b.Com,205,13) as varchar(13)) as AlterStock6
		, coalesce(dbo.Stockname(CAST(SUBSTRING(b.Com,205,13) as varchar(13)),2),'') as AlterStock6NameTH
		, coalesce(dbo.Stockname(CAST(SUBSTRING(b.Com,205,13) as varchar(13)),1),'') as AlterStock6NameEN

		, CAST(SUBSTRING(b.Com,237,13) as varchar(13)) as AlterStock7
		, coalesce(dbo.Stockname(CAST(SUBSTRING(b.Com,237,13) as varchar(13)),2),'') as AlterStock7NameTH
		, coalesce(dbo.Stockname(CAST(SUBSTRING(b.Com,237,13) as varchar(13)),1),'') as AlterStock7NameEN

		, CAST(SUBSTRING(b.Com,269,13) as varchar(13)) as AlterStock8
		, coalesce(dbo.Stockname(CAST(SUBSTRING(b.Com,269,13) as varchar(13)),2),'') as AlterStock8NameTH
		, coalesce(dbo.Stockname(CAST(SUBSTRING(b.Com,269,13) as varchar(13)),1),'') as AlterStock8NameEN

		, CAST(SUBSTRING(b.Com,301,13) as varchar(13)) as AlterStock9
		, coalesce(dbo.Stockname(CAST(SUBSTRING(b.Com,301,13) as varchar(13)),2),'') as AlterStock9NameTH
		, coalesce(dbo.Stockname(CAST(SUBSTRING(b.Com,301,13) as varchar(13)),1),'') as AlterStock9NameEN

		, CAST(SUBSTRING(b.Com,333,13) as varchar(13)) as AlterStock10
		, coalesce(dbo.Stockname(CAST(SUBSTRING(b.Com,333,13) as varchar(13)),2),'') as AlterStock10NameTH
		, coalesce(dbo.Stockname(CAST(SUBSTRING(b.Com,333,13) as varchar(13)),1),'') as AlterStock10NameEN
from	DNSYSCONFIG a 
		inner join DNSYSCONFIG_DETAIL b on b.AdditionCode = 'MEDICINE' and a.CtrlCode = b.MasterCtrlCode and a.Code = b.Code
where	a.CtrlCode = 43541
		--and a.Code = 'PAY01'

