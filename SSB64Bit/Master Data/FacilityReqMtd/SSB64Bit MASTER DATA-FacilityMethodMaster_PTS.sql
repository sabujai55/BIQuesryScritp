select	
		 'PTS' as BU
		, a.Code as FacilityMethodCode
		, dbo.CutSortChar(a.LocalName) as FacilityMethodNameTH
		, dbo.CutSortChar(a.EnglishName) as FacilityMethodNameEN
		, b.EffectiveDateFrom as EffectiveDateFrom --modify 2026-03-18
		, b.EffectiveDateTo as EffectiveDateto --modify 2026-03-18
		, b.GenderOnly as GenderOnlyId --modify 2026-03-18
		, case when b.GenderOnly = 0 then 'None'
		  when b.GenderOnly = 1 then 'หญิง'
		  when b.GenderOnly = 2 then 'ชาย'
		  when b.GenderOnly = 3 then 'ไม่ระบุเพศ'
		  else '' end  as GenderOnlyName --modify 2026-03-18

		, b.NoDayAgeFrom as NoDayAgeFrom --modify 2026-03-18

		, b.NoDayAgeTo as NoDayAgeTo --modify 2026-03-18

		, b.UseOnlyIpdOpdType as UseOnlyIpdOpdTypeId --modify 2026-03-18
		, case when b.UseOnlyIpdOpdType = 0 then 'None'
		  when b.UseOnlyIpdOpdType = 1 then 'IPD'
		  when b.UseOnlyIpdOpdType = 2 then 'OPD'
		  when b.UseOnlyIpdOpdType = 3 then 'OPD'
		  when b.UseOnlyIpdOpdType = 4 then 'IPD OPD'
		  when b.UseOnlyIpdOpdType = 5 then 'LR'
		  when b.UseOnlyIpdOpdType = 6 then 'OR'
		  when b.UseOnlyIpdOpdType = 7 then 'LR OR'
		  end as UseOnlyIpdOpdTypeName --modify 2026-03-18

		, b.CheckUpMethod as CheckUpMethodCode --modify 2026-03-18
		, coalesce(dbo.sysconname(b.CheckUpMethod,42158,2),'') as CheckUpMethodNameTH --modify 2026-03-18
		, coalesce(dbo.sysconname(b.CheckUpMethod,42158,1),'') as CheckUpMethodNameEN --modify 2026-03-18

		, b.NoDayRecallPeriod as NoDayRecallPeriod --modify 2026-03-18

		, b.GroupRequestNormallyGenIPDDrugOrderType as GroupReqNormallyGenIPDDrugOrderId --modify 2026-03-18
		, case when b.GroupRequestNormallyGenIPDDrugOrderType = 0 then 'None' 
		  when b.GroupRequestNormallyGenIPDDrugOrderType = 1 then 'Alway'
		  when b.GroupRequestNormallyGenIPDDrugOrderType = 2 then 'Never'
		  else '' end as GroupReqNormallyGenIPDDrugOrderName --modify 2026-03-18

		, b.ColourCode as ColourCode --modify 2026-03-18
		, coalesce(dbo.sysconname(b.ColourCode,10151,2),'') as ColourNameTH --modify 2026-03-18
		, coalesce(dbo.sysconname(b.ColourCode,10151,1),'') as ColourNameEN --modify 2026-03-18

		, b.CannotRebate as CannotRebate --modify 2026-03-18
		, b.OffCode as [Off] --modify 2026-03-18
		, b.HereUseAsAddition as HereUseAsAddition --modify 2026-03-18
		, b.FreeOfCharge as FreeOfCharge --modify 2026-03-18
		, b.HereAddition as HereAddition --modify 2026-03-18
		, b.CheckUp as CheckUp --modify 2026-03-18
		, b.Package as Package --modify 2026-03-18
		, b.Common as Common --modify 2026-03-18
		, a.Memo 
from	DNSYSCONFIG a 
		inner join DEVDECRYPT.dbo.PYTS_SETUP_FACILITYREQ_METHOD b on a.Code=b.Code --modify 2026-03-18
where	a.CtrlCode = 42161
		--and a.Code = 'PAY01'