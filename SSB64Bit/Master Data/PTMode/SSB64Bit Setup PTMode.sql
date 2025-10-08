use SSBLIVE
go 

select	
		'PT2' as BU
		, a.Code as PTModeCode
		, dbo.CutSortChar(a.LocalName) as PTModeNameTH
		, dbo.CutSortChar(a.EnglishName) as PTModeNameEN
		, dbo.GetPriceFromSyscon(a.Com,8) as DefaultPriceOPD
		, dbo.GetPriceFromSyscon(a.Com,8) as DefaultPriceIPD
		, CAST(SUBSTRING(a.Com,25,5) as varchar(5)) as HNActivityOPDCode
		, dbo.sysconname(cast(substring(a.com,25,5) as varchar(10)),42093,2) as HNActivityOPDNameTH
		, dbo.sysconname(cast(substring(a.com,25,5) as varchar(10)),42093,1) as HNActivityOPDNameEN

		, CAST(SUBSTRING(a.Com,31,5) as varchar(5)) as HNActivityIPDCode
		, dbo.sysconname(cast(substring(a.com,31,5) as varchar(10)),42093,2) as HNActivityIPDNameTH
		, dbo.sysconname(cast(substring(a.com,31,5) as varchar(10)),42093,1) as HNActivityIPDNameEN

		, CAST(SUBSTRING(a.Com,37,5) as varchar(5)) as PTModeGroupCode
		, dbo.sysconname(cast(substring(a.com,37,5) as varchar(10)),42631,2) as PTModeGroupNameTH
		, dbo.sysconname(cast(substring(a.com,37,5) as varchar(10)),42631,1) as PTModeGroupNameEN

		, dbo.GetNumberFromSyscon(a.Com,43) as OpenPrice
		, dbo.GetNumberFromSyscon(a.Com,44) as [Off]
from	DNSYSCONFIG a
where	a.CtrlCode = 42632
		--and a.Code = 'PAY01'