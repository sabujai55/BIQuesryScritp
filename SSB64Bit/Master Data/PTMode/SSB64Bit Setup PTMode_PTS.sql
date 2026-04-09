select	
		'PTS' as BU
		, a.Code as PTModeCode
		, dbo.CutSortChar(a.LocalName) as PTModeNameTH
		, dbo.CutSortChar(a.EnglishName) as PTModeNameEN
		, b.DefaultPrice as DefaultPriceOPD --modify 2026-03-17
		, b.IPDDefaultPrice as DefaultPriceIPD --modify 2026-03-17

		, b.HNActivityCodeOPD as HNActivityOPDCode --modify 2026-03-17
		, dbo.sysconname(b.HNActivityCodeOPD,42093,2) as HNActivityOPDNameTH --modify 2026-03-17
		, dbo.sysconname(b.HNActivityCodeOPD,42093,1) as HNActivityOPDNameEN --modify 2026-03-17

		, b.HNActivityCodeIPD as HNActivityIPDCode --modify 2026-03-17
		, dbo.sysconname(b.HNActivityCodeIPD,42093,2) as HNActivityIPDNameTH --modify 2026-03-17
		, dbo.sysconname(b.HNActivityCodeIPD,42093,1) as HNActivityIPDNameEN --modify 2026-03-17

		, b.PTModeGroupCode as PTModeGroupCode --modify 2026-03-17
		, dbo.sysconname(b.PTModeGroupCode,42631,2) as PTModeGroupNameTH --modify 2026-03-17
		, dbo.sysconname(b.PTModeGroupCode,42631,1) as PTModeGroupNameEN --modify 2026-03-17

		, b.OpenPrice as OpenPrice --modify 2026-03-17
		, b.OffCode as [Off] --modify 2026-03-17
from	DNSYSCONFIG a
		left join DEVDECRYPT.dbo.PYTS_SETUP_PT_MODE_CODE b on a.Code=b.Code --modify 2026-03-17
where	a.CtrlCode = 42632