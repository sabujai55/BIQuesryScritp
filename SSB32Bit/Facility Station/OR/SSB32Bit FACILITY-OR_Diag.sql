select top 1000
		  'PLS' as 'BU'
		, orr.HN as 'PatientID'
		, ord.FacilityRmsNo as 'FacilityRmsNo'
		, ord.RequestNo as 'RequestNo'
		, ord.Suffix as 'SuffixTiny'
		, ord.IcdCode as 'ICDCode1'
		, icd1.ThaiName as 'ICDNameTH1'
		, icd1.EnglishName as 'ICDNameEN1'
		, ord.IcdCode2 as 'ICDCode2'
		, icd2.ThaiName as 'ICDNameTH2'
		, icd2.EnglishName as 'ICDNameEN2'
		, ord.Organ as 'OrganCode'
		, dbo.sysconname(ord.ORGAN,20053,2) as 'OrganNameTH'
		, dbo.sysconname(ord.ORGAN,20053,1) as 'OrganNameEN'
		, ord.DOCTOR as 'Doctor'
		, dbo.CutSortChar(doc.THAINAME) as 'DoctorNameTH'
		, dbo.CutSortChar(doc.ENGLISHNAME) as 'DoctorNameEN'
		, ord.PROCUDUREICDCMCODE1 as 'ICDCmCode1'
		, icdcm1.THAINAME as 'ICDCMNameTH1'
		, icdcm1.ENGLISHNAME as 'ICDCMNameEN1'
		, ord.PROCUDUREICDCMCODE2 as 'ICDCmCode2'
		, icdcm2.THAINAME as 'ICDCMNameTH2'
		, icdcm2.ENGLISHNAME as 'ICDCMNameEN2'
		, ord.PROCUDUREICDCMCODE3 as 'ICDCmCode3'
		, icdcm3.THAINAME as 'ICDCMNameTH3'
		, icdcm3.ENGLISHNAME as 'ICDCMNameEN3'
		, ord.PROCUDUREICDCMCODE4 as 'ICDCmCode4'
		, icdcm4.THAINAME as 'ICDCMNameTH4'
		, icdcm4.ENGLISHNAME as 'ICDCMNameEN4'
		, '' as 'ORSpecialty'
		, '' as 'ORSpecialtyNameTH'
		, '' as 'ORSpecialtyNameEN'
		, '' as 'HNOREndoscopeType'
		, ord.CONFIRMDOCTORDATETIME as 'ConfirmDoctorDateTime'
		, ord.DIAGDATETIME as 'DiagDateTime'
		, ord.OPERATIONSTARTDATETIME as 'ORStartDateTime'
		, ord.OPERATIONFINISHDATETIME as 'ORFinishDateTime'
		, '' as 'HNWoundType'
		, ord.DIAGNOSISMEMO as 'Memo'
				from ORREQ orr
				inner join ORDIAG ord on orr.RequestNo=ord.RequestNo and orr.FacilityRmsNo=ord.FacilityRmsNo
				left join ICD_MASTER icd1 on ord.IcdCode=icd1.IcdCode
				left join ICD_MASTER icd2 on ord.IcdCode2=icd2.IcdCode
				left join HNDOCTOR doc on ord.DOCTOR=doc.DOCTOR
				left join ICDCM_MASTER icdcm1 on ord.PROCUDUREICDCMCODE1 = icdcm1.ICDCMCODE
				left join ICDCM_MASTER icdcm2 on ord.PROCUDUREICDCMCODE2 = icdcm2.ICDCMCODE
				left join ICDCM_MASTER icdcm3 on ord.PROCUDUREICDCMCODE3 = icdcm3.ICDCMCODE
				left join ICDCM_MASTER icdcm4 on ord.PROCUDUREICDCMCODE4 = icdcm4.ICDCMCODE
				where ord.Organ is not null