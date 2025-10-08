select
		  'PLS' as BU
		, frm.CODE as FacilityMethodCode
		, dbo.CutSortChar(frm.THAINAME) as FacilityMethodNameTH
		, dbo.CutSortChar(frm.ENGLISHNAME) as FacilityMethodNameEN
		, convert(varchar(4),convert(int,substring(frm.COM,46,1) + SUBSTRING(frm.COM,45,1))) + '-' + convert(varchar(2),convert(int,substring(frm.COM,47,1))) + '-' + convert(varchar(2),convert(int,substring(frm.COM,49,1))) as EffectiveDateFrom
		, convert(varchar(4),convert(int,substring(frm.COM,62,1) + SUBSTRING(frm.COM,61,1))) + '-' + convert(varchar(2),convert(int,substring(frm.COM,63,1))) + '-' + convert(varchar(2),convert(int,substring(frm.COM,65,1))) as EffectiveDateto
		, CAST(SUBSTRING(frm.COM,5,1)as int) as GenderOnlyId
		, case when CAST(SUBSTRING(frm.COM,5,1)as int)=0 then 'None'
			   when CAST(SUBSTRING(frm.COM,5,1)as int)=1 then 'Male'
			   when CAST(SUBSTRING(frm.COM,5,1)as int)=2 then 'Female'
			   end as GenderOnlyName
		, '' as NoDayAgeFrom
		, '' as NoDayAgeTo
		, '' as UseOnlyIpdOpdTypeId
		, '' as UseOnlyIpdOpdTypeName
		, '' as CheckUpMethodCode
		, '' as CheckUpMethodNameTH
		, '' as CheckUpMethodNameEN
		, '' as NoDayRecallPeriod
		, '' as GroupReqNormallyGenIPDDrugOrderId
		, '' as GroupReqNormallyGenIPDDrugOrderName
		, '' as ColourCode
		, '' as ColourNameTH
		, '' as ColourNameEN
		, '' as CannotRebate
		, CAST(SUBSTRING(frm.COM,41,1)as int) as [Off]
		, '' as HereUseAsAddition
		, '' as FreeOfCharge
		, '' as HereAddition
		, CAST(SUBSTRING(frm.COM,2,1)as int) as CheckUp
		, '' as Package
		, '' as Common
		, frm.MEMO as Memo
			from SYSCONFIG frm
			where frm.CTRLCODE = 20120

