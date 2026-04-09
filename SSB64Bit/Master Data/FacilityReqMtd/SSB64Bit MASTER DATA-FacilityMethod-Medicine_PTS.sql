select	
		'PTS' as BU
		, a.Code as FacilityMethodCode
		, dbo.CutSortChar(a.LocalName) as FacilityMethodNameTH
		, dbo.CutSortChar(a.EnglishName) as FacilityMethodNameEN
		, b.Store as Store --modify 2026-03-18
		, b.StockCode as ItemCode --modify 2026-03-18
		, coalesce(dbo.cutsortchar(c.LocalName),'') as ItemNameTH --modify 2026-03-18
		, coalesce(dbo.cutsortchar(c.EngLishName),'') as ItemNameEN --modify 2026-03-18
		, b.HNActivityCodeOPD as HNActivityCodeOPD --modify 2026-03-18
		, dbo.sysconname(b.HNActivityCodeOPD,42093,2) as HNActivityOPDNameTH --modify 2026-03-18
		, dbo.sysconname(b.HNActivityCodeOPD,42093,1) as HNActivityOPDNameEN --modify 2026-03-18
		, b.HNActivityCodeIPD as HNActivityCodeIPD --modify 2026-03-18
		, dbo.sysconname(b.HNActivityCodeIPD,42093,2) as HNActivityIPDNameTH --modify 2026-03-18
		, dbo.sysconname(b.HNActivityCodeIPD,42093,1) as HNActivityIPDNameEH --modify 2026-03-18
		, b.HNActivityCodeCheckUp as HNActivityCodeCheckup --modify 2026-03-18
		, dbo.sysconname(b.HNActivityCodeCheckUp,42093,2) as HNActivityCheckupNameTH --modify 2026-03-18
		, dbo.sysconname(b.HNActivityCodeCheckUp,42093,1) as HNActivityCheckupNameEN --modify 2026-03-18
		, b.Qty --modify 2026-03-18
		, b.ChargeAmt as PriceOPD --modify 2026-03-18
		, b.ChargeAmt as PriceIPD --modify 2026-03-18
		--, 'Qty' = SIGN(CAST(substring(b.COM,8-0,1)+substring(b.COM,8-1,1)+substring(b.COM,8-2,1)+substring(b.COM,8-3,1)+substring(b.COM,8-4,1)+substring(b.COM,8-5,1)+substring(b.COM,8-6,1)+substring(b.COM,8-7,1) AS BIGINT))
		--  *(1.0 + (CAST(substring(b.COM,8-0,1)+substring(b.COM,8-1,1)+substring(b.COM,8-2,1)+substring(b.COM,8-3,1)+substring(b.COM,8-4,1)+substring(b.COM,8-5,1)+substring(b.COM,8-6,1)+substring(b.COM,8-7,1) AS BIGINT) & 0x000FFFFFFFFFFFFF) * POWER(CAST(2 AS FLOAT), -52))
		--  * POWER(CAST(2 AS FLOAT), (CAST(substring(b.COM,8-0,1)+substring(b.COM,8-1,1)+substring(b.COM,8-2,1)+substring(b.COM,8-3,1)+substring(b.COM,8-4,1)+substring(b.COM,8-5,1)+substring(b.COM,8-6,1)+substring(b.COM,8-7,1) AS BIGINT) & 0x7ff0000000000000) / 0x0010000000000000 - 1023)
		--, 'PriceOPD' = SIGN(CAST(substring(b.COM,16-0,1)+substring(b.COM,16-1,1)+substring(b.COM,16-2,1)+substring(b.COM,16-3,1)+substring(b.COM,16-4,1)+substring(b.COM,16-5,1)+substring(b.COM,16-6,1)+substring(b.COM,16-7,1) AS BIGINT))
		--  *(1.0 + (CAST(substring(b.COM,16-0,1)+substring(b.COM,16-1,1)+substring(b.COM,16-2,1)+substring(b.COM,16-3,1)+substring(b.COM,16-4,1)+substring(b.COM,16-5,1)+substring(b.COM,16-6,1)+substring(b.COM,16-7,1) AS BIGINT) & 0x000FFFFFFFFFFFFF) * POWER(CAST(2 AS FLOAT), -52))
		--  * POWER(CAST(2 AS FLOAT), (CAST(substring(b.COM,16-0,1)+substring(b.COM,16-1,1)+substring(b.COM,16-2,1)+substring(b.COM,16-3,1)+substring(b.COM,16-4,1)+substring(b.COM,16-5,1)+substring(b.COM,16-6,1)+substring(b.COM,16-7,1) AS BIGINT) & 0x7ff0000000000000) / 0x0010000000000000 - 1023)
		--, 'PriceIPD' = SIGN(CAST(substring(b.COM,16-0,1)+substring(b.COM,16-1,1)+substring(b.COM,16-2,1)+substring(b.COM,16-3,1)+substring(b.COM,16-4,1)+substring(b.COM,16-5,1)+substring(b.COM,16-6,1)+substring(b.COM,16-7,1) AS BIGINT))
		--  *(1.0 + (CAST(substring(b.COM,16-0,1)+substring(b.COM,16-1,1)+substring(b.COM,16-2,1)+substring(b.COM,16-3,1)+substring(b.COM,16-4,1)+substring(b.COM,16-5,1)+substring(b.COM,16-6,1)+substring(b.COM,16-7,1) AS BIGINT) & 0x000FFFFFFFFFFFFF) * POWER(CAST(2 AS FLOAT), -52))
		--  * POWER(CAST(2 AS FLOAT), (CAST(substring(b.COM,16-0,1)+substring(b.COM,16-1,1)+substring(b.COM,16-2,1)+substring(b.COM,16-3,1)+substring(b.COM,16-4,1)+substring(b.COM,16-5,1)+substring(b.COM,16-6,1)+substring(b.COM,16-7,1) AS BIGINT) & 0x7ff0000000000000) / 0x0010000000000000 - 1023)
		, case when b.HNChargeType = 0 then 'None'  
			  when b.HNChargeType = 1 then 'FreeOfCharge ' 
			  when b.HNChargeType = 2 then 'Refund' 
			  when b.HNChargeType = 3 then 'Adjust' 
			  when b.HNChargeType = 5 then 'ChargeByDefault' 
			  when b.HNChargeType = 6 then 'FreeOfChargeReturn ' end as HNChargeType --modify 2026-03-18
		, b.DefaultCheck as DefaultCheck --modify 2026-03-18
from	DNSYSCONFIG a
		inner join DEVDECRYPT.dbo.PYTS_SETUP_FACILITYREQ_METHOD_DTL_MEDICINE b on a.Code=b.Code
		--join DNSYSCONFIG_DETAIL b on b.MasterCtrlCode = a.CtrlCode and b.Code = a.Code and b.additioncode = 'MEDICINE'
		join stockmaster c on b.StockCode = c.stockcode
where	a.CtrlCode = 42161