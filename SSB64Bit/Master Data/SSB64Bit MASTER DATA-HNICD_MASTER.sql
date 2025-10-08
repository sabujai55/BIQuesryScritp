select	IcdCode
		, dbo.cutsortchar(LocalName) as IcdNameTH
		, dbo.cutsortchar(EnglishName) as IcdNameEN
		, Chronic as IsChronic
		, '' as IsSecret
		, Off_ICD_MASTER as [Status]
from	HNICD_MASTER