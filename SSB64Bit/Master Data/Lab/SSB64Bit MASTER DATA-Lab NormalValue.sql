select 
		'PT2' as BU
		, ln.Code as LabCode
		, dbo.sysconname(ln.Code,42136,2) as LabNameTH
		, dbo.sysconname(ln.Code,42136,1) as LabNameEN
		, ln.Suffix
		, CAST(SUBSTRING(ln.com,42,7)as varchar) as Specimen
		, dbo.sysconname(CAST(SUBSTRING(ln.com,42,7)as varchar),42121,2) as SpecimenNameTH
		, dbo.sysconname(CAST(SUBSTRING(ln.com,42,7)as varchar),42121,1) as SpecimenNameEN
		, SIGN(CAST(SUBSTRING(ln.Com, 24 - 0, 1) + SUBSTRING(ln.Com, 24 - 1, 1) + SUBSTRING(ln.Com, 24 - 2, 1) + SUBSTRING(ln.Com, 24 - 3, 1) + SUBSTRING(ln.Com, 24 - 4, 1) + SUBSTRING(ln.Com, 24 - 5, 1) + SUBSTRING(ln.Com, 24 - 6, 1) + SUBSTRING(ln.Com,24 - 7, 1) AS BIGINT)) 
		 * (1.0 + (CAST(SUBSTRING(ln.Com, 24 - 0, 1) + SUBSTRING(ln.Com, 24 - 1, 1) + SUBSTRING(ln.Com, 24 - 2, 1) + SUBSTRING(ln.Com, 24 - 3,1) + SUBSTRING(ln.Com, 24 - 4, 1) + SUBSTRING(ln.Com, 24 - 5, 1) + SUBSTRING(ln.Com, 24 - 6, 1) + SUBSTRING(ln.Com, 24 - 7, 1) AS BIGINT) & 0x000FFFFFFFFFFFFF) 
		 * POWER(CAST(2 AS FLOAT), - 52)) * POWER(CAST(2 AS FLOAT), (CAST(SUBSTRING(ln.Com, 24 - 0, 1) + SUBSTRING(ln.Com, 24 - 1, 1) + SUBSTRING(ln.Com, 24 - 2, 1) + SUBSTRING(ln.Com, 24 - 3, 1) + SUBSTRING(ln.Com, 24 - 4, 1) + SUBSTRING(ln.Com, 24 - 5, 1) + SUBSTRING(ln.Com,24 - 6, 1) + SUBSTRING(ln.Com, 24 - 7, 1) AS BIGINT) & 0x7ff0000000000000) / 0x0010000000000000 - 1023) AS NormalValueFrom
		, SIGN(CAST(SUBSTRING(ln.Com, 32 - 0, 1) + SUBSTRING(ln.Com, 32 - 1, 1) + SUBSTRING(ln.Com, 32 - 2, 1) + SUBSTRING(ln.Com, 32 - 3, 1) + SUBSTRING(ln.Com, 32 - 4, 1) + SUBSTRING(ln.Com, 32 - 5, 1) + SUBSTRING(ln.Com, 32 - 6, 1) + SUBSTRING(ln.Com,32 - 7, 1) AS BIGINT)) 
		 * (1.0 + (CAST(SUBSTRING(ln.Com, 32 - 0, 1) + SUBSTRING(ln.Com, 32 - 1, 1) + SUBSTRING(ln.Com, 32 - 2, 1) + SUBSTRING(ln.Com, 32 - 3,1) + SUBSTRING(ln.Com, 32 - 4, 1) + SUBSTRING(ln.Com, 32 - 5, 1) + SUBSTRING(ln.Com, 32 - 6, 1) + SUBSTRING(ln.Com, 32 - 7, 1) AS BIGINT) & 0x000FFFFFFFFFFFFF) 
		 * POWER(CAST(2 AS FLOAT), - 52)) * POWER(CAST(2 AS FLOAT), (CAST(SUBSTRING(ln.Com, 32 - 0, 1) + SUBSTRING(ln.Com, 32 - 1, 1) + SUBSTRING(ln.Com, 32 - 2, 1) + SUBSTRING(ln.Com, 32 - 3, 1) + SUBSTRING(ln.Com, 32 - 4, 1) + SUBSTRING(ln.Com, 32 - 5, 1) + SUBSTRING(ln.Com,32 - 6, 1) + SUBSTRING(ln.Com, 32 - 7, 1) AS BIGINT) & 0x7ff0000000000000) / 0x0010000000000000 - 1023) AS NormalValueTo
		, (cast(cast((Substring(ln.COM,4,1)+Substring(ln.Com,3,1)+Substring(ln.Com,2,1)+Substring(ln.Com,1,1)) as binary(4))as int))/360 As AgeYearFrom
		, ((cast(cast((Substring(ln.Com,4,1)+Substring(ln.Com,3,1)+Substring(ln.Com,2,1)+Substring(ln.Com,1,1)) as binary(4))as int))%360)/30 As AgeMonthFrom
		, (((cast(cast((Substring(ln.Com,4,1)+Substring(ln.Com,3,1)+Substring(ln.Com,2,1)+Substring(ln.Com,1,1)) as binary(4))as int))%360)%30) As AgeDayFrom
		, (cast(cast((Substring(ln.Com,8,1)+Substring(ln.Com,7,1)+Substring(ln.Com,6,1)+Substring(ln.Com,5,1)) as binary(4))as int))/360 As AgeYearTo
		, ((cast(cast((Substring(ln.Com,8,1)+Substring(ln.Com,7,1)+Substring(ln.Com,6,1)+Substring(ln.Com,5,1)) as binary(4))as int))%360)/30 As AgeMonthTo
		, (((cast(cast((Substring(ln.Com,8,1)+Substring(ln.Com,7,1)+Substring(ln.Com,6,1)+Substring(ln.Com,5,1)) as binary(4))as int))%360)%30) As AgeDayTo
		, SIGN(CAST(SUBSTRING(ln.Com, 16 - 0, 1) + SUBSTRING(ln.Com, 16 - 1, 1) + SUBSTRING(ln.Com, 16 - 2, 1) + SUBSTRING(ln.Com, 16 - 3, 1) + SUBSTRING(ln.Com, 16 - 4, 1) + SUBSTRING(ln.Com, 16 - 5, 1) + SUBSTRING(ln.Com, 16 - 6, 1) + SUBSTRING(ln.Com,16 - 7, 1) AS BIGINT)) 
		 * (1.0 + (CAST(SUBSTRING(ln.Com, 16 - 0, 1) + SUBSTRING(ln.Com, 16 - 1, 1) + SUBSTRING(ln.Com, 16 - 2, 1) + SUBSTRING(ln.Com, 16 - 3,1) + SUBSTRING(ln.Com, 16 - 4, 1) + SUBSTRING(ln.Com, 16 - 5, 1) + SUBSTRING(ln.Com, 16 - 6, 1) + SUBSTRING(ln.Com, 16 - 7, 1) AS BIGINT) & 0x000FFFFFFFFFFFFF) 
		 * POWER(CAST(2 AS FLOAT), - 52)) * POWER(CAST(2 AS FLOAT), (CAST(SUBSTRING(ln.Com, 16 - 0, 1) + SUBSTRING(ln.Com, 16 - 1, 1) + SUBSTRING(ln.Com, 16 - 2, 1) + SUBSTRING(ln.Com, 16 - 3, 1) + SUBSTRING(ln.Com, 16 - 4, 1) + SUBSTRING(ln.Com, 16 - 5, 1) + SUBSTRING(ln.Com,16 - 6, 1) + SUBSTRING(ln.Com, 16 - 7, 1) AS BIGINT) & 0x7ff0000000000000) / 0x0010000000000000 - 1023) AS ValidFrom
		, SIGN(CAST(SUBSTRING(ln.Com, 40 - 0, 1) + SUBSTRING(ln.Com, 40 - 1, 1) + SUBSTRING(ln.Com, 40 - 2, 1) + SUBSTRING(ln.Com, 40 - 3, 1) + SUBSTRING(ln.Com, 40 - 4, 1) + SUBSTRING(ln.Com, 40 - 5, 1) + SUBSTRING(ln.Com, 40 - 6, 1) + SUBSTRING(ln.Com,40 - 7, 1) AS BIGINT)) 
		 * (1.0 + (CAST(SUBSTRING(ln.Com, 40 - 0, 1) + SUBSTRING(ln.Com, 40 - 1, 1) + SUBSTRING(ln.Com, 40 - 2, 1) + SUBSTRING(ln.Com, 40 - 3,1) + SUBSTRING(ln.Com, 40 - 4, 1) + SUBSTRING(ln.Com, 40 - 5, 1) + SUBSTRING(ln.Com, 40 - 6, 1) + SUBSTRING(ln.Com, 40 - 7, 1) AS BIGINT) & 0x000FFFFFFFFFFFFF) 
		 * POWER(CAST(2 AS FLOAT), - 52)) * POWER(CAST(2 AS FLOAT), (CAST(SUBSTRING(ln.Com, 40 - 0, 1) + SUBSTRING(ln.Com, 40 - 1, 1) + SUBSTRING(ln.Com, 40 - 2, 1) + SUBSTRING(ln.Com, 40 - 3, 1) + SUBSTRING(ln.Com, 40 - 4, 1) + SUBSTRING(ln.Com, 40 - 5, 1) + SUBSTRING(ln.Com,40 - 6, 1) + SUBSTRING(ln.Com, 40 - 7, 1) AS BIGINT) & 0x7ff0000000000000) / 0x0010000000000000 - 1023) AS ValidTo
		, CAST(SUBSTRING(ln.com,41,1)as int) as Gender
		, case when CAST(SUBSTRING(ln.com,41,1)as int) = 0 then 'ไม่ระบุ'
		   when CAST(SUBSTRING(ln.com,41,1)as int) = 1 then 'หญิง'
		   when CAST(SUBSTRING(ln.com,41,1)as int) = 2 then 'ชาย'
		   when CAST(SUBSTRING(ln.com,41,1)as int) = 3 then 'ไม่ระบุเพศ'
		   end as GenderNameTH
		, case when CAST(SUBSTRING(ln.com,41,1)as int) = 0 then 'None'
		   when CAST(SUBSTRING(ln.com,41,1)as int) = 1 then 'Female'
		   when CAST(SUBSTRING(ln.com,41,1)as int) = 2 then 'Male'
		   when CAST(SUBSTRING(ln.com,41,1)as int) = 3 then 'Gender_not_specified'
		   end as GenderNameEN	
		, CONCAT(CAST(SUBSTRING(ln.Com,61,1)as varchar),CAST(SUBSTRING(ln.Com,63,1)as varchar),CAST(SUBSTRING(ln.Com,65,1)as varchar)
		    ,CAST(SUBSTRING(ln.Com,67,1)as varchar),CAST(SUBSTRING(ln.Com,69,1)as varchar),CAST(SUBSTRING(ln.Com,71,1)as varchar)
			,CAST(SUBSTRING(ln.Com,73,1)as varchar),CAST(SUBSTRING(ln.Com,75,1)as varchar),CAST(SUBSTRING(ln.Com,77,1)as varchar)
			,CAST(SUBSTRING(ln.Com,79,1)as varchar),CAST(SUBSTRING(ln.Com,81,1)as varchar),CAST(SUBSTRING(ln.Com,83,1)as varchar)
			,CAST(SUBSTRING(ln.Com,85,1)as varchar),CAST(SUBSTRING(ln.Com,87,1)as varchar),CAST(SUBSTRING(ln.Com,89,1)as varchar)
			,CAST(SUBSTRING(ln.Com,91,1)as varchar),CAST(SUBSTRING(ln.Com,93,1)as varchar),CAST(SUBSTRING(ln.Com,95,1)as varchar)
			,CAST(SUBSTRING(ln.Com,97,1)as varchar),CAST(SUBSTRING(ln.Com,99,1)as varchar),CAST(SUBSTRING(ln.Com,101,1)as varchar)
			,CAST(SUBSTRING(ln.Com,103,1)as varchar),CAST(SUBSTRING(ln.Com,105,1)as varchar),CAST(SUBSTRING(ln.Com,107,1)as varchar)
			,CAST(SUBSTRING(ln.Com,109,1)as varchar),CAST(SUBSTRING(ln.Com,111,1)as varchar),CAST(SUBSTRING(ln.Com,113,1)as varchar)
			,CAST(SUBSTRING(ln.Com,115,1)as varchar),CAST(SUBSTRING(ln.Com,117,1)as varchar),CAST(SUBSTRING(ln.Com,119,1)as varchar)) as NormalName
		, CONCAT(CAST(SUBSTRING(ln.Com,121,1)as varchar),CAST(SUBSTRING(ln.Com,123,1)as varchar),CAST(SUBSTRING(ln.Com,125,1)as varchar)
		    ,CAST(SUBSTRING(ln.Com,127,1)as varchar),CAST(SUBSTRING(ln.Com,129,1)as varchar),CAST(SUBSTRING(ln.Com,131,1)as varchar)
			,CAST(SUBSTRING(ln.Com,133,1)as varchar),CAST(SUBSTRING(ln.Com,135,1)as varchar),CAST(SUBSTRING(ln.Com,137,1)as varchar)
			,CAST(SUBSTRING(ln.Com,139,1)as varchar),CAST(SUBSTRING(ln.Com,141,1)as varchar),CAST(SUBSTRING(ln.Com,143,1)as varchar)
			,CAST(SUBSTRING(ln.Com,145,1)as varchar),CAST(SUBSTRING(ln.Com,147,1)as varchar),CAST(SUBSTRING(ln.Com,149,1)as varchar)
			,CAST(SUBSTRING(ln.Com,151,1)as varchar),CAST(SUBSTRING(ln.Com,153,1)as varchar),CAST(SUBSTRING(ln.Com,155,1)as varchar)
			,CAST(SUBSTRING(ln.Com,157,1)as varchar),CAST(SUBSTRING(ln.Com,159,1)as varchar),CAST(SUBSTRING(ln.Com,161,1)as varchar)
			,CAST(SUBSTRING(ln.Com,163,1)as varchar),CAST(SUBSTRING(ln.Com,165,1)as varchar),CAST(SUBSTRING(ln.Com,167,1)as varchar)
			,CAST(SUBSTRING(ln.Com,169,1)as varchar),CAST(SUBSTRING(ln.Com,171,1)as varchar),CAST(SUBSTRING(ln.Com,173,1)as varchar)
			,CAST(SUBSTRING(ln.Com,175,1)as varchar),CAST(SUBSTRING(ln.Com,177,1)as varchar),CAST(SUBSTRING(ln.Com,179,1)as varchar)) as LowName
		, CONCAT(CAST(SUBSTRING(ln.Com,181,1)as varchar),CAST(SUBSTRING(ln.Com,183,1)as varchar),CAST(SUBSTRING(ln.Com,185,1)as varchar)
		    ,CAST(SUBSTRING(ln.Com,187,1)as varchar),CAST(SUBSTRING(ln.Com,189,1)as varchar),CAST(SUBSTRING(ln.Com,191,1)as varchar)
			,CAST(SUBSTRING(ln.Com,193,1)as varchar),CAST(SUBSTRING(ln.Com,195,1)as varchar),CAST(SUBSTRING(ln.Com,197,1)as varchar)
			,CAST(SUBSTRING(ln.Com,199,1)as varchar),CAST(SUBSTRING(ln.Com,201,1)as varchar),CAST(SUBSTRING(ln.Com,203,1)as varchar)
			,CAST(SUBSTRING(ln.Com,205,1)as varchar),CAST(SUBSTRING(ln.Com,207,1)as varchar),CAST(SUBSTRING(ln.Com,209,1)as varchar)
			,CAST(SUBSTRING(ln.Com,211,1)as varchar),CAST(SUBSTRING(ln.Com,213,1)as varchar),CAST(SUBSTRING(ln.Com,215,1)as varchar)
			,CAST(SUBSTRING(ln.Com,217,1)as varchar),CAST(SUBSTRING(ln.Com,219,1)as varchar),CAST(SUBSTRING(ln.Com,221,1)as varchar)
			,CAST(SUBSTRING(ln.Com,223,1)as varchar),CAST(SUBSTRING(ln.Com,225,1)as varchar),CAST(SUBSTRING(ln.Com,227,1)as varchar)
			,CAST(SUBSTRING(ln.Com,229,1)as varchar),CAST(SUBSTRING(ln.Com,231,1)as varchar),CAST(SUBSTRING(ln.Com,233,1)as varchar)
			,CAST(SUBSTRING(ln.Com,235,1)as varchar),CAST(SUBSTRING(ln.Com,237,1)as varchar),CAST(SUBSTRING(ln.Com,239,1)as varchar)) as HighName
				from DNSYSCONFIG_DETAIL ln 
				where  AdditionCode = 'NORMALVALUE' 
				and CtrlCode = 60051


