use SSBLIVE
go

select 'PT2' AS 'BU'
	,CONCAT(format(A.MakeDateTime,'yyyyMMdd'),A.vn,A.prescriptionno,format(A.MakeDateTime,'yyyyMMddHHmmssffff'),A.SuffixTiny) AS 'OrderID'
	,B.HN AS 'PatientID'
	,CONCAT(format(A.MakeDateTime,'yyyyMMdd'),A.vn,A.prescriptionno) AS 'VisitID'
	,format(A.VisitDate,'yyyy-MM-dd') AS 'VisitDate'
	,A.VN AS 'VN'
	,A.PrescriptionNo AS 'PrescriptionNo'
	,A.MakeDateTime AS 'MakeDateTime'
	,'Treatment' AS 'ItemType'
	,A.TreatmentCode AS 'ItemCode'
	,dbo.sysconname(A.TreatmentCode,42075,2) AS 'ItemNameTH' --แก้ไขวันที่ 26/02/2568
	,dbo.sysconname(A.TreatmentCode,42075,1) AS 'ItemNameEN' --เพิ่มวันที่ 26/02/2568
	,A.HNActivityCode AS 'ActivityCode'
	,dbo.sysconname(A.HNActivityCode,42093,2) AS 'ActivityNameTH' --แก้ไขวันที่ 26/02/2568
	,dbo.sysconname(A.HNActivityCode,42093,1) AS 'ActivityNameEN' --เพิ่มวันที่ 26/02/2568
	,A.UnitCode AS 'UnitCode'
	,null AS 'UnitNameTH' --แก้ไขวันที่ 26/02/2568
	,null AS 'UnitNameEN' --เพิ่มวันที่ 26/02/2568
	,A.QTY AS 'QTY'
	,A.UnitPrice  'UnitPrice'
	,A.ChargeAmt AS 'ChargeAmt'
	,Case 
	when A.HNChargeType = 0 then 'Charge' 
	when A.HNChargeType = 1 then 'Free' 
	when A.HNChargeType = 2 then 'Refund'
	when A.HNChargeType = 6 then 'Free Return'
	end AS 'ChargeType'
	,A.ChargeDateTime AS 'ChargeDateTime'
	,A.EntryByFacilityRmsNo AS 'EntryByFacility'
	,A.EntryByFacilityRefNo AS 'RefNo'
	,A.CxlByUserCode AS 'CancelByUserCode' --แก้ไขวันที่ 26/02/2568
	,dbo.sysconname(A.CxlByUserCode,10031,2) AS 'CancelByUserNameTH' --เพิ่มวันที่ 26/02/2568
	,dbo.sysconname(A.CxlByUserCode,10031,1) AS 'CancelByUserNameEN' --เพิ่มวันที่ 26/02/2568
	,A.CxlDateTime AS 'CancelDateTime'
	,A.TreatmentDateTime AS 'TreatmentDateTimeFrom'
	,A.TreatmentDateTime  AS 'TreatmentDateTimeTo'
	,A.DFDoctor AS 'DFDoctor'
	,A.RightCode AS 'RightCode'
	,dbo.sysconname(A.RightCode,42086,2) AS 'RightNameTH' --แก้ไขวันที่ 26/02/2568
	,dbo.sysconname(A.RightCode,42086,1) AS 'RightNameEN' --เพิ่มวันที่ 26/02/2568
	,null AS 'StoreCode'
	,null AS 'StoreNameTH' --แก้ไขวันที่ 26/02/2568
	,null AS 'StoreNameEN' --เพิ่มวันที่ 26/02/2568
	,null AS 'DoseType'
	,null AS 'DoseCode'
	,null AS 'DoseQTY'
	,null AS 'DoseUnit'
	,null AS 'DoseFreqCode'
	,null AS 'AuxLabel1'
	,null AS 'AuxLabel2'
	,null AS 'AuxLabel3'
	,a.FacilityRequestMethod AS 'EntryByFacilityMethodCode' --แก้ไขวันที่ 8/4/68
	,dbo.sysconname(A.FacilityRequestMethod,42161,2) AS 'EntryByFacilityMethodNameTH' --แก้ไขวันที่ 8/4/68
	,dbo.sysconname(A.FacilityRequestMethod,42161,1) AS 'EntryByFacilityMethodNameEN' --แก้ไขวันที่ 8/4/68
	,case when A.CheckUp = 1 then 'True' else 'False' end AS 'Checkup'
	,null AS 'DoseMemo'
	,case when A.DFDoctor is null then 0 else 1 end as 'FlagDF' --เพิ่มวันที่ 17/02/2568
	,cast(SUBSTRING(ACT.Com,17,3) as varchar) as 'ActivityCategoryCode' --เพิ่มวันที่ 26/02/2568
	,dbo.sysconname(cast(SUBSTRING(ACT.Com,17,3) as varchar),42091,2) as 'ActivityCategoryNameTH' --เพิ่มวันที่ 26/02/2568
	,dbo.sysconname(cast(SUBSTRING(ACT.Com,17,3) as varchar),42091,1) as 'ActivityCategoryNameEN' --เพิ่มวันที่ 26/02/2568

from

HNOPD_PRESCRIP_TREATMENT A
left join HNOPD_MASTER B ON(A.visitdate = B.VisitDate and A.vn = B.VN)
left join DNSYSCONFIG ACT ON A.HNActivityCode=ACT.Code and ACT.CtrlCode = 42093 
where A.TreatmentCode is not null

union all
-- ************************************** OR **************************************
select 'PT2' AS 'BU'
	,CONCAT(format(A.MakeDateTime,'yyyyMMdd'),A.vn,A.prescriptionno,format(A.MakeDateTime,'yyyyMMddHHmmssffff'),A.SuffixTiny) AS 'OrderID'
	,B.HN AS 'PatientID'
	,CONCAT(format(A.MakeDateTime,'yyyyMMdd'),A.vn,A.prescriptionno) AS 'VisitID'
	,format(A.VisitDate,'yyyy-MM-dd') AS 'VisitDate'
	,A.VN AS 'VN'
	,A.PrescriptionNo AS 'PrescriptionNo'
	,A.MakeDateTime AS 'MakeDateTime'
	, case when c.StockComposeCategory like 'ME%' then 'Medicine' 
	  when c.StockComposeCategory like 'MS%' then 'Usage' end AS 'ItemType'
	,A.StockCode AS 'ItemCode'
	, dbo.CutSortChar(c.LocalName) AS 'ItemNameTH' --แก้ไขวันที่ 26/02/2568
	, dbo.CutSortChar(c.EnglishName) AS 'ItemNameEN' --เพิ่มวันที่ 26/02/2568
	,A.HNActivityCode AS 'ActivityCode'
	,dbo.sysconname(A.HNActivityCode,42093,2) AS 'ActivityNameTH' --แก้ไขวันที่ 26/02/2568
	,dbo.sysconname(A.HNActivityCode,42093,1) AS 'ActivityNameEN' --เพิ่มวันที่ 26/02/2568
	,A.UnitCode AS 'UnitCode'
	,null AS 'UnitNameTH' --แก้ไขวันที่ 26/02/2568
	,null AS 'UnitNameEN' --เพิ่มวันที่ 26/02/2568
	,A.QTY AS 'QTY'
	,A.UnitPrice  'UnitPrice'
	,A.ChargeAmt AS 'ChargeAmt'
	,Case 
	when A.HNChargeType = 0 then 'Charge' 
	when A.HNChargeType = 1 then 'Free' 
	when A.HNChargeType = 2 then 'Refund'
	when A.HNChargeType = 6 then 'Free Return'
	end AS 'ChargeType'
	,A.ChargeDateTime AS 'ChargeDateTime'
	,A.EntryByFacilityRmsNo AS 'EntryByFacility'
	,A.EntryByFacilityRefNo AS 'RefNo'
	,A.CxlByUserCode AS 'CancelByUserCode' --แก้ไขวันที่ 26/02/2568
	,dbo.sysconname(A.CxlByUserCode,10031,2) AS 'CancelByUserNameTH' --เพิ่มวันที่ 26/02/2568
	,dbo.sysconname(A.CxlByUserCode,10031,1) AS 'CancelByUserNameEN' --เพิ่มวันที่ 26/02/2568
	,A.CxlDateTime AS 'CancelDateTime'
	,A.TreatmentDateTime AS 'TreatmentDateTimeFrom'
	,A.TreatmentDateTime  AS 'TreatmentDateTimeTo'
	,A.DFDoctor AS 'DFDoctor'
	,A.RightCode AS 'RightCode'
	,dbo.sysconname(A.RightCode,42086,2) AS 'RightNameTH' --แก้ไขวันที่ 26/02/2568
	,dbo.sysconname(A.RightCode,42086,1) AS 'RightNameEN' --เพิ่มวันที่ 26/02/2568
	,null AS 'StoreCode'
	,null AS 'StoreNameTH' --แก้ไขวันที่ 26/02/2568
	,null AS 'StoreNameEN' --เพิ่มวันที่ 26/02/2568
	,null AS 'DoseType'
	,null AS 'DoseCode'
	,null AS 'DoseQTY'
	,null AS 'DoseUnit'
	,null AS 'DoseFreqCode'
	,null AS 'AuxLabel1'
	,null AS 'AuxLabel2'
	,null AS 'AuxLabel3'
	,a.FacilityRequestMethod AS 'EntryByFacilityMethodCode' --แก้ไขวันที่ 8/4/68
	,dbo.sysconname(A.FacilityRequestMethod,42161,2) AS 'EntryByFacilityMethodNameTH' --แก้ไขวันที่ 8/4/68
	,dbo.sysconname(A.FacilityRequestMethod,42161,1) AS 'EntryByFacilityMethodNameEN' --แก้ไขวันที่ 8/4/68
	,case when A.CheckUp = 1 then 'True' else 'False' end AS 'Checkup'
	,null AS 'DoseMemo'
	,case when A.DFDoctor is null then 0 else 1 end as 'FlagDF' --เพิ่มวันที่ 17/02/2568
	,cast(SUBSTRING(ACT.Com,17,3) as varchar) as 'ActivityCategoryCode' --เพิ่มวันที่ 26/02/2568
	,dbo.sysconname(cast(SUBSTRING(ACT.Com,17,3) as varchar),42091,2) as 'ActivityCategoryNameTH' --เพิ่มวันที่ 26/02/2568
	,dbo.sysconname(cast(SUBSTRING(ACT.Com,17,3) as varchar),42091,1) as 'ActivityCategoryNameEN' --เพิ่มวันที่ 26/02/2568

from

HNOPD_PRESCRIP_TREATMENT A
left join HNOPD_MASTER B ON(A.visitdate = B.VisitDate and A.vn = B.VN)
left join STOCKMASTER c on A.StockCode = c.StockCode
left join DNSYSCONFIG ACT ON A.HNActivityCode=ACT.Code and ACT.CtrlCode = 42093 
where A.StockCode is not null

union all

select 'PT2' AS 'BU'
	,CONCAT(format(A.MakeDateTime,'yyyyMMdd'),A.vn,A.prescriptionno,format(A.MakeDateTime,'yyyyMMddHHmmssffff'),A.SuffixTiny) AS 'OrderID'
	,B.HN AS 'PatientID'
	,CONCAT(format(A.MakeDateTime,'yyyyMMdd'),A.vn,A.prescriptionno) AS 'VisitID'
	,format(A.VisitDate,'yyyy-MM-dd') AS 'VisitDate'
	,A.VN AS 'VN'
	,A.PrescriptionNo AS 'PrescriptionNo'
	,A.MakeDateTime AS 'MakeDateTime'
	,'Lab' AS 'ItemType'
	,A.LabCode AS 'ItemCode'
	,dbo.sysconname(A.LabCode,42136,2) AS 'ItemNameTH' --แก้ไขวันที่ 26/02/2568
	,dbo.sysconname(A.LabCode,42136,1) AS 'ItemNameEN' --เพิ่มวันที่ 26/02/2568
	,A.HNActivityCode AS 'ActivityCode'
	,dbo.sysconname(A.HNActivityCode,42093,2) AS 'ActivityNameTH' --แก้ไขวันที่ 26/02/2568
	,dbo.sysconname(A.HNActivityCode,42093,1) AS 'ActivityNameEN' --เพิ่มวันที่ 26/02/2568
	,A.UnitCode AS 'UnitCode'
	,null AS 'UnitNameTH' --แก้ไขวันที่ 26/02/2568
	,null AS 'UnitNameEN' --เพิ่มวันที่ 26/02/2568
	,A.QTY AS 'QTY'
	,A.UnitPrice  'UnitPrice'
	,A.ChargeAmt AS 'ChargeAmt'
	,Case 
	when A.HNChargeType = 0 then 'Charge' 
	when A.HNChargeType = 1 then 'Free' 
	when A.HNChargeType = 2 then 'Refund'
	when A.HNChargeType = 6 then 'Free Return'
	end AS 'ChargeType'
	,A.ChargeDateTime AS 'ChargeDateTime'
	,A.EntryByFacilityRmsNo AS 'EntryByFacility'
	,A.EntryByFacilityRefNo AS 'RefNo'
	,A.CxlByUserCode AS 'CancelByUserCode' --แก้ไขวันที่ 26/02/2568
	,dbo.sysconname(A.CxlByUserCode,10031,2) AS 'CancelByUserNameTH' --เพิ่มวันที่ 26/02/2568
	,dbo.sysconname(A.CxlByUserCode,10031,1) AS 'CancelByUserNameEN' --เพิ่มวันที่ 26/02/2568
	,A.CxlDateTime AS 'CancelDateTime'
	,A.TreatmentDateTime AS 'TreatmentDateTimeFrom'
	,A.TreatmentDateTime  AS 'TreatmentDateTimeTo'
	,A.DFDoctor AS 'DFDoctor'
	,A.RightCode AS 'RightCode'
	,dbo.sysconname(A.RightCode,42086,2) AS 'RightNameTH' --แก้ไขวันที่ 26/02/2568
	,dbo.sysconname(A.RightCode,42086,1) AS 'RightNameEN' --เพิ่มวันที่ 26/02/2568
	,null AS 'StoreCode' 
	,null AS 'StoreNameTH' --แก้ไขวันที่ 26/02/2568
	,null AS 'StoreNameEN' --เพิ่มวันที่ 26/02/2568
	,null AS 'DoseType'
	,null AS 'DoseCode'
	,null AS 'DoseQTY'
	,null AS 'DoseUnit'
	,null AS 'DoseFreqCode'
	,null AS 'AuxLabel1'
	,null AS 'AuxLabel2'
	,null AS 'AuxLabel3'
	,a.FacilityRequestMethod AS 'EntryByFacilityMethodCode' --แก้ไขวันที่ 8/4/68
	,dbo.sysconname(A.FacilityRequestMethod,42161,2) AS 'EntryByFacilityMethodNameTH' --แก้ไขวันที่ 8/4/68
	,dbo.sysconname(A.FacilityRequestMethod,42161,1) AS 'EntryByFacilityMethodNameEN' --แก้ไขวันที่ 8/4/68
	,case when A.CheckUp = 1 then 'True' else 'False' end AS 'Checkup'
	,null AS 'DoseMemo'
	, 0 as 'FlagDF' --เพิ่มวันที่ 17/02/2568
	,cast(SUBSTRING(ACT.Com,17,3) as varchar) as 'ActivityCategoryCode' --เพิ่มวันที่ 26/02/2568
	,dbo.sysconname(cast(SUBSTRING(ACT.Com,17,3) as varchar),42091,2) as 'ActivityCategoryNameTH' --เพิ่มวันที่ 26/02/2568
	,dbo.sysconname(cast(SUBSTRING(ACT.Com,17,3) as varchar),42091,1) as 'ActivityCategoryNameEN' --เพิ่มวันที่ 26/02/2568
	
from

HNOPD_PRESCRIP_TREATMENT A
left join HNOPD_MASTER B ON(A.visitdate = B.VisitDate and A.vn = B.VN)
left join DNSYSCONFIG ACT ON A.HNActivityCode=ACT.Code and ACT.CtrlCode = 42093 
where A.LabCode is not null

union all

select 'PT2' AS 'BU'
	,CONCAT(format(A.MakeDateTime,'yyyyMMdd'),A.vn,A.prescriptionno,format(A.MakeDateTime,'yyyyMMddHHmmssffff'),A.SuffixTiny) AS 'OrderID'
	,B.HN AS 'PatientID'
	,CONCAT(format(A.MakeDateTime,'yyyyMMdd'),A.vn,A.prescriptionno) AS 'VisitID'
	,format(A.VisitDate,'yyyy-MM-dd') AS 'VisitDate'
	,A.VN AS 'VN'
	,A.PrescriptionNo AS 'PrescriptionNo'
	,A.MakeDateTime AS 'MakeDateTime'
	,'Xray' AS 'ItemType'
	,A.XrayCode AS 'ItemCode'
	,dbo.sysconname(A.XrayCode,42179,2) AS 'ItemNameTH' --แก้ไขวันที่ 26/02/2568
	,dbo.sysconname(A.XrayCode,42179,1) AS 'ItemNameEN' --เพิ่มวันที่ 26/02/2568
	,A.HNActivityCode AS 'ActivityCode'
	,dbo.sysconname(A.HNActivityCode,42093,2) AS 'ActivityNameTH' --แก้ไขวันที่ 26/02/2568
	,dbo.sysconname(A.HNActivityCode,42093,1) AS 'ActivityNameEN' --เพิ่มวันที่ 26/02/2568
	,A.UnitCode AS 'UnitCode'
	,null AS 'UnitNameTH' --แก้ไขวันที่ 26/02/2568
	,null AS 'UnitNameEN' --เพิ่มวันที่ 26/02/2568
	,A.QTY AS 'QTY'
	,A.UnitPrice  'UnitPrice'
	,A.ChargeAmt AS 'ChargeAmt'
	,Case 
	when A.HNChargeType = 0 then 'Charge' 
	when A.HNChargeType = 1 then 'Free' 
	when A.HNChargeType = 2 then 'Refund'
	when A.HNChargeType = 6 then 'Free Return'
	end AS 'ChargeType'
	,A.ChargeDateTime AS 'ChargeDateTime'
	,A.EntryByFacilityRmsNo AS 'EntryByFacility'
	,A.EntryByFacilityRefNo AS 'RefNo'
	,A.CxlByUserCode AS 'CancelByUserCode' --แก้ไขวันที่ 26/02/2568
	,dbo.sysconname(A.CxlByUserCode,10031,2) AS 'CancelByUserNameTH' --เพิ่มวันที่ 26/02/2568
	,dbo.sysconname(A.CxlByUserCode,10031,1) AS 'CancelByUserNameEN' --เพิ่มวันที่ 26/02/2568
	,A.CxlDateTime AS 'CancelDateTime'
	,A.TreatmentDateTime AS 'TreatmentDateTimeFrom'
	,A.TreatmentDateTime  AS 'TreatmentDateTimeTo'
	,A.DFDoctor AS 'DFDoctor'
	,A.RightCode AS 'RightCode'
	,dbo.sysconname(A.RightCode,42086,2) AS 'RightNameTH' --แก้ไขวันที่ 26/02/2568
	,dbo.sysconname(A.RightCode,42086,1) AS 'RightNameEN' --เพิ่มวันที่ 26/02/2568
	,null AS 'StoreCode'
	,null AS 'StoreNameTH' --แก้ไขวันที่ 26/02/2568
	,null AS 'StoreNameEN' --เพิ่มวันที่ 26/02/2568
	,null AS 'DoseType'
	,null AS 'DoseCode'
	,null AS 'DoseQTY'
	,null AS 'DoseUnit'
	,null AS 'DoseFreqCode'
	,null AS 'AuxLabel1'
	,null AS 'AuxLabel2'
	,null AS 'AuxLabel3'
	,A.FacilityRequestMethod AS 'EntryByFacilityMethodCode'
	,dbo.sysconname(A.FacilityRequestMethod,42161,2) AS 'EntryByFacilityMethodNameTH' --แก้ไขวันที่ 26/02/2568
	,dbo.sysconname(A.FacilityRequestMethod,42161,1) AS 'EntryByFacilityMethodNameEN' --เพิ่มวันที่ 26/02/2568
	,case when A.CheckUp = 1 then 'True' else 'False' end AS 'Checkup'
	,null AS 'DoseMemo'
	, 0 as 'FlagDF' --เพิ่มวันที่ 17/02/2568
	,cast(SUBSTRING(ACT.Com,17,3) as varchar) as 'ActivityCategoryCode' --เพิ่มวันที่ 26/02/2568
	,dbo.sysconname(cast(SUBSTRING(ACT.Com,17,3) as varchar),42091,2) as 'ActivityCategoryNameTH' --เพิ่มวันที่ 26/02/2568
	,dbo.sysconname(cast(SUBSTRING(ACT.Com,17,3) as varchar),42091,1) as 'ActivityCategoryNameEN' --เพิ่มวันที่ 26/02/2568
from

HNOPD_PRESCRIP_TREATMENT A
left join HNOPD_MASTER B ON(A.visitdate = B.VisitDate and A.vn = B.VN)
left join DNSYSCONFIG ACT ON A.HNActivityCode=ACT.Code and ACT.CtrlCode = 42093 
where A.XrayCode is not null

union all

select 'PT2' AS 'BU'
	,CONCAT(format(A.MakeDateTime,'yyyyMMdd'),A.vn,A.prescriptionno,format(A.MakeDateTime,'yyyyMMddHHmmssffff'),A.SuffixTiny) AS 'OrderID'
	,B.HN AS 'PatientID'
	,CONCAT(format(A.MakeDateTime,'yyyyMMdd'),A.vn,A.prescriptionno) AS 'VisitID'
	,format(A.VisitDate,'yyyy-MM-dd') AS 'VisitDate'
	,A.VN AS 'VN'
	,A.PrescriptionNo AS 'PrescriptionNo'
	,A.MakeDateTime AS 'MakeDateTime'
	,'Medicine' AS 'ItemType'
	,A.StockCode AS 'ItemCode'
	,dbo.Stockname(A.StockCode,2) AS 'ItemNameTH' --แก้ไขวันที่ 26/02/2658
	,dbo.Stockname(A.StockCode,1) AS 'ItemNameEN' --เพิ่มวันที่ 26/02/2568
	,A.HNActivityCode AS 'ActivityCode'
	,dbo.sysconname(A.HNActivityCode,42093,2) AS 'ActivityNameTH' --แก้ไขวันที่ 26/02/2658
	,dbo.sysconname(A.HNActivityCode,42093,1) AS 'ActivityNameEN' --เพิ่มวันที่ 26/02/2568
	,A.UnitCode AS 'UnitCode'
	,dbo.sysconname(A.UnitCode,20021,2) AS 'UnitNameTH' --แก้ไขวันที่ 26/02/2658
	,dbo.sysconname(A.UnitCode,20021,1) AS 'UnitNameEN' --เพิ่มวันที่ 26/02/2568
	,A.QTY AS 'QTY'
	,A.UnitPrice  'UnitPrice'
	,A.ChargeAmt AS 'ChargeAmt'
	,Case 
	when A.HNChargeType = 0 then 'Charge' 
	when A.HNChargeType = 1 then 'Free' 
	when A.HNChargeType = 2 then 'Refund'
	when A.HNChargeType = 6 then 'Free Return'
	end AS 'ChargeType'
	,A.ChargeDateTime AS 'ChargeDateTime'
	,A.EntryByFacilityRmsNo AS 'EntryByFacility'
	,A.EntryByFacilityRefNo AS 'RefNo'
	,A.CxlByUserCode AS 'CancelByUserCode'
	,dbo.sysconname(A.CxlByUserCode,10031,2) AS 'CancelByUserNameTH'
	,dbo.sysconname(A.CxlByUserCode,10031,1) AS 'CancelByUserNameEN'
	,A.CxlDateTime AS 'CancelDateTime'
	,null AS 'TreatmentDateTimeFrom'
	,null  AS 'TreatmentDateTimeTo'
	,null AS 'DFDoctor'
	,A.RightCode AS 'RightCode'
	,dbo.sysconname(A.RightCode,42086,2) AS 'RightNameTH' --แก้ไขวันที่ 26/022568
	,dbo.sysconname(A.RightCode,42086,1) AS 'RightNameEN' --เพิ่มวันที่ 26/02/2568
	,A.Store AS 'StoreCode'
	,dbo.sysconname(A.Store,20020,2) AS 'StoreNameTH' --แก้ไขวันที่ 26/022568
	,dbo.sysconname(A.Store,20020,1) AS 'StoreNameEN' --เพิ่มวันที่ 26/02/2568
	,A.DoseType AS 'DoseType'
	,A.DoseCode AS 'DoseCode'
	,A.DoseQtyCode AS 'DoseQTY'
	,a.DoseUnitCode AS 'DoseUnit'
	,a.DoseFreqCode AS 'DoseFreqCode'
	,a.AuxLabel1 AS 'AuxLabel1'
	,a.AuxLabel2 AS 'AuxLabel2'
	,a.AuxLabel3 AS 'AuxLabel3'
	,a.FacilityRequestMethod AS 'EntryByFacilityMethodCode'
	,dbo.sysconname(A.FacilityRequestMethod,42161,2) AS 'EntryByFacilityMethodNameTH' --แก้ไขวันที่ 26/022568
	,dbo.sysconname(A.FacilityRequestMethod,42161,1) AS 'EntryByFacilityMethodNameEN' --เพิ่มวันที่ 26/02/2568
	,case when A.CheckUp = 1 then 'True' else 'False' end AS 'Checkup'
	,A.DoseMemo AS 'DoseMemo'
	, 0 as 'FlagDF' --เพิ่มวันที่ 17/02/2568
	,cast(SUBSTRING(ACT.Com,17,3) as varchar) as 'ActivityCategoryCode' --เพิ่มวันที่ 26/02/2568
	,dbo.sysconname(cast(SUBSTRING(ACT.Com,17,3) as varchar),42091,2) as 'ActivityCategoryNameTH' --เพิ่มวันที่ 26/02/2568
	,dbo.sysconname(cast(SUBSTRING(ACT.Com,17,3) as varchar),42091,1) as 'ActivityCategoryNameEN' --เพิ่มวันที่ 26/02/2568
from

HNOPD_PRESCRIP_MEDICINE A
left join HNOPD_MASTER B ON(A.visitdate = B.VisitDate and A.vn = B.VN)
left join DNSYSCONFIG ACT ON A.HNActivityCode=ACT.Code and ACT.CtrlCode = 42093 
where A.HereUsage = 0


union all

select 'PT2' AS 'BU'
	,CONCAT(format(A.MakeDateTime,'yyyyMMdd'),A.vn,A.prescriptionno,format(A.MakeDateTime,'yyyyMMddHHmmssffff'),A.SuffixTiny) AS 'OrderID'
	,B.HN AS 'PatientID'
	,CONCAT(format(A.MakeDateTime,'yyyyMMdd'),A.vn,A.prescriptionno) AS 'VisitID'
	,format(A.VisitDate,'yyyy-MM-dd') AS 'VisitDate'
	,A.VN AS 'VN'
	,A.PrescriptionNo AS 'PrescriptionNo'
	,A.MakeDateTime AS 'MakeDateTime'
	,'Usage' AS 'ItemType'
	,A.StockCode AS 'ItemCode'
	,dbo.Stockname(A.StockCode,2) AS 'ItemNameTH' --แก้ไขวันที่ 26/02/2568
	,dbo.Stockname(A.StockCode,1) AS 'ItemNameEN' --เพิ่มวันที่ 26/02/2568
	,A.HNActivityCode AS 'ActivityCode'
	,dbo.sysconname(A.HNActivityCode,42093,2) AS 'ActivityNameTH' --แก้ไขวันที่ 26/02/2568
	,dbo.sysconname(A.HNActivityCode,42093,1) AS 'ActivityNameEN' --เพิ่มวันที่ 26/02/2568
	,A.UnitCode AS 'UnitCode'
	,dbo.sysconname(A.UnitCode,20021,2) AS 'UnitNameTH' --แก้ไขวันที่ 26/02/2568
	,dbo.sysconname(A.UnitCode,20021,1) AS 'UnitNameEN' --เพิ่มวันที่ 26/02/2568
	,A.QTY AS 'QTY'
	,A.UnitPrice  'UnitPrice'
	,A.ChargeAmt AS 'ChargeAmt'
	,Case 
	when A.HNChargeType = 0 then 'Charge' 
	when A.HNChargeType = 1 then 'Free' 
	when A.HNChargeType = 2 then 'Refund'
	when A.HNChargeType = 6 then 'Free Return'
	end AS 'ChargeType'
	,A.ChargeDateTime AS 'ChargeDateTime'
	,A.EntryByFacilityRmsNo AS 'EntryByFacility'
	,A.EntryByFacilityRefNo AS 'RefNo'
	,A.CxlByUserCode AS 'CancelByUserCode' --แก้ไขวันที่ 26/02/2568
	,dbo.sysconname(A.CxlByUserCode,10031,2) AS 'CancelByUserNameTH' --เพิ่มวันที่ 26/02/2568
	,dbo.sysconname(A.CxlByUserCode,10031,1) AS 'CancelByUserNameEN' --เพิ่มวันที่ 26/02/2568
	,A.CxlDateTime AS 'CancelDateTime'
	,null AS 'TreatmentDateTimeFrom'
	,null  AS 'TreatmentDateTimeTo'
	,null AS 'DFDoctor'
	,A.RightCode AS 'RightCode'
	,dbo.sysconname(A.RightCode,42086,2) AS 'RightNameTH' --แก้ไขวันที่ 26/02/2568
	,dbo.sysconname(A.RightCode,42086,1) AS 'RightNameEN' --เพิ่มวันที่ 26/02/2568
	,A.Store AS 'StoreCode'
	,dbo.sysconname(A.Store,20020,2) AS 'StoreNameTH' --แก้ไขวันที่ 26/02/2568
	,dbo.sysconname(A.Store,20020,1) AS 'StoreNameEN' --เพิ่มวันที่ 26/02/2568
	,A.DoseType AS 'DoseType'
	,A.DoseCode AS 'DoseCode'
	,A.DoseQtyCode AS 'DoseQTY'
	,a.DoseUnitCode AS 'DoseUnit'
	,a.DoseFreqCode AS 'DoseFreqCode'
	,a.AuxLabel1 AS 'AuxLabel1'
	,a.AuxLabel2 AS 'AuxLabel2'
	,a.AuxLabel3 AS 'AuxLabel3'
	,a.FacilityRequestMethod AS 'EntryByFacilityMethodCode'
	,dbo.sysconname(A.FacilityRequestMethod,42161,2) AS 'EntryByFacilityMethodNameTH'
	,dbo.sysconname(A.FacilityRequestMethod,42161,1) AS 'EntryByFacilityMethodNameEN'
	,case when A.CheckUp = 1 then 'True' else 'False' end AS 'Checkup'
	,A.DoseMemo AS 'DoseMemo'
	, 0 as 'FlagDF' --เพิ่มวันที่ 17/02/2568
	,cast(SUBSTRING(ACT.Com,17,3) as varchar) as 'ActivityCategoryCode' --เพิ่มวันที่ 26/02/2568
	,dbo.sysconname(cast(SUBSTRING(ACT.Com,17,3) as varchar),42091,2) as 'ActivityCategoryNameTH' --เพิ่มวันที่ 26/02/2568
	,dbo.sysconname(cast(SUBSTRING(ACT.Com,17,3) as varchar),42091,1) as 'ActivityCategoryNameEN' --เพิ่มวันที่ 26/02/2568
from

HNOPD_PRESCRIP_MEDICINE A
left join HNOPD_MASTER B ON(A.visitdate = B.VisitDate and A.vn = B.VN)
left join DNSYSCONFIG ACT ON A.HNActivityCode=ACT.Code and ACT.CtrlCode = 42093
where A.HereUsage = 1
