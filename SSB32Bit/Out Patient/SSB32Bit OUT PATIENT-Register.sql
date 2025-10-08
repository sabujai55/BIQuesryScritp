select 
'PLS' as 'BU'
,vnm.HN as 'PatientID'
,convert(varchar,vnp.VISITDATE,112)+convert(varchar,vnp.VN)+convert(varchar,vnp.SUFFIX) as 'VisitID'
,vnp.VISITDATE as 'VisitDate'
,vnp.VN as 'VN'
,vnp.SUFFIX as 'PrescriptionNo'
,vnp.CLINIC as 'LocationCode'
,dbo.sysconname(vnp.CLINIC,20016,2) as 'LocationNameTH' --���ѹ��� 26/02/2568
,dbo.sysconname(vnp.CLINIC,20016,1) as 'LocationNameEN' --�����ѹ��� 26/02/2568
,vnp.DOCTOR as 'DoctorCode'
,dbo.CutSortChar(doc.THAINAME) as 'DoctorNameTH'
,dbo.CutSortChar(doc.ENGLISHNAME) as 'DoctorNameEN'
,doc.CERTIFYPUBLICNO as 'DoctorCertificate'
,'' as 'ClinicDepartmentCode'
,'' as 'ClinicDepartmentNameTH'
,'' as 'ClinicDepartmentNameEN'
,vnp.CLOSEVISITTYPE as 'CloseVisitCode'
,dbo.sysconname(vnp.CLOSEVISITTYPE,20043,2) as 'CloseVisitNameTH' --����ѹ��� 26/02/2568
,dbo.sysconname(vnp.CLOSEVISITTYPE,20043,1) as 'CloseVisitNameEN' --�����ѹ��� 26/02/2568
,vnp.APPOINTMENTNO as 'AppointmentNo'
,case when CLOSEVISITTYPE is null then 'Active' else 'InActive' end as 'Status'
,vnp.REGINDATETIME as 'RegInDateTime' --�����ѹ��� 17/02/2568
,vnp.DISGRMS as 'DiagRms' --�����ѹ��� 17/02/2568
,dbo.sysconname(vnp.DISGRMS,20042,4) as 'DiagRmsName' --�����ѹ��� 17/02/2568
,vnm.NEWPATIENT as 'NEWPATIENT' --�����ѹ��� 17/02/2568
,vnm.VISITOUTDATETIME as 'CloseVisitDateTime' --�����ѹ��� 17/02/2568
,vnm.VISITINDATETIME as 'MakeDateTime' --�����ѹ��� 17/02/2568
,vnm.USEDRIGHTCODE as 'DefaultRightCode' --�����ѹ��� 17/02/2568
,dbo.sysconname(vnm.USEDRIGHTCODE,20019,2) as 'DefaultRightNameTH' --�����ѹ��� 26/02/2568
,dbo.sysconname(vnm.USEDRIGHTCODE,20019,1) as 'DefaultRightNameEN' --�����ѹ��� 26/02/2568
,vnm.ACCIDENT as 'AccidentCode' --�����ѹ��� 17/02/2568
,'' as 'AccidentNameTH' --�����ѹ��� 26/02/2568
,'' as 'AccidentNameEN' --�����ѹ��� 26/02/2568
,'' as 'ComposeDept'
,'' as 'VisitCode'
,'' as 'VisitNameTH'
,'' as 'VisitNameEN'
,vnp.ISSUEBYUSERID as 'EntryByUserCode'
,dbo.sysconname(vnp.ISSUEBYUSERID,10000,2) as 'EntryByUserNameTH'
,dbo.sysconname(vnp.ISSUEBYUSERID,10000,1) as 'EntryByUserNameEN'
,'' as 'ReVisitCode'
,'' as 'ReVisitNameTH'
,'' as 'ReVisitNameEN'
		from VNPRES vnp
		left join VNMST vnm on vnp.VN=vnm.VN and vnp.VISITDATE=vnm.VISITDATE
		left join HNDOCTOR doc on vnp.DOCTOR=doc.DOCTOR