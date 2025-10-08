select top 10
		 'PLS' as 'BU'
		, a.DOCTOR as 'Doctor'
		, dbo.CutSortChar(a.ENGLISHNAME) as 'EnglishName'
		, dbo.CutSortChar(a.THAINAME) as 'ThaiName'
		, a.SPECIALTY as 'Specialty'
		, dbo.sysconname(a.SPECIALTY,20014,2) as 'SpecialtyNameTH'
		, dbo.sysconname(a.SPECIALTY,20014,1) as 'SpecialtyNameEN'
		, a.SUBSPECIALTY as 'SubSpecialty'
		, dbo.CutSortChar(sbp.THAINAME) as 'SubSpecialtyNameTH'
		, dbo.CutSortChar(sbp.ENGLISHNAME) as 'SubSpecialtyNameEN'
		, '' as 'SpecialtyGroup'
		, '' as 'SpecialtyGroupNameTH'
		, '' as 'SpecialtyGroupNameEN'
		, a.CLINIC as 'ClinicCode'
		, dbo.sysconname(a.CLINIC,20016,2) as 'ClinicNameTH'
		, dbo.sysconname(a.CLINIC,20016,1) as 'ClinicNameEN'
		, '' as 'ComposeDept'
		, '' as 'ComposeDeptNameTH'
		, '' as 'ComposeDeptNameEN'
		, '' as 'ClusterCode'
		, '' as 'ClusterNameTH'
		, '' as 'ClusterNameEN'
		, '' as 'DeptCode'
		, '' as 'DeptNameTH'
		, '' as 'DeptNameEN'
		, case
			when a.OFFDOCTOR = '1' then '0'
			when a.OFFDOCTOR = '0' then '1'
		end as 'Active'
				from HNDOCTOR a
				left join SYSCONFIG sbp on a.SPECIALTY=LEFT(sbp.CODE,CHARINDEX(' ',CODE)-1) and a.SUBSPECIALTY=RIGHT(sbp.CODE,CHARINDEX(' ',CODE)-1) and sbp.CTRLCODE = 20015





