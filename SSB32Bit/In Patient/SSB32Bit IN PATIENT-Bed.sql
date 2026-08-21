select top 1000
'PLS' as 'BU'
,CONCAT(b.An,b.BedNo,FORMAT(b.makedatetime, 'yyyyMMddHHmmss')) as 'BedID' --Modify 10/06/69
,a.HN as 'PatientID'
,CONVERT(varchar,a.ADMDATETIME,112)+a.AN as 'AdmitID'
,b.AN as 'AN'
,b.MakeDateTime as 'MakeDateTime'
,b.InDateTime as 'InDateTime'
,b.OutDateTime as 'OutDateTime'
,b.AckDateTime as 'AckDateTime'
,'' as 'StartRmsFeeDateTime'
,b.LASTUPDATEROOMFEEDATETIME as 'LastPostDateTime'
,b.INFROMWARD as 'FromWardCode'
,dbo.sysconname(b.INFROMWARD,20024,2) as 'FromWardNameTH'
,dbo.sysconname(b.INFROMWARD,20024,1) as 'FromWardNameEN'
,b.OUTTOWARD as 'ToWardCode'
,dbo.sysconname(b.OUTTOWARD,20024,2) as  'ToWardNameTH'
,dbo.sysconname(b.OUTTOWARD,20024,1) as  'ToWardNameEN'
,b.Ward as 'WardCode'
,dbo.sysconname(b.Ward,20024,2) as 'WardNameTH'
,dbo.sysconname(b.Ward,20024,1) as 'WardNameEN'
,b.BedNo as 'HNBedNo'
,dbo.CutSortChar(bi.THAINAME) as 'HNBedNameTH'
,dbo.CutSortChar(bi.ENGLISHNAME) as 'HNBedNameEN'
,bi.BEDTYPE as 'HNRmsTypeCode'
,dbo.sysconname(bi.BEDTYPE,20118,2) as 'HNRmsTypeNameTH'
,dbo.sysconname(bi.BEDTYPE,20118,1) as 'HNRmsTypeNameEN'
,'' as 'TransferInReasonCode'
,'' as 'TransferInReasonNameTH'
,'' as 'TransferInReasonNameEN'
,'' as 'TransferOutReasonCode'
,'' as 'TransferOutReasonNameTH'
,'' as 'TransferOutReasonNameEN'
,'' as 'Remarks'
,b.INBYUSERID as 'InByUserCode'
,dbo.sysconname(b.INBYUSERID,10000,2) as 'InByUserNameTH'
,dbo.sysconname(b.INBYUSERID,10000,1) as 'InByUserNameEN'
,b.OUTBYUSERID as 'OutByUserCode'
,dbo.sysconname(b.OUTBYUSERID,10000,2) as 'OutByUserNameTH'
,dbo.sysconname(b.OUTBYUSERID,10000,1) as 'OutByUserNameEN'
,CASE
	WHEN bi.OBSERVE = 1 THEN 1
	WHEN bi.TEMPORARYBED = 1 THEN 1
	ELSE 0
END as 'Observe' --modify 04/06/2569
,b.PATIENTSTAY as 'PatientStay'
		from ADMBED b
		inner join ADMMASTER a on b.AN=a.AN
		inner join HNBEDINV bi on b.BEDNO=bi.BEDNO
		where b.MakeDateTime > '2026-06-09' and a.AN = '2569/6251'