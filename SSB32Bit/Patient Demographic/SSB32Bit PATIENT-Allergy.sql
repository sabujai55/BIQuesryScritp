SELECT	top 10
		'PTP' as BU
		, A.HN as PatientID
		, HN
		, ROW_NUMBER() over(partition by A.HN order by MAKEDATETIME asc) as Suffix
		, PHARMACOINDEX
		, dbo.sysconname(PHARMACOINDEX, 20025, 3) AS PharmacoIndexName
		, '' AS StockIngredientCode
		, '' AS StockIngredientName
		, '' AS MedicineStructureCode
		, '' AS MedicineStructureName
		, '' AS WithGenericName
		, MEDICINE
		, dbo.Stockname(MEDICINE, 3) AS StockName
		, ADVERSEREACTIONS1
		, dbo.sysconname(ADVERSEREACTIONS1, 20028, 3) AS AdverseReactions1Name
		, ADVERSEREACTIONS2
		, dbo.sysconname(ADVERSEREACTIONS2, 20028, 3) AS AdverseReactions2Name
		, ADVERSEREACTIONS3
		, dbo.sysconname(ADVERSEREACTIONS3, 20028, 3) AS AdverseReactions3Name
		, ADVERSEREACTIONS4
		, dbo.sysconname(ADVERSEREACTIONS4, 20028, 3) AS AdverseReactions4Name
		, ADVERSEREACTIONS5
		, dbo.sysconname(ADVERSEREACTIONS5, 20028, 3) AS AdverseReactions5Name
		, ADVERSEREACTIONS6
		, dbo.sysconname(ADVERSEREACTIONS6, 20028, 3) AS AdverseReactions6Name
		, '' as Remark
		, MAKEDATETIME
		, 'Active' as [Status]
		, '' AS InactiveDateTime
		, '' as InactiveByUserCode --แก้ไขวันที่ 24/02/2568
		, '' as InactiveByUserNameTH --เพิ่มวันที่ 24/02/2568
		, '' as InactiveByUserNameEN --เพิ่มวันที่ 24/02/2568
FROM         dbo.PATIENT_ALLERGIC AS A
