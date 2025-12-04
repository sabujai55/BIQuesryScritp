use SSBLIVE
go

select 'PT2' as BU,
		adm.HN as PatientID,
		CONVERT(varchar,adm.AdmDateTime,112)+adm.AN as AdmitID,
		adm.AdmDateTime as AdmitDate,
		adm.AN as AN,
		ipddiag.SuffixTiny as Suffix,
		adm.AdmWard as WardCode,
		dbo.sysconname(adm.AdmWard,42201,2) as WardNameTH, --แก้ไขวันที่ 03/03/2568
		dbo.sysconname(adm.AdmWard,42201,1) as WardNameEN, --เพิ่มวันที่ 03/03/2568
		ipddiag.DiagDateTime as DiagDateTime,
		ipddiag.ICDCode as PrimaryDiagnosisCode,
		dbo.ICDName(ipddiag.ICDCode,2) as PrimaryDiagnosisNameTH,
		dbo.ICDName(ipddiag.ICDCode,1) as PrimaryDiagnosisNameEN,

		ipddiag.IcdCmCode1,
		dbo.ICDCMName(ipddiag.IcdCmCode1,2) as ICDCm1NameTH,
		dbo.ICDCMName(ipddiag.IcdCmCode1,1) as ICDCm1NameEN,
		ipddiag.IcdCmCode2,
		dbo.ICDCMName(ipddiag.IcdCmCode2,2) as ICDCm2NameTH,
		dbo.ICDCMName(ipddiag.IcdCmCode2,1) as ICDCm2NameEN,
		ipddiag.IcdCmCode3,
		dbo.ICDCMName(ipddiag.IcdCmCode3,2) as ICDCm3NameTH,
		dbo.ICDCMName(ipddiag.IcdCmCode3,1) as ICDCm3NameEN,
		ipddiag.IcdCmCode4,
		dbo.ICDCMName(ipddiag.IcdCmCode4,2) as ICDCm4NameTH,
		dbo.ICDCMName(ipddiag.IcdCmCode4,1) as ICDCm4NameEN,
		ipddiag.IcdCmCode5,
		dbo.ICDCMName(ipddiag.IcdCmCode5,2) as ICDCm5NameTH,
		dbo.ICDCMName(ipddiag.IcdCmCode5,1) as ICDCm5NameEN,
		ipddiag.IcdCmCode6,
		dbo.ICDCMName(ipddiag.IcdCmCode6,2) as ICDCm6NameTH,
		dbo.ICDCMName(ipddiag.IcdCmCode6,1) as ICDCm6NameEN,
		ipddiag.IcdCmCode7,
		dbo.ICDCMName(ipddiag.IcdCmCode7,2) as ICDCm7NameTH,
		dbo.ICDCMName(ipddiag.IcdCmCode7,1) as ICDCm7NameEN,
		ipddiag.IcdCmCode8,
		dbo.ICDCMName(ipddiag.IcdCmCode8,2) as ICDCm8NameTH,
		dbo.ICDCMName(ipddiag.IcdCmCode8,1) as ICDCm8NameEN,
		ipddiag.IcdCmCode9,
		dbo.ICDCMName(ipddiag.IcdCmCode9,2) as ICDCm9NameTH,
		dbo.ICDCMName(ipddiag.IcdCmCode9,1) as ICDCm9NameEN,
		ipddiag.IcdCmCode10,
		dbo.ICDCMName(ipddiag.IcdCmCode10,2) as ICDCm10NameTH,
		dbo.ICDCMName(ipddiag.IcdCmCode10,1) as ICDCm10NameEN,
		ipddiag.EntryByUserCode as EntryByUserCode, --แก้ไขวันที่ 03/03/2568
		dbo.sysconname(ipddiag.EntryByUserCode,10031,2) as EntryByUserNameTH, --เพิ่มวันที่ 03/03/2568
		dbo.sysconname(ipddiag.EntryByUserCode,10031,1) as EntryByUserNameEN, --เพิ่มวันที่ 03/03/2568
		ipddiag.RegisterDate as RegisterDate,
		ipddiag.ChronicCreteriaCode as ChronicCreteriaCode,
		dbo.sysconname(ipddiag.ChronicCreteriaCode,43523,2) as ChronicCreteriaNameTH,
		dbo.sysconname(ipddiag.ChronicCreteriaCode,43523,1) as ChronicCreteriaNameEN,

		ipddiag.Doctor as DoctorCode, --เพิ่มวันที่ 03/03/2568
		dbo.CutSortChar(doc.LocalName) as DoctorNameTH, --เพิ่มวันที่ 03/03/2568
		dbo.CutSortChar(doc.EnglishName) as DoctorNameEN, --เพิ่มวันที่ 03/03/2568
		doc.CertifyPublicNo as DoctorCertificate,
		doc.Clinic as DoctorClinicCode,
		dbo.sysconname(doc.Clinic,42203,2) as DoctorClinicNameTH,
		dbo.sysconname(doc.Clinic,42203,1) as DoctorClinicNameEN,
		doc.ComposeDept as DoctorDepartmentCode,
		dbo.sysconname(doc.ComposeDept,10145,2) as DoctorDepartmentNameTH,
		dbo.sysconname(doc.ComposeDept,10145,1) as DoctorDepartmentNameEN,
		doc.Specialty as DoctorSpecialtyCode,
		dbo.sysconname(doc.Specialty,42197,2) as DoctorSpecialtyNameTH,
		dbo.sysconname(doc.Specialty,42197,1) as DoctorSpecialtyNameEN,

		ipddiag.ECode, --เพิ่มวันที่ 03/03/2568
		dbo.ICDName(ipddiag.ECode,2) as ECodeNameTH,
		dbo.ICDName(ipddiag.ECode,1) as ECodeNameEN,

		ipddiag.RemarksMemo, --เพิ่มวันที่ 03/03/2568

		ipddiag.UnderlyingICDCode1, --เพิ่มวันที่ 03/03/2568
		dbo.ICDName(ipddiag.UnderlyingICDCode1,2) as UnderlyingICD1NameTH,
		dbo.ICDName(ipddiag.UnderlyingICDCode1,1) as UnderlyingICD1NameEN,
		ipddiag.UnderlyingICDCode2, --เพิ่มวันที่ 03/03/2568
		dbo.ICDName(ipddiag.UnderlyingICDCode2,2) as UnderlyingICD2NameTH,
		dbo.ICDName(ipddiag.UnderlyingICDCode2,1) as UnderlyingICD2NameEN,
		ipddiag.UnderlyingICDCode3, --เพิ่มวันที่ 03/03/2568
		dbo.ICDName(ipddiag.UnderlyingICDCode3,2) as UnderlyingICD3NameTH,
		dbo.ICDName(ipddiag.UnderlyingICDCode3,1) as UnderlyingICD3NameEN, --เพิ่มวันที่ 03/03/2568
		ipddiag.UnderlyingICDCode4, --เพิ่มวันที่ 03/03/2568
		dbo.ICDName(ipddiag.UnderlyingICDCode4,2) as UnderlyingICD4NameTH,
		dbo.ICDName(ipddiag.UnderlyingICDCode4,1) as UnderlyingICD4NameEN,
		ipddiag.UnderlyingICDCode5, --เพิ่มวันที่ 03/03/2568
		dbo.ICDName(ipddiag.UnderlyingICDCode5,2) as UnderlyingICD5NameTH,
		dbo.ICDName(ipddiag.UnderlyingICDCode5,1) as UnderlyingICD5NameEN,
		ipddiag.UnderlyingICDCode6,
		dbo.ICDName(ipddiag.UnderlyingICDCode6,2) as UnderlyingICD6NameTH,
		dbo.ICDName(ipddiag.UnderlyingICDCode6,1) as UnderlyingICD6NameEN,
		ipddiag.UnderlyingICDCode7,
		dbo.ICDName(ipddiag.UnderlyingICDCode7,2) as UnderlyingICD7NameTH,
		dbo.ICDName(ipddiag.UnderlyingICDCode7,1) as UnderlyingICD7NameEN,
		ipddiag.UnderlyingICDCode8,
		dbo.ICDName(ipddiag.UnderlyingICDCode8,2) as UnderlyingICD8NameTH,
		dbo.ICDName(ipddiag.UnderlyingICDCode8,1) as UnderlyingICD8NameEN,
		ipddiag.UnderlyingICDCode9,
		dbo.ICDName(ipddiag.UnderlyingICDCode9,2) as UnderlyingICD9NameTH,
		dbo.ICDName(ipddiag.UnderlyingICDCode9,1) as UnderlyingICD9NameEN,
		ipddiag.UnderlyingICDCode10,
		dbo.ICDName(ipddiag.UnderlyingICDCode10,2) as UnderlyingICD10NameTH,
		dbo.ICDName(ipddiag.UnderlyingICDCode10,1) as UnderlyingICD10NameEN,


		ipddiag.ComplicationsICDCode1, --เพิ่มวันที่ 03/03/2568
		dbo.ICDName(ipddiag.ComplicationsICDCode1,2) as ComplicationsICD1NameTH,
		dbo.ICDName(ipddiag.ComplicationsICDCode1,1) as ComplicationsICD1NameEN,
		ipddiag.ComplicationsICDCode2, --เพิ่มวันที่ 03/03/2568
		dbo.ICDName(ipddiag.ComplicationsICDCode2,2) as ComplicationsICD2NameTH,
		dbo.ICDName(ipddiag.ComplicationsICDCode2,1) as ComplicationsICD2NameEN,
		ipddiag.ComplicationsICDCode3, --เพิ่มวันที่ 03/03/2568
		dbo.ICDName(ipddiag.ComplicationsICDCode3,2) as ComplicationsICD3NameTH,
		dbo.ICDName(ipddiag.ComplicationsICDCode3,1) as ComplicationsICD3NameEN, --เพิ่มวันที่ 03/03/2568
		ipddiag.ComplicationsICDCode4, --เพิ่มวันที่ 03/03/2568
		dbo.ICDName(ipddiag.ComplicationsICDCode4,2) as ComplicationsICD4NameTH,
		dbo.ICDName(ipddiag.ComplicationsICDCode4,1) as ComplicationsICD4NameEN, --เพิ่มวันที่ 03/03/2568
		ipddiag.ComplicationsICDCode5, --เพิ่มวันที่ 03/03/2568
		dbo.ICDName(ipddiag.ComplicationsICDCode5,2) as ComplicationsICD5NameTH,
		dbo.ICDName(ipddiag.ComplicationsICDCode5,1) as ComplicationsICD5NameEN,
		null as ComplicationsICDCode6,
		null as ComplicationsICD6NameTH,
		null as ComplicationsICD6NameEN,
		null as ComplicationsICDCode7,
		null as ComplicationsICD7NameTH,
		null as ComplicationsICD7NameEN,
		null as ComplicationsICDCode8,
		null as ComplicationsICD8NameTH,
		null as ComplicationsICD8NameEN,
		null as ComplicationsICDCode9,
		null as ComplicationsICD9NameTH,
		null as ComplicationsICD9NameEN,
		null as ComplicationsICDCode10,
		null as ComplicationsICD10NameTH,
		null as ComplicationsICD10NameEN,

		ipddiag.OtherICDCode1, --เพิ่มวันที่ 03/03/2568
		dbo.ICDName(ipddiag.OtherICDCode1,2) as OtherICD1NameTH,
		dbo.ICDName(ipddiag.OtherICDCode1,1) as OtherICD1NameEN,
		ipddiag.OtherICDCode2, --เพิ่มวันที่ 03/03/2568
		dbo.ICDName(ipddiag.OtherICDCode2,2) as OtherICD2NameTH,
		dbo.ICDName(ipddiag.OtherICDCode2,1) as OtherICD2NameEN,
		ipddiag.OtherICDCode3, --เพิ่มวันที่ 03/03/2568
		dbo.ICDName(ipddiag.OtherICDCode3,2) as OtherICD3NameTH,
		dbo.ICDName(ipddiag.OtherICDCode3,1) as OtherICD3NameEN,
		ipddiag.OtherICDCode4, --เพิ่มวันที่ 03/03/2568
		dbo.ICDName(ipddiag.OtherICDCode4,2) as OtherICD4NameTH,
		dbo.ICDName(ipddiag.OtherICDCode4,1) as OtherICD4NameEN,
		null as OtherICDCode5,
		null as OtherICD5NameTH,
		null as OtherICD5NameEN,
		null as OtherICDCode6,
		null as OtherICD6NameTH,
		null as OtherICD6NameEN,
		null as OtherICDCode7,
		null as OtherICD7NameTH,
		null as OtherICD7NameEN,
		null as OtherICDCode8,
		null as OtherICD8NameTH,
		null as OtherICD8NameEN,
		null as OtherICDCode9,
		null as OtherICD9NameTH,
		null as OtherICD9NameEN,
		null as OtherICDCode10,
		null as OtherICD10NameTH,
		null as OtherICD10NameEN,

		ipddiag.OperationDoctor1 as OperationDoctorCode1, --เพิ่มวันที่ 03/03/2568
		dbo.Doctorname(ipddiag.OperationDoctor1,2) as OperationDoctor1NameTH,
		dbo.Doctorname(ipddiag.OperationDoctor1,1) as OperationDoctor1NameEN,
		ipddiag.OperationDoctor2 as OperationDoctorCode2, --เพิ่มวันที่ 03/03/2568
		dbo.Doctorname(ipddiag.OperationDoctor2,2) as OperationDoctor2NameTH,
		dbo.Doctorname(ipddiag.OperationDoctor2,1) as OperationDoctor2NameEN,
		ipddiag.OperationDoctor3 as OperationDoctorCode3, --เพิ่มวันที่ 03/03/2568
		dbo.Doctorname(ipddiag.OperationDoctor3,2) as OperationDoctor3NameTH,
		dbo.Doctorname(ipddiag.OperationDoctor3,1) as OperationDoctor3NameEN,
		ipddiag.OperationDoctor4 as OperationDoctorCode4, --เพิ่มวันที่ 03/03/2568
		dbo.Doctorname(ipddiag.OperationDoctor4,2) as OperationDoctor4NameTH,
		dbo.Doctorname(ipddiag.OperationDoctor4,1) as OperationDoctor4NameEN,
		ipddiag.OperationDoctor5 as OperationDoctorCode5, --เพิ่มวันที่ 03/03/2568
		dbo.Doctorname(ipddiag.OperationDoctor5,2) as OperationDoctor5NameTH,
		dbo.Doctorname(ipddiag.OperationDoctor5,1) as OperationDoctor5NameEN,
		ipddiag.OperationDoctor6 as OperationDoctorCode6, --เพิ่มวันที่ 03/03/2568
		dbo.Doctorname(ipddiag.OperationDoctor6,2) as OperationDoctor6NameTH,
		dbo.Doctorname(ipddiag.OperationDoctor6,1) as OperationDoctor6NameEN,
		ipddiag.OperationDoctor7 as OperationDoctorCode7, --เพิ่มวันที่ 03/03/2568
		dbo.Doctorname(ipddiag.OperationDoctor7,2) as OperationDoctor7NameTH,
		dbo.Doctorname(ipddiag.OperationDoctor7,1) as OperationDoctor7NameEN,
		ipddiag.OperationDoctor8 as OperationDoctorCode8, --เพิ่มวันที่ 03/03/2568
		dbo.Doctorname(ipddiag.OperationDoctor8,2) as OperationDoctor8NameTH,
		dbo.Doctorname(ipddiag.OperationDoctor8,1) as OperationDoctor8NameEN,
		ipddiag.OperationDoctor9 as OperationDoctorCode9, --เพิ่มวันที่ 03/03/2568
		dbo.Doctorname(ipddiag.OperationDoctor9,2) as OperationDoctor9NameTH,
		dbo.Doctorname(ipddiag.OperationDoctor9,1) as OperationDoctor9NameEN,
		ipddiag.OperationDoctor10 as OperationDoctorCode10, --เพิ่มวันที่ 03/03/2568
		dbo.Doctorname(ipddiag.OperationDoctor10,2) as OperationDoctor10NameTH,
		dbo.Doctorname(ipddiag.OperationDoctor10,1) as OperationDoctor10NameEN
from	HNIPD_MASTER adm
		join HNIPD_DIAG ipddiag on adm.AN=ipddiag.AN
		left join HNDOCTOR_MASTER doc on ipddiag.Doctor = doc.Doctor
		--where ipddiag.ChronicCreteriaCode is not null
where	adm.AN in (select am.AN from HNIPD_MASTER am where am.AdmDateTime between GETDATE()-5 and GETDATE())
		
