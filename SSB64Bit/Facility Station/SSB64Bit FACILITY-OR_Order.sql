select chg.*
from
(
select	'PT2' as BU
		, a.HN as PatientID
		, a.FacilityRmsNo
		, a.RequestNo
		, b.EntryDateTime
		, b.ChargeDateTime
		, b.SuffixSmall
		, c.SuffixSmall as ChargeSuffix
		, b.StockCode as ItemCode
		, dbo.CutSortChar(d.LocalName) as ItemNameTH
		, dbo.CutSortChar(d.EnglishName) as ItemNameEN
		, b.HNActivityCode as ActivityCode
		, dbo.CutSortChar(sys01.LocalName) as ActivityNameTH
		, dbo.CutSortChar(sys01.EnglishName) as ActivityNameEN
		, Case when b.HNChargeType = 0 then 'None' 
		  when b.HNChargeType = 1 then 'Free' 
		  when b.HNChargeType = 2 then 'Refund'
		  when b.HNChargeType = 6 then 'Free Return'
		  end AS 'ChargeType'
		, b.UnitPrice
		, b.Qty
		, b.ChargeAmt
		, '' as Doctor
		, '' as DoctorNameTH
		, '' as DoctorNameEN
		, '' as DFDoctor
		, '' as DFDoctorNameTH
		, '' as DFDoctorNameEN
		, b.RightCode
		, dbo.CutSortChar(sys02.LocalName) as RightNameTH
		, dbo.CutSortChar(sys02.EnglishName) as RightNameEN
		, '' as TreatmentDateTime
		, '' as NoMinuteDuration
		, case when b.HNORPostByType = 0 then 'None'
		  when b.HNORPostByType = 1 then 'OR'
		  when b.HNORPostByType = 1 then 'Anes' end as HNORPostByType
		, 'Y' as Usage
		, c.ChargeVisitDate
		, c.ChargeVN
		, c.PrescriptionNo
		, c.IPDChargeDateTime
		, c.ChargeAN
		, c.ChargeVoucherNo
from	HNORREQ_HEADER a 
		inner join HNORREQ_USAGE b on a.FacilityRmsNo = b.FacilityRmsNo and a.RequestNo = b.RequestNo
		left join HNORREQ_CHARGE c on b.FacilityRmsNo = c.FacilityRmsNo and b.RequestNo = c.RequestNo and b.HNActivityCode = c.HNActivityCode and b.ChargeDateTime = c.ChargeDateTime and b.ChargeAmt = c.ChargeAmt
		inner join STOCKMASTER d on b.StockCode = d.StockCode
		inner join DNSYSCONFIG sys01 on sys01.CtrlCode = 42093 and b.HNActivityCode = sys01.Code
		inner join DNSYSCONFIG sys02 on sys02.CtrlCode = 42086 and b.RightCode = sys02.Code
where	a.ORBeginDateTimePlan between '2025-05-01 00:00:00' and '2025-05-01 23:59:59'
union all 
select	'PT2' as BU
		, a.HN as PatientID
		, a.FacilityRmsNo
		, a.RequestNo
		, b.ChargeDateTime as EntryDateTime
		, b.ChargeDateTime
		, b.SuffixSmall
		, c.SuffixSmall as ChargeSuffix
		, b.TreatmentCode as ItemCode
		, dbo.CutSortChar(sys01.LocalName) as ItemNameTH
		, dbo.CutSortChar(sys01.EnglishName) as ItemNameEN
		, b.HNActivityCode as ActivityCode
		, dbo.CutSortChar(sys02.LocalName) as ActivityNameTH
		, dbo.CutSortChar(sys02.EnglishName) as ActivityNameEN
		, Case when b.HNChargeType = 0 then 'None' 
		  when b.HNChargeType = 1 then 'Free' 
		  when b.HNChargeType = 2 then 'Refund'
		  when b.HNChargeType = 6 then 'Free Return'
		  end AS 'ChargeType'
		, b.UnitPrice
		, b.Qty
		, b.ChargeAmt
		, b.Doctor
		, dbo.CutSortChar(d1.LocalName) as DoctorNameTH
		, dbo.CutSortChar(d1.EnglishName) as DoctorNameEN
		, b.DFDoctor
		, dbo.CutSortChar(d1.LocalName) as DFDoctorNameTH
		, dbo.CutSortChar(d1.EnglishName) as DFDoctorNameEN
		, b.RightCode
		, dbo.CutSortChar(sys03.LocalName) as RightNameTH
		, dbo.CutSortChar(sys03.EnglishName) as RightNameEN
		, b.TreatmentDateTime
		, b.NoMinuteDuration
		, case when b.HNORPostByType = 0 then 'None'
		  when b.HNORPostByType = 1 then 'OR'
		  when b.HNORPostByType = 1 then 'Anes' end as HNORPostByType
		, 'N' as Usage
		, c.ChargeVisitDate
		, c.ChargeVN
		, c.PrescriptionNo
		, c.IPDChargeDateTime
		, c.ChargeAN
		, c.ChargeVoucherNo
from	HNORREQ_HEADER a 
		inner join HNORREQ_TREATMENT b on a.FacilityRmsNo = b.FacilityRmsNo and a.RequestNo = b.RequestNo
		left join HNORREQ_CHARGE c on b.FacilityRmsNo = c.FacilityRmsNo and b.RequestNo = c.RequestNo and b.HNActivityCode = c.HNActivityCode and b.ChargeDateTime = c.ChargeDateTime and b.ChargeAmt = c.ChargeAmt
		left join HNDOCTOR_MASTER d1 on b.Doctor = d1.Doctor
		left join HNDOCTOR_MASTER d2 on b.Doctor = d2.Doctor
		inner join DNSYSCONFIG sys01 on sys01.CtrlCode = 42075 and b.TreatmentCode = sys01.Code
		inner join DNSYSCONFIG sys02 on sys02.CtrlCode = 42093 and b.HNActivityCode = sys02.Code
		inner join DNSYSCONFIG sys03 on sys03.CtrlCode = 42086 and b.RightCode = sys03.Code
where	a.ORBeginDateTimePlan between '2025-05-01 00:00:00' and '2025-05-01 23:59:59'
)chg
order by chg.FacilityRmsNo, chg.RequestNo, chg.ChargeSuffix
