select
	'PT2' as BU
	, sh.StockCode
	, dbo.CutSortChar(sm.LocalName) as StockNameTH
	, dbo.CutSortChar(sm.EnglishName) as StockNameEN
	, sh.TreatmentCode
	, dbo.sysconname(sh.TreatmentCode,42075,2) as TreatmentNameTH
	, dbo.sysconname(sh.TreatmentCode,42075,1) as TreatmentNameEN
	, sh.GroupOfChargeCode
	, dbo.sysconname(sh.GroupOfChargeCode,42454,2) as GroupOfChargeNameTH
	, dbo.sysconname(sh.GroupOfChargeCode,42454,1) as GroupOfChargeNameEN
	, sh.PrePregnantWarningType
	, sh.PoisonClass
	, dbo.sysconname(sh.PoisonClass,42065,2) as PoisonClassNameTH
	, dbo.sysconname(sh.PoisonClass,42065,1) as PoisonClassNameEN
	, sh.MaxDosePerDayQty
	, sh.MaxDosePerDayUnitCode
	, dbo.sysconname(sh.MaxDosePerDayUnitCode,20021,2) as MaxDosePerDayUnitNameTH
	, dbo.sysconname(sh.MaxDosePerDayUnitCode,20021,1) as MaxDosePerDayUnitNameEN
	, sh.NoDayCanContinueTake
	, sh.WarningPregnantCode
	, dbo.sysconname(sh.WarningPregnantCode,42412,2) as WarningPregnantNameTH
	, dbo.sysconname(sh.WarningPregnantCode,42412,1) as WarningPregnantNameEN
	, sh.AvailableGender
	, case when sh.AvailableGender = 0 then 'None'
		   when sh.AvailableGender = 1 then 'หญิง'
		   when sh.AvailableGender = 2 then 'ชาย'
		   when sh.AvailableGender = 3 then 'ไม่ระบุเพศ'
	 end as AvailableGenderName
	, sh.DrugCanZeroPriceType
	, case when charindex('|', AuxLabel)>0 then substring(AuxLabel, 0, charindex('|', AuxLabel)) else AuxLabel end as AuxLabel1
	, dbo.sysconname(case when charindex('|', AuxLabel)>0 then substring(AuxLabel, 0, charindex('|', AuxLabel)) else AuxLabel end,42046,2) as AuxLabel1NameTH
	, dbo.sysconname(case when charindex('|', AuxLabel)>0 then substring(AuxLabel, 0, charindex('|', AuxLabel)) else AuxLabel end,42046,1) as AuxLabel1NameEN
	, case when charindex('|', AuxLabel)>0 then 
			case when charindex('|', (substring(AuxLabel, charindex('|', AuxLabel)+1, LEN(AuxLabel))))>0
			then substring((substring(AuxLabel, charindex('|', AuxLabel)+1, LEN(AuxLabel))), 0, charindex('|', (substring(AuxLabel, charindex('|', AuxLabel)+1, LEN(AuxLabel)))))
			else substring(AuxLabel, charindex('|', AuxLabel)+1, LEN(AuxLabel)) end
		  else '' end as AuxLabel2
	, dbo.sysconname(case when charindex('|', AuxLabel)>0 then 
			case when charindex('|', (substring(AuxLabel, charindex('|', AuxLabel)+1, LEN(AuxLabel))))>0
			then substring((substring(AuxLabel, charindex('|', AuxLabel)+1, LEN(AuxLabel))), 0, charindex('|', (substring(AuxLabel, charindex('|', AuxLabel)+1, LEN(AuxLabel)))))
			else substring(AuxLabel, charindex('|', AuxLabel)+1, LEN(AuxLabel)) end
		  else '' end,42046,2) as AuxLabel2NameTH
	, dbo.sysconname(case when charindex('|', AuxLabel)>0 then 
			case when charindex('|', (substring(AuxLabel, charindex('|', AuxLabel)+1, LEN(AuxLabel))))>0
			then substring((substring(AuxLabel, charindex('|', AuxLabel)+1, LEN(AuxLabel))), 0, charindex('|', (substring(AuxLabel, charindex('|', AuxLabel)+1, LEN(AuxLabel)))))
			else substring(AuxLabel, charindex('|', AuxLabel)+1, LEN(AuxLabel)) end
		  else '' end,42046,1) as AuxLabel2NameEN
	, case when charindex('|', substring(AuxLabel, charindex('|', AuxLabel)+1, LEN(AuxLabel)))>0 
		  then substring(substring(AuxLabel, charindex('|', AuxLabel)+1, LEN(AuxLabel))
		                , charindex('|', (substring(AuxLabel, charindex('|', AuxLabel)+1, LEN(AuxLabel))))+1
						, LEN(substring(AuxLabel, charindex('|', AuxLabel)+1, LEN(AuxLabel)))) 
		  else '' end as AuxLabel3
	, dbo.sysconname(case when charindex('|', substring(AuxLabel, charindex('|', AuxLabel)+1, LEN(AuxLabel)))>0 
		  then substring(substring(AuxLabel, charindex('|', AuxLabel)+1, LEN(AuxLabel))
		                , charindex('|', (substring(AuxLabel, charindex('|', AuxLabel)+1, LEN(AuxLabel))))+1
						, LEN(substring(AuxLabel, charindex('|', AuxLabel)+1, LEN(AuxLabel)))) 
		  else '' end,42046,2) as AuxLabel3NameTH
	, dbo.sysconname(case when charindex('|', substring(AuxLabel, charindex('|', AuxLabel)+1, LEN(AuxLabel)))>0 
		  then substring(substring(AuxLabel, charindex('|', AuxLabel)+1, LEN(AuxLabel))
		                , charindex('|', (substring(AuxLabel, charindex('|', AuxLabel)+1, LEN(AuxLabel))))+1
						, LEN(substring(AuxLabel, charindex('|', AuxLabel)+1, LEN(AuxLabel)))) 
		  else '' end,42046,1) as AuxLabel3NameEN
	, sh.AuxEnglishMemo
	, sh.AuxLocalMemo
		, case when charindex('|', DoseType)>0 then substring(DoseType, 0, charindex('|', DoseType)) else DoseType end as DoseType1
	, dbo.sysconname(case when charindex('|', DoseType)>0 then substring(DoseType, 0, charindex('|', DoseType)) else DoseType end,42042,2) as DoseType1NameTH
	, dbo.sysconname(case when charindex('|', DoseType)>0 then substring(DoseType, 0, charindex('|', DoseType)) else DoseType end,42042,1) as DoseType1NameEN
	, case when charindex('|', DoseType)>0 then 
			case when charindex('|', (substring(DoseType, charindex('|', DoseType)+1, LEN(DoseType))))>0
			then substring((substring(DoseType, charindex('|', DoseType)+1, LEN(DoseType))), 0, charindex('|', (substring(DoseType, charindex('|', DoseType)+1, LEN(DoseType)))))
			else substring(DoseType, charindex('|', DoseType)+1, LEN(DoseType)) end
		  else '' end as DoseType2
	, dbo.sysconname(case when charindex('|', DoseType)>0 then 
			case when charindex('|', (substring(DoseType, charindex('|', DoseType)+1, LEN(DoseType))))>0
			then substring((substring(DoseType, charindex('|', DoseType)+1, LEN(DoseType))), 0, charindex('|', (substring(DoseType, charindex('|', DoseType)+1, LEN(DoseType)))))
			else substring(DoseType, charindex('|', DoseType)+1, LEN(DoseType)) end
		  else '' end,42042,2) as DoseType2NameTH
	, dbo.sysconname(case when charindex('|', DoseType)>0 then 
			case when charindex('|', (substring(DoseType, charindex('|', DoseType)+1, LEN(DoseType))))>0
			then substring((substring(DoseType, charindex('|', DoseType)+1, LEN(DoseType))), 0, charindex('|', (substring(DoseType, charindex('|', DoseType)+1, LEN(DoseType)))))
			else substring(DoseType, charindex('|', DoseType)+1, LEN(DoseType)) end
		  else '' end,42042,1) as DoseType2NameEN
	, case when charindex('|', substring(DoseType, charindex('|', DoseType)+1, LEN(DoseType)))>0 
		  then substring(substring(DoseType, charindex('|', DoseType)+1, LEN(DoseType))
		                , charindex('|', (substring(DoseType, charindex('|', DoseType)+1, LEN(DoseType))))+1
						, LEN(substring(DoseType, charindex('|', DoseType)+1, LEN(DoseType)))) 
		  else '' end as DoseType3
	, dbo.sysconname(case when charindex('|', substring(DoseType, charindex('|', DoseType)+1, LEN(DoseType)))>0 
		  then substring(substring(DoseType, charindex('|', DoseType)+1, LEN(DoseType))
		                , charindex('|', (substring(DoseType, charindex('|', DoseType)+1, LEN(DoseType))))+1
						, LEN(substring(DoseType, charindex('|', DoseType)+1, LEN(DoseType)))) 
		  else '' end,42042,2) as DoseType3NameTH
	, dbo.sysconname(case when charindex('|', substring(DoseType, charindex('|', DoseType)+1, LEN(DoseType)))>0 
		  then substring(substring(DoseType, charindex('|', DoseType)+1, LEN(DoseType))
		                , charindex('|', (substring(DoseType, charindex('|', DoseType)+1, LEN(DoseType))))+1
						, LEN(substring(DoseType, charindex('|', DoseType)+1, LEN(DoseType)))) 
		  else '' end,42042,1) as DoseType3NameEN
		, case when charindex('|', DoseUnitCode)>0 then substring(DoseUnitCode, 0, charindex('|', DoseUnitCode)) else DoseUnitCode end as DoseUnitCode1
	, dbo.sysconname(case when charindex('|', DoseUnitCode)>0 then substring(DoseUnitCode, 0, charindex('|', DoseUnitCode)) else DoseUnitCode end,42045,2) as DoseUnitCode1NameTH
	, dbo.sysconname(case when charindex('|', DoseUnitCode)>0 then substring(DoseUnitCode, 0, charindex('|', DoseUnitCode)) else DoseUnitCode end,42045,1) as DoseUnitCode1NameEN
	, case when charindex('|', DoseUnitCode)>0 then 
			case when charindex('|', (substring(DoseUnitCode, charindex('|', DoseUnitCode)+1, LEN(DoseUnitCode))))>0
			then substring((substring(DoseUnitCode, charindex('|', DoseUnitCode)+1, LEN(DoseUnitCode))), 0, charindex('|', (substring(DoseUnitCode, charindex('|', DoseUnitCode)+1, LEN(DoseUnitCode)))))
			else substring(DoseUnitCode, charindex('|', DoseUnitCode)+1, LEN(DoseUnitCode)) end
		  else '' end as DoseUnitCode2
	, dbo.sysconname(case when charindex('|', DoseUnitCode)>0 then 
			case when charindex('|', (substring(DoseUnitCode, charindex('|', DoseUnitCode)+1, LEN(DoseUnitCode))))>0
			then substring((substring(DoseUnitCode, charindex('|', DoseUnitCode)+1, LEN(DoseUnitCode))), 0, charindex('|', (substring(DoseUnitCode, charindex('|', DoseUnitCode)+1, LEN(DoseUnitCode)))))
			else substring(DoseUnitCode, charindex('|', DoseUnitCode)+1, LEN(DoseUnitCode)) end
		  else '' end,42045,2) as DoseUnitCode2NameTH
	, dbo.sysconname(case when charindex('|', DoseUnitCode)>0 then 
			case when charindex('|', (substring(DoseUnitCode, charindex('|', DoseUnitCode)+1, LEN(DoseUnitCode))))>0
			then substring((substring(DoseUnitCode, charindex('|', DoseUnitCode)+1, LEN(DoseUnitCode))), 0, charindex('|', (substring(DoseUnitCode, charindex('|', DoseUnitCode)+1, LEN(DoseUnitCode)))))
			else substring(DoseUnitCode, charindex('|', DoseUnitCode)+1, LEN(DoseUnitCode)) end
		  else '' end,42045,1) as DoseUnitCode2NameEN
	, case when charindex('|', substring(DoseUnitCode, charindex('|', DoseUnitCode)+1, LEN(DoseUnitCode)))>0 
		  then substring(substring(DoseUnitCode, charindex('|', DoseUnitCode)+1, LEN(DoseUnitCode))
		                , charindex('|', (substring(DoseUnitCode, charindex('|', DoseUnitCode)+1, LEN(DoseUnitCode))))+1
						, LEN(substring(DoseUnitCode, charindex('|', DoseUnitCode)+1, LEN(DoseUnitCode)))) 
		  else '' end as DoseUnitCode3
	, dbo.sysconname(case when charindex('|', substring(DoseUnitCode, charindex('|', DoseUnitCode)+1, LEN(DoseUnitCode)))>0 
		  then substring(substring(DoseUnitCode, charindex('|', DoseUnitCode)+1, LEN(DoseUnitCode))
		                , charindex('|', (substring(DoseUnitCode, charindex('|', DoseUnitCode)+1, LEN(DoseUnitCode))))+1
						, LEN(substring(DoseUnitCode, charindex('|', DoseUnitCode)+1, LEN(DoseUnitCode)))) 
		  else '' end,42045,2) as DoseUnitCode3NameTH
	, dbo.sysconname(case when charindex('|', substring(DoseUnitCode, charindex('|', DoseUnitCode)+1, LEN(DoseUnitCode)))>0 
		  then substring(substring(DoseUnitCode, charindex('|', DoseUnitCode)+1, LEN(DoseUnitCode))
		                , charindex('|', (substring(DoseUnitCode, charindex('|', DoseUnitCode)+1, LEN(DoseUnitCode))))+1
						, LEN(substring(DoseUnitCode, charindex('|', DoseUnitCode)+1, LEN(DoseUnitCode)))) 
		  else '' end,42045,1) as DoseUnitCode3NameEN
	, sh.PharmacoIndex
	, dbo.sysconname(sh.PharmacoIndex,42062,2) as PharmacoIndexNameTH
	, dbo.sysconname(sh.PharmacoIndex,42062,1) as PharmacoIndexNameEN
	, sh.PharmacoIndexAddition1
	, dbo.sysconname(sh.PharmacoIndexAddition1,42062,2) as PharmacoIndexAddition1NameTH
	, dbo.sysconname(sh.PharmacoIndexAddition1,42062,1) as PharmacoIndexAddition1NameEN
	, sh.PharmacoIndexAddition2
	, dbo.sysconname(sh.PharmacoIndexAddition2,42062,2) as PharmacoIndexAddition2NameTH
	, dbo.sysconname(sh.PharmacoIndexAddition2,42062,1) as PharmacoIndexAddition2NameEN
	, sh.PharmacoIndexAddition3
	, dbo.sysconname(sh.PharmacoIndexAddition3,42062,2) as PharmacoIndexAddition3NameTH
	, dbo.sysconname(sh.PharmacoIndexAddition3,42062,1) as PharmacoIndexAddition3NameEN 
	, sh.DoseUnitCodeForWeight
	, dbo.sysconname(sh.DoseUnitCodeForWeight,42045,2) as DoseUnitCodeForWeightNameTH
	, dbo.sysconname(sh.DoseUnitCodeForWeight,42045,1) as DoseUnitCodeForWeightNameEN
	, sh.WeightUnitName
	, sh.WeightPerDoseUnit
	, sh.NoDayAgeFrom
	, sh.NoDayAgeTo
	, sh.DoseCode
	, dbo.sysconname(sh.DoseCode,42043,2) as DoseNameTH
	, dbo.sysconname(sh.DoseCode,42043,1) as DoseNameEN
	, sh.DoseFreqCode
	, dbo.sysconname(sh.DoseFreqCode,42041,2) as DoseFreqNameTH
	, dbo.sysconname(sh.DoseFreqCode,42041,1) as DoseFreqNameEN
	, sh.OnlyDoctorGroup
	, dbo.sysconname(sh.OnlyDoctorGroup,42069,2) as OnlyDoctorGroupNameTH
	, dbo.sysconname(sh.OnlyDoctorGroup,42069,1) as OnlyDoctorGroupNameEN
	, sh.DoseQtyCode
	, dbo.sysconname(sh.DoseQtyCode,42044,2) as DoseQtyNameTH
	, dbo.sysconname(sh.DoseQtyCode,42044,1) as DoseQtyNameEN
	, sh.NeverRightGroupCodeList
	, dbo.sysconname(sh.NeverRightGroupCodeList,42087,2) as NeverRightGroupCodeListNameTH
	, dbo.sysconname(sh.NeverRightGroupCodeList,42087,1) as NeverRightGroupCodeListNameEN
	, sh.MedicineStructureCode
	, dbo.sysconname(sh.MedicineStructureCode,43498,2) as MedicineStructureNameTH
	, dbo.sysconname(sh.MedicineStructureCode,43498,1) as MedicineStructureNameEN
	, sh.AlwaysGoWithStockCodeList
	, dbo.Stockname(sh.AlwaysGoWithStockCodeList,2) as AlwaysGoWithStockCodeListNameTH
	, dbo.Stockname(sh.AlwaysGoWithStockCodeList,1) as AlwaysGoWithStockCodeListNameEN
	, sh.AlwaysGoWithStockQtyType
	, sh.Antibiotic
	, sh.ValidForNoDayAgeOnly
	, sh.NeverContinueDrug
	, sh.DoseCodeNeverChange
	, sh.AnyAgeSameDose
	, sh.DoseTypeNeverChange
		from STOCKMASTER_HOSPITAL sh
		inner join STOCKMASTER sm on sh.StockCode=sm.StockCode