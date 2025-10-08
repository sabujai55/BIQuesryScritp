select top 100
		'PT2' as BU
		,lrc.HN as PatientID
		,lrc.FacilityRmsNo
		,lrc.RequestNo
		,lrc.AN
		,lrc.HNBedNo
		,dbo.sysconname(lrc.HNBedNo,42421,2) as HNBedNameTH
		,dbo.sysconname(lrc.HNBedNo,42421,1) as HNBedNameEN
		,lrc.Ward
		,dbo.sysconname(lrc.Ward,42201,2) as WardNameTH
		,dbo.sysconname(lrc.Ward,42201,1) as WardNameEN
		,lrc.AdmCode
		,dbo.sysconname(lrc.AdmCode,42396,2) as AdmNameTH
		,dbo.sysconname(lrc.AdmCode,42396,1) as AdmNameEN
		,lrc.AdmDoctor
		,dbo.CutSortChar(doc.LocalName) as AdmDoctorNameTH
		,dbo.CutSortChar(doc.EnglishName) as AdmDoctorNameEN
		,lrc.PatientType
		,dbo.sysconname(lrc.PatientType,42051,2) as PatientTypeNameTH
		,dbo.sysconname(lrc.PatientType,42051,1) as PatientTypeNameEN
		,lrc.RightCode
		,dbo.sysconname(lrc.RightCode,42086,2) as RightNameTH
		,dbo.sysconname(lrc.RightCode,42086,1) as RightNameEN
		,lrc.NationalityCode
		,dbo.sysconname(lrc.NationalityCode,10119,2) as NationalityNameTH
		,dbo.sysconname(lrc.NationalityCode,10119,1) as NationalityNameEN
		,lrc.RaceCode
		,dbo.sysconname(lrc.RaceCode,10119,2) as RaceNameTH
		,dbo.sysconname(lrc.RaceCode,10119,1) as RaceNameEN
		,lrc.BornOrder
		,lrc.Gender
		,case when lrc.Gender = 1 then 'Ë­Ô§' 
			  when lrc.Gender = 2 then 'ªÒÂ'
			  else ''
		 end as GenderNameTH
		,case when lrc.Gender = 1 then 'Female' 
			  when lrc.Gender = 2 then 'Male'
			  else ''
		 end as GenderNameEN
		,dbo.CutSortChar(lrc.FirstLocalName) as FirstThaiName
		,dbo.CutSortChar(lrc.LastLocalName) as LastThaiName
		,dbo.CutSortChar(lrc.FirstEnglishName) as FirstEnglishName
		,dbo.CutSortChar(lrc.LastEnglishName) as LastEnglishName
		,lrc.BirthDateTime
		,lrc.DeadDateTime
		,lrc.LRAliveCode
		,dbo.sysconname(lrc.LRAliveCode,42884,2) as LRAliveNameTH
		,dbo.sysconname(lrc.LRAliveCode,42884,1) as LRAliveNameEN
		,lrc.LRMode
		,dbo.sysconname(lrc.LRMode,42214,2) as LRModeNameTH
		,dbo.sysconname(lrc.LRMode,42214,1) as LRModeNameEN
		,lrc.IndicationCode1
		,dbo.sysconname(lrc.IndicationCode1,42213,2) as IndicationNameTH1
		,dbo.sysconname(lrc.IndicationCode1,42213,1) as IndicationNameEN1
		,lrc.IndicationCode2
		,dbo.sysconname(lrc.IndicationCode2,42213,2) as IndicationNameTH2
		,dbo.sysconname(lrc.IndicationCode2,42213,1) as IndicationNameEN2
		,lrc.IndicationCode3
		,dbo.sysconname(lrc.IndicationCode3,42213,2) as IndicationNameTH3
		,dbo.sysconname(lrc.IndicationCode3,42213,1) as IndicationNameEN3
		,lrc.NoGADay
		,lrc.WeightGm
		,lrc.LengthCm
		,lrc.Temperature
		,lrc.Temperature2
		,case when lrc.HNLRExpireType = 0 then 'None'
			  when lrc.HNLRExpireType = 2 then 'Peri_Operative_Mortality'
			  when lrc.HNLRExpireType = 3 then 'Neonatal_Mortality'
		 end as HNLRExpireType
		,lrc.MentoOccipital
		,lrc.ChestCm
		,lrc.ApgarScoreOneMinute
		,lrc.ApgarScoreThreeMinute
		,lrc.ApgarScoreFiveMinute
		,lrc.ApgarScoreTenMinute
		,lrc.LRNewBornResultCode
		,dbo.sysconname(lrc.LRNewBornResultCode,42897,2) as LRNewBornResultNameTH
		,dbo.sysconname(lrc.LRNewBornResultCode,42897,1) as LRNewBornResultNameEN
		,lrc.LRNewBornResultCode2
		,dbo.sysconname(lrc.LRNewBornResultCode2,42897,2) as LRNewBornResultNameTH2
		,dbo.sysconname(lrc.LRNewBornResultCode2,42897,1) as LRNewBornResultNameEN2
		,lrc.LRNewBornResultCode3
		,dbo.sysconname(lrc.LRNewBornResultCode3,42897,2) as LRNewBornResultNameTH3
		,dbo.sysconname(lrc.LRNewBornResultCode3,42897,1) as LRNewBornResultNameEN3
		,lrc.LRMedicationCode1
		,dbo.sysconname(lrc.LRMedicationCode1,42888,2) as LRMedicationNameTH1
		,dbo.sysconname(lrc.LRMedicationCode1,42888,1) as LRMedicationNameEN1
		,lrc.LRMedicationCode2
		,dbo.sysconname(lrc.LRMedicationCode2,42888,2) as LRMedicationNameTH2
		,dbo.sysconname(lrc.LRMedicationCode2,42888,1) as LRMedicationNameEN2
		,lrc.IndicationOfOperation1
		,dbo.sysconname(lrc.IndicationOfOperation1,42871,2) as IndicationOfOperationNameTH1
		,dbo.sysconname(lrc.IndicationOfOperation1,42871,1) as IndicationOfOperationNameEN1
		,lrc.IndicationOfOperation2
		,dbo.sysconname(lrc.IndicationOfOperation2,42871,2) as IndicationOfOperationNameTH2
		,dbo.sysconname(lrc.IndicationOfOperation2,42871,1) as IndicationOfOperationNameEN2
		,lrc.AbnormalOnChildCode1
		,dbo.sysconname(lrc.AbnormalOnChildCode1,42217,2) as AbnormalOnChildNameTH1
		,dbo.sysconname(lrc.AbnormalOnChildCode1,42217,1) as AbnormalOnChildNameEN1
		,lrc.AbnormalOnChildCode2
		,dbo.sysconname(lrc.AbnormalOnChildCode2,42217,2) as AbnormalOnChildNameTH2
		,dbo.sysconname(lrc.AbnormalOnChildCode2,42217,1) as AbnormalOnChildNameEN2
			from HNLRREQ_CHILD lrc
			left join HNDOCTOR_MASTER doc on lrc.AdmDoctor=doc.Doctor