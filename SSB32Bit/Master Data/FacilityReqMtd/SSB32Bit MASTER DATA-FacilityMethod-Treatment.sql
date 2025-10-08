SELECT
          'PLS' as BU
        , frm.CODE as FacilityMethodCode
        , dbo.CutSortChar(frm.THAINAME) as FacilityMethodNameTH
        , dbo.CutSortChar(frm.ENGLISHNAME) as FacilityMethodNameEN
        , CAST(SUBSTRING(frt.COM,51,10) as varchar(10)) as TreatmentCode
        , dbo.sysconname(CAST(SUBSTRING(frt.COM,51,10) as varchar(10)),20051,2) as TreatmentNameTH
        , dbo.sysconname(CAST(SUBSTRING(frt.COM,51,10) as varchar(10)),20051,1) as TreatmentNameEN
        , CAST(SUBSTRING(frt.COM,21,6) as varchar(6)) as HNActivityCodeOPD
        , dbo.sysconname(CAST(SUBSTRING(frt.COM,21,6) as varchar(6)),20023,2) as HNActivityOPDNameTH
        , dbo.sysconname(CAST(SUBSTRING(frt.COM,21,6) as varchar(6)),20023,1) as HNActivityOPDNameEN
        , CAST(SUBSTRING(frt.COM,27,6) as varchar(6)) as HNActivityCodeIPD
        , dbo.sysconname(CAST(SUBSTRING(frt.COM,27,6) as varchar(6)),20023,2) as HNActivityIPDNameTH
        , dbo.sysconname(CAST(SUBSTRING(frt.COM,27,6) as varchar(6)),20023,1) as HNActivityIPDNameEN
        , '' as HNActivityCodeCheckup
        , '' as HNActivityCheckupNameTH
        , '' as HNActivityCheckupNameEN
        , SIGN(CAST(substring(frt.COM,40-0,1)+substring(frt.COM,40-1,1)+substring(frt.COM,40-2,1)+substring(frt.COM,40-3,1)+substring(frt.COM,40-4,1)+substring(frt.COM,40-5,1)+substring(frt.COM,40-6,1)+substring(frt.COM,40-7,1) AS BIGINT))
									 *(1.0 + (CAST(substring(frt.COM,40-0,1)+substring(frt.COM,40-1,1)+substring(frt.COM,40-2,1)+substring(frt.COM,40-3,1)+substring(frt.COM,40-4,1)+substring(frt.COM,40-5,1)+substring(frt.COM,40-6,1)+substring(frt.COM,40-7,1) AS BIGINT) & 0x000FFFFFFFFFFFFF) * POWER(CAST(2 AS FLOAT), -52))
									  * POWER(CAST(2 AS FLOAT), (CAST(substring(frt.COM,40-0,1)+substring(frt.COM,40-1,1)+substring(frt.COM,40-2,1)+substring(frt.COM,40-3,1)+substring(frt.COM,40-4,1)+substring(frt.COM,40-5,1)+substring(frt.COM,40-6,1)+substring(frt.COM,40-7,1) AS BIGINT) & 0x7ff0000000000000) / 0x0010000000000000 - 1023) as PriceOPD
        , SIGN(CAST(substring(frt.COM,48-0,1)+substring(frt.COM,48-1,1)+substring(frt.COM,48-2,1)+substring(frt.COM,48-3,1)+substring(frt.COM,48-4,1)+substring(frt.COM,48-5,1)+substring(frt.COM,48-6,1)+substring(frt.COM,48-7,1) AS BIGINT))
									 *(1.0 + (CAST(substring(frt.COM,48-0,1)+substring(frt.COM,48-1,1)+substring(frt.COM,48-2,1)+substring(frt.COM,48-3,1)+substring(frt.COM,48-4,1)+substring(frt.COM,48-5,1)+substring(frt.COM,48-6,1)+substring(frt.COM,48-7,1) AS BIGINT) & 0x000FFFFFFFFFFFFF) * POWER(CAST(2 AS FLOAT), -52))
									  * POWER(CAST(2 AS FLOAT), (CAST(substring(frt.COM,48-0,1)+substring(frt.COM,48-1,1)+substring(frt.COM,48-2,1)+substring(frt.COM,48-3,1)+substring(frt.COM,48-4,1)+substring(frt.COM,48-5,1)+substring(frt.COM,48-6,1)+substring(frt.COM,48-7,1) AS BIGINT) & 0x7ff0000000000000) / 0x0010000000000000 - 1023) as PriceIPD
        , '' as DefaultCheck
        , '' as FreeOfCharge
        , '' as DefaultCheck
        , '' as FreeofCharge
                FROM SYSCONFIG_DETAIL frt
                INNER JOIN SYSCONFIG frm ON frt.CODE=frm.CODE and frm.CTRLCODE = 20120
                WHERE frt.CTRLCODE = 10228
