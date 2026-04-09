select	
		 'PTS' as BU
		, a.Code as HNActivityCode
		, dbo.CutSortChar(a.LocalName) as HNActivityNameTH
		, dbo.CutSortChar(a.EnglishName) as HNActivityNameEN
		, b.IncomeSummaryCode as IncomeSummaryCode --modify 2026-03-17
		, coalesce(dbo.sysconname(b.IncomeSummaryCode,43424,2),'') as IncomeSummaryNameTH --modify 2026-03-17
		, coalesce(dbo.sysconname(b.IncomeSummaryCode,43424,1),'') as IncomeSummaryNameEN --modify 2026-03-17

		, b.ActivityCategory as HNActivityCategoryCode --modify 2026-03-17
		, coalesce(dbo.sysconname(b.ActivityCategory,42091,2),'') as HNActivityCategoryNameTH --modify 2026-03-17
		, coalesce(dbo.sysconname(b.ActivityCategory,42091,1),'') as HNActivityCategoryNameEN --modify 2026-03-17

		, b.ARActivityCode as ARActivityCode --modify 2026-03-17
		, coalesce(dbo.sysconname(b.ARActivityCode,36081,2),'') as ARActivityNameTH --modify 2026-03-17
		, coalesce(dbo.sysconname(b.ARActivityCode,36081,1),'') as ARActivityNameEN --modify 2026-03-17

		, b.HospitalTypeOfActivity as HospitalActivityTypeId --modify 2026-03-17
		, case when b.HospitalTypeOfActivity = 0 then 'None'
		  when b.HospitalTypeOfActivity = 1 then 'Normal'
		  when b.HospitalTypeOfActivity = 2 then 'Medicine'
		  when b.HospitalTypeOfActivity = 3 then 'Activity'
		  when b.HospitalTypeOfActivity = 4 then 'Room'
		  when b.HospitalTypeOfActivity = 5 then 'Meal'
		  when b.HospitalTypeOfActivity = 6 then 'Service Charge'
		  when b.HospitalTypeOfActivity = 7 then 'Usage'
		  when b.HospitalTypeOfActivity = 8 then 'Xray'
		  when b.HospitalTypeOfActivity = 9 then 'Lab'
		  when b.HospitalTypeOfActivity = 10 then 'PT'
		  when b.HospitalTypeOfActivity = 11 then 'LR'
		  when b.HospitalTypeOfActivity = 12 then 'OR'
		  when b.HospitalTypeOfActivity = 13 then 'PABX'
		  when b.HospitalTypeOfActivity = 14 then 'Meal Extra'
		  when b.HospitalTypeOfActivity = 15 then 'Equipment'
		  when b.HospitalTypeOfActivity = 16 then 'Room Meal'
		  when b.HospitalTypeOfActivity = 17 then 'Blood Bank'
		  when b.HospitalTypeOfActivity = 18 then 'Patho'
		  when b.HospitalTypeOfActivity = 19 then 'Investigate'
		  when b.HospitalTypeOfActivity = 20 then 'Protesis'
		  when b.HospitalTypeOfActivity = 21 then 'Rehabilitation'
		  when b.HospitalTypeOfActivity = 22 then 'ICD Charge'
		  when b.HospitalTypeOfActivity = 23 then 'Vehicle Tranfer'
		  when b.HospitalTypeOfActivity = 24 then 'DF'
		  when b.HospitalTypeOfActivity = 25 then 'ANES'
		  when b.HospitalTypeOfActivity = 26 then 'OR DF'
		  when b.HospitalTypeOfActivity = 27 then 'Blood Crossmatch'
		  when b.HospitalTypeOfActivity = 28 then 'Treatment'
		  when b.HospitalTypeOfActivity = 29 then 'Misc'
		  when b.HospitalTypeOfActivity = 30 then 'ICU Room'
		  when b.HospitalTypeOfActivity = 31 then 'Dental'
		  when b.HospitalTypeOfActivity = 32 then 'Medical Equipment'
		  when b.HospitalTypeOfActivity = 33 then 'Take Home Medical'
		  when b.HospitalTypeOfActivity = 34 then 'Special Diagnotic'
		  when b.HospitalTypeOfActivity = 35 then 'Acpuncture'
		  else '' end as HospitalActivityTypeName --modify 2026-03-17

		, b.TransferDFType as TypeofTransfertoDFId  --modify 2026-03-17
		, case when b.TransferDFType = 0 then 'None'
		  when b.TransferDFType = 2 then 'Yes' 
		  else '' end as TypeofTransfertoDFName --modify 2026-03-17
from	DNSYSCONFIG a
		left join DEVDECRYPT.dbo.PYTS_SETUP_ACTIVITY_CODE b on a.Code=b.Code --modify 2026-03-17
where	CtrlCode = 42093

