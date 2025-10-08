select
		  'PLS' as BU
		, frm.CODE as FacilityMethodCode
		, dbo.CutSortChar(frm.THAINAME) as FacilityMethodNameTH
		, dbo.CutSortChar(frm.ENGLISHNAME) as FacilityMethodNameEN
		, CAST(SUBSTRING(frl.COM,13,5) as varchar(5)) as LabCode
		, dbo.sysconname(CAST(SUBSTRING(frl.COM,13,5) as varchar(5)),20067,2) as LabNameTH
		, dbo.sysconname(CAST(SUBSTRING(frl.COM,13,5) as varchar(5)),20067,1) as LabNameEN
		, CAST(SUBSTRING(frl.COM,81,7)as varchar) as SpecimenCode1
		, dbo.sysconname(CAST(SUBSTRING(frl.COM,81,7)as varchar),20066,2) as SpecimenNameTH1
		, dbo.sysconname(CAST(SUBSTRING(frl.COM,81,7)as varchar),20066,1) as SpecimenNameEN1
		, '' as SpecimenCode2
		, '' as SpecimenNameTH2
		, '' as SpecimenNameEN2
		, CAST(SUBSTRING(frl.COM,0,6) as varchar(6)) as HNActivityOPDCode
		, dbo.sysconname(CAST(SUBSTRING(frl.COM,0,6) as varchar(6)),20023,2) as HNActivityOPDNameTH
		, dbo.sysconname(CAST(SUBSTRING(frl.COM,0,6) as varchar(6)),20023,1) as HNActivityOPDNameEN
		, CAST(SUBSTRING(frl.COM,7,6) as varchar(6)) as HNActivityIPDCode
		, dbo.sysconname(CAST(SUBSTRING(frl.COM,7,6) as varchar(6)),20023,2) as HNActivityIPDNameTH
		, dbo.sysconname(CAST(SUBSTRING(frl.COM,7,6) as varchar(6)),20023,1) as HNActivityIPDNameEN
		, '' as HNActivityCheckupCode
		, '' as HNActivityCheckupNameTH
		, '' as HNActivityCheckupNameEN
		, '' as Qty
		, SIGN(CAST(substring(frl.COM,32-0,1)+substring(frl.COM,32-1,1)+substring(frl.COM,32-2,1)+substring(frl.COM,32-3,1)+substring(frl.COM,32-4,1)+substring(frl.COM,32-5,1)+substring(frl.COM,32-6,1)+substring(frl.COM,32-7,1) AS BIGINT))
									 *(1.0 + (CAST(substring(frl.COM,32-0,1)+substring(frl.COM,32-1,1)+substring(frl.COM,32-2,1)+substring(frl.COM,32-3,1)+substring(frl.COM,32-4,1)+substring(frl.COM,32-5,1)+substring(frl.COM,32-6,1)+substring(frl.COM,32-7,1) AS BIGINT) & 0x000FFFFFFFFFFFFF) * POWER(CAST(2 AS FLOAT), -52))
									  * POWER(CAST(2 AS FLOAT), (CAST(substring(frl.COM,32-0,1)+substring(frl.COM,32-1,1)+substring(frl.COM,32-2,1)+substring(frl.COM,32-3,1)+substring(frl.COM,32-4,1)+substring(frl.COM,32-5,1)+substring(frl.COM,32-6,1)+substring(frl.COM,32-7,1) AS BIGINT) & 0x7ff0000000000000) / 0x0010000000000000 - 1023) as PriceOPD
		, SIGN(CAST(substring(frl.COM,40-0,1)+substring(frl.COM,40-1,1)+substring(frl.COM,40-2,1)+substring(frl.COM,40-3,1)+substring(frl.COM,40-4,1)+substring(frl.COM,40-5,1)+substring(frl.COM,40-6,1)+substring(frl.COM,40-7,1) AS BIGINT))
									 *(1.0 + (CAST(substring(frl.COM,40-0,1)+substring(frl.COM,40-1,1)+substring(frl.COM,40-2,1)+substring(frl.COM,40-3,1)+substring(frl.COM,40-4,1)+substring(frl.COM,40-5,1)+substring(frl.COM,40-6,1)+substring(frl.COM,40-7,1) AS BIGINT) & 0x000FFFFFFFFFFFFF) * POWER(CAST(2 AS FLOAT), -52))
									  * POWER(CAST(2 AS FLOAT), (CAST(substring(frl.COM,40-0,1)+substring(frl.COM,40-1,1)+substring(frl.COM,40-2,1)+substring(frl.COM,40-3,1)+substring(frl.COM,40-4,1)+substring(frl.COM,40-5,1)+substring(frl.COM,40-6,1)+substring(frl.COM,40-7,1) AS BIGINT) & 0x7ff0000000000000) / 0x0010000000000000 - 1023) as PriceIPD
		, '' as DefaultCheck
		, CAST(SUBSTRING(frl.COM,19,1)as int) as FreeOfCharge
				from SYSCONFIG frm
				inner join SYSCONFIG_DETAIL frl on frm.CODE=frl.CODE and frl.CTRLCODE = 10227
				where frm.CTRLCODE = 20120
