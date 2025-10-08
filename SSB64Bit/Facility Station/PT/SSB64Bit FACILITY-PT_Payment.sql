select top 100
		'PT2' as BU
		, pth.HN as PatientID
		, ptp.FacilityRmsNo
		, ptp.RequestNo
		, ptp.PTModeCode
		, dbo.sysconname(ptp.PTModeCode,42632,2) as PTModeNameTH
		, dbo.sysconname(ptp.PTModeCode,42632,1) as PTModeNameEN
		, ptp.HNActivityCode
		, dbo.sysconname(ptp.HNActivityCode,42093,2) as HNActivityNameTH
		, dbo.sysconname(ptp.HNActivityCode,42093,1) as HNActivityNameEN
		, ChargeDateTime
		, ChargeVisitDate
		, IRNo
		, ChargeVN
		, ChargeAN
		, ptp.RightCode
		, dbo.sysconname(ptp.RightCode,42086,2) as RightNameTH
		, dbo.sysconname(ptp.RightCode,42086,1) as RightNameEN
		, ptp.ChargeAmt
		, Case when ptp.HNChargeType = 0 then 'None' 
		  when ptp.HNChargeType = 1 then 'Free' 
		  when ptp.HNChargeType = 2 then 'Refund'
		  when ptp.HNChargeType = 6 then 'Free Return'
		  end AS 'ChargeType'
		, ptp.EntryByUserCode
		, dbo.sysconname(ptp.EntryByUserCode,10031,2) as EntryByUserNameTH
		, dbo.sysconname(ptp.EntryByUserCode,10031,1) as EntryByUserNameEN
		, ptp.VoidByUserCode
		, dbo.sysconname(ptp.VoidByUserCode,10031,2) as VoidByUserNameTH
		, dbo.sysconname(ptp.VoidByUserCode,10031,1) as VoidByUserNameEN
		, ptp.VoidDateTime
		, ptp.VoidRemarks
		, ptp.ChargeVoucherNo
		, ptp.Remarks
				from HNPTREQ_PAYMENT ptp
				left join HNPTREQ_HEADER pth on ptp.FacilityRmsNo=pth.FacilityRmsNo and ptp.RequestNo=pth.RequestNo
				where ptp.RequestNo = 'PT02566-68'
				order by pth.EntryDateTime desc