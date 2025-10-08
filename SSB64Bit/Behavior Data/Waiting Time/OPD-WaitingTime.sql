use SSBLIVE
go

select	opd.BU
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
		  DATEADD(minute, (case when opd.CashierReceiveDateTime is not null then DATEDIFF(Minute, opd.InDateTime,opd.CashierReceiveDateTime)
		  when opd.DrugCheckoutDateTime is not null then DATEDIFF(Minute, opd.InDateTime,opd.DrugCheckoutDateTime) 
		  end),0), 114)  as TotalVisitTime
from 
(
select	'PT2' as BU
		, b.HN as PatientID
		, b.HN
		, FORMAT(a.VisitDate, 'yyyyMMdd') + a.VN + cast(a.PrescriptionNo as varchar(2)) as VisitID
		, a.VisitDate
		, b.InDateTime
		, a.VN
		, a.PrescriptionNo
		, a.Clinic as LocationCode
		, dbo.CutSortChar(sys01.LocalName) as LocationNameTH
		, dbo.CutSortChar(sys01.EnglishName) as LocationNameEN
		, a.Doctor as DoctorCode
		, dbo.CutSortChar(c.LocalName) as DoctorNameTH
		, dbo.CutSortChar(c.EnglishName) as DoctorNameEN
		, a.CloseVisitCode
		, dbo.CutSortChar(sys02.LocalName) as CloseVisitNameTH
		, dbo.CutSortChar(sys02.EnglishName) as CloseVisitNameEN
		, a.AppointmentNo
		, (select top 1 l.MakeDateTime from HNOPD_LOG l where l.VisitDate = a.VisitDate and l.VN = a.VN and l.PrescriptionNo = a.PrescriptionNo and l.OpdMasterLogType = 14 order by MakeDateTime asc) as NurseAcknowledge
		, (select top 1 l.MakeDateTime from HNOPD_LOG l where l.VisitDate = a.VisitDate and l.VN = a.VN and l.PrescriptionNo = a.PrescriptionNo and l.OpdMasterLogType = 15 order by MakeDateTime asc) as DiagRmsIn
		, (select top 1 l.MakeDateTime from HNOPD_LOG l where l.VisitDate = a.VisitDate and l.VN = a.VN and l.PrescriptionNo = a.PrescriptionNo and l.OpdMasterLogType = 16 order by MakeDateTime asc) as DiagRmsOut
		, (
			select	top 1 
					 ll.MakeDateTime
			from	HNPAT_REQFAC pq 
					inner join HNLABREQ_LOG ll on pq.FacilityRmsNo = ll.FacilityRmsNo and pq.RequestNo = ll.RequestNo
			where	pq.VisitDate = a.VisitDate
					and pq.VN = a.VN
					and pq.PrescriptionNo = a.PrescriptionNo
					and ll.HNLABRequestLogType = 6
			order by ll.MakeDateTime asc
		   ) as LabReceiveSpecimenDateTime
		, (
			select	top 1 
					 ll.MakeDateTime
			from	HNPAT_REQFAC pq 
					inner join HNLABREQ_LOG ll on pq.FacilityRmsNo = ll.FacilityRmsNo and pq.RequestNo = ll.RequestNo
			where	pq.VisitDate = a.VisitDate
					and pq.VN = a.VN
					and pq.PrescriptionNo = a.PrescriptionNo
					and ll.HNLABRequestLogType = 12
			order by ll.MakeDateTime asc
		   ) as LabApproveDateTime
		, (
			select	top 1 
					xl.MakeDateTime
			from	HNPAT_REQFAC pq
					inner join HNXRAYREQ_LOG xl on pq.FacilityRmsNo = xl.FacilityRmsNo and pq.RequestNo = xl.RequestNo
			where	pq.VisitDate = a.VisitDate
					and pq.VN = a.VN
					and pq.PrescriptionNo = a.PrescriptionNo
					and xl.HNXRayRequestLogType = 1
			order by xl.MakeDateTime asc
		   ) as XrayAcknowledgeDateTime
		, (
			select	top 1 
					xl.MakeDateTime
			from	HNPAT_REQFAC pq
					inner join HNXRAYREQ_LOG xl on pq.FacilityRmsNo = xl.FacilityRmsNo and pq.RequestNo = xl.RequestNo
			where	pq.VisitDate = a.VisitDate
					and pq.VN = a.VN
					and pq.PrescriptionNo = a.PrescriptionNo
					and xl.HNXRayRequestLogType = 9
			order by xl.MakeDateTime asc
		   ) as XrayResultReadyDateTime
		, (select top 1 l.MakeDateTime from HNOPD_LOG l where l.VisitDate = a.VisitDate and l.VN = a.VN and l.PrescriptionNo = a.PrescriptionNo and l.OpdMasterLogType = 22 order by MakeDateTime asc) as DrugAcknowledgeDateTime
		, (select top 1 l.MakeDateTime from HNOPD_LOG l where l.VisitDate = a.VisitDate and l.VN = a.VN and l.PrescriptionNo = a.PrescriptionNo and l.OpdMasterLogType = 23 order by MakeDateTime asc) as DrugReadyDateTime
		, (select top 1 l.MakeDateTime from HNOPD_LOG l where l.VisitDate = a.VisitDate and l.VN = a.VN and l.PrescriptionNo = a.PrescriptionNo and l.OpdMasterLogType = 21 order by MakeDateTime asc) as CashierReceiveDateTime
		, (select top 1 l.MakeDateTime from HNOPD_LOG l where l.VisitDate = a.VisitDate and l.VN = a.VN and l.PrescriptionNo = a.PrescriptionNo and l.OpdMasterLogType = 24 order by MakeDateTime asc) as DrugCheckoutDateTime
from	HNOPD_PRESCRIP a
		inner join HNOPD_MASTER b on a.VisitDate = b.VisitDate and a.VN = b.VN
		left join HNDOCTOR_MASTER c on a.Doctor = c.Doctor
		left join DNSYSCONFIG sys01 on sys01.CtrlCode = 42203 and a.Clinic = sys01.Code
		left join DNSYSCONFIG sys02 on sys02.CtrlCode = 42261 and a.CloseVisitCode = sys02.Code
where	a.VisitDate = '2025-05-30'
)opd
order by opd.VisitDate, opd.VN, opd.PrescriptionNo