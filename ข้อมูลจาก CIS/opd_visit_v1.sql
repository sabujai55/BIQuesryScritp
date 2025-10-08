Declare @dto datetime
Declare @dfrom datetime
--select @dfrom='2023/08/01 00:00:00.000'
--select @dto='2023/08/01 23:59:59.000';
select  @dfrom= cast((convert(varchar(10),@dd,111)+' 00:00:00:000') as datetime)
select  @dto= cast((convert(varchar(10),@dd1,111)+' 23:59:59:997') as datetime);

WITH OPD_Visit (VisitDate,RegInDateTime,VN,Suffix,HN,PatientName,Age,CurrentAge,[Address],Village,Moo,Tambon,Amphoe,Province,
				PatientType,RightCode,RightName,RightGroup,Gender,DoctorCode,DoctorName,DiagRms,ClinicCode,ClinicName,ClinicGroup,
				CloseVisitType,CloseVisitName,NewHos,NewClinic,TreatmentAmt,DFTreatmentAmt,MedicineAmt,
				PrimaryDiagCode,RemarksMemo,ECode,ComobidityCode1,ComobidityCode2,ComobidityCode3,ComobidityCode4,
				ComobidityCode5,Sponsor,CompanyNo,NewPatient,AdmFlag,ReceiveCode,
				TextPulseRate,TextRespireRate,BPHigh,BPLow,PostBPHigh,PostBPLow,BodyWeight,Height,Temperature,UserName,Blood,
				Tel,MobilePhone,EmailAddress,PatientPicture,ReligionCode,NationalityCode,RaceCode,IDCard,DiagOutDateTime)
AS
(

SELECT a.VisitDate
		,a.RegInDateTime
		,a.VN
		,a.Suffix
		,b.HN
		,'PatientName'=COALESCE(dbo.getname(b.hn),e_name)
		,'Age'=Datediff("yy",d.birthdatetime,a.VisitDate)
		,'CurrentAge'= dbo.calc_age(d.birthdatetime,getdate(),2)
		,d.[Address]
		,d.Village
		,d.Moo
		,d.Tambon 
		,d.Amphoe
		,d.Province
		,'PatientType' = dbo.sysconname(b.PatientType,20011,1)
		,'RightCode' = a.rightcode
		,'RightName' = dbo.sysconname(a.rightcode,20019,2)
		,'RightGroup'=dbo.rightgroup(a.rightcode)
		,d.Gender
		,'DoctorCode'=a.Doctor
		,'DoctorName'= dbo.Doctorname(a.Doctor,2)
		,'DiagRms'=dbo.sysconname(a.disgrms,20042,2)
		,'ClinicCode'=a.Clinic
		,'ClinicName'=dbo.sysconname(a.Clinic,20016,2)
		,'ClinicGroup'=dbo.clinicgroup(a.clinic)
		,a.CloseVisitType
		,'CloseVisitName'=dbo.sysconname(a.CloseVisitType,20043,2)
		,'NewHos'=CASE WHEN b.NEWPATIENT=1 THEN 'N' ELSE 'O' END
		,'NewClinic'=(SELECT CASE WHEN CONVERT(VARCHAR(8),firstvisitdate,112)=CONVERT(VARCHAR(8),a.visitdate,112) 
									 OR firstvisitdate IS null 
								  THEN 'N' 
								  ELSE 'O'
							 END
					  FROM dbo.PATIENT_CLINIC
					  WHERE hn=b.hn and clinic=a.clinic)

		,'TreatmentAmt'=(SELECT ISNULL(SUM(CASE WHEN [reverse]=1 THEN amt *(-1) ELSE amt END),0) AS Amt
						 FROM dbo.VNTREAT
						 WHERE a.vn=vn and a.visitdate=visitdate and a.SUFFIX=SUFFIX and (TYPEOFCHARGE is NULL or TYPEOFCHARGE<>3))
		
		,'DFTreatmentAmt'=(SELECT ISNULL(SUM(CASE WHEN [reverse]=1 THEN amt *(-1) ELSE amt END),0) AS Amt
						 FROM dbo.VNTREAT
						 WHERE a.vn=vn and a.visitdate=visitdate and a.SUFFIX=SUFFIX and (TYPEOFCHARGE is NULL or TYPEOFCHARGE<>3) and TREATMENTCODE like 'DF%')				  

		,'MedicineAmt'=(SELECT ISNULL(SUM(CASE WHEN TYPEOFCHARGE=2 THEN amt *(-1) ELSE amt END),0) AS Amt
						FROM dbo.VNMEDICINE
						WHERE a.vn=vn and a.visitdate=visitdate and a.SUFFIX=SUFFIX and TYPEOFCHARGE not in (1,3))
				  
		,'PrimaryDiagCode'= (SELECT max(ICDCode) FROM dbo.VNDIAG  
			WHERE a.vn=vn and a.visitdate=visitdate and a.SUFFIX=SUFFIX and TYPEOFTHISDIAG=1)

		,'RemarksMemo'= (SELECT max(RemarksMemo) FROM dbo.VNDIAG  
			WHERE a.vn=vn and a.visitdate=visitdate and a.SUFFIX=SUFFIX and TYPEOFTHISDIAG=1)
			
		,'ECode'= (SELECT max(ECODE) FROM VNDIAG
				   WHERE a.vn=vn and a.visitdate=visitdate and a.SUFFIX=SUFFIX and TYPEOFTHISDIAG=1)
			
		,'ComobidityCode1'=(SELECT MAX(ICDCode) FROM dbo.VNDIAG
			WHERE(a.vn=vn and a.visitdate=visitdate and a.SUFFIX=SUFFIX and TYPEOFTHISDIAG=4 and SUBSUFFIX=1))

		,'ComobidityCode2'=(SELECT MAX(ICDCode) FROM dbo.VNDIAG
			WHERE(a.vn=vn and a.visitdate=visitdate and a.SUFFIX=SUFFIX and TYPEOFTHISDIAG=4 and SUBSUFFIX=2))

		,'ComobidityCode3'=(SELECT MAX(ICDCode) FROM dbo.VNDIAG
			WHERE(a.vn=vn and a.visitdate=visitdate and a.SUFFIX=SUFFIX and TYPEOFTHISDIAG=4 and SUBSUFFIX=3))
			
		,'ComobidityCode4'=(SELECT MAX(ICDCode) FROM dbo.VNDIAG
			WHERE(a.vn=vn and a.visitdate=visitdate and a.SUFFIX=SUFFIX and TYPEOFTHISDIAG=4 and SUBSUFFIX=4))

		,'ComobidityCode5'=(SELECT MAX(ICDCode) FROM dbo.VNDIAG
			WHERE(a.vn=vn and a.visitdate=visitdate and a.SUFFIX=SUFFIX and TYPEOFTHISDIAG=4 and SUBSUFFIX=5))
		
		,a.SPONSOR
		,b.COMPANYNO
		,b.NewPatient
		,b.AdmFlag
		,'ReceiveCode'=dbo.rightgroup(a.rightcode)
		,b.TextPulseRate
	    ,b.TextRespireRate
		,b.BPHigh
		,b.BPLow
		,b.PostBPHigh
		,b.PostBPLow
		,b.BodyWeight
		,b.Height
		,b.Temperature
		,UserName=dbo.sysconname(a.ISSUEBYUSERID,10000,2)
		,c.Blood
		,d.Tel
		,d.MobilePhoneNo
		,d.EmailAddress
		,case when c.PictureFileName is not null then 'Y' else 'N' end
		,d.ReligionCode
		,d.NationalityCode
		,d.RaceCode
		,d.IDCard
		,a.DiagOutDateTime
		
FROM VNPRES a
LEFT JOIN VNMST b ON (a.vn=b.vn and a.visitdate=b.visitdate)	
LEFT JOIN PATIENT_INFO c ON (b.hn=c.hn)
LEFT JOIN MK_HN_PATIENT d ON (b.HN=d.hn)

)


,LAB (VisitDate,VN,Flag)
AS
(
SELECT DISTINCT 
	   a.CHARGETOVISITDATE
	   ,a.REQUESTFROMVN 
	   ,'1'

FROM LABREQ a
LEFT JOIN LABRESULT b ON a.REQUESTNO=b.REQUESTNO

WHERE a.CHARGETOVISITDATE between @dfrom and @dto
and b.LABCODE in ('L3711','L3722','L3725','L3726','L3727','L3728','L3729','L3732',
'L3733','L7153','L7154','L7155','L7156','L7164','L7168','L2209','L3476')

)

---------------------------------------------------

SELECT a.Visitdate
	   ,RegInDateTime
	   ,a.VN
	   ,a.HN
	   ,PatientName
	   ,Age
	   ,Address
	   ,Village
	   ,Moo
	   ,Tambon 
	   ,Amphoe
	   ,Province
	   ,PatientType
	   ,RightCode
	   ,RightName
	   ,RightGroup
	   ,'RightGroup2'='' --CASE WHEN cliniccode='9' THEN 'G' ELSE RightGroup END
	   ,Gender
	   ,DoctorCode
	   ,DoctorName
	   ,'Specialty'=dbo.specialty(doctorcode)
	   ,'SubSpecialty'=dbo.subspecialty(doctorcode)
	   ,DiagRms
	   ,ClinicCode
	   ,ClinicName
	   ,ClinicGroup
	   ,CloseVisitType
	   ,CloseVisitName
	   ,NewHos
	   ,NewClinic
	   ,TreatmentAmt
	   ,DFTreatmentAmt
	   ,MedicineAmt
	   ,'TotalAmt'=TreatmentAmt+MedicineAmt
	   ,PrimaryDiagCode
	   ,'PrimaryDiagName'=dbo.icdname(primarydiagcode,1)
	   ,RemarksMemo
	   ,ECode
	   ,'EcodeName'=(select EnglishName from ECODE_MASTER where a.ECODE=ECODE)
	   ,ComobidityCode1
	   ,'ComobidityName1'=dbo.icdname(ComobidityCode1,1) 
	   ,ComobidityCode2
	   ,'ComobidityName2'=dbo.icdname(ComobidityCode2,3) 
	   ,ComobidityCode3
	   ,'ComobidityName3'=dbo.icdname(ComobidityCode3,3) 
	   ,ComobidityCode4
	   ,'ComobidityName4'=dbo.icdname(ComobidityCode4,3) 
	   ,ComobidityCode5
	   ,'ComobidityName5'=dbo.icdname(ComobidityCode5,3) 
	   ,CASE WHEN b.VisitCnt=1 and a.NewPatient=1 THEN 'NewNew'
			 WHEN b.VisitCnt=1 and a.NewPatient=0 THEN 'OldNew'
			 WHEN b.VisitCnt>1 and a.NewPatient=0 THEN 'OldOld'
		END [Type]
	   ,CASE WHEN AdmFlag=1 THEN 'Admit' END Admit
	   ,CASE WHEN NewPatient=1 THEN 'New'
			 WHEN NewPatient=0 THEN 'Old'
		END [New-Old]	   
	   ,Sponsor
	   ,'SponsorName'=(select RIGHT(englishname,LEN(englishname)-1) from ssbbackoffice.dbo.armaster where arcode=a.Sponsor) 
	   ,CompanyNo
	   ,dbo.sysconname(CompanyNo,10017,3) CompanyName
	   
--VNMEDICINE
	    ,'รายได้ค่ายา'=
			(SELECT ISNULL(SUM(CASE WHEN [reverse]=1 THEN amt *(-1) ELSE amt END),0) AS Amt
			 FROM dbo.VNMEDICINE x
			 WHERE a.vn=vn and a.visitdate=visitdate and a.SUFFIX=SUFFIX and TYPEOFCHARGE not in (1,3)
				   and (select cast(substring(com,91,3) as varchar) from SYSCONFIG z where z.CtrlCode='20023' and z.CODE=x.chargecode)='032')
	    ,'รายได้ค่าวัสดุสิ้นเปลืองทางการแพทย์'=
			(SELECT ISNULL(SUM(CASE WHEN [reverse]=1 THEN amt *(-1) ELSE amt END),0) AS Amt
			 FROM dbo.VNMEDICINE x
			 WHERE a.vn=vn and a.visitdate=visitdate and a.SUFFIX=SUFFIX and TYPEOFCHARGE not in (1,3)
				   and (select cast(substring(com,91,3) as varchar) from SYSCONFIG z where z.CtrlCode='20023' and z.CODE=x.chargecode)='035')+
			(SELECT ISNULL(SUM(CASE WHEN [reverse]=1 THEN amt *(-1) ELSE amt END),0) AS Amt
			 FROM dbo.VNTREAT x
			 WHERE a.vn=vn and a.visitdate=visitdate and a.SUFFIX=SUFFIX and TYPEOFCHARGE not in (1,3)
				   and (select cast(substring(com,91,3) as varchar) from SYSCONFIG z where z.CtrlCode='20023' and z.CODE=x.chargecode)='035')
--VNTREAT
		,'รายได้ค่าห้องสังเกตการณ์'=
			(SELECT ISNULL(SUM(CASE WHEN [reverse]=1 THEN amt *(-1) ELSE amt END),0) AS Amt
			 FROM dbo.VNTREAT x
			 WHERE a.vn=vn and a.visitdate=visitdate and a.SUFFIX=SUFFIX and (TYPEOFCHARGE is NULL or TYPEOFCHARGE<>3)
				   and (select cast(substring(com,91,3) as varchar) from SYSCONFIG z where z.CtrlCode='20023' and z.CODE=x.chargecode)='001')
		,'รายได้ค่าห้องผู้ป่วยใน'=
			(SELECT ISNULL(SUM(CASE WHEN [reverse]=1 THEN amt *(-1) ELSE amt END),0) AS Amt
			 FROM dbo.VNTREAT x
			 WHERE a.vn=vn and a.visitdate=visitdate and a.SUFFIX=SUFFIX and (TYPEOFCHARGE is NULL or TYPEOFCHARGE<>3)
				   and (select cast(substring(com,91,3) as varchar) from SYSCONFIG z where z.CtrlCode='20023' and z.CODE=x.chargecode)='002')
		,'รายได้ค่าห้องรอคลอด'=
			(SELECT ISNULL(SUM(CASE WHEN [reverse]=1 THEN amt *(-1) ELSE amt END),0) AS Amt
			 FROM dbo.VNTREAT x
			 WHERE a.vn=vn and a.visitdate=visitdate and a.SUFFIX=SUFFIX and (TYPEOFCHARGE is NULL or TYPEOFCHARGE<>3)
				   and (select cast(substring(com,91,3) as varchar) from SYSCONFIG z where z.CtrlCode='20023' and z.CODE=x.chargecode)='003')
		,'รายได้ค่าห้องคลอด'=
			(SELECT ISNULL(SUM(CASE WHEN [reverse]=1 THEN amt *(-1) ELSE amt END),0) AS Amt
			 FROM dbo.VNTREAT x
			 WHERE a.vn=vn and a.visitdate=visitdate and a.SUFFIX=SUFFIX and (TYPEOFCHARGE is NULL or TYPEOFCHARGE<>3)
				   and (select cast(substring(com,91,3) as varchar) from SYSCONFIG z where z.CtrlCode='20023' and z.CODE=x.chargecode)='004')
		,'รายได้ค่าห้อง ICU'=
			(SELECT ISNULL(SUM(CASE WHEN [reverse]=1 THEN amt *(-1) ELSE amt END),0) AS Amt
			 FROM dbo.VNTREAT x
			 WHERE a.vn=vn and a.visitdate=visitdate and a.SUFFIX=SUFFIX and (TYPEOFCHARGE is NULL or TYPEOFCHARGE<>3)
				   and (select cast(substring(com,91,3) as varchar) from SYSCONFIG z where z.CtrlCode='20023' and z.CODE=x.chargecode)='005')
		,'รายได้ค่าห้องพักฟื้น'=
			(SELECT ISNULL(SUM(CASE WHEN [reverse]=1 THEN amt *(-1) ELSE amt END),0) AS Amt
			 FROM dbo.VNTREAT x
			 WHERE a.vn=vn and a.visitdate=visitdate and a.SUFFIX=SUFFIX and (TYPEOFCHARGE is NULL or TYPEOFCHARGE<>3)
				   and (select cast(substring(com,91,3) as varchar) from SYSCONFIG z where z.CtrlCode='20023' and z.CODE=x.chargecode)='006')
		,'รายได้ค่าห้องผ่าตัด'=
			(SELECT ISNULL(SUM(CASE WHEN [reverse]=1 THEN amt *(-1) ELSE amt END),0) AS Amt
			 FROM dbo.VNTREAT x
			 WHERE a.vn=vn and a.visitdate=visitdate and a.SUFFIX=SUFFIX and (TYPEOFCHARGE is NULL or TYPEOFCHARGE<>3)
				   and (select cast(substring(com,91,3) as varchar) from SYSCONFIG z where z.CtrlCode='20023' and z.CODE=x.chargecode)='007')
		,'รายได้ค่าล้างไต'=
			(SELECT ISNULL(SUM(CASE WHEN [reverse]=1 THEN amt *(-1) ELSE amt END),0) AS Amt
			 FROM dbo.VNTREAT x
			 WHERE a.vn=vn and a.visitdate=visitdate and a.SUFFIX=SUFFIX and (TYPEOFCHARGE is NULL or TYPEOFCHARGE<>3)
				   and (select cast(substring(com,91,3) as varchar) from SYSCONFIG z where z.CtrlCode='20023' and z.CODE=x.chargecode)='008')
		,'รายได้ค่าดมยา'=
			(SELECT ISNULL(SUM(CASE WHEN [reverse]=1 THEN amt *(-1) ELSE amt END),0) AS Amt
			 FROM dbo.VNTREAT x
			 WHERE a.vn=vn and a.visitdate=visitdate and a.SUFFIX=SUFFIX and (TYPEOFCHARGE is NULL or TYPEOFCHARGE<>3)
				   and (select cast(substring(com,91,3) as varchar) from SYSCONFIG z where z.CtrlCode='20023' and z.CODE=x.chargecode)='009')
		,'รายได้ค่าสลายนิ่ว'=
			(SELECT ISNULL(SUM(CASE WHEN [reverse]=1 THEN amt *(-1) ELSE amt END),0) AS Amt
			 FROM dbo.VNTREAT x
			 WHERE a.vn=vn and a.visitdate=visitdate and a.SUFFIX=SUFFIX and (TYPEOFCHARGE is NULL or TYPEOFCHARGE<>3)
				   and (select cast(substring(com,91,3) as varchar) from SYSCONFIG z where z.CtrlCode='20023' and z.CODE=x.chargecode)='010')
		,'รายได้ค่าตรวจนิ่วในถุงน้ำดี'=
			(SELECT ISNULL(SUM(CASE WHEN [reverse]=1 THEN amt *(-1) ELSE amt END),0) AS Amt
			 FROM dbo.VNTREAT x
			 WHERE a.vn=vn and a.visitdate=visitdate and a.SUFFIX=SUFFIX and (TYPEOFCHARGE is NULL or TYPEOFCHARGE<>3)
				   and (select cast(substring(com,91,3) as varchar) from SYSCONFIG z where z.CtrlCode='20023' and z.CODE=x.chargecode)='011')
		,'รายได้ค่าบริการพยาบาล'=
			(SELECT ISNULL(SUM(CASE WHEN [reverse]=1 THEN amt *(-1) ELSE amt END),0) AS Amt
			 FROM dbo.VNTREAT x
			 WHERE a.vn=vn and a.visitdate=visitdate and a.SUFFIX=SUFFIX and (TYPEOFCHARGE is NULL or TYPEOFCHARGE<>3)
				   and (select cast(substring(com,91,3) as varchar) from SYSCONFIG z where z.CtrlCode='20023' and z.CODE=x.chargecode)='012')
		,'รายได้ค่าบริการอื่น ๆ'=
			(SELECT ISNULL(SUM(CASE WHEN [reverse]=1 THEN amt *(-1) ELSE amt END),0) AS Amt
			 FROM dbo.VNTREAT x
			 WHERE a.vn=vn and a.visitdate=visitdate and a.SUFFIX=SUFFIX and (TYPEOFCHARGE is NULL or TYPEOFCHARGE<>3)
				   and (select cast(substring(com,91,3) as varchar) from SYSCONFIG z where z.CtrlCode='20023' and z.CODE=x.chargecode)='013')
	    ,'รายได้ค่าพยาบาลพิเศษ'=
			(SELECT ISNULL(SUM(CASE WHEN [reverse]=1 THEN amt *(-1) ELSE amt END),0) AS Amt
			 FROM dbo.VNTREAT x
			 WHERE a.vn=vn and a.visitdate=visitdate and a.SUFFIX=SUFFIX and (TYPEOFCHARGE is NULL or TYPEOFCHARGE<>3)
				   and (select cast(substring(com,91,3) as varchar) from SYSCONFIG z where z.CtrlCode='20023' and z.CODE=x.chargecode)='014')
	    ,'รายได้ค่าเอ็กซเรย์'=
			(SELECT ISNULL(SUM(CASE WHEN [reverse]=1 THEN amt *(-1) ELSE amt END),0) AS Amt
			 FROM dbo.VNTREAT x
			 WHERE a.vn=vn and a.visitdate=visitdate and a.SUFFIX=SUFFIX and (TYPEOFCHARGE is NULL or TYPEOFCHARGE<>3)
				   and (select cast(substring(com,91,3) as varchar) from SYSCONFIG z where z.CtrlCode='20023' and z.CODE=x.chargecode)='015')
		,'รายได้ค่าเอ็กซเรย์คอมพิวเตอร์'=
			(SELECT ISNULL(SUM(CASE WHEN [reverse]=1 THEN amt *(-1) ELSE amt END),0) AS Amt
			 FROM dbo.VNTREAT x
			 WHERE a.vn=vn and a.visitdate=visitdate and a.SUFFIX=SUFFIX and (TYPEOFCHARGE is NULL or TYPEOFCHARGE<>3)
				   and (select cast(substring(com,91,3) as varchar) from SYSCONFIG z where z.CtrlCode='20023' and z.CODE=x.chargecode)='016')
		,'รายได้ค่า Ultrasound'=
			(SELECT ISNULL(SUM(CASE WHEN [reverse]=1 THEN amt *(-1) ELSE amt END),0) AS Amt
			 FROM dbo.VNTREAT x
			 WHERE a.vn=vn and a.visitdate=visitdate and a.SUFFIX=SUFFIX and (TYPEOFCHARGE is NULL or TYPEOFCHARGE<>3)
				   and (select cast(substring(com,91,3) as varchar) from SYSCONFIG z where z.CtrlCode='20023' and z.CODE=x.chargecode)='017')
	    ,'รายได้ค่า MRI'=
			(SELECT ISNULL(SUM(CASE WHEN [reverse]=1 THEN amt *(-1) ELSE amt END),0) AS Amt
			 FROM dbo.VNTREAT x
			 WHERE a.vn=vn and a.visitdate=visitdate and a.SUFFIX=SUFFIX and (TYPEOFCHARGE is NULL or TYPEOFCHARGE<>3)
				   and (select cast(substring(com,91,3) as varchar) from SYSCONFIG z where z.CtrlCode='20023' and z.CODE=x.chargecode)='018')
	    ,'รายได้ค่า Mammogram'=
			(SELECT ISNULL(SUM(CASE WHEN [reverse]=1 THEN amt *(-1) ELSE amt END),0) AS Amt
			 FROM dbo.VNTREAT x
			 WHERE a.vn=vn and a.visitdate=visitdate and a.SUFFIX=SUFFIX and (TYPEOFCHARGE is NULL or TYPEOFCHARGE<>3)
				   and (select cast(substring(com,91,3) as varchar) from SYSCONFIG z where z.CtrlCode='20023' and z.CODE=x.chargecode)='019')
		,'รายได้ค่าทำ Bone Density'=
			(SELECT ISNULL(SUM(CASE WHEN [reverse]=1 THEN amt *(-1) ELSE amt END),0) AS Amt
			 FROM dbo.VNTREAT x
			 WHERE a.vn=vn and a.visitdate=visitdate and a.SUFFIX=SUFFIX and (TYPEOFCHARGE is NULL or TYPEOFCHARGE<>3)
				   and (select cast(substring(com,91,3) as varchar) from SYSCONFIG z where z.CtrlCode='20023' and z.CODE=x.chargecode)='020')
		,'รายได้ค่า DSI Angiography'=
			(SELECT ISNULL(SUM(CASE WHEN [reverse]=1 THEN amt *(-1) ELSE amt END),0) AS Amt
			 FROM dbo.VNTREAT x
			 WHERE a.vn=vn and a.visitdate=visitdate and a.SUFFIX=SUFFIX and (TYPEOFCHARGE is NULL or TYPEOFCHARGE<>3)
				   and (select cast(substring(com,91,3) as varchar) from SYSCONFIG z where z.CtrlCode='20023' and z.CODE=x.chargecode)='021')
	    ,'รายได้ค่าห้องปฎิบัติการ (Laboratory)'=
			(SELECT ISNULL(SUM(CASE WHEN [reverse]=1 THEN amt *(-1) ELSE amt END),0) AS Amt
			 FROM dbo.VNTREAT x
			 WHERE a.vn=vn and a.visitdate=visitdate and a.SUFFIX=SUFFIX and (TYPEOFCHARGE is NULL or TYPEOFCHARGE<>3)
				   and (select cast(substring(com,91,3) as varchar) from SYSCONFIG z where z.CtrlCode='20023' and z.CODE=x.chargecode)='022')
	    ,'รายได้ค่าห้องปฎิบัติการ - ส่งตรวจภายนอก'=
			(SELECT ISNULL(SUM(CASE WHEN [reverse]=1 THEN amt *(-1) ELSE amt END),0) AS Amt
			 FROM dbo.VNTREAT x
			 WHERE a.vn=vn and a.visitdate=visitdate and a.SUFFIX=SUFFIX and (TYPEOFCHARGE is NULL or TYPEOFCHARGE<>3)
				   and (select cast(substring(com,91,3) as varchar) from SYSCONFIG z where z.CtrlCode='20023' and z.CODE=x.chargecode)='023')
		,'รายได้ค่าทำ Laser'=
			(SELECT ISNULL(SUM(CASE WHEN [reverse]=1 THEN amt *(-1) ELSE amt END),0) AS Amt
			 FROM dbo.VNTREAT x
			 WHERE a.vn=vn and a.visitdate=visitdate and a.SUFFIX=SUFFIX and (TYPEOFCHARGE is NULL or TYPEOFCHARGE<>3)
				   and (select cast(substring(com,91,3) as varchar) from SYSCONFIG z where z.CtrlCode='20023' and z.CODE=x.chargecode)='024')
		,'รายได้ค่าทำ EKG'=
			(SELECT ISNULL(SUM(CASE WHEN [reverse]=1 THEN amt *(-1) ELSE amt END),0) AS Amt
			 FROM dbo.VNTREAT x
			 WHERE a.vn=vn and a.visitdate=visitdate and a.SUFFIX=SUFFIX and (TYPEOFCHARGE is NULL or TYPEOFCHARGE<>3)
				   and (select cast(substring(com,91,3) as varchar) from SYSCONFIG z where z.CtrlCode='20023' and z.CODE=x.chargecode)='025')
		,'รายได้ค่า EEG'=
			(SELECT ISNULL(SUM(CASE WHEN [reverse]=1 THEN amt *(-1) ELSE amt END),0) AS Amt
			 FROM dbo.VNTREAT x
			 WHERE a.vn=vn and a.visitdate=visitdate and a.SUFFIX=SUFFIX and (TYPEOFCHARGE is NULL or TYPEOFCHARGE<>3)
				   and (select cast(substring(com,91,3) as varchar) from SYSCONFIG z where z.CtrlCode='20023' and z.CODE=x.chargecode)='026')
		,'รายได้ค่าทำ Exercise Stress Test'=
			(SELECT ISNULL(SUM(CASE WHEN [reverse]=1 THEN amt *(-1) ELSE amt END),0) AS Amt
			 FROM dbo.VNTREAT x
			 WHERE a.vn=vn and a.visitdate=visitdate and a.SUFFIX=SUFFIX and (TYPEOFCHARGE is NULL or TYPEOFCHARGE<>3)
				   and (select cast(substring(com,91,3) as varchar) from SYSCONFIG z where z.CtrlCode='20023' and z.CODE=x.chargecode)='027')
		,'รายได้ค่า Echo'=
			(SELECT ISNULL(SUM(CASE WHEN [reverse]=1 THEN amt *(-1) ELSE amt END),0) AS Amt
			 FROM dbo.VNTREAT x
			 WHERE a.vn=vn and a.visitdate=visitdate and a.SUFFIX=SUFFIX and (TYPEOFCHARGE is NULL or TYPEOFCHARGE<>3)
				   and (select cast(substring(com,91,3) as varchar) from SYSCONFIG z where z.CtrlCode='20023' and z.CODE=x.chargecode)='028')
		,'รายได้ค่า Holter'=
			(SELECT ISNULL(SUM(CASE WHEN [reverse]=1 THEN amt *(-1) ELSE amt END),0) AS Amt
			 FROM dbo.VNTREAT x
			 WHERE a.vn=vn and a.visitdate=visitdate and a.SUFFIX=SUFFIX and (TYPEOFCHARGE is NULL or TYPEOFCHARGE<>3)
				   and (select cast(substring(com,91,3) as varchar) from SYSCONFIG z where z.CtrlCode='20023' and z.CODE=x.chargecode)='029')
		,'รายได้ค่าตรวจสมรรถภาพปอด'=
			(SELECT ISNULL(SUM(CASE WHEN [reverse]=1 THEN amt *(-1) ELSE amt END),0) AS Amt
			 FROM dbo.VNTREAT x
			 WHERE a.vn=vn and a.visitdate=visitdate and a.SUFFIX=SUFFIX and (TYPEOFCHARGE is NULL or TYPEOFCHARGE<>3)
				   and (select cast(substring(com,91,3) as varchar) from SYSCONFIG z where z.CtrlCode='20023' and z.CODE=x.chargecode)='030')
		,'รายได้ค่าปฎิบัติการแพทย์อื่น ๆ'=
			(SELECT ISNULL(SUM(CASE WHEN [reverse]=1 THEN amt *(-1) ELSE amt END),0) AS Amt
			 FROM dbo.VNTREAT x
			 WHERE a.vn=vn and a.visitdate=visitdate and a.SUFFIX=SUFFIX and (TYPEOFCHARGE is NULL or TYPEOFCHARGE<>3)
				   and (select cast(substring(com,91,3) as varchar) from SYSCONFIG z where z.CtrlCode='20023' and z.CODE=x.chargecode)='031')
		,'รายได้ค่าบริการโลหิต'=
			(SELECT ISNULL(SUM(CASE WHEN [reverse]=1 THEN amt *(-1) ELSE amt END),0) AS Amt
			 FROM dbo.VNTREAT x
			 WHERE a.vn=vn and a.visitdate=visitdate and a.SUFFIX=SUFFIX and (TYPEOFCHARGE is NULL or TYPEOFCHARGE<>3)
				   and (select cast(substring(com,91,3) as varchar) from SYSCONFIG z where z.CtrlCode='20023' and z.CODE=x.chargecode)='033')
		,'รายได้ค่าอ๊อกซิเจน'=
			(SELECT ISNULL(SUM(CASE WHEN [reverse]=1 THEN amt *(-1) ELSE amt END),0) AS Amt
			 FROM dbo.VNTREAT x
			 WHERE a.vn=vn and a.visitdate=visitdate and a.SUFFIX=SUFFIX and (TYPEOFCHARGE is NULL or TYPEOFCHARGE<>3)
				   and (select cast(substring(com,91,3) as varchar) from SYSCONFIG z where z.CtrlCode='20023' and z.CODE=x.chargecode)='034')
		,'รายได้ค่ากายภาพบำบัด'=
			(SELECT ISNULL(SUM(CASE WHEN [reverse]=1 THEN amt *(-1) ELSE amt END),0) AS Amt
			 FROM dbo.VNTREAT x
			 WHERE a.vn=vn and a.visitdate=visitdate and a.SUFFIX=SUFFIX and (TYPEOFCHARGE is NULL or TYPEOFCHARGE<>3)
				   and (select cast(substring(com,91,3) as varchar) from SYSCONFIG z where z.CtrlCode='20023' and z.CODE=x.chargecode)='036')
		,'รายได้ค่ารถพยาบาล'=
			(SELECT ISNULL(SUM(CASE WHEN [reverse]=1 THEN amt *(-1) ELSE amt END),0) AS Amt
			 FROM dbo.VNTREAT x
			 WHERE a.vn=vn and a.visitdate=visitdate and a.SUFFIX=SUFFIX and (TYPEOFCHARGE is NULL or TYPEOFCHARGE<>3)
				   and (select cast(substring(com,91,3) as varchar) from SYSCONFIG z where z.CtrlCode='20023' and z.CODE=x.chargecode)='037')
		,'รายได้ค่าอาหารคนไข้'=
			(SELECT ISNULL(SUM(CASE WHEN [reverse]=1 THEN amt *(-1) ELSE amt END),0) AS Amt
			 FROM dbo.VNTREAT x
			 WHERE a.vn=vn and a.visitdate=visitdate and a.SUFFIX=SUFFIX and (TYPEOFCHARGE is NULL or TYPEOFCHARGE<>3)
				   and (select cast(substring(com,91,3) as varchar) from SYSCONFIG z where z.CtrlCode='20023' and z.CODE=x.chargecode)='038')
		,'รายได้ค่าโทรศัพท์'=
			(SELECT ISNULL(SUM(CASE WHEN [reverse]=1 THEN amt *(-1) ELSE amt END),0) AS Amt
			 FROM dbo.VNTREAT x
			 WHERE a.vn=vn and a.visitdate=visitdate and a.SUFFIX=SUFFIX and (TYPEOFCHARGE is NULL or TYPEOFCHARGE<>3)
				   and (select cast(substring(com,91,3) as varchar) from SYSCONFIG z where z.CtrlCode='20023' and z.CODE=x.chargecode)='039')
		,'รายได้ค่าใช้อุปกรณ์ทางการแพทย์'=
			(SELECT ISNULL(SUM(CASE WHEN [reverse]=1 THEN amt *(-1) ELSE amt END),0) AS Amt
			 FROM dbo.VNTREAT x
			 WHERE a.vn=vn and a.visitdate=visitdate and a.SUFFIX=SUFFIX and (TYPEOFCHARGE is NULL or TYPEOFCHARGE<>3)
				   and (select cast(substring(com,91,3) as varchar) from SYSCONFIG z where z.CtrlCode='20023' and z.CODE=x.chargecode)='040')
		,'รายได้จากการเขียนใบเคลมหรือใบรับรองแพทย์'=
			(SELECT ISNULL(SUM(CASE WHEN [reverse]=1 THEN amt *(-1) ELSE amt END),0) AS Amt
			 FROM dbo.VNTREAT x
			 WHERE a.vn=vn and a.visitdate=visitdate and a.SUFFIX=SUFFIX and (TYPEOFCHARGE is NULL or TYPEOFCHARGE<>3)
				   and (select cast(substring(com,91,3) as varchar) from SYSCONFIG z where z.CtrlCode='20023' and z.CODE=x.chargecode)='041')
		,'รายได้ค่าฉีดศพ'=
			(SELECT ISNULL(SUM(CASE WHEN [reverse]=1 THEN amt *(-1) ELSE amt END),0) AS Amt
			 FROM dbo.VNTREAT x
			 WHERE a.vn=vn and a.visitdate=visitdate and a.SUFFIX=SUFFIX and (TYPEOFCHARGE is NULL or TYPEOFCHARGE<>3)
				   and (select cast(substring(com,91,3) as varchar) from SYSCONFIG z where z.CtrlCode='20023' and z.CODE=x.chargecode)='042')
		,'รายได้ค่าธรรมเนียมแพทย์ - ทั่วไป'=
			(SELECT ISNULL(SUM(CASE WHEN [reverse]=1 THEN amt *(-1) ELSE amt END),0) AS Amt
			 FROM dbo.VNTREAT x
			 WHERE a.vn=vn and a.visitdate=visitdate and a.SUFFIX=SUFFIX and (TYPEOFCHARGE is NULL or TYPEOFCHARGE<>3)
				   and (select cast(substring(com,91,3) as varchar) from SYSCONFIG z where z.CtrlCode='20023' and z.CODE=x.chargecode)='043')
		,'รายได้ค่าธรรมเนียมแพทย์ - ผ่าตัด'=
			(SELECT ISNULL(SUM(CASE WHEN [reverse]=1 THEN amt *(-1) ELSE amt END),0) AS Amt
			 FROM dbo.VNTREAT x
			 WHERE a.vn=vn and a.visitdate=visitdate and a.SUFFIX=SUFFIX and (TYPEOFCHARGE is NULL or TYPEOFCHARGE<>3)
				   and (select cast(substring(com,91,3) as varchar) from SYSCONFIG z where z.CtrlCode='20023' and z.CODE=x.chargecode)='044')
		,'รายได้ค่าธรรมเนียมแพทย์ - ทันตกรรม'=
			(SELECT ISNULL(SUM(CASE WHEN [reverse]=1 THEN amt *(-1) ELSE amt END),0) AS Amt
			 FROM dbo.VNTREAT x
			 WHERE a.vn=vn and a.visitdate=visitdate and a.SUFFIX=SUFFIX and (TYPEOFCHARGE is NULL or TYPEOFCHARGE<>3)
				   and (select cast(substring(com,91,3) as varchar) from SYSCONFIG z where z.CtrlCode='20023' and z.CODE=x.chargecode)='045')
		,'รายได้ค่าธรรมเนียมแพทย์ - อ่านผล'=
			(SELECT ISNULL(SUM(CASE WHEN [reverse]=1 THEN amt *(-1) ELSE amt END),0) AS Amt
			 FROM dbo.VNTREAT x
			 WHERE a.vn=vn and a.visitdate=visitdate and a.SUFFIX=SUFFIX and (TYPEOFCHARGE is NULL or TYPEOFCHARGE<>3)
				   and (select cast(substring(com,91,3) as varchar) from SYSCONFIG z where z.CtrlCode='20023' and z.CODE=x.chargecode)='046')
		,'รายได้ค่าธรรมเนียมแพทย์อื่น ๆ'=
			(SELECT ISNULL(SUM(CASE WHEN [reverse]=1 THEN amt *(-1) ELSE amt END),0) AS Amt
			 FROM dbo.VNTREAT x
			 WHERE a.vn=vn and a.visitdate=visitdate and a.SUFFIX=SUFFIX and (TYPEOFCHARGE is NULL or TYPEOFCHARGE<>3)
				   and (select cast(substring(com,91,3) as varchar) from SYSCONFIG z where z.CtrlCode='20023' and z.CODE=x.chargecode)='047')
		,'รายได้จากการขายอาหารญาติ'=
			(SELECT ISNULL(SUM(CASE WHEN [reverse]=1 THEN amt *(-1) ELSE amt END),0) AS Amt
			 FROM dbo.VNTREAT x
			 WHERE a.vn=vn and a.visitdate=visitdate and a.SUFFIX=SUFFIX and (TYPEOFCHARGE is NULL or TYPEOFCHARGE<>3)
				   and (select cast(substring(com,91,3) as varchar) from SYSCONFIG z where z.CtrlCode='20023' and z.CODE=x.chargecode)='048')
		,'รายได้ค่ารับเลี้ยงเด็ก'=
			(SELECT ISNULL(SUM(CASE WHEN [reverse]=1 THEN amt *(-1) ELSE amt END),0) AS Amt
			 FROM dbo.VNTREAT x
			 WHERE a.vn=vn and a.visitdate=visitdate and a.SUFFIX=SUFFIX and (TYPEOFCHARGE is NULL or TYPEOFCHARGE<>3)
				   and (select cast(substring(com,91,3) as varchar) from SYSCONFIG z where z.CtrlCode='20023' and z.CODE=x.chargecode)='049')
		,'รายได้ทันตกรรม'=
			(SELECT ISNULL(SUM(CASE WHEN [reverse]=1 THEN amt *(-1) ELSE amt END),0) AS Amt
			 FROM dbo.VNTREAT x
			 WHERE a.vn=vn and a.visitdate=visitdate and a.SUFFIX=SUFFIX and (TYPEOFCHARGE is NULL or TYPEOFCHARGE<>3)
				   and (select cast(substring(com,91,3) as varchar) from SYSCONFIG z where z.CtrlCode='20023' and z.CODE=x.chargecode)='070')
		,'ส่วนลดทั่วไป'=
			(SELECT ISNULL(SUM(CASE WHEN [reverse]=1 THEN amt *(-1) ELSE amt END),0) AS Amt
			 FROM dbo.VNTREAT x
			 WHERE a.vn=vn and a.visitdate=visitdate and a.SUFFIX=SUFFIX and (TYPEOFCHARGE is NULL or TYPEOFCHARGE<>3)
				   and (select cast(substring(com,91,3) as varchar) from SYSCONFIG z where z.CtrlCode='20023' and z.CODE=x.chargecode)='101')
		,'ส่วนลดบริษัทคู่สัญญา'=
			(SELECT ISNULL(SUM(CASE WHEN [reverse]=1 THEN amt *(-1) ELSE amt END),0) AS Amt
			 FROM dbo.VNTREAT x
			 WHERE a.vn=vn and a.visitdate=visitdate and a.SUFFIX=SUFFIX and (TYPEOFCHARGE is NULL or TYPEOFCHARGE<>3)
				   and (select cast(substring(com,91,3) as varchar) from SYSCONFIG z where z.CtrlCode='20023' and z.CODE=x.chargecode)='102')
		,'ส่วนลดโปรแกรมตรวจสุขภาพ'=
			(SELECT ISNULL(SUM(CASE WHEN [reverse]=1 THEN amt *(-1) ELSE amt END),0) AS Amt
			 FROM dbo.VNTREAT x
			 WHERE a.vn=vn and a.visitdate=visitdate and a.SUFFIX=SUFFIX and (TYPEOFCHARGE is NULL or TYPEOFCHARGE<>3)
				   and (select cast(substring(com,91,3) as varchar) from SYSCONFIG z where z.CtrlCode='20023' and z.CODE=x.chargecode)='103')
		,'ส่วนลดค่าบริการเหมาจ่าย'=
			(SELECT ISNULL(SUM(CASE WHEN [reverse]=1 THEN amt *(-1) ELSE amt END),0) AS Amt
			 FROM dbo.VNTREAT x
			 WHERE a.vn=vn and a.visitdate=visitdate and a.SUFFIX=SUFFIX and (TYPEOFCHARGE is NULL or TYPEOFCHARGE<>3)
				   and (select cast(substring(com,91,3) as varchar) from SYSCONFIG z where z.CtrlCode='20023' and z.CODE=x.chargecode)='104')
		,ReceiveCode	   
	    ,TextPulseRate
		,TextRespireRate
		,BPHigh
		,BPLow
		,PostBPHigh
		,PostBPLow
		,BodyWeight
		,Height
		,Temperature
		,UserName	   
		,Blood
		,Tel
		,MobilePhone
		,EmailAddress
		,'Allergy'=case when (select distinct hn from PATIENT_ALLERGIC where HN=a.HN) is not null then 'มี' end
		,'Chronic'=case when (select chronic from ICD_MASTER where icdcode=PrimaryDiagCode)='1' then 'Y' else 'N' end
		,PatientPicture
		,'Religion'=dbo.sysconname(religioncode,10071,2)
		,'Nationality'=dbo.sysconname(NationalityCode,10080,2)
		,'Race'=dbo.sysconname(RaceCode,10072,2)
		,CurrentAge	
		,'Free Package'=''
	    ,'ProcedureICDCmCode1'= (SELECT top 1 ProcudureICDCMCode1 FROM dbo.VNDIAG WHERE a.vn=vn and a.visitdate=visitdate and a.SUFFIX=SUFFIX and TYPEOFTHISDIAG=1)
	    ,'ProcedureICDCmName1'= dbo.ICDCMname((SELECT top 1 ProcudureICDCMCode1 FROM dbo.VNDIAG WHERE a.vn=vn and a.visitdate=visitdate and a.SUFFIX=SUFFIX and TYPEOFTHISDIAG=1),1)
	    ,'ProcedureICDCmCode2'= (SELECT top 1 ProcudureICDCMCode2 FROM dbo.VNDIAG WHERE a.vn=vn and a.visitdate=visitdate and a.SUFFIX=SUFFIX and TYPEOFTHISDIAG=1)
	    ,'ProcedureICDCmName2'= dbo.ICDCMname((SELECT top 1 ProcudureICDCMCode2 FROM dbo.VNDIAG WHERE a.vn=vn and a.visitdate=visitdate and a.SUFFIX=SUFFIX and TYPEOFTHISDIAG=1),1)
	    ,'ProcedureICDCmCode3'= (SELECT top 1 ProcudureICDCMCode3 FROM dbo.VNDIAG WHERE a.vn=vn and a.visitdate=visitdate and a.SUFFIX=SUFFIX and TYPEOFTHISDIAG=1)
	    ,'ProcedureICDCmName3'= dbo.ICDCMname((SELECT top 1 ProcudureICDCMCode3 FROM dbo.VNDIAG WHERE a.vn=vn and a.visitdate=visitdate and a.SUFFIX=SUFFIX and TYPEOFTHISDIAG=1),1)
	    ,'ProcedureICDCmCode4'= (SELECT top 1 ProcudureICDCMCode4 FROM dbo.VNDIAG WHERE a.vn=vn and a.visitdate=visitdate and a.SUFFIX=SUFFIX and TYPEOFTHISDIAG=1)
		,'ProcedureICDCmCode4'= dbo.ICDCMname((SELECT top 1 ProcudureICDCMCode4 FROM dbo.VNDIAG WHERE a.vn=vn and a.visitdate=visitdate and a.SUFFIX=SUFFIX and TYPEOFTHISDIAG=1),1)
		,'Lab'=case when c.Flag='1' then 'Y' else 'N' end
		,IDCard
		,'CloseVisitDateTime'=a.DiagOutDateTime
		
FROM OPD_Visit a
LEFT JOIN PATIENT_CLINIC b ON a.HN=b.HN and a.ClinicCode=b.Clinic
LEFT JOIN LAB c on a.VISITDATE=c.visitdate and a.vn=c.vn

WHERE a.visitdate between @dfrom and @dto

