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
	    ,'���������'=
			(SELECT ISNULL(SUM(CASE WHEN [reverse]=1 THEN amt *(-1) ELSE amt END),0) AS Amt
			 FROM dbo.VNMEDICINE x
			 WHERE a.vn=vn and a.visitdate=visitdate and a.SUFFIX=SUFFIX and TYPEOFCHARGE not in (1,3)
				   and (select cast(substring(com,91,3) as varchar) from SYSCONFIG z where z.CtrlCode='20023' and z.CODE=x.chargecode)='032')
	    ,'���������ʴ�������ͧ�ҧ���ᾷ��'=
			(SELECT ISNULL(SUM(CASE WHEN [reverse]=1 THEN amt *(-1) ELSE amt END),0) AS Amt
			 FROM dbo.VNMEDICINE x
			 WHERE a.vn=vn and a.visitdate=visitdate and a.SUFFIX=SUFFIX and TYPEOFCHARGE not in (1,3)
				   and (select cast(substring(com,91,3) as varchar) from SYSCONFIG z where z.CtrlCode='20023' and z.CODE=x.chargecode)='035')+
			(SELECT ISNULL(SUM(CASE WHEN [reverse]=1 THEN amt *(-1) ELSE amt END),0) AS Amt
			 FROM dbo.VNTREAT x
			 WHERE a.vn=vn and a.visitdate=visitdate and a.SUFFIX=SUFFIX and TYPEOFCHARGE not in (1,3)
				   and (select cast(substring(com,91,3) as varchar) from SYSCONFIG z where z.CtrlCode='20023' and z.CODE=x.chargecode)='035')
--VNTREAT
		,'���������ͧ�ѧࡵ��ó�'=
			(SELECT ISNULL(SUM(CASE WHEN [reverse]=1 THEN amt *(-1) ELSE amt END),0) AS Amt
			 FROM dbo.VNTREAT x
			 WHERE a.vn=vn and a.visitdate=visitdate and a.SUFFIX=SUFFIX and (TYPEOFCHARGE is NULL or TYPEOFCHARGE<>3)
				   and (select cast(substring(com,91,3) as varchar) from SYSCONFIG z where z.CtrlCode='20023' and z.CODE=x.chargecode)='001')
		,'���������ͧ�������'=
			(SELECT ISNULL(SUM(CASE WHEN [reverse]=1 THEN amt *(-1) ELSE amt END),0) AS Amt
			 FROM dbo.VNTREAT x
			 WHERE a.vn=vn and a.visitdate=visitdate and a.SUFFIX=SUFFIX and (TYPEOFCHARGE is NULL or TYPEOFCHARGE<>3)
				   and (select cast(substring(com,91,3) as varchar) from SYSCONFIG z where z.CtrlCode='20023' and z.CODE=x.chargecode)='002')
		,'���������ͧ�ͤ�ʹ'=
			(SELECT ISNULL(SUM(CASE WHEN [reverse]=1 THEN amt *(-1) ELSE amt END),0) AS Amt
			 FROM dbo.VNTREAT x
			 WHERE a.vn=vn and a.visitdate=visitdate and a.SUFFIX=SUFFIX and (TYPEOFCHARGE is NULL or TYPEOFCHARGE<>3)
				   and (select cast(substring(com,91,3) as varchar) from SYSCONFIG z where z.CtrlCode='20023' and z.CODE=x.chargecode)='003')
		,'���������ͧ��ʹ'=
			(SELECT ISNULL(SUM(CASE WHEN [reverse]=1 THEN amt *(-1) ELSE amt END),0) AS Amt
			 FROM dbo.VNTREAT x
			 WHERE a.vn=vn and a.visitdate=visitdate and a.SUFFIX=SUFFIX and (TYPEOFCHARGE is NULL or TYPEOFCHARGE<>3)
				   and (select cast(substring(com,91,3) as varchar) from SYSCONFIG z where z.CtrlCode='20023' and z.CODE=x.chargecode)='004')
		,'���������ͧ ICU'=
			(SELECT ISNULL(SUM(CASE WHEN [reverse]=1 THEN amt *(-1) ELSE amt END),0) AS Amt
			 FROM dbo.VNTREAT x
			 WHERE a.vn=vn and a.visitdate=visitdate and a.SUFFIX=SUFFIX and (TYPEOFCHARGE is NULL or TYPEOFCHARGE<>3)
				   and (select cast(substring(com,91,3) as varchar) from SYSCONFIG z where z.CtrlCode='20023' and z.CODE=x.chargecode)='005')
		,'���������ͧ�ѡ���'=
			(SELECT ISNULL(SUM(CASE WHEN [reverse]=1 THEN amt *(-1) ELSE amt END),0) AS Amt
			 FROM dbo.VNTREAT x
			 WHERE a.vn=vn and a.visitdate=visitdate and a.SUFFIX=SUFFIX and (TYPEOFCHARGE is NULL or TYPEOFCHARGE<>3)
				   and (select cast(substring(com,91,3) as varchar) from SYSCONFIG z where z.CtrlCode='20023' and z.CODE=x.chargecode)='006')
		,'���������ͧ��ҵѴ'=
			(SELECT ISNULL(SUM(CASE WHEN [reverse]=1 THEN amt *(-1) ELSE amt END),0) AS Amt
			 FROM dbo.VNTREAT x
			 WHERE a.vn=vn and a.visitdate=visitdate and a.SUFFIX=SUFFIX and (TYPEOFCHARGE is NULL or TYPEOFCHARGE<>3)
				   and (select cast(substring(com,91,3) as varchar) from SYSCONFIG z where z.CtrlCode='20023' and z.CODE=x.chargecode)='007')
		,'���������ҧ�'=
			(SELECT ISNULL(SUM(CASE WHEN [reverse]=1 THEN amt *(-1) ELSE amt END),0) AS Amt
			 FROM dbo.VNTREAT x
			 WHERE a.vn=vn and a.visitdate=visitdate and a.SUFFIX=SUFFIX and (TYPEOFCHARGE is NULL or TYPEOFCHARGE<>3)
				   and (select cast(substring(com,91,3) as varchar) from SYSCONFIG z where z.CtrlCode='20023' and z.CODE=x.chargecode)='008')
		,'������Ҵ���'=
			(SELECT ISNULL(SUM(CASE WHEN [reverse]=1 THEN amt *(-1) ELSE amt END),0) AS Amt
			 FROM dbo.VNTREAT x
			 WHERE a.vn=vn and a.visitdate=visitdate and a.SUFFIX=SUFFIX and (TYPEOFCHARGE is NULL or TYPEOFCHARGE<>3)
				   and (select cast(substring(com,91,3) as varchar) from SYSCONFIG z where z.CtrlCode='20023' and z.CODE=x.chargecode)='009')
		,'����������¹���'=
			(SELECT ISNULL(SUM(CASE WHEN [reverse]=1 THEN amt *(-1) ELSE amt END),0) AS Amt
			 FROM dbo.VNTREAT x
			 WHERE a.vn=vn and a.visitdate=visitdate and a.SUFFIX=SUFFIX and (TYPEOFCHARGE is NULL or TYPEOFCHARGE<>3)
				   and (select cast(substring(com,91,3) as varchar) from SYSCONFIG z where z.CtrlCode='20023' and z.CODE=x.chargecode)='010')
		,'������ҵ�Ǩ����㹶ا��Ӵ�'=
			(SELECT ISNULL(SUM(CASE WHEN [reverse]=1 THEN amt *(-1) ELSE amt END),0) AS Amt
			 FROM dbo.VNTREAT x
			 WHERE a.vn=vn and a.visitdate=visitdate and a.SUFFIX=SUFFIX and (TYPEOFCHARGE is NULL or TYPEOFCHARGE<>3)
				   and (select cast(substring(com,91,3) as varchar) from SYSCONFIG z where z.CtrlCode='20023' and z.CODE=x.chargecode)='011')
		,'������Һ�ԡ�þ�Һ��'=
			(SELECT ISNULL(SUM(CASE WHEN [reverse]=1 THEN amt *(-1) ELSE amt END),0) AS Amt
			 FROM dbo.VNTREAT x
			 WHERE a.vn=vn and a.visitdate=visitdate and a.SUFFIX=SUFFIX and (TYPEOFCHARGE is NULL or TYPEOFCHARGE<>3)
				   and (select cast(substring(com,91,3) as varchar) from SYSCONFIG z where z.CtrlCode='20023' and z.CODE=x.chargecode)='012')
		,'������Һ�ԡ����� �'=
			(SELECT ISNULL(SUM(CASE WHEN [reverse]=1 THEN amt *(-1) ELSE amt END),0) AS Amt
			 FROM dbo.VNTREAT x
			 WHERE a.vn=vn and a.visitdate=visitdate and a.SUFFIX=SUFFIX and (TYPEOFCHARGE is NULL or TYPEOFCHARGE<>3)
				   and (select cast(substring(com,91,3) as varchar) from SYSCONFIG z where z.CtrlCode='20023' and z.CODE=x.chargecode)='013')
	    ,'������Ҿ�Һ�ž����'=
			(SELECT ISNULL(SUM(CASE WHEN [reverse]=1 THEN amt *(-1) ELSE amt END),0) AS Amt
			 FROM dbo.VNTREAT x
			 WHERE a.vn=vn and a.visitdate=visitdate and a.SUFFIX=SUFFIX and (TYPEOFCHARGE is NULL or TYPEOFCHARGE<>3)
				   and (select cast(substring(com,91,3) as varchar) from SYSCONFIG z where z.CtrlCode='20023' and z.CODE=x.chargecode)='014')
	    ,'���������硫����'=
			(SELECT ISNULL(SUM(CASE WHEN [reverse]=1 THEN amt *(-1) ELSE amt END),0) AS Amt
			 FROM dbo.VNTREAT x
			 WHERE a.vn=vn and a.visitdate=visitdate and a.SUFFIX=SUFFIX and (TYPEOFCHARGE is NULL or TYPEOFCHARGE<>3)
				   and (select cast(substring(com,91,3) as varchar) from SYSCONFIG z where z.CtrlCode='20023' and z.CODE=x.chargecode)='015')
		,'���������硫�������������'=
			(SELECT ISNULL(SUM(CASE WHEN [reverse]=1 THEN amt *(-1) ELSE amt END),0) AS Amt
			 FROM dbo.VNTREAT x
			 WHERE a.vn=vn and a.visitdate=visitdate and a.SUFFIX=SUFFIX and (TYPEOFCHARGE is NULL or TYPEOFCHARGE<>3)
				   and (select cast(substring(com,91,3) as varchar) from SYSCONFIG z where z.CtrlCode='20023' and z.CODE=x.chargecode)='016')
		,'������� Ultrasound'=
			(SELECT ISNULL(SUM(CASE WHEN [reverse]=1 THEN amt *(-1) ELSE amt END),0) AS Amt
			 FROM dbo.VNTREAT x
			 WHERE a.vn=vn and a.visitdate=visitdate and a.SUFFIX=SUFFIX and (TYPEOFCHARGE is NULL or TYPEOFCHARGE<>3)
				   and (select cast(substring(com,91,3) as varchar) from SYSCONFIG z where z.CtrlCode='20023' and z.CODE=x.chargecode)='017')
	    ,'������� MRI'=
			(SELECT ISNULL(SUM(CASE WHEN [reverse]=1 THEN amt *(-1) ELSE amt END),0) AS Amt
			 FROM dbo.VNTREAT x
			 WHERE a.vn=vn and a.visitdate=visitdate and a.SUFFIX=SUFFIX and (TYPEOFCHARGE is NULL or TYPEOFCHARGE<>3)
				   and (select cast(substring(com,91,3) as varchar) from SYSCONFIG z where z.CtrlCode='20023' and z.CODE=x.chargecode)='018')
	    ,'������� Mammogram'=
			(SELECT ISNULL(SUM(CASE WHEN [reverse]=1 THEN amt *(-1) ELSE amt END),0) AS Amt
			 FROM dbo.VNTREAT x
			 WHERE a.vn=vn and a.visitdate=visitdate and a.SUFFIX=SUFFIX and (TYPEOFCHARGE is NULL or TYPEOFCHARGE<>3)
				   and (select cast(substring(com,91,3) as varchar) from SYSCONFIG z where z.CtrlCode='20023' and z.CODE=x.chargecode)='019')
		,'������ҷ� Bone Density'=
			(SELECT ISNULL(SUM(CASE WHEN [reverse]=1 THEN amt *(-1) ELSE amt END),0) AS Amt
			 FROM dbo.VNTREAT x
			 WHERE a.vn=vn and a.visitdate=visitdate and a.SUFFIX=SUFFIX and (TYPEOFCHARGE is NULL or TYPEOFCHARGE<>3)
				   and (select cast(substring(com,91,3) as varchar) from SYSCONFIG z where z.CtrlCode='20023' and z.CODE=x.chargecode)='020')
		,'������� DSI Angiography'=
			(SELECT ISNULL(SUM(CASE WHEN [reverse]=1 THEN amt *(-1) ELSE amt END),0) AS Amt
			 FROM dbo.VNTREAT x
			 WHERE a.vn=vn and a.visitdate=visitdate and a.SUFFIX=SUFFIX and (TYPEOFCHARGE is NULL or TYPEOFCHARGE<>3)
				   and (select cast(substring(com,91,3) as varchar) from SYSCONFIG z where z.CtrlCode='20023' and z.CODE=x.chargecode)='021')
	    ,'���������ͧ��Ժѵԡ�� (Laboratory)'=
			(SELECT ISNULL(SUM(CASE WHEN [reverse]=1 THEN amt *(-1) ELSE amt END),0) AS Amt
			 FROM dbo.VNTREAT x
			 WHERE a.vn=vn and a.visitdate=visitdate and a.SUFFIX=SUFFIX and (TYPEOFCHARGE is NULL or TYPEOFCHARGE<>3)
				   and (select cast(substring(com,91,3) as varchar) from SYSCONFIG z where z.CtrlCode='20023' and z.CODE=x.chargecode)='022')
	    ,'���������ͧ��Ժѵԡ�� - �觵�Ǩ��¹͡'=
			(SELECT ISNULL(SUM(CASE WHEN [reverse]=1 THEN amt *(-1) ELSE amt END),0) AS Amt
			 FROM dbo.VNTREAT x
			 WHERE a.vn=vn and a.visitdate=visitdate and a.SUFFIX=SUFFIX and (TYPEOFCHARGE is NULL or TYPEOFCHARGE<>3)
				   and (select cast(substring(com,91,3) as varchar) from SYSCONFIG z where z.CtrlCode='20023' and z.CODE=x.chargecode)='023')
		,'������ҷ� Laser'=
			(SELECT ISNULL(SUM(CASE WHEN [reverse]=1 THEN amt *(-1) ELSE amt END),0) AS Amt
			 FROM dbo.VNTREAT x
			 WHERE a.vn=vn and a.visitdate=visitdate and a.SUFFIX=SUFFIX and (TYPEOFCHARGE is NULL or TYPEOFCHARGE<>3)
				   and (select cast(substring(com,91,3) as varchar) from SYSCONFIG z where z.CtrlCode='20023' and z.CODE=x.chargecode)='024')
		,'������ҷ� EKG'=
			(SELECT ISNULL(SUM(CASE WHEN [reverse]=1 THEN amt *(-1) ELSE amt END),0) AS Amt
			 FROM dbo.VNTREAT x
			 WHERE a.vn=vn and a.visitdate=visitdate and a.SUFFIX=SUFFIX and (TYPEOFCHARGE is NULL or TYPEOFCHARGE<>3)
				   and (select cast(substring(com,91,3) as varchar) from SYSCONFIG z where z.CtrlCode='20023' and z.CODE=x.chargecode)='025')
		,'������� EEG'=
			(SELECT ISNULL(SUM(CASE WHEN [reverse]=1 THEN amt *(-1) ELSE amt END),0) AS Amt
			 FROM dbo.VNTREAT x
			 WHERE a.vn=vn and a.visitdate=visitdate and a.SUFFIX=SUFFIX and (TYPEOFCHARGE is NULL or TYPEOFCHARGE<>3)
				   and (select cast(substring(com,91,3) as varchar) from SYSCONFIG z where z.CtrlCode='20023' and z.CODE=x.chargecode)='026')
		,'������ҷ� Exercise Stress Test'=
			(SELECT ISNULL(SUM(CASE WHEN [reverse]=1 THEN amt *(-1) ELSE amt END),0) AS Amt
			 FROM dbo.VNTREAT x
			 WHERE a.vn=vn and a.visitdate=visitdate and a.SUFFIX=SUFFIX and (TYPEOFCHARGE is NULL or TYPEOFCHARGE<>3)
				   and (select cast(substring(com,91,3) as varchar) from SYSCONFIG z where z.CtrlCode='20023' and z.CODE=x.chargecode)='027')
		,'������� Echo'=
			(SELECT ISNULL(SUM(CASE WHEN [reverse]=1 THEN amt *(-1) ELSE amt END),0) AS Amt
			 FROM dbo.VNTREAT x
			 WHERE a.vn=vn and a.visitdate=visitdate and a.SUFFIX=SUFFIX and (TYPEOFCHARGE is NULL or TYPEOFCHARGE<>3)
				   and (select cast(substring(com,91,3) as varchar) from SYSCONFIG z where z.CtrlCode='20023' and z.CODE=x.chargecode)='028')
		,'������� Holter'=
			(SELECT ISNULL(SUM(CASE WHEN [reverse]=1 THEN amt *(-1) ELSE amt END),0) AS Amt
			 FROM dbo.VNTREAT x
			 WHERE a.vn=vn and a.visitdate=visitdate and a.SUFFIX=SUFFIX and (TYPEOFCHARGE is NULL or TYPEOFCHARGE<>3)
				   and (select cast(substring(com,91,3) as varchar) from SYSCONFIG z where z.CtrlCode='20023' and z.CODE=x.chargecode)='029')
		,'������ҵ�Ǩ���ö�Ҿ�ʹ'=
			(SELECT ISNULL(SUM(CASE WHEN [reverse]=1 THEN amt *(-1) ELSE amt END),0) AS Amt
			 FROM dbo.VNTREAT x
			 WHERE a.vn=vn and a.visitdate=visitdate and a.SUFFIX=SUFFIX and (TYPEOFCHARGE is NULL or TYPEOFCHARGE<>3)
				   and (select cast(substring(com,91,3) as varchar) from SYSCONFIG z where z.CtrlCode='20023' and z.CODE=x.chargecode)='030')
		,'������һ�Ժѵԡ��ᾷ����� �'=
			(SELECT ISNULL(SUM(CASE WHEN [reverse]=1 THEN amt *(-1) ELSE amt END),0) AS Amt
			 FROM dbo.VNTREAT x
			 WHERE a.vn=vn and a.visitdate=visitdate and a.SUFFIX=SUFFIX and (TYPEOFCHARGE is NULL or TYPEOFCHARGE<>3)
				   and (select cast(substring(com,91,3) as varchar) from SYSCONFIG z where z.CtrlCode='20023' and z.CODE=x.chargecode)='031')
		,'������Һ�ԡ�����Ե'=
			(SELECT ISNULL(SUM(CASE WHEN [reverse]=1 THEN amt *(-1) ELSE amt END),0) AS Amt
			 FROM dbo.VNTREAT x
			 WHERE a.vn=vn and a.visitdate=visitdate and a.SUFFIX=SUFFIX and (TYPEOFCHARGE is NULL or TYPEOFCHARGE<>3)
				   and (select cast(substring(com,91,3) as varchar) from SYSCONFIG z where z.CtrlCode='20023' and z.CODE=x.chargecode)='033')
		,'���������͡��ਹ'=
			(SELECT ISNULL(SUM(CASE WHEN [reverse]=1 THEN amt *(-1) ELSE amt END),0) AS Amt
			 FROM dbo.VNTREAT x
			 WHERE a.vn=vn and a.visitdate=visitdate and a.SUFFIX=SUFFIX and (TYPEOFCHARGE is NULL or TYPEOFCHARGE<>3)
				   and (select cast(substring(com,91,3) as varchar) from SYSCONFIG z where z.CtrlCode='20023' and z.CODE=x.chargecode)='034')
		,'������ҡ���Ҿ�ӺѴ'=
			(SELECT ISNULL(SUM(CASE WHEN [reverse]=1 THEN amt *(-1) ELSE amt END),0) AS Amt
			 FROM dbo.VNTREAT x
			 WHERE a.vn=vn and a.visitdate=visitdate and a.SUFFIX=SUFFIX and (TYPEOFCHARGE is NULL or TYPEOFCHARGE<>3)
				   and (select cast(substring(com,91,3) as varchar) from SYSCONFIG z where z.CtrlCode='20023' and z.CODE=x.chargecode)='036')
		,'�������ö��Һ��'=
			(SELECT ISNULL(SUM(CASE WHEN [reverse]=1 THEN amt *(-1) ELSE amt END),0) AS Amt
			 FROM dbo.VNTREAT x
			 WHERE a.vn=vn and a.visitdate=visitdate and a.SUFFIX=SUFFIX and (TYPEOFCHARGE is NULL or TYPEOFCHARGE<>3)
				   and (select cast(substring(com,91,3) as varchar) from SYSCONFIG z where z.CtrlCode='20023' and z.CODE=x.chargecode)='037')
		,'�����������ä���'=
			(SELECT ISNULL(SUM(CASE WHEN [reverse]=1 THEN amt *(-1) ELSE amt END),0) AS Amt
			 FROM dbo.VNTREAT x
			 WHERE a.vn=vn and a.visitdate=visitdate and a.SUFFIX=SUFFIX and (TYPEOFCHARGE is NULL or TYPEOFCHARGE<>3)
				   and (select cast(substring(com,91,3) as varchar) from SYSCONFIG z where z.CtrlCode='20023' and z.CODE=x.chargecode)='038')
		,'����������Ѿ��'=
			(SELECT ISNULL(SUM(CASE WHEN [reverse]=1 THEN amt *(-1) ELSE amt END),0) AS Amt
			 FROM dbo.VNTREAT x
			 WHERE a.vn=vn and a.visitdate=visitdate and a.SUFFIX=SUFFIX and (TYPEOFCHARGE is NULL or TYPEOFCHARGE<>3)
				   and (select cast(substring(com,91,3) as varchar) from SYSCONFIG z where z.CtrlCode='20023' and z.CODE=x.chargecode)='039')
		,'����������ػ�ó�ҧ���ᾷ��'=
			(SELECT ISNULL(SUM(CASE WHEN [reverse]=1 THEN amt *(-1) ELSE amt END),0) AS Amt
			 FROM dbo.VNTREAT x
			 WHERE a.vn=vn and a.visitdate=visitdate and a.SUFFIX=SUFFIX and (TYPEOFCHARGE is NULL or TYPEOFCHARGE<>3)
				   and (select cast(substring(com,91,3) as varchar) from SYSCONFIG z where z.CtrlCode='20023' and z.CODE=x.chargecode)='040')
		,'�����ҡ�����¹����������Ѻ�ͧᾷ��'=
			(SELECT ISNULL(SUM(CASE WHEN [reverse]=1 THEN amt *(-1) ELSE amt END),0) AS Amt
			 FROM dbo.VNTREAT x
			 WHERE a.vn=vn and a.visitdate=visitdate and a.SUFFIX=SUFFIX and (TYPEOFCHARGE is NULL or TYPEOFCHARGE<>3)
				   and (select cast(substring(com,91,3) as varchar) from SYSCONFIG z where z.CtrlCode='20023' and z.CODE=x.chargecode)='041')
		,'������ҩմȾ'=
			(SELECT ISNULL(SUM(CASE WHEN [reverse]=1 THEN amt *(-1) ELSE amt END),0) AS Amt
			 FROM dbo.VNTREAT x
			 WHERE a.vn=vn and a.visitdate=visitdate and a.SUFFIX=SUFFIX and (TYPEOFCHARGE is NULL or TYPEOFCHARGE<>3)
				   and (select cast(substring(com,91,3) as varchar) from SYSCONFIG z where z.CtrlCode='20023' and z.CODE=x.chargecode)='042')
		,'������Ҹ�������ᾷ�� - �����'=
			(SELECT ISNULL(SUM(CASE WHEN [reverse]=1 THEN amt *(-1) ELSE amt END),0) AS Amt
			 FROM dbo.VNTREAT x
			 WHERE a.vn=vn and a.visitdate=visitdate and a.SUFFIX=SUFFIX and (TYPEOFCHARGE is NULL or TYPEOFCHARGE<>3)
				   and (select cast(substring(com,91,3) as varchar) from SYSCONFIG z where z.CtrlCode='20023' and z.CODE=x.chargecode)='043')
		,'������Ҹ�������ᾷ�� - ��ҵѴ'=
			(SELECT ISNULL(SUM(CASE WHEN [reverse]=1 THEN amt *(-1) ELSE amt END),0) AS Amt
			 FROM dbo.VNTREAT x
			 WHERE a.vn=vn and a.visitdate=visitdate and a.SUFFIX=SUFFIX and (TYPEOFCHARGE is NULL or TYPEOFCHARGE<>3)
				   and (select cast(substring(com,91,3) as varchar) from SYSCONFIG z where z.CtrlCode='20023' and z.CODE=x.chargecode)='044')
		,'������Ҹ�������ᾷ�� - �ѹ�����'=
			(SELECT ISNULL(SUM(CASE WHEN [reverse]=1 THEN amt *(-1) ELSE amt END),0) AS Amt
			 FROM dbo.VNTREAT x
			 WHERE a.vn=vn and a.visitdate=visitdate and a.SUFFIX=SUFFIX and (TYPEOFCHARGE is NULL or TYPEOFCHARGE<>3)
				   and (select cast(substring(com,91,3) as varchar) from SYSCONFIG z where z.CtrlCode='20023' and z.CODE=x.chargecode)='045')
		,'������Ҹ�������ᾷ�� - ��ҹ��'=
			(SELECT ISNULL(SUM(CASE WHEN [reverse]=1 THEN amt *(-1) ELSE amt END),0) AS Amt
			 FROM dbo.VNTREAT x
			 WHERE a.vn=vn and a.visitdate=visitdate and a.SUFFIX=SUFFIX and (TYPEOFCHARGE is NULL or TYPEOFCHARGE<>3)
				   and (select cast(substring(com,91,3) as varchar) from SYSCONFIG z where z.CtrlCode='20023' and z.CODE=x.chargecode)='046')
		,'������Ҹ�������ᾷ����� �'=
			(SELECT ISNULL(SUM(CASE WHEN [reverse]=1 THEN amt *(-1) ELSE amt END),0) AS Amt
			 FROM dbo.VNTREAT x
			 WHERE a.vn=vn and a.visitdate=visitdate and a.SUFFIX=SUFFIX and (TYPEOFCHARGE is NULL or TYPEOFCHARGE<>3)
				   and (select cast(substring(com,91,3) as varchar) from SYSCONFIG z where z.CtrlCode='20023' and z.CODE=x.chargecode)='047')
		,'�����ҡ��â������íҵ�'=
			(SELECT ISNULL(SUM(CASE WHEN [reverse]=1 THEN amt *(-1) ELSE amt END),0) AS Amt
			 FROM dbo.VNTREAT x
			 WHERE a.vn=vn and a.visitdate=visitdate and a.SUFFIX=SUFFIX and (TYPEOFCHARGE is NULL or TYPEOFCHARGE<>3)
				   and (select cast(substring(com,91,3) as varchar) from SYSCONFIG z where z.CtrlCode='20023' and z.CODE=x.chargecode)='048')
		,'��������Ѻ����§��'=
			(SELECT ISNULL(SUM(CASE WHEN [reverse]=1 THEN amt *(-1) ELSE amt END),0) AS Amt
			 FROM dbo.VNTREAT x
			 WHERE a.vn=vn and a.visitdate=visitdate and a.SUFFIX=SUFFIX and (TYPEOFCHARGE is NULL or TYPEOFCHARGE<>3)
				   and (select cast(substring(com,91,3) as varchar) from SYSCONFIG z where z.CtrlCode='20023' and z.CODE=x.chargecode)='049')
		,'�����ѹ�����'=
			(SELECT ISNULL(SUM(CASE WHEN [reverse]=1 THEN amt *(-1) ELSE amt END),0) AS Amt
			 FROM dbo.VNTREAT x
			 WHERE a.vn=vn and a.visitdate=visitdate and a.SUFFIX=SUFFIX and (TYPEOFCHARGE is NULL or TYPEOFCHARGE<>3)
				   and (select cast(substring(com,91,3) as varchar) from SYSCONFIG z where z.CtrlCode='20023' and z.CODE=x.chargecode)='070')
		,'��ǹŴ�����'=
			(SELECT ISNULL(SUM(CASE WHEN [reverse]=1 THEN amt *(-1) ELSE amt END),0) AS Amt
			 FROM dbo.VNTREAT x
			 WHERE a.vn=vn and a.visitdate=visitdate and a.SUFFIX=SUFFIX and (TYPEOFCHARGE is NULL or TYPEOFCHARGE<>3)
				   and (select cast(substring(com,91,3) as varchar) from SYSCONFIG z where z.CtrlCode='20023' and z.CODE=x.chargecode)='101')
		,'��ǹŴ����ѷ����ѭ��'=
			(SELECT ISNULL(SUM(CASE WHEN [reverse]=1 THEN amt *(-1) ELSE amt END),0) AS Amt
			 FROM dbo.VNTREAT x
			 WHERE a.vn=vn and a.visitdate=visitdate and a.SUFFIX=SUFFIX and (TYPEOFCHARGE is NULL or TYPEOFCHARGE<>3)
				   and (select cast(substring(com,91,3) as varchar) from SYSCONFIG z where z.CtrlCode='20023' and z.CODE=x.chargecode)='102')
		,'��ǹŴ�������Ǩ�آ�Ҿ'=
			(SELECT ISNULL(SUM(CASE WHEN [reverse]=1 THEN amt *(-1) ELSE amt END),0) AS Amt
			 FROM dbo.VNTREAT x
			 WHERE a.vn=vn and a.visitdate=visitdate and a.SUFFIX=SUFFIX and (TYPEOFCHARGE is NULL or TYPEOFCHARGE<>3)
				   and (select cast(substring(com,91,3) as varchar) from SYSCONFIG z where z.CtrlCode='20023' and z.CODE=x.chargecode)='103')
		,'��ǹŴ��Һ�ԡ�����Ҩ���'=
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
		,'Allergy'=case when (select distinct hn from PATIENT_ALLERGIC where HN=a.HN) is not null then '��' end
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

