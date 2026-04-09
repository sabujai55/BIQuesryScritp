
select	
		'PTS' as BU
		, a.Code as FacilityMethodCode
		, dbo.CutSortChar(a.LocalName) as FacilityMethodNameTH
		, dbo.CutSortChar(a.EnglishName) as FacilityMethodNameEN

		, b.XrayCode as XrayCode --modify 2026-03-18
		, dbo.sysconname(b.XrayCode,42179,2) as XrayNameTH --modify 2026-03-18
		, dbo.sysconname(b.XrayCode,42179,1) as XrayNameEN --modify 2026-03-18

		, b.HNActivityCodeOPD as HNActivityCodeOPD --modify 2026-03-18
		, dbo.sysconname(b.HNActivityCodeOPD,42093,2) as HNActivityOPDNameTH --modify 2026-03-18
		, dbo.sysconname(b.HNActivityCodeOPD,42093,1) as HNActivityOPDNameEN --modify 2026-03-18

		, b.HNActivityCodeIPD as HNActivityCodeIPD --modify 2026-03-18
		, dbo.sysconname(b.HNActivityCodeIPD,42093,2) as HNActivityIPDNameTH --modify 2026-03-18
		, dbo.sysconname(b.HNActivityCodeIPD,42093,1) as HNActivityIPDNameEN --modify 2026-03-18

		, b.HNActivityCodeCheckUp as HNActivityCodeCheckup --modify 2026-03-18
		, dbo.sysconname(b.HNActivityCodeCheckUp,42093,2) as HNActivityCheckupNameTH --modify 2026-03-18
		, dbo.sysconname(b.HNActivityCodeCheckUp,42093,1) as HNActivityCheckupNameEN --modify 2026-03-18

		, b.Price as PriceOPD --modify 2026-03-18
		, b.Price as PriceIPD --modify 2026-03-18

		--, 'PriceOPD' = SIGN(CAST(substring(b.COM,8-0,1)+substring(b.COM,8-1,1)+substring(b.COM,8-2,1)+substring(b.COM,8-3,1)+substring(b.COM,8-4,1)+substring(b.COM,8-5,1)+substring(b.COM,8-6,1)+substring(b.COM,8-7,1) AS BIGINT))
		--  *(1.0 + (CAST(substring(b.COM,8-0,1)+substring(b.COM,8-1,1)+substring(b.COM,8-2,1)+substring(b.COM,8-3,1)+substring(b.COM,8-4,1)+substring(b.COM,8-5,1)+substring(b.COM,8-6,1)+substring(b.COM,8-7,1) AS BIGINT) & 0x000FFFFFFFFFFFFF) * POWER(CAST(2 AS FLOAT), -52))
		--  * POWER(CAST(2 AS FLOAT), (CAST(substring(b.COM,8-0,1)+substring(b.COM,8-1,1)+substring(b.COM,8-2,1)+substring(b.COM,8-3,1)+substring(b.COM,8-4,1)+substring(b.COM,8-5,1)+substring(b.COM,8-6,1)+substring(b.COM,8-7,1) AS BIGINT) & 0x7ff0000000000000) / 0x0010000000000000 - 1023)
		--, 'PriceIPD' = SIGN(CAST(substring(b.COM,8-0,1)+substring(b.COM,8-1,1)+substring(b.COM,8-2,1)+substring(b.COM,8-3,1)+substring(b.COM,8-4,1)+substring(b.COM,8-5,1)+substring(b.COM,8-6,1)+substring(b.COM,8-7,1) AS BIGINT))
		--  *(1.0 + (CAST(substring(b.COM,8-0,1)+substring(b.COM,8-1,1)+substring(b.COM,8-2,1)+substring(b.COM,8-3,1)+substring(b.COM,8-4,1)+substring(b.COM,8-5,1)+substring(b.COM,8-6,1)+substring(b.COM,8-7,1) AS BIGINT) & 0x000FFFFFFFFFFFFF) * POWER(CAST(2 AS FLOAT), -52))
		--  * POWER(CAST(2 AS FLOAT), (CAST(substring(b.COM,8-0,1)+substring(b.COM,8-1,1)+substring(b.COM,8-2,1)+substring(b.COM,8-3,1)+substring(b.COM,8-4,1)+substring(b.COM,8-5,1)+substring(b.COM,8-6,1)+substring(b.COM,8-7,1) AS BIGINT) & 0x7ff0000000000000) / 0x0010000000000000 - 1023)
		, b.DefaultCheck as DefaultCheck --modify 2026-03-18
		, b.FreeOfCharge as FreeOfCharge --modify 2026-03-18
from	DNSYSCONFIG a
		inner join DEVDECRYPT.dbo.PYTS_SETUP_FACILITYREQ_METHOD_DTL_XRAY b on a.Code=b.Code --modify 2026-03-18
where	a.CtrlCode = 42161