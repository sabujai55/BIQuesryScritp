select top 10
		  'PT2' as 'BU'
		, a.HN as 'PatientID'
		, a.VisitDate as 'Date'
		, a.VN as 'VN/AN'
		, b.Doctor as 'DoctorCode'
		, dbo.Doctorname(b.Doctor,2) as 'DoctorNameTH'
		, dbo.Doctorname(b.Doctor,1) as 'DoctorNameEN'
		, 'ReferOut' as 'Refer'
		, a.RefToCode as 'ReferType'
		, dbo.sysconname(a.RefToCode,42266,2) as 'ReferTypeNameTH'
		, dbo.sysconname(a.RefToCode,42266,1) as 'ReferTypeNameEN'
		, a.RefToHospital as 'ReferHospital'
		, dbo.sysconname(a.RefToHospital,42025,2) as 'ReferHospitalNameTH'
		, dbo.sysconname(a.RefToHospital,42025,1) as 'ReferHospitalNameEN'
		, b.RemarksMemo as 'Remarks'
		, c.ICDCode as 'Diag'
		, dbo.CutSortChar(d.LocalName) as 'DiagNameTH'
		, dbo.CutSortChar(d.EnglishName) as 'DiagNameEN'
				from HNOPD_MASTER a
				inner join HNOPD_PRESCRIP b on a.VN=b.VN and a.VisitDate=b.VisitDate and a.RefToCode is not null
				left join HNOPD_PRESCRIP_DIAG c on a.VN=c.VN and a.VisitDate=c.VisitDate and c.DiagnosisRecordType = 1
				left join HNICD_MASTER d on c.ICDCode=d.IcdCode
Union All
select top 10
		  'PT2' as 'BU'
		, a.HN as 'PatientID'
		, a.VisitDate as 'Date'
		, a.VN as 'VN/AN'
		, b.Doctor as 'DoctorCode'
		, dbo.Doctorname(b.Doctor,2) as 'DoctorNameTH'
		, dbo.Doctorname(b.Doctor,1) as 'DoctorNameEN'
		, 'ReferIn' as 'Refer'
		, a.RefFromCode as 'ReferType'
		, dbo.sysconname(a.RefFromCode,42266,2) as 'ReferTypeNameTH'
		, dbo.sysconname(a.RefFromCode,42266,1) as 'ReferTypeNameEN'
		, a.RefFromHospital as 'ReferHospital'
		, dbo.sysconname(a.RefFromHospital,42025,2) as 'ReferHospitalNameTH'
		, dbo.sysconname(a.RefFromHospital,42025,1) as 'ReferHospitalNameEN'
		, b.RemarksMemo as 'Remarks'
		, c.ICDCode as 'Diag'
		, dbo.CutSortChar(d.LocalName) as 'DiagNameTH'
		, dbo.CutSortChar(d.EnglishName) as 'DiagNameEN'
				from HNOPD_MASTER a
				inner join HNOPD_PRESCRIP b on a.VN=b.VN and a.VisitDate=b.VisitDate and a.RefFromCode is not null
				left join HNOPD_PRESCRIP_DIAG c on a.VN=c.VN and a.VisitDate=c.VisitDate and c.DiagnosisRecordType = 1
				left join HNICD_MASTER d on c.ICDCode=d.IcdCode
Union All
select top 10
		  'PT2' as 'BU'
		, a.HN as 'PatientID'
		, a.AdmDateTime as 'Date'
		, a.AN as 'VN/AN'
		, a.AdmDoctor as 'DoctorCode'
		, dbo.Doctorname(a.AdmDoctor,2) as 'DoctorNameTH'
		, dbo.Doctorname(a.AdmDoctor,1) as 'DoctorNameEN'
		, 'ReferIn' as 'Refer'
		, a.RefFromCode as 'ReferType'
		, dbo.sysconname(a.RefFromCode,42266,2) as 'ReferTypeNameTH'
		, dbo.sysconname(a.RefFromCode,42266,1) as 'ReferTypeNameEN'
		, a.RefFromHospital as 'ReferHospital'
		, dbo.sysconname(a.RefFromHospital,42025,2) as 'ReferHospitalNameTH'
		, dbo.sysconname(a.RefFromHospital,42025,1) as 'ReferHospitalNameEN'
		, '' as 'Remarks'
		, b.ICDCode
		, dbo.CutSortChar(c.LocalName) as 'DiagNameTH'
		, dbo.CutSortChar(c.EnglishName) as 'DiagNameEN'
				from HNIPD_MASTER a
				left join HNIPD_DIAG b on a.AN=b.AN and b.SuffixTiny = 1
				left join HNICD_MASTER c on b.ICDCode=c.IcdCode
				where a.RefFromCode is not null
Union All
select top 10
		  'PT2' as 'BU'
		, a.HN as 'PatientID'
		, a.AdmDateTime as 'Date'
		, a.AN as 'VN/AN'
		, a.AdmDoctor as 'DoctorCode'
		, dbo.Doctorname(a.AdmDoctor,2) as 'DoctorNameTH'
		, dbo.Doctorname(a.AdmDoctor,1) as 'DoctorNameEN'
		, 'ReferOut' as 'Refer'
		, a.RefToCode as 'ReferType'
		, dbo.sysconname(a.RefToCode,42266,2) as 'ReferTypeNameTH'
		, dbo.sysconname(a.RefToCode,42266,1) as 'ReferTypeNameEN'
		, a.RefToHospital as 'ReferHospital'
		, dbo.sysconname(a.RefToHospital,42025,2) as 'ReferHospitalNameTH'
		, dbo.sysconname(a.RefToHospital,42025,1) as 'ReferHospitalNameEN'
		, '' as 'Remarks'
		, b.ICDCode
		, dbo.CutSortChar(c.LocalName) as 'DiagNameTH'
		, dbo.CutSortChar(c.EnglishName) as 'DiagNameEN'
				from HNIPD_MASTER a
				left join HNIPD_DIAG b on a.AN=b.AN and b.SuffixTiny = 1
				left join HNICD_MASTER c on b.ICDCode=c.IcdCode
				where a.RefToCode is not null