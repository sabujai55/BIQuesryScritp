USE SSBLIVE
go

select	'PT2' as 'BU'
		,a.HN as 'PatientID'
		,CONVERT(varchar,a.ADMDATETIME,112)+a.AN as 'AdmitID'
		,b.AN as 'AN'
		,b.MakeDateTime as 'MakeDateTime'
		,b.InDateTime as 'InDateTime'
		,b.OutDateTime as 'OutDateTime'
		,b.AckDateTime as 'AckDateTime'
		,b.StartRmsFeeDateTime as 'StartRmsFeeDateTime'
		,b.LastPostDateTime as 'LastPostDateTime'
		,b.FromWard as 'FromWardCode'
		,dbo.sysconname(b.FromWard,42201,2) as 'FromWardNameTH'
		,dbo.sysconname(b.FromWard,42201,1) as 'FromWardNameEN'
		,b.ToWard as 'ToWardCode'
		,dbo.sysconname(b.ToWard,42201,2) as  'ToWardNameTH'
		,dbo.sysconname(b.ToWard,42201,1) as  'ToWardNameEN'
		,b.Ward as 'WardCode'
		,dbo.sysconname(b.Ward,42201,2) as 'WardNameTH'
		,dbo.sysconname(b.Ward,42201,1) as 'WardNameEN'
		,b.HNBedNo as 'HNBedNo'
		,dbo.sysconname(b.HNBedNo,42421,2) as 'HNBedNameTH'
		,dbo.sysconname(b.HNBedNo,42421,1) as 'HNBedNameEN'
		,b.HNRmsTypeCode as 'HNRmsTypeCode'
		,dbo.sysconname(b.HNRmsTypeCode,42056,2) as 'HNRmsTypeNameTH'
		,dbo.sysconname(b.HNRmsTypeCode,42056,1) as 'HNRmsTypeNameEN'
		,b.TransferInReasonCode as 'TransferInReasonCode'
		,dbo.sysconname(b.TransferInReasonCode,43301,2) as 'TransferInReasonNameTH'
		,dbo.sysconname(b.TransferInReasonCode,43301,1) as 'TransferInReasonNameEN'
		,b.TransferOutReasonCode as 'TransferOutReasonCode'
		,dbo.sysconname(b.TransferOutReasonCode,43301,2) as 'TransferOutReasonNameTH'
		,dbo.sysconname(b.TransferOutReasonCode,43301,1) as 'TransferOutReasonNameEN'
		,b.Remarks as 'Remarks'
		,b.InByUserCode as 'InByUserCode'
		,dbo.sysconname(b.InByUserCode,10031,2) as 'InByUserNameTH'
		,dbo.sysconname(b.InByUserCode,10031,1) as 'InByUserNameEN'
		,b.OutByUserCode as 'OutByUserCode'
		,dbo.sysconname(b.OutByUserCode,10031,2) as 'OutByUserNameTH'
		,dbo.sysconname(b.OutByUserCode,10031,1) as 'OutByUserNameEN'
		,CASE
			WHEN (
				dbo.sysconname(b.Ward, 42201, 2) LIKE 'WOBS%'
				OR dbo.sysconname(b.Ward, 42201, 1) LIKE 'WOBS%'
				) 
			OR (
				dbo.sysconname(b.HNRmsTypeCode, 42056, 2) LIKE '%observe%'
				OR dbo.sysconname(b.HNRmsTypeCode, 42056, 1) LIKE '%observe%'
				OR dbo.sysconname(b.HNRmsTypeCode, 42056, 2) LIKE '%temporary%'
				OR dbo.sysconname(b.HNRmsTypeCode, 42056, 1) LIKE '%temporary%'
				OR dbo.sysconname(b.HNRmsTypeCode, 42056, 2) LIKE '%hrs%'
				OR dbo.sysconname(b.HNRmsTypeCode, 42056, 1) LIKE '%hrs%'
				) THEN 1
			ELSE 0
		END AS 'Observe'
		, b.PatientStay
from	HNIPD_BED b
		inner join HNIPD_MASTER a on b.AN=a.AN
where	a.AN in (select AN from HNIPD_MASTER where ADMDateTime between '2025-10-01 00:00:00' and '2025-10-01 23:59:59')
order by b.AN, b.MakeDateTime
