Use
SSBLIVE
go

select top 100
		'PT2' as BU
		, pth.HN as PatientID
		, ptd.FacilityRmsNo
		, ptd.RequestNo
		, ptd.DiagDateTime
		, ptd.PTDiagCode
		, dbo.sysconname(ptd.PTDiagCode,42638,2) as PTDiagNameTH
		, dbo.sysconname(ptd.PTDiagCode,42638,1) as PTDiagNameEN
		, ptd.PTSystemCode
		, dbo.sysconname(ptd.PTSystemCode,42623,2) as PTSystemNameTH
		, dbo.sysconname(ptd.PTSystemCode,42623,1) as PTSystemNameEN
		, ptd.PTStopReasonCode
		, dbo.sysconname(ptd.PTStopReasonCode,42635,2) as PTStopReasonNameTH
		, dbo.sysconname(ptd.PTStopReasonCode,42635,1) as PTStopReasonNameEN
		, ptd.OrganCode1
		, dbo.sysconname(ptd.OrganCode1,42181,2) as OrganNameTH1
		, dbo.sysconname(ptd.OrganCode1,42181,1) as OrganNameEN1
		, ptd.OrganCode2
		, dbo.sysconname(ptd.OrganCode2,42181,2) as OrganNameTH2
		, dbo.sysconname(ptd.OrganCode2,42181,1) as OrganNameEN2
		, ptd.OrganCode3
		, dbo.sysconname(ptd.OrganCode3,42181,2) as OrganNameTH3
		, dbo.sysconname(ptd.OrganCode3,42181,1) as OrganNameEN3
		, ptd.OrganPosition1
		, dbo.sysconname(ptd.OrganPosition1,42182,2) as OrganPositionNameTH1
		, dbo.sysconname(ptd.OrganPosition1,42182,1) as OrganPositionNameEN1
		, ptd.OrganPosition2
		, dbo.sysconname(ptd.OrganPosition2,42182,2) as OrganPositionNameTH2
		, dbo.sysconname(ptd.OrganPosition2,42182,1) as OrganPositionNameEN2
		, ptd.OrganPosition3
		, dbo.sysconname(ptd.OrganPosition3,42182,2) as OrganPositionNameTH3
		, dbo.sysconname(ptd.OrganPosition3,42182,1) as OrganPositionNameEN3
		, ptd.EntryDateTime
		, ptd.PTTherapistCode
		, dbo.sysconname(ptd.PTTherapistCode,42629,2) as PTTherapistNameTH
		, dbo.sysconname(ptd.PTTherapistCode,42629,1) as PTTherapistNameEN
		, ptd.RefToHospital
		, dbo.sysconname(ptd.RefToHospital,42025,2) as RefToHospitalNameTH
		, dbo.sysconname(ptd.RefToHospital,42025,1) as RefToHospitalNameEN
		, ptd.RefToCode
		, dbo.sysconname(ptd.RefToCode,42266,2) as RefToNameTH
		, dbo.sysconname(ptd.RefToCode,42266,1) as RefToNameEN
		, ptd.RefToRefNo
		, ptd.FollowUp
		, case when ptd.FacilityResultType = 0 then 'None'
			   when ptd.FacilityResultType = 1 then 'Abnormal'
			   when ptd.FacilityResultType = 2 then 'Hiden'
			   when ptd.FacilityResultType = 3 then 'Found'
		 end as FacilityResultType
		, case when ptd.HNPTTreatmentType = 0 then 'None'
		       when ptd.HNPTTreatmentType = 1 then 'Treatment'
			   when ptd.HNPTTreatmentType = 2 then 'Recover'
			   when ptd.HNPTTreatmentType = 3 then 'Encourage'
			   when ptd.HNPTTreatmentType = 4 then 'Prevent'
			   when ptd.HNPTTreatmentType = 5 then 'Encourage_Prevent'
			   when ptd.HNPTTreatmentType = 6 then 'Treatment_Recover'
		 end as HNPTTreatmentType
		, case when ptd.HNPTStatusType = 0 then 'None'
			   when ptd.HNPTStatusType = 1 then 'Acute'
			   when ptd.HNPTStatusType = 2 then 'Chronic'
		 end as HNPTStatusType
		, case when ptd.IpdOpdType = 0 then 'None'
			   when ptd.IpdOpdType = 1 then 'IPD'
			   when ptd.IpdOpdType = 2 then 'OPD'
			   when ptd.IpdOpdType = 3 then 'Deposit'
			   when ptd.IpdOpdType = 4 then 'IPD OPD'
			   when ptd.IpdOpdType = 5 then 'LR'
			   when ptd.IpdOpdType = 6 then 'OR'
			   when ptd.IpdOpdType = 7 then 'LR OR'
		 end as IpdOpdType
		, ptd.RemarksMemo
		, ptd.ICDCmCode
		, dbo.CutSortChar(icdcm.LocalName) as ICDCmNameTH
		, dbo.CutSortChar(icdcm.EnglishName) as ICDCmNameEN
				from HNPTREQ_DIAG ptd
				left join HNPTREQ_HEADER pth on ptd.FacilityRmsNo=pth.FacilityRmsNo and ptd.RequestNo=pth.RequestNo
				left join HNICDCM_MASTER icdcm on ptd.ICDCmCode=icdcm.IcdCmCode