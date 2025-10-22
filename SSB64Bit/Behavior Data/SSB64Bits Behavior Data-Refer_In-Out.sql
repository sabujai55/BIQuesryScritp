USE SSBLIVE
GO

select top 10
		  'PT2' as 'BU'
		, a.HN as 'PatientID'
		, a.VisitDate as 'Date'
		, a.VN as 'VN/AN'
		, b.Doctor as 'DoctorCode'
		, dbo.Doctorname(b.Doctor,2) as 'DoctorNameTH'
		, dbo.Doctorname(b.Doctor,1) as 'DoctorNameEN'
		, doc.CertifyPublicNo as DoctorCertificate
		, doc.Clinic as DoctorClinicCode
		, dbo.sysconname(doc.Clinic,42203,2) as DoctorClinicNameTH
		, dbo.sysconname(doc.Clinic,42203,1) as DoctorClinicNameEN
		, doc.ComposeDept as DoctorDepartmentCode
		, dbo.sysconname(doc.ComposeDept,10145,2) as DoctorDepartmentNameTH
		, dbo.sysconname(doc.ComposeDept,10145,1) as DoctorDepartmentNameEN
		, doc.Specialty as DoctorSpecialtyCode
		, dbo.sysconname(doc.Specialty,42197,2) as DoctorSpecialtyNameTH
		, dbo.sysconname(doc.Specialty,42197,1) as DoctorSpecialtyNameEN
		, 'ReferOut' as 'Refer'
		, a.RefToCode as 'ReferType'
		, dbo.sysconname(a.RefToCode,42266,2) as 'ReferTypeNameTH'
		, dbo.sysconname(a.RefToCode,42266,1) as 'ReferTypeNameEN'
		, a.RefToHospital as 'ReferHospital'
		, dbo.sysconname(a.RefToHospital,42025,2) as 'ReferHospitalNameTH'
		, dbo.sysconname(a.RefToHospital,42025,1) as 'ReferHospitalNameEN'
		, b.RemarksMemo as 'Remarks'
		, c.ICDCode as 'Diag'
		, dbo.CutSortChar(d.LocalName) as 'DiagNameTH'
		, dbo.CutSortChar(d.EnglishName) as 'DiagNameEN'
from	HNOPD_MASTER a
		inner join HNOPD_PRESCRIP b on a.VN=b.VN and a.VisitDate=b.VisitDate and a.RefToCode is not null
		left join HNOPD_PRESCRIP_DIAG c on a.VN=c.VN and a.VisitDate=c.VisitDate and c.DiagnosisRecordType = 1
		left join HNICD_MASTER d on c.ICDCode=d.IcdCode
		left join HNDOCTOR_MASTER doc on b.Doctor = doc.Doctor
Union All
select top 10
		  'PT2' as 'BU'
		, a.HN as 'PatientID'
		, a.VisitDate as 'Date'
		, a.VN as 'VN/AN'
		, b.Doctor as 'DoctorCode'
		, dbo.Doctorname(b.Doctor,2) as 'DoctorNameTH'
		, dbo.Doctorname(b.Doctor,1) as 'DoctorNameEN'
		, doc.CertifyPublicNo as DoctorCertificate
		, doc.Clinic as DoctorClinicCode
		, dbo.sysconname(doc.Clinic,42203,2) as DoctorClinicNameTH
		, dbo.sysconname(doc.Clinic,42203,1) as DoctorClinicNameEN
		, doc.ComposeDept as DoctorDepartmentCode
		, dbo.sysconname(doc.ComposeDept,10145,2) as DoctorDepartmentNameTH
		, dbo.sysconname(doc.ComposeDept,10145,1) as DoctorDepartmentNameEN
		, doc.Specialty as DoctorSpecialtyCode
		, dbo.sysconname(doc.Specialty,42197,2) as DoctorSpecialtyNameTH
		, dbo.sysconname(doc.Specialty,42197,1) as DoctorSpecialtyNameEN
		, 'ReferIn' as 'Refer'
		, a.RefFromCode as 'ReferType'
		, dbo.sysconname(a.RefFromCode,42266,2) as 'ReferTypeNameTH'
		, dbo.sysconname(a.RefFromCode,42266,1) as 'ReferTypeNameEN'
		, a.RefFromHospital as 'ReferHospital'
		, dbo.sysconname(a.RefFromHospital,42025,2) as 'ReferHospitalNameTH'
		, dbo.sysconname(a.RefFromHospital,42025,1) as 'ReferHospitalNameEN'
		, b.RemarksMemo as 'Remarks'
		, c.ICDCode as 'Diag'
		, dbo.CutSortChar(d.LocalName) as 'DiagNameTH'
		, dbo.CutSortChar(d.EnglishName) as 'DiagNameEN'
from	HNOPD_MASTER a
		inner join HNOPD_PRESCRIP b on a.VN=b.VN and a.VisitDate=b.VisitDate and a.RefFromCode is not null
		left join HNOPD_PRESCRIP_DIAG c on a.VN=c.VN and a.VisitDate=c.VisitDate and c.DiagnosisRecordType = 1
		left join HNICD_MASTER d on c.ICDCode=d.IcdCode
		left join HNDOCTOR_MASTER doc on b.Doctor = doc.Doctor
Union All
select top 10
		  'PT2' as 'BU'
		, a.HN as 'PatientID'
		, a.AdmDateTime as 'Date'
		, a.AN as 'VN/AN'
		, dm.DoctorCode
		, dm.DoctorNameTH
		, dm.DoctorNameEN
		, dm.DoctorCertificate
		, dm.DoctorClinicCode
		, dm.DoctorClinicNameTH
		, dm.DoctorClinicNameEN
		, dm.DoctorDepartmentCode
		, dm.DoctorDepartmentNameTH
		, dm.DoctorDepartmentNameEN
		, dm.DoctorSpecialtyCode
		, dm.DoctorSpecialtyNameTH
		, dm.DoctorSpecialtyNameEN
		, 'ReferIn' as 'Refer'
		, a.RefFromCode as 'ReferType'
		, dbo.sysconname(a.RefFromCode,42266,2) as 'ReferTypeNameTH'
		, dbo.sysconname(a.RefFromCode,42266,1) as 'ReferTypeNameEN'
		, a.RefFromHospital as 'ReferHospital'
		, dbo.sysconname(a.RefFromHospital,42025,2) as 'ReferHospitalNameTH'
		, dbo.sysconname(a.RefFromHospital,42025,1) as 'ReferHospitalNameEN'
		, '' as 'Remarks'
		, b.ICDCode
		, dbo.CutSortChar(c.LocalName) as 'DiagNameTH'
		, dbo.CutSortChar(c.EnglishName) as 'DiagNameEN'
from	HNIPD_MASTER a
		left join HNIPD_DIAG b on a.AN=b.AN and b.SuffixTiny = 1
		left join HNICD_MASTER c on b.ICDCode=c.IcdCode
		left join 
		(
			select	a.AN
					, a.Doctor as DoctorCode
					, dbo.CutSortChar(b.LocalName) as DoctorNameTH
					, dbo.CutSortChar(b.EnglishName) as DoctorNameEN
					, b.CertifyPublicNo as DoctorCertificate
					, b.Clinic as DoctorClinicCode
					, dbo.sysconname(b.Clinic,42203,2) as DoctorClinicNameTH
					, dbo.sysconname(b.Clinic,42203,1) as DoctorClinicNameEN
					, b.ComposeDept as DoctorDepartmentCode
					, dbo.sysconname(b.ComposeDept,10145,2) as DoctorDepartmentNameTH
					, dbo.sysconname(b.ComposeDept,10145,1) as DoctorDepartmentNameEN
					, b.Specialty as DoctorSpecialtyCode
					, dbo.sysconname(b.Specialty,42197,2) as DoctorSpecialtyNameTH
					, dbo.sysconname(b.Specialty,42197,1) as DoctorSpecialtyNameEN
					, a.PrivateCase
			from	HNIPD_DOCTOR a
					join HNDOCTOR_MASTER b on a.Doctor = b.doctor
			--where	a.AN in (select am.AN from HNIPD_MASTER am where am.AdmDateTime between GETDATE()-5 and GETDATE())
					and a.HNDoctorConsultType = 2 
					and a.OffFromDateTime is null
		)dm on a.AN = dm.AN
where	a.RefFromCode is not null
Union All
select top 10
		  'PT2' as 'BU'
		, a.HN as 'PatientID'
		, a.AdmDateTime as 'Date'
		, a.AN as 'VN/AN'
		, dm.DoctorCode
		, dm.DoctorNameTH
		, dm.DoctorNameEN
		, dm.DoctorCertificate
		, dm.DoctorClinicCode
		, dm.DoctorClinicNameTH
		, dm.DoctorClinicNameEN
		, dm.DoctorDepartmentCode
		, dm.DoctorDepartmentNameTH
		, dm.DoctorDepartmentNameEN
		, dm.DoctorSpecialtyCode
		, dm.DoctorSpecialtyNameTH
		, dm.DoctorSpecialtyNameEN
		, 'ReferOut' as 'Refer'
		, a.RefToCode as 'ReferType'
		, dbo.sysconname(a.RefToCode,42266,2) as 'ReferTypeNameTH'
		, dbo.sysconname(a.RefToCode,42266,1) as 'ReferTypeNameEN'
		, a.RefToHospital as 'ReferHospital'
		, dbo.sysconname(a.RefToHospital,42025,2) as 'ReferHospitalNameTH'
		, dbo.sysconname(a.RefToHospital,42025,1) as 'ReferHospitalNameEN'
		, '' as 'Remarks'
		, b.ICDCode
		, dbo.CutSortChar(c.LocalName) as 'DiagNameTH'
		, dbo.CutSortChar(c.EnglishName) as 'DiagNameEN'
from	HNIPD_MASTER a
		left join HNIPD_DIAG b on a.AN=b.AN and b.SuffixTiny = 1
		left join HNICD_MASTER c on b.ICDCode=c.IcdCode
		left join 
		(
			select	a.AN
					, a.Doctor as DoctorCode
					, dbo.CutSortChar(b.LocalName) as DoctorNameTH
					, dbo.CutSortChar(b.EnglishName) as DoctorNameEN
					, b.CertifyPublicNo as DoctorCertificate
					, b.Clinic as DoctorClinicCode
					, dbo.sysconname(b.Clinic,42203,2) as DoctorClinicNameTH
					, dbo.sysconname(b.Clinic,42203,1) as DoctorClinicNameEN
					, b.ComposeDept as DoctorDepartmentCode
					, dbo.sysconname(b.ComposeDept,10145,2) as DoctorDepartmentNameTH
					, dbo.sysconname(b.ComposeDept,10145,1) as DoctorDepartmentNameEN
					, b.Specialty as DoctorSpecialtyCode
					, dbo.sysconname(b.Specialty,42197,2) as DoctorSpecialtyNameTH
					, dbo.sysconname(b.Specialty,42197,1) as DoctorSpecialtyNameEN
					, a.PrivateCase
			from	HNIPD_DOCTOR a
					join HNDOCTOR_MASTER b on a.Doctor = b.doctor
			--where	a.AN in (select am.AN from HNIPD_MASTER am where am.AdmDateTime between GETDATE()-5 and GETDATE())
					and a.HNDoctorConsultType = 2 
					and a.OffFromDateTime is null
		)dm on a.AN = dm.AN
where	a.RefToCode is not null