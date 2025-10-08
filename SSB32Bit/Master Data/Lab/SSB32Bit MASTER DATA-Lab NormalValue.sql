select
		  'PLS' as BU
		, lnv.CODE as LabCode
		, dbo.CutSortChar(lm.THAINAME) as LabNameTH
		, dbo.CutSortChar(lm.ENGLISHNAME) as LabNameEN
		, lnv.SUFFIX as Suffix
		, CAST(SUBSTRING(lnv.COM,49,7)as varchar) as Specimen
		, dbo.sysconname(CAST(SUBSTRING(lnv.COM,49,7)as varchar),20066,2) as SpecimenNameTH
		, dbo.sysconname(CAST(SUBSTRING(lnv.COM,49,7)as varchar),20066,1) as SpecimenNameEN
		, SIGN(CAST(substring(lnv.COM,32-0,1)+substring(lnv.COM,32-1,1)+substring(lnv.COM,32-2,1)+substring(lnv.COM,32-3,1)+substring(lnv.COM,32-4,1)+substring(lnv.COM,32-5,1)+substring(lnv.COM,32-6,1)+substring(lnv.COM,32-7,1) AS BIGINT))
		  *(1.0 + (CAST(substring(lnv.COM,32-0,1)+substring(lnv.COM,32-1,1)+substring(lnv.COM,32-2,1)+substring(lnv.COM,32-3,1)+substring(lnv.COM,32-4,1)+substring(lnv.COM,32-5,1)+substring(lnv.COM,32-6,1)+substring(lnv.COM,32-7,1) AS BIGINT) & 0x000FFFFFFFFFFFFF) * POWER(CAST(2 AS FLOAT), -52))
		  * POWER(CAST(2 AS FLOAT), (CAST(substring(lnv.COM,32-0,1)+substring(lnv.COM,32-1,1)+substring(lnv.COM,32-2,1)+substring(lnv.COM,32-3,1)+substring(lnv.COM,32-4,1)+substring(lnv.COM,32-5,1)+substring(lnv.COM,32-6,1)+substring(lnv.COM,32-7,1) AS BIGINT) & 0x7ff0000000000000) / 0x0010000000000000 - 1023)
		  as NormalValueFrom
		, SIGN(CAST(substring(lnv.COM,40-0,1)+substring(lnv.COM,40-1,1)+substring(lnv.COM,40-2,1)+substring(lnv.COM,40-3,1)+substring(lnv.COM,40-4,1)+substring(lnv.COM,40-5,1)+substring(lnv.COM,40-6,1)+substring(lnv.COM,40-7,1) AS BIGINT))
		  *(1.0 + (CAST(substring(lnv.COM,40-0,1)+substring(lnv.COM,40-1,1)+substring(lnv.COM,40-2,1)+substring(lnv.COM,40-3,1)+substring(lnv.COM,40-4,1)+substring(lnv.COM,40-5,1)+substring(lnv.COM,40-6,1)+substring(lnv.COM,40-7,1) AS BIGINT) & 0x000FFFFFFFFFFFFF) * POWER(CAST(2 AS FLOAT), -52))
		  * POWER(CAST(2 AS FLOAT), (CAST(substring(lnv.COM,40-0,1)+substring(lnv.COM,40-1,1)+substring(lnv.COM,40-2,1)+substring(lnv.COM,40-3,1)+substring(lnv.COM,40-4,1)+substring(lnv.COM,40-5,1)+substring(lnv.COM,40-6,1)+substring(lnv.COM,40-7,1) AS BIGINT) & 0x7ff0000000000000) / 0x0010000000000000 - 1023)
		  as NormalValueTo
		, cast(SUBSTRING(lnv.com,10,1)+SUBSTRING(lnv.com,9,1) as int) as AgeYearFrom
		, '' as AgeMonthFrom
		, '' as AgeDayFrom
		, cast(SUBSTRING(lnv.com,14,1)+SUBSTRING(lnv.com,13,1) as int) as AgeYearTo
		, '' as AgeMonthTo
		, '' as AgeDayTo
		, SIGN(CAST(substring(lnv.COM,24-0,1)+substring(lnv.COM,24-1,1)+substring(lnv.COM,24-2,1)+substring(lnv.COM,24-3,1)+substring(lnv.COM,24-4,1)+substring(lnv.COM,24-5,1)+substring(lnv.COM,24-6,1)+substring(lnv.COM,24-7,1) AS BIGINT))
		  *(1.0 + (CAST(substring(lnv.COM,24-0,1)+substring(lnv.COM,24-1,1)+substring(lnv.COM,24-2,1)+substring(lnv.COM,24-3,1)+substring(lnv.COM,24-4,1)+substring(lnv.COM,24-5,1)+substring(lnv.COM,24-6,1)+substring(lnv.COM,24-7,1) AS BIGINT) & 0x000FFFFFFFFFFFFF) * POWER(CAST(2 AS FLOAT), -52))
		  * POWER(CAST(2 AS FLOAT), (CAST(substring(lnv.COM,24-0,1)+substring(lnv.COM,24-1,1)+substring(lnv.COM,24-2,1)+substring(lnv.COM,24-3,1)+substring(lnv.COM,24-4,1)+substring(lnv.COM,24-5,1)+substring(lnv.COM,24-6,1)+substring(lnv.COM,24-7,1) AS BIGINT) & 0x7ff0000000000000) / 0x0010000000000000 - 1023)
		  as ValidFrom
		, SIGN(CAST(substring(lnv.COM,48-0,1)+substring(lnv.COM,48-1,1)+substring(lnv.COM,48-2,1)+substring(lnv.COM,48-3,1)+substring(lnv.COM,48-4,1)+substring(lnv.COM,48-5,1)+substring(lnv.COM,48-6,1)+substring(lnv.COM,48-7,1) AS BIGINT))
		  *(1.0 + (CAST(substring(lnv.COM,48-0,1)+substring(lnv.COM,48-1,1)+substring(lnv.COM,48-2,1)+substring(lnv.COM,48-3,1)+substring(lnv.COM,48-4,1)+substring(lnv.COM,48-5,1)+substring(lnv.COM,48-6,1)+substring(lnv.COM,48-7,1) AS BIGINT) & 0x000FFFFFFFFFFFFF) * POWER(CAST(2 AS FLOAT), -52))
		  * POWER(CAST(2 AS FLOAT), (CAST(substring(lnv.COM,48-0,1)+substring(lnv.COM,48-1,1)+substring(lnv.COM,48-2,1)+substring(lnv.COM,48-3,1)+substring(lnv.COM,48-4,1)+substring(lnv.COM,48-5,1)+substring(lnv.COM,48-6,1)+substring(lnv.COM,48-7,1) AS BIGINT) & 0x7ff0000000000000) / 0x0010000000000000 - 1023)
		  as ValidTo
		, CAST(SUBSTRING(lnv.COM,1,1)as int) as Gender
		, '' as GenderNameTH
		, case when CAST(SUBSTRING(lnv.COM,1,1)as int) = 0 then 'Any'
			   when CAST(SUBSTRING(lnv.COM,1,1)as int) = 1 then 'Male'
			   when CAST(SUBSTRING(lnv.COM,1,1)as int) = 2 then 'Female'
			   when CAST(SUBSTRING(lnv.COM,1,1)as int) = 3 then 'Pregnant'
			   end as GenderNameEN
		, '' as NormalName
		, '' as LowName
		, '' as HighName
				from SYSCONFIG_DETAIL lnv
				left join SYSCONFIG lm on lnv.CODE=lm.CODE and lm.CTRLCODE = 20067
				where lnv.CTRLCODE = 10252
