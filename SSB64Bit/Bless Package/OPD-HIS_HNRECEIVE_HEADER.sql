use SSBLIVE
go

select 'PT2' as BU,
		'OPD' as OPD_IPD,
		a.VisitDate as Visitdate_AdmDateTime,
		a.VN as VN_AN,
		a.ReceiptNo,
		a.ReceiveDateTime,
		a.ReceiptSuffixTiny as ReceiptSeqNo,
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
		when a.HNReceiptFormCode = 'O09' then 'Discount_Bill'
		else 'Over Package_Bill' end
		as Bill_Type, --> Package_Bill ,Over Package_Bill ,Discount_Bill 

		a.FromChargeAmt - a.DiscountAmt as NetAmt,
		('PT2-' + format(a.VisitDate,'dd/MM/yyyy') + '-' + a.vn) as AN_VN_KEY,
		'HIS' as Source_System,
		NULL as Interface_Datetime,
		NULL as Period_Interface
from	HNOPD_RECEIVE_HEADER a
		inner join HNOPD_MASTER b on a.VN=b.VN and a.VisitDate=b.VisitDate
		left join ARMASTER ar on a.ARCode=ar.ARCode
		left join
		(
			select	b.VisitDate
					, b.VN
					, b.ReceiptSuffixTiny
					, SUBSTRING(c.FacilityRequestMethod,1,1) as FacilityRequestMethod
					, sum(case when b.HNChargeType = 1 then 0  
					  when b.HNChargeType = 2 then (b.FromChargeAmt * -1)
					  else b.FromChargeAmt end)  FromChargeAmt
			from	HNOPD_RECEIVE_ITEM b
					inner join HNOPD_PRESCRIP_TREATMENT c on b.VN=c.VN and b.VisitDate=c.VisitDate and b.PrescriptionNo=c.PrescriptionNo and b.TreatmentSuffixTiny=c.SuffixTiny and b.MakeDateTime=c.MakeDateTime
			where	1=1
					and SUBSTRING(c.FacilityRequestMethod,1,1) in ('I', 'M', 'N', 'R', 'H', 'S', 'P')
			group by 
			b.VisitDate
			, b.VN
			, b.ReceiptSuffixTiny
			, SUBSTRING(c.FacilityRequestMethod,1,1)
		)fr on fr.VisitDate = a.VisitDate and fr.VN = a.VN and fr.ReceiptSuffixTiny = a.ReceiptSuffixTiny
		inner join 
		(
			select	distinct 
					a2.VisitDate
					, a2.VN
			from	HNOPD_PRESCRIP a2
			where	1=1
					and a2.HNPackageCode is not null 
		)hp on hp.VisitDate = a.VisitDate and hp.VN = a.VN
where	1=1
		and a.VisitDate = '2026-11-22'
		and a.HereStatement = 0
		and a.HNReceiptFormCode != 'O05'
order by a.VisitDate, a.VN, a.ReceiptSuffixTiny