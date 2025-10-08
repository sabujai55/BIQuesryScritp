use SSBLIVE
go

select	top 10
		'PT2' as BU 
		, a.HN as PatientID
		, a.HN 
		, a.SuffixSmall as Suffix
		, coalesce(a.PharmacoIndex, '') as PharmacoIndex
		, coalesce(dbo.CutSortChar(sys01.LocalName), dbo.CutSortChar(sys01.EnglishName),'') as PharmacoIndexName
		, coalesce(a.StockIngredientCode,'') as StockIngredientCode
		, coalesce(dbo.CutSortChar(sys02.LocalName), dbo.CutSortChar(sys02.EnglishName),'') as StockIngredientName
		, coalesce(a.MedicineStructureCode,'') as MedicineStructureCode
		, coalesce(dbo.CutSortChar(sys03.LocalName), dbo.CutSortChar(sys03.EnglishName),'') as MedicineStructureName
		, coalesce(a.WithGenericName, '') as WithGenericName
		, coalesce(a.StockCode, '') as StockCode
		, coalesce(dbo.CutSortChar(sk.LocalName), dbo.CutSortChar(sk.EnglishName),'') as StockName
		, coalesce(a.AdverseReactions1, '') as AdverseReactions1
		, coalesce(dbo.CutSortChar(ad1.LocalName), dbo.CutSortChar(ad1.EnglishName),'') as AdverseReactionsName1
		, coalesce(a.AdverseReactions2, '') as AdverseReactions2
		, coalesce(dbo.CutSortChar(ad2.LocalName), dbo.CutSortChar(ad2.EnglishName),'') as AdverseReactionsName2
		, coalesce(a.AdverseReactions3, '') as AdverseReactions3
		, coalesce(dbo.CutSortChar(ad3.LocalName), dbo.CutSortChar(ad3.EnglishName),'') as AdverseReactionsName3
		, coalesce(a.AdverseReactions4, '') as AdverseReactions4
		, coalesce(dbo.CutSortChar(ad4.LocalName), dbo.CutSortChar(ad4.EnglishName),'') as AdverseReactionsName4
		, coalesce(a.AdverseReactions5, '') as AdverseReactions5
		, coalesce(dbo.CutSortChar(ad5.LocalName), dbo.CutSortChar(ad5.EnglishName),'') as AdverseReactionsName5
		, coalesce(a.AdverseReactions6, '') as AdverseReactions6
		, coalesce(dbo.CutSortChar(ad6.LocalName), dbo.CutSortChar(ad6.EnglishName),'') as AdverseReactionsName6
		, coalesce(a.RemarksMemo,'') as Remark
		, a.MakeDateTime
		, case when a.InactiveDate is not null then 'Inactive' else 'Active' end as [Status]
		, coalesce(a.InactiveDate,'') as InactiveDateTime
		, a.InactiveEntryByUserCode --แก้ไขวันที่ 24/02/2568
		, dbo.CutSortChar(sys04.LocalName) as InactiveByUserNameTH --เพิ่มวันที่ 24/02/2568
		, dbo.CutSortChar(sys04.EnglishName) as InactiveByUserNameEN --เพิ่มวันที่ 24/02/2568
from	HNPAT_ALLERGIC a
		left join DNSYSCONFIG sys01 on sys01.CtrlCode = 42062 and a.PharmacoIndex = sys01.Code
		left join DNSYSCONFIG sys02 on sys02.CtrlCode = 20159 and a.StockIngredientCode = sys02.Code
		left join DNSYSCONFIG sys03 on sys03.CtrlCode = 43498 and a.MedicineStructureCode = sys03.Code
		left join DNSYSCONFIG sys04 on sys04.CtrlCode = 10031 and a.InactiveEntryByUserCode = sys04.Code
		left join DNSYSCONFIG ad1 on ad1.CtrlCode = 42076 and a.AdverseReactions1 = ad1.Code
		left join DNSYSCONFIG ad2 on ad2.CtrlCode = 42076 and a.AdverseReactions2 = ad2.Code
		left join DNSYSCONFIG ad3 on ad3.CtrlCode = 42076 and a.AdverseReactions3 = ad3.Code
		left join DNSYSCONFIG ad4 on ad4.CtrlCode = 42076 and a.AdverseReactions4 = ad4.Code
		left join DNSYSCONFIG ad5 on ad5.CtrlCode = 42076 and a.AdverseReactions5 = ad5.Code
		left join DNSYSCONFIG ad6 on ad6.CtrlCode = 42076 and a.AdverseReactions6 = ad6.Code
		left join STOCKMASTER sk on a.StockCode = sk.StockCode
