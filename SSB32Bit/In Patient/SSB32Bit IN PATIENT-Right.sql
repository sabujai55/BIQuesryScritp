select 
		'PLS' as 'BU',
		a.HN as 'PatientID',
		CONVERT(varchar,a.ADMDATETIME,112)+a.AN as 'AdmitID',
		a.ADMDATETIME as 'AdmitDateTime',
		a.AN as 'AN',
		ROW_NUMBER() OVER (PARTITION BY c.hn ORDER BY CASE WHEN c.activeforthisadm IS NULL THEN 2 WHEN c.activeforthisadm = 0 THEN 1 ELSE 0 END,c.activeforthisadm ASC) as 'Suffix', --Modify 19/11/2569
		c.RIGHTCODE as 'RightCode', --Modify 19/11/2569
		dbo.sysconname(c.RIGHTCODE,20019,2) as 'RightNameTH', --Modify 19/11/2569
		dbo.sysconname(c.RIGHTCODE,20019,1) as 'RightNameEN', --Modify 19/11/2569
		c.SPONSOR as 'SponsorCode', --Modify 19/11/2569
		dbo.cutsortchar(b.thainame) as 'SponsorNameTH', --แก้ไขวันที่ 28/02/2568
		dbo.cutsortchar(b.englishname) as 'SponsorNameEN' , --เพิ่มวันที่ 28/02/2568
		'' as 'PolicyNo',
		'' as 'LimitAmt',
		c.REF as 'RefNo',
		c.VALIDFROM as 'EffectiveDateTimeFrom',
		c.VALIDTILL as 'EffectiveDateTimeTo',
		c.REMARKS as 'Remark',
		ISNULL(dbo.sysconname(c.MAINHOSPITALCODE,20010,4),dbo.sysconname(c.MAINHOSPITALCODE,20010,4)) as 'HospitalMain', 
		ISNULL(dbo.sysconname(c.SUBHOSPITALCODE,20010,4),dbo.sysconname(c.SUBHOSPITALCODE,20010,4)) as 'HospitalSub',
		c.COMPANYCODE as 'CompanyNo', --Modify 19/11/2569
		dbo.sysconname(c.COMPANYCODE,10017,2) as 'CompanyNameTH', --Modify 19/11/2569
		dbo.sysconname(c.COMPANYCODE,10017,1) as 'CompanyNameEN' --Modify 19/11/2569
				from ADMMASTER a
				left join PATIENT_RIGHT c on a.HN=c.HN --Modify 19/11/2569
				left join SSBBACKOFFICE.dbo.ARMASTER b on c.SPONSOR=b.ARCODE --Modify 19/11/2569
				--where a.ADMDATETIME >= '2026-11-19 12:00'
				--and a.HN = '2540/26753'




