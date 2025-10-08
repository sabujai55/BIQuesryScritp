use SSBLIVE
go
--42084

select	'PT2' as BU
		, a.Code as PackageCode
		, coalesce(a.LocalName,'') as PackageNameTH
		, coalesce(a.EnglishName,'') as PackageNameEN
		, a.UseOnlyIpdOpdTypeId as UseOnlyIpdOpdType
		, a.UseOnlyIpdOpdTypeName
		, a.[Rule] 
		, coalesce(dbo.sysconname(a.[Rule],42111,2),'') as RuleNameTH
		, coalesce(dbo.sysconname(a.[Rule],42111,1),'') as RuleNameEN
		, a.ReceiptForm
		, coalesce(dbo.sysconname(a.ReceiptForm,42101,2),'') as ReceiptFormNameTH
		, coalesce(dbo.sysconname(a.ReceiptForm,42101,1),'') as ReceiptFormNameEN
		, a.PriceCategory
		, coalesce(dbo.sysconname(a.PriceCategory,10451,2),'') as PriceCategoryNameTH
		, coalesce(dbo.sysconname(a.PriceCategory,10451,1),'') as PriceCategoryNameEN
		, a.HNActivityForGain
		, coalesce(dbo.sysconname(a.HNActivityForGain,42093,2),'') as HNActivityForGainNameTH
		, coalesce(dbo.sysconname(a.HNActivityForGain,42093,1),'') as HNActivityForGainNameEN
		, a.HNActivityForLoss
		, coalesce(dbo.sysconname(a.HNActivityForLoss,42093,2),'') as HNActivityForLossNameTH
		, coalesce(dbo.sysconname(a.HNActivityForLoss,42093,1),'') as HNActivityForLossNameEN
		, a.EffectiveFrom
		, a.EffectiveTo
		, a.PackageAmt
		, a.DiscountCodeForLoss
		, coalesce(dbo.sysconname(a.DiscountCodeForLoss,42084,2),'') as DiscountCodeForLossNameTH
		, coalesce(dbo.sysconname(a.DiscountCodeForLoss,42084,1),'') as DiscountCodeForLossNameEN
		, coalesce(a.Memo,'') as Memo
from	
(
	select	a.Code
			, dbo.CutSortChar(a.LocalName) as LocalName
			, dbo.CutSortChar(a.EnglishName) as EnglishName
			, cast(SUBSTRING(a.Com,1,1) as int) as UseOnlyIpdOpdTypeId
			, case when cast(SUBSTRING(a.Com,1,1) as int) = 0 then 'None'
			  when cast(SUBSTRING(a.Com,1,1) as int) = 1 then 'IPD'
			  when cast(SUBSTRING(a.Com,1,1) as int) = 2 then 'OPD'
			  when cast(SUBSTRING(a.Com,1,1) as int) = 3 then 'OPD'
			  when cast(SUBSTRING(a.Com,1,1) as int) = 4 then 'IPD OPD'
			  when cast(SUBSTRING(a.Com,1,1) as int) = 5 then 'LR'
			  when cast(SUBSTRING(a.Com,1,1) as int) = 6 then 'OR'
			  when cast(SUBSTRING(a.Com,1,1) as int) = 7 then 'LR OR'
			  end as UseOnlyIpdOpdTypeName
			, cast(SUBSTRING(a.Com,2,7) as varchar(7)) as [Rule]
			, cast(SUBSTRING(a.Com,8,7) as varchar(7)) as ReceiptForm
			, cast(SUBSTRING(a.Com,16,2) as varchar(2)) as PriceCategory
			, cast(SUBSTRING(a.Com,22,5) as varchar(5)) as HNActivityForGain
			, cast(SUBSTRING(a.Com,28,5) as varchar(5)) as HNActivityForLoss
			, '' as EffectiveFrom
			, '' as EffectiveTo
			, PackageAmt = SIGN(CAST(substring(a.COM,56-0,1)+substring(a.COM,56-1,1)+substring(a.COM,56-2,1)+substring(a.COM,56-3,1)+substring(a.COM,56-4,1)+substring(a.COM,56-5,1)+substring(a.COM,56-6,1)+substring(a.COM,56-7,1) AS BIGINT))
			  *(1.0 + (CAST(substring(a.COM,56-0,1)+substring(a.COM,56-1,1)+substring(a.COM,56-2,1)+substring(a.COM,56-3,1)+substring(a.COM,56-4,1)+substring(a.COM,56-5,1)+substring(a.COM,56-6,1)+substring(a.COM,56-7,1) AS BIGINT) & 0x000FFFFFFFFFFFFF) * POWER(CAST(2 AS FLOAT), -52))
			  * POWER(CAST(2 AS FLOAT), (CAST(substring(a.COM,56-0,1)+substring(a.COM,56-1,1)+substring(a.COM,56-2,1)+substring(a.COM,56-3,1)+substring(a.COM,56-4,1)+substring(a.COM,56-5,1)+substring(a.COM,56-6,1)+substring(a.COM,56-7,1) AS BIGINT) & 0x7ff0000000000000) / 0x0010000000000000 - 1023)
			, cast(SUBSTRING(a.Com,57,5) as varchar(5)) as DiscountCodeForLoss
			, a.Memo
	from	DNSYSCONFIG a
	where	a.CtrlCode = 43541
			--and a.Code = 'PAY01'
)a



