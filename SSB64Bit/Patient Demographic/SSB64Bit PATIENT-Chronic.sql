
select	top 20 
		'PTS' as BU
		, a.HN as PatientID
		, a.HN 
		, a.ICDCode as ICDCode
		, dbo.CutSortChar(b.LocalName) as ICDNameTH --����ѹ��� 24/02/2568
		, dbo.CutSortChar(b.EnglishName) as ICDNameEN --�����ѹ��� 24/02/2568
		, a.RegisterDate as RegisterDate
		, a.ChronicCreteriaCode
		, dbo.CutSortChar(sys01.LocalName) as ChronicCreteriaNameTH --����ѹ��� 24/02/2568
		, dbo.CutSortChar(sys01.EnglishName) as ChronicCreteriaNameEN --�����ѹ��� 24/02/2568
		, a.FirstDate
		, a.RegisterDoctor
		, dbo.CutSortChar(c.LocalName) as RegisterDoctorNameTH
		, dbo.CutSortChar(c.EnglishName) as RegisterDoctorNameEN
		, c.CertifyPublicNo as RegisterDoctorCertificate
		, a.EntryByUserCode --����ѹ��� 24/02/2568
		, dbo.CutSortChar(sys02.LocalName) as EntryByUserNameTH --�����ѹ��� 24/02/2568
		, dbo.CutSortChar(sys02.EnglishName) as EntryByUserNameEN --�����ѹ��� 24/02/2568
from	HNPAT_CHRONIC a	
		left join HNICD_MASTER b on a.ICDCode = b.IcdCode
		left join DNSYSCONFIG sys01 on sys01.CtrlCode = 43523 and a.ChronicCreteriaCode = sys01.Code
		left join DNSYSCONFIG sys02 on sys02.CtrlCode = 10031 and a.EntryByUserCode = sys02.Code
		left join HNDOCTOR_MASTER c on a.RegisterDoctor = c.Doctor 