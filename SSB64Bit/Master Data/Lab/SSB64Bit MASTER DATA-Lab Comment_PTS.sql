SELECT 
	 'PTS' as BU
	, lc.Code as LabCode
	, dbo.sysconname(lc.code,42136,2) LabCodeNameTH
	, dbo.sysconname(lc.code,42136,1) LabCodeNameEN
	, b.Gender as Gender --modify 2026-03-17
	, CASE WHEN CONVERT(int,b.Gender)=0 THEN 'None' 
		  WHEN CONVERT(int,b.Gender)=1 THEN 'หญิง'
		  WHEN CONVERT(int,b.Gender)=2 THEN 'ชาย'
		  WHEN CONVERT(int,b.Gender)=3 THEN 'ไม่ระบุเพศ'
	 END GenderNameTH --modify 2026-03-17
	, CASE WHEN CONVERT(int,b.Gender)=0 THEN 'None' 
		  WHEN CONVERT(int,b.Gender)=1 THEN 'Female'
		  WHEN CONVERT(int,b.Gender)=2 THEN 'Male'
		  WHEN CONVERT(int,b.Gender)=3 THEN 'Gender_not_specified'
	 END GenderNameEN --modify 2026-03-17
	--, (cast(cast((Substring(lc.Com,4,1)+Substring(lc.Com,3,1)+Substring(lc.Com,2,1)+Substring(lc.Com,1,1)) as binary(4))as int))/360 As AgeYearFrom
	, '' As AgeYearFrom --modify 2026-03-17
    --, ((cast(cast((Substring(lc.Com,4,1)+Substring(lc.Com,3,1)+Substring(lc.Com,2,1)+Substring(lc.Com,1,1)) as binary(4))as int))%360)/30 As AgeMonthFrom
	, '' As AgeMonthFrom --modify 2026-03-17
    , b.AgeDayFrom As AgeDayFrom --modify 2026-03-17
	--, (cast(cast((Substring(lc.Com,8,1)+Substring(lc.Com,7,1)+Substring(lc.Com,6,1)+Substring(lc.Com,5,1)) as binary(4))as int))/360 As AgeYearTo
	, '' As AgeYearTo --modify 2026-03-17
    --, ((cast(cast((Substring(lc.Com,8,1)+Substring(lc.Com,7,1)+Substring(lc.Com,6,1)+Substring(lc.Com,5,1)) as binary(4))as int))%360)/30 As AgeMonthTo
	, '' As AgeMonthTo --modify 2026-03-17
    , b.AgeDayTo As AgeDayTo --modify 2026-03-17
	, b.ResultValueFrom AS NormalValueFrom --modify 2026-03-17
	, b.ResultValueTo AS NormalValueTo --modify 2026-03-17
	, b.ORResultValueFrom AS OrNormalValueFrom --modify 2026-03-17
	, b.ORResultValueTo AS OrNormalValueTo --modify 2026-03-17
	, b.LabCommentCode as LabCommentCode --modify 2026-03-17
	, dbo.sysconname(b.LabCommentCode,42601,2) as LabCommentNameTH --modify 2026-03-17
	, dbo.sysconname(b.LabCommentCode,42601,1) as LabCommentNameEN --modify 2026-03-17
	, b.LabCommentSelectionCode1 as LabCommentSelection1 --modify 2026-03-17
	, dbo.sysconname(b.LabCommentSelectionCode1,42138,2) as LabCommentSelection1NameTH --modify 2026-03-17
	, dbo.sysconname(b.LabCommentSelectionCode1,42138,1) as LabCommentSelection1NameEN --modify 2026-03-17
	, b.LabCommentSelectionCode2 as LabCommentSelection2 --modify 2026-03-17
	, dbo.sysconname(b.LabCommentSelectionCode2,42138,2) as LabCommentSelection2NameTH --modify 2026-03-17
	, dbo.sysconname(b.LabCommentSelectionCode2,42138,1) as LabCommentSelection2NameEN --modify 2026-03-17
	, b.LabCommentSelectionCode3 as LabCommentSelection3 --modify 2026-03-17
	, dbo.sysconname(b.LabCommentSelectionCode3,42138,2) as LabCommentSelection3NameTH --modify 2026-03-17
	, dbo.sysconname(b.LabCommentSelectionCode3,42138,1) as LabCommentSelection3NameEN --modify 2026-03-17
	, b.LabCommentSelectionCode4 as LabCommentSelection4 --modify 2026-03-17
	, dbo.sysconname(b.LabCommentSelectionCode4,42138,2) as LabCommentSelection4NameTH --modify 2026-03-17
	, dbo.sysconname(b.LabCommentSelectionCode4,42138,1) as LabCommentSelection4NameEN --modify 2026-03-17
	, lc.LocalName as ConclusionResultTH
	, lc.EnglishName as  ConclusionResultEN
	, b.LabCommentCodeAddition1 as  LabCommentAddition1 --modify 2026-03-17
	, dbo.sysconname(b.LabCommentCodeAddition1,42601,2) as  LabCommentAddition1NameTH --modify 2026-03-17
    , dbo.sysconname(b.LabCommentCodeAddition1,42601,1) as  LabCommentAddition1NameEN --modify 2026-03-17
	, b.LabCommentCodeAddition2 as LabCommentAddition2 --modify 2026-03-17
	, dbo.sysconname(b.LabCommentCodeAddition2,42601,2) as LabCommentAddition2NameTH --modify 2026-03-17
    , dbo.sysconname(b.LabCommentCodeAddition2,42601,1) as LabCommentAddition2NameEN --modify 2026-03-17
	, b.LabCommentCodeAddition3 as LabCommentAddition3 --modify 2026-03-17
	, dbo.sysconname(b.LabCommentCodeAddition3,42601,1) as LabCommentAddition3NameTH --modify 2026-03-17
    , dbo.sysconname(b.LabCommentCodeAddition3,42601,2) as LabCommentAddition3NameEN --modify 2026-03-17
	, b.LabCommentCodeAddition4 as LabCommentAddition4 --modify 2026-03-17
	, dbo.sysconname(b.LabCommentCodeAddition4,42601,1) as LabCommentAddition4NameTH --modify 2026-03-17
    , dbo.sysconname(b.LabCommentCodeAddition4,42601,2) as LabCommentAddition4NameEN --modify 2026-03-17
	, b.Doctor1 as Doctor1 --modify 2026-03-17
	, dbo.Doctorname(b.Doctor1,2) as Doctor1NameTH --modify 2026-03-17
	, dbo.Doctorname(b.Doctor1,1) as Doctor1NameEN --modify 2026-03-17
	, b.Doctor2 as Doctor2 --modify 2026-03-17
	, dbo.Doctorname(b.Doctor2,2) as Doctor2NameTH --modify 2026-03-17
	, dbo.Doctorname(b.Doctor2,1) as Doctor2NameEN --modify 2026-03-17
	, b.Doctor3 as Doctor3 --modify 2026-03-17
	, dbo.Doctorname(b.Doctor3,2) as Doctor3NameTH --modify 2026-03-17
	, dbo.Doctorname(b.Doctor3,1) as Doctor3NameEN --modify 2026-03-17
	, b.Doctor4 as Doctor4 --modify 2026-03-17
	, dbo.Doctorname(b.Doctor4,2) as Doctor4NameTH --modify 2026-03-17
	, dbo.Doctorname(b.Doctor4,1) as Doctor4NameEN --modify 2026-03-17
	, b.Doctor5 as Doctor5 --modify 2026-03-17
	, dbo.Doctorname(b.Doctor5,2) as Doctor5NameTH --modify 2026-03-17
	, dbo.Doctorname(b.Doctor5,1) as Doctor5NameEN --modify 2026-03-17
	, b.Doctor6 as Doctor6 --modify 2026-03-17
	, dbo.Doctorname(b.Doctor6,2) as Doctor6NameTH --modify 2026-03-17
	, dbo.Doctorname(b.Doctor6,1) as Doctor6NameEN --modify 2026-03-17
				FROM dnsysconfig_detail lc
				inner join DEVDECRYPT.dbo.PYTS_SETUP_LAB_CODE_DTL_ADDITION_COMMENT b on lc.Code=b.Code and lc.suffix=b.suffix --modify 2026-03-17
				WHERE lc.CtrlCode='60051'
				and lc.AdditionCode='Comment' 
