select top 100
	'PT2' as BU
	, arg.ARCode
	, dbo.CutSortChar(ar.LocalName) as ARNameTH
	, dbo.CutSortChar(ar.EnglishName) as ARNameEN
	, arg.SuffixTiny
	, arg.CustomerDept
	, arg.MaleFacilityRequestMethod
	, dbo.sysconname(arg.MaleFacilityRequestMethod,42161,2) as MaleFacilityRequestMethodNameTH
	, dbo.sysconname(arg.MaleFacilityRequestMethod,42161,1) as MaleFacilityRequestMethodNameEN
	, arg.FemaleFacilityRequestMethod
	, dbo.sysconname(arg.FemaleFacilityRequestMethod,42161,2) as FemaleFacilityRequestMethodNameTH
	, dbo.sysconname(arg.FemaleFacilityRequestMethod,42161,1) as FemaleFacilityRequestMethodNameEN
	, arg.RemarksMemo
	, arg.EffDateFrom
	, arg.EffDateTo
		from ARMASTER_HN_GROUPREQ arg
		inner join ARMASTER ar on arg.ARCode=arg.ARCode