select 
		 'PT2' as BU
		, lrh.HN as PatientID
		, lrc.FacilityRmsNo
		, lrc.RequestNo
		, lrc.ChargeDateTime
		, lrc.SuffixTiny
		, ISNULL(lru.StockCode,lroth.TreatmentCode) as ItemCode
		, case when lru.StockCode is not null then dbo.Stockname(lru.StockCode,2) else dbo.sysconname(lroth.TreatmentCode,42075,2) end as ItemNameTH
		, case when lru.StockCode is not null then dbo.Stockname(lru.StockCode,1) else dbo.sysconname(lroth.TreatmentCode,42075,1) end as ItemNameEN
		, lrc.HNActivityCode as ActivityCode
		, dbo.sysconname(lrc.HNActivityCode,42093,2) as ActivityNameTH
		, dbo.sysconname(lrc.HNActivityCode,42093,1) as ActivityNameEN
		,  Case when lrc.HNChargeType = 0 then 'None' 
		  when lrc.HNChargeType = 1 then 'Free' 
		  when lrc.HNChargeType = 2 then 'Refund'
		  when lrc.HNChargeType = 6 then 'Free Return'
		  end AS 'ChargeType'
		, ISNULL(lru.UnitPrice,lroth.UnitPrice) as UnitPrice
		, ISNULL(lru.Qty,lroth.Qty) as Qty
		, lrc.ChargeAmt
		, lroth.TreatmentDateTime
		, lroth.Doctor
		, dbo.CutSortChar(doc.LocalName) as DoctorNameTH
		, dbo.CutSortChar(doc.EnglishName) as DoctorNameEN
		, lroth.DFDoctor
		, dbo.CutSortChar(dfdoc.LocalName) as DFDoctorNameTH
		, dbo.CutSortChar(dfdoc.EnglishName) as DFDoctorNameEN
		, lrc.RightCode
		, dbo.sysconname(lrc.RightCode,42086,2) as RightNameTH
		, dbo.sysconname(lrc.RightCode,42086,1) as RightNameEN
		, case when lru.StockCode is not null then 'Y' else 'N' end as Usage
		, lrc.ChargeVisitDate
		, lrc.ChargeVN
		, lrc.PrescriptionNo
		, lrc.IPDChargeDateTime
		, lrc.ChargeAN
		, lrc.ChargeVoucherNo
				from HNLRREQ_CHARGE lrc
				left join HNLRREQ_USAGE lru on lrc.FacilityRmsNo=lru.FacilityRmsNo and lrc.RequestNo=lru.RequestNo and lrc.HNActivityCode=lru.HNActivityCode and lrc.ChargeAmt=lru.ChargeAmt and lrc.SuffixTiny=lru.SuffixSmall
				left join HNLRREQ_OTHER_CHARGE lroth on lrc.FacilityRmsNo=lroth.FacilityRmsNo and lrc.RequestNo=lroth.RequestNo and lrc.HNActivityCode=lroth.HNActivityCode and lrc.ChargeAmt=lroth.ChargeAmt
				left join HNLRREQ_HEADER lrh on lrc.FacilityRmsNo = lrh.FacilityRmsNo and lrc.RequestNo=lrh.RequestNo
				left join HNDOCTOR_MASTER doc on lroth.Doctor=doc.Doctor
				left join HNDOCTOR_MASTER dfdoc on lroth.DFDoctor=dfdoc.Doctor