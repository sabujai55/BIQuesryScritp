use SSBLIVE
go

select TOP 10	
		'PT2' as BU
		, a.HN as PatientID
		, a.HN
		, b.Initial as PreNameTH
		, b.FirstName as FirstNameTH
		, b.LastName as LastNameTH
		, b.E_Initial as PreNameEN
		, b.E_FirstName as FirstNameEN
		, b.E_LastName as LastNameEN
		, b.BirthDateTime 
		, b.gender as Gender
		, b.BloodGroup
		, b.IDCard as IDCardNo
		, b.Passport
		, b.Race
		, b.Nationality
		, b.Religion
		, b.[Address]
		, b.Tambon
		, b.Amphoe
		, b.Province
		, b.PostalCode
		, b.MobilePhone as MobilePhoneNo
		, b.TelephoneNo as Tel2
		, b.EMailAddress as Email
		, b.[Patient Type] as PatientType
		, b.HN_Married as MaritalStatus
		, b.VIP as VIPType
		, a.VipRemarks as VIPRemark
		, coalesce(dbo.CutSortChar(c.LocalName), dbo.CutSortChar(c.EnglishName)) as VisitAllow
		, b.Occupation
		, a.DeadDateTime
		, a.FileDeletedDate
		, b.PrivateDoctor as PrivateDoctorCode --�����ѹ��� 24/02/2568
		, b.CommunicableNo as Tel1 --�����ѹ��� 24/02/2568
		, a.MakeDateTime as CreatePatientDate --�����ѹ��� 24/02/2568
		, a.LastVisitDateTime as LastUpdateDateTime --�����ѹ��� 24/02/2568
		, a.BirthPlace as BirthPlace --�����ѹ��� 24/02/2568
		, a.PatientFileStatusCode as PatientStatusCode
		, dbo.sysconname(a.PatientFileStatusCode,43777,2) as PatientStatusNameTH
		, dbo.sysconname(a.PatientFileStatusCode,43777,1) as PatientStatusNameEN
from	HNPAT_INFO a
		left join MK_HN_PATIENT b on a.HN = b.HN
		left join DNSYSCONFIG c on c.CtrlCode = 42058 and a.VisitorAllowCode = c.Code