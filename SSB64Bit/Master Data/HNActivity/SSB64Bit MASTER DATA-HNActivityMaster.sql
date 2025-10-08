use SSBLIVE
go

select	
		 'PT2' as BU
		, a.Code as HNActivityCode
		, dbo.CutSortChar(a.LocalName) as HNActivityNameTH
		, dbo.CutSortChar(a.EnglishName) as HNActivityNameEN
		, cast(substring(a.com,21,5) as varchar(5)) as IncomeSummaryCode
		, coalesce(dbo.sysconname(CAST(SUBSTRING(a.Com,21,5) as varchar(5)),43424,2),'') as IncomeSummaryNameTH
		, coalesce(dbo.sysconname(CAST(SUBSTRING(a.Com,21,5) as varchar(5)),43424,1),'') as IncomeSummaryNameEN

		, cast(substring(a.com,17,3) as varchar(3)) as HNActivityCategoryCode
		, coalesce(dbo.sysconname(CAST(SUBSTRING(a.Com,17,3) as varchar(3)),42091,2),'') as HNActivityCategoryNameTH
		, coalesce(dbo.sysconname(CAST(SUBSTRING(a.Com,17,3) as varchar(3)),42091,1),'') as HNActivityCategoryNameEN

		, cast(substring(a.com,124,3) as varchar(3)) as ARActivityCode
		, coalesce(dbo.sysconname(CAST(SUBSTRING(a.Com,124,3) as varchar(3)),36081,2),'') as ARActivityNameTH
		, coalesce(dbo.sysconname(CAST(SUBSTRING(a.Com,124,3) as varchar(3)),36081,1),'') as ARActivityNameEN

		, cast(substring(a.com,94,1) as int) as HospitalActivityTypeId
		, case when cast(substring(a.com,94,1) as int) = 0 then 'None'
		  when cast(substring(a.com,94,1) as int) = 1 then 'Normal'
		  when cast(substring(a.com,94,1) as int) = 2 then 'Medicine'
		  when cast(substring(a.com,94,1) as int) = 3 then 'Activity'
		  when cast(substring(a.com,94,1) as int) = 4 then 'Room'
		  when cast(substring(a.com,94,1) as int) = 5 then 'Meal'
		  when cast(substring(a.com,94,1) as int) = 6 then 'Service Charge'
		  when cast(substring(a.com,94,1) as int) = 7 then 'Usage'
		  when cast(substring(a.com,94,1) as int) = 8 then 'Xray'
		  when cast(substring(a.com,94,1) as int) = 9 then 'Lab'
		  when cast(substring(a.com,94,1) as int) = 10 then 'PT'
		  when cast(substring(a.com,94,1) as int) = 11 then 'LR'
		  when cast(substring(a.com,94,1) as int) = 12 then 'OR'
		  when cast(substring(a.com,94,1) as int) = 13 then 'PABX'
		  when cast(substring(a.com,94,1) as int) = 14 then 'Meal Extra'
		  when cast(substring(a.com,94,1) as int) = 15 then 'Equipment'
		  when cast(substring(a.com,94,1) as int) = 16 then 'Room Meal'
		  when cast(substring(a.com,94,1) as int) = 17 then 'Blood Bank'
		  when cast(substring(a.com,94,1) as int) = 18 then 'Patho'
		  when cast(substring(a.com,94,1) as int) = 19 then 'Investigate'
		  when cast(substring(a.com,94,1) as int) = 20 then 'Protesis'
		  when cast(substring(a.com,94,1) as int) = 21 then 'Rehabilitation'
		  when cast(substring(a.com,94,1) as int) = 22 then 'ICD Charge'
		  when cast(substring(a.com,94,1) as int) = 23 then 'Vehicle Tranfer'
		  when cast(substring(a.com,94,1) as int) = 24 then 'DF'
		  when cast(substring(a.com,94,1) as int) = 25 then 'ANES'
		  when cast(substring(a.com,94,1) as int) = 26 then 'OR DF'
		  when cast(substring(a.com,94,1) as int) = 27 then 'Blood Crossmatch'
		  when cast(substring(a.com,94,1) as int) = 28 then 'Treatment'
		  when cast(substring(a.com,94,1) as int) = 29 then 'Misc'
		  when cast(substring(a.com,94,1) as int) = 30 then 'ICU Room'
		  when cast(substring(a.com,94,1) as int) = 31 then 'Dental'
		  when cast(substring(a.com,94,1) as int) = 32 then 'Medical Equipment'
		  when cast(substring(a.com,94,1) as int) = 33 then 'Take Home Medical'
		  when cast(substring(a.com,94,1) as int) = 34 then 'Special Diagnotic'
		  when cast(substring(a.com,94,1) as int) = 35 then 'Acpuncture'
		  else '' end as HospitalActivityTypeName

		, cast(substring(a.com,96,1) as int) as TypeofTransfertoDFId 
		, case when cast(substring(a.com,96,1) as int) = 0 then 'None'
		  when cast(substring(a.com,96,1) as int) = 2 then 'Yes' 
		  else '' end as TypeofTransfertoDFName
from	DNSYSCONFIG a
where	CtrlCode = 42093

