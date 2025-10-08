select top 10
'PT1' as 'BU'
,vnm.HN as 'PatientID'
,convert(varchar,vnp.VISITDATE,112)+convert(varchar,vnp.VN)+convert(varchar,vnp.PrescriptionNo) as 'VisitID'
,vnp.VISITDATE as 'VisitDate'
,vnp.VN as 'VN'
,vnp.PrescriptionNo as 'PrescriptionNo'
,vnp.CLINIC as 'LocationCode'
,dbo.sysconname(vnp.Clinic,42203,2) as 'LocationNameTH' 
,dbo.sysconname(vnp.Clinic,42203,1) as 'LocationNameEN' 
,vnp.Doctor as 'DoctorCode'
,dbo.CutSortChar(doc.LocalName) as 'DoctorNameTH'
,dbo.CutSortChar(doc.EnglishName) as 'DoctorNameEN'
,CertifyPublicNo as 'DoctorCertificate'
,CAST(SUBSTRING(cndp.Com,27,13)as varchar) as 'ClinicDepartmentCode' 
,dbo.sysconname(CAST(SUBSTRING(cndp.Com,27,13)as varchar),10145,2) as 'ClinicDepartmentNameTH' 
,dbo.sysconname(CAST(SUBSTRING(cndp.Com,27,13)as varchar),10145,1) as 'ClinicDepartmentNameEN' 
,vnp.CloseVisitCode as 'CloseVisitCode'
,dbo.sysconname(vnp.CloseVisitCode,42261,2) as 'CloseVisitNameTH' 
,dbo.sysconname(vnp.CloseVisitCode,42261,1) as 'CloseVisitNameEN' 
,vnp.AppointmentNo as 'AppointmentNo'
,case when vnp.CloseVisitCode is null then 'Active' else 'InActive' end as 'Status'
,vnm.InDateTime as 'RegInDateTime' 
,vnp.DiagRms as 'DiagRms' 
,dbo.sysconname(vnp.DiagRms,42205,4) as 'DiagRmsName' 
,vnm.NewPatient as 'NEWPATIENT' 
,vnm.OutDateTime as 'CloseVisitDateTime' 
,vnp.MakeDateTime as 'MakeDateTime' 
,vnp.DefaultRightCode as 'DefaultRightCode' 
,dbo.sysconname(vnp.DefaultRightCode,42086,2) as 'DefaultRightNameTH' 
,dbo.sysconname(vnp.DefaultRightCode,42086,1) as 'DefaultRightNameEN' 
,vnm.AccidentCode as 'AccidentCode' 
,dbo.sysconname(vnm.AccidentCode,42416,2) as 'AccidentNameTH' 
,dbo.sysconname(vnm.AccidentCode,42416,1) as 'AccidentNameEN' 
,CAST(SUBSTRING(cndp.Com,27,13)as varchar) as 'ComposeDept' 
,vnp.VisitCode 
,dbo.sysconname(vnp.VisitCode,42260,2) as 'VisitNameTH' 
,dbo.sysconname(vnp.VisitCode,42260,1) as 'VisitNameEN' 
,vnp.EntryByUserCode 
,dbo.sysconname(vnp.EntryByUserCode,10031,2) as 'EntryByUserNameTH' 
,dbo.sysconname(vnp.EntryByUserCode,10031,1) as 'EntryByUserNameEN' 
,vnm.ReVisitCode 
,dbo.sysconname(vnm.ReVisitCode,42259,2) as 'ReVisitNameTH' 
,dbo.sysconname(vnm.ReVisitCode,42259,1) as 'ReVisitNameEN' 
		from HNOPD_PRESCRIP vnp
		left join HNOPD_MASTER vnm on vnp.VN=vnm.VN and vnp.VISITDATE=vnm.VISITDATE
		left join HNDOCTOR_MASTER doc on vnp.Doctor=doc.Doctor
		left join DNSYSCONFIG cndp on vnp.Clinic = cndp.Code and cndp.CtrlCode = 42203
		where vnp.VisitCode = '74' --BU = PT1
union all
select top 10
'PT2' as 'BU'
,vnm.HN as 'PatientID'
,convert(varchar,vnp.VISITDATE,112)+convert(varchar,vnp.VN)+convert(varchar,vnp.PrescriptionNo) as 'VisitID'
,vnp.VISITDATE as 'VisitDate'
,vnp.VN as 'VN'
,vnp.PrescriptionNo as 'PrescriptionNo'
,vnp.CLINIC as 'LocationCode'
,dbo.sysconname(vnp.Clinic,42203,2) as 'LocationNameTH' 
,dbo.sysconname(vnp.Clinic,42203,1) as 'LocationNameEN' 
,vnp.Doctor as 'DoctorCode'
,dbo.CutSortChar(doc.LocalName) as 'DoctorNameTH'
,dbo.CutSortChar(doc.EnglishName) as 'DoctorNameEN'
,CertifyPublicNo as 'DoctorCertificate'
,CAST(SUBSTRING(cndp.Com,27,13)as varchar) as 'ClinicDepartmentCode' 
,dbo.sysconname(CAST(SUBSTRING(cndp.Com,27,13)as varchar),10145,2) as 'ClinicDepartmentNameTH' 
,dbo.sysconname(CAST(SUBSTRING(cndp.Com,27,13)as varchar),10145,1) as 'ClinicDepartmentNameEN' 
,vnp.CloseVisitCode as 'CloseVisitCode'
,dbo.sysconname(vnp.CloseVisitCode,42261,2) as 'CloseVisitNameTH' 
,dbo.sysconname(vnp.CloseVisitCode,42261,1) as 'CloseVisitNameEN' 
,vnp.AppointmentNo as 'AppointmentNo'
,case when vnp.CloseVisitCode is null then 'Active' else 'InActive' end as 'Status'
,vnm.InDateTime as 'RegInDateTime' 
,vnp.DiagRms as 'DiagRms' 
,dbo.sysconname(vnp.DiagRms,42205,4) as 'DiagRmsName' 
,vnm.NewPatient as 'NEWPATIENT' 
,vnm.OutDateTime as 'CloseVisitDateTime' 
,vnp.MakeDateTime as 'MakeDateTime' 
,vnp.DefaultRightCode as 'DefaultRightCode' 
,dbo.sysconname(vnp.DefaultRightCode,42086,2) as 'DefaultRightNameTH' 
,dbo.sysconname(vnp.DefaultRightCode,42086,1) as 'DefaultRightNameEN' 
,vnm.AccidentCode as 'AccidentCode' 
,dbo.sysconname(vnm.AccidentCode,42416,2) as 'AccidentNameTH' 
,dbo.sysconname(vnm.AccidentCode,42416,1) as 'AccidentNameEN' 
,CAST(SUBSTRING(cndp.Com,27,13)as varchar) as 'ComposeDept' 
,vnp.VisitCode 
,dbo.sysconname(vnp.VisitCode,42260,2) as 'VisitNameTH' 
,dbo.sysconname(vnp.VisitCode,42260,1) as 'VisitNameEN' 
,vnp.EntryByUserCode 
,dbo.sysconname(vnp.EntryByUserCode,10031,2) as 'EntryByUserNameTH' 
,dbo.sysconname(vnp.EntryByUserCode,10031,1) as 'EntryByUserNameEN' 
,vnm.ReVisitCode 
,dbo.sysconname(vnm.ReVisitCode,42259,2) as 'ReVisitNameTH' 
,dbo.sysconname(vnm.ReVisitCode,42259,1) as 'ReVisitNameEN' 
		from HNOPD_PRESCRIP vnp
		left join HNOPD_MASTER vnm on vnp.VN=vnm.VN and vnp.VISITDATE=vnm.VISITDATE
		left join HNDOCTOR_MASTER doc on vnp.Doctor=doc.Doctor
		left join DNSYSCONFIG cndp on vnp.Clinic = cndp.Code and cndp.CtrlCode = 42203
		where vnp.VisitCode = '33' --BU = PT2
union all
select top 10
'PT3' as 'BU'
,vnm.HN as 'PatientID'
,convert(varchar,vnp.VISITDATE,112)+convert(varchar,vnp.VN)+convert(varchar,vnp.PrescriptionNo) as 'VisitID'
,vnp.VISITDATE as 'VisitDate'
,vnp.VN as 'VN'
,vnp.PrescriptionNo as 'PrescriptionNo'
,vnp.CLINIC as 'LocationCode'
,dbo.sysconname(vnp.Clinic,42203,2) as 'LocationNameTH' 
,dbo.sysconname(vnp.Clinic,42203,1) as 'LocationNameEN' 
,vnp.Doctor as 'DoctorCode'
,dbo.CutSortChar(doc.LocalName) as 'DoctorNameTH'
,dbo.CutSortChar(doc.EnglishName) as 'DoctorNameEN'
,CertifyPublicNo as 'DoctorCertificate'
,CAST(SUBSTRING(cndp.Com,27,13)as varchar) as 'ClinicDepartmentCode' 
,dbo.sysconname(CAST(SUBSTRING(cndp.Com,27,13)as varchar),10145,2) as 'ClinicDepartmentNameTH' 
,dbo.sysconname(CAST(SUBSTRING(cndp.Com,27,13)as varchar),10145,1) as 'ClinicDepartmentNameEN' 
,vnp.CloseVisitCode as 'CloseVisitCode'
,dbo.sysconname(vnp.CloseVisitCode,42261,2) as 'CloseVisitNameTH' 
,dbo.sysconname(vnp.CloseVisitCode,42261,1) as 'CloseVisitNameEN' 
,vnp.AppointmentNo as 'AppointmentNo'
,case when vnp.CloseVisitCode is null then 'Active' else 'InActive' end as 'Status'
,vnm.InDateTime as 'RegInDateTime' 
,vnp.DiagRms as 'DiagRms' 
,dbo.sysconname(vnp.DiagRms,42205,4) as 'DiagRmsName' 
,vnm.NewPatient as 'NEWPATIENT' 
,vnm.OutDateTime as 'CloseVisitDateTime' 
,vnp.MakeDateTime as 'MakeDateTime' 
,vnp.DefaultRightCode as 'DefaultRightCode' 
,dbo.sysconname(vnp.DefaultRightCode,42086,2) as 'DefaultRightNameTH' 
,dbo.sysconname(vnp.DefaultRightCode,42086,1) as 'DefaultRightNameEN' 
,vnm.AccidentCode as 'AccidentCode' 
,dbo.sysconname(vnm.AccidentCode,42416,2) as 'AccidentNameTH' 
,dbo.sysconname(vnm.AccidentCode,42416,1) as 'AccidentNameEN' 
,CAST(SUBSTRING(cndp.Com,27,13)as varchar) as 'ComposeDept' 
,vnp.VisitCode 
,dbo.sysconname(vnp.VisitCode,42260,2) as 'VisitNameTH' 
,dbo.sysconname(vnp.VisitCode,42260,1) as 'VisitNameEN' 
,vnp.EntryByUserCode 
,dbo.sysconname(vnp.EntryByUserCode,10031,2) as 'EntryByUserNameTH' 
,dbo.sysconname(vnp.EntryByUserCode,10031,1) as 'EntryByUserNameEN' 
,vnm.ReVisitCode 
,dbo.sysconname(vnm.ReVisitCode,42259,2) as 'ReVisitNameTH' 
,dbo.sysconname(vnm.ReVisitCode,42259,1) as 'ReVisitNameEN' 
		from HNOPD_PRESCRIP vnp
		left join HNOPD_MASTER vnm on vnp.VN=vnm.VN and vnp.VISITDATE=vnm.VISITDATE
		left join HNDOCTOR_MASTER doc on vnp.Doctor=doc.Doctor
		left join DNSYSCONFIG cndp on vnp.Clinic = cndp.Code and cndp.CtrlCode = 42203
		where vnp.VisitCode = '27' --BU = PT3
union all
select top 10
'PTS' as 'BU'
,vnm.HN as 'PatientID'
,convert(varchar,vnp.VISITDATE,112)+convert(varchar,vnp.VN)+convert(varchar,vnp.PrescriptionNo) as 'VisitID'
,vnp.VISITDATE as 'VisitDate'
,vnp.VN as 'VN'
,vnp.PrescriptionNo as 'PrescriptionNo'
,vnp.CLINIC as 'LocationCode'
,dbo.sysconname(vnp.Clinic,42203,2) as 'LocationNameTH' 
,dbo.sysconname(vnp.Clinic,42203,1) as 'LocationNameEN' 
,vnp.Doctor as 'DoctorCode'
,dbo.CutSortChar(doc.LocalName) as 'DoctorNameTH'
,dbo.CutSortChar(doc.EnglishName) as 'DoctorNameEN'
,CertifyPublicNo as 'DoctorCertificate'
,CAST(SUBSTRING(cndp.Com,27,13)as varchar) as 'ClinicDepartmentCode' 
,dbo.sysconname(CAST(SUBSTRING(cndp.Com,27,13)as varchar),10145,2) as 'ClinicDepartmentNameTH' 
,dbo.sysconname(CAST(SUBSTRING(cndp.Com,27,13)as varchar),10145,1) as 'ClinicDepartmentNameEN' 
,vnp.CloseVisitCode as 'CloseVisitCode'
,dbo.sysconname(vnp.CloseVisitCode,42261,2) as 'CloseVisitNameTH' 
,dbo.sysconname(vnp.CloseVisitCode,42261,1) as 'CloseVisitNameEN' 
,vnp.AppointmentNo as 'AppointmentNo'
,case when vnp.CloseVisitCode is null then 'Active' else 'InActive' end as 'Status'
,vnm.InDateTime as 'RegInDateTime' 
,vnp.DiagRms as 'DiagRms' 
,dbo.sysconname(vnp.DiagRms,42205,4) as 'DiagRmsName' 
,vnm.NewPatient as 'NEWPATIENT' 
,vnm.OutDateTime as 'CloseVisitDateTime' 
,vnp.MakeDateTime as 'MakeDateTime' 
,vnp.DefaultRightCode as 'DefaultRightCode' 
,dbo.sysconname(vnp.DefaultRightCode,42086,2) as 'DefaultRightNameTH' 
,dbo.sysconname(vnp.DefaultRightCode,42086,1) as 'DefaultRightNameEN' 
,vnm.AccidentCode as 'AccidentCode' 
,dbo.sysconname(vnm.AccidentCode,42416,2) as 'AccidentNameTH' 
,dbo.sysconname(vnm.AccidentCode,42416,1) as 'AccidentNameEN' 
,CAST(SUBSTRING(cndp.Com,27,13)as varchar) as 'ComposeDept' 
,vnp.VisitCode 
,dbo.sysconname(vnp.VisitCode,42260,2) as 'VisitNameTH' 
,dbo.sysconname(vnp.VisitCode,42260,1) as 'VisitNameEN' 
,vnp.EntryByUserCode 
,dbo.sysconname(vnp.EntryByUserCode,10031,2) as 'EntryByUserNameTH' 
,dbo.sysconname(vnp.EntryByUserCode,10031,1) as 'EntryByUserNameEN' 
,vnm.ReVisitCode 
,dbo.sysconname(vnm.ReVisitCode,42259,2) as 'ReVisitNameTH' 
,dbo.sysconname(vnm.ReVisitCode,42259,1) as 'ReVisitNameEN' 
		from HNOPD_PRESCRIP vnp
		left join HNOPD_MASTER vnm on vnp.VN=vnm.VN and vnp.VISITDATE=vnm.VISITDATE
		left join HNDOCTOR_MASTER doc on vnp.Doctor=doc.Doctor
		left join DNSYSCONFIG cndp on vnp.Clinic = cndp.Code and cndp.CtrlCode = 42203
		where vnp.VisitCode = 'TM' --BU = PTS