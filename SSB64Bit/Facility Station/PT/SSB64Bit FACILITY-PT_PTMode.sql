select top 100
		'PT2' as BU
		, pth.HN as PatientID
		, ptm.FacilityRmsNo
		, ptm.RequestNo
		, ptm.PTModeSuffixSmall
		, ptm.PTModeCode
		, dbo.sysconname(ptm.PTModeCode,42632,2) as PTModeNameTH
		, dbo.sysconname(ptm.PTModeCode,42632,1) as PTModeNameEN
		, ptm.NoOfVisitTobeDone
		, ptm.UnitPrice
		, ptm.ChargeAmt
		, ptm.PaidFromChargeAmt
		, ptm.ChargeDateTime
		, Case when ptm.HNChargeType = 0 then 'None' 
		  when ptm.HNChargeType = 1 then 'Free' 
		  when ptm.HNChargeType = 2 then 'Refund'
		  when ptm.HNChargeType = 6 then 'Free Return'
		  end AS 'ChargeType'
		, ptm.PTSystemCode
		, dbo.sysconname(ptm.PTSystemCode,42623,2) as PTSystemNameTH
		, dbo.sysconname(ptm.PTSystemCode,42623,1) as PTSystemNameEN
		, ptm.OrganCode
		, dbo.sysconname(ptm.OrganCode,42181,2) as OrganNameTH
		, dbo.sysconname(ptm.OrganCode,42181,1) as OrganNameEN
		, ptm.OrganPosition
		, dbo.sysconname(ptm.OrganPosition,42182,2) as OrganPositionNameTH
		, dbo.sysconname(ptm.OrganPosition,42182,1) as OrganPositionNameEN
		, ptm.PTTherapistCode
		, dbo.sysconname(ptm.PTTherapistCode,42629,2) as PTTherapistNameTH
		, dbo.sysconname(ptm.PTTherapistCode,42629,1) as PTTherapistNameEN
		, ptm.AtWard
		, ptm.MinutePerVisit
		, ptm.VoidDateTime
		, ptm.Remarks
				from HNPTREQ_PTMODE ptm
				left join HNPTREQ_HEADER pth on ptm.FacilityRmsNo=pth.FacilityRmsNo and ptm.RequestNo=pth.RequestNo