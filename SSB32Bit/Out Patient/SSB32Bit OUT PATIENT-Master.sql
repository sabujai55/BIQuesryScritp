select top 10 
  opd.BU
, opd.PatientID
, opd.VisitID
, opd.VisitDate
, opd.VN
, opd.PrescriptionNo
, opd.ClinicCode
, opd.ClinicNameTH
, opd.ClinicNameEN
, opd.ClinicDepartmentCode
, opd.ClinicDepartmentNameTH
, opd.ClinicDepartmentNameEN
, opd.DoctorCode
, opd.DoctorNameTH
, opd.DoctorNameEN
, opd.DoctorCertificate
, opd.DoctorClinicCode
, opd.DoctorClinicNameTH
, opd.DoctorClinicNameEN
, opd.DoctorDepartmentCode
, opd.DoctorDepartmentNameTH
, opd.DoctorDepartmentNameEN
, opd.DoctorSpecialtyCode
, opd.DoctorSpecialtyNameTH
, opd.DoctorSpecialtyNameEN
, opd.CloseVisitCode
, opd.CloseVisitNameTH
, opd.CloseVisitNameEN
, opd.AppointmentNo
, opd.AppointmentDateTime
, opd.[Status]
, opd.RegInDateTime
, opd.DiagRms
, opd.DiagRmsName
, opd.NEWPATIENT
, opd.CloseVisitDateTime
, opd.PrescriptionMakeDateTime
, opd.DefaultRightCode
, opd.DefaultRightNameTH
, opd.DefaultRightNameEN
, opd.AccidentCode
, opd.AccidentNameTH
, opd.AccidentNameEN
, opd.ComposeDept
, opd.VisitCode
, opd.VisitNameTH
, opd.VisitNameEN
, opd.EntryByUserCode
, opd.EntryByUserNameTH
, opd.EntryByUserNameEN
, opd.ReVisitCode
, opd.ReVisitNameTH
, opd.ReVisitNameEN
, opd.AN
, opd.OldNew
, opd.PrivateCase
, opd.AgencyCode
, opd.AgencyNameTH
, opd.AgencyNameEN
, opd.NurseAcknowledge
, opd.DiagRmsIn
, opd.DiagRmsOut
, opd.LabReceiveSpecimenDateTime
, opd.LabApproveDateTime
, CONVERT(varchar(12),
	  DATEADD(minute, (case when opd.LabReceiveSpecimenDateTime is not null and opd.LabApproveDateTime is not null
	  then DATEDIFF(Minute, opd.LabReceiveSpecimenDateTime ,opd.LabApproveDateTime) end),0), 114) as TotalTimeLabReceiveSpecimenToLabApprove
, opd.XrayAcknowledgeDateTime
, opd.XrayResultReadyDateTime
, CONVERT(varchar(12),
	  DATEADD(minute, (case when opd.XrayAcknowledgeDateTime is not null and opd.XrayResultReadyDateTime is not null
	  then DATEDIFF(Minute,opd.XrayAcknowledgeDateTime ,opd.XrayResultReadyDateTime) end),0), 114) as TotalTimeXrayAcknowledgeToXrayResultReady
, opd.DrugAcknowledgeDateTime
, opd.DrugReadyDateTime
, opd.CashierReceiveDateTime
, opd.DrugCheckoutDateTime
, opd.TotalTimeDrugAcknowledgeToDrugCheckout
, opd.TotalVisitTime
	from (
		select
		'PLS' as 'BU'
		,vnm.HN as 'PatientID'
		,convert(varchar,vnp.VISITDATE,112)+convert(varchar,vnp.VN)+convert(varchar,vnp.SUFFIX) as 'VisitID'
		,vnp.VISITDATE as 'VisitDate'
		,vnp.VN as 'VN'
		,vnp.SUFFIX as 'PrescriptionNo'
		,vnp.CLINIC as 'ClinicCode'
		,dbo.sysconname(vnp.CLINIC,20016,2) as 'ClinicNameTH' 
		,dbo.sysconname(vnp.CLINIC,20016,1) as 'ClinicNameEN' 
		,'' as 'ClinicDepartmentCode'
		,'' as 'ClinicDepartmentNameTH'
		,'' as 'ClinicDepartmentNameEN'
		,vnp.DOCTOR as 'DoctorCode'
		,dbo.CutSortChar(doc.THAINAME) as 'DoctorNameTH'
		,dbo.CutSortChar(doc.ENGLISHNAME) as 'DoctorNameEN'
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
		,vnp.CLOSEVISITTYPE as 'CloseVisitCode'
		,dbo.sysconname(vnp.CLOSEVISITTYPE,20043,2) as 'CloseVisitNameTH' 
		,dbo.sysconname(vnp.CLOSEVISITTYPE,20043,1) as 'CloseVisitNameEN' 
		,vnp.APPOINTMENTNO as 'AppointmentNo'
		,apm.APPOINTMENTDATETIME as 'AppointmentDateTime'
		,case when CLOSEVISITTYPE is null then 'Active' else 'InActive' end as 'Status'
		,vnp.REGINDATETIME as 'RegInDateTime' 
		,vnp.DISGRMS as 'DiagRms' 
		,dbo.sysconname(vnp.DISGRMS,20042,4) as 'DiagRmsName' 
		,vnm.NEWPATIENT as 'NEWPATIENT' 
		,vnm.VISITOUTDATETIME as 'CloseVisitDateTime' 
		,vnm.VISITINDATETIME as 'PrescriptionMakeDateTime' 
		,vnm.USEDRIGHTCODE as 'DefaultRightCode' 
		,dbo.sysconname(vnm.USEDRIGHTCODE,20019,2) as 'DefaultRightNameTH' 
		,dbo.sysconname(vnm.USEDRIGHTCODE,20019,1) as 'DefaultRightNameEN' 
		,vnm.ACCIDENT as 'AccidentCode' 
		,'' as 'AccidentNameTH' 
		,'' as 'AccidentNameEN' 
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
		,adm.AN
		,CASE WHEN ptc.VisitCnt=1 and vnm.NewPatient=1 THEN 'NewNew'
					 WHEN ptc.VisitCnt=1 and vnm.NewPatient=0 THEN 'OldNew'
					 WHEN ptc.VisitCnt>1 and vnm.NewPatient=0 THEN 'OldOld'
				END as 'OldNew'
		,vnp.PRIVATECASE
		,'' as 'AgencyCode'
		,'' as 'AgencyNameTH'
		,'' as 'AgencyNameEN'
		,vnp.DIAGACKDATETIME as 'NurseAcknowledge'
		,vnp.DIAGINDATETIME as 'DiagRmsIn'
		,vnp.DIAGOUTDATETIME as 'DiagRmsOut'
		, (select top 1 lr.RECEIVESPECIMENDATETIME from LABREQ lr where lr.RECEIVESPECIMENDATETIME is not null and vnp.VN=lr.CHARGETOVN and vnp.VISITDATE=lr.CHARGETOVISITDATE and vnp.SUFFIX=lr.PRESCRIPTIONSUFFIX order by lr.RECEIVESPECIMENDATETIME) as LabReceiveSpecimenDateTime
		, (select top 1 ls.APPROVEDATETIME 
									from LABRESULT ls 
									left join LABREQ lr on  ls.REQUESTNO=lr.REQUESTNO and ls.FACILITYRMSNO=lr.FACILITYRMSNO
									where ls.APPROVEDATETIME is not null and lr.CHARGETOVN=vnp.VN and lr.CHARGETOVISITDATE=vnp.VISITDATE and lr.PRESCRIPTIONSUFFIX=vnp.SUFFIX
									order by ls.APPROVEDATETIME asc) as LabApproveDateTime
		, (select top 1 xr.ACKDATETIME from XRAYREQ xr where xr.ACKDATETIME is not null and vnp.VN=xr.CHARGETOVN and vnp.VISITDATE=xr.CHARGETOVISITDATE and vnp.SUFFIX=xr.PRESCRIPTIONSUFFIX order by xr.ACKDATETIME asc ) as XrayAcknowledgeDateTime
		, (select top 1 xs.APPROVEDATETIME 
									from XRAYRESULT xs 
									left join XRAYREQ xr on xs.REQUESTNO=xr.REQUESTNO and xs.FACILITYRMSNO=xr.FACILITYRMSNO
									where xs.APPROVEDATETIME is not null and xr.CHARGETOVN=vnp.VN and xr.CHARGETOVISITDATE=vnp.VISITDATE and xr.PRESCRIPTIONSUFFIX=vnp.SUFFIX
									order by xs.APPROVEDATETIME asc) as XrayResultReadyDateTime
		, vnp.DRUGACKDATETIME as DrugAcknowledgeDateTime
		, vnp.DRUGREADYDATETIME as DrugReadyDateTime
		, vnp.CASHIERRECEIVEDATETIME as CashierReceiveDateTime
		, vnp.DIAGOUTDATETIME as DrugCheckoutDateTime
		, CONVERT(varchar(12),
			DATEADD(minute, (case when vnp.DRUGACKDATETIME is not null and vnp.DIAGOUTDATETIME is not null
			then DATEDIFF(Minute, vnp.DRUGACKDATETIME ,vnp.DIAGOUTDATETIME) end),0), 114) as TotalTimeDrugAcknowledgeToDrugCheckout
		, CONVERT(varchar(12),
			DATEADD(minute, (case when vnp.CASHIERRECEIVEDATETIME is not null then DATEDIFF(Minute, vnp.DIAGINDATETIME,vnp.CASHIERRECEIVEDATETIME)
			when vnp.DIAGOUTDATETIME is not null then DATEDIFF(Minute, vnp.DIAGINDATETIME,vnp.DIAGOUTDATETIME) 
			end),0), 114) as TotalVisitTime
				from VNPRES vnp
				left join VNMST vnm on vnp.VN=vnm.VN and vnp.VISITDATE=vnm.VISITDATE
				left join HNAPPMNT apm on vnp.APPOINTMENTNO=apm.APPOINTMENTNO
				left join HNDOCTOR doc on vnp.DOCTOR=doc.DOCTOR
				left join SYSCONFIG ssp on doc.SPECIALTY+doc.SUBSPECIALTY = REPLACE(ssp.CODE,' ','') and ssp.CTRLCODE = 20015
				left join ADMMASTER adm on vnm.HN=adm.HN and CONVERT(date,vnm.VISITDATE,101) = CONVERT(date,adm.ADMDATETIME,101)
				left join PATIENT_CLINIC ptc on vnm.HN=ptc.HN and vnp.CLINIC=ptc.CLINIC
		) opd
