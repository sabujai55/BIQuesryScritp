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
		, orp.NurseCode as 'NurseCode'
		, dbo.CutSortChar(nur.THAINAME) as 'NurseNameTH'
		, dbo.CutSortChar(nur.EnglishName) as 'NurseNameEN'
		, orp.MEMO as 'Remarks'
				from ORREQ orr
				inner join ORPERSON orp on orr.RequestNo=orp.RequestNo and orr.FacilityRmsNo=orp.FacilityRmsNo
				left join HNDOCTOR doc on orp.Doctor=doc.Doctor
				left join HNDOCTOR nur on orp.NURSECODE=nur.DOCTOR
				order by orr.ENTRYDATETIME desc
