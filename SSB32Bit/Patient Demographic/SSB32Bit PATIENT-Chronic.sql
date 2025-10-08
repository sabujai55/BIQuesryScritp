use SSBHOSPITAL
go

select	top 10
		'PTP' as BU
		, a.HN as PatientID
		, a.HN 
		, a.ICDCODE as ICDCode
		, b.THAINAME as ICDNameTH --แก้ไขวันที่ 22/05/2568
		, b.EnglishName as ICDNameEN --แก้ไขวันที่ 22/05/2568
		, '' as RegisterDate
		, '' as ChronicCreteriaCode
		, '' as ChronicCreteriaNameTH --แก้ไขวันที่ 24/02/2568
		, '' as ChronicCreteriaNameEN --เพิ่มวันที่ 24/02/2568
		, a.FIRSTDATE as FirstDate
		, '' as RegisterDoctor
		, '' as RegisterDoctorNameTH
		, '' as RegisterDoctorNameEN
		, '' as RegisterDoctorCertificate
		, a.EntryByUserCode --แก้ไขวันที่ 24/02/2568
		, dbo.CutSortChar(sys01.THAIName) as EntryByUserNameTH --เพิ่มวันที่ 24/02/2568
		, dbo.CutSortChar(sys01.EnglishName) as EntryByUserNameEN --เพิ่มวันที่ 24/02/2568
from	PATIENT_CHRONIC a
		left join ICD_MASTER b on a.ICDCODE = b.ICDCODE
		left join SYSCONFIG sys01 on sys01.CtrlCode = 10000 and a.EntryByUserCode = sys01.Code
