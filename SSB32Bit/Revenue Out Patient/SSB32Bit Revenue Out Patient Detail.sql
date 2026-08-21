select top 1000
		'PLS' as 'BU',
		a.HN as 'PatientID',
		CONVERT(varchar,a.VISITDATE,112)+CONVERT(varchar,a.VN)+CONVERT(varchar,a.SUFFIX) as 'VisitID',
		a.VISITDATE as 'VisitDate',
		a.VN as 'VN',
		case when vnpt.SUFFIX is null then vnpm.SUFFIX else vnpt.SUFFIX end as 'PrescriptionNo', --modify 05/08/2569
		case when vnpt.CLINIC is null then vnpm.CLINIC else vnpt.CLINIC end as 'ClinicCode', --modify 24/07/2569
		case when vnpt.CLINIC is null then dbo.sysconname(vnpm.CLINIC,20016,2) else dbo.sysconname(vnpt.CLINIC,20016,2) end as 'ClinicNameTH', --modify 24/07/2569
		case when vnpt.CLINIC is null then dbo.sysconname(vnpm.CLINIC,20016,1) else dbo.sysconname(vnpt.CLINIC,20016,1) end as 'ClinicNameEN', --modify 24/07/2569
		case when vnpt.DOCTOR is null then vnpm.DOCTOR else vnpt.DOCTOR end as 'DoctorCode', --modify 24/07/2569
		case when vnpt.DOCTOR is null then dbo.Doctorname(vnpm.DOCTOR,2) else dbo.Doctorname(vnpt.DOCTOR,2) end as 'DoctorNameTH', --modify 24/07/2569
		case when vnpt.DOCTOR is null then dbo.Doctorname(vnpm.DOCTOR,1) else dbo.Doctorname(vnpt.DOCTOR,1) end as 'DoctorNameEN', --modify 24/07/2569
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
				left join VNTREAT c on b.VISITDATE=c.VISITDATE and b.VN=c.VN and b.PAIDSUBSUFFIX=c.SUBSUFFIX and a.MAINPRESCRIPTIONSUFFIX=c.SUFFIX --modify 24/07/2569
				left join VNMEDICINE d on b.VISITDATE=d.VISITDATE and b.VN=d.VN and b.PAIDSUBSUFFIX=d.SUBSUFFIX and a.MAINPRESCRIPTIONSUFFIX=d.SUFFIX --modify 24/07/2569
				left join VNPRES vnpt on c.VN=vnpt.VN and c.VISITDATE=vnpt.VISITDATE and c.SUFFIX=vnpt.SUFFIX --modify 24/07/2569
				left join VNPRES vnpm on d.VN=vnpm.VN and d.VISITDATE=vnpm.VISITDATE and d.SUFFIX=vnpm.SUFFIX --modify 24/07/2569
				left join vw_setup_HNReceiptForm_Line_Activity act on b.CHARGECODE=act.hnactivitycode
				left join dbo.API_SIMB_ReceiptFormBillingLocation bll on act.ReceiptFormLine=bll.Line