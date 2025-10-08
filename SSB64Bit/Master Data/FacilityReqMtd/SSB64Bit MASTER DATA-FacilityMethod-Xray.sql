use SSBLIVE
go

select	
		'PT2' as BU
		, a.Code as FacilityMethodCode
		, dbo.CutSortChar(a.LocalName) as FacilityMethodNameTH
		, dbo.CutSortChar(a.EnglishName) as FacilityMethodNameEN

		, cast(substring(b.com,17,10) as varchar(10)) as XrayCode
		, dbo.sysconname(cast(substring(b.com,17,10) as varchar(10)),42179,2) as XrayNameTH
		, dbo.sysconname(cast(substring(b.com,17,10) as varchar(10)),42179,1) as XrayNameEN
		, cast(substring(b.com,27,5) as varchar(10)) as HNActivityCodeOPD
		, dbo.sysconname(cast(substring(b.com,27,5) as varchar(10)),42093,2) as HNActivityOPDNameTH
		, dbo.sysconname(cast(substring(b.com,27,5) as varchar(10)),42093,1) as HNActivityOPDNameEN

		, cast(substring(b.com,33,5) as varchar(10)) as HNActivityCodeIPD
		, dbo.sysconname(cast(substring(b.com,33,5) as varchar(10)),42093,2) as HNActivityIPDNameTH
		, dbo.sysconname(cast(substring(b.com,33,5) as varchar(10)),42093,1) as HNActivityIPDNameEN

		, cast(substring(b.com,39,5) as varchar(10)) as HNActivityCodeCheckup
		, dbo.sysconname(cast(substring(b.com,39,5) as varchar(10)),42093,2) as HNActivityCheckupNameTH
		, dbo.sysconname(cast(substring(b.com,39,5) as varchar(10)),42093,1) as HNActivityCheckupNameEN

		, 'PriceOPD' = SIGN(CAST(substring(b.COM,8-0,1)+substring(b.COM,8-1,1)+substring(b.COM,8-2,1)+substring(b.COM,8-3,1)+substring(b.COM,8-4,1)+substring(b.COM,8-5,1)+substring(b.COM,8-6,1)+substring(b.COM,8-7,1) AS BIGINT))
		  *(1.0 + (CAST(substring(b.COM,8-0,1)+substring(b.COM,8-1,1)+substring(b.COM,8-2,1)+substring(b.COM,8-3,1)+substring(b.COM,8-4,1)+substring(b.COM,8-5,1)+substring(b.COM,8-6,1)+substring(b.COM,8-7,1) AS BIGINT) & 0x000FFFFFFFFFFFFF) * POWER(CAST(2 AS FLOAT), -52))
		  * POWER(CAST(2 AS FLOAT), (CAST(substring(b.COM,8-0,1)+substring(b.COM,8-1,1)+substring(b.COM,8-2,1)+substring(b.COM,8-3,1)+substring(b.COM,8-4,1)+substring(b.COM,8-5,1)+substring(b.COM,8-6,1)+substring(b.COM,8-7,1) AS BIGINT) & 0x7ff0000000000000) / 0x0010000000000000 - 1023)
		, 'PriceIPD' = SIGN(CAST(substring(b.COM,8-0,1)+substring(b.COM,8-1,1)+substring(b.COM,8-2,1)+substring(b.COM,8-3,1)+substring(b.COM,8-4,1)+substring(b.COM,8-5,1)+substring(b.COM,8-6,1)+substring(b.COM,8-7,1) AS BIGINT))
		  *(1.0 + (CAST(substring(b.COM,8-0,1)+substring(b.COM,8-1,1)+substring(b.COM,8-2,1)+substring(b.COM,8-3,1)+substring(b.COM,8-4,1)+substring(b.COM,8-5,1)+substring(b.COM,8-6,1)+substring(b.COM,8-7,1) AS BIGINT) & 0x000FFFFFFFFFFFFF) * POWER(CAST(2 AS FLOAT), -52))
		  * POWER(CAST(2 AS FLOAT), (CAST(substring(b.COM,8-0,1)+substring(b.COM,8-1,1)+substring(b.COM,8-2,1)+substring(b.COM,8-3,1)+substring(b.COM,8-4,1)+substring(b.COM,8-5,1)+substring(b.COM,8-6,1)+substring(b.COM,8-7,1) AS BIGINT) & 0x7ff0000000000000) / 0x0010000000000000 - 1023)
		, cast(substring(b.com,45,1) as int) as DefaultCheck
		, cast(substring(b.com,46,1) as int) as FreeOfCharge
from	DNSYSCONFIG a
		join DNSYSCONFIG_DETAIL b on b.MasterCtrlCode = a.CtrlCode and b.Code = a.Code and b.additioncode = 'XRAY'
where	a.CtrlCode = 42161