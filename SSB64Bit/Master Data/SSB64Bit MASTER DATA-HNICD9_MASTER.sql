select 'PT2' as BU 
		, IcdCmCode
		, dbo.CutSortChar(LocalName) as IcdCmNameTH
		, dbo.CutSortChar(EnglishName) as IcdCmNameEN
		, Off_ICDCM_MASTER as [Status]
				from HNICDCM_MASTER