select top 10
		'PT2' as 'BU',
		opd.HN as 'PatientID',
		CONVERT(varchar,a.VisitDate,112)+convert(varchar,a.VN)+convert(varchar,a.PrescriptionNo) as 'VisitID',
		a.VisitDate as 'VisitDate',
		a.VN as 'VN',
		a.ReceiptNo as 'InvoiceNo',
		a.ReceiptSuffixTiny as 'InvoiceSuffixSmall',
		a.HNReceiptFormCode as 'HNReceiptFormCode',
		b.SuffixSmall as 'SuffixSmall',
		b.TreatmentSuffixTiny as 'TreatmentSuffixTiny',
		b.MedcineSuffixTiny as 'MedcineSuffixTiny',
		b.MakeDateTime as 'MakeDateTime',
		b.ReceiveFormLineNo as 'ReceiveFormLineNo',
		b.HNActivityCode as 'HNActivityCode',
		case when treat.TreatmentCode is not null then treat.TreatmentCode
			 when med.StockCode is not null then med.StockCode
			 when b.HNActivityCode is not null then b.HNActivityCode end as 'ItemCode',
		case when treat.TreatmentCode is not null then coalesce(dbo.sysconname(treat.TreatmentCode,42075,2),dbo.sysconname(treat.TreatmentCode,42075,1))
			 when med.StockCode is not null then coalesce(dbo.stockname(med.StockCode,2),dbo.stockname(med.StockCode,1))
			 when b.HNActivityCode is not null then coalesce(dbo.sysconname(b.HNActivityCode,42093,2),dbo.sysconname(b.HNActivityCode,42093,1)) end as 'ItemName',
		case when treat.TreatmentCode is not null then treat.ChargeAmt
			 when med.StockCode is not null then med.UnitPrice
			 when b.HNActivityCode is not null then b.FromChargeAmt end as 'UnitPrice',
		case when treat.TreatmentCode is not null then treat.Qty
			 when med.StockCode is not null then med.Qty
			 when b.HNActivityCode is not null then b.Qty end as 'Qty',
		case when treat.TreatmentCode is not null then treat.ChargeAmt
			 when med.StockCode is not null then med.ChargeAmt
			 when b.HNActivityCode is not null then b.FromChargeAmt end as 'ChargeAmt',
		b.FromChargeAmt as 'FromChargeAmt',
		b.DiscountAmt as 'DiscountAmt',
		bll.BillingGroupId as 'BillingGroupId',
		bll.BillingGroupLocalName as 'BillingGroupLocalName',
		bll.BillingGroupEnglishName as 'BillingGroupEnglishName',
		bll.BillingSubGroupId as 'BillingSubGroupId',
		bll.BillingSubGroupLocalName as 'BillingSubGroupLocalName',
		bll.BillingSubGroupEnglishName as 'BillingSubGroupEnglishName',
		case 
			when treat.FacilityRequestMethod is not null then treat.FacilityRequestMethod
			when med.FacilityRequestMethod is not null then med.FacilityRequestMethod
		end as 'FacilityReqMethodCode', --เพิ่ทมวันที่ 05/02/2568
		case 
			when treat.FacilityRequestMethod is not null then dbo.sysconname(treat.FacilityRequestMethod,42161,2)
			when med.FacilityRequestMethod is not null then dbo.sysconname(med.FacilityRequestMethod,42161,2)
		end as 'FacilityReqMethodNameTH', --เพิ่ทมวันที่ 05/02/2568
		case 
			when treat.FacilityRequestMethod is not null then dbo.sysconname(treat.FacilityRequestMethod,42161,1)
			when med.FacilityRequestMethod is not null then dbo.sysconname(med.FacilityRequestMethod,42161,1)
		end as 'FacilityReqMethodNameEN' --เพิ่ทมวันที่ 05/02/2568
				from HNOPD_RECEIVE_HEADER a
				left join HNOPD_MASTER opd on a.VN=opd.VN and a.VisitDate=opd.VisitDate
				left join HNOPD_RECEIVE_ITEM b on a.VN=b.VN and a.VisitDate=b.VisitDate and a.ReceiptSuffixTiny=b.ReceiptSuffixTiny
				left join HNOPD_PRESCRIP_MEDICINE med on b.VN=med.VN and b.VisitDate=med.VisitDate and b.PrescriptionNo=med.PrescriptionNo and b.MedcineSuffixTiny=med.SuffixTiny and b.MakeDateTime=med.MakeDateTime
				left join HNOPD_PRESCRIP_TREATMENT treat on b.VN=treat.VN and b.VisitDate=treat.VisitDate and b.PrescriptionNo=treat.PrescriptionNo and b.TreatmentSuffixTiny=treat.SuffixTiny and b.MakeDateTime=treat.MakeDateTime
				left join API_SIMB_ReceiptFormBillingLocation bll on b.ReceiveFormLineNo=bll.Line