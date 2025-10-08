use SSBLIVE
go

select 'PT2' as 'BU'
		,vnm.HN as 'PatientID'
		,convert(varchar,vnp.VISITDATE,112)+convert(varchar,vnp.VN)+convert(varchar,vnp.PrescriptionNo) as 'VisitID'
		,vnp.VISITDATE as 'VisitDate'
		,vnp.VN as 'VN'
		,vnp.PrescriptionNo as 'PrescriptionNo'
		,vnp.CLINIC as 'ClinicCode' -- ����¹�� ClinicCode �ѹ��� 07/10/2568
		,dbo.sysconname(vnp.Clinic,42203,2) as 'ClinicNameTH' --����ѹ��� 26/02/268
		,dbo.sysconname(vnp.Clinic,42203,1) as 'ClinicNameEN' --�����ѹ��� 26/02/2568
		,CAST(SUBSTRING(cndp.Com,27,13)as varchar) as 'ClinicDepartmentCode' --����ѹ��� 26/02/2568
		,dbo.sysconname(CAST(SUBSTRING(cndp.Com,27,13)as varchar),10145,2) as 'ClinicDepartmentNameTH' --����ѹ��� 26/02/2568
		,dbo.sysconname(CAST(SUBSTRING(cndp.Com,27,13)as varchar),10145,1) as 'ClinicDepartmentNameEN' --�����ѹ��� 26/02/2568

		,vnp.Doctor as 'DoctorCode'
		,dbo.CutSortChar(doc.LocalName) as 'DoctorNameTH'
		,dbo.CutSortChar(doc.EnglishName) as 'DoctorNameEN'
		,CertifyPublicNo as 'DoctorCertificate'
		, doc.Clinic as DoctorClinicCode
		, dbo.sysconname(doc.Clinic,42203,2) as DoctorClinicNameTH --�����ѹ��� 07/10/2568
		, dbo.sysconname(doc.Clinic,42203,1) as DoctorClinicNameEN --�����ѹ��� 07/10/2568
		, doc.ComposeDept as DoctorDepartmentCode
		, dbo.sysconname(doc.ComposeDept,10145,2) as DoctorDepartmentNameTH --�����ѹ��� 07/10/2568
		, dbo.sysconname(doc.ComposeDept,10145,1) as DoctorDepartmentNameEN --�����ѹ��� 07/10/2568
		, doc.Specialty as DoctorSpecialtyCode
		, dbo.sysconname(doc.Specialty,42197,2) as DoctorSpecialtyNameTH --�����ѹ��� 07/10/2568
		, dbo.sysconname(doc.Specialty,42197,1) as DoctorSpecialtyNameEN --�����ѹ��� 07/10/2568

		,vnp.CloseVisitCode as 'CloseVisitCode'
		,dbo.sysconname(vnp.CloseVisitCode,42261,2) as 'CloseVisitNameTH' --����ѹ��� 26/02/2568
		,dbo.sysconname(vnp.CloseVisitCode,42261,1) as 'CloseVisitNameEN' --�����ѹ��� 26/02/2568

		,vnp.AppointmentNo as 'AppointmentNo'
		, ah.AppointDateTime as AppointmentDateTime

		,case when vnp.CloseVisitCode is null then 'Active' else 'InActive' end as 'Status'
		,vnm.InDateTime as 'RegInDateTime' --�����ѹ��� 17/02/2568
		,vnp.DiagRms as 'DiagRms' --�����ѹ��� 17/02/2568
		,dbo.sysconname(vnp.DiagRms,42205,4) as 'DiagRmsName' --�����ѹ��� 17/02/2568
		,vnm.NewPatient as 'NEWPATIENT' --�����ѹ��� 17/02/2568
		,vnm.OutDateTime as 'CloseVisitDateTime' --�����ѹ��� 17/02/2568
		,vnp.MakeDateTime as 'PrescriptionDateTime' --�����ѹ��� 17/02/2568
		,vnp.DefaultRightCode as 'DefaultRightCode' --�����ѹ��� 17/02/2568
		,dbo.sysconname(vnp.DefaultRightCode,42086,2) as 'DefaultRightNameTH' --�����ѹ��� 26/02/2568
		,dbo.sysconname(vnp.DefaultRightCode,42086,1) as 'DefaultRightNameEN' --�����ѹ��� 26/02/2568
		,vnm.AccidentCode as 'AccidentCode' --�����ѹ��� 17/02/2568
		,dbo.sysconname(vnm.AccidentCode,42416,2) as 'AccidentNameTH' --�����ѹ��� 26/02/2568
		,dbo.sysconname(vnm.AccidentCode,42416,1) as 'AccidentNameEN' --�����ѹ��� 26/02/2568
		,CAST(SUBSTRING(cndp.Com,27,13)as varchar) as 'ComposeDept' --�����ѹ��� 26/02/2568
		,vnp.VisitCode --�����ѹ��� 26/02/2568
		,dbo.sysconname(vnp.VisitCode,42260,2) as 'VisitNameTH' --�����ѹ��� 26/02/2568
		,dbo.sysconname(vnp.VisitCode,42260,1) as 'VisitNameEN' --�����ѹ��� 26/02/2568
		,vnp.EntryByUserCode --�����ѹ��� 26/02/2568
		,dbo.sysconname(vnp.EntryByUserCode,10031,2) as 'EntryByUserNameTH' --�����ѹ��� 26/02/2568
		,dbo.sysconname(vnp.EntryByUserCode,10031,1) as 'EntryByUserNameEN' --�����ѹ��� 26/02/2568
		,vnm.ReVisitCode --�����ѹ��� 26/02/2568
		,dbo.sysconname(vnm.ReVisitCode,42259,2) as 'ReVisitNameTH' --�����ѹ��� 26/02/2568
		,dbo.sysconname(vnm.ReVisitCode,42259,1) as 'ReVisitNameEN' --�����ѹ��� 26/02/2568

		, vnp.PrivateCase --�����ѹ��� 07/10/2568
		, vnm.InsuranceSalesAgent --�����ѹ��� 07/10/2568
		, dbo.sysconname(vnm.InsuranceSalesAgent,43961,2) as InsuranceSalesAgentNameTH --�����ѹ��� 07/10/2568
		, dbo.sysconname(vnm.InsuranceSalesAgent,43961,1) as InsuranceSalesAgentNameEN --�����ѹ��� 07/10/2568
		, case when vnp.NewToHere = 1  then 'NewNew' 
		  when vnm.NewPatient = 0 then 
			(
				case when vnp.NewToHere in (1,2) then 'OldNew'
				else 'OldOld' end 
			)
		  end as [OldNew] 
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
		--and vnp.NewToHere != 0
