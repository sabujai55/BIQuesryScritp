select top 10
'PLS' as 'BU'
,convert(varchar,vnp.VISITDATE,112)+convert(varchar,vnp.VN)+convert(varchar,vnp.SUFFIX) as 'VisitID'
,vnm.HN 
,vnp.VISITDATE as 'VisitDate'
,vnp.VN as 'VN'
,vnp.SUFFIX as 'PrescriptionNo'
,vnp.RIGHTCODE as 'RightCode'
,dbo.sysconname(vnp.RIGHTCODE,20019,2) as 'RightNameTH' --แก้ไขวันที่ 26/02/2568
,dbo.sysconname(vnp.RIGHTCODE,20019,1) as 'RightNameEN' --เพิ่มวันที่ 26/02/2568
,isnull(vnp.SPONSOR,'') as 'SponsorCode'
,substring(ar.THAINAME,2,500) as 'SponsorNameTH' --แก้ไขวันที่ 26/02/2568
,substring(ar.ENGLISHNAME,2,500) as 'SponsorNameEN' --เพิ่มวันที่ 26/02/2568
,'' as 'PolicyNo'
,'' as 'LimitAmt'
,isnull(ptr.REF ,'')as 'RefNo'
,isnull(ptr.VALIDFROM,'') as 'EffectiveDateTimeFrom'
,isnull(ptr.VALIDTILL,'') as 'EffectiveDateTimeTo'
,isnull(ptr.REMARKS,'') as 'Remark'
,ISNULL(dbo.sysconname(ptr.MAINHOSPITALCODE,20010,4),dbo.sysconname(ptr.MAINHOSPITALCODE,20010,4)) as 'HospitalMain'  
,ISNULL(dbo.sysconname(ptr.SUBHOSPITALCODE,20010,4),dbo.sysconname(ptr.SUBHOSPITALCODE,20010,4)) as 'HospitalSub'
,vnm.COMPANYNO as 'CompanyNo' --เพิ่มวันที่ 17/02/2568
,dbo.sysconname(vnm.COMPANYNO,10017,2) as 'CompanyNameTH' --เพิ่มวันที่ 26/02/2568
,dbo.sysconname(vnm.COMPANYNO,10017,1) as 'CompanyNameEN' --เพิ่มวันที่ 26/02/2568
			from VNPRES vnp
			left join VNMST vnm on vnp.VISITDATE=vnm.VISITDATE and vnp.VN=vnm.VN
			left join PATIENT_RIGHT ptr on vnm.HN=ptr.HN and vnp.RIGHTCODE=ptr.RIGHTCODE
			left join SSBBACKOFFICE.dbo.ARMASTER ar on vnp.SPONSOR=ar.ARCODE
