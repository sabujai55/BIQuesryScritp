select
		  'PTP' as BU
		, A.CODE as PTModeCode
		, dbo.CutSortChar(A.THAINAME) as PTModeNameTH
		, dbo.CutSortChar(A.ENGLISHNAME) as PTModeNameEN
		, dbo.GetPriceFromSyscon(A.COM,8) as DefaultPriceOPD
		, dbo.GetPriceFromSyscon(A.COM,56) as DefaultPriceIPD
		, cast(substring(a.COM, 31,5) as varchar(5)) as HNActivityOPDCode
		, dbo.sysconname(cast(substring(a.COM, 31,5) as varchar(5)),20023,2) as HNActivityOPDNameTH
		, dbo.sysconname(cast(substring(a.COM, 31,5) as varchar(5)),20023,1) as HNActivityOPDNameEN
		, cast(substring(a.COM, 57,5) as varchar(5)) as HNActivityIPDCode
		, dbo.sysconname(cast(substring(a.COM, 57,5) as varchar(5)),20023,2) as HNActivityIPDNameTH
		, dbo.sysconname(cast(substring(a.COM, 57,5) as varchar(5)),20023,1) as HNActivityIPDNameEN
		, '' as PTModeGroupCode
		, '' as PTModeGroupNameTH
		, '' as PTModeGroupNameEN
		, '' as OpenPrice
		, Convert(int, substring(com,243,1)) as [Off]
				from SYSCONFIG A
				WHERE CTRLCODE = 20104
