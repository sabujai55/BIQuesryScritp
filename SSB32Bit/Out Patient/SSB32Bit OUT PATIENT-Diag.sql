select top 1000 
'PLS' as 'BU'
,vnm.HN as 'PatientID'
,convert(varchar,vnd.VISITDATE,112)+convert(varchar,vnd.VN)+convert(varchar,vnd.SUFFIX) as 'VisitID'
,vnd.VISITDATE as 'VisitDate'
,vnd.VN as 'VN'
,vnd.SUFFIX as 'PrescriptionNo'
,vnd.SUBSUFFIX as 'Suffix'
,vnp.CLINIC as 'LocationCode' --แก้ไขวันที่ 27/02/2568
,dbo.sysconname(vnp.CLINIC,20016,2) as 'LocationNameTH' --เพิ่มวันที่ 27/02/2568
,dbo.sysconname(vnp.CLINIC,20016,1) as 'LocationNameEN' --เพิ่มวันที่ 27/02/2568
,vnd.DIAGDATETIME as 'DiagDateTime'
,vnd.TYPEOFTHISDIAG as 'DiagnosisRecordType'
,case 
	when vnd.TYPEOFTHISDIAG = 0 then 'None'
	when vnd.TYPEOFTHISDIAG = 1 then 'Principal'
	when vnd.TYPEOFTHISDIAG = 2 then 'Complication'
	when vnd.TYPEOFTHISDIAG = 3 then 'Metastasis'
	when vnd.TYPEOFTHISDIAG = 4 then 'Comorbidity'
end as 'DiagnosisRecordName' --เพิ่มวันที่ 27/02/2568
,case when vnd.TYPEOFTHISDIAG = 1 then vnd.ICDCODE else null end as 'ICDCode' --แก้ไข 17/02/2568
,case when vnd.TYPEOFTHISDIAG = 1 then isnull(icd.ENGLISHNAME,icd.THAINAME) else null end as 'ICDName' --แก้ไข 17/02/2568
,vnd.PROCUDUREICDCMCODE1 as 'ICDCmCode1'
,ISNULL(icdcm1.ENGLISHNAME,icdcm1.THAINAME) as 'ICDCmName1'
,vnd.PROCUDUREICDCMCODE2 as 'ICDCmCode2'
,ISNULL(icdcm2.ENGLISHNAME,icdcm2.THAINAME) as 'ICDCmName2'
,vnd.PROCUDUREICDCMCODE3 as 'ICDCmCode3'
,ISNULL(icdcm3.ENGLISHNAME,icdcm3.THAINAME) as 'ICDCmName3'
,vnd.PROCUDUREICDCMCODE4 as 'ICDCmCode4'
,ISNULL(icdcm4.ENGLISHNAME,icdcm4.THAINAME) as 'ICDCmName4'
,'' as 'ICDCmCode5'
,'' as 'ICDCmName5'
,'' as 'ICDCmCode6'
,'' as 'ICDCmName6'
,'' as 'ICDCmCode7'
,'' as 'ICDCmName7'
,'' as 'ICDCmCode8'
,'' as 'ICDCmName8'
,'' as 'ICDCmCode9'
,'' as 'ICDCmName9'
,'' as 'ICDCmCode10'
,'' as 'ICDCmName10'
,vnd.ENTRYBYUSERCODE as 'EntryByUserCode' --แก้ไขวันที่ 27/02/2568
,dbo.sysconname(vnd.ENTRYBYUSERCODE,10000,2) as 'EntryByUserNameTH' --เพิ่มวันที่ 27/02/2568
,dbo.sysconname(vnd.ENTRYBYUSERCODE,10000,1) as 'EntryByUserNameEN' --เพิ่มวันที่ 27/02/2568
,vnd.UPDATESTATDATETIME as 'RegisterDate'
,'' as 'ChronicCreteriaCode'
,'' as 'ChronicCreteriaName'
,vnd.REMARKSMEMO as 'RemarksMemo' --เพิ่มวันที่ 17/02/2568
,vnd.ECODE as 'ECode' --เพิ่มวันที่ 17/02/2568
,icde.ENGLISHNAME as 'ECodeName' --เพิ่มวันที่ 17/02/2568
,vnd1.ICDCODE as 'ComobidityCode1' --เพิ่มวันที่ 17/02/2568
,dbo.ICDname(vnd1.ICDCODE,4) as 'ComobidityName1' --เพิ่มวันที่ 17/02/2568
,vnd2.ICDCODE as 'ComobidityCode2' --เพิ่มวันที่ 17/02/2568
,dbo.ICDname(vnd2.ICDCODE,4) as 'ComobidityName2' --เพิ่มวันที่ 17/02/2568
,vnd3.ICDCODE as 'ComobidityCode3' --เพิ่มวันที่ 17/02/2568
,dbo.ICDname(vnd3.ICDCODE,4) as 'ComobidityName3' --เพิ่มวันที่ 17/02/2568
,vnd4.ICDCODE as 'ComobidityCode4' --เพิ่มวันที่ 17/02/2568
,dbo.ICDname(vnd4.ICDCODE,4) as 'ComobidityName4' --เพิ่มวันที่ 17/02/2568
,vnd5.ICDCODE as 'ComobidityCode5' --เพิ่มวันที่ 17/02/2568
,dbo.ICDname(vnd5.ICDCODE,4) as 'ComobidityName5' --เพิ่มวันที่ 17/02/2568
		from VNDIAG vnd
		left join VNMST vnm on vnd.VN=vnm.VN and vnd.VISITDATE=vnm.VISITDATE
		left join VNPRES vnp on vnd.VN=vnp.VN and vnd.VISITDATE=vnp.VISITDATE and vnd.SUFFIX=vnp.SUFFIX
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