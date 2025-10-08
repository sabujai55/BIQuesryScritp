select top 10 
	'PT2' as BU
	, arp.ARCode
	, dbo.CutSortChar(ar.LocalName) as ARNameTH
	, dbo.CutSortChar(ar.EnglishName) as ARNameEN
	, arp.SuffixTiny
	, arp.EffectiveDateFrom
	, arp.EffectiveDateTo
	, arp.HNReceiveRuleCode
	, arp.DiscountCodeOPD
	, dbo.sysconname(arp.DiscountCodeOPD,42084,2) as DiscountOPDNameTH
	, dbo.sysconname(arp.DiscountCodeOPD,42084,1) as DiscountOPDNameEN
	, arp.ReceiveCodeOPD
	, dbo.sysconname(arp.ReceiveCodeOPD,42077,2) as ReceiveOPDNameTH
	, dbo.sysconname(arp.ReceiveCodeOPD,42077,1) as ReceiveOPDNameEN
	, arp.ReceiptFormOPD
	, dbo.sysconname(arp.ReceiptFormOPD,42101,2) as ReceiptFormOPDNameTH
	, dbo.sysconname(arp.ReceiptFormOPD,42101,2) as ReceiptFormOPDNameEN
	, arp.ServiceChargeCodeOPD
	, dbo.sysconname(arp.ServiceChargeCodeOPD,42081,2) as ServiceChargeOPDNameTH
	, dbo.sysconname(arp.ServiceChargeCodeOPD,42081,1) as ServiceChargeOPDNameEN
	, arp.ServiceChargeCodeNewOPD
	, dbo.sysconname(arp.ServiceChargeCodeNewOPD,42081,2) as ServiceChargeNewOPDNameTH
	, dbo.sysconname(arp.ServiceChargeCodeNewOPD,42081,1) as ServiceChargeNewOPDNameEN
	, arp.DiscountCodeIPD
	, dbo.sysconname(arp.DiscountCodeIPD,42084,2) as DiscountIPDNameTH
	, dbo.sysconname(arp.DiscountCodeIPD,42084,1) as DiscountIPDNameEN
	, arp.ReceiveCodeIPD
	, dbo.sysconname(arp.ReceiveCodeIPD,42077,2) as ReceiveIPDNameTH
	, dbo.sysconname(arp.ReceiveCodeIPD,42077,1) as ReceiveIPDNameEN
	, arp.ReceiptFormIPD
	, dbo.sysconname(arp.ReceiptFormIPD,42101,2) as ReceiptFormIPDNameTH
	, dbo.sysconname(arp.ReceiptFormIPD,42101,2) as ReceiptFormIPDNameEN
	, arp.ServiceChargeCodeIPD
	, dbo.sysconname(arp.ServiceChargeCodeIPD,42081,2) as ServiceChargeIPDNameTH
	, dbo.sysconname(arp.ServiceChargeCodeIPD,42081,1) as ServiceChargeIPDNameEN
	, arp.RightCodeOPD
	, dbo.sysconname(arp.RightCodeOPD,42086,2) as RightOPDNameTH
	, dbo.sysconname(arp.RightCodeOPD,42086,1) as RightOPDNameEN
	, arp.RightCodeIPD
	, dbo.sysconname(arp.RightCodeIPD,42086,2) as RightIPDNameTH
	, dbo.sysconname(arp.RightCodeIPD,42086,1) as RightIPDNameEN
	, arp.RplGlAccCode
	, arp.RemarksMemo
	, arp.LockReceiveCode
	, arp.LockDiscountCode
	, arp.LockReceiptForm
	, arp.NeedCertificate
	, MustBeAR
	, arp.ConfigTobeChange
		from ARMASTER_HN_PLAN arp
		inner join ARMASTER ar on arp.ARCode=ar.ARCode