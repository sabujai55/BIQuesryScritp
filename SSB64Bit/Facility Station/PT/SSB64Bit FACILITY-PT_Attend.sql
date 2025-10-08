select top 100
		'PT2' as BU
		, pth.HN as PatientID
		, pta.FacilityRmsNo
		, pta.RequestNo
		, pta.PTModeSuffixSmall
		, pta.PTModeCode
		, dbo.sysconname(pta.PTModeCode,42632,2) as PTModeNameTH
		, dbo.sysconname(pta.PTModeCode,42632,1) as PTModeNameEN
		, pta.PTSystemCode
		, dbo.sysconname(pta.PTSystemCode,42623,2) as PTSystemNameTH
		, dbo.sysconname(pta.PTSystemCode,42623,1) as PTSystemNameEN
		, pta.OrganCode1
		, dbo.sysconname(pta.OrganCode1,42181,2) as OrganNameTH1
		, dbo.sysconname(pta.OrganCode1,42181,1) as OrganNameEN1
		, pta.OrganCode2
		, dbo.sysconname(pta.OrganCode2,42181,2) as OrganNameTH2
		, dbo.sysconname(pta.OrganCode2,42181,1) as OrganNameEN2
		, pta.OrganCode3
		, dbo.sysconname(pta.OrganCode3,42181,2) as OrganNameTH3
		, dbo.sysconname(pta.OrganCode3,42181,1) as OrganNameEN3
		, pta.OrganPosition1
		, dbo.sysconname(pta.OrganPosition1,42182,2) as OrganPositionNameTH1
		, dbo.sysconname(pta.OrganPosition1,42182,1) as OrganPositionNameEN1
		, pta.OrganPosition2
		, dbo.sysconname(pta.OrganPosition2,42182,2) as OrganPositionNameTH2
		, dbo.sysconname(pta.OrganPosition2,42182,1) as OrganPositionNameEN2
		, pta.OrganPosition3
		, dbo.sysconname(pta.OrganPosition3,42182,2) as OrganPositionNameTH3
		, dbo.sysconname(pta.OrganPosition3,42182,1) as OrganPositionNameEN3
		, pta.PTTherapistCode1
		, dbo.sysconname(pta.PTTherapistCode1,42629,2) as PTTherapistNameTH1
		, dbo.sysconname(pta.PTTherapistCode1,42629,1) as PTTherapistNameEN1
		, pta.PTTherapistCode2
		, dbo.sysconname(pta.PTTherapistCode2,42629,2) as PTTherapistNameTH2
		, dbo.sysconname(pta.PTTherapistCode2,42629,1) as PTTherapistNameEN2
		, pta.PTTherapistCode3
		, dbo.sysconname(pta.PTTherapistCode3,42629,2) as PTTherapistNameTH3
		, dbo.sysconname(pta.PTTherapistCode3,42629,1) as PTTherapistNameEN3
		, pta.RegisterDateTime
		, pta.StartDateTime
		, pta.FinishDateTime
		, pta.EntryDateTime
		, Case when pta.HNChargeType = 0 then 'None' 
		  when pta.HNChargeType = 1 then 'Free' 
		  when pta.HNChargeType = 2 then 'Refund'
		  when pta.HNChargeType = 6 then 'Free Return'
		  end AS 'ChargeType'
		, pta.AtWard
		, case when pta.IpdOpdType = 0 then 'None'
			   when pta.IpdOpdType = 1 then 'IPD'
			   when pta.IpdOpdType = 2 then 'OPD'
			   when pta.IpdOpdType = 3 then 'Deposit'
			   when pta.IpdOpdType = 4 then 'IPD OPD'
			   when pta.IpdOpdType = 5 then 'LR'
			   when pta.IpdOpdType = 6 then 'OR'
			   when pta.IpdOpdType = 7 then 'LR OR'
		 end as IpdOpdType
		, pta.RightCode
		, dbo.sysconname(pta.RightCode,42086,2) as RightNameTH
		, dbo.sysconname(pta.RightCode,42086,1) as RightNameEN
		, pta.Qty
				from HNPTREQ_ATTEND pta
				left join HNPTREQ_HEADER pth on pta.FacilityRmsNo=pth.FacilityRmsNo and pta.RequestNo=pth.RequestNo