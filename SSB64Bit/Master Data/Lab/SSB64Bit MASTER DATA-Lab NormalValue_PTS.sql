select 
		'PTS' as BU
		, ln.Code as LabCode
		, dbo.sysconname(ln.Code,42136,2) as LabNameTH
		, dbo.sysconname(ln.Code,42136,1) as LabNameEN
		, ln.Suffix
		, b.SpecimenCode as Specimen --modify 2026-03-18
		, dbo.sysconname(b.SpecimenCode,42121,2) as SpecimenNameTH --modify 2026-03-18
		, dbo.sysconname(b.SpecimenCode,42121,1) as SpecimenNameEN --modify 2026-03-18
		, b.LowestNormalValue as NormalValueFrom --modify 2026-03-18
		--, SIGN(CAST(SUBSTRING(ln.Com, 24 - 0, 1) + SUBSTRING(ln.Com, 24 - 1, 1) + SUBSTRING(ln.Com, 24 - 2, 1) + SUBSTRING(ln.Com, 24 - 3, 1) + SUBSTRING(ln.Com, 24 - 4, 1) + SUBSTRING(ln.Com, 24 - 5, 1) + SUBSTRING(ln.Com, 24 - 6, 1) + SUBSTRING(ln.Com,24 - 7, 1) AS BIGINT)) 
		-- * (1.0 + (CAST(SUBSTRING(ln.Com, 24 - 0, 1) + SUBSTRING(ln.Com, 24 - 1, 1) + SUBSTRING(ln.Com, 24 - 2, 1) + SUBSTRING(ln.Com, 24 - 3,1) + SUBSTRING(ln.Com, 24 - 4, 1) + SUBSTRING(ln.Com, 24 - 5, 1) + SUBSTRING(ln.Com, 24 - 6, 1) + SUBSTRING(ln.Com, 24 - 7, 1) AS BIGINT) & 0x000FFFFFFFFFFFFF) 
		-- * POWER(CAST(2 AS FLOAT), - 52)) * POWER(CAST(2 AS FLOAT), (CAST(SUBSTRING(ln.Com, 24 - 0, 1) + SUBSTRING(ln.Com, 24 - 1, 1) + SUBSTRING(ln.Com, 24 - 2, 1) + SUBSTRING(ln.Com, 24 - 3, 1) + SUBSTRING(ln.Com, 24 - 4, 1) + SUBSTRING(ln.Com, 24 - 5, 1) + SUBSTRING(ln.Com,24 - 6, 1) + SUBSTRING(ln.Com, 24 - 7, 1) AS BIGINT) & 0x7ff0000000000000) / 0x0010000000000000 - 1023) AS NormalValueFrom
		--, SIGN(CAST(SUBSTRING(ln.Com, 32 - 0, 1) + SUBSTRING(ln.Com, 32 - 1, 1) + SUBSTRING(ln.Com, 32 - 2, 1) + SUBSTRING(ln.Com, 32 - 3, 1) + SUBSTRING(ln.Com, 32 - 4, 1) + SUBSTRING(ln.Com, 32 - 5, 1) + SUBSTRING(ln.Com, 32 - 6, 1) + SUBSTRING(ln.Com,32 - 7, 1) AS BIGINT)) 
		-- * (1.0 + (CAST(SUBSTRING(ln.Com, 32 - 0, 1) + SUBSTRING(ln.Com, 32 - 1, 1) + SUBSTRING(ln.Com, 32 - 2, 1) + SUBSTRING(ln.Com, 32 - 3,1) + SUBSTRING(ln.Com, 32 - 4, 1) + SUBSTRING(ln.Com, 32 - 5, 1) + SUBSTRING(ln.Com, 32 - 6, 1) + SUBSTRING(ln.Com, 32 - 7, 1) AS BIGINT) & 0x000FFFFFFFFFFFFF) 
		-- * POWER(CAST(2 AS FLOAT), - 52)) * POWER(CAST(2 AS FLOAT), (CAST(SUBSTRING(ln.Com, 32 - 0, 1) + SUBSTRING(ln.Com, 32 - 1, 1) + SUBSTRING(ln.Com, 32 - 2, 1) + SUBSTRING(ln.Com, 32 - 3, 1) + SUBSTRING(ln.Com, 32 - 4, 1) + SUBSTRING(ln.Com, 32 - 5, 1) + SUBSTRING(ln.Com,32 - 6, 1) + SUBSTRING(ln.Com, 32 - 7, 1) AS BIGINT) & 0x7ff0000000000000) / 0x0010000000000000 - 1023) AS NormalValueTo
		, b.HigestNormalValue as NormalValueTo --modify 2026-03-18
		, (b.AgeDayFrom / 360) As AgeYearFrom --modify 2026-03-18
		, (b.AgeDayFrom % 360) / 30 As AgeMonthFrom --modify 2026-03-18
		, (b.AgeDayFrom % 360) % 30 As AgeDayFrom --modify 2026-03-18
		, (b.AgeDayTo / 360) As AgeYearTo --modify 2026-03-18
		, (b.AgeDayTo % 360) / 30 As AgeMonthTo --modify 2026-03-18
		, (b.AgeDayTo % 360) % 30 As AgeDayTo --modify 2026-03-18
		--, SIGN(CAST(SUBSTRING(ln.Com, 16 - 0, 1) + SUBSTRING(ln.Com, 16 - 1, 1) + SUBSTRING(ln.Com, 16 - 2, 1) + SUBSTRING(ln.Com, 16 - 3, 1) + SUBSTRING(ln.Com, 16 - 4, 1) + SUBSTRING(ln.Com, 16 - 5, 1) + SUBSTRING(ln.Com, 16 - 6, 1) + SUBSTRING(ln.Com,16 - 7, 1) AS BIGINT)) 
		-- * (1.0 + (CAST(SUBSTRING(ln.Com, 16 - 0, 1) + SUBSTRING(ln.Com, 16 - 1, 1) + SUBSTRING(ln.Com, 16 - 2, 1) + SUBSTRING(ln.Com, 16 - 3,1) + SUBSTRING(ln.Com, 16 - 4, 1) + SUBSTRING(ln.Com, 16 - 5, 1) + SUBSTRING(ln.Com, 16 - 6, 1) + SUBSTRING(ln.Com, 16 - 7, 1) AS BIGINT) & 0x000FFFFFFFFFFFFF) 
		-- * POWER(CAST(2 AS FLOAT), - 52)) * POWER(CAST(2 AS FLOAT), (CAST(SUBSTRING(ln.Com, 16 - 0, 1) + SUBSTRING(ln.Com, 16 - 1, 1) + SUBSTRING(ln.Com, 16 - 2, 1) + SUBSTRING(ln.Com, 16 - 3, 1) + SUBSTRING(ln.Com, 16 - 4, 1) + SUBSTRING(ln.Com, 16 - 5, 1) + SUBSTRING(ln.Com,16 - 6, 1) + SUBSTRING(ln.Com, 16 - 7, 1) AS BIGINT) & 0x7ff0000000000000) / 0x0010000000000000 - 1023) AS ValidFrom
		, b.LowestValidValue as ValidFrom --modify 2026-03-18
		--, SIGN(CAST(SUBSTRING(ln.Com, 40 - 0, 1) + SUBSTRING(ln.Com, 40 - 1, 1) + SUBSTRING(ln.Com, 40 - 2, 1) + SUBSTRING(ln.Com, 40 - 3, 1) + SUBSTRING(ln.Com, 40 - 4, 1) + SUBSTRING(ln.Com, 40 - 5, 1) + SUBSTRING(ln.Com, 40 - 6, 1) + SUBSTRING(ln.Com,40 - 7, 1) AS BIGINT)) 
		-- * (1.0 + (CAST(SUBSTRING(ln.Com, 40 - 0, 1) + SUBSTRING(ln.Com, 40 - 1, 1) + SUBSTRING(ln.Com, 40 - 2, 1) + SUBSTRING(ln.Com, 40 - 3,1) + SUBSTRING(ln.Com, 40 - 4, 1) + SUBSTRING(ln.Com, 40 - 5, 1) + SUBSTRING(ln.Com, 40 - 6, 1) + SUBSTRING(ln.Com, 40 - 7, 1) AS BIGINT) & 0x000FFFFFFFFFFFFF) 
		-- * POWER(CAST(2 AS FLOAT), - 52)) * POWER(CAST(2 AS FLOAT), (CAST(SUBSTRING(ln.Com, 40 - 0, 1) + SUBSTRING(ln.Com, 40 - 1, 1) + SUBSTRING(ln.Com, 40 - 2, 1) + SUBSTRING(ln.Com, 40 - 3, 1) + SUBSTRING(ln.Com, 40 - 4, 1) + SUBSTRING(ln.Com, 40 - 5, 1) + SUBSTRING(ln.Com,40 - 6, 1) + SUBSTRING(ln.Com, 40 - 7, 1) AS BIGINT) & 0x7ff0000000000000) / 0x0010000000000000 - 1023) AS ValidTo
		, b.HigestValidValue as ValidTo --modify 2026-03-18
		, b.Gender as Gender --modify 2026-03-18
		, case when b.Gender = 0 then 'ไม่ระบุ'
		   when b.Gender = 1 then 'หญิง'
		   when b.Gender = 2 then 'ชาย'
		   when b.Gender = 3 then 'ไม่ระบุเพศ'
		   end as GenderNameTH --modify 2026-03-18
		, case when b.Gender = 0 then 'None'
		   when b.Gender = 1 then 'Female'
		   when b.Gender = 2 then 'Male'
		   when b.Gender = 3 then 'Gender_not_specified'
		   end as GenderNameEN	 --modify 2026-03-18
		, b.NormalName as NormalName --modify 2026-03-18
		, b.LowName as LowName --modify 2026-03-18
		, b.HighName as HighName --modify 2026-03-18
				from DNSYSCONFIG_DETAIL ln 
				inner join DEVDECRYPT.dbo.PYTS_SETUP_LAB_CODE_DTL_NORMAL_VALUE b on ln.Code=b.Code and ln.Suffix=b.Suffix --modify 2026-03-18
				where  AdditionCode = 'NORMALVALUE' 
				and CtrlCode = 60051