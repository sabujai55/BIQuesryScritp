use SSBLIVE
go

select	opd.BU
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
		, opd.PatientType
		, opd.PatientTypeNameTH
		, opd.PatientTypeNameEN
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
		  then DATEDIFF(Minute, opd.LabReceiveSpecimenDateTime,opd.LabApproveDateTime) end),0), 114) as TotalTimeLabReceiveSpecimenToLabApprove

		, opd.XrayAcknowledgeDateTime
		, opd.XrayResultReadyDateTime
		, CONVERT(varchar(12),
		  DATEADD(minute, (case when opd.XrayAcknowledgeDateTime is not null and opd.XrayResultReadyDateTime is not null
		  then DATEDIFF(Minute, opd.XrayAcknowledgeDateTime,opd.XrayResultReadyDateTime) end),0), 114) as TotalTimeXrayAcknowledgeToXrayResultReady

		, opd.DrugAcknowledgeDateTime
		, opd.DrugReadyDateTime
		, opd.CashierReceiveDateTime
		, opd.DrugCheckoutDateTime
		, CONVERT(varchar(12),
		  DATEADD(minute, (case when opd.DrugAcknowledgeDateTime is not null and opd.DrugCheckoutDateTime is not null
		  then DATEDIFF(Minute, opd.DrugAcknowledgeDateTime,opd.DrugCheckoutDateTime) end),0), 114) as TotalTimeDrugAcknowledgeToDrugCheckout
		, CONVERT(varchar(12),
		  DATEADD(minute, (case when opd.CashierReceiveDateTime is not null then DATEDIFF(Minute, opd.RegInDateTime,opd.CashierReceiveDateTime)
		  when opd.DrugCheckoutDateTime is not null then DATEDIFF(Minute, opd.RegInDateTime,opd.DrugCheckoutDateTime) 
		  end),0), 114)  as TotalVisitTime
from
(
select 'PT2' as BU
		,vnm.HN as PatientID
		,convert(varchar,vnp.VISITDATE,112)+convert(varchar,vnp.VN)+convert(varchar,vnp.PrescriptionNo) as VisitID
		,vnp.VISITDATE as VisitDate
		,vnp.VN as VN
		,vnp.PrescriptionNo as PrescriptionNo
		,vnp.CLINIC as ClinicCode
		,dbo.sysconname(vnp.Clinic,42203,2) as ClinicNameTH
		,dbo.sysconname(vnp.Clinic,42203,1) as ClinicNameEN
		,CAST(SUBSTRING(cndp.Com,27,13)as varchar) as ClinicDepartmentCode
		,dbo.sysconname(CAST(SUBSTRING(cndp.Com,27,13)as varchar),10145,2) as ClinicDepartmentNameTH
		,dbo.sysconname(CAST(SUBSTRING(cndp.Com,27,13)as varchar),10145,1) as ClinicDepartmentNameEN

		,vnp.Doctor as DoctorCode
		,dbo.CutSortChar(doc.LocalName) as DoctorNameTH
		,dbo.CutSortChar(doc.EnglishName) as DoctorNameEN
		,CertifyPublicNo as DoctorCertificate
		, doc.Clinic as DoctorClinicCode
		, dbo.sysconname(doc.Clinic,42203,2) as DoctorClinicNameTH
		, dbo.sysconname(doc.Clinic,42203,1) as DoctorClinicNameEN
		, doc.ComposeDept as DoctorDepartmentCode
		, dbo.sysconname(doc.ComposeDept,10145,2) as DoctorDepartmentNameTH
		, dbo.sysconname(doc.ComposeDept,10145,1) as DoctorDepartmentNameEN
		, doc.Specialty as DoctorSpecialtyCode
		, dbo.sysconname(doc.Specialty,42197,2) as DoctorSpecialtyNameTH
		, dbo.sysconname(doc.Specialty,42197,1) as DoctorSpecialtyNameEN

		,vnp.CloseVisitCode as CloseVisitCode
		,dbo.sysconname(vnp.CloseVisitCode,42261,2) as CloseVisitNameTH
		,dbo.sysconname(vnp.CloseVisitCode,42261,1) as CloseVisitNameEN

		,vnp.AppointmentNo as AppointmentNo
		, ah.AppointDateTime as AppointmentDateTime

		,case when vnp.CloseVisitCode is null then 'Active' else 'InActive' end as [Status]
		,vnm.InDateTime as RegInDateTime
		,vnp.DiagRms as DiagRms
		,dbo.sysconname(vnp.DiagRms,42205,4) as DiagRmsName
		,vnm.NewPatient as NEWPATIENT
		,vnm.OutDateTime as CloseVisitDateTime
		,vnp.MakeDateTime as PrescriptionMakeDateTime
		,vnp.DefaultRightCode as DefaultRightCode
		,dbo.sysconname(vnp.DefaultRightCode,42086,2) as DefaultRightNameTH
		,dbo.sysconname(vnp.DefaultRightCode,42086,1) as DefaultRightNameEN

		, vnm.PatientType 
		, dbo.sysconname(vnm.PatientType,42051,2) as PatientTypeNameTH
		, dbo.sysconname(vnm.PatientType,42051,1) as PatientTypeNameEN
		,vnm.AccidentCode as AccidentCode
		,dbo.sysconname(vnm.AccidentCode,42416,2) as AccidentNameTH
		,dbo.sysconname(vnm.AccidentCode,42416,1) as AccidentNameEN
		,CAST(SUBSTRING(cndp.Com,27,13)as varchar) as ComposeDept
		,vnp.VisitCode
		,dbo.sysconname(vnp.VisitCode,42260,2) as VisitNameTH
		,dbo.sysconname(vnp.VisitCode,42260,1) as VisitNameEN
		,vnp.EntryByUserCode
		,dbo.sysconname(vnp.EntryByUserCode,10031,2) as EntryByUserNameTH
		,dbo.sysconname(vnp.EntryByUserCode,10031,1) as EntryByUserNameEN
		,vnm.ReVisitCode
		,dbo.sysconname(vnm.ReVisitCode,42259,2) as ReVisitNameTH
		,dbo.sysconname(vnm.ReVisitCode,42259,1) as ReVisitNameEN

		, vnp.PrivateCase
		, vnm.InsuranceSalesAgent as AgencyCode
		, dbo.sysconname(vnm.InsuranceSalesAgent,43961,2) as AgencyNameTH
		, dbo.sysconname(vnm.InsuranceSalesAgent,43961,1) as AgencyNameEN
		, case when vnp.NewToHere = 1  then 'NewNew' 
		  when vnm.NewPatient = 0 then 
			(
				case when vnp.NewToHere in (1,2) then 'OldNew'
				else 'OldOld' end 
			)
		  end as [OldNew] 
        , vnm.AN
        , (select top 1 l.MakeDateTime from HNOPD_LOG l where l.VisitDate = vnp.VisitDate and l.VN = vnp.VN and l.PrescriptionNo = vnp.PrescriptionNo and l.OpdMasterLogType = 14 order by MakeDateTime asc) as NurseAcknowledge
		, (select top 1 l.MakeDateTime from HNOPD_LOG l where l.VisitDate = vnp.VisitDate and l.VN = vnp.VN and l.PrescriptionNo = vnp.PrescriptionNo and l.OpdMasterLogType = 15 order by MakeDateTime asc) as DiagRmsIn
		, (select top 1 l.MakeDateTime from HNOPD_LOG l where l.VisitDate = vnp.VisitDate and l.VN = vnp.VN and l.PrescriptionNo = vnp.PrescriptionNo and l.OpdMasterLogType = 16 order by MakeDateTime asc) as DiagRmsOut
        , (
			select	top 1 
					 ll.MakeDateTime
			from	HNPAT_REQFAC pq 
					inner join HNLABREQ_LOG ll on pq.FacilityRmsNo = ll.FacilityRmsNo and pq.RequestNo = ll.RequestNo
			where	pq.VisitDate = vnp.VisitDate
					and pq.VN = vnp.VN
					and pq.PrescriptionNo = vnp.PrescriptionNo
					and ll.HNLABRequestLogType = 6
			order by ll.MakeDateTime asc
		   ) as LabReceiveSpecimenDateTime
		, (
			select	top 1 
					 ll.MakeDateTime
			from	HNPAT_REQFAC pq 
					inner join HNLABREQ_LOG ll on pq.FacilityRmsNo = ll.FacilityRmsNo and pq.RequestNo = ll.RequestNo
			where	pq.VisitDate = vnp.VisitDate
					and pq.VN = vnp.VN
					and pq.PrescriptionNo = vnp.PrescriptionNo
					and ll.HNLABRequestLogType = 12
			order by ll.MakeDateTime asc
		   ) as LabApproveDateTime
		, (
			select	top 1 
					xl.MakeDateTime
			from	HNPAT_REQFAC pq
					inner join HNXRAYREQ_LOG xl on pq.FacilityRmsNo = xl.FacilityRmsNo and pq.RequestNo = xl.RequestNo
			where	pq.VisitDate = vnp.VisitDate
					and pq.VN = vnp.VN
					and pq.PrescriptionNo = vnp.PrescriptionNo
					and xl.HNXRayRequestLogType = 1
			order by xl.MakeDateTime asc
		   ) as XrayAcknowledgeDateTime
		, (
			select	top 1 
					xl.MakeDateTime
			from	HNPAT_REQFAC pq
					inner join HNXRAYREQ_LOG xl on pq.FacilityRmsNo = xl.FacilityRmsNo and pq.RequestNo = xl.RequestNo
			where	pq.VisitDate = vnp.VisitDate
					and pq.VN = vnp.VN
					and pq.PrescriptionNo = vnp.PrescriptionNo
					and xl.HNXRayRequestLogType = 9
			order by xl.MakeDateTime asc
		   ) as XrayResultReadyDateTime
		, (select top 1 l.MakeDateTime from HNOPD_LOG l where l.VisitDate = vnp.VisitDate and l.VN = vnp.VN and l.PrescriptionNo = vnp.PrescriptionNo and l.OpdMasterLogType = 22 order by MakeDateTime asc) as DrugAcknowledgeDateTime
		, (select top 1 l.MakeDateTime from HNOPD_LOG l where l.VisitDate = vnp.VisitDate and l.VN = vnp.VN and l.PrescriptionNo = vnp.PrescriptionNo and l.OpdMasterLogType = 23 order by MakeDateTime asc) as DrugReadyDateTime
		, (select top 1 l.MakeDateTime from HNOPD_LOG l where l.VisitDate = vnp.VisitDate and l.VN = vnp.VN and l.PrescriptionNo = vnp.PrescriptionNo and l.OpdMasterLogType = 21 order by MakeDateTime asc) as CashierReceiveDateTime
		, (select top 1 l.MakeDateTime from HNOPD_LOG l where l.VisitDate = vnp.VisitDate and l.VN = vnp.VN and l.PrescriptionNo = vnp.PrescriptionNo and l.OpdMasterLogType = 24 order by MakeDateTime asc) as DrugCheckoutDateTime
from	HNOPD_PRESCRIP vnp
		left join HNOPD_MASTER vnm on vnp.VN=vnm.VN and vnp.VISITDATE=vnm.VISITDATE
		left join HNDOCTOR_MASTER doc on vnp.Doctor=doc.Doctor
		left join DNSYSCONFIG cndp on vnp.Clinic = cndp.Code and cndp.CtrlCode = 42203
		left join HNAPPMNT_HEADER ah on vnp.AppointmentNo = ah.AppointmentNo
where	vnp.VisitDate = CAST(GETDATE() as date)
)opd