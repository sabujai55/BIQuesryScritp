select
		  'PLS' as BU
		, arg.CODE as ARCode
		, dbo.CutSortChar(arm.THAINAME) as ARNameTH
		, dbo.CutSortChar(arm.ENGLISHNAME) as ARNameEN
		, arg.SUFFIX as SuffixTiny
		, '' as CustomerDept
		, CAST(SUBSTRING(arg.COM,1,7)as varchar) as MaleFacilityRequestMethod
		, dbo.sysconname(CAST(SUBSTRING(arg.COM,1,7)as varchar),20120,2) as MaleFacilityRequestMethodNameTH
		, dbo.sysconname(CAST(SUBSTRING(arg.COM,1,7)as varchar),20120,1) as MaleFacilityRequestMethodNameEN
		, CAST(SUBSTRING(arg.COM,1,7)as varchar) as FemaleFacilityRequestMethod
		, dbo.sysconname(CAST(SUBSTRING(arg.COM,1,7)as varchar),20120,2) as FemaleFacilityRequestMethodNameTH
		, dbo.sysconname(CAST(SUBSTRING(arg.COM,1,7)as varchar),20120,1) as FemaleFacilityRequestMethodNameEN
		, '' as RemarksMemo
		, case 
			when convert(varchar(4),convert(int,substring(arg.com,14,1) + SUBSTRING(arg.com,13,1)))+'-'+convert(varchar(2),convert(int,substring(arg.com,15,1)))+'-'+convert(varchar(2),convert(int,substring(arg.com,17,1))) in ('99-99-99','0-0-0') then ''
			else Convert(datetime,convert(varchar(4),convert(int,substring(arg.com,14,1) + SUBSTRING(arg.com,13,1)))+'-'+convert(varchar(2),convert(int,substring(arg.com,15,1)))+'-'+convert(varchar(2),convert(int,substring(arg.com,17,1)))) end as EffDateFrom
		,  case 
			when convert(varchar(4),convert(int,substring(arg.com,30,1) + SUBSTRING(arg.com,29,1)))+'-'+convert(varchar(2),convert(int,substring(arg.com,31,1)))+'-'+convert(varchar(2),convert(int,substring(arg.com,33,1))) in ('99-99-99','0-0-0') then ''
			else Convert(datetime,convert(varchar(4),convert(int,substring(arg.com,30,1) + SUBSTRING(arg.com,29,1)))+'-'+convert(varchar(2),convert(int,substring(arg.com,31,1)))+'-'+convert(varchar(2),convert(int,substring(arg.com,33,1)))) end as EffDateTo
				from SYSCONFIG_DETAIL arg
				left join SSBBACKOFFICE.dbo.ARMASTER arm on arg.CODE=arm.ARCODE 
				where arg.CTRLCODE = 10089