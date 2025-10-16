select top 1000
		  'PLS' as 'BU'
		, orr.HN as 'PatientID'
		, orp.FacilityRmsNo as 'FacilityRmsNo'
		, orp.RequestNo as 'RequestNo'
		, orp.Suffix as 'SuffixTiny'
		, '' as 'HNORPersonType'
		, orp.Doctor as 'Doctor'
		, dbo.CutSortChar(doc.ThaiName) as 'DoctorNameTH'
		, dbo.CutSortChar(doc.EnglishName) as 'DoctorNameEN'
		, doc.CERTIFYPUBLICNO as 'DoctorCertificate'
		, doc.CLINIC as 'DoctorClinicCode'
		, dbo.sysconname(doc.CLINIC,20016,2) as 'DoctorClinicNameTH'
		, dbo.sysconname(doc.CLINIC,20016,1) as 'DoctorClinicNameEN'
		, '' as 'DoctorDepartmentCode'
		, '' as 'DoctorDepartmentNameTH'
		, '' as 'DoctorDepartmentNameEN'
		, doc.SPECIALTY+doc.SUBSPECIALTY as 'DoctorSpecialtyCode'
		, dbo.CutSortChar(ssp.THAINAME) as 'DoctorSpecialtyNameTH'
		, dbo.CutSortChar(ssp.ENGLISHNAME) as 'DoctorSpecialtyNameEN'
		, orp.NurseCode as 'NurseCode'
		, dbo.CutSortChar(nur.THAINAME) as 'NurseNameTH'
		, dbo.CutSortChar(nur.EnglishName) as 'NurseNameEN'
		, orp.MEMO as 'Remarks'
				from ORREQ orr
				inner join ORPERSON orp on orr.RequestNo=orp.RequestNo and orr.FacilityRmsNo=orp.FacilityRmsNo
				left join HNDOCTOR doc on orp.Doctor=doc.Doctor
				left join SYSCONFIG ssp on doc.SPECIALTY+doc.SUBSPECIALTY = REPLACE(ssp.CODE,' ','') and ssp.CTRLCODE = 20015
				left join HNDOCTOR nur on orp.NURSECODE=nur.DOCTOR
