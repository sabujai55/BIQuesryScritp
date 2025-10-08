select top 10 
	 'PT2' as 'BU',
	 a.HN as 'PatientID',
	 CONVERT(varchar,a.AdmDateTime,112)+a.AN as 'AdmitID',
	 a.AdmDateTime as 'AdmitDate',
	 a.AN as 'AN',
	 b.SuffixTiny as 'Suffix',
	 b.RightCode as 'RightCode',
	 dbo.sysconname(b.RIGHTCODE,42086,2) as 'RightNameTH', --แก้ไขวันที่ 28/02/2568
	 dbo.sysconname(b.RIGHTCODE,42086,1) as 'RightNameEN', --เพิ่มวันที่ 28/02/2568
	 b.ARCode as 'SponsorCode',
	 substring(ar.LocalName,2,500)  as 'SponsorNameTH', --แก้ไขวันที่ 28/02/2568
	 substring(ar.ENGLISHNAME,2,500) as 'SponsorNameEN', --เพิ่มวันที่ 28/02/2568
	 b.PolicyNo as 'PolicyNo',
	 c.LimitAmt as 'LimitAmt',
	 b.RefRightKeyNo as 'RefNo',
	 c.ValidFrom as 'EffectiveDateTimeFrom',
	 c.ValidTill as 'EffectiveDateTimeTo',
	 b.Remarks as 'Remark',
	 ISNULL(dbo.sysconname(b.MainHospital,42025,4),dbo.sysconname(b.MainHospital,42025,4)) as 'HospitalMain',
	 ISNULL(dbo.sysconname(b.SubHospital,42025,4),dbo.sysconname(b.SubHospital,42025,4)) as 'HospitalSub',
	 a.CompanyCode as 'CompanyNo', --เพิ่มวันที่ 28/02/2568
	 dbo.sysconname(a.CompanyCode,10167,2) as 'CompanyNameTH', --เพิ่มวันที่ 28/02/2568
	 dbo.sysconname(a.CompanyCode,10167,1) as 'CompanyNameEN' --เพิ่มวันที่ 28/02/2568
			from HNIPD_MASTER a
			left join HNIPD_RIGHT b on a.AN=b.AN
			left join ARMASTER ar on b.ARCode=ar.ARCode
			left join HNPAT_RIGHT c on b.RightCode=c.RightCode and b.ARCode=c.ARCode and a.HN=c.HN