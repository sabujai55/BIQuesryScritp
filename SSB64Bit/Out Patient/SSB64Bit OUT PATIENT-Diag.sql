select top 10
'PT2' as 'BU'
,vnm.HN as 'PatientID'
,convert(varchar,vnd.VISITDATE,112)+convert(varchar,vnd.VN)+convert(varchar,vnd.PrescriptionNo) as 'VisitID'
,vnd.VisitDate as 'VisitDate'
,vnd.VN as 'VN'
,vnd.PrescriptionNo as 'PrescriptionNo'
,vnd.SuffixSmall as 'Suffix'
,vnp.Clinic as 'LocationCode' --แก้ไขวันที่ 27/02/2568
,dbo.sysconname(vnp.Clinic,42203,2) as 'LocationNameTH' --เพิ่มวันที่ 27/02/2568
,dbo.sysconname(vnp.Clinic,42203,1) as 'LocationNameEN' --เพิ่มวันที่ 27/02/2568
,vnd.DiagDateTime as 'DiagDateTime'
,vnd.DiagnosisRecordType as 'DiagnosisRecordType' 
,case
		when vnd.DiagnosisRecordType = 0 then 'None'
		when vnd.DiagnosisRecordType = 1 then 'Principal'
		when vnd.DiagnosisRecordType = 2 then 'Complication'
		when vnd.DiagnosisRecordType = 3 then 'Metastasis'
		when vnd.DiagnosisRecordType = 4 then 'Comorbidity'
		when vnd.DiagnosisRecordType = 5 then 'Other'
end as 'DiagnosisRecordName'  --เพิ่มวันที่ 27/02/2568
,case when vnd.DiagnosisRecordType = 1 then vnd.ICDCode else null end as 'ICDCode' --แก้ไขวันที่ 17/02/2568
,case when vnd.DiagnosisRecordType = 1 then ISNULL(dbo.CutSortChar(icd.englishname),dbo.CutSortChar(icd.LocalName)) else null end as 'ICDName' --แก้ไขวันที่ 17/02/2568
,vnd.IcdCmCode1 as 'ICDCmCode1'
,ISNULL(dbo.CutSortChar(icdcm1.englishname),dbo.CutSortChar(icdcm1.LocalName)) as 'ICDCmName1'
,vnd.IcdCmCode2 as 'ICDCmCode2'
,ISNULL(dbo.CutSortChar(icdcm2.englishname),dbo.CutSortChar(icdcm2.LocalName)) as 'ICDCmName2'
,vnd.IcdCmCode3 as 'ICDCmCode3'
,ISNULL(dbo.CutSortChar(icdcm3.englishname),dbo.CutSortChar(icdcm3.LocalName)) as 'ICDCmName3'
,vnd.IcdCmCode4 as 'ICDCmCode4'
,ISNULL(dbo.CutSortChar(icdcm4.englishname),dbo.CutSortChar(icdcm4.LocalName)) as 'ICDCmName4'
,vnd.IcdCmCode5 as 'ICDCmCode5'
,ISNULL(dbo.CutSortChar(icdcm5.englishname),dbo.CutSortChar(icdcm5.LocalName)) as 'ICDCmName5'
,vnd.IcdCmCode6 as 'ICDCmCode6'
,ISNULL(dbo.CutSortChar(icdcm6.englishname),dbo.CutSortChar(icdcm6.LocalName)) as 'ICDCmName6'
,vnd.IcdCmCode7 as 'ICDCmCode7'
,ISNULL(dbo.CutSortChar(icdcm7.englishname),dbo.CutSortChar(icdcm7.LocalName)) as 'ICDCmName7'
,vnd.IcdCmCode8 as 'ICDCmCode8'
,ISNULL(dbo.CutSortChar(icdcm8.englishname),dbo.CutSortChar(icdcm8.LocalName)) as 'ICDCmName8'
,vnd.IcdCmCode9 as 'ICDCmCode9'
,ISNULL(dbo.CutSortChar(icdcm9.englishname),dbo.CutSortChar(icdcm9.LocalName))as 'ICDCmName9'
,vnd.IcdCmCode10 as 'ICDCmCode10'
,ISNULL(dbo.CutSortChar(icdcm10.englishname),dbo.CutSortChar(icdcm10.LocalName)) as 'ICDCmName10'
,vnd.EntryByUserCode as 'EntryByUserCode'
,dbo.sysconname(vnd.EntryByUserCode,10031,2) as 'EntryByUserNameTH' --เปลี่ยน จาก Code เป็น Name
,dbo.sysconname(vnd.EntryByUserCode,10031,1) as 'EntryByUserNameEN'
,vnd.RegisterDate as 'RegisterDate'
,vnd.ChronicCreteriaCode as 'ChronicCreteriaCode'
,dbo.sysconname(vnd.ChronicCreteriaCode,43523,4) as 'ChronicCreteriaName'
,vnd.RemarksMemo as 'RemarksMemo' --เพิ่มวันที่ 17/02/2568
,vnd.ECode as 'ECode' --เพิ่มวันที่ 17/02/2568
,ISNULL(SUBSTRING(icde.EnglishName,2,500),SUBSTRING(icde.LocalName,2,500)) as 'ECodeName' --เพิ่มวันที่ 17/02/2568
,vnd1.ICDCode as 'ComobidityCode1' --เพิ่มวันที่ 17/02/2568
,dbo.ICDname(vnd1.ICDCode,4) as 'ComobidityName1' --เพิ่มวันที่ 17/02/2568
,vnd2.ICDCode as 'ComobidityCode2' --เพิ่มวันที่ 17/02/2568
,dbo.ICDname(vnd2.ICDCode,4) as 'ComobidityName2' --เพิ่มวันที่ 17/02/2568
,vnd3.ICDCode as 'ComobidityCode3' --เพิ่มวันที่ 17/02/2568
,dbo.ICDname(vnd3.ICDCode,4) as 'ComobidityName3' --เพิ่มวันที่ 17/02/2568
,vnd4.ICDCode as 'ComobidityCode4' --เพิ่มวันที่ 17/02/2568
,dbo.ICDname(vnd4.ICDCode,4) as 'ComobidityName4' --เพิ่มวันที่ 17/02/2568
,vnd5.ICDCode as 'ComobidityCode5' --เพิ่มวันที่ 17/02/2568
,dbo.ICDname(vnd5.ICDCode,4) as 'ComobidityName5' --เพิ่มวันที่ 17/02/2568
		from HNOPD_PRESCRIP_DIAG vnd
		left join HNOPD_PRESCRIP vnp on vnd.VN=vnp.VN and vnd.VisitDate=vnp.VisitDate and vnd.PrescriptionNo=vnp.PrescriptionNo
		left join HNOPD_MASTER vnm on vnd.VN=vnm.VN and vnd.VisitDate=vnm.VisitDate
		left join HNICD_MASTER icd on vnd.ICDCode=icd.IcdCode and vnd.DiagnosisRecordType = 1
		left join HNICDCM_MASTER icdcm1 on vnd.IcdCmCode1=icdcm1.IcdCmCode
		left join HNICDCM_MASTER icdcm2 on vnd.IcdCmCode2=icdcm2.IcdCmCode
		left join HNICDCM_MASTER icdcm3 on vnd.IcdCmCode3=icdcm3.IcdCmCode
		left join HNICDCM_MASTER icdcm4 on vnd.IcdCmCode4=icdcm4.IcdCmCode
		left join HNICDCM_MASTER icdcm5 on vnd.IcdCmCode5=icdcm5.IcdCmCode
		left join HNICDCM_MASTER icdcm6 on vnd.IcdCmCode6=icdcm6.IcdCmCode
		left join HNICDCM_MASTER icdcm7 on vnd.IcdCmCode7=icdcm7.IcdCmCode
		left join HNICDCM_MASTER icdcm8 on vnd.IcdCmCode8=icdcm8.IcdCmCode
		left join HNICDCM_MASTER icdcm9 on vnd.IcdCmCode9=icdcm9.IcdCmCode
		left join HNICDCM_MASTER icdcm10 on vnd.IcdCmCode10=icdcm10.IcdCmCode
		left join HNICD_MASTER icde on vnd.ECode=icde.IcdCode
		LEFT join	( 
						select VisitDate,VN,PrescriptionNo,SuffixSmall,ICDCode,DiagnosisRecordType
								from HNOPD_PRESCRIP_DIAG 
								where DiagnosisRecordType = 4
								and SuffixSmall = 1
					)vnd1 on vnd.VN=vnd1.VN and vnd.VisitDate=vnd1.VisitDate and vnd.PrescriptionNo=vnd1.PrescriptionNo and vnd.SuffixSmall=vnd1.SuffixSmall and vnd.DiagnosisRecordType=vnd1.DiagnosisRecordType 
		LEFT join	( 
						select VisitDate,VN,PrescriptionNo,SuffixSmall,ICDCode,DiagnosisRecordType
								from HNOPD_PRESCRIP_DIAG 
								where DiagnosisRecordType = 4
								and SuffixSmall = 2
					)vnd2 on vnd.VN=vnd2.VN and vnd.VisitDate=vnd2.VisitDate and vnd.PrescriptionNo=vnd2.PrescriptionNo and vnd.SuffixSmall=vnd2.SuffixSmall and vnd.DiagnosisRecordType=vnd2.DiagnosisRecordType 
		LEFT join	( 
						select VisitDate,VN,PrescriptionNo,SuffixSmall,ICDCode,DiagnosisRecordType
								from HNOPD_PRESCRIP_DIAG 
								where DiagnosisRecordType = 4
								and SuffixSmall = 3
					)vnd3 on vnd.VN=vnd3.VN and vnd.VisitDate=vnd3.VisitDate and vnd.PrescriptionNo=vnd3.PrescriptionNo and vnd.SuffixSmall=vnd3.SuffixSmall and vnd.DiagnosisRecordType=vnd3.DiagnosisRecordType 
		LEFT join	( 
						select VisitDate,VN,PrescriptionNo,SuffixSmall,ICDCode,DiagnosisRecordType
								from HNOPD_PRESCRIP_DIAG 
								where DiagnosisRecordType = 4
								and SuffixSmall = 4
					)vnd4 on vnd.VN=vnd4.VN and vnd.VisitDate=vnd4.VisitDate and vnd.PrescriptionNo=vnd4.PrescriptionNo and vnd.SuffixSmall=vnd4.SuffixSmall and vnd.DiagnosisRecordType=vnd4.DiagnosisRecordType 
		LEFT join	( 
						select VisitDate,VN,PrescriptionNo,SuffixSmall,ICDCode,DiagnosisRecordType
								from HNOPD_PRESCRIP_DIAG 
								where DiagnosisRecordType = 4
								and SuffixSmall = 5
					)vnd5 on vnd.VN=vnd5.VN and vnd.VisitDate=vnd5.VisitDate and vnd.PrescriptionNo=vnd5.PrescriptionNo and vnd.SuffixSmall=vnd5.SuffixSmall and vnd.DiagnosisRecordType=vnd5.DiagnosisRecordType 


