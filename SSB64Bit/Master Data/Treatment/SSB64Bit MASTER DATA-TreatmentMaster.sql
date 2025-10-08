use SSBLIVE
go

select	
		 'PT2' as BU
		, a.Code as TreatmentCode
		, coalesce(dbo.CutSortChar(a.LocalName),'') as TreatmentNameTH
		, coalesce(dbo.CutSortChar(a.EnglishName),'') as TreatmentNameEN
		, CAST(SUBSTRING(a.Com,131,9) as varchar(9)) as TreatmentCategoryCode
		, coalesce(dbo.sysconname(CAST(SUBSTRING(a.Com,131,9) as varchar(9)),42072,2),'') as TreatmentCategoryNameTH
		, coalesce(dbo.sysconname(CAST(SUBSTRING(a.Com,131,9) as varchar(9)),42072,1),'') as TreatmentCategoryNameEN
		, CAST(SUBSTRING(a.Com,141,5) as varchar(5)) as HNActivityCode
		, coalesce(dbo.sysconname(CAST(SUBSTRING(a.Com,141,5) as varchar(5)),42093,2),'') as HNActivityNameTH
		, coalesce(dbo.sysconname(CAST(SUBSTRING(a.Com,141,5) as varchar(5)),42093,1),'') as HNActivityNameEN
		, CAST(SUBSTRING(a.Com,202,11) as varchar(11)) as UnitOfQtyOfWork
		, DefaultPrice = SIGN(CAST(substring(a.COM,16-0,1)+substring(a.COM,16-1,1)+substring(a.COM,16-2,1)+substring(a.COM,16-3,1)+substring(a.COM,16-4,1)+substring(a.COM,16-5,1)+substring(a.COM,16-6,1)+substring(a.COM,16-7,1) AS BIGINT))
		  *(1.0 + (CAST(substring(a.COM,16-0,1)+substring(a.COM,16-1,1)+substring(a.COM,16-2,1)+substring(a.COM,16-3,1)+substring(a.COM,16-4,1)+substring(a.COM,16-5,1)+substring(a.COM,16-6,1)+substring(a.COM,16-7,1) AS BIGINT) & 0x000FFFFFFFFFFFFF) * POWER(CAST(2 AS FLOAT), -52))
		  * POWER(CAST(2 AS FLOAT), (CAST(substring(a.COM,16-0,1)+substring(a.COM,16-1,1)+substring(a.COM,16-2,1)+substring(a.COM,16-3,1)+substring(a.COM,16-4,1)+substring(a.COM,16-5,1)+substring(a.COM,16-6,1)+substring(a.COM,16-7,1) AS BIGINT) & 0x7ff0000000000000) / 0x0010000000000000 - 1023)
		, CAST(SUBSTRING(a.Com,179,1) as int) as TreatmentEntryStyleId
		, case when CAST(SUBSTRING(a.Com,179,1) as int) = 0 then 'None'
		  when CAST(SUBSTRING(a.Com,179,1) as int) = 1 then 'Fix Amount'
		  when CAST(SUBSTRING(a.Com,179,1) as int) = 2 then 'Adjustable Amount'
		  when CAST(SUBSTRING(a.Com,179,1) as int) = 3 then 'Qty'
		  when CAST(SUBSTRING(a.Com,179,1) as int) = 4 then 'Time Between'
		  else '' end as TreatmentEntryStyleName
		, CAST(SUBSTRING(a.Com,184,1) as int) as TreatmentTimeTypeId
		, case when CAST(SUBSTRING(a.Com,184,1) as int) = 0 then 'None'
		  when CAST(SUBSTRING(a.Com,184,1) as int) = 1 then 'Minute'
		  when CAST(SUBSTRING(a.Com,184,1) as int) = 2 then 'Hour'
		  when CAST(SUBSTRING(a.Com,184,1) as int) = 3 then 'Day'
		  when CAST(SUBSTRING(a.Com,184,1) as int) = 4 then 'Day Hour Minute'
		  when CAST(SUBSTRING(a.Com,184,1) as int) = 5 then 'Day Hour'
		  when CAST(SUBSTRING(a.Com,184,1) as int) = 6 then 'Hour Minute'
		  else '' end as TreatmentTimeTypeName
		, CAST(SUBSTRING(a.Com,233,3) as varchar(3)) as QtyUnitNameText
		, coalesce(dbo.sysconname(CAST(SUBSTRING(a.Com,233,3) as varchar(3)),20021,2),'') as QtyUnitNameTextNameTH
		, coalesce(dbo.sysconname(CAST(SUBSTRING(a.Com,233,3) as varchar(3)),20021,1),'') as QtyUnitNameTextNameEN
		, CAST(SUBSTRING(a.Com,185,1) as int) as DF
		, CAST(SUBSTRING(a.Com,265,1) as int) as DoctorCannotEmpty
		, CAST(SUBSTRING(a.Com,180,1) as int) as NurseActivity
		, CAST(SUBSTRING(a.Com,189,1) as int) as CanBeZeroPrice
		, CAST(SUBSTRING(a.Com,194,1) as int) as [Off]
		, a.Memo
from	DNSYSCONFIG a
where	a.CtrlCode = 42075