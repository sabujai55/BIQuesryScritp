use SSBLIVE
go

select	
		 'PT2' as BU
		, a.Code as FacilityMethodCode
		, dbo.CutSortChar(a.LocalName) as FacilityMethodNameTH
		, dbo.CutSortChar(a.EnglishName) as FacilityMethodNameEN
		, '' as EffectiveDateFrom
		, '' as EffectiveDateto
		, CAST(SUBSTRING(a.Com, 4, 1) as int) as GenderOnlyId
		, case when CAST(SUBSTRING(a.Com, 4, 1) as int) = 0 then 'None'
		  when CAST(SUBSTRING(a.Com, 4, 1) as int) = 1 then 'หญิง'
		  when CAST(SUBSTRING(a.Com, 4, 1) as int) = 2 then 'ชาย'
		  when CAST(SUBSTRING(a.Com, 4, 1) as int) = 3 then 'ไม่ระบุเพศ'
		  else '' end  as GenderOnlyName

		, CONCAT((CAST(CAST(SUBSTRING(a.Com, 166, 1) + SUBSTRING(a.Com, 165, 1) as varbinary(2)) AS int) / 360), ' ปี ') +
		  CONCAT(((CAST(CAST(SUBSTRING(a.Com, 166, 1) + SUBSTRING(a.Com, 165, 1) as varbinary(2)) AS int) % 360) / 30), ' เดือน ') +
		  CONCAT(((CAST(CAST(SUBSTRING(a.Com, 166, 1) + SUBSTRING(a.Com, 165, 1) as varbinary(2)) AS int) % 360) % 30), ' วัน') as NoDayAgeFrom

		, CONCAT((CAST(CAST(SUBSTRING(a.Com, 170, 1) + SUBSTRING(a.Com, 169, 1) as varbinary(2)) AS int) / 360), ' ปี ') +
		  CONCAT(((CAST(CAST(SUBSTRING(a.Com, 170, 1) + SUBSTRING(a.Com, 169, 1) as varbinary(2)) AS int) % 360) / 30), ' เดือน ') +
		  CONCAT(((CAST(CAST(SUBSTRING(a.Com, 170, 1) + SUBSTRING(a.Com, 169, 1) as varbinary(2)) AS int) % 360) % 30), ' วัน') as NoDayAgeTo

		, CAST(SUBSTRING(a.Com, 173, 1) as int) as UseOnlyIpdOpdTypeId
		, case when cast(SUBSTRING(a.Com,173,1) as int) = 0 then 'None'
		  when cast(SUBSTRING(a.Com,173,1) as int) = 1 then 'IPD'
		  when cast(SUBSTRING(a.Com,173,1) as int) = 2 then 'OPD'
		  when cast(SUBSTRING(a.Com,173,1) as int) = 3 then 'OPD'
		  when cast(SUBSTRING(a.Com,173,1) as int) = 4 then 'IPD OPD'
		  when cast(SUBSTRING(a.Com,173,1) as int) = 5 then 'LR'
		  when cast(SUBSTRING(a.Com,173,1) as int) = 6 then 'OR'
		  when cast(SUBSTRING(a.Com,173,1) as int) = 7 then 'LR OR'
		  end as UseOnlyIpdOpdTypeName

		, CAST(SUBSTRING(a.Com,155,7) as varchar(7)) as CheckUpMethodCode
		, coalesce(dbo.sysconname(CAST(SUBSTRING(a.Com,155,7) as varchar(7)),42158,2),'') as CheckUpMethodNameTH
		, coalesce(dbo.sysconname(CAST(SUBSTRING(a.Com,155,7) as varchar(7)),42158,1),'') as CheckUpMethodNameEN

		, CONCAT((CAST(CAST(SUBSTRING(a.Com, 150, 1) + SUBSTRING(a.Com, 149, 1) as varbinary(2)) AS int) / 360), ' ปี ') +
		  CONCAT(((CAST(CAST(SUBSTRING(a.Com, 150, 1) + SUBSTRING(a.Com, 149, 1) as varbinary(2)) AS int) % 360) / 30), ' เดือน ') +
		  CONCAT(((CAST(CAST(SUBSTRING(a.Com, 150, 1) + SUBSTRING(a.Com, 149, 1) as varbinary(2)) AS int) % 360) % 30), ' วัน') as NoDayRecallPeriod

		, CAST(SUBSTRING(a.Com, 148, 1) as int) as GroupReqNormallyGenIPDDrugOrderId
		, case when CAST(SUBSTRING(a.Com, 148, 1) as int) = 0 then 'None' 
		  when CAST(SUBSTRING(a.Com, 148, 1) as int) = 1 then 'Alway'
		  when CAST(SUBSTRING(a.Com, 148, 1) as int) = 2 then 'Never'
		  else '' end as GroupReqNormallyGenIPDDrugOrderName

		, CAST(SUBSTRING(a.Com,138,9) as varchar(9)) as ColourCode
		, coalesce(dbo.sysconname(CAST(SUBSTRING(a.Com,138,9) as varchar(9)),10151,2),'') as ColourNameTH
		, coalesce(dbo.sysconname(CAST(SUBSTRING(a.Com,138,9) as varchar(9)),10151,1),'') as ColourNameEN

		, cast(SUBSTRING(a.Com,3,1) as int) as CannotRebate
		, cast(SUBSTRING(a.Com,2,1) as int) as [Off]
		, cast(SUBSTRING(a.Com,1,1) as int) as HereUseAsAddition
		, cast(SUBSTRING(a.Com,137,1) as int) as FreeOfCharge
		, cast(SUBSTRING(a.Com,126,1) as int) as HereAddition
		, cast(SUBSTRING(a.Com,5,1) as int) as CheckUp
		, cast(SUBSTRING(a.Com,153,1) as int) as Package
		, cast(SUBSTRING(a.Com,154,1) as int) as Common
		, a.Memo
from	DNSYSCONFIG a 
where	a.CtrlCode = 42161
		--and a.Code = 'PAY01'