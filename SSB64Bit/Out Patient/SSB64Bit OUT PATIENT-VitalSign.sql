select Distinct
		'PT2' as 'BU'
		,vnm.HN as 'PatientID'
		,convert(varchar,a.VISITDATE,112)+convert(varchar,a.VN)+ '1' as 'VisitID'
		,a.VISITDATE as 'VisitDate'
		,a.VN as 'VN'
		,a.SuffixTiny as 'Suffix'
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
from	HNOPD_VITALSIGN a
		left join HNOPD_MASTER vnm on a.VN=vnm.VN and a.VisitDate=vnm.VisitDate
where	a.VisitDate = CAST(GETDATE() as date)