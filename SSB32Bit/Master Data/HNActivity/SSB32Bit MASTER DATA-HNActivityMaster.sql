select
		  'PLS' as BU
		, act.CODE as HNActivityCode
		, dbo.CutSortChar(act.THAINAME) as HNActivityNameTH
		, dbo.CutSortChar(act.ENGLISHNAME) as HNActivityNameEN
		, '' as IncomeSummaryCode
		, '' as IncomeSummaryNameTH
		, '' as IncomeSummaryNameEN
		, cast(SUBSTRING(act.COM,91,3) as varchar(3)) as HNActivityCategoryCode
		, dbo.sysconname(cast(SUBSTRING(act.COM,91,3) as varchar(3)),10051,2) as HNActivityCategoryNameTH
		, dbo.sysconname(cast(SUBSTRING(act.COM,91,3) as varchar(3)),10051,1) as HNActivityCategoryNameEN
		, '' as ARActivityCode
		, '' as ARActivityNameTH
		, '' as ARActivityNameEN
		, '' as HospitalActivityTypeId
		, '' as HospitalActivityTypeName
		, '' as TypeofTransfertoDFId
		, '' as TypeofTransfertoDFName
				from SYSCONFIG act
				where act.CTRLCODE = 20023
