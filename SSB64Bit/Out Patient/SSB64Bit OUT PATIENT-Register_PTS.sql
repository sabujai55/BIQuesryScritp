select top 10
'PT2' as 'BU'
,vnm.HN as 'PatientID'
,convert(varchar,vnp.VISITDATE,112)+convert(varchar,vnp.VN)+convert(varchar,vnp.PrescriptionNo) as 'VisitID'
,vnp.VISITDATE as 'VisitDate'
,vnp.VN as 'VN'
,vnp.PrescriptionNo as 'PrescriptionNo'
,vnp.CLINIC as 'LocationCode'
,dbo.sysconname(vnp.Clinic,42203,2) as 'LocationNameTH' --แก้ไขวันที่ 26/02/268
,dbo.sysconname(vnp.Clinic,42203,1) as 'LocationNameEN' --เพิ่มวันที่ 26/02/2568
,vnp.Doctor as 'DoctorCode'
,dbo.CutSortChar(doc.LocalName) as 'DoctorNameTH'
,dbo.CutSortChar(doc.EnglishName) as 'DoctorNameEN'
,CertifyPublicNo as 'DoctorCertificate'
,dept.ComposeDept as 'ClinicDepartmentCode' --แก้ไขวันที่ 17/09/2568
,dbo.sysconname(dept.ComposeDept,10145,2) as 'ClinicDepartmentNameTH' --แก้ไขวันที่ 17/09/2568
,dbo.sysconname(dept.ComposeDept,10145,1) as 'ClinicDepartmentNameEN' --แก้ไขวันที่ 17/09/2568
,vnp.CloseVisitCode as 'CloseVisitCode'
,dbo.sysconname(vnp.CloseVisitCode,42261,2) as 'CloseVisitNameTH' --แก้ไขวันที่ 26/02/2568
,dbo.sysconname(vnp.CloseVisitCode,42261,1) as 'CloseVisitNameEN' --เพิ่มวันที่ 26/02/2568
,vnp.AppointmentNo as 'AppointmentNo'
,case when vnp.CloseVisitCode is null then 'Active' else 'InActive' end as 'Status'
,vnm.InDateTime as 'RegInDateTime' --เพิ่มวันที่ 17/02/2568
,vnp.DiagRms as 'DiagRms' --เพิ่มวันที่ 17/02/2568
,dbo.sysconname(vnp.DiagRms,42205,4) as 'DiagRmsName' --เพิ่มวันที่ 17/02/2568
,vnm.NewPatient as 'NEWPATIENT' --เพิ่มวันที่ 17/02/2568
,vnm.OutDateTime as 'CloseVisitDateTime' --เพิ่มวันที่ 17/02/2568
,vnp.MakeDateTime as 'MakeDateTime' --เพิ่มวันที่ 17/02/2568
,vnp.DefaultRightCode as 'DefaultRightCode' --เพิ่มวันที่ 17/02/2568
,dbo.sysconname(vnp.DefaultRightCode,42086,2) as 'DefaultRightNameTH' --เพิ่มวันที่ 26/02/2568
,dbo.sysconname(vnp.DefaultRightCode,42086,1) as 'DefaultRightNameEN' --เพิ่มวันที่ 26/02/2568
,vnm.AccidentCode as 'AccidentCode' --เพิ่มวันที่ 17/02/2568
,dbo.sysconname(vnm.AccidentCode,42416,2) as 'AccidentNameTH' --เพิ่มวันที่ 26/02/2568
,dbo.sysconname(vnm.AccidentCode,42416,1) as 'AccidentNameEN' --เพิ่มวันที่ 26/02/2568
,dept.ComposeDept as 'ComposeDept' --แก้ไขวันที่ 17/09/2568
,vnp.VisitCode --เพิ่มวันที่ 26/02/2568
,dbo.sysconname(vnp.VisitCode,42260,2) as 'VisitNameTH' --เพิ่มวันที่ 26/02/2568
,dbo.sysconname(vnp.VisitCode,42260,1) as 'VisitNameEN' --เพิ่มวันที่ 26/02/2568
,vnp.EntryByUserCode --เพิ่มวันที่ 26/02/2568
,dbo.sysconname(vnp.EntryByUserCode,10031,2) as 'EntryByUserNameTH' --เพิ่มวันที่ 26/02/2568
,dbo.sysconname(vnp.EntryByUserCode,10031,1) as 'EntryByUserNameEN' --เพิ่มวันที่ 26/02/2568
,vnm.ReVisitCode --เพิ่มวันที่ 26/02/2568
,dbo.sysconname(vnm.ReVisitCode,42259,2) as 'ReVisitNameTH' --เพิ่มวันที่ 26/02/2568
,dbo.sysconname(vnm.ReVisitCode,42259,1) as 'ReVisitNameEN' --เพิ่มวันที่ 26/02/2568
		from HNOPD_PRESCRIP vnp
		left join HNOPD_MASTER vnm on vnp.VN=vnm.VN and vnp.VISITDATE=vnm.VISITDATE
		left join HNDOCTOR_MASTER doc on vnp.Doctor=doc.Doctor
		left join DEVDECRYPT.dbo.PYTS_SETUP_CLINIC_CODE dept on vnp.Clinic = dept.Code  
