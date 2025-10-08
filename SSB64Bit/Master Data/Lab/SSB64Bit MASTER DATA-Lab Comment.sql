SELECT 
	 'PT2' as BU
	, Code as LabCode
	, dbo.sysconname(code,42136,2) LabCodeNameTH
	, dbo.sysconname(code,42136,1) LabCodeNameEN
	, CONVERT(int, SUBSTRING(lc.Com, 25, 1)) as Gender
	, CASE WHEN CONVERT(int, SUBSTRING(lc.Com, 25, 1))=0 THEN 'None' 
		  WHEN CONVERT(int, SUBSTRING(lc.Com, 25, 1))=1 THEN 'หญิง'
		  WHEN CONVERT(int, SUBSTRING(lc.Com, 25, 1))=2 THEN 'ชาย'
		  WHEN CONVERT(int, SUBSTRING(lc.Com, 25, 1))=3 THEN 'ไม่ระบุเพศ'
	 END GenderNameTH
	, CASE WHEN CONVERT(int, SUBSTRING(lc.Com, 25, 1))=0 THEN 'None' 
		  WHEN CONVERT(int, SUBSTRING(lc.Com, 25, 1))=1 THEN 'Female'
		  WHEN CONVERT(int, SUBSTRING(lc.Com, 25, 1))=2 THEN 'Male'
		  WHEN CONVERT(int, SUBSTRING(lc.Com, 25, 1))=3 THEN 'Gender_not_specified'
	 END GenderNameEN
	, (cast(cast((Substring(lc.Com,4,1)+Substring(lc.Com,3,1)+Substring(lc.Com,2,1)+Substring(lc.Com,1,1)) as binary(4))as int))/360 As AgeYearFrom
    , ((cast(cast((Substring(lc.Com,4,1)+Substring(lc.Com,3,1)+Substring(lc.Com,2,1)+Substring(lc.Com,1,1)) as binary(4))as int))%360)/30 As AgeMonthFrom
    , (((cast(cast((Substring(lc.Com,4,1)+Substring(lc.Com,3,1)+Substring(lc.Com,2,1)+Substring(lc.Com,1,1)) as binary(4))as int))%360)%30) As AgeDayFrom
	, (cast(cast((Substring(lc.Com,8,1)+Substring(lc.Com,7,1)+Substring(lc.Com,6,1)+Substring(lc.Com,5,1)) as binary(4))as int))/360 As AgeYearTo
    , ((cast(cast((Substring(lc.Com,8,1)+Substring(lc.Com,7,1)+Substring(lc.Com,6,1)+Substring(lc.Com,5,1)) as binary(4))as int))%360)/30 As AgeMonthTo
    , (((cast(cast((Substring(lc.Com,8,1)+Substring(lc.Com,7,1)+Substring(lc.Com,6,1)+Substring(lc.Com,5,1)) as binary(4))as int))%360)%30) As AgeDayTo
	, SIGN(CAST(SUBSTRING(lc.Com, 16 - 0, 1) + SUBSTRING(lc.Com, 16 - 1, 1) + SUBSTRING(lc.Com, 16 - 2, 1) + SUBSTRING(lc.Com, 16 - 3, 1) + SUBSTRING(lc.Com, 16 - 4, 1) + SUBSTRING(lc.Com, 16 - 5, 1) + SUBSTRING(lc.Com, 16 - 6, 1) + SUBSTRING(lc.Com,16 - 7, 1) AS BIGINT)) 
		 * (1.0 + (CAST(SUBSTRING(lc.Com, 16 - 0, 1) + SUBSTRING(lc.Com, 16 - 1, 1) + SUBSTRING(lc.Com, 16 - 2, 1) + SUBSTRING(lc.Com, 16 - 3,1) + SUBSTRING(lc.Com, 16 - 4, 1) + SUBSTRING(lc.Com, 16 - 5, 1) + SUBSTRING(lc.Com, 16 - 6, 1) + SUBSTRING(lc.Com, 16 - 7, 1) AS BIGINT) & 0x000FFFFFFFFFFFFF) 
		 * POWER(CAST(2 AS FLOAT), - 52)) * POWER(CAST(2 AS FLOAT), (CAST(SUBSTRING(lc.Com, 16 - 0, 1) + SUBSTRING(lc.Com, 16 - 1, 1) + SUBSTRING(lc.Com, 16 - 2, 1) + SUBSTRING(lc.Com, 16 - 3, 1) + SUBSTRING(lc.Com, 16 - 4, 1) + SUBSTRING(lc.Com, 16 - 5, 1) + SUBSTRING(lc.Com,16 - 6, 1) + SUBSTRING(lc.Com, 16 - 7, 1) AS BIGINT) & 0x7ff0000000000000) / 0x0010000000000000 - 1023) AS NormalValueFrom
	, SIGN(CAST(SUBSTRING(lc.Com, 24 - 0, 1) + SUBSTRING(lc.Com, 24 - 1, 1) + SUBSTRING(lc.Com, 24 - 2, 1) + SUBSTRING(lc.Com, 24 - 3, 1) + SUBSTRING(lc.Com, 24 - 4, 1) + SUBSTRING(lc.Com, 24 - 5, 1) + SUBSTRING(lc.Com, 24 - 6, 1) + SUBSTRING(lc.Com,24 - 7, 1) AS BIGINT)) 
		 * (1.0 + (CAST(SUBSTRING(lc.Com, 24 - 0, 1) + SUBSTRING(lc.Com, 24 - 1, 1) + SUBSTRING(lc.Com, 24 - 2, 1) + SUBSTRING(lc.Com, 24 - 3,1) + SUBSTRING(lc.Com, 24 - 4, 1) + SUBSTRING(lc.Com, 24 - 5, 1) + SUBSTRING(lc.Com, 24 - 6, 1) + SUBSTRING(lc.Com, 24 - 7, 1) AS BIGINT) & 0x000FFFFFFFFFFFFF) 
		 * POWER(CAST(2 AS FLOAT), - 52)) * POWER(CAST(2 AS FLOAT), (CAST(SUBSTRING(lc.Com, 24 - 0, 1) + SUBSTRING(lc.Com, 24 - 1, 1) + SUBSTRING(lc.Com, 24 - 2, 1) + SUBSTRING(lc.Com, 24 - 3, 1) + SUBSTRING(lc.Com, 24 - 4, 1) + SUBSTRING(lc.Com, 24 - 5, 1) + SUBSTRING(lc.Com,24 - 6, 1) + SUBSTRING(lc.Com, 24 - 7, 1) AS BIGINT) & 0x7ff0000000000000) / 0x0010000000000000 - 1023) AS NormalValueTo
	, SIGN(CAST(SUBSTRING(lc.Com, 56 - 0, 1) + SUBSTRING(lc.Com, 56 - 1, 1) + SUBSTRING(lc.Com, 56 - 2, 1) + SUBSTRING(lc.Com, 56 - 3, 1) + SUBSTRING(lc.Com, 56 - 4, 1) + SUBSTRING(lc.Com, 56 - 5, 1) + SUBSTRING(lc.Com, 56 - 6, 1) + SUBSTRING(lc.Com,56 - 7, 1) AS BIGINT)) 
		 * (1.0 + (CAST(SUBSTRING(lc.Com, 56 - 0, 1) + SUBSTRING(lc.Com, 56 - 1, 1) + SUBSTRING(lc.Com, 56 - 2, 1) + SUBSTRING(lc.Com, 56 - 3,1) + SUBSTRING(lc.Com, 56 - 4, 1) + SUBSTRING(lc.Com, 56 - 5, 1) + SUBSTRING(lc.Com, 56 - 6, 1) + SUBSTRING(lc.Com, 56 - 7, 1) AS BIGINT) & 0x000FFFFFFFFFFFFF) 
		 * POWER(CAST(2 AS FLOAT), - 52)) * POWER(CAST(2 AS FLOAT), (CAST(SUBSTRING(lc.Com, 56 - 0, 1) + SUBSTRING(lc.Com, 56 - 1, 1) + SUBSTRING(lc.Com, 56 - 2, 1) + SUBSTRING(lc.Com, 56 - 3, 1) + SUBSTRING(lc.Com, 56 - 4, 1) + SUBSTRING(lc.Com, 56 - 5, 1) + SUBSTRING(lc.Com,56 - 6, 1) + SUBSTRING(lc.Com, 56 - 7, 1) AS BIGINT) & 0x7ff0000000000000) / 0x0010000000000000 - 1023) AS OrNormalValueFrom
	, SIGN(CAST(SUBSTRING(lc.Com, 64 - 0, 1) + SUBSTRING(lc.Com, 64 - 1, 1) + SUBSTRING(lc.Com, 64 - 2, 1) + SUBSTRING(lc.Com, 64 - 3, 1) + SUBSTRING(lc.Com, 64 - 4, 1) + SUBSTRING(lc.Com, 64 - 5, 1) + SUBSTRING(lc.Com, 64 - 6, 1) + SUBSTRING(lc.Com,64 - 7, 1) AS BIGINT)) 
		 * (1.0 + (CAST(SUBSTRING(lc.Com, 64 - 0, 1) + SUBSTRING(lc.Com, 64 - 1, 1) + SUBSTRING(lc.Com, 64 - 2, 1) + SUBSTRING(lc.Com, 64 - 3,1) + SUBSTRING(lc.Com, 64 - 4, 1) + SUBSTRING(lc.Com, 64 - 5, 1) + SUBSTRING(lc.Com, 64 - 6, 1) + SUBSTRING(lc.Com, 64 - 7, 1) AS BIGINT) & 0x000FFFFFFFFFFFFF) 
		 * POWER(CAST(2 AS FLOAT), - 52)) * POWER(CAST(2 AS FLOAT), (CAST(SUBSTRING(lc.Com, 64 - 0, 1) + SUBSTRING(lc.Com, 64 - 1, 1) + SUBSTRING(lc.Com, 64 - 2, 1) + SUBSTRING(lc.Com, 64 - 3, 1) + SUBSTRING(lc.Com, 64 - 4, 1) + SUBSTRING(lc.Com, 64 - 5, 1) + SUBSTRING(lc.Com,64 - 6, 1) + SUBSTRING(lc.Com, 64 - 7, 1) AS BIGINT) & 0x7ff0000000000000) / 0x0010000000000000 - 1023) AS OrNormalValueTo
	, CAST(SUBSTRING(lc.com,26,9)as varchar) as LabCommentCode
	, dbo.sysconname(CAST(SUBSTRING(lc.com,26,9)as varchar),42601,2) as LabCommentNameTH
	, dbo.sysconname(CAST(SUBSTRING(lc.com,26,9)as varchar),42601,1) as LabCommentNameEN
	, CAST(SUBSTRING(lc.Com,105,5)as varchar) as LabCommentSelection1
	, dbo.sysconname(CAST(SUBSTRING(lc.Com,105,5)as varchar),42138,2) as LabCommentSelection1NameTH
	, dbo.sysconname(CAST(SUBSTRING(lc.Com,105,5)as varchar),42138,1) as LabCommentSelection1NameEN
	, CAST(SUBSTRING(lc.Com,111,5)as varchar) as LabCommentSelection2
	, dbo.sysconname(CAST(SUBSTRING(lc.Com,111,5)as varchar),42138,2) as LabCommentSelection2NameTH
	, dbo.sysconname(CAST(SUBSTRING(lc.Com,111,5)as varchar),42138,1) as LabCommentSelection2NameEN
	, CAST(SUBSTRING(lc.Com,117,5)as varchar) as LabCommentSelection3
	, dbo.sysconname(CAST(SUBSTRING(lc.Com,117,5)as varchar),42138,2) as LabCommentSelection3NameTH
	, dbo.sysconname(CAST(SUBSTRING(lc.Com,117,5)as varchar),42138,1) as LabCommentSelection3NameEN
	, CAST(SUBSTRING(lc.Com,123,5)as varchar) as LabCommentSelection4
	, dbo.sysconname(CAST(SUBSTRING(lc.Com,123,5)as varchar),42138,2) as LabCommentSelection4NameTH
	, dbo.sysconname(CAST(SUBSTRING(lc.Com,123,5)as varchar),42138,1) as LabCommentSelection4NameEN
	, lc.LocalName as ConclusionResultTH
	, lc.EnglishName as  ConclusionResultEN
	, CONVERT(Varchar(9), SUBSTRING(lc.Com, 65, 9)) LabCommentAddition1
	, dbo.sysconname(CONVERT(Varchar(9), SUBSTRING(lc.Com, 65, 9)),42601,2) LabCommentAddition1NameTH
    , dbo.sysconname(CONVERT(Varchar(9), SUBSTRING(lc.Com, 65, 9)),42601,1) LabCommentAddition1NameEN
	, CONVERT(Varchar(9), SUBSTRING(lc.Com, 75, 9)) LabCommentAddition2
	, dbo.sysconname(CONVERT(Varchar(9), SUBSTRING(lc.Com, 75, 9)),42601,2) LabCommentAddition2NameTH
    , dbo.sysconname(CONVERT(Varchar(9), SUBSTRING(lc.Com, 75, 9)),42601,1) LabCommentAddition2NameEN
	, CONVERT(Varchar(9), SUBSTRING(lc.Com, 85, 9)) LabCommentAddition3
	, dbo.sysconname(CONVERT(Varchar(9), SUBSTRING(lc.Com, 85, 9)),42601,1) LabCommentAddition3NameTH
    , dbo.sysconname(CONVERT(Varchar(9), SUBSTRING(lc.Com, 85, 9)),42601,2) LabCommentAddition3NameEN
	, CONVERT(Varchar(9), SUBSTRING(lc.Com, 95, 9)) LabCommentAddition4
	, dbo.sysconname(CONVERT(Varchar(9), SUBSTRING(lc.Com, 95, 9)),42601,1) LabCommentAddition4NameTH
    , dbo.sysconname(CONVERT(Varchar(9), SUBSTRING(lc.Com, 95, 9)),42601,2) LabCommentAddition4NameEN
	, CAST(SUBSTRING(lc.Com,129,13)as varchar) as Doctor1
	, dbo.Doctorname(CAST(SUBSTRING(lc.Com,129,13)as varchar),2) as Doctor1NameTH
	, dbo.Doctorname(CAST(SUBSTRING(lc.Com,129,13)as varchar),1) as Doctor1NameEN
	, CAST(SUBSTRING(lc.Com,143,13)as varchar) as Doctor2
	, dbo.Doctorname(CAST(SUBSTRING(lc.Com,143,13)as varchar),2) as Doctor2NameTH
	, dbo.Doctorname(CAST(SUBSTRING(lc.Com,143,13)as varchar),1) as Doctor2NameEN
	, CAST(SUBSTRING(lc.Com,157,13)as varchar) as Doctor3
	, dbo.Doctorname(CAST(SUBSTRING(lc.Com,157,13)as varchar),2) as Doctor3NameTH
	, dbo.Doctorname(CAST(SUBSTRING(lc.Com,157,13)as varchar),1) as Doctor3NameEN
	, CAST(SUBSTRING(lc.Com,171,13)as varchar) as Doctor4
	, dbo.Doctorname(CAST(SUBSTRING(lc.Com,171,13)as varchar),2) as Doctor4NameTH
	, dbo.Doctorname(CAST(SUBSTRING(lc.Com,171,13)as varchar),1) as Doctor4NameEN
	, CAST(SUBSTRING(lc.Com,185,13)as varchar) as Doctor5
	, dbo.Doctorname(CAST(SUBSTRING(lc.Com,185,13)as varchar),2) as Doctor5NameTH
	, dbo.Doctorname(CAST(SUBSTRING(lc.Com,185,13)as varchar),1) as Doctor5NameEN
	, CAST(SUBSTRING(lc.Com,199,13)as varchar) as Doctor6
	, dbo.Doctorname(CAST(SUBSTRING(lc.Com,199,13)as varchar),2) as Doctor6NameTH
	, dbo.Doctorname(CAST(SUBSTRING(lc.Com,199,13)as varchar),1) as Doctor6NameEN
				FROM dnsysconfig_detail lc
				WHERE lc.CtrlCode='60051'
				and lc.AdditionCode='Comment' 
