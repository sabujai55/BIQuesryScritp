use SSBHOSPITAL
go

select	top 10
		'PTP' as BU
		, a.HN as PatientID
		, a.HN 
		, a.ICDCODE as ICDCode
		, b.THAINAME as ICDNameTH --����ѹ��� 22/05/2568
		, b.EnglishName as ICDNameEN --����ѹ��� 22/05/2568
		, '' as RegisterDate
		, '' as ChronicCreteriaCode
		, '' as ChronicCreteriaNameTH --����ѹ��� 24/02/2568
		, '' as ChronicCreteriaNameEN --�����ѹ��� 24/02/2568
		, a.FIRSTDATE as FirstDate
		, '' as RegisterDoctor
		, '' as RegisterDoctorNameTH
		, '' as RegisterDoctorNameEN
		, '' as RegisterDoctorCertificate
		, a.EntryByUserCode --����ѹ��� 24/02/2568
		, dbo.CutSortChar(sys01.THAIName) as EntryByUserNameTH --�����ѹ��� 24/02/2568
		, dbo.CutSortChar(sys01.EnglishName) as EntryByUserNameEN --�����ѹ��� 24/02/2568
from	PATIENT_CHRONIC a
		left join ICD_MASTER b on a.ICDCODE = b.ICDCODE
		left join SYSCONFIG sys01 on sys01.CtrlCode = 10000 and a.EntryByUserCode = sys01.Code
