select top 100
	'PT2' as BU
	, pth.HN as PatientID
	, pth.FacilityRmsNo
	, pth.RequestNo
	, pth.EntryDateTime
	, pth.RequestDoctor
	, dbo.CutSortChar(doc.LocalName) as RequestDoctorNameTH
	, dbo.CutSortChar(doc.EnglishName) as RequestDoctorNameEN
	, case when pth.HNAlreadySettleType = 0 then 'None'
			  when pth.HNAlreadySettleType = 1 then 'Charged'
			  when pth.HNAlreadySettleType = 2 then 'Free Of Charge'
			  when pth.HNAlreadySettleType = 3 then 'Paid Out'
		 end as HNAlready
	, pth.PTTherapistCode
	, dbo.sysconname(pth.PTTherapistCode,42629,2) as PTTherapistNameTH
	, dbo.sysconname(pth.PTTherapistCode,42629,1) as PTTherapistNameEN
	, pth.PatientType
	, dbo.sysconname(pth.PatientType,42051,2) as PatientTypeNameTH
	, dbo.sysconname(pth.PatientType,42051,1) as PatientTypeNameEN
	, pth.LastAttendDateTime
	, pth.LastChargeDateTime
	, pth.RequestByUserCode
	, dbo.sysconname(pth.RequestByUserCode,10031,2) as RequestByUserNameTH
	, dbo.sysconname(pth.RequestByUserCode,10031,1) as RequestByUserNameEN
	, pth.RightCode
	, dbo.sysconname(pth.RightCode,42086,2) as RightNameTH
	, dbo.sysconname(pth.RightCode,42086,1) as RightNameEN
	, pth.AppointmentNo
	, pth.AppointmentDateTime
	, pth.Clinic
	, dbo.sysconname(pth.Clinic,42203,2) as ClinicNameTH
	, dbo.sysconname(pth.Clinic,42203,1) as ClinicNameEN
	, pth.Ward
	, dbo.sysconname(pth.Ward,42201,2) as WardNameTH
	, dbo.sysconname(pth.Ward,42201,1) as WardNameEN
	, pth.CaseCloseCode
	, dbo.sysconname(pth.CaseCloseCode,42630,2) as CaseCloseNameTH
	, dbo.sysconname(pth.CaseCloseCode,42630,1) as CaseCloseNameEN
	, pth.CaseCloseDateTime
	, pth.Remarks
			from HNPTREQ_HEADER pth
			left join HNDOCTOR_MASTER doc on pth.RequestDoctor=doc.Doctor
			where pth.RequestNo = 'PT02550-68'
			--where PTTherapistCode is not null
			order by EntryDateTime desc