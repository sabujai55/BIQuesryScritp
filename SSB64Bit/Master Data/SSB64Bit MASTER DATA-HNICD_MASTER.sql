use SSBLIVE
go

select	'PT2' as BU
		, IcdCode
		, dbo.cutsortchar(LocalName) as IcdNameTH
		, dbo.cutsortchar(EnglishName) as IcdNameEN
		, Chronic as IsChronic
		, null as IsSecret
		, case when Off_ICD_MASTER = 1 then 'Inactive' else 'Active' end as [Status]
from	HNICD_MASTER
order by IcdCode