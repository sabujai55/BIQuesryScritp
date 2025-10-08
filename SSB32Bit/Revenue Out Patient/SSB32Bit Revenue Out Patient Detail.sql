select top 1000
		'PLS' as 'BU',
		a.HN as 'PatientID',
		CONVERT(varchar,a.VISITDATE,112)+CONVERT(varchar,a.VN)+CONVERT(varchar,a.SUFFIX) as 'VisitID',
		a.VISITDATE as 'VisitDate',
		a.VN as 'VN',
		a.REFNO as 'InvoiceNo',
		a.SUFFIX as 'InvoiceSuffixSmall',
		a.RECEIPTFORMCODE as 'HNReceiptFormCode',
		b.SUBSUFFIX as 'SuffixSmall',
		c.SUBSUFFIX as 'TreatmentSuffixTiny',
		d.SUBSUFFIX as 'MedcineSuffixTiny',
		coalesce(c.makedatetime,d.makedatetime) as 'MakeDateTime',
		bll.line as 'ReceiveFormLineNo',
		b.CHARGECODE as 'HNActivityCode',
		coalesce(c.treatmentcode,d.stockcode,b.chargecode) as 'ItemCode',
		case when c.TREATMENTCODE is not null then dbo.sysconname(c.treatmentcode,20051,4)
			 when d.STOCKCODE is not null then dbo.stockname(d.STOCKCODE,4)
			 when b.CHARGECODE is not null then dbo.sysconname(b.chargecode,20023,4) end as 'ItemName',
		case when c.TREATMENTCODE is not null then c.AMT
			 when d.STOCKCODE is not null then d.UNITPRICE 
			 when b.CHARGECODE is not null then b.AMT end  as 'UnitPrice',
		case when c.TREATMENTCODE is not null then 1
			 when d.STOCKCODE is not null then d.QTY 
			 when b.CHARGECODE is not null then 1 end as 'Qty',
		case when c.TREATMENTCODE is not null then c.AMT
			 when d.STOCKCODE is not null then d.AMT 
			 when b.CHARGECODE is not null then b.AMT end as 'ChargeAmt',
		b.AMT as 'FromChargeAmt',
		b.DISCOUNTAMT as 'DiscountAmt',
		b.CHARGECODE,
		bll.BillingGroupId as 'BillingGroupId',
		bll.BillingGroupLocalName as 'BillingGroupLocalName',
		bll.BillingGroupEnglishName as 'BillingGroupEnglishName',
		bll.BillingSubGroupId as 'BillingSubGroupId',
		bll.BillingSubGroupLocalName as 'BillingSubGroupLocalName',
		bll.BillingSubGroupEnglishName as 'BillingSubGroupEnglishName',
		c.GROUPREQUESTCODE as 'FacilityReqMethodCode', --เพิ่ทมวันที่ 05/02/2568
		dbo.sysconname(c.GROUPREQUESTCODE,20120,2) as 'FacilityReqMethodNameTH', --เพิ่ทมวันที่ 05/02/2568
		dbo.sysconname(c.GROUPREQUESTCODE,20120,1) as 'FacilityReqMethodNameEN' --เพิ่ทมวันที่ 05/02/2568
				from VNRCPT a
				left join VNRCPTDTL b on a.VISITDATE=b.VISITDATE and a.VN=b.VN and a.SUFFIX=b.SUFFIX
				left join VNTREAT c on b.VISITDATE=c.VISITDATE and b.VN=c.VN and b.PAIDSUBSUFFIX=c.SUBSUFFIX
				left join VNMEDICINE d on b.VISITDATE=d.VISITDATE and b.VN=d.VN and b.PAIDSUBSUFFIX=d.SUBSUFFIX
				left join vw_setup_HNReceiptForm_Line_Activity act on b.CHARGECODE=act.hnactivitycode
				left join dbo.API_SIMB_ReceiptFormBillingLocation bll on act.ReceiptFormLine=bll.Line
