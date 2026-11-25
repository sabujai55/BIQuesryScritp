use SSBLIVE	
go
select 'PT2' as BU
		, 'OPD' as OPD_IPD
		, a.VisitDate as Visitdate_AdmDateTime
		, a.VN as VN_AN
		, a.ReceiptSuffixTiny as ReceiptSeqNo
		, b.SuffixSmall as TRX_LineNo
		, NULL as IPDChargeDateTime
		, NULL as IPDChargeSuffixTiny
		, b.MakeDateTime
		, b.TreatmentSuffixTiny
		, b.MedcineSuffixTiny
		, b.HNActivityCode
		, b.FromChargeAmt
		, b.DiscountAmt
		, b.HNChargeType
		, NULL as HNBedNo
		, b.PayForVisitDate
		, b.PayForVN
		, b.PrescriptionNo
		, NULL as ChargeMedicineSuffixSmallList
		, NULL as ChargeMedicineAmtList
		, ('PT2-' + format(a.VisitDate,'dd/MM/yyyy') + '-' + a.vn) as AN_VN_KEY
		, 'HIS' as Source_System
		, NULL as Interface_Datetime
		, NULL as Period_Interface
from	HNOPD_RECEIVE_HEADER a
		inner join HNOPD_RECEIVE_ITEM b on a.VN=b.VN and a.VisitDate=b.VisitDate and a.ReceiptSuffixTiny=b.ReceiptSuffixTiny
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
order by a.VisitDate, a.VN, a.ReceiptSuffixTiny, b.SuffixSmall