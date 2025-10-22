use SSBLIVE
go

select	'PT2' as BU
		, a.HN as PatientID
		, a.FacilityRmsNo
		, a.RequestNo
		, b.SuffixTiny
		, c.[Description] as HNORPersonType
		, b.Doctor
		, dbo.CutSortChar(d.LocalName) as DoctorNameTH
		, dbo.CutSortChar(d.EnglishName) as DoctorNameEN
		, CertifyPublicNo as DoctorCertificate
		, d.Clinic as DoctorClinicCode
		, dbo.sysconname(d.Clinic,42203,2) as DoctorClinicNameTH
		, dbo.sysconname(d.Clinic,42203,1) as DoctorClinicNameEN
		, d.ComposeDept as DoctorDepartmentCode
		, dbo.sysconname(d.ComposeDept,10145,2) as DoctorDepartmentNameTH
		, dbo.sysconname(d.ComposeDept,10145,1) as DoctorDepartmentNameEN
		, d.Specialty as DoctorSpecialtyCode
		, dbo.sysconname(d.Specialty,42197,2) as DoctorSpecialtyNameTH
		, dbo.sysconname(d.Specialty,42197,1) as DoctorSpecialtyNameEN

		, b.NurseCode
		, dbo.CutSortChar(sys01.LocalName) as NurseNameTH
		, dbo.CutSortChar(sys01.EnglishName) as NurseNameEN
		, b.Remarks
from	HNORREQ_HEADER a 
		inner join HNORREQ_PERSON b on a.FacilityRmsNo = b.FacilityRmsNo and a.RequestNo = b.RequestNo
		left join v_FixHNORPersonType c on b.HNORPersonType = c.FixHNORPersonTypeId
		left join HNDOCTOR_MASTER d on b.Doctor = d.Doctor
		left join DNSYSCONFIG sys01 on sys01.CtrlCode = 42701 and b.NurseCode = sys01.Code
where	a.ORBeginDateTimePlan between '2025-01-01 00:00:00' and '2025-05-01 23:59:59'