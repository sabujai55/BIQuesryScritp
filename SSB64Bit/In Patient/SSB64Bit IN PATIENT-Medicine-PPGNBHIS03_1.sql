use SSBLIVE
go

select	'PT2' as BU 
		, convert(varchar(25), b.AdmDateTime, 112) + replace(a.AN,'/','') + FORMAT(a.IPDChargeDateTime, 'yyyyMMddHHmmss') + convert(varchar(3),a.ChargeMedicineSuffixSmall) as OrderID
		, b.HN as PatientID
		, convert(varchar(25), b.AdmDateTime, 112) + replace(b.AN,'/','') as AdmitID
		, b.AdmDateTime as AdmitDateTime
		, b.AN
		, a.SuffixDateTime as MakeDateTime
		, a.DrugOrderNo
		, a.Store as StoreCode
		, dbo.sysconname(a.Store,20020,2) as StoreNameTH
		, dbo.sysconname(a.Store,20020,1) as StoreNameEN
		, a.StockCode as ItemCode
		, dbo.Stockname(a.StockCode,2) as ItemNameTH
		, dbo.Stockname(a.StockCode,1) as ItemNameEN
		, case 
		  when a.HNChargeType in (1,6) then a.Qty
		  when a.HNChargeType = 2 then a.Qty * (-1)
		  else a.Qty end as Qty
		, a.UnitCode
		, dbo.sysconname(a.UnitCode,20021,2) as UnitNameTH
		, dbo.sysconname(a.UnitCode,20021,1) as UnitNameEN
		, a.UnitPrice
		, a.ChargeAmt
		, c.HNActivityCode
		, dbo.sysconname(c.HNActivityCode,42093,2) as HNActivityNameTH
		, dbo.sysconname(c.HNActivityCode,42093,1) as HNActivityNameEN
		, a.RightCode
		, dbo.sysconname(a.RightCode,42086,2) as RightNameTH
		, dbo.sysconname(a.RightCode,42086,1) as RightNameEN
		, a.DispendDrugReasonCode
		, dbo.sysconname(a.DispendDrugReasonCode,42429,2) as DispendDrugReasonNameTH
		, dbo.sysconname(a.DispendDrugReasonCode,42429,1) as DispendDrugReasonNameEN
		, a.DoseType as DoseTypeCode
		, dbo.sysconname(a.DoseType,42042,2) as DoseTypeNameTH
		, dbo.sysconname(a.DoseType,42042,1) as DoseTypeNameEN
		, a.DoseCode
		, dbo.sysconname(a.DoseCode,42043,2) as DoseNameTH
		, dbo.sysconname(a.DoseCode,42043,1) as DoseNameEN
		, cast(SUBSTRING(sys1.Com,1,1) as int) as NumberDosePerDay
		, cast(SUBSTRING(sys1.Com,122,1) as int) as BeforeAfterMealType
		, case 
		  when cast(SUBSTRING(sys1.Com,122,1) as int) = 0 then 'None'
		  when cast(SUBSTRING(sys1.Com,122,1) as int) = 1 then 'Before'
		  when cast(SUBSTRING(sys1.Com,122,1) as int) = 2 then 'After'
		  when cast(SUBSTRING(sys1.Com,122,1) as int) = 3 then 'With'
		  end as BeforeAfterMealTypeName
		, a.DoseQtyCode
		, dbo.sysconname(a.DoseQtyCode,42044,2) as DoseQtyNameTH
		, dbo.sysconname(a.DoseQtyCode,42044,1) as DoseQtyNameEN
		, a.IPDDrugOrderQtyType as IPDDrugOrderQtyTypeCode
		, case 
		  when a.IPDDrugOrderQtyType = 0 then 'None'
		  when a.IPDDrugOrderQtyType = 1 then 'Return'
		  when a.IPDDrugOrderQtyType = 2 then 'Stat'
		  end as IPDDrugOrderQtyTypeName
		, a.DoseUnitCode
		, dbo.sysconname(a.DoseUnitCode,42045,2) as DoseUnitNameTH
		, dbo.sysconname(a.DoseUnitCode,42045,1) as DoseUnitNameEN
		, a.NoDayDose as NumberDayDose
		, a.DoseFreqCode
		, dbo.sysconname(a.DoseFreqCode,42041,2) as DoseFreqNameTH
		, dbo.sysconname(a.DoseFreqCode,42041,1) as DoseFreqNameEN
		, d.AuxLabel1 as AuxLabel1Code
		, dbo.sysconname(d.AuxLabel1,42046,2) as AuxLabel1NameTH
		, dbo.sysconname(d.AuxLabel1,42046,1) as AuxLabel1NameEN
		, d.AuxLabel2 as AuxLabel2Code
		, dbo.sysconname(d.AuxLabel2,42046,2) as AuxLabel2NameTH
		, dbo.sysconname(d.AuxLabel2,42046,1) as AuxLabel2NameEN
		, d.AuxLabel3 as AuxLabel3Code
		, dbo.sysconname(d.AuxLabel3,42046,2) as AuxLabel3NameTH
		, dbo.sysconname(d.AuxLabel3,42046,1) as AuxLabel3NameEN
		, replace(replace(a.DoseMemo, CHAR(10),' '), CHAR(13),' ') as DoseMemo
		, d.ReturnIpdDrugReason as ReturnIpdDrugReasonCode
		, dbo.sysconname(d.ReturnIpdDrugReason,42457,2) as ReturnIpdDrugReasonnameTH
		, dbo.sysconname(d.ReturnIpdDrugReason,42457,1) as ReturnIpdDrugReasonNameEN
		, d.NetPrice
		, d.OutsideHospitalDrug
		, a.MedicineOrderType as MedicineOrderTypeCode
		, case
		  when a.MedicineOrderType = 0 then 'None'
		  when a.MedicineOrderType = 1 then 'Continue'
		  when a.MedicineOrderType = 2 then 'OneDay'
		  when a.MedicineOrderType = 4 then 'TakeHome'
		  when a.MedicineOrderType = 5 then 'ToBeTakeHome'
		  when a.MedicineOrderType = 6 then 'PRN'
		  end as MedicineOrderTypeName
		, a.HNDrugErrorCodeType as HNDrugErrorCodeTypeCode
		, case
		  when a.HNDrugErrorCodeType = 0 then 'None'
		  when a.HNDrugErrorCodeType = 1 then 'Duplicate Stock'
		  when a.HNDrugErrorCodeType = 2 then 'Duplicate Pharmaco'
		  when a.HNDrugErrorCodeType = 3 then 'Duplicate Stock Posted'
		  when a.HNDrugErrorCodeType = 4 then 'Duplicate Pharmaco Posted'
		  when a.HNDrugErrorCodeType = 5 then 'Gender'
		  when a.HNDrugErrorCodeType = 6 then 'Over Dose'
		  when a.HNDrugErrorCodeType = 7 then 'Over Limit Continue_Day'
		  when a.HNDrugErrorCodeType = 8 then 'Against Chronic'
		  when a.HNDrugErrorCodeType = 9 then 'Drug Interaction'
		  when a.HNDrugErrorCodeType = 10 then 'Patient Allergy'
		  when a.HNDrugErrorCodeType = 11 then 'Not Normal Dose'
		  when a.HNDrugErrorCodeType = 12 then 'Duplicate Ingredient'
		  when a.HNDrugErrorCodeType = 13 then 'Duplicate Ingredient Posted'
		  end as HNDrugErrorCodeTypeName
		, a.HNAllergicErrorCodeType as HNAllergicErrorCodeTypeCode
		, case
		  when a.HNAllergicErrorCodeType = 0 then 'None'
		  when a.HNAllergicErrorCodeType = 1 then 'Duplicate Stock'
		  when a.HNAllergicErrorCodeType = 2 then 'Duplicate Pharmaco'
		  when a.HNAllergicErrorCodeType = 3 then 'Duplicate Stock Posted'
		  when a.HNAllergicErrorCodeType = 4 then 'Duplicate Pharmaco Posted'
		  when a.HNAllergicErrorCodeType = 5 then 'Gender'
		  when a.HNAllergicErrorCodeType = 6 then 'Over Dose'
		  when a.HNAllergicErrorCodeType = 7 then 'Over Limit Continue_Day'
		  when a.HNAllergicErrorCodeType = 8 then 'Against Chronic'
		  when a.HNAllergicErrorCodeType = 9 then 'Drug Interaction'
		  when a.HNAllergicErrorCodeType = 10 then 'Patient Allergy'
		  when a.HNAllergicErrorCodeType = 11 then 'Not Normal Dose'
		  when a.HNAllergicErrorCodeType = 12 then 'Duplicate Ingredient'
		  when a.HNAllergicErrorCodeType = 13 then 'Duplicate Ingredient Posted'
		  end as HNAllergicErrorCodeTypeName
		, a.StartDoseDateTime
		, a.StopDateTime
		, null as MarDateTime1
		, null as MarDateTime2
		, null as MarDateTime3
		, null as MarDateTime4
		, null as MarDateTime5
		, null as MarDateTime6
from	HNIPD_DRUG_HISTORY a
		inner join HNIPD_MASTER b on a.AN = b.AN
		inner join HNIPD_CHARGE_MEDICINE c on a.AN = c.AN and a.IPDChargeDateTime = c.IPDChargeDateTime and a.ChargeMedicineSuffixSmall = c.ChargeMedicineSuffixSmall
		inner join HNIPDDRUG_ORDER_ITEM d on a.DrugOrderNo = d.DrugOrderNo and a.ChargeMedicineSuffixSmall = d.SuffixSmall
		left join DNSYSCONFIG sys1 on sys1.CtrlCode = 42043 and a.DoseCode = sys1.Code
where	1=1
		and a.AN in (select AN from HNIPD_MASTER where AdmDateTime between '2026-01-01 00:00:00' and '2026-01-01 23:59:59')
order by a.AN, a.SuffixDateTime, a. ChargeMedicineSuffixSmall