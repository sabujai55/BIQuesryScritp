USE SSBLIVE
GO

select	top 10
		'PT2' as 'BU'
		,a.HN as 'PatientID'
		,CONVERT(varchar,a.ADMDATETIME,112)+a.AN as 'AdmitID'
		,doc.AN
		,doc.EntryDateTime as 'MakeDateTime'
		,doc.Doctor as 'DoctorCode'
		,dbo.CutSortChar(dm.LocalName) as 'DoctorNameTH'
		,dbo.CutSortChar(dm.EnglishName) as 'DoctorNameEN'
		, dm.CertifyPublicNo as DoctorCertificate
		, dm.Clinic as DoctorClinicCode
		, dbo.sysconname(dm.Clinic,42203,2) as DoctorClinicNameTH
		, dbo.sysconname(dm.Clinic,42203,1) as DoctorClinicNameEN
		, dm.ComposeDept as DoctorDepartmentCode
		, dbo.sysconname(dm.ComposeDept,10145,2) as DoctorDepartmentNameTH
		, dbo.sysconname(dm.ComposeDept,10145,1) as DoctorDepartmentNameEN
		, dm.Specialty as DoctorSpecialtyCode
		, dbo.sysconname(dm.Specialty,42197,2) as DoctorSpecialtyNameTH
		, dbo.sysconname(dm.Specialty,42197,1) as DoctorSpecialtyNameEN
		, doc.PrivateCase
		, doc.HNDoctorConsultType as 'DoctorType'
		, case
			when doc.HNDoctorConsultType = '0' then 'None'
			when doc.HNDoctorConsultType = '1' then 'Consult'
			when doc.HNDoctorConsultType = '2' then 'Master'
			when doc.HNDoctorConsultType = '3' then 'OR'
			when doc.HNDoctorConsultType = '4' then 'Anesthesiologist'
			when doc.HNDoctorConsultType = '5' then 'LR'
			when doc.HNDoctorConsultType = '6' then 'PT'
			when doc.HNDoctorConsultType = '8' then 'OR_Assistant'
			when doc.HNDoctorConsultType = '9' then 'OR_Scrub'
			when doc.HNDoctorConsultType = '10' then 'OR_Cirulate'
			when doc.HNDoctorConsultType = '11' then 'Attending_Physician'
			when doc.HNDoctorConsultType = '12' then 'On_Duty'
			when doc.HNDoctorConsultType = '15' then 'Round'
			when doc.HNDoctorConsultType = '16' then 'CO Master'
		 end as 'DoctorTypeName'
		, doc.AdmitDoctor
		, doc.DischargeDoctor
		, doc.RemarksMemo
from	HNIPD_DOCTOR doc
		left join HNIPD_MASTER a on doc.AN=a.AN
		left join HNDOCTOR_MASTER dm on doc.Doctor=dm.Doctor
