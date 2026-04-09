select
		 'PTS' as BU
		, a.Code as TreatmentCode
		, coalesce(dbo.CutSortChar(a.LocalName),'') as TreatmentNameTH
		, coalesce(dbo.CutSortChar(a.EnglishName),'') as TreatmentNameEN
		, b.TreatmentCategory as TreatmentCategoryCode --modify 2026-03-17
		, coalesce(dbo.sysconname(b.TreatmentCategory,42072,2),'') as TreatmentCategoryNameTH --modify 2026-03-17
		, coalesce(dbo.sysconname(b.TreatmentCategory,42072,1),'') as TreatmentCategoryNameEN --modify 2026-03-17
		, b.HNActivityCode as HNActivityCode --modify 2026-03-17
		, coalesce(dbo.sysconname(b.HNActivityCode,42093,2),'') as HNActivityNameTH --modify 2026-03-17
		, coalesce(dbo.sysconname(b.HNActivityCode,42093,1),'') as HNActivityNameEN --modify 2026-03-17
		, b.UnitOfQtyOfWork as UnitOfQtyOfWork --modify 2026-03-17
		, b.DefaultPrice as DefaultPrice --modify 2026-03-17
		, b.TreatmentEntryStyle as TreatmentEntryStyleId
		, case when b.TreatmentEntryStyle = 0 then 'None'
		  when b.TreatmentEntryStyle = 1 then 'Fix Amount'
		  when b.TreatmentEntryStyle = 2 then 'Adjustable Amount'
		  when b.TreatmentEntryStyle = 3 then 'Qty'
		  when b.TreatmentEntryStyle = 4 then 'Time Between'
		  else '' end as TreatmentEntryStyleName --modify 2026-03-17
		, b.TreatmentTimeType as TreatmentTimeTypeId --modify 2026-03-17
		, case when b.TreatmentTimeType = 0 then 'None'
		  when b.TreatmentTimeType = 1 then 'Minute'
		  when b.TreatmentTimeType = 2 then 'Hour'
		  when b.TreatmentTimeType = 3 then 'Day'
		  when b.TreatmentTimeType = 4 then 'Day Hour Minute'
		  when b.TreatmentTimeType = 5 then 'Day Hour'
		  when b.TreatmentTimeType = 6 then 'Hour Minute'
		  else '' end as TreatmentTimeTypeName --modify 2026-03-17
		, b.QtyUnitNameText as QtyUnitNameText --modify 2026-03-17
		, coalesce(dbo.sysconname( b.QtyUnitNameText,20021,2),'') as QtyUnitNameTextNameTH --modify 2026-03-17
		, coalesce(dbo.sysconname( b.QtyUnitNameText,20021,1),'') as QtyUnitNameTextNameEN --modify 2026-03-17
		, b.DF as DF --modify 2026-03-17
		, b.DoctorCodeCannotEmpty as DoctorCannotEmpty --modify 2026-03-17
		, b.NurseActivity as NurseActivity --modify 2026-03-17
		, b.CanBeZeroPrice as CanBeZeroPrice --modify 2026-03-17
		, b.OffCode as [Off] --modify 2026-03-17
		, a.Memo --modify 2026-03-17
from	DNSYSCONFIG a
		left join DEVDECRYPT.dbo.PYTS_SETUP_TREATMENT_CODE b  on a.Code=b.Code --modify 2026-03-17
where	a.CtrlCode = 42075