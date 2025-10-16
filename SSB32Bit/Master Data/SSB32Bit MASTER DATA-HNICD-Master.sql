select
	  'PLS' as BU
	, icd.ICDCODE as IcdCode
	, icd.THAINAME as IcdNameTH
	, icd.ENGLISHNAME as IcdNameEN
	, icd.CHRONIC as IsChronic
	, '' as IsSecret
	, icd.ICDOFF as [Status]
			from ICD_MASTER icd