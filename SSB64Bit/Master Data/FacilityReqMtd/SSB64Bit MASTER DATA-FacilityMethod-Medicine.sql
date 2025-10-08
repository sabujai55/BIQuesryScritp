use SSBLIVE
go

select	
		'PT2' as BU
		, a.Code as FacilityMethodCode
		, dbo.CutSortChar(a.LocalName) as FacilityMethodNameTH
		, dbo.CutSortChar(a.EnglishName) as FacilityMethodNameEN
		, cast(substring(b.com,17,6) as varchar(6)) as Store
		, cast(substring(b.com,23,12) as varchar(12)) as ItemCode
		, coalesce(dbo.cutsortchar(c.LocalName),'') as ItemNameTH
		, coalesce(dbo.cutsortchar(c.EngLishName),'') as ItemNameEN
		, cast(substring(b.com,61,5) as varchar(10)) as HNActivityCodeOPD
		, dbo.sysconname(cast(substring(b.com,61,5) as varchar(10)),42093,2) as HNActivityOPDNameTH
		, dbo.sysconname(cast(substring(b.com,61,5) as varchar(10)),42093,1) as HNActivityOPDNameEN
		, cast(substring(b.com,67,5) as varchar(10)) as HNActivityCodeIPD
		, dbo.sysconname(cast(substring(b.com,67,5) as varchar(10)),42093,2) as HNActivityIPDNameTH
		, dbo.sysconname(cast(substring(b.com,67,5) as varchar(10)),42093,1) as HNActivityIPDNameTH
		, cast(substring(b.com,73,5) as varchar(10)) as HNActivityCodeCheckup
		, dbo.sysconname(cast(substring(b.com,73,5) as varchar(10)),42093,2) as HNActivityCheckupNameTH
		, dbo.sysconname(cast(substring(b.com,73,5) as varchar(10)),42093,1) as HNActivityCheckupNameEN
		, 'Qty' = SIGN(CAST(substring(b.COM,8-0,1)+substring(b.COM,8-1,1)+substring(b.COM,8-2,1)+substring(b.COM,8-3,1)+substring(b.COM,8-4,1)+substring(b.COM,8-5,1)+substring(b.COM,8-6,1)+substring(b.COM,8-7,1) AS BIGINT))
		  *(1.0 + (CAST(substring(b.COM,8-0,1)+substring(b.COM,8-1,1)+substring(b.COM,8-2,1)+substring(b.COM,8-3,1)+substring(b.COM,8-4,1)+substring(b.COM,8-5,1)+substring(b.COM,8-6,1)+substring(b.COM,8-7,1) AS BIGINT) & 0x000FFFFFFFFFFFFF) * POWER(CAST(2 AS FLOAT), -52))
		  * POWER(CAST(2 AS FLOAT), (CAST(substring(b.COM,8-0,1)+substring(b.COM,8-1,1)+substring(b.COM,8-2,1)+substring(b.COM,8-3,1)+substring(b.COM,8-4,1)+substring(b.COM,8-5,1)+substring(b.COM,8-6,1)+substring(b.COM,8-7,1) AS BIGINT) & 0x7ff0000000000000) / 0x0010000000000000 - 1023)
		, 'PriceOPD' = SIGN(CAST(substring(b.COM,16-0,1)+substring(b.COM,16-1,1)+substring(b.COM,16-2,1)+substring(b.COM,16-3,1)+substring(b.COM,16-4,1)+substring(b.COM,16-5,1)+substring(b.COM,16-6,1)+substring(b.COM,16-7,1) AS BIGINT))
		  *(1.0 + (CAST(substring(b.COM,16-0,1)+substring(b.COM,16-1,1)+substring(b.COM,16-2,1)+substring(b.COM,16-3,1)+substring(b.COM,16-4,1)+substring(b.COM,16-5,1)+substring(b.COM,16-6,1)+substring(b.COM,16-7,1) AS BIGINT) & 0x000FFFFFFFFFFFFF) * POWER(CAST(2 AS FLOAT), -52))
		  * POWER(CAST(2 AS FLOAT), (CAST(substring(b.COM,16-0,1)+substring(b.COM,16-1,1)+substring(b.COM,16-2,1)+substring(b.COM,16-3,1)+substring(b.COM,16-4,1)+substring(b.COM,16-5,1)+substring(b.COM,16-6,1)+substring(b.COM,16-7,1) AS BIGINT) & 0x7ff0000000000000) / 0x0010000000000000 - 1023)
		, 'PriceIPD' = SIGN(CAST(substring(b.COM,16-0,1)+substring(b.COM,16-1,1)+substring(b.COM,16-2,1)+substring(b.COM,16-3,1)+substring(b.COM,16-4,1)+substring(b.COM,16-5,1)+substring(b.COM,16-6,1)+substring(b.COM,16-7,1) AS BIGINT))
		  *(1.0 + (CAST(substring(b.COM,16-0,1)+substring(b.COM,16-1,1)+substring(b.COM,16-2,1)+substring(b.COM,16-3,1)+substring(b.COM,16-4,1)+substring(b.COM,16-5,1)+substring(b.COM,16-6,1)+substring(b.COM,16-7,1) AS BIGINT) & 0x000FFFFFFFFFFFFF) * POWER(CAST(2 AS FLOAT), -52))
		  * POWER(CAST(2 AS FLOAT), (CAST(substring(b.COM,16-0,1)+substring(b.COM,16-1,1)+substring(b.COM,16-2,1)+substring(b.COM,16-3,1)+substring(b.COM,16-4,1)+substring(b.COM,16-5,1)+substring(b.COM,16-6,1)+substring(b.COM,16-7,1) AS BIGINT) & 0x7ff0000000000000) / 0x0010000000000000 - 1023)
		, case when cast(substring(b.com,80,1) as int) = 0 then 'None'  
			  when cast(substring(b.com,80,1) as int) = 1 then 'FreeOfCharge ' 
			  when cast(substring(b.com,80,1) as int) = 2 then 'Refund' 
			  when cast(substring(b.com,80,1) as int) = 3 then 'Adjust' 
			  when cast(substring(b.com,80,1) as int) = 5 then 'ChargeByDefault' 
			  when cast(substring(b.com,80,1) as int) = 6 then 'FreeOfChargeReturn ' end as HNChargeType
		, CAST(SUBSTRING(b.Com,79,1) AS int) as DefaultCheck
from	DNSYSCONFIG a
		join DNSYSCONFIG_DETAIL b on b.MasterCtrlCode = a.CtrlCode and b.Code = a.Code and b.additioncode = 'MEDICINE'
		join stockmaster c on cast(substring(b.com,23,12) as varchar(12)) = c.stockcode
where	a.CtrlCode = 42161