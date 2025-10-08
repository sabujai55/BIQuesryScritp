select	top 10
		'PT2' as BU
		, b.HN as PatientID
		, CONVERT(varchar,b.AdmDateTime,112)+b.AN as AdmitID
		, b.AdmDateTime
		, a.AN 
		, a.InvoiceNo
		, a.InvoiceSuffixSmall
		, a.ReceiveDateTime
		, coalesce(a.ARCode, '') as ARCode
		, dbo.CutSortChar(ar.LocalName) as ARNameTH --����ѹ��� 05/03/2568
		, dbo.CutSortChar(ar.EnglishName) as ARNameEN --�����ѹ��� 05/03/2568
		, a.RightCode
		, dbo.CutSortChar(syc02.LocalName) as RightNameTH --����ѹ��� 05/03/2568
		, dbo.CutSortChar(syc02.EnglishName) as RightNameEN --�����ѹ��� 05/03/2568
		, a.HNReceiptFormCode
		, coalesce(dbo.CutSortChar(syc01.LocalName), '') as HNReceiptFormLocalName
		, coalesce(dbo.CutSortChar(syc01.EnglishName), '') as HNReceiptFormEnglishName
		, coalesce(a.HNDiscountCode,'') as HNDiscountCode
		, coalesce(dbo.CutSortChar(syc03.LocalName), '') as HNDiscountLocalName
		, coalesce(dbo.CutSortChar(syc03.EnglishName), '') as HNDiscountEnglishName
		, a.FromChargeAmt
		, a.DiscountAmt
		, a.ReceiveDateTime as PrintDateTime
		, a.CxlByUserCode as CancelByUserCode --����ѹ��� 05/03/2568
		, dbo.sysconname(a.CxlByUserCode,10031,2) as CancelByUserNameTH --�����ѹ��� 05/03/2568
		, dbo.sysconname(a.CxlByUserCode,10031,1) as CancelByUserNameEN --�����ѹ��� 05/03/2568
		, a.CxlDateTime as CancelDateTime
		, a.HNPackageCode as HNPackage --�����ѹ��� 05/03/2568
		, dbo.sysconname(a.HNPackageCode,43541,2) as HNPackageNameTH --�����ѹ��� 05/03/2568
		, dbo.sysconname(a.HNPackageCode,43541,1) as HNPackageNameEN --�����ѹ��� 05/03/2568
		, a.EntryByUserCode as ReceiveByUserCode --�����ѹ��� 05/03/2568
		, dbo.sysconname(a.EntryByUserCode,10031,2) as ReceiveByUserNameTH --�����ѹ��� 05/03/2568
		, dbo.sysconname(a.EntryByUserCode,10031,1) as ReceiveByUserNameEN --�����ѹ��� 05/03/2568
		, a.HNReceiveCode as HNReceiveCode --�����ѹ��� 05/03/2568
		, dbo.sysconname(a.HNReceiveCode,42077,2) as HNReceiveNameTH --�����ѹ��� 05/03/2568
		, dbo.sysconname(a.HNReceiveCode,42077,1) as HNReceiveNameEN --�����ѹ��� 05/03/2568
from	HNIPD_INVOICE_HEADER a
		left join HNIPD_MASTER b on a.AN = b.AN 
		left join MK_HN_PATIENT c on b.HN = c.HN
		left join ARMASTER ar on a.ARCode = ar.ARCode
		left join DNSYSCONFIG syc01 on syc01.CtrlCode = 42101 and a.HNReceiptFormCode = syc01.Code
		left join DNSYSCONFIG syc02 on syc02.CtrlCode = 42086 and a.RightCode = syc02.Code
		left join DNSYSCONFIG syc03 on syc03.CtrlCode = 42084 and a.HNDiscountCode = syc03.Code
		left join DNSYSCONFIG syc04 on syc04.CtrlCode = 42201 and b.ActiveWard = syc04.Code