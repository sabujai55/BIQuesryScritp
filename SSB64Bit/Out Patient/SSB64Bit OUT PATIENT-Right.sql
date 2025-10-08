select top 10
'PT2' as 'BU'
,convert(varchar,vnr.VISITDATE,112)+convert(varchar,vnr.VN)+convert(varchar,vnr.PrescriptionNo) as 'VisitID'
,vnm.HN as 'HN'
,vnr.VISITDATE as 'VisitDate'
,vnr.VN as 'VN'
,vnr.PrescriptionNo as 'PrescriptionNo'
,vnr.RightCode as 'RightCode'
,dbo.sysconname(vnr.RIGHTCODE,42086,2) as 'RightNameTH' --แก้ไขวันที่ 26/02/2568
,dbo.sysconname(vnr.RIGHTCODE,42086,1) as 'RightNameEN' --เพิ่ม 26/02/2568
,vnr.ARCode as 'SponsorCode'
,substring(ar.LocalName,2,500)  as 'SponsorNameTH' --แก้ไขวันที่ 26/02/2568
,substring(ar.ENGLISHNAME,2,500) as 'SponsorNameEN' --เพิ่ม 26/02/2568
,vnr.PolicyNo as 'PolicyNo'
,ptr.LimitAmt as 'LimitAmt'
,vnr.RefRightKeyNo as 'RefNo'
,ptr.VALIDFROM as 'EffectiveDateTimeFrom'
,ptr.VALIDTILL as 'EffectiveDateTimeTo'
,vnr.REMARKS as 'Remark'
,ISNULL(dbo.sysconname(vnr.MainHospital,42025,4),dbo.sysconname(vnr.MainHospital,42025,4)) as 'HospitalMain'  
,ISNULL(dbo.sysconname(vnr.SubHospital,42025,4),dbo.sysconname(vnr.SubHospital,42025,4)) as 'HospitalSub'
,vnm.CompanyCode as 'CompanyNo' --เพิ่มวันที่ 17/02/2568
,dbo.sysconname(vnm.CompanyCode,10167,2) as 'CompanyNameTH' --เพิ่มวันที่ 26/02/2568
,dbo.sysconname(vnm.CompanyCode,10167,1) as 'CompanyNameEN' --เพิ่มวันที่ 26/02/2568
		from HNOPD_PRESCRIP_RIGHT vnr
		left join HNOPD_MASTER vnm on vnr.VN=vnm.VN and vnr.VisitDate=vnm.VisitDate
		left join HNPAT_RIGHT ptr on vnm.HN=ptr.HN and vnr.RightCode=ptr.RightCode and vnr.ARCode=ptr.ARCode
		left join ARMASTER ar on ptr.ARCode=ar.ARCode
