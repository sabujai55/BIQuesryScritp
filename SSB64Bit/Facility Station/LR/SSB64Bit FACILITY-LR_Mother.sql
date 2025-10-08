use SSBLIVE 
go

select top 100 
		 'PT2' as BU
		,lrh.HN as PatientID
		,lrh.FacilityRmsNo as FacilityRmsNo
		,lrh.RequestNo as RequestNo
		,lrh.EntryDateTime as EntryDateTime
		,lrh.LRBedNo
		,dbo.sysconname(lrh.LRBedNo,42421,2) as LRBedNameTH
		,dbo.sysconname(lrh.LRBedNo,42421,1) as LRBedNameEN
		,lrh.Ward
		,dbo.sysconname(lrh.Ward,42201,2) as WardNameTH
		,dbo.sysconname(lrh.Ward,42201,1) as WardNameEN
		,lrh.PatientType
		,dbo.sysconname(lrh.PatientType,42051,2) as PatientTypeNameTH
		,dbo.sysconname(lrh.PatientType,42051,1) as PatientTypeNameEN
		,lrh.TotalBorn
		,lrh.NoLivingChild
		,lrh.Gravidarum
		,lrh.RightCode
		,dbo.sysconname(lrh.RightCode,42086,2) as RightNameTH
		,dbo.sysconname(lrh.RightCode,42086,1) as RightNameEN
		,lrd3.SetDateTime as LMP
		,lrd4.SetDateTime as EDC
		,lrh.NoGADay
		,lrh.DateTimePlan
		,lrd13.SetDateTime as IN_DateTime
		,lrd14.SetDateTime as OUT_DateTime
		,lrh.RequestDoctor
		,dbo.CutSortChar(doc.LocalName) as RequestDoctorNameTH
		,dbo.CutSortChar(doc.EnglishName) as RequestDoctorNameEN
		,lrh.ANCTypeCode
		,dbo.sysconname(lrh.ANCTypeCode,42651,2) as ANCTypeNameTH
		,dbo.sysconname(lrh.ANCTypeCode,42651,1) as ANCTypeNameEN
		,lrh.IndicationOfOperation1
		,dbo.sysconname(lrh.IndicationOfOperation1,42871,2) as IndicationOfOperationNameTH1
		,dbo.sysconname(lrh.IndicationOfOperation1,42871,1) as IndicationOfOperationNameEN1
		,lrh.IndicationOfOperation2
		,dbo.sysconname(lrh.IndicationOfOperation2,42871,2) as IndicationOfOperationNameTH2
		,dbo.sysconname(lrh.IndicationOfOperation2,42871,1) as IndicationOfOperationNameEN2
		,lrh.IndicationOfOperation3
		,dbo.sysconname(lrh.IndicationOfOperation3,42871,2) as IndicationOfOperationNameTH3
		,dbo.sysconname(lrh.IndicationOfOperation3,42871,1) as IndicationOfOperationNameEN3
		,lrh.LRInductionCode
		,dbo.sysconname(lrh.LRInductionCode,42874,2) as LRInductionNameTH
		,dbo.sysconname(lrh.LRInductionCode,42874,1) as LRInductionNameEN
		,lrh.LRInhibitCode
		,dbo.sysconname(lrh.LRInhibitCode,42876,2) as LRInhibitNameTH
		,dbo.sysconname(lrh.LRInhibitCode,42876,1) as LRInhibitNameEN
		,lrh.InLabourRmsStatusCode
		,dbo.sysconname(lrh.InLabourRmsStatusCode,42219,2) as InLabourRmsStatusNameTH
		,dbo.sysconname(lrh.InLabourRmsStatusCode,42219,1) as InLabourRmsStatusNameEN
		,lrd2.SetDateTime as LastAbort
		,lrd1.SetDateTime as LastChild
		,lrh.RefFromCode
		,dbo.sysconname(lrh.RefFromCode,42265,2) as RefFromNameTH
		,dbo.sysconname(lrh.RefFromCode,42265,1) as RefFromNameEN
		,lrh.RefFromHospital 
		,dbo.sysconname(lrh.RefFromHospital,42025,2) as RefFromHospitalNameTH
		,dbo.sysconname(lrh.RefFromHospital,42025,1) as RefFromHospitalNameEN
		, lrh.HisFirstName as HusbandFirstName
		, lrh.HisLastName as HusbandLastName
		,lrh.Clinic
		,dbo.sysconname(lrh.Clinic,42203,2) as ClinicNameTH
		,dbo.sysconname(lrh.Clinic,42203,1) as ClinicNameEN
		,lrh.RequestByUserCode
		,dbo.sysconname(lrh.RequestByUserCode,10031,2) as RequestByUserNameTH
		,dbo.sysconname(lrh.RequestByUserCode,10031,1) as RequestByUserNameEN
		,lrh.LRPackageCode
		,dbo.sysconname(lrh.LRPackageCode,43541,2) as LRPackageNameTH
		,dbo.sysconname(lrh.LRPackageCode,43541,1) as LRPackageNameEN
		,case when lrh.HNAlreadySettleType = 0 then 'None'
			  when lrh.HNAlreadySettleType = 1 then 'Charged'
			  when lrh.HNAlreadySettleType = 2 then 'Free Of Charge'
			  when lrh.HNAlreadySettleType = 3 then 'Paid Out'
		 end as HNAlready
		,lrh.CxlDateTime
		,lrh.CxlReasonCode
		,dbo.sysconname(lrh.CxlReasonCode,43165,2) as CxlReasonNameTH
		,dbo.sysconname(lrh.CxlReasonCode,43165,1) as CxlReasonNameEN
from	HNLRREQ_HEADER lrh
		left join HNLRREQ_DATE lrd1 on lrh.FacilityRmsNo=lrd1.FacilityRmsNo and lrh.RequestNo=lrd1.RequestNo and lrd1.HNLRDateType = 1
		left join HNLRREQ_DATE lrd2 on lrh.FacilityRmsNo=lrd2.FacilityRmsNo and lrh.RequestNo=lrd2.RequestNo and lrd2.HNLRDateType = 2
		left join HNLRREQ_DATE lrd3 on lrh.FacilityRmsNo=lrd3.FacilityRmsNo and lrh.RequestNo=lrd3.RequestNo and lrd3.HNLRDateType = 3
		left join HNLRREQ_DATE lrd4 on lrh.FacilityRmsNo=lrd4.FacilityRmsNo and lrh.RequestNo=lrd4.RequestNo and lrd4.HNLRDateType = 4
		left join HNLRREQ_DATE lrd13 on lrh.FacilityRmsNo=lrd13.FacilityRmsNo and lrh.RequestNo=lrd13.RequestNo and lrd13.HNLRDateType = 13
		left join HNLRREQ_DATE lrd14 on lrh.FacilityRmsNo=lrd14.FacilityRmsNo and lrh.RequestNo=lrd14.RequestNo and lrd14.HNLRDateType = 14
		left join HNDOCTOR_MASTER doc on lrh.RequestDoctor=doc.Doctor
				--where lrh.LRPackageCode is not null
where	lrh.EntryDateTime between '2025-05-01 00:00:00' and '2025-05-21 23:59:59'
		--lrh.RequestNo = 'LR68/0242'