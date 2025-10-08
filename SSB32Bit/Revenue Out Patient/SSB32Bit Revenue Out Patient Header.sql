select top 10
		'PLS' as 'BU',
		a.HN as 'PatientID',
		CONVERT(varchar,a.VISITDATE,112)+CONVERT(varchar,a.VN)+CONVERT(varchar,a.SUFFIX) as 'VisitID',
		a.VISITDATE as 'VisitDate',
		a.VN as 'VN',
		a.REFNO as 'InvoiceNo',
		a.SUFFIX as 'InvoiceSuffixSmall',
		a.ISSUEDATETIME as 'ReceiveDateTime',
		a.SPONSOR as 'ARCode',
		dbo.CutSortChar(ar.THAINAME) as 'ARNameTH', --แก้ไขวันที่ 05/03/2568
		dbo.CutSortChar(ar.ENGLISHNAME) as 'ARNameEN', --เพิ่มวันที่ 05/03/2568
		a.RIGHTCODE as 'RightCode',
		dbo.sysconname(a.RIGHTCODE,20019,2) as 'RightNameTH', --แก้ไขวันที่ 05/03/2568
		dbo.sysconname(a.RIGHTCODE,20019,1) as 'RightNameEN', --เพิ่มวันที่ 05/03/2568
		a.RECEIPTFORMCODE as 'HNReceiptFormCode',
		dbo.sysconname(a.RECEIPTFORMCODE,20079,2) as 'HNReceiptFormLocalName',
		dbo.sysconname(a.RECEIPTFORMCODE,20079,1) as 'HNReceiptFormEnglishName',
		a.DISCOUNTCODE as 'HNDiscountCode',
		dbo.sysconname(a.DISCOUNTCODE,20081,2) as 'HNDiscountLocalName',
		dbo.sysconname(a.DISCOUNTCODE,20081,1) as 'HNDiscountEnglishName',
		a.RECEIPTAMT as 'FromChargeAmt',
		a.DISCOUNTAMT as 'DiscountAmt',
		a.ISSUEDATETIME as 'PrintDateTime',
		a.CXLBYUSERCODE as 'CancelByUserCode', --แก้ไขวันที่ 05/03/2568
		dbo.sysconname(a.CXLBYUSERCODE,10000,2) as 'CancelByUserNameTH', --เพิ่มวันที่ 05/03/2568
		dbo.sysconname(a.CXLBYUSERCODE,10000,1) as 'CancelByUserNameEN', --เพิ่มวันที่ 05/03/2568
		a.CXLDATETIME as 'CancelDateTime',
		'' as 'HNPackage' , --เพิ่มวันที่ 05/03/2568
		'' as 'HNPackageNameTH', --เพิ่มวันที่ 05/03/2568
		'' as 'HNPackageNameEN', --เพิ่มวันที่ 05/03/2568
		a.ISSUEBYUSERCODE as 'ReceiveByUserCode', --เพิ่มวันที่ 05/03/2568
		dbo.sysconname(a.ISSUEBYUSERCODE,10000,2) as 'ReceiveByUserNameTH', --เพิ่มวันที่ 05/03/2568
		dbo.sysconname(a.ISSUEBYUSERCODE,10000,1) as 'ReceiveByUserNameEN', --เพิ่มวันที่ 05/03/2568
		a.RECEIVECODE as 'HNReceiveCode', --เพิ่มวันที่ 05/03/2568
		dbo.sysconname(a.RECEIVECODE,20107,2) as 'HNReceiveNameTH', --เพิ่มวันที่ 05/03/2568
		dbo.sysconname(a.RECEIVECODE,20107,1) as 'HNReceiveNameEN' --เพิ่มวันที่ 05/03/2568
				from VNRCPT a
				left join SSBBACKOFFICE.dbo.ARMASTER ar on a.SPONSOR=ar.ARCODE