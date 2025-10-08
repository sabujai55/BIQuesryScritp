use SSBLIVE
go

--****************************** TREATMENT ******************************
select	'PT2' as BU 
		, convert(varchar(25), b.AdmDateTime, 112) + replace(b.AN,'/','') + FORMAT(a.IPDChargeDateTime, 'yyyyMMddHHmmss') + convert(varchar(3),a.IPDChargeSuffixTiny) as OrderID
		, b.HN as PatientID
		, convert(varchar(25), b.AdmDateTime, 112) + replace(b.AN,'/','') as AdmitID
		, b.AdmDateTime as AdmitDate
		, b.AN
		, a.IPDChargeDateTime as MakeDateTime
		, 'Treatment' as  ItemType
		, a.TreatmentCode as ItemCode
		, dbo.CutSortChar(sys01.LocalName) as ItemNameTH --แก้ไขวันที่ 03/03/2568
		, dbo.CutSortChar(sys01.EnglishName) as ItemNameEN --เพิ่มวันที่ 03/03/2568
		, a.HNActivityCode as ActivityCode
		, dbo.CutSortChar(sys02.LocalName) as ActivityNameTH --แก้ไขวันที่ 03/03/2568
		, dbo.CutSortChar(sys02.EnglishName) as ActivityNameEN --เพิ่มวันที่ 03/03/2568
		, '' as UnitCode
		, '' as UnitNameTH --แก้ไขวันที่ 03/03/2568 
		, '' as UnitNameEN --เพิ่มวันที่ 03/03/2568
		, case when a.HNChargeType = 2 then a.Qty * (-1) else a.Qty end as QTY
		, a.ChargeAmt as UnitPrice
		, case when a.HNChargeType = 2 then a.ChargeAmt * (-1) else a.ChargeAmt end as ChargeAmt
		, case when a.HNChargeType = 0 then 'Charge' 
		  when a.HNChargeType = 1 then 'FreeOfCharge'
		  when a.HNChargeType = 2 then 'Return' 
		  when a.HNChargeType = 6 then 'ReturnFreeOfCharge'
		  end as ChargeType
		, a.ChargeDateTime
		, a.EntryByFacilityRmsNo as EntryByFacility
		, case when a.EntryByFacilityRmsNo is not null then a.EntryByFacilityRefNo else a.OrderRef end as RefNo
		, a.VoidByUserCode as CancelByUserCode --แก้ไขวันที่ 03/03/2568 
		, dbo.sysconname(a.VoidByUserCode,10031,2) as CancelByUserNameTH --เพิ่มวันที่ 03/03/2568
		, dbo.sysconname(a.VoidByUserCode,10031,1) as CancelByUserNameEN --เพิ่มวันที่ 03/03/2568
		, a.VoidDateTime as CancelDateTime
		, a.ForDateTimeFrom as TreatmentDateTimeFrom
		, a.ForDateTimeTo as TreatmentDateTimeTo
		, a.DFDoctor
		, a.RightCode
		, dbo.CutSortChar(sys03.LocalName) as RightNameTH --แก้ไขวันที่ 03/03/2568 
		, dbo.CutSortChar(sys03.EnglishName) as RightNameEN --เพิ่มวันที่ 03/03/2568
		, '' as StoreCode 
		, '' as StoreNameTH --แก้ไขวันที่ 03/03/2568 
		, '' as StoreNameEN --เพิ่มวันที่ 03/03/2568
		, '' as DoseType
		, '' as DoseCode
		, '' as DoseQTY
		, '' as DoseUnit
		, '' as DoseFreqCode
		, '' as AuxLabel1
		, '' as AuxLabel2
		, '' as AuxLabel3
		, a.FacilityRequestMethod as EntryByFacilityMethodCode
		, dbo.CutSortChar(sys04.LocalName) as EntryByFacilityMethodNameTH --แก้ไขวันที่ 03/03/2568 
		, dbo.CutSortChar(sys04.EnglishName) as EntryByFacilityMethodNameEN --เพิ่มวันที่ 03/03/2568
		, a.CheckUp as Checkup 
		, '' as DoseMemo
		, case when a.DFDoctor is not null then 1 else 0 end as FlagDF --เพิ่มวันที่ 03/03/2568
		, CAST(SUBSTRING(sys02.Com,17,3)as varchar) as ActivityCategoryCode --เพิ่มวันที่ 03/03/2568
		, dbo.sysconname(CAST(SUBSTRING(sys02.Com,17,3)as varchar),42091,2) as ActivityCategoryNameTH --เพิ่มวันที่ 03/03/2568
		, dbo.sysconname(CAST(SUBSTRING(sys02.Com,17,3)as varchar),42091,1) as ActivityCategoryNameEN --เพิ่มวันที่ 03/03/2568
from	HNIPD_CHARGE a
		left join HNIPD_MASTER b on a.AN = b.AN 
		left join DNSYSCONFIG sys01 on sys01.CtrlCode = 42075 and a.TreatmentCode = sys01.Code
		left join DNSYSCONFIG sys02 on sys02.CtrlCode = 42093 and a.HNActivityCode = sys02.Code
		left join DNSYSCONFIG sys03 on sys03.CtrlCode = 42086 and a.RightCode = sys03.Code
		left join DNSYSCONFIG sys04 on sys04.CtrlCode = 42161 and a.FacilityRequestMethod = sys04.Code
where	a.TreatmentCode is not null 
union all 
--****************************** LAB ******************************
select	'PT2' as BU 
		, convert(varchar(25), b.AdmDateTime, 112) + replace(b.AN,'/','') + FORMAT(a.IPDChargeDateTime, 'yyyyMMddHHmmss') + convert(varchar(3),a.IPDChargeSuffixTiny) as OrderID
		, b.HN as PatientID
		, convert(varchar(25), b.AdmDateTime, 112) + replace(b.AN,'/','') as AdmitID
		, b.AdmDateTime as AdmitDate
		, b.AN
		, a.IPDChargeDateTime as MakeDateTime
		, 'Lab' as  ItemType
		, a.LabCode as ItemCode
		, dbo.CutSortChar(sys01.LocalName) as ItemNameTH --แก้ไขวันที่ 03/03/2568 
		, dbo.CutSortChar(sys01.EnglishName) as ItemNameEN --เพิ่มวันที่ 03/03/2568
		, a.HNActivityCode as ActivityCode
		, dbo.CutSortChar(sys02.LocalName) as ActivityNameTH --แก้ไขวันที่ 03/03/2568 
		, dbo.CutSortChar(sys02.EnglishName) as ActivityNameEN --เพิ่มวันที่ 03/03/2568
		, '' as UnitCode
		, '' as UnitNameTH --แก้ไขวันที่ 03/03/2568 
		, '' as UnitNameEN --เพิ่มวันที่ 03/03/2568
		, case when a.HNChargeType = 2 then a.Qty * (-1) else a.Qty end as QTY
		, a.ChargeAmt as UnitPrice
		, case when a.HNChargeType = 2 then a.ChargeAmt * (-1) else a.ChargeAmt end as ChargeAmt
		, case when a.HNChargeType = 0 then 'Charge' 
		  when a.HNChargeType = 1 then 'FreeOfCharge'
		  when a.HNChargeType = 2 then 'Return' 
		  when a.HNChargeType = 6 then 'ReturnFreeOfCharge'
		  end as ChargeType
		, a.ChargeDateTime
		, a.EntryByFacilityRmsNo as EntryByFacility
		, case when a.EntryByFacilityRmsNo is not null then a.EntryByFacilityRefNo else a.OrderRef end as RefNo
		, a.VoidByUserCode as CancelByUserCode --แก้ไขวันที่ 03/03/2568 
		, dbo.sysconname(a.VoidByUserCode,10031,2) as CancelByUserNameTH --เพิ่มวันที่ 03/03/2568
		, dbo.sysconname(a.VoidByUserCode,10031,1) as CancelByUserNameEN --เพิ่มวันที่ 03/03/2568
		, a.VoidDateTime as CancelDateTime
		, a.ForDateTimeFrom as TreatmentDateTimeFrom
		, a.ForDateTimeTo as TreatmentDateTimeTo
		, a.DFDoctor
		, a.RightCode
		, dbo.CutSortChar(sys03.LocalName) as RightNameTH --แก้ไขวันที่ 03/03/2568 
		, dbo.CutSortChar(sys03.EnglishName) as RightNameEN --เพิ่มวันที่ 03/03/2568
		, '' as StoreCode
		, '' as StoreNameTH --แก้ไขวันที่ 03/03/2568 
		, '' as StoreNameEN --เพิ่มวันที่ 03/03/2568
		, '' as DoseType
		, '' as DoseCode
		, '' as DoseQTY
		, '' as DoseUnit
		, '' as DoseFreqCode
		, '' as AuxLabel1
		, '' as AuxLabel2
		, '' as AuxLabel3
		, a.FacilityRequestMethod as EntryByFacilityMethodCode
		, dbo.CutSortChar(sys04.LocalName) as EntryByFacilityMethodNameTH --แก้ไขวันที่ 03/03/2568 
		, dbo.CutSortChar(sys04.EnglishName) as EntryByFacilityMethodNameEN --เพิ่มวันที่ 03/03/2568
		, a.CheckUp as Checkup 
		, '' as DoseMemo
		, case when a.DFDoctor is not null then 1 else 0 end as FlagDF --เพิ่มวันที่ 03/03/2568
		, CAST(SUBSTRING(sys02.Com,17,3)as varchar) as ActivityCategoryCode --เพิ่มวันที่ 03/03/2568
		, dbo.sysconname(CAST(SUBSTRING(sys02.Com,17,3)as varchar),42091,2) as ActivityCategoryNameTH --เพิ่มวันที่ 03/03/2568
		, dbo.sysconname(CAST(SUBSTRING(sys02.Com,17,3)as varchar),42091,1) as ActivityCategoryNameEN --เพิ่มวันที่ 03/03/2568
from	HNIPD_CHARGE a
		left join HNIPD_MASTER b on a.AN = b.AN 
		left join DNSYSCONFIG sys01 on sys01.CtrlCode = 42136 and a.LabCode = sys01.Code
		left join DNSYSCONFIG sys02 on sys02.CtrlCode = 42093 and a.HNActivityCode = sys02.Code
		left join DNSYSCONFIG sys03 on sys03.CtrlCode = 42086 and a.RightCode = sys03.Code
		left join DNSYSCONFIG sys04 on sys04.CtrlCode = 42161 and a.FacilityRequestMethod = sys04.Code
where	a.LabCode is not null
union all 
--****************************** XRAY ******************************
select	'PT2' as BU 
		, convert(varchar(25), b.AdmDateTime, 112) + replace(b.AN,'/','') + FORMAT(a.IPDChargeDateTime, 'yyyyMMddHHmmss') + convert(varchar(3),a.IPDChargeSuffixTiny) as OrderID
		, b.HN as PatientID
		, convert(varchar(25), b.AdmDateTime, 112) + replace(b.AN,'/','') as AdmitID
		, b.AdmDateTime as AdmitDate
		, b.AN
		, a.IPDChargeDateTime as MakeDateTime
		, 'Xray' as  ItemType
		, a.XrayCode as ItemCode
		, dbo.CutSortChar(sys01.LocalName) as ItemNameTH --แก้ไขวันที่ 03/03/2568 
		, dbo.CutSortChar(sys01.EnglishName) as ItemNameEN --เพิ่มวันที่ 03/03/2568
		, a.HNActivityCode as ActivityCode
		, dbo.CutSortChar(sys02.LocalName) as ActivityNameTH --แก้ไขวันที่ 03/03/2568 
		, dbo.CutSortChar(sys02.EnglishName) as ActivityNameEN --เพิ่มวันที่ 03/03/2568
		, '' as UnitCode
		, '' as UnitNameTH --แก้ไขวันที่ 03/03/2568 
		, '' as UnitNameEN --เพิ่มวันที่ 03/03/2568
		, case when a.HNChargeType = 2 then a.Qty * (-1) else a.Qty end as QTY
		, a.ChargeAmt as UnitPrice
		, case when a.HNChargeType = 2 then a.ChargeAmt * (-1) else a.ChargeAmt end as ChargeAmt
		, case when a.HNChargeType = 0 then 'Charge' 
		  when a.HNChargeType = 1 then 'FreeOfCharge'
		  when a.HNChargeType = 2 then 'Return' 
		  when a.HNChargeType = 6 then 'ReturnFreeOfCharge'
		  end as ChargeType
		, a.ChargeDateTime
		, a.EntryByFacilityRmsNo as EntryByFacility
		, case when a.EntryByFacilityRmsNo is not null then a.EntryByFacilityRefNo else a.OrderRef end as RefNo
		, a.VoidByUserCode as CancelByUserCode --แก้ไขวันที่ 03/03/2568 
		, dbo.sysconname(a.VoidByUserCode,10031,2) as CancelByUserNameTH --เพิ่มวันที่ 03/03/2568
		, dbo.sysconname(a.VoidByUserCode,10031,1) as CancelByUserNameEN --เพิ่มวันที่ 03/03/2568
		, a.VoidDateTime as CancelDateTime
		, a.ForDateTimeFrom as TreatmentDateTimeFrom
		, a.ForDateTimeTo as TreatmentDateTimeTo
		, a.DFDoctor
		, a.RightCode
		, dbo.CutSortChar(sys03.LocalName) as RightNameTH --แก้ไขวันที่ 03/03/2568 
		, dbo.CutSortChar(sys03.EnglishName) as RightNameEN --เพิ่มวันที่ 03/03/2568
		, '' as StoreCode
		, '' as StoreNameTH --แก้ไขวันที่ 03/03/2568
		, '' as StoreNameEN --เพิ่มวันที่ 03/03/2568
		, '' as DoseType
		, '' as DoseCode
		, '' as DoseQTY
		, '' as DoseUnit
		, '' as DoseFreqCode
		, '' as AuxLabel1
		, '' as AuxLabel2
		, '' as AuxLabel3
		, a.FacilityRequestMethod as EntryByFacilityMethodCode 
		, dbo.CutSortChar(sys04.LocalName) as EntryByFacilityMethodNameTH --แก้ไขวันที่ 03/03/2568 
		, dbo.CutSortChar(sys04.EnglishName) as EntryByFacilityMethodNameEN --เพิ่มวันที่ 03/03/2568
		, a.CheckUp as Checkup 
		, '' as DoseMemo
		, case when a.DFDoctor is not null then 1 else 0 end as FlagDF --เพิ่มวันที่ 03/03/2568
		, CAST(SUBSTRING(sys02.Com,17,3)as varchar) as ActivityCategoryCode --เพิ่มวันที่ 03/03/2568
		, dbo.sysconname(CAST(SUBSTRING(sys02.Com,17,3)as varchar),42091,2) as ActivityCategoryNameTH --เพิ่มวันที่ 03/03/2568
		, dbo.sysconname(CAST(SUBSTRING(sys02.Com,17,3)as varchar),42091,1) as ActivityCategoryNameEN --เพิ่มวันที่ 03/03/2568
from	HNIPD_CHARGE a
		left join HNIPD_MASTER b on a.AN = b.AN 
		left join DNSYSCONFIG sys01 on sys01.CtrlCode = 42179 and a.XrayCode = sys01.Code
		left join DNSYSCONFIG sys02 on sys02.CtrlCode = 42093 and a.HNActivityCode = sys02.Code
		left join DNSYSCONFIG sys03 on sys03.CtrlCode = 42086 and a.RightCode = sys03.Code
		left join DNSYSCONFIG sys04 on sys04.CtrlCode = 42161 and a.FacilityRequestMethod = sys04.Code
where	 a.XrayCode is not null
union all 
--****************************** PT ******************************
select	'PT2' as BU 
		, convert(varchar(25), b.AdmDateTime, 112) + replace(b.AN,'/','') + FORMAT(a.IPDChargeDateTime, 'yyyyMMddHHmmss') + convert(varchar(3),a.IPDChargeSuffixTiny) as OrderID
		, b.HN as PatientID
		, convert(varchar(25), b.AdmDateTime, 112) + replace(b.AN,'/','') as AdmitID
		, b.AdmDateTime as AdmitDate
		, b.AN
		, a.IPDChargeDateTime as MakeDateTime
		, 'PT' as  ItemType
		, a.PTModeCode as ItemCode
		, dbo.CutSortChar(sys01.LocalName) as ItemNameTH --แก้ไขวันที่ 03/03/2568 
		, dbo.CutSortChar(sys01.EnglishName) as ItemNameEN --เพิ่มวันที่ 03/03/2568
		, a.HNActivityCode as ActivityCode
		, dbo.CutSortChar(sys02.LocalName) as ActivityNameTH --แก้ไขวันที่ 03/03/2568 
		, dbo.CutSortChar(sys02.EnglishName) as ActivityNameEN --เพิ่มวันที่ 03/03/2568
		, '' as UnitCode
		, '' as UnitNameTH --แก้ไขวันที่ 03/03/2568 
		, '' as UnitNameEN --เพิ่มวันที่ 03/03/2568
		, case when a.HNChargeType = 2 then a.Qty * (-1) else a.Qty end as QTY
		, a.ChargeAmt as UnitPrice
		, case when a.HNChargeType = 2 then a.ChargeAmt * (-1) else a.ChargeAmt end as ChargeAmt
		, case when a.HNChargeType = 0 then 'Charge' 
		  when a.HNChargeType = 1 then 'FreeOfCharge'
		  when a.HNChargeType = 2 then 'Return' 
		  when a.HNChargeType = 6 then 'ReturnFreeOfCharge'
		  end as ChargeType
		, a.ChargeDateTime
		, a.EntryByFacilityRmsNo as EntryByFacility
		, case when a.EntryByFacilityRmsNo is not null then a.EntryByFacilityRefNo else a.OrderRef end as RefNo
		, a.VoidByUserCode as CancelByUserCode --แก้ไขวันที่ 03/03/2568 
		, dbo.sysconname(a.VoidByUserCode,10031,2) as CancelByUserNameTH --เพิ่มวันที่ 03/03/2568
		, dbo.sysconname(a.VoidByUserCode,10031,1) as CancelByUserNameEN --เพิ่มวันที่ 03/03/2568
		, a.VoidDateTime as CancelDateTime
		, a.ForDateTimeFrom as TreatmentDateTimeFrom
		, a.ForDateTimeTo as TreatmentDateTimeTo
		, a.DFDoctor
		, a.RightCode
		, dbo.CutSortChar(sys03.LocalName) as RightNameTH --แก้ไขวันที่ 03/03/2568 
		, dbo.CutSortChar(sys03.EnglishName) as RightNameEN --เพิ่มวันที่ 03/03/2568
		, '' as StoreCode
		, '' as StoreNameTH --แก้ไขวันที่ 03/03/2568 
		, '' as StoreNameEN --เพิ่มวันที่ 03/03/2568
		, '' as DoseType
		, '' as DoseCode
		, '' as DoseQTY
		, '' as DoseUnit
		, '' as DoseFreqCode
		, '' as AuxLabel1
		, '' as AuxLabel2
		, '' as AuxLabel3
		, a.FacilityRequestMethod as EntryByFacilityMethodCode
		, dbo.CutSortChar(sys04.LocalName) as EntryByFacilityMethodNameTH --แก้ไขวันที่ 03/03/2568
		, dbo.CutSortChar(sys04.EnglishName) as EntryByFacilityMethodNameEN --เพิ่มวันที่ 03/03/2568
		, a.CheckUp as Checkup 
		, '' as DoseMemo
		, case when a.DFDoctor is not null then 1 else 0 end as FlagDF --เพิ่มวันที่ 03/03/2568
		, CAST(SUBSTRING(sys02.Com,17,3)as varchar) as ActivityCategoryCode --เพิ่มวันที่ 03/03/2568
		, dbo.sysconname(CAST(SUBSTRING(sys02.Com,17,3)as varchar),42091,2) as ActivityCategoryNameTH --เพิ่มวันที่ 03/03/2568
		, dbo.sysconname(CAST(SUBSTRING(sys02.Com,17,3)as varchar),42091,1) as ActivityCategoryNameEN --เพิ่มวันที่ 03/03/2568
from	HNIPD_CHARGE a
		left join HNIPD_MASTER b on a.AN = b.AN 
		left join DNSYSCONFIG sys01 on sys01.CtrlCode = 42632 and a.PTModeCode = sys01.Code
		left join DNSYSCONFIG sys02 on sys02.CtrlCode = 42093 and a.HNActivityCode = sys02.Code
		left join DNSYSCONFIG sys03 on sys03.CtrlCode = 42086 and a.RightCode = sys03.Code
		left join DNSYSCONFIG sys04 on sys04.CtrlCode = 42161 and a.FacilityRequestMethod = sys04.Code
where	 a.PTModeCode is not null
union all 
--****************************** Medicine ******************************
select	'PT2' as BU 
		, convert(varchar(25), b.AdmDateTime, 112) + replace(b.AN,'/','') + FORMAT(a.IPDChargeDateTime, 'yyyyMMddHHmmss') + convert(varchar(3),c.ChargeMedicineSuffixSmall) as OrderID
		, b.HN as PatientID
		, convert(varchar(25), b.AdmDateTime, 112) + replace(b.AN,'/','') as AdmitID
		, b.AdmDateTime as AdmitDate
		, b.AN
		, a.IPDChargeDateTime as MakeDateTime
		, case when sk.StockComposeCategory like 'ME.%' then 'Medicine' else 'Usage' end as  ItemType
		, c.StockCode as ItemCode
		, dbo.CutSortChar(sk.LocalName) as ItemNameTH --แก้ไขวันที่ 03/03/2568
		, dbo.CutSortChar(sk.EnglishName) as ItemNameEN --เพิ่มวันที่ 03/03/2568
		, a.HNActivityCode as ActivityCode
		, dbo.CutSortChar(sys02.LocalName) as ActivityNameTH --แก้ไขวันที่ 03/03/2568
		, dbo.CutSortChar(sys02.EnglishName) as ActivityNameEN --เพิ่มวันที่ 03/03/2568
		, d.UnitCode as UnitCode
		, coalesce(dbo.CutSortChar(sys14.LocalName),'') as UnitNameTH --แก้ไขวันที่ 03/03/2568
		, coalesce(dbo.CutSortChar(sys14.EnglishName),'') as UnitNameEN --เพิ่มวันที่ 03/03/2568
		, case when d.HNChargeType = 2 then d.Qty * (-1) else d.Qty end as QTY
		, d.UnitPrice as UnitPrice
		, case when d.HNChargeType = 2 then d.ChargeAmt * (-1) else d.ChargeAmt end as ChargeAmt
		, case when a.HNChargeType = 0 then 'Charge' 
		  when a.HNChargeType = 1 then 'FreeOfCharge'
		  when a.HNChargeType = 2 then 'Return' 
		  when a.HNChargeType = 6 then 'ReturnFreeOfCharge'
		  end as ChargeType
		, a.ChargeDateTime
		, a.EntryByFacilityRmsNo as EntryByFacility
		, case when a.EntryByFacilityRmsNo is not null then a.EntryByFacilityRefNo else a.OrderRef end as RefNo
		, a.VoidByUserCode as CancelByUserCode --แก้ไขวันที่ 03/03/2568 
		, dbo.sysconname(a.VoidByUserCode,10031,2) as CancelByUserNameTH --เพิ่มวันที่ 03/03/2568
		, dbo.sysconname(a.VoidByUserCode,10031,1) as CancelByUserNameEN --เพิ่มวันที่ 03/03/2568
		, a.VoidDateTime as CancelDateTime
		, a.ForDateTimeFrom as TreatmentDateTimeFrom
		, a.ForDateTimeTo as TreatmentDateTimeTo
		, a.DFDoctor
		, a.RightCode
		, dbo.CutSortChar(sys03.LocalName) as RightNameTH --แก้ไขวันที่ 03/03/2568 
		, dbo.CutSortChar(sys03.EnglishName) as RightNameEN --เพิ่มวันที่ 03/03/2568
		, c.Store as StoreCode
		, coalesce(dbo.CutSortChar(sys05.LocalName),'') as StoreNameTH --แก้ไขวันที่ 03/03/2568 
		, coalesce(dbo.CutSortChar(sys05.EnglishName),'') as StoreNameEN --เพิ่มวันที่ 03/03/2568
		, coalesce(dbo.CutSortChar(sys06.LocalName), dbo.CutSortChar(sys06.EnglishName),'') as DoseType
		, coalesce(dbo.CutSortChar(sys07.LocalName), dbo.CutSortChar(sys07.EnglishName),'') as DoseCode
		, coalesce(dbo.CutSortChar(sys08.EnglishName), dbo.CutSortChar(sys08.LocalName),'') as DoseQTY
		--, e.DoseQtyCode as DoseQTY
		, coalesce(dbo.CutSortChar(sys09.LocalName), dbo.CutSortChar(sys09.EnglishName),'') as DoseUnit
		, coalesce(dbo.CutSortChar(sys10.LocalName), dbo.CutSortChar(sys10.EnglishName),'') as DoseFreqCode
		, coalesce(dbo.CutSortChar(sys11.LocalName), dbo.CutSortChar(sys11.EnglishName),'') as AuxLabel1
		, coalesce(dbo.CutSortChar(sys12.LocalName), dbo.CutSortChar(sys12.EnglishName),'') as AuxLabel2
		, coalesce(dbo.CutSortChar(sys13.LocalName), dbo.CutSortChar(sys13.EnglishName),'') as AuxLabel3
		, a.FacilityRequestMethod as EntryByFacilityMethodCode
		, dbo.CutSortChar(sys04.LocalName) as EntryByFacilityMethodNameTH --แก้ไขวันที่ 03/03/2568 
		, dbo.CutSortChar(sys04.EnglishName) as EntryByFacilityMethodNameEN --เพิ่มวันที่ 03/03/2568
		, a.CheckUp as Checkup  
		, e.DoseMemo as DoseMemo --เพิ่มวันที่ 03/03/2568
		, case when a.DFDoctor is not null then 1 else 0 end as FlagDF --เพิ่มวันที่ 03/03/2568
		, CAST(SUBSTRING(sys02.Com,17,3)as varchar) as ActivityCategoryCode --เพิ่มวันที่ 03/03/2568
		, dbo.sysconname(CAST(SUBSTRING(sys02.Com,17,3)as varchar),42091,2) as ActivityCategoryNameTH --เพิ่มวันที่ 03/03/2568
		, dbo.sysconname(CAST(SUBSTRING(sys02.Com,17,3)as varchar),42091,1) as ActivityCategoryNameEN --เพิ่มวันที่ 03/03/2568
from	HNIPD_CHARGE a
		left join HNIPD_MASTER b on a.AN = b.AN 
		left join HNIPD_CHARGE_MEDICINE c on a.AN = c.AN and a.IPDChargeDateTime = c.IPDChargeDateTime and a.IPDChargeSuffixTiny = c.IPDChargeSuffixTiny
		LEFT join HNIPD_DRUG_HISTORY d on c.AN = d.AN and c.IPDChargeDateTime = d.IPDChargeDateTime and c.ChargeMedicineSuffixSmall = d.ChargeMedicineSuffixSmall
		left join  HNIPDDRUG_ORDER_ITEM e on d.DrugOrderNo = e.DrugOrderNo and d.ChargeMedicineSuffixSmall = e.SuffixSmall and d.StockCode = e.StockCode
		LEFT join STOCKMASTER sk on c.StockCode = sk.StockCode 
		left join DNSYSCONFIG sys02 on sys02.CtrlCode = 42093 and a.HNActivityCode = sys02.Code
		left join DNSYSCONFIG sys03 on sys03.CtrlCode = 42086 and a.RightCode = sys03.Code
		left join DNSYSCONFIG sys04 on sys04.CtrlCode = 42161 and a.FacilityRequestMethod = sys04.Code
		left join DNSYSCONFIG sys05 on sys05.CtrlCode = 20020 and c.Store = sys05.Code
		left join DNSYSCONFIG sys06 on sys06.CtrlCode = 42042 and e.DoseType = sys06.Code
		left join DNSYSCONFIG sys07 on sys07.CtrlCode = 42043 and e.DoseCode = sys07.Code
		left join DNSYSCONFIG sys08 on sys08.CtrlCode = 42044 and e.DoseQtyCode = sys08.Code
		left join DNSYSCONFIG sys09 on sys09.CtrlCode = 42045 and e.DoseUnitCode = sys09.Code
		left join DNSYSCONFIG sys10 on sys10.CtrlCode = 42041 and e.DoseFreqCode = sys10.Code
		left join DNSYSCONFIG sys11 on sys11.CtrlCode = 42046 and e.AuxLabel1 = sys11.Code
		left join DNSYSCONFIG sys12 on sys12.CtrlCode = 42046 and e.AuxLabel2 = sys12.Code
		left join DNSYSCONFIG sys13 on sys13.CtrlCode = 42046 and e.AuxLabel3 = sys13.Code
		left join DNSYSCONFIG sys14 on sys14.CtrlCode = 20021 and d.UnitCode = sys14.Code
union all 
--****************************** OR ******************************
select	'PT2' as BU 
		, convert(varchar(25), b.AdmDateTime, 112) + replace(b.AN,'/','') + FORMAT(a.IPDChargeDateTime, 'yyyyMMddHHmmss') + convert(varchar(3),d.SuffixSmall) as OrderID
		, b.HN as PatientID
		, convert(varchar(25), b.AdmDateTime, 112) + replace(b.AN,'/','') as AdmitID
		, b.AdmDateTime as AdmitDate
		, b.AN
		, a.IPDChargeDateTime as MakeDateTime
		, case when sk.StockComposeCategory like 'ME.%' then 'Medicine' else 'Usage' end as  ItemType
		, a.StockCode as ItemCode
		, dbo.CutSortChar(sk.LocalName) as ItemNameTH --แก้ไขวันที่ 03/03/2568 
		, dbo.CutSortChar(sk.EnglishName) as ItemNameEN --เพิ่มวันที่ 03/03/2568
		, a.HNActivityCode as ActivityCode
		, dbo.CutSortChar(sys02.LocalName) as ActivityNameTH --แก้ไขวันที่ 03/03/2568 
		, dbo.CutSortChar(sys02.EnglishName) as ActivityNameEN --เพิ่มวันที่ 03/03/2568
		, a.UnitCode as UnitCode
		, coalesce(dbo.CutSortChar(sys14.LocalName),'') as UnitNameTH --แก้ไขวันที่ 03/03/2568 
		, coalesce(dbo.CutSortChar(sys14.EnglishName),'') as UnitNameEN --เพิ่มวันที่ 03/03/2568
		, case when d.HNChargeType = 2 then d.Qty * (-1) else d.Qty end as QTY
		, d.UnitPrice as UnitPrice
		, case when d.HNChargeType = 2 then d.ChargeAmt * (-1) else d.ChargeAmt end as ChargeAmt
		, case when a.HNChargeType = 0 then 'Charge' 
		  when a.HNChargeType = 1 then 'FreeOfCharge'
		  when a.HNChargeType = 2 then 'Return' 
		  when a.HNChargeType = 6 then 'ReturnFreeOfCharge'
		  end as ChargeType
		, a.ChargeDateTime
		, a.EntryByFacilityRmsNo as EntryByFacility
		, case when a.EntryByFacilityRmsNo is not null then a.EntryByFacilityRefNo else a.OrderRef end as RefNo
		, a.VoidByUserCode as CancelByUserCode --แก้ไขวันที่ 03/03/2568 
		, dbo.sysconname(a.VoidByUserCode,10031,2) as CancelByUserNameTH --เพิ่มวันที่ 03/03/2568
		, dbo.sysconname(a.VoidByUserCode,10031,1) as CancelByUserNameEN --เพิ่มวันที่ 03/03/2568
		, a.VoidDateTime as CancelDateTime
		, a.ForDateTimeFrom as TreatmentDateTimeFrom
		, a.ForDateTimeTo as TreatmentDateTimeTo
		, a.DFDoctor
		, a.RightCode
		, dbo.CutSortChar(sys03.LocalName) as RightNameTH --แก้ไขวันที่ 03/03/2568 
		, dbo.CutSortChar(sys03.EnglishName) as RightNameEN --เพิ่มวันที่ 03/03/2568
		, d.Store as StoreCode
		, coalesce(dbo.CutSortChar(sys05.LocalName),'') as StoreNameTH --แก้ไขวันที่ 03/03/2568 
		, coalesce(dbo.CutSortChar(sys05.EnglishName),'') as StoreNameEN --เพิ่มวันที่ 03/03/2568
		, '' as DoseType
		, '' as DoseCode
		, '' as DoseQTY
		, '' as DoseUnit
		, '' as DoseFreqCode
		, '' as AuxLabel1
		, '' as AuxLabel2
		, '' as AuxLabel3
		, a.FacilityRequestMethod as EntryByFacilityMethodCode
		, dbo.CutSortChar(sys04.LocalName) as EntryByFacilityMethodNameTH --แก้ไขวันที่ 03/03/2568 
		, dbo.CutSortChar(sys04.EnglishName) as EntryByFacilityMethodNameEN --เพิ่มวันที่ 03/03/2568
		, a.CheckUp as Checkup  
		, '' as DoseMemo --เพิ่มวันที่ 03/03/2568
		, case when a.DFDoctor is not null then 1 else 0 end as FlagDF --เพิ่มวันที่ 03/03/2568
		, CAST(SUBSTRING(sys02.Com,17,3)as varchar) as ActivityCategoryCode --เพิ่มวันที่ 03/03/2568
		, dbo.sysconname(CAST(SUBSTRING(sys02.Com,17,3)as varchar),42091,2) as ActivityCategoryNameTH --เพิ่มวันที่ 03/03/2568
		, dbo.sysconname(CAST(SUBSTRING(sys02.Com,17,3)as varchar),42091,1) as ActivityCategoryNameEN --เพิ่มวันที่ 03/03/2568
from	HNIPD_CHARGE a
		left join HNIPD_MASTER b on a.AN = b.AN 
		left join HNIPD_CHARGE_MEDICINE c on a.AN = c.AN and a.IPDChargeDateTime = c.IPDChargeDateTime and a.IPDChargeSuffixTiny = c.IPDChargeSuffixTiny
		left join HNORREQ_USAGE d on a.EntryByFacilityRmsNo = d.FacilityRmsNo and a.EntryByFacilityRefNo = d.RequestNo and a.HNActivityCode = d.HNActivityCode and a.StockCode = d.StockCode
		LEFT join STOCKMASTER sk on a.StockCode = sk.StockCode 
		left join DNSYSCONFIG sys02 on sys02.CtrlCode = 42093 and a.HNActivityCode = sys02.Code
		left join DNSYSCONFIG sys03 on sys03.CtrlCode = 42086 and a.RightCode = sys03.Code
		left join DNSYSCONFIG sys04 on sys04.CtrlCode = 42161 and a.FacilityRequestMethod = sys04.Code
		left join DNSYSCONFIG sys05 on sys05.CtrlCode = 20020 and d.Store = sys05.Code
		left join DNSYSCONFIG sys14 on sys14.CtrlCode = 20021 and a.UnitCode = sys14.Code
where	a.StockCode is not null 
		and c.AN is null
union all 
--****************************** Activity ******************************
select	'PT2' as BU 
		, convert(varchar(25), b.AdmDateTime, 112) + replace(b.AN,'/','') + FORMAT(a.IPDChargeDateTime, 'yyyyMMddHHmmss') + convert(varchar(3),a.IPDChargeSuffixTiny) as OrderID
		, b.HN as PatientID
		, convert(varchar(25), b.AdmDateTime, 112) + replace(b.AN,'/','') as AdmitID
		, b.AdmDateTime as AdmitDate
		, b.AN
		, a.IPDChargeDateTime as MakeDateTime
		, case when a.HNEntryFromSystemType = 6 then 'Food' else 'ServiceCharge' end as  ItemType
		, a.HNActivityCode as ItemCode
		, dbo.CutSortChar(sys02.LocalName) as ItemNameTH --แก้ไขวันที่ 03/03/2568 
		,  dbo.CutSortChar(sys02.EnglishName) as ItemNameEN --เพิ่มวันที่ 03/03/2568 
		, a.HNActivityCode as ActivityCode
		, dbo.CutSortChar(sys02.LocalName) as ActivityNameTH --แก้ไขวันที่ 03/03/2568
		, dbo.CutSortChar(sys02.EnglishName) as ActivityNameEN --เพิ่มวันที่ 03/03/2568
		, a.UnitCode as UnitCode
		, coalesce(dbo.CutSortChar(sys14.LocalName),'') as UnitNameTH --แก้ไขวันที่ 03/03/2568
		, coalesce(dbo.CutSortChar(sys14.EnglishName),'') as UnitNameEN --เพิ่มวันที่ 03/03/2568
		, case when a.HNChargeType = 2 then a.Qty * (-1) else a.Qty end as QTY
		, a.ChargeAmt as UnitPrice
		, case when a.HNChargeType = 2 then a.ChargeAmt * (-1) else a.ChargeAmt end as ChargeAmt
		, case when a.HNChargeType = 0 then 'Charge' 
		  when a.HNChargeType = 1 then 'FreeOfCharge'
		  when a.HNChargeType = 2 then 'Return' 
		  when a.HNChargeType = 6 then 'ReturnFreeOfCharge'
		  end as ChargeType
		, a.ChargeDateTime
		, a.EntryByFacilityRmsNo as EntryByFacility
		, case when a.EntryByFacilityRmsNo is not null then a.EntryByFacilityRefNo else a.OrderRef end as RefNo
		, a.VoidByUserCode as CancelByUserCode --แก้ไขวันที่ 03/03/2568 
		, dbo.sysconname(a.VoidByUserCode,10031,2) as CancelByUserNameTH --เพิ่มวันที่ 03/03/2568
		, dbo.sysconname(a.VoidByUserCode,10031,1) as CancelByUserNameEN --เพิ่มวันที่ 03/03/2568
		, a.VoidDateTime as CancelDateTime
		, a.ForDateTimeFrom as TreatmentDateTimeFrom
		, a.ForDateTimeTo as TreatmentDateTimeTo
		, a.DFDoctor
		, a.RightCode
		, dbo.CutSortChar(sys03.LocalName) as RightNameTH --แก้ไขวันที่ 03/03/2568
		, dbo.CutSortChar(sys03.EnglishName) as RightNameEN --เพิ่มวันที่ 03/03/2568
		, '' as StoreCode
		, '' as StoreNameTH --แก้ไขวันที่ 03/03/2568
		, '' as StoreNameEN --เพิ่มวันที่ 03/03/2568
		, '' as DoseType
		, '' as DoseCode
		, '' as DoseQTY
		, '' as DoseUnit
		, '' as DoseFreqCode
		, '' as AuxLabel1
		, '' as AuxLabel2
		, '' as AuxLabel3
		, a.FacilityRequestMethod as EntryByFacilityMethodCode
		, dbo.CutSortChar(sys04.LocalName) as EntryByFacilityMethodNameTH --แก้ไขวันที่ 03/03/2568
		, dbo.CutSortChar(sys04.EnglishName) as EntryByFacilityMethodNameEN --เพิ่มวันที่ 03/03/2568
		, a.CheckUp as Checkup  
		, '' as DoseMemo --เพิ่มวันที่ 03/03/2568
		, case when a.DFDoctor is not null then 1 else 0 end as FlagDF --เพิ่มวันที่ 03/03/2568
		, CAST(SUBSTRING(sys02.Com,17,3)as varchar) as ActivityCategoryCode --เพิ่มวันที่ 03/03/2568
		, dbo.sysconname(CAST(SUBSTRING(sys02.Com,17,3)as varchar),42091,2) as ActivityCategoryNameTH --เพิ่มวันที่ 03/03/2568
		, dbo.sysconname(CAST(SUBSTRING(sys02.Com,17,3)as varchar),42091,1) as ActivityCategoryNameEN --เพิ่มวันที่ 03/03/2568
from	HNIPD_CHARGE a
		left join HNIPD_MASTER b on a.AN = b.AN 
		left join DNSYSCONFIG sys02 on sys02.CtrlCode = 42093 and a.HNActivityCode = sys02.Code
		left join DNSYSCONFIG sys03 on sys03.CtrlCode = 42086 and a.RightCode = sys03.Code
		left join DNSYSCONFIG sys04 on sys04.CtrlCode = 42161 and a.FacilityRequestMethod = sys04.Code
		left join DNSYSCONFIG sys14 on sys14.CtrlCode = 20021 and a.UnitCode = sys14.Code
where	a.HNEntryFromSystemType in (6,7)
