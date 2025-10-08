select top 10 
		'PT2' as 'BU',
		b.HN as 'PatientID',
		CONVERT(varchar,a.VisitDate,112)+convert(varchar,a.VN)+convert(varchar,a.PrescriptionNo) as 'VisitID',
		a.VisitDate as 'VisitDate',
		a.VN as 'VN',
		a.ReceiptNo as 'InvoiceNo',
		a.ReceiptSuffixTiny as 'InvoiceSuffixSmall',
		a.ReceiveDateTime as 'ReceiveDateTime',
		a.ARCode as 'ARCode',
		dbo.CutSortChar(ar.LocalName) as 'ARNameTH', --����ѹ��� 05/03/2568
		dbo.CutSortChar(ar.EnglishName) as 'ARNameEN', --�����ѹ��� 05/03/2568
		a.RightCode as 'RightCode',
		dbo.sysconname(a.RightCode,42086,2) as 'RightNameTH', --����ѹ��� 05/03/2568
		dbo.sysconname(a.RightCode,42086,1) as 'RightNameEN', --�����ѹ��� 05/03/2568
		a.HNReceiptFormCode as 'HNReceiptFormCode',
		dbo.sysconname(a.HNReceiptFormCode,42101,2) as 'HNReceiptFormLocalName',
		dbo.sysconname(a.HNReceiptFormCode,42101,1) as 'HNReceiptFormEnglishName',
		a.HNDiscountCode as 'HNDiscountCode',
		dbo.sysconname(a.HNDiscountCode,42084,2) as 'HNDiscountLocalName',
		dbo.sysconname(a.HNDiscountCode,42084,1) as 'HNDiscountEnglishName',
		a.FromChargeAmt as 'FromChargeAmt',
		a.DiscountAmt as 'DiscountAmt',
		a.ReceiveDateTime as 'PrintDateTime',
		a.CxlByUserCode as 'CancelByUserCode', --����ѹ��� 05/03/2568
		dbo.sysconname(a.CxlByUserCode,10031,2) as 'CancelByUserNameTH', --�����ѹ��� 05/03/2568
		dbo.sysconname(a.CxlByUserCode,10031,1) as 'CancelByUserNameEN', --�����ѹ��� 05/03/2568
		a.CxlDateTime as 'CancelDateTime',
		a.HNPackageCode as 'HNPackage' , --�����ѹ��� 05/03/2568
		dbo.sysconname(a.HNPackageCode,43541,2) as 'HNPackageNameTH', --�����ѹ��� 05/03/2568
		dbo.sysconname(a.HNPackageCode,43541,2) as 'HNPackageNameEN', --�����ѹ��� 05/03/2568
		a.EntryByUserCode as 'ReceiveByUserCode', --�����ѹ��� 05/03/2568
		dbo.sysconname(a.EntryByUserCode,10031,2) as 'ReceiveByUserNameTH', --�����ѹ��� 05/03/2568
		dbo.sysconname(a.EntryByUserCode,10031,1) as 'ReceiveByUserNameEN', --�����ѹ��� 05/03/2568
		rb.HNReceiveCode as 'HNReceiveCode', --�����ѹ��� 05/03/2568
		dbo.sysconname(rb.HNReceiveCode,42077,2) as 'HNReceiveNameTH', --�����ѹ��� 05/03/2568
		dbo.sysconname(rb.HNReceiveCode,42077,1) as 'HNReceiveNameEN' --�����ѹ��� 05/03/2568
				from HNOPD_RECEIVE_HEADER a
				left join HNOPD_MASTER b on a.VN=b.VN and a.VisitDate=b.VisitDate
				left join ARMASTER ar on a.ARCode=ar.ARCode
				left join HNOPD_RECEIVE_BY rb on a.VisitDate=rb.VisitDate and a.VN=rb.VN and a.ReceiptSuffixTiny=rb.ReceiptSuffixTiny