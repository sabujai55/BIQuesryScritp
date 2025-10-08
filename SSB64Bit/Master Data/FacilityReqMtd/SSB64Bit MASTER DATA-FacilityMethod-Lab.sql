use SSBLIVE
go

select	
		 'PT2' as BU
		, a.Code as FacilityMethodCode
		, dbo.CutSortChar(a.LocalName) as FacilityMethodNameTH
		, dbo.CutSortChar(a.EnglishName) as FacilityMethodNameEN

		, cast(substring(b.com,9,12) as varchar(12)) as LabCode
		, dbo.sysconname(cast(substring(b.com,9,12) as varchar(10)),42136,2) as LabNameTH
		, dbo.sysconname(cast(substring(b.com,9,12) as varchar(10)),42136,1) as LabNameEN

		, CAST(SUBSTRING(b.Com,19,7) AS varchar(7)) as SpecimenCode1
		, dbo.sysconname(CAST(SUBSTRING(b.Com,19,7) AS varchar(7)),42121,2) as SpecimenNameTH1
		, dbo.sysconname(CAST(SUBSTRING(b.Com,19,7) AS varchar(7)),42121,1) as SpecimenNameEN1

		, CAST(SUBSTRING(b.Com,27,7) AS varchar(7)) as SpecimenCode2
		, dbo.sysconname(CAST(SUBSTRING(b.Com,27,7) AS varchar(7)),42121,2) as SpecimenNameTH2
		, dbo.sysconname(CAST(SUBSTRING(b.Com,27,7) AS varchar(7)),42121,1) as SpecimenNameEN2

		, cast(substring(b.com,35,5) as varchar(10)) as HNActivityOPDCode
		, dbo.sysconname(cast(substring(b.com,35,5) as varchar(10)),42093,2) as HNActivityOPDNameTH
		, dbo.sysconname(cast(substring(b.com,35,5) as varchar(10)),42093,1) as HNActivityOPDNameEN

		, cast(substring(b.com,41,5) as varchar(10)) as HNActivityIPDCode
		, dbo.sysconname(cast(substring(b.com,41,5) as varchar(10)),42093,2) as HNActivityIPDNameTH
		, dbo.sysconname(cast(substring(b.com,41,5) as varchar(10)),42093,1) as HNActivityIPDNameEN

		, cast(substring(b.com,47,5) as varchar(10)) as HNActivityCheckupCode
		, dbo.sysconname(cast(substring(b.com,47,5) as varchar(10)),42093,2) as HNActivityCheckupNameTH
		, dbo.sysconname(cast(substring(b.com,47,5) as varchar(10)),42093,1) as HNActivityCheckupNameEN

		, '1' as Qty
		, 'PriceOPD' = SIGN(CAST(substring(b.COM,8-0,1)+substring(b.COM,8-1,1)+substring(b.COM,8-2,1)+substring(b.COM,8-3,1)+substring(b.COM,8-4,1)+substring(b.COM,8-5,1)+substring(b.COM,8-6,1)+substring(b.COM,8-7,1) AS BIGINT))
		  *(1.0 + (CAST(substring(b.COM,8-0,1)+substring(b.COM,8-1,1)+substring(b.COM,8-2,1)+substring(b.COM,8-3,1)+substring(b.COM,8-4,1)+substring(b.COM,8-5,1)+substring(b.COM,8-6,1)+substring(b.COM,8-7,1) AS BIGINT) & 0x000FFFFFFFFFFFFF) * POWER(CAST(2 AS FLOAT), -52))
		  * POWER(CAST(2 AS FLOAT), (CAST(substring(b.COM,8-0,1)+substring(b.COM,8-1,1)+substring(b.COM,8-2,1)+substring(b.COM,8-3,1)+substring(b.COM,8-4,1)+substring(b.COM,8-5,1)+substring(b.COM,8-6,1)+substring(b.COM,8-7,1) AS BIGINT) & 0x7ff0000000000000) / 0x0010000000000000 - 1023)
		, 'PriceIPD' = SIGN(CAST(substring(b.COM,8-0,1)+substring(b.COM,8-1,1)+substring(b.COM,8-2,1)+substring(b.COM,8-3,1)+substring(b.COM,8-4,1)+substring(b.COM,8-5,1)+substring(b.COM,8-6,1)+substring(b.COM,8-7,1) AS BIGINT))
		  *(1.0 + (CAST(substring(b.COM,8-0,1)+substring(b.COM,8-1,1)+substring(b.COM,8-2,1)+substring(b.COM,8-3,1)+substring(b.COM,8-4,1)+substring(b.COM,8-5,1)+substring(b.COM,8-6,1)+substring(b.COM,8-7,1) AS BIGINT) & 0x000FFFFFFFFFFFFF) * POWER(CAST(2 AS FLOAT), -52))
		  * POWER(CAST(2 AS FLOAT), (CAST(substring(b.COM,8-0,1)+substring(b.COM,8-1,1)+substring(b.COM,8-2,1)+substring(b.COM,8-3,1)+substring(b.COM,8-4,1)+substring(b.COM,8-5,1)+substring(b.COM,8-6,1)+substring(b.COM,8-7,1) AS BIGINT) & 0x7ff0000000000000) / 0x0010000000000000 - 1023)
		, cast(substring(b.com,53,1) as int) as DefaultCheck
		, cast(substring(b.com,54,1) as int) as FreeOfCharge
from	DNSYSCONFIG a
		join DNSYSCONFIG_DETAIL b on b.MasterCtrlCode = a.CtrlCode and b.Code = a.Code and b.additioncode = 'LAB'
where	a.CtrlCode = 42161