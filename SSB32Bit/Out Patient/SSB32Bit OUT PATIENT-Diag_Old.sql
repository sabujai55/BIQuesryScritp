select top 1000 
'PLS' as 'BU'
,vnm.HN as 'PatientID'
,convert(varchar,vnd.VISITDATE,112)+convert(varchar,vnd.VN)+convert(varchar,vnd.SUFFIX) as 'VisitID'
,vnd.VISITDATE as 'VisitDate'
,vnd.VN as 'VN'
,vnd.SUFFIX as 'PrescriptionNo'
,vnd.SUBSUFFIX as 'Suffix'
,vnp.CLINIC as 'ClinicCode' 
,dbo.sysconname(vnp.CLINIC,20016,2) as 'ClinicNameTH' 
,dbo.sysconname(vnp.CLINIC,20016,1) as 'ClinicNameEN'
,vnd.DIAGDATETIME as 'DiagDateTime'
--,vnd.TYPEOFTHISDIAG as 'DiagnosisRecordType' ตัดออก 14/10/68
--,case 
--	when vnd.TYPEOFTHISDIAG = 0 then 'None'
--	when vnd.TYPEOFTHISDIAG = 1 then 'Principal'
--	when vnd.TYPEOFTHISDIAG = 2 then 'Complication'
--	when vnd.TYPEOFTHISDIAG = 3 then 'Metastasis'
--	when vnd.TYPEOFTHISDIAG = 4 then 'Comorbidity'
--end as 'DiagnosisRecordName' --ตัดออก 14/10/68
,case when vnd.TYPEOFTHISDIAG = 1 then vnd.ICDCODE else null end as 'PrimaryDiagnosisCode' 
,case when vnd.TYPEOFTHISDIAG = 1 then icd.THAINAME else null end as 'PrimaryDiagnosisNameTH' 
,case when vnd.TYPEOFTHISDIAG = 1 then icd.ENGLISHNAME else null end as 'PrimaryDiagnosisNameEN'
,vnd.PROCUDUREICDCMCODE1 as 'ICDCmCode1'
,icdcm1.THAINAME as 'ICDCm1NameTH'
,icdcm1.ENGLISHNAME as 'ICDCm1NameEN'
,vnd.PROCUDUREICDCMCODE2 as 'ICDCmCode2'
,icdcm2.THAINAME as 'ICDCm2NameTH'
,icdcm2.ENGLISHNAME as 'ICDCm2NameEN'
,vnd.PROCUDUREICDCMCODE3 as 'ICDCmCode3'
,icdcm3.THAINAME as 'ICDCm3NameTH'
,icdcm3.ENGLISHNAME as 'ICDCm3NameEN'
,vnd.PROCUDUREICDCMCODE4 as 'ICDCmCode4'
,icdcm4.THAINAME as 'ICDCm4NameTH'
,icdcm4.ENGLISHNAME as 'ICDCm4NameEN'
,'' as 'ICDCmCode5'
,'' as 'ICDCm5NameTH'
,'' as 'ICDCm5NameEN'
,'' as 'ICDCmCode6'
,'' as 'ICDCm6NameTH'
,'' as 'ICDCm6NameEN'
,'' as 'ICDCmCode7'
,'' as 'ICDCm7NameTH'
,'' as 'ICDCm7NameEN'
,'' as 'ICDCmCode8'
,'' as 'ICDCm8NameTH'
,'' as 'ICDCm8NameEN'
,'' as 'ICDCmCode9'
,'' as 'ICDCm9NameTH'
,'' as 'ICDCm9NameEN'
,'' as 'ICDCmCode10'
,'' as 'ICDCm10NameTH'
,'' as 'ICDCm10NameEN'
,vnd.ENTRYBYUSERCODE as 'EntryByUserCode' 
,dbo.sysconname(vnd.ENTRYBYUSERCODE,10000,2) as 'EntryByUserNameTH' 
,dbo.sysconname(vnd.ENTRYBYUSERCODE,10000,1) as 'EntryByUserNameEN' 
,vnd.UPDATESTATDATETIME as 'RegisterDate'
,'' as 'ChronicCreteriaCode'
,'' as 'ChronicCreteriaName'
,vnd.REMARKSMEMO as 'RemarksMemo' 
,vnd.ECODE as 'ECode' 
,icde.THAINAME as 'ECodeNameTH' 
,icde.ENGLISHNAME as 'ECodeNameEN' 
,vnd1.ICDCODE as 'ComobidityCode1' 
,dbo.ICDname(vnd1.ICDCODE,2) as 'Comobidity1NameTH' 
,dbo.ICDname(vnd1.ICDCODE,1) as 'Comobidity1NameEN' 
,vnd2.ICDCODE as 'ComobidityCode2' 
,dbo.ICDname(vnd2.ICDCODE,2) as 'Comobidity2NameTH' 
,dbo.ICDname(vnd2.ICDCODE,1) as 'Comobidity2NameEN' 
,vnd3.ICDCODE as 'ComobidityCode3' 
,dbo.ICDname(vnd3.ICDCODE,2) as 'Comobidity3NameTH' 
,dbo.ICDname(vnd3.ICDCODE,1) as 'Comobidity3NameEN'
,vnd4.ICDCODE as 'ComobidityCode4' 
,dbo.ICDname(vnd4.ICDCODE,2) as 'Comobidity4NameTH' 
,dbo.ICDname(vnd4.ICDCODE,1) as 'Comobidity4NameEN' 
,vnd5.ICDCODE as 'ComobidityCode5' 
,dbo.ICDname(vnd5.ICDCODE,2) as 'Comobidity5NameTH' 
,dbo.ICDname(vnd5.ICDCODE,1) as 'Comobidity5NameEN' 
		from VNDIAG vnd
		inner join VNMST vnm on vnd.VN=vnm.VN and vnd.VISITDATE=vnm.VISITDATE
		inner join VNPRES vnp on vnd.VN=vnp.VN and vnd.VISITDATE=vnp.VISITDATE and vnd.SUFFIX=vnp.SUFFIX
		left join ICD_MASTER icd on vnd.ICDCODE=icd.ICDCODE
		left join ICDCM_MASTER icdcm1 on vnd.PROCUDUREICDCMCODE1=icdcm1.ICDCMCODE
		left join ICDCM_MASTER icdcm2 on vnd.PROCUDUREICDCMCODE2=icdcm2.ICDCMCODE
		left join ICDCM_MASTER icdcm3 on vnd.PROCUDUREICDCMCODE3=icdcm3.ICDCMCODE
		left join ICDCM_MASTER icdcm4 on vnd.PROCUDUREICDCMCODE4=icdcm4.ICDCMCODE
		left join ICD_MASTER icde on vnd.ECODE=icde.ICDCODE
		left join (
					select VISITDATE,VN,SUFFIX,SUBSUFFIX,TYPEOFTHISDIAG,ICDCODE
							from VNDIAG
							where TYPEOFTHISDIAG = 4
							and SUBSUFFIX = 1
					)vnd1 on vnd.VN=vnd1.VN and vnd.VISITDATE=vnd1.VISITDATE and vnd.SUFFIX=vnd1.SUFFIX and vnd.TYPEOFTHISDIAG=vnd1.TYPEOFTHISDIAG
		left join (
					select VISITDATE,VN,SUFFIX,SUBSUFFIX,TYPEOFTHISDIAG,ICDCODE
							from VNDIAG
							where TYPEOFTHISDIAG = 4
							and SUBSUFFIX = 2
					)vnd2 on vnd.VN=vnd2.VN and vnd.VISITDATE=vnd2.VISITDATE and vnd.SUFFIX=vnd2.SUFFIX and vnd.TYPEOFTHISDIAG=vnd2.TYPEOFTHISDIAG
		left join (
					select VISITDATE,VN,SUFFIX,SUBSUFFIX,TYPEOFTHISDIAG,ICDCODE
							from VNDIAG
							where TYPEOFTHISDIAG = 4
							and SUBSUFFIX = 3
					)vnd3 on vnd.VN=vnd3.VN and vnd.VISITDATE=vnd3.VISITDATE and vnd.SUFFIX=vnd3.SUFFIX and vnd.TYPEOFTHISDIAG=vnd3.TYPEOFTHISDIAG
		left join (
					select VISITDATE,VN,SUFFIX,SUBSUFFIX,TYPEOFTHISDIAG,ICDCODE
							from VNDIAG
							where TYPEOFTHISDIAG = 4
							and SUBSUFFIX = 4
					)vnd4 on vnd.VN=vnd4.VN and vnd.VISITDATE=vnd4.VISITDATE and vnd.SUFFIX=vnd4.SUFFIX and vnd.TYPEOFTHISDIAG=vnd4.TYPEOFTHISDIAG
		left join (
					select VISITDATE,VN,SUFFIX,SUBSUFFIX,TYPEOFTHISDIAG,ICDCODE
							from VNDIAG
							where TYPEOFTHISDIAG = 4
							and SUBSUFFIX = 5
					)vnd5 on vnd.VN=vnd5.VN and vnd.VISITDATE=vnd5.VISITDATE and vnd.SUFFIX=vnd5.SUFFIX and vnd.TYPEOFTHISDIAG=vnd5.TYPEOFTHISDIAG