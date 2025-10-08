use SSBLIVE
go

select	top 100 
		'PT2' as BU
		, a.HN as PatientID
		, a.FacilityRmsNo
		, a.RequestNo
		, a.EntryDateTime
		, a.RequestDoctor as RequestDoctorCode
		, dbo.CutSortChar(b.LocalName) as RequestDoctorNameTH
		, dbo.CutSortChar(b.EnglishName) as RequestDoctorNameEN
		, a.RightCode
		, dbo.CutSortChar(sys07.LocalName) as RightNameTH
		, dbo.CutSortChar(sys07.EnglishName) as RightNameEN
		, a.HNORRmsNo
		, dbo.CutSortChar(sys08.LocalName) as HNORRmsNoNameTH
		, dbo.CutSortChar(sys08.EnglishName) as HNORRmsNoNameEN
		, a.NPODateTime
		, a.AttendDateTime
		, a.ORConfirmDateTime
		, a.AnesConfirmDateTime
		, a.PrivateCase
		, c.[Description] as ORCaseType
		, case when a.ORClassifiedType = 1 then 'Major'
		  when a.ORClassifiedType = 2 then 'Minor'
		  when a.ORClassifiedType = 0 then 'None' end as ORClassifiedType
		, d.[Description] as ORVisitType
		, a.HoldRequest
		, a.ORBeginDateTimePlan
		, a.ORFinishDateTimePlan
		, a.ORBeginDateTimeActual
		, a.ORFinishDateTimeActual
		, a.AnesBeginDateTimePlan
		, a.AnesFinishDateTimePlan
		, a.AnesBeginDateTimeActual
		, a.AnesFinishDateTimeActual
		, a.ORPostureCode
		, dbo.CutSortChar(sys01.LocalName) as ORPostureNameTH
		, dbo.CutSortChar(sys01.EnglishName) as ORPostureNameEN
		, a.ORICDGroupCode
		, dbo.CutSortChar(sys02.LocalName) as ORICDGroupNameTH
		, dbo.CutSortChar(sys02.EnglishName) as ORICDGroupNameEN
		, a.ORICDCmGroupCode
		, dbo.CutSortChar(sys03.LocalName) as ORICDCMGroupNameTH
		, dbo.CutSortChar(sys03.EnglishName) as ORICDCMGroupNameEN
		, a.ORSpecialty
		, dbo.CutSortChar(sys04.LocalName) as ORSpecialtyNameTH
		, dbo.CutSortChar(sys04.EnglishName) as ORSpecialtyNameEN
		, e.[Description] as ORWithAnesType
		, a.ORReOperationReasonCode
		, dbo.CutSortChar(sys05.LocalName) as ORReOperationReasonNameTH
		, dbo.CutSortChar(sys05.EnglishName) as ORReOperationReasonNameEN
		, a.ORResultCode
		, dbo.CutSortChar(sys06.LocalName) as ORResultNameTH
		, dbo.CutSortChar(sys06.EnglishName) as ORResultNameEN
		, a.CxlDateTime
		, a.CxlByUserCode
		, dbo.CutSortChar(sys09.LocalName) as CxlByUserNameTH
		, dbo.CutSortChar(sys09.EnglishName) as CxlByUserNameEN
		, a.CxlReasonCode
		, dbo.CutSortChar(sys10.LocalName) as CxlReasonNameTH
		, dbo.CutSortChar(sys10.EnglishName) as CxlReasonNameEN
from	HNORREQ_HEADER a 
		left join HNDOCTOR_MASTER b on a.RequestDoctor = b.Doctor
		left join v_FixORCaseType c on a.ORCaseType = c.FixORCaseTypeID
		left join v_FixORVisitType d on a.ORVisitType = d.FixORVisitTypeId
		LEFT join v_FixORWithAnesType e on a.ORWithAnesType = e.FixORWithAnesTypeID
		left join DNSYSCONFIG sys01 on sys01.CtrlCode = 42726 and a.ORPostureCode = sys01.Code
		left join DNSYSCONFIG sys02 on sys02.CtrlCode = 42753 and a.ORICDGroupCode = sys02.Code
		left join DNSYSCONFIG sys03 on sys03.CtrlCode = 42758 and a.ORICDCmGroupCode = sys03.Code
		left join DNSYSCONFIG sys04 on sys04.CtrlCode = 42729 and a.ORSpecialty = sys04.Code
		left join DNSYSCONFIG sys05 on sys05.CtrlCode = 42766 and a.ORReOperationReasonCode = sys05.Code
		left join DNSYSCONFIG sys06 on sys06.CtrlCode = 42773 and a.ORResultCode = sys06.Code
		left join DNSYSCONFIG sys07 on sys07.CtrlCode = 42086 and a.RightCode = sys07.Code
		left join DNSYSCONFIG sys08 on sys08.CtrlCode = 42721 and a.HNORRmsNo = sys08.Code
		left join DNSYSCONFIG sys09 on sys09.CtrlCode = 10031 and a.CxlByUserCode = sys09.Code
		left join DNSYSCONFIG sys10 on sys10.CtrlCode = 43165 and a.CxlReasonCode = sys10.Code
where	a.ORBeginDateTimePlan between '2025-05-01 00:00:00' and '2025-05-01 23:59:59'
order by a.EntryDateTime desc