select	'PTS' as BU
		, a.Code as PackageCode
		, a.LocalName as PackageNameTH --modify 2026-03-18
		, a.EnglishName as PackageNameEN --modify 2026-03-18
		, a.UseOnlyIpdOpdType as UseOnlyIpdOpdType --modify 2026-03-18
		, case when a.UseOnlyIpdOpdType = 0 then 'None'
			  when a.UseOnlyIpdOpdType = 1 then 'IPD'
			  when a.UseOnlyIpdOpdType = 2 then 'OPD'
			  when a.UseOnlyIpdOpdType = 3 then 'OPD'
			  when a.UseOnlyIpdOpdType = 4 then 'IPD OPD'
			  when a.UseOnlyIpdOpdType = 5 then 'LR'
			  when a.UseOnlyIpdOpdType = 6 then 'OR'
			  when a.UseOnlyIpdOpdType = 7 then 'LR OR'
			  end as UseOnlyIpdOpdTypeName --modify 2026-03-18
		, a.RuleCode as [Rule] --modify 2026-03-18
		, coalesce(dbo.sysconname(a.RuleCode,42111,2),'') as RuleNameTH --modify 2026-03-18
		, coalesce(dbo.sysconname(a.RuleCode,42111,1),'') as RuleNameEN --modify 2026-03-18
		, a.ReceiptForm --modify 2026-03-18
		, coalesce(dbo.sysconname(a.ReceiptForm,42101,2),'') as ReceiptFormNameTH --modify 2026-03-18
		, coalesce(dbo.sysconname(a.ReceiptForm,42101,1),'') as ReceiptFormNameEN --modify 2026-03-18
		, a.PriceCategoryCode as PriceCategory --modify 2026-03-18
		, coalesce(dbo.sysconname(a.PriceCategoryCode,10451,2),'') as PriceCategoryNameTH --modify 2026-03-18
		, coalesce(dbo.sysconname(a.PriceCategoryCode,10451,1),'') as PriceCategoryNameEN --modify 2026-03-18
		, a.HNActivityCodeForGain asHNActivityForGain --modify 2026-03-18
		, coalesce(dbo.sysconname(a.HNActivityCodeForGain,42093,2),'') as HNActivityForGainNameTH --modify 2026-03-18
		, coalesce(dbo.sysconname(a.HNActivityCodeForGain,42093,1),'') as HNActivityForGainNameEN --modify 2026-03-18
		, a.HNActivityCodeForLoss as HNActivityForLoss --modify 2026-03-18
		, coalesce(dbo.sysconname(a.HNActivityCodeForLoss,42093,2),'') as HNActivityForLossNameTH --modify 2026-03-18
		, coalesce(dbo.sysconname(a.HNActivityCodeForLoss,42093,1),'') as HNActivityForLossNameEN --modify 2026-03-18
		, a.EffectiveDateFrom --modify 2026-03-18
		, a.EffectiveDateTo --modify 2026-03-18
		, a.PackageAmt --modify 2026-03-18
		, a.DiscountCodeForLoss --modify 2026-03-18
		, coalesce(dbo.sysconname(a.DiscountCodeForLoss,42084,2),'') as DiscountCodeForLossNameTH --modify 2026-03-18
		, coalesce(dbo.sysconname(a.DiscountCodeForLoss,42084,1),'') as DiscountCodeForLossNameEN --modify 2026-03-18
		, coalesce(b.memo,'') as Memo --modify 2026-03-18
		from	DEVDECRYPT.dbo.PYTS_SETUP_HN_PACKAGE a --modify 2026-03-18
		inner join DNSYSCONFIG b on a.Code=b.Code and b.CtrlCode = 43541 --modify 2026-03-18
