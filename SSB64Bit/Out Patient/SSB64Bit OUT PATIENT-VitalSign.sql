select Distinct
'PT2' as 'BU'
,vnm.HN as 'PatientID'
,convert(varchar,vnp.VISITDATE,112)+convert(varchar,vnp.VN)+convert(varchar,vnp.PrescriptionNo) as 'VisitID'
,vnp.VISITDATE as 'VisitDate'
,vnp.VN as 'VN'
,a.SuffixTiny as 'Suffix'
,vnp.CLINIC as 'LocationCode'
,dbo.sysconname(vnp.Clinic,42203,2) as 'LocationNameTH' 
,dbo.sysconname(vnp.Clinic,42203,1) as 'LocationNameEN' 
,a.EntryByUserCode
,dbo.sysconname(a.EntryByUserCode,10031,2) as 'EntryByUserNameTH'
,dbo.sysconname(a.EntryByUserCode,10031,1) as 'EntryByUserNameEN'
,a.EntryDateTime
,a.BodyWeight
,a.Height
,a.BMIValue as 'BMI'
,a.PostBpSystolic
,a.PostBpDiastolic
,a.BpSystolic
,a.BpDiastolic
,a.Temperature
,a.PulseRate
,a.RespirationRate
,a.PainScale
,a.O2Sat
,a.Remarks
		from HNOPD_VITALSIGN a
		left join HNOPD_PRESCRIP vnp on a.VN=vnp.VN and a.VisitDate=vnp.VisitDate
		left join HNOPD_MASTER vnm on a.VN=vnm.VN and a.VisitDate=vnm.VisitDate