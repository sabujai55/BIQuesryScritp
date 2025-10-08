select
		  'PLS' as BU
		, xm.Code as XrayCode
		, dbo.CutSortChar(xm.THAINAME) as XrayNameTH
		, dbo.CutSortChar(xm.ENGLISHNAME) as XrayNameEN
		, '' as DefaultXrayExposureMachine
		, '' as DefaultXrayExposureMachineNameTH
		, '' as DefaultXrayExposureMachineNameEN
		, '' as TypeOfXrayId
		, '' as TypeOfXrayName
		, CAST(SUBSTRING(xm.COM,61,3)as varchar) as GroupOfXrayCode
		, dbo.sysconname(CAST(SUBSTRING(xm.COM,61,3)as varchar),20072,2) as GroupOfXrayNameTH
		, dbo.sysconname(CAST(SUBSTRING(xm.COM,61,3)as varchar),20072,1) as GroupOfXrayNameEN
		, CAST(SUBSTRING(xm.COM,133,7)as varchar) as Organ
		, dbo.sysconname(CAST(SUBSTRING(xm.COM,133,7)as varchar),20053,2) as OrganNameTH
		, dbo.sysconname(CAST(SUBSTRING(xm.COM,133,7)as varchar),20053,1) as OrganNameEN
		, CAST(SUBSTRING(xm.COM,141,7)as varchar) as OrganPosition
		, dbo.sysconname(CAST(SUBSTRING(xm.COM,141,7)as varchar),20054,2) as OrganPositionNameTH
		, dbo.sysconname(CAST(SUBSTRING(xm.COM,141,7)as varchar),20054,1) as OrganPositionNameEN
		, CAST(SUBSTRING(xm.COM,41,5)as varchar) as UsageMethod
		, dbo.sysconname(CAST(SUBSTRING(xm.COM,41,5)as varchar),20074,2) as UsageMethodNameTH
		, dbo.sysconname(CAST(SUBSTRING(xm.COM,41,5)as varchar),20074,1) as UsageMethodNameEN
		, CAST(SUBSTRING(xm.COM,65,5)as varchar) as FacilityRmsNo
		, dbo.sysconname(CAST(SUBSTRING(xm.COM,65,5)as varchar),20045,2) as FacilityRmsNoNameTH
		, dbo.sysconname(CAST(SUBSTRING(xm.COM,65,5)as varchar),20045,1) as FacilityRmsNoNameEN
		, CAST(SUBSTRING(xm.COM,49,5)as varchar) as HNActivityCodeOPD
		, dbo.sysconname(CAST(SUBSTRING(xm.COM,49,5)as varchar),20023,2) as HNActivityOPDNameTH
		, dbo.sysconname(CAST(SUBSTRING(xm.COM,49,5)as varchar),20023,1) as HNActivityOPDNameEN
		, CAST(SUBSTRING(xm.COM,55,5)as varchar) as HNActivityCodeIPD
		, dbo.sysconname(CAST(SUBSTRING(xm.COM,55,5)as varchar),20023,2) as HNActivityIPDNameTH
		, dbo.sysconname(CAST(SUBSTRING(xm.COM,55,5)as varchar),20023,1) as HNActivityIPDNameEN
		, '' as HNActivityCodeCheckUp
		, '' as HNActivityCheckUpNameTH
		, '' as HNActivityCheckUpNameEN
		, CAST(SUBSTRING(xm.COM,109,11)as varchar) as DFOnResultTreatmentCode
		, dbo.sysconname(CAST(SUBSTRING(xm.COM,109,11)as varchar),20051,2) as DFOnResultTreatmentNameTH
		, dbo.sysconname(CAST(SUBSTRING(xm.COM,109,11)as varchar),20051,1) as DFOnResultTreatmentNameEN
		, CAST(SUBSTRING(xm.COM,121,11)as varchar) as DFOnSpecialResultTreatmentCode
		, dbo.sysconname(CAST(SUBSTRING(xm.COM,121,11)as varchar),20051,2) as DFOnSpecialResultTreatmentNameTH
		, dbo.sysconname(CAST(SUBSTRING(xm.COM,121,11)as varchar),20051,1) as DFOnSpecialResultTreatmentNameEN
		, '' as XrayResultCategoryCode
		, '' as XrayResultCategoryNameTH
		, '' as XrayResultCategoryNameEN
		, '' as DefaultPrice
		, SIGN(CAST(substring(xm.COM,200-0,1)+substring(xm.COM,200-1,1)+substring(xm.COM,200-2,1)+substring(xm.COM,200-3,1)+substring(xm.COM,200-4,1)+substring(xm.COM,200-5,1)+substring(xm.COM,200-6,1)+substring(xm.COM,200-7,1) AS BIGINT))
		  *(1.0 + (CAST(substring(xm.COM,200-0,1)+substring(xm.COM,200-1,1)+substring(xm.COM,200-2,1)+substring(xm.COM,200-3,1)+substring(xm.COM,200-4,1)+substring(xm.COM,200-5,1)+substring(xm.COM,200-6,1)+substring(xm.COM,200-7,1) AS BIGINT) & 0x000FFFFFFFFFFFFF) * POWER(CAST(2 AS FLOAT), -52))
		  * POWER(CAST(2 AS FLOAT), (CAST(substring(xm.COM,200-0,1)+substring(xm.COM,200-1,1)+substring(xm.COM,200-2,1)+substring(xm.COM,200-3,1)+substring(xm.COM,200-4,1)+substring(xm.COM,200-5,1)+substring(xm.COM,200-6,1)+substring(xm.COM,200-7,1) AS BIGINT) & 0x7ff0000000000000) / 0x0010000000000000 - 1023)
		  as ResultDfAmt
		, '' as DefaultPortableAdditionCharge
		, '' as CGDTextCode
		, CAST(SUBSTRING(xm.COM,72,1)as int) as OpenPrice
		, CAST(SUBSTRING(xm.COM,185,1)as int) as [Off]
				from SYSCONFIG xm
				where xm.CtrlCode = 20073