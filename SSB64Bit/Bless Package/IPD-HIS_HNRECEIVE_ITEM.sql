use SSBLIVE	
go
select 'PT2' as BU
		, 'IPD' as OPD_IPD
		, b.AdmDateTime as Visitdate_AdmDateTime
		, a.AN as VN_AN
		, a.InvoiceSuffixSmall as ReceiptSeqNo
		, c.SuffixSmall as TRX_LineNo
		, c.IPDChargeDateTime
		, c.IPDChargeSuffixTiny
		, NULL as MakeDateTime
		, NULL as TreatmentSuffixTiny
		, NULL as MedcineSuffixTiny
		, c.HNActivityCode
		, c.FromChargeAmt
		, c.DiscountAmt
		, c.HNChargeType
		, b.ActiveHNBedNo as HNBedNo
		, NULL as PayForVisitDate
		, NULL as PayForVN
		, NULL as PrescriptionNo
		, c.ChargeMedicineSuffixSmallList
		, c.ChargeMedicineAmtList
		, ('PT2-' + a.AN) as AN_VN_KEY
		, 'HIS' as Source_System
		, NULL as Interface_Datetime
		, NULL as Period_Interface
from	HNIPD_INVOICE_HEADER a
		inner join HNIPD_MASTER b on b.AN = a.AN
		inner join HNIPD_INVOICE_ITEM c on c.AN = a.AN and c.InvoiceSuffixSmall = a.InvoiceSuffixSmall
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