SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

Declare @dto datetime;
Declare @dfrom datetime;
--select @dfrom='2025/06/04 00:00:00.000';
--select @dto='2025/06/04 23:59:59.000';
select  @dfrom=cast((convert(varchar(10),@dd,111)+' 00:00:00:000') as datetime)
select  @dto=cast((convert(varchar(10),@dd1,111)+' 23:59:59:997') as datetime);

--PTS
WITH Picture (HN)
AS
(
SELECT DISTINCT MasterKey

FROM OPENDATASOURCE('SQLOLEDB',
         'Data Source=10.55.189.110;User ID=ptsemrapp;Password=RpkT24&@S$'
         ).SSBDOCUMENT.[dbo].[HN_MEDIA_LIBRARY]
WHERE GroupKey='PATPIC'

)


,CheckPrescription (RowNo,VisitDate,VN,PrescriptionNo,Clinic,Doctor)
AS
(
SELECT row_number() over(partition by visitdate,vn,clinic,doctor order by visitdate,vn,prescriptionno)
	   ,VisitDate
	   ,VN
	   ,PrescriptionNo
	   ,Clinic
	   ,Doctor

FROM HNOPD_PRESCRIP

WHERE VisitDate between @dfrom and @dto

)


,Visit (VisitDate,VisitInDateTime,VN,Suffix,HN,Age,CurrentAge,[Address],Village,Moo,Tambon,Amphoe,Province,PatientType,RightCode,Gender,Doctor,DiagRms,Clinic,CloseVisitType,
		    Sponsor,CompanyNo,NewPatient,AdmFlag,TextPulseRate,TextRespireRate,BPHigh,BPLow,PostBPHigh,PostBPLow,BodyWeight,Height,Temperature,UserName,Blood,Tel,MobilePhone,
			EmailAddress,Religion,Nationality,Race,IDCard,[Type],NewToHere,AppointmentDateTime)
AS
(
SELECT a.VisitDate
		,b.InDateTime
		,a.VN
		,a.PrescriptionNo
		,b.HN
		,'Age'=Datediff("yy",c.birthdatetime,a.VisitDate)
		,'CurrentAge'=c.AgeYear
		,c.[Address1]
		,'Village'=''
		,c.Moo
		,c.Tambon 
		,c.Amphoe
		,c.Province
		,b.PatientType
		,a.DefaultRightCode
		,c.Gender
		,a.Doctor
		,a.DiagRms
		,a.Clinic
		,a.CloseVisitCode
		--,d.ARCode
		,'ARCode'=(select top 1 ARCode from HNOPD_PRESCRIP_RIGHT where a.vn=vn and a.visitdate=visitdate and a.prescriptionno=prescriptionno and rightcode=a.defaultrightcode)
		,b.CompanyCode
		,b.NewPatient
		,case when b.an is not null then 1 else 0 end AdmFlag
		,'PulseRate'=(select top 1 PulseRate from hnopd_vitalsign where visitdate=a.visitdate and vn=a.vn and PulseRate is not null order by entrydatetime asc)
	    ,'RespirationRate'=(select top 1 RespirationRate from hnopd_vitalsign where visitdate=a.visitdate and vn=a.vn and RespirationRate is not null order by entrydatetime asc)
		,'BpSystolic'=(select top 1 BpSystolic from hnopd_vitalsign where visitdate=a.visitdate and vn=a.vn and BpSystolic is not null order by entrydatetime asc)
		,'BpDiastolic'=(select top 1 BpDiastolic from hnopd_vitalsign where visitdate=a.visitdate and vn=a.vn and BpDiastolic is not null order by entrydatetime asc)
		,'PostBpSystolic'=(select top 1 PostBpSystolic from hnopd_vitalsign where visitdate=a.visitdate and vn=a.vn and PostBpSystolic is not null order by entrydatetime asc)
		,'PostBpDiastolic'=(select top 1 PostBpDiastolic from hnopd_vitalsign where visitdate=a.visitdate and vn=a.vn and PostBpDiastolic is not null order by entrydatetime asc)
		,'BodyWeight'=(select top 1 BodyWeight from hnopd_vitalsign where visitdate=a.visitdate and vn=a.vn and BodyWeight is not null order by entrydatetime asc)
		,'Height'=(select top 1 Height from hnopd_vitalsign where visitdate=a.visitdate and vn=a.vn and Height is not null order by entrydatetime asc)
		,'Temperature'=(select top 1 Temperature from hnopd_vitalsign where visitdate=a.visitdate and vn=a.vn and Temperature is not null order by entrydatetime asc)
		,'UserName'=dbo.sysconname(b.OutByUserCode,10031,2)
		,c.BloodGroup
		,c.TelephoneNo
		,c.CommunicableNo
		,c.EmailAddress
		,c.Religion
		,dbo.sysconname(c.NationalityCode,10119,3)
		,c.Race
		,c.IDCard
		,CASE WHEN a.NewToHere=1 and b.VisitCount=1 and b.NewPatient=1 THEN 'NewNew'
			  WHEN a.NewToHere=0 and b.VisitCount=1 and b.NewPatient=0 THEN 'OldNew'
			  WHEN a.NewToHere=0 and b.VisitCount>1 and b.NewPatient=0 THEN 'OldOld'
		 END [Type]
		,a.NewToHere
		,a.AppointmentDateTime

FROM HNOPD_PRESCRIP a
INNER JOIN HNOPD_MASTER b ON a.vn=b.vn and a.visitdate=b.visitdate
INNER JOIN vw_PatientMaster c ON b.HN=c.hn
--LEFT JOIN HNOPD_PRESCRIP_RIGHT d ON a.vn=d.vn and a.visitdate=d.visitdate and a.prescriptionno=d.prescriptionno and d.SuffixTiny=1
--2363
left join HNAPPMNT_HEADER d on a.AppointmentNo=d.AppointmentNo

WHERE a.VisitDate between @dfrom and @dto

)


,Charge (VN,VisitDate,Suffix,HNActivityCode,ActivityCategory,Amt)
AS
(
SELECT VN
	   ,VisitDate
	   ,PrescriptionNo
	   ,HNActivityCode
	   ,ActivityCategory
	   ,sum(amt)
FROM 
(
SELECT a.VN
	   ,a.VisitDate
	   ,a.PrescriptionNo
	   ,a.HNActivityCode
	   ,b.ActivityCategory
	   ,case when hnchargetype=2 then chargeamt *(-1) else chargeamt end Amt

FROM HNOPD_PRESCRIP_MEDICINE a
INNER JOIN DEVDECRYPT.[dbo].[PYTS_SETUP_Activity_Code] b ON a.HNActivityCode=b.Code
INNER JOIN HNOPD_MASTER c ON a.vn=c.vn and a.visitdate=c.visitdate

WHERE a.VisitDate between @dfrom and @dto
and a.cxldatetime is null


UNION ALL


SELECT a.VN
	   ,a.VisitDate
	   ,a.PrescriptionNo
	   ,a.HNActivityCode
	   ,b.ActivityCategory
	   ,case when hnchargetype=2 then chargeamt *(-1) else chargeamt end Amt

FROM HNOPD_PRESCRIP_TREATMENT a
INNER JOIN DEVDECRYPT.[dbo].[PYTS_SETUP_Activity_Code] b ON a.HNActivityCode=b.Code
INNER JOIN HNOPD_MASTER c ON a.vn=c.vn and a.visitdate=c.visitdate

WHERE a.VisitDate between @dfrom and @dto
and a.cxldatetime is null

) r

GROUP BY vn,visitdate,prescriptionno,HNActivityCode,ActivityCategory

)


--,LAB (VisitDate,VN,Flag)
--AS
--(
--SELECT DISTINCT 
--	   a.CHARGETOVISITDATE
--	   ,a.REQUESTFROMVN 
--	   ,'1'

--FROM LABREQ a 
--INNER JOIN LABRESULT b ON a.REQUESTNO=b.REQUESTNO and b.LABCODE in ('4039','7087','7090','7093','7095','7099','7100','7098')

--WHERE a.chargetovisitdate between @dfrom and @dto

--)


,Diag (VN,VisitDate,Suffix,TypeOfThisDiag,SubSuffix,ICDCode,ProcudureICDCMCode1,ProcudureICDCMCode2,ProcudureICDCMCode3,
	   ProcudureICDCMCode4,ECode,RemarksMemo)
AS
(
SELECT b.VN
	   ,b.VisitDate
	   ,b.Suffix
	   ,a.DiagnosisRecordType
	   ,a.SuffixSmall
	   ,a.icdcode
	   ,ICDCMCode1 
	   ,ICDCMCode2 
	   ,ICDCMCode3 
	   ,ICDCMCode4 
	   ,ECode
	   ,a.RemarksMemo

FROM HNOPD_PRESCRIP_DIAG a
INNER JOIN Visit b ON a.visitdate=b.visitdate and a.vn=b.vn and a.PrescriptionNo=b.Suffix

WHERE a.DiagnosisRecordType=1
and a.visitdate between @dfrom and @dto

)


,FreePackage (VN,VisitDate,Suffix,TotalAmt)
AS
(
SELECT a.VN
	   ,a.VisitDate
	   ,a.Suffix
	   ,sum(b.Amt)

FROM Visit a
INNER JOIN HNOPD_RECEIVE_BY b ON a.vn=b.vn and a.visitdate=b.visitdate and a.suffix=b.suffixtiny

WHERE b.hnreceivecode in ('CACI','CACO','CN','CN1','DIS','DIS1','DIS2','DIS3','DPKI','DPKO','UCI','UCO')

GROUP BY a.VN,a.VisitDate,a.suffix

)

---------------------------------------------

SELECT DISTINCT a.VisitDate
	   ,a.VisitInDateTime
	   ,a.VN
	   ,a.Suffix
	   ,a.HN
	   ,'Name'=dbo.getname(a.hn)
	   ,a.Age
	   ,a.[Address]
	   ,a.Village
	   ,a.Moo
	   ,a.Tambon 
	   ,a.Amphoe
	   ,a.Province
	   ,'PatientType'=dbo.sysconname(a.PatientType,42051,3)
	   ,a.RightCode
	   ,'RightName'=dbo.sysconname(a.rightcode,42086,3)
	   ,'RightGroup'=dbo.rightgroup(a.rightcode)
	   ,'RightGroup2'='' --CASE WHEN a.clinic='9' THEN 'HE' ELSE dbo.rightgroup(a.rightcode) END
	   ,a.Gender
	   ,'DoctorCode'=a.Doctor
	   ,'DoctorName'= dbo.Doctorname(a.Doctor,2)
	   ,'Specialty'=dbo.specialty(a.Doctor)
	   ,'SubSpecialty'=dbo.specialty(a.Doctor)
	   ,'DiagRms'=dbo.sysconname(a.diagrms,42205,2)
	   ,'ClinicCode'=a.Clinic
	   ,'ClinicName'=dbo.sysconname(a.Clinic,42203,2)
	   ,'ClinicGroup'=dbo.clinicgroup(a.clinic) 
	   ,a.CloseVisitType
	   ,'CloseVisitName'=dbo.sysconname(a.CloseVisitType,42261,2)
	   ,'NewHos'=CASE WHEN a.NEWPATIENT=1 THEN 'N' ELSE 'O' END
	   ,'NewClinic'=CASE WHEN a.NewToHere=1 THEN 'N' ELSE 'O' END
		--CASE WHEN (CONVERT(VARCHAR(8),firstvisitdate,112)=CONVERT(VARCHAR(8),a.visitdate,112) 
		--							 OR firstvisitdate IS null)
		--						  THEN 'N' 
		--						  ELSE 'O'
		--			  END
					 
		,'TreatmentAmt'=(SELECT COALESCE(SUM(case when hnchargetype=2 then chargeamt *(-1) else chargeamt end),0) AS Amt
						 FROM HNOPD_PRESCRIP_TREATMENT
						 WHERE a.vn=vn and a.visitdate=visitdate and a.SUFFIX=prescriptionno and cxldatetime is null) --and (TYPEOFCHARGE is NULL or TYPEOFCHARGE<>3))
		
		--,'DFTreatmentAmt'=(SELECT ISNULL(SUM(CASE WHEN [reverse]=1 THEN amt *(-1) ELSE amt END),0) AS Amt
		--				 FROM VNTREAT
		--				 WHERE a.vn=vn and a.visitdate=visitdate and a.SUFFIX=SUFFIX and (TYPEOFCHARGE is NULL or TYPEOFCHARGE<>3) and TREATMENTCODE like 'DF%')				  

		,'MedicineAmt'=(SELECT COALESCE(SUM(case when hnchargetype=2 then chargeamt *(-1) else chargeamt end),0) AS Amt
						FROM HNOPD_PRESCRIP_MEDICINE
						WHERE a.vn=vn and a.visitdate=visitdate and a.SUFFIX=prescriptionno and hnchargetype <> 1 and cxldatetime is null)
		,'TotalAmt'=(SELECT COALESCE(SUM(case when hnchargetype=2 then chargeamt *(-1) else chargeamt end),0) AS Amt
						 FROM HNOPD_PRESCRIP_TREATMENT
						 WHERE a.vn=vn and a.visitdate=visitdate and a.SUFFIX=prescriptionno and cxldatetime is null)
					+
					(SELECT COALESCE(SUM(case when hnchargetype=2 then chargeamt *(-1) else chargeamt end),0) AS Amt
						FROM HNOPD_PRESCRIP_MEDICINE
						WHERE a.vn=vn and a.visitdate=visitdate and a.SUFFIX=prescriptionno and hnchargetype <> 1 and cxldatetime is null)
	    ,'PrimaryDiagCode'=b.ICDCode --(select top 1 ICDCode from diag where a.vn=vn and a.visitdate=visitdate and a.suffix=suffix and typeofthisdiag=1)
		,'PrimaryDiagName'=dbo.icdname(b.ICDCode,1) 
		,'RemarksMemo'=b.RemarksMemo --(select top 1 RemarksMemo from diag where a.vn=vn and a.visitdate=visitdate and a.suffix=suffix and typeofthisdiag=1)
		,'ECode'=b.ECode --(select top 1 ECode from diag where a.vn=vn and a.visitdate=visitdate and a.suffix=suffix and typeofthisdiag=1)
		,'EcodeName'=dbo.icdname(b.ecode,2)
		,'ComobidityCode1'=(select top 1 ICDCode from diag where a.vn=vn and a.visitdate=visitdate and a.suffix=suffix and typeofthisdiag=4 and subsuffix=1)
		,'ComobidityName1'=dbo.icdname((select top 1 ICDCode from diag where a.vn=vn and a.visitdate=visitdate and a.suffix=suffix and typeofthisdiag=4 and subsuffix=1),1) 
		,'ComobidityCode2'=(select top 1 ICDCode from diag where a.vn=vn and a.visitdate=visitdate and a.suffix=suffix and typeofthisdiag=4 and subsuffix=2)
		,'ComobidityName2'=dbo.icdname((select top 1 ICDCode from diag where a.vn=vn and a.visitdate=visitdate and a.suffix=suffix and typeofthisdiag=4 and subsuffix=2),1) 
		,'ComobidityCode3'=(select top 1 ICDCode from diag where a.vn=vn and a.visitdate=visitdate and a.suffix=suffix and typeofthisdiag=4 and subsuffix=3)
		,'ComobidityName3'=dbo.icdname((select top 1 ICDCode from diag where a.vn=vn and a.visitdate=visitdate and a.suffix=suffix and typeofthisdiag=4 and subsuffix=3),1) 
		,'ComobidityCode4'=(select top 1 ICDCode from diag where a.vn=vn and a.visitdate=visitdate and a.suffix=suffix and typeofthisdiag=4 and subsuffix=4)
		,'ComobidityName4'=dbo.icdname((select top 1 ICDCode from diag where a.vn=vn and a.visitdate=visitdate and a.suffix=suffix and typeofthisdiag=4 and subsuffix=4),1) 
		,'ComobidityCode5'=(select top 1 ICDCode from diag where a.vn=vn and a.visitdate=visitdate and a.suffix=suffix and typeofthisdiag=4 and subsuffix=5)
		,'ComobidityName5'=dbo.icdname((select top 1 ICDCode from diag where a.vn=vn and a.visitdate=visitdate and a.suffix=suffix and typeofthisdiag=4 and subsuffix=5),1) 

	    ,[Type]
	    ,CASE WHEN AdmFlag=1 THEN 'Admit' END Admit
	    ,CASE WHEN NewPatient=1 THEN 'New'
			  WHEN NewPatient=0 THEN 'Old'
		 END [New-Old]


	   ,a.Sponsor
	   ,'SponsorName'=dbo.arname(a.Sponsor,3)
	   ,a.CompanyNo
	   ,dbo.sysconname(a.CompanyNo,10167,3) CompanyName
		
		--,a.NewPatient
		--,a.AdmFlag
	   ,'รายได้ค่ายา'=(select SUM(coalesce(Amt,0)) from charge where vn=a.vn and visitdate=a.visitdate and suffix=a.suffix and ActivityCategory='026')
	   ,'รายได้ค่าวัสดุสิ้นเปลืองทางการแพทย์'=(select SUM(coalesce(Amt,0)) from charge where vn=a.vn and visitdate=a.visitdate and suffix=a.suffix and ActivityCategory='029')
	   ,'รายได้ค่าเตียงผู้ป่วย'=(select SUM(coalesce(Amt,0)) from charge where vn=a.vn and visitdate=a.visitdate and suffix=a.suffix and ActivityCategory='001')
	   ,'รายได้ค่าไตเทียม'=(select SUM(coalesce(Amt,0)) from charge where vn=a.vn and visitdate=a.visitdate and suffix=a.suffix and ActivityCategory='002')
	   ,'รายได้ค่าห้อง ICU/CCU'=(select SUM(coalesce(Amt,0)) from charge where vn=a.vn and visitdate=a.visitdate and suffix=a.suffix and ActivityCategory='003')
	   ,'รายได้พยาบาลพิเศษ'=(select SUM(coalesce(Amt,0)) from charge where vn=a.vn and visitdate=a.visitdate and suffix=a.suffix and ActivityCategory='004')
	   ,'รายได้ค่าบริการพยาบาล'=(select SUM(coalesce(Amt,0)) from charge where vn=a.vn and visitdate=a.visitdate and suffix=a.suffix and ActivityCategory='005')
	   ,'รายได้ค่าเตียง Observe'=(select SUM(coalesce(Amt,0)) from charge where vn=a.vn and visitdate=a.visitdate and suffix=a.suffix and ActivityCategory='006')
	   ,'รายได้ค่าห้องผ่าตัด'=(select SUM(coalesce(Amt,0)) from charge where vn=a.vn and visitdate=a.visitdate and suffix=a.suffix and ActivityCategory='007')
	   ,'รายได้ค่าห้องพักฟื้น'=(select SUM(coalesce(Amt,0)) from charge where vn=a.vn and visitdate=a.visitdate and suffix=a.suffix and ActivityCategory='008')
	   ,'รายได้ค่าดมยา (ไม่ใช่ค่าแพทย์ดมยา)'=(select SUM(coalesce(Amt,0)) from charge where vn=a.vn and visitdate=a.visitdate and suffix=a.suffix and ActivityCategory='009')
	   ,'รายได้ค่าสลายนิ่ว'=(select SUM(coalesce(Amt,0)) from charge where vn=a.vn and visitdate=a.visitdate and suffix=a.suffix and ActivityCategory='010')
	   ,'รายได้ค่าห้องคลอด'=(select SUM(coalesce(Amt,0)) from charge where vn=a.vn and visitdate=a.visitdate and suffix=a.suffix and ActivityCategory='011')
	   ,'รายได้ค่าบริการอื่น ๆ'=(select SUM(coalesce(Amt,0)) from charge where vn=a.vn and visitdate=a.visitdate and suffix=a.suffix and ActivityCategory='012')
	   ,'รายได้ค่าเอกซ์เรย์'=(select SUM(coalesce(Amt,0)) from charge where vn=a.vn and visitdate=a.visitdate and suffix=a.suffix and ActivityCategory='013')
	   ,'รายได้ค่าเอกซ์เรย์คอมพิวเตอร์'=(select SUM(coalesce(Amt,0)) from charge where vn=a.vn and visitdate=a.visitdate and suffix=a.suffix and ActivityCategory='014')
	   ,'รายได้ค่า Utrasound'=(select SUM(coalesce(Amt,0)) from charge where vn=a.vn and visitdate=a.visitdate and suffix=a.suffix and ActivityCategory='015')
	   ,'รายได้ค่า MRI'=(select SUM(coalesce(Amt,0)) from charge where vn=a.vn and visitdate=a.visitdate and suffix=a.suffix and ActivityCategory='016')
	   ,'รายได้ค่า Mammogram'=(select SUM(coalesce(Amt,0)) from charge where vn=a.vn and visitdate=a.visitdate and suffix=a.suffix and ActivityCategory='017')
	   ,'รายได้ค่าห้องปฏิบัติการ (Laboratory)'=(select SUM(coalesce(Amt,0)) from charge where vn=a.vn and visitdate=a.visitdate and suffix=a.suffix and ActivityCategory='018')
	   ,'รายได้ค่าห้องปฏิบัติการ+ส่งตรวจภายนอก'=(select SUM(coalesce(Amt,0)) from charge where vn=a.vn and visitdate=a.visitdate and suffix=a.suffix and ActivityCategory='019')
	   ,'รายได้ค่าทำเลเซอร์'=(select SUM(coalesce(Amt,0)) from charge where vn=a.vn and visitdate=a.visitdate and suffix=a.suffix and ActivityCategory='020')
	   ,'รายได้ค่าทำ EKG'=(select SUM(coalesce(Amt,0)) from charge where vn=a.vn and visitdate=a.visitdate and suffix=a.suffix and ActivityCategory='021')
	   ,'รายได้ค่าทำ Audiogram'=(select SUM(coalesce(Amt,0)) from charge where vn=a.vn and visitdate=a.visitdate and suffix=a.suffix and ActivityCategory='022')
	   ,'รายได้ค่า Echo'=(select SUM(coalesce(Amt,0)) from charge where vn=a.vn and visitdate=a.visitdate and suffix=a.suffix and ActivityCategory='023')
	   ,'รายได้ค่าทำ Exercise Stress Test'=(select SUM(coalesce(Amt,0)) from charge where vn=a.vn and visitdate=a.visitdate and suffix=a.suffix and ActivityCategory='024')
	   ,'รายได้ค่าปฏิบัติการแพทย์อื่น ๆ'=(select SUM(coalesce(Amt,0)) from charge where vn=a.vn and visitdate=a.visitdate and suffix=a.suffix and ActivityCategory='025')
	   ,'รายได้ค่าสมุนไพรและนวดแผนโบราณ'=(select SUM(coalesce(Amt,0)) from charge where vn=a.vn and visitdate=a.visitdate and suffix=a.suffix and ActivityCategory='027')
	   ,'รายได้ค่าออกซิเจน'=(select SUM(coalesce(Amt,0)) from charge where vn=a.vn and visitdate=a.visitdate and suffix=a.suffix and ActivityCategory='028')
	   ,'รายได้ค่ากายภาพบำบัด'=(select SUM(coalesce(Amt,0)) from charge where vn=a.vn and visitdate=a.visitdate and suffix=a.suffix and ActivityCategory='030')
	   ,'รายได้ค่ารถพยาบาล'=(select SUM(coalesce(Amt,0)) from charge where vn=a.vn and visitdate=a.visitdate and suffix=a.suffix and ActivityCategory='031')
	   ,'รายได้ค่าทำ CPR'=(select SUM(coalesce(Amt,0)) from charge where vn=a.vn and visitdate=a.visitdate and suffix=a.suffix and ActivityCategory='032')
	   ,'รายได้ค่าอาหารคนไข้'=(select SUM(coalesce(Amt,0)) from charge where vn=a.vn and visitdate=a.visitdate and suffix=a.suffix and ActivityCategory='033')
	   ,'รายได้ค่าโทรศัพท์'=(select SUM(coalesce(Amt,0)) from charge where vn=a.vn and visitdate=a.visitdate and suffix=a.suffix and ActivityCategory='034')
	   ,'รายได้ค่าใช้อุปกรณ์ทางการแพทย์ประเภท Set ต่าง ๆ'=(select SUM(coalesce(Amt,0)) from charge where vn=a.vn and visitdate=a.visitdate and suffix=a.suffix and ActivityCategory='035')
	   ,'รายได้จากการเขียนใบเคลมหรือใบรับรองแพทย์'=(select SUM(coalesce(Amt,0)) from charge where vn=a.vn and visitdate=a.visitdate and suffix=a.suffix and ActivityCategory='036')
	   ,'รายได้ค่าทำศพ'=(select SUM(coalesce(Amt,0)) from charge where vn=a.vn and visitdate=a.visitdate and suffix=a.suffix and ActivityCategory='037')
	   ,'รายได้ค่าตรวจรักษาของแพทย์'=(select SUM(coalesce(Amt,0)) from charge where vn=a.vn and visitdate=a.visitdate and suffix=a.suffix and ActivityCategory='038')
	   ,'รายได้ค่าตรวจรักษาของทันตแพทย์'=(select SUM(coalesce(Amt,0)) from charge where vn=a.vn and visitdate=a.visitdate and suffix=a.suffix and ActivityCategory='039')
	   ,'รายได้ค่าตรวจรักษาอื่น ๆ'=(select SUM(coalesce(Amt,0)) from charge where vn=a.vn and visitdate=a.visitdate and suffix=a.suffix and ActivityCategory='040')
	   ,'รายได้จากการขายอาหารญาติ'=(select SUM(coalesce(Amt,0)) from charge where vn=a.vn and visitdate=a.visitdate and suffix=a.suffix and ActivityCategory='041')
	   ,'รายได้จากค่ารับเลี้ยงเด็ก'=(select SUM(coalesce(Amt,0)) from charge where vn=a.vn and visitdate=a.visitdate and suffix=a.suffix and ActivityCategory='042')
	   ,'รายได้อื่น ๆ (Fax,Photocopy,เวชระเบียน)'=(select SUM(coalesce(Amt,0)) from charge where vn=a.vn and visitdate=a.visitdate and suffix=a.suffix and ActivityCategory='043')
	   ,'รายได้ค่าแพทย์อ่านผล'=(select SUM(coalesce(Amt,0)) from charge where vn=a.vn and visitdate=a.visitdate and suffix=a.suffix and ActivityCategory='044')
	   ,'รายได้ค่าธรรมเนียมแพทย์-รพ.'=(select SUM(coalesce(Amt,0)) from charge where vn=a.vn and visitdate=a.visitdate and suffix=a.suffix and ActivityCategory='045')
	   ,'รายได้ค่า Sleep Lab'=(select SUM(coalesce(Amt,0)) from charge where vn=a.vn and visitdate=a.visitdate and suffix=a.suffix and ActivityCategory='046')
	   ,'ส่วนลดทั่วไป'=(select SUM(coalesce(Amt,0)) from charge where vn=a.vn and visitdate=a.visitdate and suffix=a.suffix and ActivityCategory='101')
	   ,'ส่วนลดบริษัทคู่สัญญา'=(select SUM(coalesce(Amt,0)) from charge where vn=a.vn and visitdate=a.visitdate and suffix=a.suffix and ActivityCategory='102')
	   ,'ส่วนลดโปรแกรมตรวจสุขภาพ'=(select SUM(coalesce(Amt,0)) from charge where vn=a.vn and visitdate=a.visitdate and suffix=a.suffix and ActivityCategory='103')
	   ,'ส่วนลดค่าบริการเหมาจ่าย'=(select SUM(coalesce(Amt,0)) from charge where vn=a.vn and visitdate=a.visitdate and suffix=a.suffix and ActivityCategory='104')
	   ,'ภาษีขาย'=(select SUM(coalesce(Amt,0)) from charge where vn=a.vn and visitdate=a.visitdate and suffix=a.suffix and ActivityCategory='105')
	   ,'ค่าอุปกรณ์ของใช้และเครื่องมือที่ใช้ในห้องผ่าตัด'=(select SUM(coalesce(Amt,0)) from charge where vn=a.vn and visitdate=a.visitdate and suffix=a.suffix and ActivityCategory='154')
	   ,'ค่าแพทย์ตรวจวินิจฉัยสาขาเฉพาะ'=(select SUM(coalesce(Amt,0)) from charge where vn=a.vn and visitdate=a.visitdate and suffix=a.suffix and ActivityCategory='187')
	   ,'194 - ค่าวิชาชีพทันตกรรม'=(select SUM(coalesce(Amt,0)) from charge where vn=a.vn and visitdate=a.visitdate and suffix=a.suffix and ActivityCategory='194')
	   ,'เงินมัดจำ'=(select SUM(coalesce(Amt,0)) from charge where vn=a.vn and visitdate=a.visitdate and suffix=a.suffix and ActivityCategory='219')
	   ,'279 - ค่าเอ็กซเรย์ฟันด้วยคอมพิวเตอร์ (CT Scan)'=(select SUM(coalesce(Amt,0)) from charge where vn=a.vn and visitdate=a.visitdate and suffix=a.suffix and ActivityCategory='279')
	   ,'ธุรกิจค้าปลีก'=(select SUM(coalesce(Amt,0)) from charge where vn=a.vn and visitdate=a.visitdate and suffix=a.suffix and ActivityCategory='280')
		,'ReceiveCode'=dbo.rightgroup(a.rightcode)
		,a.TextPulseRate
	    ,a.TextRespireRate
		,a.BPHigh
		,a.BPLow
		,a.PostBPHigh
		,a.PostBPLow
		,a.BodyWeight
		,a.Height
		,a.Temperature
		,a.UserName
		,a.Blood
		,a.Tel
		,a.MobilePhone
		,a.EmailAddress
		,'Allergy'=case when (select distinct hn from hnpat_allergic where HN=a.HN) is not null then 'มี' end
		,'Chronic'=case when (select chronic from HNICD_MASTER where icdcode=b.icdcode)='1' then 'Y' else 'N' end
		,'PatientPicture'=case when f.hn is not null then 'Y' else 'N' end
		,Religion 
		,Nationality 
		,Race 
		,CurrentAge	
		,'Free Package'=e.TotalAmt
	    ,'ProcedureICDCmCode1'=ProcudureICDCMCode1
	    ,'ProcedureICDCmName1'=dbo.ICDCMname(ProcudureICDCMCode1,1)
	    ,'ProcedureICDCmCode2'=ProcudureICDCMCode2
	    ,'ProcedureICDCmName2'=dbo.ICDCMname(ProcudureICDCMCode2,1)
	    ,'ProcedureICDCmCode3'=ProcudureICDCMCode3
	    ,'ProcedureICDCmName3'=dbo.ICDCMname(ProcudureICDCMCode3,1)
	    ,'ProcedureICDCmCode4'=ProcudureICDCMCode4
		,'ProcedureICDCmCode4'=dbo.ICDCMname(ProcudureICDCMCode4,1)
		,'Lab'=''  --case when c.Flag='1' then 'Y' else 'N' end
		,a.IDCard
		,'RightGroupInternal'=dbo.rightgroupinternal(a.rightcode) 
		,'CountFromPrescripRight'=(select case when rowno=1 then 'Yes' else 'No' end from checkprescription where a.vn=vn and a.visitdate=visitdate and a.suffix=prescriptionno)
		,'CloseVisitDateTime'=(select max(makedatetime) from hnopd_log where a.vn=vn and a.visitdate=visitdate and a.suffix=prescriptionno and OpdMasterLogType='25')
		,'CountCloseVisit'=case when a.CloseVisitType in ('004','006','100','888','996','997','999') then 'No' else 'Yes' end
	    ,a.AppointmentDateTime
		,'Ack_Nurse'=(select max(MakeDateTime) from HNOPD_LOG where a.visitdate=visitdate and a.vn=vn and a.Suffix=prescriptionno and OpdMasterLogType=14)
		,'CheckIn'=(select max(MakeDateTime) from HNOPD_LOG where a.visitdate=visitdate and a.vn=vn and a.Suffix=prescriptionno and OpdMasterLogType=15)
		,'LabCode'=(select max(MakeDateTime) from HNOPD_PRESCRIP_TREATMENT where a.visitdate=visitdate and a.vn=vn and a.Suffix=prescriptionno and labcode is not null)
	    ,'XrayCode'=(select max(MakeDateTime) from HNOPD_PRESCRIP_TREATMENT where a.visitdate=visitdate and a.vn=vn and a.Suffix=prescriptionno and xraycode is not null)
		,'CheckOut'=(select max(MakeDateTime) from HNOPD_LOG where a.visitdate=visitdate and a.vn=vn and a.Suffix=prescriptionno and OpdMasterLogType=16)
		,'Nurse_Release'=(select max(MakeDateTime) from HNOPD_LOG where a.visitdate=visitdate and a.vn=vn and a.Suffix=prescriptionno and OpdMasterLogType=16)
	    ,'DoctorApprovePrescription'=(select max(MakeDateTime) from HNOPD_LOG where a.visitdate=visitdate and a.vn=vn and a.Suffix=prescriptionno and OpdMasterLogType=11)
	    ,'Drug_Ack'=(select max(MakeDateTime) from HNOPD_LOG where a.visitdate=visitdate and a.vn=vn and a.Suffix=prescriptionno and OpdMasterLogType=22)				
	    ,'Cashier_Receive'=(select max(MakeDateTime) from HNOPD_LOG where a.visitdate=visitdate and a.vn=vn and a.Suffix=prescriptionno and OpdMasterLogType=21)


FROM Visit a
LEFT JOIN Diag b ON a.visitdate=b.visitdate and a.vn=b.vn and a.suffix=b.suffix and typeofthisdiag=1
--INNER JOIN HNOPD_MASTER c ON a.visitdate=c.visitdate and a.vn=c.vn
--INNER JOIN HNPAT_CLINIC d ON a.HN=d.HN and a.Clinic=d.Clinic
LEFT JOIN FreePackage e ON a.visitdate=e.visitdate and a.vn=e.vn and a.suffix=e.suffix
LEFT JOIN Picture f ON a.hn=f.hn
