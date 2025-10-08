select top 1000
	  opd.BU
	, opd.PatientID
	, opd.HN
	, opd.VisitID
	, opd.VisitDate
	, opd.InDateTime
	, opd.VN
	, opd.PrescriptionNo
	, opd.LocationCode
	, opd.LocationNameTH
	, opd.LocationNameEN
	, opd.DoctorCode
	, opd.DoctorNameTH
	, opd.DoctorNameEN
	, opd.CloseVisitCode
	, opd.CloseVisitNameTH
	, opd.CloseVisitNameEN
	, opd.AppointmentNo
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
	from
			(select 
					 'PLS' as BU
					, vnm.HN as PatientID
					, vnm.HN as HN
					, CONVERT(varchar,vnp.VISITDATE,112)+vnp.VN+CONVERT(varchar,vnp.SUFFIX) as VisitID
					, vnp.VISITDATE as VisitDate
					, vnp.REGINDATETIME as InDateTime
					, vnp.VN as VN
					, vnp.SUFFIX as PrescriptionNo
					, vnp.CLINIC as LocationCode
					, dbo.sysconname(vnp.CLINIC,20016,2) as LocationNameTH
					, dbo.sysconname(vnp.CLINIC,20016,1) as LocationNameEN
					, vnp.DOCTOR as DoctorCode
					, dbo.CutSortChar(doc.THAINAME) as DoctorNameTH
					, dbo.CutSortChar(doc.ENGLISHNAME) as DoctorNameEN
					, vnp.CLOSEVISITTYPE as CloseVisitCode
					, dbo.sysconname(vnp.CLOSEVISITTYPE,20043,2) as CloseVisitNameTH
					, dbo.sysconname(vnp.CLOSEVISITTYPE,20043,1) as CloseVisitNameEN
					, vnp.APPOINTMENTNO as AppointmentNo
					, vnp.DIAGACKDATETIME as NurseAcknowledge
					, vnp.DIAGINDATETIME as DiagRmsIn
					, vnp.DIAGOUTDATETIME as DiagRmsOut
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
							left join HNDOCTOR doc on vnp.DOCTOR=doc.DOCTOR
			)as opd order by opd.VisitDate desc