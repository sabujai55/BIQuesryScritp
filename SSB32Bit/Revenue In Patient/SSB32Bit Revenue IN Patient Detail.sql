select top 1000 'PLS' as 'BU'
,*
from
(
--############################ TREATMENT ############################
select	adm.HN as PatientID
		,CONVERT(varchar,adm.ADMDATETIME,112)+adm.AN as AdmitID
		,adm.ADMDATETIME as AdmitDateTime
		,adm.AN
		,a.INVOICENO as InvoiceNo
		, 1 as InvoiceSuffixSmall
		,b.RECEIPTFORMCODE as HNReceiptFormCode
		, a.SUFFIX as SuffixSmall
		, a.IPDMEDICINEHISTORYDATETIME as ChargeMedicineSuffixSmall
		, a.IPDCHARGEMAKEDATETIME as MakeDateTime
		, sr.ReceiptFormLine as ReceiveFormLineNo
		, c.CHARGECODE as HNActivityCode
		, c.TREATMENTCODE as ItemCode
		, coalesce(dbo.CutSortChar(sys01.THAINAME),dbo.CutSortChar(sys01.ENGLISHNAME)) as ItemName
		, c.CHARGEAMT as UnitPrice
		, coalesce(dbo.GetAmountfromHNChargeType(c.TYPEOFCHARGE,c.QTY),1) as Qty
		, coalesce(dbo.GetAmountfromHNChargeType(c.TYPEOFCHARGE,c.CHARGEAMT),1) as ChargeAmt
		, dbo.GetAmountfromHNChargeType(c.TYPEOFCHARGE,a.AMT) as FromChargeAmt
		, dbo.GetAmountfromHNChargeType(c.TYPEOFCHARGE,a.DISCOUNTAMT) as DiscountAmt 
		, rf.BillingGroupId
		, rf.BillingGroupLocalName 
		, rf.BillingGroupEnglishName
		, case when charindex('(',rf.BillingSubGroupId) > 0  then substring(rf.BillingSubGroupId, 1, charindex('(',rf.BillingSubGroupId)-1) 
		  else rf.BillingSubGroupId end as BillingSubGroupId
		, rf.BillingSubGroupLocalName
		, rf.BillingSubGroupEnglishName
		, gr.GroupRequestCode as FacilityReqMethodCode
		, dbo.sysconname(gr.GroupRequestCode,20120,2) as FacilityReqMethodNameTH
		, dbo.sysconname(gr.GroupRequestCode,20120,1) as FacilityReqMethodNameEN
from	IPDINVDTL a
		left join IPDINV b on a.INVOICENO = b.INVOICENO
		left join ADMMASTER adm on b.AN=adm.AN
		left join IPDCHRG c on b.AN = c.AN	 and a.IPDCHARGEMAKEDATETIME = c.MAKEDATETIME and c.TREATMENTCODE is not null and c.TYPEOFACTIVITY != 8
		left join vw_setup_HNReceiptForm_Line_Activity sr on sr.HNActivityCode = c.CHARGECODE
		left join API_SIMB_ReceiptFormBillingLocation rf on sr.ReceiptFormLine = rf.Line
		left join SYSCONFIG sys01 on sys01.CtrlCode = 20051 and c.TREATMENTCODE = sys01.CODE
		left join GRPREQMST gr on c.GROUPREQUESTMASTERREF=gr.GroupRequestMasterRef
where	 c.TYPEOFACTIVITY != 8
union all
--############################ USAGE ############################
select	adm.HN as PatientID
		,CONVERT(varchar,adm.ADMDATETIME,112)+adm.AN as AdmitID
		,adm.ADMDATETIME as AdmitDateTime
		,adm.AN
		,a.INVOICENO as InvoiceNo
		, 1 as InvoiceSuffixSmall
		,b.RECEIPTFORMCODE as HNReceiptFormCode
		, a.SUFFIX as SuffixSmall
		, a.IPDCHARGESUFFIXFILEDATETIME as ChargeMedicineSuffixSmall
		, a.IPDCHARGEMAKEDATETIME as MakeDateTime
		, sr.ReceiptFormLine as ReceiveFormLineNo
		, u.CHARGECODE as HNActivityCode
		, u.STOCKCODE as ItemCode
		, coalesce(dbo.CutSortChar(sk.THAINAME),dbo.CutSortChar(sk.ENGLISHNAME)) as ItemName
		, u.UNITPRICE as UnitPrice
		, coalesce(dbo.GetAmountfromHNChargeType(c.TYPEOFCHARGE,u.QTY),1) as Qty
		, coalesce(dbo.GetAmountfromHNChargeType(c.TYPEOFCHARGE,u.AMT),1) as ChargeAmt
		, dbo.GetAmountfromHNChargeType(c.TYPEOFCHARGE,a.AMT) as FromChargeAmt
		, dbo.GetAmountfromHNChargeType(c.TYPEOFCHARGE,a.DISCOUNTAMT) as DiscountAmt 
		, rf.BillingGroupId
		, rf.BillingGroupLocalName 
		, rf.BillingGroupEnglishName
		, case when charindex('(',rf.BillingSubGroupId) > 0  then substring(rf.BillingSubGroupId, 1, charindex('(',rf.BillingSubGroupId)-1) 
		  else rf.BillingSubGroupId end as BillingSubGroupId
		, rf.BillingSubGroupLocalName
		, rf.BillingSubGroupEnglishName
		, gr.GroupRequestCode as FacilityReqMethodCode
		, '' as FacilityReqMethodNameTH
		, '' as FacilityReqMethodNameEN 
from	IPDINVDTL a
		left join IPDINV b on a.INVOICENO = b.INVOICENO
		left join ADMMASTER adm on b.AN=adm.AN
		left join IPDCHRG c on b.AN = c.AN	 and a.IPDCHARGEMAKEDATETIME = c.MAKEDATETIME 
		left join IPDSTOCKUSAGE u on c.AN = u.AN and c.MAKEDATETIME = u.HEADERMAKEDATETIME and a.IPDCHARGESUFFIXFILEDATETIME = u.MAKEDATETIME
		left join vw_setup_HNReceiptForm_Line_Activity sr on sr.HNActivityCode = c.CHARGECODE
		left join API_SIMB_ReceiptFormBillingLocation rf on sr.ReceiptFormLine = rf.Line
		left join [SSBSTOCK].[dbo].[STOCK_MASTER] sk on u.STOCKCODE = sk.STOCKCODE
		left join GRPREQMST gr on c.GROUPREQUESTMASTERREF=gr.GroupRequestMasterRef
where	 c.TYPEOFACTIVITY = 7
union all 
--############################ MEDICINE ############################
select	adm.HN as PatientID
		,CONVERT(varchar,adm.ADMDATETIME,112)+adm.AN as AdmitID
		,adm.ADMDATETIME as AdmitDateTime
		,adm.AN
		,a.INVOICENO as InvoiceNo
		, 1 as InvoiceSuffixSmall
		,b.RECEIPTFORMCODE as HNReceiptFormCode
		, a.SUFFIX as SuffixSmall
		, a.IPDCHARGESUFFIXFILEDATETIME as ChargeMedicineSuffixSmall
		, a.IPDCHARGEMAKEDATETIME as MakeDateTime
		, sr.ReceiptFormLine as ReceiveFormLineNo
		, u.CHARGECODE as HNActivityCode
		, u.STOCKCODE as ItemCode
		, coalesce(dbo.CutSortChar(sk.THAINAME),dbo.CutSortChar(sk.ENGLISHNAME)) as ItemName
		, u.UNITPRICE as UnitPrice
		, coalesce(dbo.GetAmountfromHNChargeType(c.TYPEOFCHARGE,u.QTY),1) as Qty
		, coalesce(dbo.GetAmountfromHNChargeType(c.TYPEOFCHARGE,u.AMT),1) as ChargeAmt
		, dbo.GetAmountfromHNChargeType(c.TYPEOFCHARGE,a.AMT) as FromChargeAmt
		, dbo.GetAmountfromHNChargeType(c.TYPEOFCHARGE,a.DISCOUNTAMT) as DiscountAmt 
		, rf.BillingGroupId
		, rf.BillingGroupLocalName 
		, rf.BillingGroupEnglishName
		, case when charindex('(',rf.BillingSubGroupId) > 0  then substring(rf.BillingSubGroupId, 1, charindex('(',rf.BillingSubGroupId)-1) 
		  else rf.BillingSubGroupId end as BillingSubGroupId
		, rf.BillingSubGroupLocalName
		, rf.BillingSubGroupEnglishName
		, gr.GroupRequestCode as FacilityReqMethodCode
		, dbo.sysconname(gr.GroupRequestCode,20120,2) as FacilityReqMethodNameTH
		, dbo.sysconname(gr.GroupRequestCode,20120,1) as FacilityReqMethodNameEN
from	IPDINVDTL a
		left join IPDINV b on a.INVOICENO = b.INVOICENO
		left join ADMMASTER adm on b.AN=adm.AN
		left join IPDCHRG c on b.AN = c.AN	 and a.IPDCHARGEMAKEDATETIME = c.MAKEDATETIME 
		left join IPDDRUGHIST u on c.AN = u.AN and c.MAKEDATETIME = u.HEADERMAKEDATETIME and a.IPDCHARGESUFFIXFILEDATETIME = u.MAKEDATETIME
		left join vw_setup_HNReceiptForm_Line_Activity sr on sr.HNActivityCode = c.CHARGECODE
		left join API_SIMB_ReceiptFormBillingLocation rf on sr.ReceiptFormLine = rf.Line
		left join [SSBSTOCK].[dbo].[STOCK_MASTER] sk on u.STOCKCODE = sk.STOCKCODE
		left join GRPREQMST gr on c.GROUPREQUESTMASTERREF=gr.GroupRequestMasterRef
where	 c.TYPEOFACTIVITY = 1
union all
--############################ LAB ############################
select	adm.HN as PatientID
		, CONVERT(varchar,adm.ADMDATETIME,112)+adm.AN as AdmitID
		, adm.ADMDATETIME as AdmitDateTime
		, adm.AN
		, a.INVOICENO as InvoiceNo
		, 1 as InvoiceSuffixSmall
		, b.RECEIPTFORMCODE as HNReceiptFormCode
		, a.SUFFIX as SuffixSmall
		, a.IPDCHARGESUFFIXFILEDATETIME as ChargeMedicineSuffixSmall
		, a.IPDCHARGEMAKEDATETIME as MakeDateTime
		, sr.ReceiptFormLine as ReceiveFormLineNo
		, ls.CHARGECODE as HNActivityCode
		, ls.LABCODE as ItemCode
		, coalesce(dbo.CutSortChar(sys01.THAINAME),dbo.CutSortChar(sys01.ENGLISHNAME)) as ItemName
		, ls.AMT as UnitPrice
		, coalesce(dbo.GetAmountfromHNChargeType(c.TYPEOFCHARGE,c.QTY),1) as Qty
		, coalesce(dbo.GetAmountfromHNChargeType(c.TYPEOFCHARGE,ls.AMT),1) as ChargeAmt
		, dbo.GetAmountfromHNChargeType(c.TYPEOFCHARGE,a.AMT) as FromChargeAmt
		, dbo.GetAmountfromHNChargeType(c.TYPEOFCHARGE,a.DISCOUNTAMT) as DiscountAmt 
		, rf.BillingGroupId
		, rf.BillingGroupLocalName 
		, rf.BillingGroupEnglishName
		, case when charindex('(',rf.BillingSubGroupId) > 0  then substring(rf.BillingSubGroupId, 1, charindex('(',rf.BillingSubGroupId)-1) 
		  else rf.BillingSubGroupId end as BillingSubGroupId
		, rf.BillingSubGroupLocalName
		, rf.BillingSubGroupEnglishName
		, gr.GroupRequestCode as FacilityReqMethodCode
		, dbo.sysconname(gr.GroupRequestCode,20120,2) as FacilityReqMethodNameTH
		, dbo.sysconname(gr.GroupRequestCode,20120,1) as FacilityReqMethodNameEN
from	IPDINVDTL a
		left join IPDINV b on a.INVOICENO = b.INVOICENO
		left join ADMMASTER adm on b.AN=adm.AN
		left join IPDCHRG c on b.AN = c.AN	 and a.IPDCHARGEMAKEDATETIME = c.MAKEDATETIME and c.TREATMENTCODE is null 
		left join LABRESULT ls on c.FACILITYRMS = ls.FACILITYRMSNO and c.REF = ls.REQUESTNO and c.CHARGECODE = ls.CHARGECODE and ls.AMT > 0 
		left join vw_setup_HNReceiptForm_Line_Activity sr on sr.HNActivityCode = c.CHARGECODE
		left join API_SIMB_ReceiptFormBillingLocation rf on sr.ReceiptFormLine = rf.Line
		left join SYSCONFIG sys01 on sys01.CtrlCode = 20067 and ls.LABCODE = sys01.CODE
		left join GRPREQMST gr on c.GROUPREQUESTMASTERREF=gr.GroupRequestMasterRef
where	  c.TYPEOFACTIVITY = 9
union all
--############################ XRAY ############################
select	adm.HN as PatientID
		, CONVERT(varchar,adm.ADMDATETIME,112)+adm.AN as AdmitID
		, adm.ADMDATETIME as AdmitDateTime
		, adm.AN
		, a.INVOICENO as InvoiceNo
		, 1 as InvoiceSuffixSmall
		, b.RECEIPTFORMCODE as HNReceiptFormCode
		, a.SUFFIX as SuffixSmall
		, a.IPDCHARGESUFFIXFILEDATETIME as ChargeMedicineSuffixSmall
		, a.IPDCHARGEMAKEDATETIME as MakeDateTime
		, sr.ReceiptFormLine as ReceiveFormLineNo
		, xr.CHARGECODE as HNActivityCode
		, xr.XRAYCODE as ItemCode
		, coalesce(dbo.CutSortChar(sys01.THAINAME),dbo.CutSortChar(sys01.ENGLISHNAME)) as ItemName
		, xr.AMT as UnitPrice
		, coalesce(dbo.GetAmountfromHNChargeType(c.TYPEOFCHARGE,c.QTY),1) as Qty
		, coalesce(dbo.GetAmountfromHNChargeType(c.TYPEOFCHARGE,xr.AMT),1) as ChargeAmt
		, dbo.GetAmountfromHNChargeType(c.TYPEOFCHARGE,a.AMT) as FromChargeAmt
		, dbo.GetAmountfromHNChargeType(c.TYPEOFCHARGE,a.DISCOUNTAMT) as DiscountAmt 
		, rf.BillingGroupId
		, rf.BillingGroupLocalName 
		, rf.BillingGroupEnglishName
		, case when charindex('(',rf.BillingSubGroupId) > 0  then substring(rf.BillingSubGroupId, 1, charindex('(',rf.BillingSubGroupId)-1) 
		  else rf.BillingSubGroupId end as BillingSubGroupId
		, rf.BillingSubGroupLocalName
		, rf.BillingSubGroupEnglishName
		, gr.GroupRequestCode as FacilityReqMethodCode
		, dbo.sysconname(gr.GroupRequestCode,20120,2) as FacilityReqMethodNameTH
		, dbo.sysconname(gr.GroupRequestCode,20120,1) as FacilityReqMethodNameEN
from	IPDINVDTL a
		left join IPDINV b on a.INVOICENO = b.INVOICENO
		left join ADMMASTER adm on b.AN=adm.AN
		left join IPDCHRG c on b.AN = c.AN	 and a.IPDCHARGEMAKEDATETIME = c.MAKEDATETIME 
		left join XRAYRESULT xr on c.FACILITYRMS = xr.FACILITYRMSNO and c.REF = xr.REQUESTNO and c.CHARGECODE = xr.CHARGECODE 
		left join vw_setup_HNReceiptForm_Line_Activity sr on sr.HNActivityCode = c.CHARGECODE
		left join API_SIMB_ReceiptFormBillingLocation rf on sr.ReceiptFormLine = rf.Line
		left join SYSCONFIG sys01 on sys01.CtrlCode = 20073 and xr.XRAYCODE = sys01.CODE
		left join GRPREQMST gr on c.GROUPREQUESTMASTERREF=gr.GroupRequestMasterRef
where	  c.TYPEOFACTIVITY = 8
union all
--############################ PT ############################
select	adm.HN as PatientID
		, CONVERT(varchar,adm.ADMDATETIME,112)+adm.AN as AdmitID
		, adm.ADMDATETIME as AdmitDateTime
		, adm.AN
		, a.INVOICENO as InvoiceNo
		, 1 as InvoiceSuffixSmall
		, b.RECEIPTFORMCODE as HNReceiptFormCode
		, a.SUFFIX as SuffixSmall
		, a.IPDCHARGESUFFIXFILEDATETIME as ChargeMedicineSuffixSmall
		, a.IPDCHARGEMAKEDATETIME as MakeDateTime
		, sr.ReceiptFormLine as ReceiveFormLineNo
		, pt.CHARGECODE as HNActivityCode
		, pt.PTMODE as ItemCode
		, coalesce(dbo.CutSortChar(sys01.THAINAME),dbo.CutSortChar(sys01.ENGLISHNAME)) as ItemName
		, pt.AMT as UnitPrice
		, coalesce(dbo.GetAmountfromHNChargeType(c.TYPEOFCHARGE,c.QTY),1) as Qty
		, coalesce(dbo.GetAmountfromHNChargeType(c.TYPEOFCHARGE,pt.AMT),1) as ChargeAmt
		, dbo.GetAmountfromHNChargeType(c.TYPEOFCHARGE,a.AMT) as FromChargeAmt
		, dbo.GetAmountfromHNChargeType(c.TYPEOFCHARGE,a.DISCOUNTAMT) as DiscountAmt 
		, rf.BillingGroupId
		, rf.BillingGroupLocalName 
		, rf.BillingGroupEnglishName
		, case when charindex('(',rf.BillingSubGroupId) > 0  then substring(rf.BillingSubGroupId, 1, charindex('(',rf.BillingSubGroupId)-1) 
		  else rf.BillingSubGroupId end as BillingSubGroupId
		, rf.BillingSubGroupLocalName
		, rf.BillingSubGroupEnglishName
		, gr.GroupRequestCode as FacilityReqMethodCode
		, dbo.sysconname(gr.GroupRequestCode,20120,2) as FacilityReqMethodNameTH
		, dbo.sysconname(gr.GroupRequestCode,20120,1) as FacilityReqMethodNameEN
from	IPDINVDTL a
		left join IPDINV b on a.INVOICENO = b.INVOICENO
		left join ADMMASTER adm on b.AN=adm.AN
		left join IPDCHRG c on b.AN = c.AN	 and a.IPDCHARGEMAKEDATETIME = c.MAKEDATETIME 
		left join PTPAYMENT pt on c.AN = pt.AN and c.REF = pt.REQUESTNO and c.MAKEDATETIME = pt.ENTRYDATETIME and c.CHARGECODE = pt.CHARGECODE 
		left join vw_setup_HNReceiptForm_Line_Activity sr on sr.HNActivityCode = c.CHARGECODE
		left join API_SIMB_ReceiptFormBillingLocation rf on sr.ReceiptFormLine = rf.Line
		left join SYSCONFIG sys01 on sys01.CtrlCode = 20104 and pt.PTMODE = sys01.CODE
		left join GRPREQMST gr on c.GROUPREQUESTMASTERREF=gr.GroupRequestMasterRef
where   c.TYPEOFACTIVITY = 10
) ipddetail