use SSBHOSPITAL
go

select TOP 10	
		'PTP' as BU
		, a.HN as Patient_ID
		, a.HN
		, b.Initial as PreNameTH
		, b.FirstName as FirstNameTH
		, b.LastName as LastNameTH
		, b.E_Initial as PreNameEN
		, (select dbo.cutsortchar(ne.FIRSTNAME) from PATIENT_NAME ne where ne.HN = a.HN and ne.SUFFIX = 1) as FirstNameEN 
		, (select dbo.cutsortchar(ne.LASTNAME) from PATIENT_NAME ne where ne.HN = a.HN and ne.SUFFIX = 1) as FirstNameEN
		, b.BirthDateTime 
		, b.gender as Gender
		, a.BLOOD as BloodGroup
		, b.IDCard as IDCardNo
		, (select pr.REF from PATIENT_REF pr where pr.HN = a.HN and pr.REFTYPE = '22') as Passport
		, coalesce(dbo.CutSortChar(d.THAINAME), dbo.CutSortChar(d.ENGLISHNAME)) as Race
		, coalesce(dbo.CutSortChar(e.THAINAME), dbo.CutSortChar(e.ENGLISHNAME)) as Nationality
		, coalesce(dbo.CutSortChar(f.THAINAME), dbo.CutSortChar(f.ENGLISHNAME)) as Religion
		, b.[Address]
		, b.Tambon
		, b.Amphoe
		, b.Province
		, b.PostalCode
		, (select pa.MOBILEPHONENO from PATIENT_ADDRESS pa where pa.HN = a.HN and pa.SUFFIX = 1) as MobilePhone
		, (select pa.TEL from PATIENT_ADDRESS pa where pa.HN = a.HN and pa.SUFFIX = 1) as TelephoneNo
		, b.EMailAddress as Email
		, b.[Patient Type] as PatientType
		, b.MaritalStatus
		, b.VIPType
		, '' as VIPRemark
		, b.VisitorAllow
		, b.Occupation
		, a.DeadDateTime
		, m.MAKEDATETIME as FileDeletedDate
		, '' as PrivateDoctorCode --เพิ่มวันที่ 24/02/2568
		, '' as CommunicableNo --เพิ่มวันที่ 24/02/2568
		, a.MAKEDATETIME as CreatePatientDate --เพิ่มวันที่ 24/02/2568
		, a.LASTVISITDATE as LastUpdateDateTime --เพิ่มวันที่ 24/02/2568
		, a.BIRTHPLACE as BirthPlace --เพิ่มวันที่ 24/02/2568
from	PATIENT_INFO a
		left join MK_HN_PATIENT b on a.HN = b.HN
		left join SYSCONFIG c on c.CTRLCODE = 10121 and a.INITIALNAMECODE = c.CODE
		left join SYSCONFIG d on d.CTRLCODE = 10080 and a.RACE = d.CODE
		left join SYSCONFIG e on e.CTRLCODE = 10041 and a.NATIONALITY = e.CODE
		left join SYSCONFIG f on f.CTRLCODE = 10071 and a.RELIGION = f.CODE
		left join SYSCONFIG g on g.CTRLCODE = 10082 and a.OCCUPATION = g.CODE
		left join MAPDELHNEXIST m on a.HN = m.DELETEDHN 
