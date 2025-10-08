use SSBLIVE
go

select	
		a.*
		--a.FacilityrequestMethodCode
		--, replace(a.FacilityrequestMethod_LocalName,char(9),' ') as FacilityrequestMethod_LocalName
		--, replace(a.FacilityrequestMethod_EngLishName,char(9),' ') as FacilityrequestMethod_EngLishName
		--, a.EffectiveDateFrom
		--, a.EffectiveDateto
		--, a.ItemType
		--, a.Store
		--, a.ItemCode
		--, replace(a.ItemName_Local,char(9),' ') as ItemName_Local
		--, replace(a.ItemName_English,char(9),' ') as ItemName_English
		--, a.HNActivityCodeOPD
		--, replace(a.HNActivityNameOPD_Local,char(9),' ') as HNActivityNameOPD_Local
		--, replace(a.HNActivityNameOPD_English,char(9),' ') as HNActivityNameOPD_English
		--, a.HNActivityCodeIPD
		--, replace(a.HNActivityNameIPD_Local,char(9),' ') as HNActivityNameIPD_Local
		--, replace(a.HNActivityNameIPD_English,char(9),' ') as HNActivityNameIPD_English
		--, a.HNActivityCodeCheckup
		--, replace(a.HNActivityNameCheckup_Local,char(9),' ') as HNActivityNameCheckup_Local
		--, replace(a.HNActivityNameCheckup_English,char(9),' ') as HNActivityNameCheckup_English
		--, a.Qty
		--, a.Price
		--, a.DefaultCheck
		--, a.FreeOfCharge
		--, a.HNChargeType
from 
(
	----------------- Treatment -------------                                                                    ---- 
	select  a.code as FacilityrequestMethodCode 
			, coalesce(dbo.cutsortchar(a.LocalName),'') as FacilityrequestMethod_LocalName
			, coalesce(dbo.cutsortchar(a.EngLishName),'') as FacilityrequestMethod_EngLishName
			--,'EffectiveDateFrom'=convert( varchar(10),dbo.BinarytoDate2(a.[Com],128),103)
			--,'EffectiveDateto'=convert( varchar(10),dbo.BinarytoDate2(a.[Com],132),103)
			, '' as EffectiveDateFrom
			, '' as EffectiveDateto
			, cast(substring(a.com,2,1) as int) as [Off]
			, 'TREATMENT' as ItemType
			, '' as Store
			, cast(substring(b.com,17,10) as varchar(10)) as ItemCode
			, dbo.sysconname(cast(substring(b.com,17,10) as varchar(10)),42075,2) as ItemName_Local
			, dbo.sysconname(cast(substring(b.com,17,10) as varchar(10)),42075,1) as ItemName_English
			, cast(substring(b.com,29,5) as varchar(10)) as HNActivityCodeOPD
			, dbo.sysconname(cast(substring(b.com,29,5) as varchar(10)),42093,2) as HNActivityNameOPD_Local
			, dbo.sysconname(cast(substring(b.com,29,5) as varchar(10)),42093,1) as HNActivityNameOPD_English
			,oin.incomelocalname as incomelocalnameopd
			, cast(substring(b.com,35,5) as varchar(10)) as HNActivityCodeIPD
			, dbo.sysconname(cast(substring(b.com,35,5) as varchar(10)),42093,2) as HNActivityNameIPD_Local
			, dbo.sysconname(cast(substring(b.com,35,5) as varchar(10)),42093,1) as HNActivityNameIPD_English
			,iin.incomelocalname as incomelocalnameipd
			, cast(substring(b.com,41,5) as varchar(10)) as HNActivityCodeCheckup
			, dbo.sysconname(cast(substring(b.com,41,5) as varchar(10)),42093,2) as HNActivityNameCheckup_Local
			, dbo.sysconname(cast(substring(b.com,41,5) as varchar(10)),42093,1) as HNActivityNameCheckup_English
			,cin.incomelocalname as incomelocalnameChk
			, '1' as Qty
			, 'Price' = SIGN(CAST(substring(b.COM,8-0,1)+substring(b.COM,8-1,1)+substring(b.COM,8-2,1)+substring(b.COM,8-3,1)+substring(b.COM,8-4,1)+substring(b.COM,8-5,1)+substring(b.COM,8-6,1)+substring(b.COM,8-7,1) AS BIGINT))
			  *(1.0 + (CAST(substring(b.COM,8-0,1)+substring(b.COM,8-1,1)+substring(b.COM,8-2,1)+substring(b.COM,8-3,1)+substring(b.COM,8-4,1)+substring(b.COM,8-5,1)+substring(b.COM,8-6,1)+substring(b.COM,8-7,1) AS BIGINT) & 0x000FFFFFFFFFFFFF) * POWER(CAST(2 AS FLOAT), -52))
			  * POWER(CAST(2 AS FLOAT), (CAST(substring(b.COM,8-0,1)+substring(b.COM,8-1,1)+substring(b.COM,8-2,1)+substring(b.COM,8-3,1)+substring(b.COM,8-4,1)+substring(b.COM,8-5,1)+substring(b.COM,8-6,1)+substring(b.COM,8-7,1) AS BIGINT) & 0x7ff0000000000000) / 0x0010000000000000 - 1023)
			, cast(substring(b.com,47,1) as int) as DefaultCheck
			, cast(substring(b.com,48,1) as int) as FreeOfCharge
			, 'None' as HNChargeType
	from	dnsysconfig a inner join  dnsysconfig_detail b on b.masterctrlcode = 42161 and b.additioncode = 'TREATMENT' and a.code = b.code

	left join
	(
	select
	a.code
	,cast(substring(a.com,21,8) as varchar) as incomecode
	,dbo.sysconname(cast(substring(a.com,21,8) as varchar(5)),43424,2) as incomelocalname
	,dbo.sysconname(cast(substring(a.com,21,8) as varchar(5)),43424,1) as incomeenglishname
	from dnsysconfig a
	left join dnsysconfig_detail b on a.code = b.code and a.ctrlcode = b.masterctrlcode and b.ctrlcode = 60023
	where a.ctrlcode = '42093'
	) as  oin on cast(substring(b.com,29,5) as varchar)  = oin.code
left join
(
select
a.code
,cast(substring(a.com,21,8) as varchar) as incomecode
,dbo.sysconname(cast(substring(a.com,21,8) as varchar(5)),43424,2) as incomelocalname
,dbo.sysconname(cast(substring(a.com,21,8) as varchar(5)),43424,1) as incomeenglishname
from dnsysconfig a
left join dnsysconfig_detail b on a.code = b.code and a.ctrlcode = b.masterctrlcode and b.ctrlcode = 60023
where a.ctrlcode = '42093'
) as  iin on cast(substring(b.com,35,5) as varchar)  = iin.code
left join
(
select
a.code
,cast(substring(a.com,21,8) as varchar) as incomecode
,dbo.sysconname(cast(substring(a.com,21,8) as varchar(5)),43424,2) as incomelocalname
,dbo.sysconname(cast(substring(a.com,21,8) as varchar(5)),43424,1) as incomeenglishname
from dnsysconfig a
left join dnsysconfig_detail b on a.code = b.code and a.ctrlcode = b.masterctrlcode and b.ctrlcode = 60023
where a.ctrlcode = '42093'
) as  cin on cast(substring(b.com,41,5) as varchar)  = cin.code
	where	a.ctrlcode = 42161 
			and a.com is not null
			--and a.code = 'TEST'

	union all 
	----------------- Medicine ----------------- 
	select	a.code as FacilityrequestMethodCode 
			, coalesce(dbo.cutsortchar(a.LocalName),'') as FacilityrequestMethod_LocalName
			, coalesce(dbo.cutsortchar(a.EngLishName),'') as FacilityrequestMethod_EngLishName
			--,'EffectiveDateFrom'=convert( varchar(10),dbo.BinarytoDate2(a.[Com],128),103)
			--,'EffectiveDateto'=convert( varchar(10),dbo.BinarytoDate2(a.[Com],132),103)
			, '' as EffectiveDateFrom
			, '' as EffectiveDateto
			, cast(substring(a.com,2,1) as int) as [Off]
			, 'MEDICINE' as ItemType
			, cast(substring(b.com,17,6) as varchar(6)) as store
			, cast(substring(b.com,23,12) as varchar(12)) as ItemCode
			, coalesce(dbo.cutsortchar(c.LocalName),'') as ItemName_Local
			, coalesce(dbo.cutsortchar(c.EngLishName),'') as ItemName_English
			, cast(substring(b.com,61,5) as varchar(10)) as HNActivityCodeOPD
			, dbo.sysconname(cast(substring(b.com,61,5) as varchar(10)),42093,2) as HNActivityNameOPD_Local
			, dbo.sysconname(cast(substring(b.com,61,5) as varchar(10)),42093,1) as HNActivityNameOPD_English
			,oin.incomelocalname as incomelocalnameopd
			, cast(substring(b.com,67,5) as varchar(10)) as HNActivityCodeIPD
			, dbo.sysconname(cast(substring(b.com,67,5) as varchar(10)),42093,2) as HNActivityNameIPD_Local
			, dbo.sysconname(cast(substring(b.com,67,5) as varchar(10)),42093,1) as HNActivityNameIPD_English
			,iin.incomelocalname as incomelocalnameipd
			, cast(substring(b.com,73,5) as varchar(10)) as HNActivityCodeCheckup
			, dbo.sysconname(cast(substring(b.com,73,5) as varchar(10)),42093,2) as HNActivityNameCheckup_Local
			, dbo.sysconname(cast(substring(b.com,73,5) as varchar(10)),42093,1) as HNActivityNameCheckup_English
			,cin.incomelocalname as incomelocalnameChk
			, 'Qty' = SIGN(CAST(substring(b.COM,8-0,1)+substring(b.COM,8-1,1)+substring(b.COM,8-2,1)+substring(b.COM,8-3,1)+substring(b.COM,8-4,1)+substring(b.COM,8-5,1)+substring(b.COM,8-6,1)+substring(b.COM,8-7,1) AS BIGINT))
			  *(1.0 + (CAST(substring(b.COM,8-0,1)+substring(b.COM,8-1,1)+substring(b.COM,8-2,1)+substring(b.COM,8-3,1)+substring(b.COM,8-4,1)+substring(b.COM,8-5,1)+substring(b.COM,8-6,1)+substring(b.COM,8-7,1) AS BIGINT) & 0x000FFFFFFFFFFFFF) * POWER(CAST(2 AS FLOAT), -52))
			  * POWER(CAST(2 AS FLOAT), (CAST(substring(b.COM,8-0,1)+substring(b.COM,8-1,1)+substring(b.COM,8-2,1)+substring(b.COM,8-3,1)+substring(b.COM,8-4,1)+substring(b.COM,8-5,1)+substring(b.COM,8-6,1)+substring(b.COM,8-7,1) AS BIGINT) & 0x7ff0000000000000) / 0x0010000000000000 - 1023)
			, 'Price' = SIGN(CAST(substring(b.COM,16-0,1)+substring(b.COM,16-1,1)+substring(b.COM,16-2,1)+substring(b.COM,16-3,1)+substring(b.COM,16-4,1)+substring(b.COM,16-5,1)+substring(b.COM,16-6,1)+substring(b.COM,16-7,1) AS BIGINT))
			  *(1.0 + (CAST(substring(b.COM,16-0,1)+substring(b.COM,16-1,1)+substring(b.COM,16-2,1)+substring(b.COM,16-3,1)+substring(b.COM,16-4,1)+substring(b.COM,16-5,1)+substring(b.COM,16-6,1)+substring(b.COM,16-7,1) AS BIGINT) & 0x000FFFFFFFFFFFFF) * POWER(CAST(2 AS FLOAT), -52))
			  * POWER(CAST(2 AS FLOAT), (CAST(substring(b.COM,16-0,1)+substring(b.COM,16-1,1)+substring(b.COM,16-2,1)+substring(b.COM,16-3,1)+substring(b.COM,16-4,1)+substring(b.COM,16-5,1)+substring(b.COM,16-6,1)+substring(b.COM,16-7,1) AS BIGINT) & 0x7ff0000000000000) / 0x0010000000000000 - 1023)
			, '' as DefaultCheck
			, '' as FreeOfCharge
			, case when cast(substring(b.com,80,1) as int) = 0 then 'None'  
			  when cast(substring(b.com,80,1) as int) = 1 then 'FreeOfCharge ' 
			  when cast(substring(b.com,80,1) as int) = 2 then 'Refund' 
			  when cast(substring(b.com,80,1) as int) = 3 then 'Adjust' 
			  when cast(substring(b.com,80,1) as int) = 5 then 'ChargeByDefault' 
			  when cast(substring(b.com,80,1) as int) = 6 then 'FreeOfChargeReturn ' end as HNChargeType
	from	dnsysconfig a inner join  dnsysconfig_detail b on b.masterctrlcode = 42161 and b.additioncode = 'MEDICINE' and a.code = b.code
			left join stockmaster c on cast(substring(b.com,23,12) as varchar(12)) = c.stockcode
				left join
(
select
a.code
,cast(substring(a.com,21,8) as varchar) as incomecode
,dbo.sysconname(cast(substring(a.com,21,8) as varchar(5)),43424,2) as incomelocalname
,dbo.sysconname(cast(substring(a.com,21,8) as varchar(5)),43424,1) as incomeenglishname
from dnsysconfig a
left join dnsysconfig_detail b on a.code = b.code and a.ctrlcode = b.masterctrlcode and b.ctrlcode = 60023
where a.ctrlcode = '42093'
) as  oin on cast(substring(b.com,61,5) as varchar)  = oin.code
left join
(
select
a.code
,cast(substring(a.com,21,8) as varchar) as incomecode
,dbo.sysconname(cast(substring(a.com,21,8) as varchar(5)),43424,2) as incomelocalname
,dbo.sysconname(cast(substring(a.com,21,8) as varchar(5)),43424,1) as incomeenglishname
from dnsysconfig a
left join dnsysconfig_detail b on a.code = b.code and a.ctrlcode = b.masterctrlcode and b.ctrlcode = 60023
where a.ctrlcode = '42093'
) as  iin on cast(substring(b.com,67,5) as varchar)  = iin.code
left join
(
select
a.code
,cast(substring(a.com,21,8) as varchar) as incomecode
,dbo.sysconname(cast(substring(a.com,21,8) as varchar(5)),43424,2) as incomelocalname
,dbo.sysconname(cast(substring(a.com,21,8) as varchar(5)),43424,1) as incomeenglishname
from dnsysconfig a
left join dnsysconfig_detail b on a.code = b.code and a.ctrlcode = b.masterctrlcode and b.ctrlcode = 60023
where a.ctrlcode = '42093'
) as  cin on cast(substring(b.com,73,5) as varchar)  = cin.code

	where	a.ctrlcode = 42161
			and a.com is not null
			--and a.code = 'TEST'
	union all 
	----------------- LAB ----------------- 	
	select	a.code as FacilityrequestMethodCode 
			, coalesce(dbo.cutsortchar(a.LocalName),'') as FacilityrequestMethod_LocalName
			, coalesce(dbo.cutsortchar(a.EngLishName),'') as FacilityrequestMethod_EngLishName
			--,'EffectiveDateFrom'=convert( varchar(10),dbo.BinarytoDate2(a.[Com],128),103)
			--,'EffectiveDateto'=convert( varchar(10),dbo.BinarytoDate2(a.[Com],132),103)
			, '' as EffectiveDateFrom
			, '' as EffectiveDateto 
			, cast(substring(a.com,2,1) as int) as [Off]
			, 'LAB' as ItemType
			, '' as store
			, cast(substring(b.com,9,12) as varchar(12)) as ItemCode
			, dbo.sysconname(cast(substring(b.com,9,12) as varchar(10)),42136,2) as ItemName_Local
			, dbo.sysconname(cast(substring(b.com,9,12) as varchar(10)),42136,1) as ItemName_English
			, cast(substring(b.com,35,5) as varchar(10)) as HNActivityCodeOPD	
			, dbo.sysconname(cast(substring(b.com,35,5) as varchar(10)),42093,2) as HNActivityNameOPD_Local
			, dbo.sysconname(cast(substring(b.com,35,5) as varchar(10)),42093,1) as HNActivityNameOPD_English
			,oin.incomelocalname
			, cast(substring(b.com,41,5) as varchar(10)) as HNActivityCodeIPD
			, dbo.sysconname(cast(substring(b.com,41,5) as varchar(10)),42093,2) as HNActivityNameIPD_Local
			, dbo.sysconname(cast(substring(b.com,41,5) as varchar(10)),42093,1) as HNActivityNameIPD_English
			,iin.incomelocalname
			, cast(substring(b.com,47,5) as varchar(10)) as HNActivityCodeCheckup
			, dbo.sysconname(cast(substring(b.com,47,5) as varchar(10)),42093,2) as HNActivityNameCheckup_Local
			, dbo.sysconname(cast(substring(b.com,47,5) as varchar(10)),42093,1) as HNActivityNameCheckup_English
			,cin.incomelocalname
			, '1' as Qty
			, 'Price' = SIGN(CAST(substring(b.COM,8-0,1)+substring(b.COM,8-1,1)+substring(b.COM,8-2,1)+substring(b.COM,8-3,1)+substring(b.COM,8-4,1)+substring(b.COM,8-5,1)+substring(b.COM,8-6,1)+substring(b.COM,8-7,1) AS BIGINT))
			  *(1.0 + (CAST(substring(b.COM,8-0,1)+substring(b.COM,8-1,1)+substring(b.COM,8-2,1)+substring(b.COM,8-3,1)+substring(b.COM,8-4,1)+substring(b.COM,8-5,1)+substring(b.COM,8-6,1)+substring(b.COM,8-7,1) AS BIGINT) & 0x000FFFFFFFFFFFFF) * POWER(CAST(2 AS FLOAT), -52))
			  * POWER(CAST(2 AS FLOAT), (CAST(substring(b.COM,8-0,1)+substring(b.COM,8-1,1)+substring(b.COM,8-2,1)+substring(b.COM,8-3,1)+substring(b.COM,8-4,1)+substring(b.COM,8-5,1)+substring(b.COM,8-6,1)+substring(b.COM,8-7,1) AS BIGINT) & 0x7ff0000000000000) / 0x0010000000000000 - 1023)
			, cast(substring(b.com,53,1) as int) as DefaultCheck
			, cast(substring(b.com,54,1) as int) as FreeOfCharge
			, 'None' as HNChargeType
	from	dnsysconfig a inner join  dnsysconfig_detail b on b.masterctrlcode = 42161 and b.additioncode = 'LAB' and a.code = b.code

	left join
(
select
a.code
,cast(substring(a.com,21,8) as varchar) as incomecode
,dbo.sysconname(cast(substring(a.com,21,8) as varchar(5)),43424,2) as incomelocalname
,dbo.sysconname(cast(substring(a.com,21,8) as varchar(5)),43424,1) as incomeenglishname
from dnsysconfig a
left join dnsysconfig_detail b on a.code = b.code and a.ctrlcode = b.masterctrlcode and b.ctrlcode = 60023
where a.ctrlcode = '42093'
) as  oin on cast(substring(b.com,35,5) as varchar)  = oin.code
left join
(
select
a.code
,cast(substring(a.com,21,8) as varchar) as incomecode
,dbo.sysconname(cast(substring(a.com,21,8) as varchar(5)),43424,2) as incomelocalname
,dbo.sysconname(cast(substring(a.com,21,8) as varchar(5)),43424,1) as incomeenglishname
from dnsysconfig a
left join dnsysconfig_detail b on a.code = b.code and a.ctrlcode = b.masterctrlcode and b.ctrlcode = 60023
where a.ctrlcode = '42093'
) as  iin on cast(substring(b.com,41,5) as varchar)  = iin.code
left join
(
select
a.code
,cast(substring(a.com,21,8) as varchar) as incomecode
,dbo.sysconname(cast(substring(a.com,21,8) as varchar(5)),43424,2) as incomelocalname
,dbo.sysconname(cast(substring(a.com,21,8) as varchar(5)),43424,1) as incomeenglishname
from dnsysconfig a
left join dnsysconfig_detail b on a.code = b.code and a.ctrlcode = b.masterctrlcode and b.ctrlcode = 60023
where a.ctrlcode = '42093'
) as  cin on cast(substring(b.com,47,5) as varchar)  = cin.code
	where	a.ctrlcode = 42161
			and a.com is not null
			--and a.code = 'TEST'
	union all 
	----------------- XRAY ----------------- 	
	select	a.code as FacilityrequestMethodCode 
			, coalesce(dbo.cutsortchar(a.LocalName),'') as FacilityrequestMethod_LocalName
			, coalesce(dbo.cutsortchar(a.EngLishName),'') as FacilityrequestMethod_EngLishName
			--,'EffectiveDateFrom'=convert( varchar(10),dbo.BinarytoDate2(a.[Com],128),103)
			--,'EffectiveDateto'=convert( varchar(10),dbo.BinarytoDate2(a.[Com],132),103)
			, '' as EffectiveDateFrom
			, '' as EffectiveDateto
			, cast(substring(a.com,2,1) as int) as [Off]
			, 'XRAY' as ItemType
			, '' as store
			, cast(substring(b.com,17,10) as varchar(10)) as ItemCode
			, dbo.sysconname(cast(substring(b.com,17,10) as varchar(10)),42179,2) as ItemName_Local
			, dbo.sysconname(cast(substring(b.com,17,10) as varchar(10)),42179,1) as ItemName_English
			, cast(substring(b.com,27,5) as varchar(10)) as HNActivityCodeOPD
			, dbo.sysconname(cast(substring(b.com,27,5) as varchar(10)),42093,2) as HNActivityNameOPD_Local
			, dbo.sysconname(cast(substring(b.com,27,5) as varchar(10)),42093,1) as HNActivityNameOPD_English
			,oin.incomelocalname
			, cast(substring(b.com,33,5) as varchar(10)) as HNActivityCodeIPD
			, dbo.sysconname(cast(substring(b.com,33,5) as varchar(10)),42093,2) as HNActivityNameIPD_Local
			, dbo.sysconname(cast(substring(b.com,33,5) as varchar(10)),42093,1) as HNActivityNameIPD_English
			,iin.incomelocalname
			, cast(substring(b.com,39,5) as varchar(10)) as HNActivityCodeCheckup
			, dbo.sysconname(cast(substring(b.com,39,5) as varchar(10)),42093,2) as HNActivityNameCheckup_Local
			, dbo.sysconname(cast(substring(b.com,39,5) as varchar(10)),42093,1) as HNActivityNameCheckup_English
			,cin.incomelocalname
			, '1' as Qty
			, 'Price' = SIGN(CAST(substring(b.COM,8-0,1)+substring(b.COM,8-1,1)+substring(b.COM,8-2,1)+substring(b.COM,8-3,1)+substring(b.COM,8-4,1)+substring(b.COM,8-5,1)+substring(b.COM,8-6,1)+substring(b.COM,8-7,1) AS BIGINT))
			  *(1.0 + (CAST(substring(b.COM,8-0,1)+substring(b.COM,8-1,1)+substring(b.COM,8-2,1)+substring(b.COM,8-3,1)+substring(b.COM,8-4,1)+substring(b.COM,8-5,1)+substring(b.COM,8-6,1)+substring(b.COM,8-7,1) AS BIGINT) & 0x000FFFFFFFFFFFFF) * POWER(CAST(2 AS FLOAT), -52))
			  * POWER(CAST(2 AS FLOAT), (CAST(substring(b.COM,8-0,1)+substring(b.COM,8-1,1)+substring(b.COM,8-2,1)+substring(b.COM,8-3,1)+substring(b.COM,8-4,1)+substring(b.COM,8-5,1)+substring(b.COM,8-6,1)+substring(b.COM,8-7,1) AS BIGINT) & 0x7ff0000000000000) / 0x0010000000000000 - 1023)
			, cast(substring(b.com,45,1) as int) as DefaultCheck
			, cast(substring(b.com,46,1) as int) as FreeOfCharge
			, 'None' as HNChargeType
	from	dnsysconfig a inner join  dnsysconfig_detail b on b.masterctrlcode = 42161 and b.additioncode = 'XRAY' and a.code = b.code

	left join
(
select
a.code
,cast(substring(a.com,21,8) as varchar) as incomecode
,dbo.sysconname(cast(substring(a.com,21,8) as varchar(5)),43424,2) as incomelocalname
,dbo.sysconname(cast(substring(a.com,21,8) as varchar(5)),43424,1) as incomeenglishname
from dnsysconfig a
left join dnsysconfig_detail b on a.code = b.code and a.ctrlcode = b.masterctrlcode and b.ctrlcode = 60023
where a.ctrlcode = '42093'
) as  oin on cast(substring(b.com,27,5) as varchar)  = oin.code
left join
(
select
a.code
,cast(substring(a.com,21,8) as varchar) as incomecode
,dbo.sysconname(cast(substring(a.com,21,8) as varchar(5)),43424,2) as incomelocalname
,dbo.sysconname(cast(substring(a.com,21,8) as varchar(5)),43424,1) as incomeenglishname
from dnsysconfig a
left join dnsysconfig_detail b on a.code = b.code and a.ctrlcode = b.masterctrlcode and b.ctrlcode = 60023
where a.ctrlcode = '42093'
) as  iin on cast(substring(b.com,33,5) as varchar)  = iin.code
left join
(
select
a.code
,cast(substring(a.com,21,8) as varchar) as incomecode
,dbo.sysconname(cast(substring(a.com,21,8) as varchar(5)),43424,2) as incomelocalname
,dbo.sysconname(cast(substring(a.com,21,8) as varchar(5)),43424,1) as incomeenglishname
from dnsysconfig a
left join dnsysconfig_detail b on a.code = b.code and a.ctrlcode = b.masterctrlcode and b.ctrlcode = 60023
where a.ctrlcode = '42093'
) as  cin on cast(substring(b.com,39,5) as varchar)  = cin.code
	where	a.ctrlcode = 42161
			and a.com is not null
			--and a.code = 'TEST'
)a 
where a.[off] <> 1 
--and (a.EffectiveDateto is null or right(EffectiveDateto,4) >= '2023')
--and a.EffectiveDateto is not null
order by a.FacilityrequestMethodCode, a.ItemType
