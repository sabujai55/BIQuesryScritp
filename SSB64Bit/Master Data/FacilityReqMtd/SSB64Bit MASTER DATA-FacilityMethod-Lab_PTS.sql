select	
		 'PTS' as BU
		, a.Code as FacilityMethodCode
		, dbo.CutSortChar(a.LocalName) as FacilityMethodNameTH
		, dbo.CutSortChar(a.EnglishName) as FacilityMethodNameEN

		, c.labcode as LabCode --modify 2026-03-18
		, dbo.sysconname(c.labcode,42136,2) as LabNameTH --modify 2026-03-18
		, dbo.sysconname(c.labcode,42136,1) as LabNameEN --modify 2026-03-18

		,c.SpecimenCode1 as SpecimenCode1 --modify 2026-03-18
		, dbo.sysconname(c.SpecimenCode1,42121,2) as SpecimenNameTH1 --modify 2026-03-18
		, dbo.sysconname(c.SpecimenCode1,42121,1) as SpecimenNameEN1 --modify 2026-03-18

		, c.SpecimenCode2 as SpecimenCode2 --modify 2026-03-18
		, dbo.sysconname(c.SpecimenCode2,42121,2) as SpecimenNameTH2 --modify 2026-03-18
		, dbo.sysconname(c.SpecimenCode2,42121,1) as SpecimenNameEN2 --modify 2026-03-18

		, c.hnactivitycodeopd as HNActivityOPDCode --modify 2026-03-18
		, dbo.sysconname(c.hnactivitycodeopd,42093,2) as HNActivityOPDNameTH --modify 2026-03-18
		, dbo.sysconname(c.hnactivitycodeopd,42093,1) as HNActivityOPDNameEN --modify 2026-03-18

		, c.hnactivitycodeipd as HNActivityIPDCode --modify 2026-03-18
		, dbo.sysconname(c.hnactivitycodeipd,42093,2) as HNActivityIPDNameTH --modify 2026-03-18
		, dbo.sysconname(c.hnactivitycodeipd,42093,1) as HNActivityIPDNameEN --modify 2026-03-18

		, c.hnactivitycodecheckup as HNActivityCheckupCode --modify 2026-03-18
		, dbo.sysconname(c.hnactivitycodecheckup,42093,2) as HNActivityCheckupNameTH --modify 2026-03-18
		, dbo.sysconname(c.hnactivitycodecheckup,42093,1) as HNActivityCheckupNameEN --modify 2026-03-18

		, c.qty as Qty --modify 2026-03-18
		, c.price as PriceOPD --modify 2026-03-18
		, c.price as PriceIPD --modify 2026-03-18
		--, 'PriceOPD' = SIGN(CAST(substring(b.COM,8-0,1)+substring(b.COM,8-1,1)+substring(b.COM,8-2,1)+substring(b.COM,8-3,1)+substring(b.COM,8-4,1)+substring(b.COM,8-5,1)+substring(b.COM,8-6,1)+substring(b.COM,8-7,1) AS BIGINT))
		--  *(1.0 + (CAST(substring(b.COM,8-0,1)+substring(b.COM,8-1,1)+substring(b.COM,8-2,1)+substring(b.COM,8-3,1)+substring(b.COM,8-4,1)+substring(b.COM,8-5,1)+substring(b.COM,8-6,1)+substring(b.COM,8-7,1) AS BIGINT) & 0x000FFFFFFFFFFFFF) * POWER(CAST(2 AS FLOAT), -52))
		--  * POWER(CAST(2 AS FLOAT), (CAST(substring(b.COM,8-0,1)+substring(b.COM,8-1,1)+substring(b.COM,8-2,1)+substring(b.COM,8-3,1)+substring(b.COM,8-4,1)+substring(b.COM,8-5,1)+substring(b.COM,8-6,1)+substring(b.COM,8-7,1) AS BIGINT) & 0x7ff0000000000000) / 0x0010000000000000 - 1023)
		--, 'PriceIPD' = SIGN(CAST(substring(b.COM,8-0,1)+substring(b.COM,8-1,1)+substring(b.COM,8-2,1)+substring(b.COM,8-3,1)+substring(b.COM,8-4,1)+substring(b.COM,8-5,1)+substring(b.COM,8-6,1)+substring(b.COM,8-7,1) AS BIGINT))
		--  *(1.0 + (CAST(substring(b.COM,8-0,1)+substring(b.COM,8-1,1)+substring(b.COM,8-2,1)+substring(b.COM,8-3,1)+substring(b.COM,8-4,1)+substring(b.COM,8-5,1)+substring(b.COM,8-6,1)+substring(b.COM,8-7,1) AS BIGINT) & 0x000FFFFFFFFFFFFF) * POWER(CAST(2 AS FLOAT), -52))
		--  * POWER(CAST(2 AS FLOAT), (CAST(substring(b.COM,8-0,1)+substring(b.COM,8-1,1)+substring(b.COM,8-2,1)+substring(b.COM,8-3,1)+substring(b.COM,8-4,1)+substring(b.COM,8-5,1)+substring(b.COM,8-6,1)+substring(b.COM,8-7,1) AS BIGINT) & 0x7ff0000000000000) / 0x0010000000000000 - 1023)
		, c.DefaultCheck as DefaultCheck --modify 2026-03-18
		, c.FreeOfCharge as FreeOfCharge --modify 2026-03-18
from	DNSYSCONFIG a
		--inner join DNSYSCONFIG_DETAIL b on b.MasterCtrlCode = a.CtrlCode and b.Code = a.Code and b.additioncode = 'LAB'
		inner join DEVDECRYPT.dbo.PYTS_SETUP_FACILITYREQ_METHOD_DTL_LAB c on a.Code=c.code  
where	a.CtrlCode = 42161

