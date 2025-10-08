SELECT
          'PLS' as BU
        , frm.CODE as FacilityMethodCode
        , dbo.CutSortChar(frx.THAINAME) as FacilityMethodNameTH
        , dbo.CutSortChar(frx.ENGLISHNAME) as FacilityMethodNameEN
        , cast(SUBSTRING(frx.COM,79,5) as varchar(5)) as XrayCode
        , dbo.sysconname(cast(SUBSTRING(frx.COM,79,5) as varchar(5)),20073,2) as XrayNameTH
        , dbo.sysconname(cast(SUBSTRING(frx.COM,79,5) as varchar(5)),20073,1) as XrayNameEN
        , cast(SUBSTRING(frx.COM,1,5) as varchar(5)) as HNActivityCodeOPD
        , dbo.sysconname(cast(SUBSTRING(frx.COM,1,5) as varchar(5)),20023,2) as HNActivityOPDNameTH
        , dbo.sysconname(cast(SUBSTRING(frx.COM,1,5) as varchar(5)),20023,1) as HNActivityOPDNameEN
        , cast(SUBSTRING(frx.COM,7,5) as varchar(5)) as HNActivityCodeIPD
        , dbo.sysconname(cast(SUBSTRING(frx.COM,7,5) as varchar(5)),20023,2) as HNActivityIPDNameTH
        , dbo.sysconname(cast(SUBSTRING(frx.COM,7,5) as varchar(5)),20023,1) as HNActivityIPDNameEN
        , '' as HNActivityCodeCheckup
        , '' as HNActivityCheckupNameTH
        , '' as HNActivityCheckupNameEN
        , SIGN(CAST(substring(frx.COM,32-0,1)+substring(frx.COM,32-1,1)+substring(frx.COM,32-2,1)+substring(frx.COM,32-3,1)+substring(frx.COM,32-4,1)+substring(frx.COM,32-5,1)+substring(frx.COM,32-6,1)+substring(frx.COM,32-7,1) AS BIGINT))
								 *(1.0 + (CAST(substring(frx.COM,32-0,1)+substring(frx.COM,32-1,1)+substring(frx.COM,32-2,1)+substring(frx.COM,32-3,1)+substring(frx.COM,32-4,1)+substring(frx.COM,32-5,1)+substring(frx.COM,32-6,1)+substring(frx.COM,32-7,1) AS BIGINT) & 0x000FFFFFFFFFFFFF) * POWER(CAST(2 AS FLOAT), -52))
								  * POWER(CAST(2 AS FLOAT), (CAST(substring(frx.COM,32-0,1)+substring(frx.COM,32-1,1)+substring(frx.COM,32-2,1)+substring(frx.COM,32-3,1)+substring(frx.COM,32-4,1)+substring(frx.COM,32-5,1)+substring(frx.COM,32-6,1)+substring(frx.COM,32-7,1) AS BIGINT) & 0x7ff0000000000000) / 0x0010000000000000 - 1023) as PriceOPD
        , SIGN(CAST(substring(frx.COM,40-0,1)+substring(frx.COM,40-1,1)+substring(frx.COM,40-2,1)+substring(frx.COM,40-3,1)+substring(frx.COM,40-4,1)+substring(frx.COM,40-5,1)+substring(frx.COM,40-6,1)+substring(frx.COM,40-7,1) AS BIGINT))
								 *(1.0 + (CAST(substring(frx.COM,40-0,1)+substring(frx.COM,40-1,1)+substring(frx.COM,40-2,1)+substring(frx.COM,40-3,1)+substring(frx.COM,40-4,1)+substring(frx.COM,40-5,1)+substring(frx.COM,40-6,1)+substring(frx.COM,40-7,1) AS BIGINT) & 0x000FFFFFFFFFFFFF) * POWER(CAST(2 AS FLOAT), -52))
								  * POWER(CAST(2 AS FLOAT), (CAST(substring(frx.COM,40-0,1)+substring(frx.COM,40-1,1)+substring(frx.COM,40-2,1)+substring(frx.COM,40-3,1)+substring(frx.COM,40-4,1)+substring(frx.COM,40-5,1)+substring(frx.COM,40-6,1)+substring(frx.COM,40-7,1) AS BIGINT) & 0x7ff0000000000000) / 0x0010000000000000 - 1023) as PriceIPD
        , '' as DefaultCheck
        , CAST(SUBSTRING(frx.COM,19,1)as int) as FreeOfCharge
                FROM SYSCONFIG_DETAIL frx
                INNER JOIN SYSCONFIG frm ON frx.CODE = frm.CODE and frm.CTRLCODE = 20120
                WHERE frx.CTRLCODE = 10226
