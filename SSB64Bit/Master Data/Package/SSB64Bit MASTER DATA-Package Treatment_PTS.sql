select	'PTS' as BU
		, a.Code as PackageCode
		, coalesce(dbo.CutSortChar(a.LocalName),'') as PackageNameTH
		, coalesce(dbo.CutSortChar(a.EnglishName),'') as PackageNameEN

		, b.HNPackageItemCategoryCode as HNPackageItemCategory --modify 2026-03-18
		, coalesce(dbo.sysconname(b.HNPackageItemCategoryCode,43540,2),'') as HNPackageItemCategoryNameTH --modify 2026-03-18
		, coalesce(dbo.sysconname(b.HNPackageItemCategoryCode,43540,1),'') as HNPackageItemCategoryNameEN --modify 2026-03-18

		, b.Qty --modify 2026-03-18
		, b.LimitAmt --modify 2026-03-18
		--, Qty = SIGN(CAST(substring(b.Com,8-0,1)+substring(b.Com,8-1,1)+substring(b.Com,8-2,1)+substring(b.Com,8-3,1)+substring(b.Com,8-4,1)+substring(b.Com,8-5,1)+substring(b.Com,8-6,1)+substring(b.Com,8-7,1) AS BIGINT))
		--	  *(1.0 + (CAST(substring(b.Com,8-0,1)+substring(b.Com,8-1,1)+substring(b.Com,8-2,1)+substring(b.Com,8-3,1)+substring(b.Com,8-4,1)+substring(b.Com,8-5,1)+substring(b.Com,8-6,1)+substring(b.Com,8-7,1) AS BIGINT) & 0x000FFFFFFFFFFFFF) * POWER(CAST(2 AS FLOAT), -52))
		--	  * POWER(CAST(2 AS FLOAT), (CAST(substring(b.Com,8-0,1)+substring(b.Com,8-1,1)+substring(b.Com,8-2,1)+substring(b.Com,8-3,1)+substring(b.Com,8-4,1)+substring(b.Com,8-5,1)+substring(b.Com,8-6,1)+substring(b.Com,8-7,1) AS BIGINT) & 0x7ff0000000000000) / 0x0010000000000000 - 1023)
		--, LimitAmt = SIGN(CAST(substring(b.Com,16-0,1)+substring(b.Com,16-1,1)+substring(b.Com,16-2,1)+substring(b.Com,16-3,1)+substring(b.Com,16-4,1)+substring(b.Com,16-5,1)+substring(b.Com,16-6,1)+substring(b.Com,16-7,1) AS BIGINT))
		--	  *(1.0 + (CAST(substring(b.Com,16-0,1)+substring(b.Com,16-1,1)+substring(b.Com,16-2,1)+substring(b.Com,16-3,1)+substring(b.Com,16-4,1)+substring(b.Com,16-5,1)+substring(b.Com,16-6,1)+substring(b.Com,16-7,1) AS BIGINT) & 0x000FFFFFFFFFFFFF) * POWER(CAST(2 AS FLOAT), -52))
		--	  * POWER(CAST(2 AS FLOAT), (CAST(substring(b.Com,16-0,1)+substring(b.Com,16-1,1)+substring(b.Com,16-2,1)+substring(b.Com,16-3,1)+substring(b.Com,16-4,1)+substring(b.Com,16-5,1)+substring(b.Com,16-6,1)+substring(b.Com,16-7,1) AS BIGINT) & 0x7ff0000000000000) / 0x0010000000000000 - 1023)
		
		, b.HNActivityCode as HNActivityCode --modify 2026-03-18
		, coalesce(dbo.sysconname(b.HNActivityCode,42093,2),'') as HNActivityNameTH --modify 2026-03-18
		, coalesce(dbo.sysconname(b.HNActivityCode,42093,1),'') as HNActivityNameEN --modify 2026-03-18

		, b.LabCode as LabCode --modify 2026-03-18
		, coalesce(dbo.sysconname(b.LabCode,42136,2),'') as LabNameTH --modify 2026-03-18
		, coalesce(dbo.sysconname(b.LabCode,42136,1),'') as LabNameEN --modify 2026-03-18

		, b.XrayCode as XrayCode --modify 2026-03-18
		, coalesce(dbo.sysconname(b.XrayCode,42179,2),'') as XrayNameTH --modify 2026-03-18
		, coalesce(dbo.sysconname(b.XrayCode,42179,1),'') as XrayNameEN --modify 2026-03-18

		, b.TreatmentCode as TreatmentCode --modify 2026-03-18
		, coalesce(dbo.sysconname(b.TreatmentCode,42075,2),'') as TreatmentNameTH --modify 2026-03-18
		, coalesce(dbo.sysconname(b.TreatmentCode,42075,1),'') as TreatmentNameEN --modify 2026-03-18
from	DNSYSCONFIG a 
		inner join DEVDECRYPT.dbo.PYTS_SETUP_HN_HN_PACKAGE_TREATMENT b on a.Code=b.Code --modify 2026-03-18
where	a.CtrlCode = 43541