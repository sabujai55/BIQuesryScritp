use SSBLIVE
go

select	'PT2' as BU
		, d.HN as PatientID
		, a.FacilityRmsNo
		, a.RequestNo
		, a.SuffixTiny
		, a.ICDCode1
		, dbo.CutSortChar(dx1.LocalName) as ICDNameTH1
		, dbo.CutSortChar(dx1.EnglishName) as ICDNameEN1
		, a.ICDCode2
		, dbo.CutSortChar(dx2.LocalName) as ICDNameTH2
		, dbo.CutSortChar(dx2.EnglishName) as ICDNameEN2
		, a.OrganCode
		, dbo.CutSortChar(sys02.LocalName) as OrganNameTH
		, dbo.CutSortChar(sys02.EnglishName) as OrganNameEN
		, a.Doctor
		, dbo.CutSortChar(c.LocalName) as DoctorNameTH
		, dbo.CutSortChar(c.EnglishName) as DoctorNameEN
		, a.ICDCmCode1
		, dbo.CutSortChar(cm1.LocalName) as ICDCMNameTH1
		, dbo.CutSortChar(cm1.EnglishName) as ICDCMNameEN1
		, a.ICDCmCode2
		, dbo.CutSortChar(cm2.LocalName) as ICDCMNameTH2
		, dbo.CutSortChar(cm2.EnglishName) as ICDCMNameEN2
		, a.ICDCmCode3
		, dbo.CutSortChar(cm3.LocalName) as ICDCMNameTH3
		, dbo.CutSortChar(cm3.EnglishName) as ICDCMNameEN3
		, a.ICDCmCode4
		, dbo.CutSortChar(cm4.LocalName) as ICDCMNameTH4
		, dbo.CutSortChar(cm4.EnglishName) as ICDCMNameEN4
		, a.ORSpecialty
		, dbo.CutSortChar(sys01.LocalName) as ORSpecialtyNameTH
		, dbo.CutSortChar(sys01.EnglishName) as ORSpecialtyNameEN
		, case when a.HNOREndoscopeType = 0 then 'None'
		  when a.HNOREndoscopeType = 1 then 'Diagnosis'
		  when a.HNOREndoscopeType = 2 then 'Therapeutic' end HNOREndoscopeType
		, a.ConfirmDoctorDateTime
		, a.DiagDateTime
		, a.ORStartDateTime
		, a.ORFinishDateTime
		, b.[Description] as HNWoundType
		, a.Remarks as Memo
from	HNORREQ_DIAG a 
		inner join v_FixHNWoundType b on a.HNWoundType = b.FixHNWoundTypeId
		inner join HNORREQ_HEADER d on a.FacilityRmsNo = d.FacilityRmsNo and a.RequestNo = d.RequestNo
		left join HNDOCTOR_MASTER c on a.Doctor = c.Doctor
		left join HNICD_MASTER dx1 on a.ICDCode1 = dx1.IcdCode
		left join HNICD_MASTER dx2 on a.ICDCode2 = dx2.IcdCode
		left join DNSYSCONFIG sys01 on sys01.CtrlCode = 42729 and a.ORSpecialty = sys01.Code
		left join DNSYSCONFIG sys02 on sys02.CtrlCode = 42181 and a.OrganCode = sys02.Code
		left join HNICDCM_MASTER cm1 on a.ICDCmCode1 = cm1.IcdCmCode
		left join HNICDCM_MASTER cm2 on a.ICDCmCode2 = cm2.IcdCmCode
		left join HNICDCM_MASTER cm3 on a.ICDCmCode3 = cm3.IcdCmCode
		left join HNICDCM_MASTER cm4 on a.ICDCmCode4 = cm4.IcdCmCode
where	a.RequestNo in (select b.RequestNo from HNORREQ_HEADER b where b.ORBeginDateTimePlan between '2025-01-01 00:00:00' and '2025-05-01 23:59:59')
--group by a.RequestNo
--having COUNT(a.RequestNo) > 1
order by a.FacilityRmsNo, a.RequestNo