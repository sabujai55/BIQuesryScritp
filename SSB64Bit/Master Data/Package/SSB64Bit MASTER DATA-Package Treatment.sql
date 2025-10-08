use SSBLIVE
go
--42179

select	'PT2' as BU
		, a.Code as PackageCode
		, coalesce(dbo.CutSortChar(a.LocalName),'') as PackageNameTH
		, coalesce(dbo.CutSortChar(a.EnglishName),'') as PackageNameEN

		, CAST(SUBSTRING(b.Com,17,3) as varchar(3)) as HNPackageItemCategory
		, coalesce(dbo.sysconname(CAST(SUBSTRING(b.Com,17,3) as varchar(3)),43540,2),'') as HNPackageItemCategoryNameTH
		, coalesce(dbo.sysconname(CAST(SUBSTRING(b.Com,17,3) as varchar(3)),43540,1),'') as HNPackageItemCategoryNameEN

		, Qty = SIGN(CAST(substring(b.Com,8-0,1)+substring(b.Com,8-1,1)+substring(b.Com,8-2,1)+substring(b.Com,8-3,1)+substring(b.Com,8-4,1)+substring(b.Com,8-5,1)+substring(b.Com,8-6,1)+substring(b.Com,8-7,1) AS BIGINT))
			  *(1.0 + (CAST(substring(b.Com,8-0,1)+substring(b.Com,8-1,1)+substring(b.Com,8-2,1)+substring(b.Com,8-3,1)+substring(b.Com,8-4,1)+substring(b.Com,8-5,1)+substring(b.Com,8-6,1)+substring(b.Com,8-7,1) AS BIGINT) & 0x000FFFFFFFFFFFFF) * POWER(CAST(2 AS FLOAT), -52))
			  * POWER(CAST(2 AS FLOAT), (CAST(substring(b.Com,8-0,1)+substring(b.Com,8-1,1)+substring(b.Com,8-2,1)+substring(b.Com,8-3,1)+substring(b.Com,8-4,1)+substring(b.Com,8-5,1)+substring(b.Com,8-6,1)+substring(b.Com,8-7,1) AS BIGINT) & 0x7ff0000000000000) / 0x0010000000000000 - 1023)
		, LimitAmt = SIGN(CAST(substring(b.Com,16-0,1)+substring(b.Com,16-1,1)+substring(b.Com,16-2,1)+substring(b.Com,16-3,1)+substring(b.Com,16-4,1)+substring(b.Com,16-5,1)+substring(b.Com,16-6,1)+substring(b.Com,16-7,1) AS BIGINT))
			  *(1.0 + (CAST(substring(b.Com,16-0,1)+substring(b.Com,16-1,1)+substring(b.Com,16-2,1)+substring(b.Com,16-3,1)+substring(b.Com,16-4,1)+substring(b.Com,16-5,1)+substring(b.Com,16-6,1)+substring(b.Com,16-7,1) AS BIGINT) & 0x000FFFFFFFFFFFFF) * POWER(CAST(2 AS FLOAT), -52))
			  * POWER(CAST(2 AS FLOAT), (CAST(substring(b.Com,16-0,1)+substring(b.Com,16-1,1)+substring(b.Com,16-2,1)+substring(b.Com,16-3,1)+substring(b.Com,16-4,1)+substring(b.Com,16-5,1)+substring(b.Com,16-6,1)+substring(b.Com,16-7,1) AS BIGINT) & 0x7ff0000000000000) / 0x0010000000000000 - 1023)
		
		, CAST(SUBSTRING(b.Com,33,5) as varchar(5)) as HNActivityCode
		, coalesce(dbo.sysconname(CAST(SUBSTRING(b.Com,33,5) as varchar(5)),42093,2),'') as HNActivityNameTH
		, coalesce(dbo.sysconname(CAST(SUBSTRING(b.Com,33,5) as varchar(5)),42093,1),'') as HNActivityNameEN

		, CAST(SUBSTRING(b.Com,49,19) as varchar(19)) as LabCode
		, coalesce(dbo.sysconname(CAST(SUBSTRING(b.Com,49,19) as varchar(19)),42136,2),'') as LabNameTH
		, coalesce(dbo.sysconname(CAST(SUBSTRING(b.Com,49,19) as varchar(19)),42136,1),'') as LabNameEN

		, CAST(SUBSTRING(b.Com,39,9) as varchar(9)) as XrayCode
		, coalesce(dbo.sysconname(CAST(SUBSTRING(b.Com,39,9) as varchar(9)),42179,2),'') as XrayNameTH
		, coalesce(dbo.sysconname(CAST(SUBSTRING(b.Com,39,9) as varchar(9)),42179,1),'') as XrayNameEN

		, CAST(SUBSTRING(b.Com,21,11) as varchar(11)) as TreatmentCode
		, coalesce(dbo.sysconname(CAST(SUBSTRING(b.Com,21,11) as varchar(9)),42075,2),'') as TreatmentNameTH
		, coalesce(dbo.sysconname(CAST(SUBSTRING(b.Com,21,11) as varchar(9)),42075,1),'') as TreatmentNameEN
from	DNSYSCONFIG a 
		inner join DNSYSCONFIG_DETAIL b on b.AdditionCode = 'TREATMENT' and a.CtrlCode = b.MasterCtrlCode and a.Code = b.Code
where	a.CtrlCode = 43541
		--and a.Code = 'PAY01'