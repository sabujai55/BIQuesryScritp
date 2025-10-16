select top 10 
	'PLS' as 'BU'
	, a.HN as 'PatientID'
	, a.VISITDATE as 'Date' 
	, a.VN as 'VN/AN'
	, b.DOCTOR as 'DoctorCode'
	, dbo.Doctorname(b.DOCTOR,2) as 'DoctorNameTH'
	, dbo.Doctorname(b.DOCTOR,1) as 'DoctorNameEN'
	,doc.CERTIFYPUBLICNO as 'DoctorCertificate'
	,doc.CLINIC as 'DoctorClinicCode'
	,dbo.sysconname(doc.CLINIC,20016,2) as 'DoctorClinicNameTH'
	,dbo.sysconname(doc.CLINIC,20016,1) as 'DoctorClinicNameEN'
	, '' as 'DoctorDepartmentCode'
	, '' as 'DoctorDepartmentNameTH'
	, '' as 'DoctorDepartmentNameEN'
	,doc.SPECIALTY+doc.SUBSPECIALTY as 'DoctorSpecialtyCode'
	,dbo.CutSortChar(ssp.THAINAME) as 'DoctorSpecialtyNameTH'
	,dbo.CutSortChar(ssp.ENGLISHNAME) as 'DoctorSpecialtyNameEN'
	, 'ReferOut' as 'Refer'
	, REFERTOTYPE as 'ReferType'
	, dbo.sysconname(REFERTOTYPE,20060,2) as 'ReferTypeNameTH'
	, dbo.sysconname(REFERTOTYPE,20060,1) as 'ReferTypeNameEN'
	, REFERTOHOSPITAL as 'ReferHospital'
	, dbo.sysconname(REFERTOHOSPITAL,20010,2) as 'ReferHospitalNameTH'
	, dbo.sysconname(REFERTOHOSPITAL,20010,1) as 'ReferHospitalNameEN'
	, a.REFERTOREMARKS as 'Remarks'
	, c.ICDCODE as 'Diag'
	, d.THAINAME as 'DiagNameTH'
	, d.ENGLISHNAME as 'DiagNameEN'
		from VNMST a
		inner join VNPRES b on a.VN=b.VN and a.VISITDATE=b.VISITDATE and REFERTOTYPE is not null
		left join VNDIAG c on b.VN=c.VN and b.VISITDATE=c.VISITDATE and b.SUFFIX=c.SUFFIX and c.TYPEOFTHISDIAG = 1
		left join ICD_MASTER d on c.ICDCODE=d.ICDCODE
		left join HNDOCTOR doc on b.DOCTOR=doc.DOCTOR
		left join SYSCONFIG ssp on doc.SPECIALTY+doc.SUBSPECIALTY = REPLACE(ssp.CODE,' ','') and ssp.CTRLCODE = 20015
Union ALL
select top 10 
	'PLS' as 'BU'
	, a.HN as 'PatientID'
	, a.VISITDATE as 'Date' 
	, a.VN as 'VN/AN'
	, b.DOCTOR as 'DoctorCode'
	, dbo.Doctorname(b.DOCTOR,2) as 'DoctorNameTH'
	, dbo.Doctorname(b.DOCTOR,1) as 'DoctorNameEN'
	,doc.CERTIFYPUBLICNO as 'DoctorCertificate'
	,doc.CLINIC as 'DoctorClinicCode'
	,dbo.sysconname(doc.CLINIC,20016,2) as 'DoctorClinicNameTH'
	,dbo.sysconname(doc.CLINIC,20016,1) as 'DoctorClinicNameEN'
	, '' as 'DoctorDepartmentCode'
	, '' as 'DoctorDepartmentNameTH'
	, '' as 'DoctorDepartmentNameEN'
	,doc.SPECIALTY+doc.SUBSPECIALTY as 'DoctorSpecialtyCode'
	,dbo.CutSortChar(ssp.THAINAME) as 'DoctorSpecialtyNameTH'
	,dbo.CutSortChar(ssp.ENGLISHNAME) as 'DoctorSpecialtyNameEN'
	, 'ReferIn' as 'Refer'
	, REFERFROMTYPE as 'ReferType'
	, dbo.sysconname(REFERFROMTYPE,20059,2) as 'ReferTypeNameTH'
	, dbo.sysconname(REFERFROMTYPE,20059,1) as 'ReferTypeNameEN'
	, REFERFROMHOSPITAL as 'ReferHospital'
	, dbo.sysconname(REFERFROMHOSPITAL,20010,2) as 'ReferHospitalNameTH'
	, dbo.sysconname(REFERFROMHOSPITAL,20010,1) as 'ReferHospitalNameEN'
	, a.REFERFROMREMARKS as 'Remarks'
	, c.ICDCODE as 'Diag'
	, d.THAINAME as 'DiagNameTH'
	, d.ENGLISHNAME as 'DiagNameEN'
		from VNMST a
		inner join VNPRES b on a.VN=b.VN and a.VISITDATE=b.VISITDATE and REFERFROMTYPE is not null
		left join VNDIAG c on b.VN=c.VN and b.VISITDATE=c.VISITDATE and b.SUFFIX=c.SUFFIX and c.TYPEOFTHISDIAG = 1
		left join ICD_MASTER d on c.ICDCODE=d.ICDCODE
		left join HNDOCTOR doc on b.DOCTOR=doc.DOCTOR
		left join SYSCONFIG ssp on doc.SPECIALTY+doc.SUBSPECIALTY = REPLACE(ssp.CODE,' ','') and ssp.CTRLCODE = 20015
Union ALL
select top 10 
	'PLS' as 'BU'
	, a.HN as 'PatientID'
	, a.ADMDATETIME
	, a.AN as 'VN/AN'
	, b.DOCTOR as 'DoctorCode'
	, dbo.CutSortChar(doc.THAINAME) as 'DoctorNameTH'
	, dbo.CutSortChar(doc.ENGLISHNAME) as 'DoctorNameEN'
	,doc.CERTIFYPUBLICNO as 'DoctorCertificate'
	,doc.CLINIC as 'DoctorClinicCode'
	,dbo.sysconname(doc.CLINIC,20016,2) as 'DoctorClinicNameTH'
	,dbo.sysconname(doc.CLINIC,20016,1) as 'DoctorClinicNameEN'
	, '' as 'DoctorDepartmentCode'
	, '' as 'DoctorDepartmentNameTH'
	, '' as 'DoctorDepartmentNameEN'
	,doc.SPECIALTY+doc.SUBSPECIALTY as 'DoctorSpecialtyCode'
	,dbo.CutSortChar(ssp.THAINAME) as 'DoctorSpecialtyNameTH'
	,dbo.CutSortChar(ssp.ENGLISHNAME) as 'DoctorSpecialtyNameEN'
	, 'ReferOut' as 'Refer'
	, REFERTOTYPE as 'ReferType'
	, dbo.sysconname(REFERTOTYPE,20060,2) as 'ReferTypeNameTH'
	, dbo.sysconname(REFERTOTYPE,20060,1) as 'ReferTypeNameEN'
	, REFERTOHOSPITAL as 'ReferHospital'
	, dbo.sysconname(REFERTOHOSPITAL,20010,2) as 'ReferHospitalNameTH'
	, dbo.sysconname(REFERTOHOSPITAL,20010,1) as 'ReferHospitalNameEN'
	, a.REFERTOREMARKS as 'Remarks'
	, c.DIAGNOSES as 'Diag'
	, d.THAINAME as 'DiagNameTH'
	, d.ENGLISHNAME as 'DiagNameEN'
		from ADMMASTER a
		inner join IPDDOCTOR b on a.AN=b.AN and b.SPECIALIZEDOCTORTYPE = 1 and a.REFERTOTYPE is not null
		inner join HNDOCTOR doc on b.DOCTOR=doc.DOCTOR
		left join IPDSUMMARY c on a.AN=c.AN and c.SUFFIX = 1
		left join ICD_MASTER d on c.DIAGNOSES=d.ICDCODE
		left join SYSCONFIG ssp on doc.SPECIALTY+doc.SUBSPECIALTY = REPLACE(ssp.CODE,' ','') and ssp.CTRLCODE = 20015
Union ALL
select top 10 
	'PLS' as 'BU'
	, a.HN as 'PatientID'
	, a.ADMDATETIME
	, a.AN as 'VN/AN'
	, b.DOCTOR as 'DoctorCode'
	, dbo.CutSortChar(doc.THAINAME) as 'DoctorNameTH'
	, dbo.CutSortChar(doc.ENGLISHNAME) as 'DoctorNameEN'
	,doc.CERTIFYPUBLICNO as 'DoctorCertificate'
	,doc.CLINIC as 'DoctorClinicCode'
	,dbo.sysconname(doc.CLINIC,20016,2) as 'DoctorClinicNameTH'
	,dbo.sysconname(doc.CLINIC,20016,1) as 'DoctorClinicNameEN'
	, '' as 'DoctorDepartmentCode'
	, '' as 'DoctorDepartmentNameTH'
	, '' as 'DoctorDepartmentNameEN'
	,doc.SPECIALTY+doc.SUBSPECIALTY as 'DoctorSpecialtyCode'
	,dbo.CutSortChar(ssp.THAINAME) as 'DoctorSpecialtyNameTH'
	,dbo.CutSortChar(ssp.ENGLISHNAME) as 'DoctorSpecialtyNameEN'
	, 'ReferIn' as 'Refer'
	, REFERFROMTYPE as 'ReferType'
	, dbo.sysconname(REFERFROMTYPE,20059,2) as 'ReferTypeNameTH'
	, dbo.sysconname(REFERFROMTYPE,20059,1) as 'ReferTypeNameEN'
	, REFERFROMHOSPITAL as 'ReferHospital'
	, dbo.sysconname(REFERFROMHOSPITAL,20010,2) as 'ReferHospitalNameTH'
	, dbo.sysconname(REFERFROMHOSPITAL,20010,1) as 'ReferHospitalNameEN'
	, a.REFERFROMHOSPITAL as 'Remarks'
	, c.DIAGNOSES as 'Diag'
	, d.THAINAME as 'DiagNameTH'
	, d.ENGLISHNAME as 'DiagNameEN'
		from ADMMASTER a
		inner join IPDDOCTOR b on a.AN=b.AN and b.SPECIALIZEDOCTORTYPE = 1 and a.REFERFROMTYPE is not null
		inner join HNDOCTOR doc on b.DOCTOR=doc.DOCTOR
		left join IPDSUMMARY c on a.AN=c.AN and c.SUFFIX = 1
		left join ICD_MASTER d on c.DIAGNOSES=d.ICDCODE
		left join SYSCONFIG ssp on doc.SPECIALTY+doc.SUBSPECIALTY = REPLACE(ssp.CODE,' ','') and ssp.CTRLCODE = 20015