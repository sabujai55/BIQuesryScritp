use SSBLIVE
go

select	'PT2' as BU,
		'IPD' as OPD_IPD,
		b.AdmDateTime as Visitdate_AdmDateTime,
		a.AN as VN_AN,
		a.ReceiptNo,
		a.InvoiceDateTime as ReceiveDateTime,
		a.InvoiceSuffixSmall as ReceiptSeqNo,
		a.HNPackageCode ,
		a.ARCode as ARCode,
		dbo.CutSortChar(ar.EnglishName) as ARCodeEN,
		dbo.CutSortChar(ar.LocalName) as ARCodeTH,
		
		a.RightCode as RightCode,
		dbo.sysconname(a.RightCode,42086,1) as RightCodeEN,
		dbo.sysconname(a.RightCode,42086,2) as RightCodeTH,

		a.HNReceiptFormCode,
		dbo.sysconname(a.HNReceiptFormCode,42101,1) as HNReceiptFormCodeEN,
		dbo.sysconname(a.HNReceiptFormCode,42101,2) as HNReceiptFormCodeTH,
		
		a.HNDiscountCode,
		dbo.sysconname(a.HNDiscountCode,42084,1) as HNDiscountCodeEN,
		dbo.sysconname(a.HNDiscountCode,42084,2) as HNDiscountCodeTH,
		
		a.FromChargeAmt,
		a.DiscountAmt,

		case when fr.FacilityRequestMethod is not null then 'Yes' 
		else 'No' end as Fac_Flg, --> ตรวจสอบตัวอักษรแรกของค่าของ  Column : FacilityRequestMethod ถ้าตัวอักษรแรกเป็นหนึ่งใน I, M, N, R, H, S, P → คืนค่า "Yes"]

		case when fr.FacilityRequestMethod in ('I','M','N','R') then fr.FromChargeAmt
		else 0 end as Fac_Package_FromChargeAmt, --> FacilityRequestMethod = I,M,N,R Sum(HNOPD_RECEIVE_ITEM.FromChargeAmt)
		case when fr.FacilityRequestMethod in ('H','S','P') then fr.FromChargeAmt
		else 0 end as Fac_Corporate_FromChargeAmt, --> FacilityRequestMethod =  H,S,P Sum(HNOPD_RECEIVE_ITEM.FromChargeAmt)

		a.HNDiscountReasonCode,
		dbo.sysconname(a.HNDiscountReasonCode,42082,2) as HNDiscountCodeTH,

		a.CxlDateTime,
		a.CxlReasonCode,
		a.CxlRemarks,

		case when a.HNPackageCode is not null then 'Package_Bill'
		when a.HNReceiptFormCode = 'I09' then 'Discount_Bill'
		else 'Over Package_Bill' end
		as Bill_Type, --> Package_Bill ,Over Package_Bill ,Discount_Bill 

		a.FromChargeAmt - a.DiscountAmt as NetAmt,
		('PT2-' + a.AN) as AN_VN_KEY,
		'HIS' as Source_System,
		NULL as Interface_Datetime,
		NULL as Period_Interface
from	HNIPD_INVOICE_HEADER a
		inner join HNIPD_MASTER b on b.AN = a.AN
		left join ARMASTER ar on ar.ARCode = a.ARCode
		left join 
		(
			select	a.AN
					, a.InvoiceSuffixSmall
					, SUBSTRING(b.FacilityRequestMethod,1,1) as FacilityRequestMethod
					, sum(case when a.HNChargeType = 1 then 0  
					  when a.HNChargeType = 2 then (a.FromChargeAmt * -1)
					  else a.FromChargeAmt end)  FromChargeAmt
			from	HNIPD_INVOICE_ITEM a
					inner join HNIPD_CHARGE b on b.AN = a.AN and b.IPDChargeDateTime = a.IPDChargeDateTime and b.IPDChargeSuffixTiny = a.IPDChargeSuffixTiny
			where	1=1
					and SUBSTRING(b.FacilityRequestMethod,1,1) in ('I', 'M', 'N', 'R', 'H', 'S', 'P')
			group by 
			a.AN
			, a.InvoiceSuffixSmall
			, SUBSTRING(b.FacilityRequestMethod,1,1)
		)fr on fr.AN = a.AN and fr.InvoiceSuffixSmall = a.InvoiceSuffixSmall
where	1=1
		--and a.InvoiceDateTime between '2026-11-22 00:00:00' and '2026-11-23 23:59:59'
		and b.DischargeDateTime between '2026-11-22 00:00:00' and '2026-11-22 23:59:59'
		and a.HereStatement= 0
		and b.HNPackageCode is not null
order by a.AN, a.InvoiceSuffixSmall