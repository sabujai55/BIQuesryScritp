select top 10
		'PLS' as 'BU',
		a.HN as 'PatientID',
		CONVERT(varchar,a.ADMDATETIME,112)+a.AN as 'AdmitID',
		a.ADMDATETIME as 'AdmitDate',
		a.AN as 'AN',
		'' as 'Suffix',
		a.USEDRIGHTCODE as 'RightCode',
		dbo.sysconname(a.USEDRIGHTCODE,20019,2) as 'RightNameTH', --แก้ไขวันที่ 28/02/2568
		dbo.sysconname(a.USEDRIGHTCODE,20019,1) as 'RightNameEN', --เพิ่มวันที่ 28/02/2568
		a.SPONSOR as 'SponsorCode',
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
		a.COMPANYNO as 'CompanyNo',
		dbo.sysconname(a.COMPANYNO,10017,2) as 'CompanyNameTH',
		dbo.sysconname(a.COMPANYNO,10017,1) as 'CompanyNameEN'
				from ADMMASTER a
				left join SSBBACKOFFICE.dbo.ARMASTER b on a.SPONSOR=b.ARCODE
				left join PATIENT_RIGHT c on a.HN=c.HN and a.USEDRIGHTCODE=c.RIGHTCODE