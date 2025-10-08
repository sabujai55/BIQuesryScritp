select 
		  'PLS' as BU
		, tm.CODE as TreatmentCode
		, dbo.CutSortChar(tm.THAINAME) as TreatmentNameTH
		, dbo.CutSortChar(tm.ENGLISHNAME) as TreatmentNameEN
		, CAST(SUBSTRING(tm.COM,1,5)as varchar) as TreatmentCategoryCode
		, dbo.sysconname(CAST(SUBSTRING(tm.COM,1,5)as varchar),20049,2) as TreatmentCategoryNameTH
		, dbo.sysconname(CAST(SUBSTRING(tm.COM,1,5)as varchar),20049,1) as TreatmentCategoryNameEN
		, CAST(SUBSTRING(tm.COM,13,5)as varchar) as HNActivityCode
		, dbo.sysconname(CAST(SUBSTRING(tm.COM,13,5)as varchar),20023,2) as HNActivityNameTH
		, dbo.sysconname(CAST(SUBSTRING(tm.COM,13,5)as varchar),20023,1) as HNActivityNameEN
		, CAST(SUBSTRING(td1.COM,65,11)as varchar) as UnitOfQtyOfWork
		, '' as DefaultPrice
		, CAST(SUBSTRING(tm.COM,45,1)as int) as TreatmentEntryStyleId
		, case when CAST(SUBSTRING(tm.COM,45,1)as int) = 0 then 'None'
			   when CAST(SUBSTRING(tm.COM,45,1)as int) = 1 then 'STD_FIX_AMT'
			   when CAST(SUBSTRING(tm.COM,45,1)as int) = 2 then 'STD_ADJ_AMT'
			   when CAST(SUBSTRING(tm.COM,45,1)as int) = 3 then 'BY_QTY'
			   when CAST(SUBSTRING(tm.COM,45,1)as int) = 4 then 'BY_TIME'
			   when CAST(SUBSTRING(tm.COM,45,1)as int) = 5 then 'BY_TIME_BETWEEN'
			   when CAST(SUBSTRING(tm.COM,45,1)as int) = 6 then 'BY_UNIT_VALUE'
			   when CAST(SUBSTRING(tm.COM,45,1)as int) = 7 then 'BY_ADJ_AMT_TIMESTAMP'
			   end as TreatmentEntryStyleName
		, '' as TreatmentTimeTypeId
		, '' as TreatmentTimeTypeName
		, '' as QtyUnitNameText
		, '' as QtyUnitNameTextNameTH
		, '' as QtyUnitNameTextNameEN
		, Convert(int, substring(tm.com,51,1)) as DF
		, '' as DoctorCannotEmpty
		, Convert(int, substring(tm.com,48,1)) as NurseActivity
		, Convert(int, substring(tm.com,56,1)) as CanBeZeroPrice
		, Convert(int, substring(tm.com,62,1)) as [Off]
		, '' as Memo
				from SYSCONFIG tm
				left join SYSCONFIG td1 on tm.CODE=td1.CODE and td1.CTRLCODE = 20461
				where tm.CTRLCODE = 20051