use SSBLIVE
go

select	
		 'PT2' as BU
		, a.Code as XrayCode
		, coalesce(dbo.CutSortChar(a.LocalName),'') as XrayNameTH
		, coalesce(dbo.CutSortChar(a.EnglishName),'') as XrayNameEN
		, CAST(SUBSTRING(a.Com,113,3) as varchar(3)) as DefaultXrayExposureMachine
		, coalesce(dbo.sysconname(CAST(SUBSTRING(a.Com,113,3) as varchar(3)),42175,2),'') as DefaultXrayExposureMachineNameTH
		, coalesce(dbo.sysconname(CAST(SUBSTRING(a.Com,113,3) as varchar(3)),42175,1),'') as DefaultXrayExposureMachineNameEN
		, CAST(SUBSTRING(a.Com,153,1) as int) as TypeOfXrayId
		, case when CAST(SUBSTRING(a.Com,153,1) as int) = 0 then 'None'
		  when CAST(SUBSTRING(a.Com,153,1) as int) = 1 then 'Breast Cancer Screening'
		  when CAST(SUBSTRING(a.Com,153,1) as int) = 2 then 'Dental InsideMouth'
		  when CAST(SUBSTRING(a.Com,153,1) as int) = 3 then 'Dental OutsideMouth'
		  end as TypeOfXrayName
		, CAST(SUBSTRING(b.Com,221,3) as varchar(3)) as GroupOfXrayCode
		, coalesce(dbo.sysconname(CAST(SUBSTRING(b.Com,221,3) as varchar(3)),42171,2),'') as GroupOfXrayNameTH
		, coalesce(dbo.sysconname(CAST(SUBSTRING(b.Com,221,3) as varchar(3)),42171,1),'') as GroupOfXrayNameEN
		, CAST(SUBSTRING(a.Com,97,7) as varchar(7)) as Organ
		, coalesce(dbo.sysconname(CAST(SUBSTRING(a.Com,97,7) as varchar(7)),42181,2),'') as OrganNameTH
		, coalesce(dbo.sysconname(CAST(SUBSTRING(a.Com,97,7) as varchar(7)),42181,1),'') as OrganNameEN
		, CAST(SUBSTRING(a.Com,105,7) as varchar(7)) as OrganPosition
		, coalesce(dbo.sysconname(CAST(SUBSTRING(a.Com,105,7) as varchar(7)),42182,2),'') as OrganPositionNameTH
		, coalesce(dbo.sysconname(CAST(SUBSTRING(a.Com,105,7) as varchar(7)),42182,1),'') as OrganPositionNameEN
		, CAST(SUBSTRING(a.Com,33,7) as varchar(7)) as UsageMethod
		, coalesce(dbo.sysconname(CAST(SUBSTRING(a.Com,33,7) as varchar(7)),20121,2),'') as UsageMethodNameTH
		, coalesce(dbo.sysconname(CAST(SUBSTRING(a.Com,33,7) as varchar(7)),20121,1),'') as UsageMethodNameEN
		, CAST(SUBSTRING(a.Com,57,5) as varchar(5)) as FacilityRmsNo
		, coalesce(dbo.sysconname(CAST(SUBSTRING(a.Com,57,5) as varchar(5)),42141,2),'') as FacilityRmsNoNameTH
		, coalesce(dbo.sysconname(CAST(SUBSTRING(a.Com,57,5) as varchar(5)),42141,1),'') as FacilityRmsNoNameEN
		, CAST(SUBSTRING(a.Com,41,5) as varchar(5)) as HNActivityCodeOPD
		, coalesce(dbo.sysconname(CAST(SUBSTRING(a.Com,41,5) as varchar(5)),42093,2),'') as HNActivityOPDNameTH
		, coalesce(dbo.sysconname(CAST(SUBSTRING(a.Com,41,5) as varchar(5)),42093,1),'') as HNActivityOPDNameEN
		, CAST(SUBSTRING(a.Com,47,5) as varchar(5)) as HNActivityCodeIPD
		, coalesce(dbo.sysconname(CAST(SUBSTRING(a.Com,47,5) as varchar(5)),42093,2),'') as HNActivityIPDNameTH
		, coalesce(dbo.sysconname(CAST(SUBSTRING(a.Com,47,5) as varchar(5)),42093,1),'') as HNActivityIPDNameEN
		, CAST(SUBSTRING(a.Com,120,5) as varchar(5)) as HNActivityCodeCheckUp
		, coalesce(dbo.sysconname(CAST(SUBSTRING(a.Com,120,5) as varchar(5)),42093,2),'') as HNActivityCheckUpNameTH
		, coalesce(dbo.sysconname(CAST(SUBSTRING(a.Com,120,5) as varchar(5)),42093,1),'') as HNActivityCheckUpNameEN
		, CAST(SUBSTRING(a.Com,73,11) as varchar(11)) as DFOnResultTreatmentCode
		, coalesce(dbo.sysconname(CAST(SUBSTRING(a.Com,73,11) as varchar(11)),42075,2),'') as DFOnResultTreatmentNameTH
		, coalesce(dbo.sysconname(CAST(SUBSTRING(a.Com,73,11) as varchar(11)),42075,1),'') as DFOnResultTreatmentNameEN
		, CAST(SUBSTRING(a.Com,85,11) as varchar(11)) as DFOnSpecialResultTreatmentCode
		, coalesce(dbo.sysconname(CAST(SUBSTRING(a.Com,85,11) as varchar(11)),42075,2),'') as DFOnSpecialResultTreatmentNameTH
		, coalesce(dbo.sysconname(CAST(SUBSTRING(a.Com,85,11) as varchar(11)),42075,1),'') as DFOnSpecialResultTreatmentNameEN
		, CAST(SUBSTRING(a.Com,357,5) as varchar(5)) as XrayResultCategoryCode
		, coalesce(dbo.sysconname(CAST(SUBSTRING(a.Com,357,5) as varchar(5)),42170,2),'') as XrayResultCategoryNameTH
		, coalesce(dbo.sysconname(CAST(SUBSTRING(a.Com,357,5) as varchar(5)),42170,1),'') as XrayResultCategoryNameEN
		, DefaultPrice = SIGN(CAST(substring(a.COM,8-0,1)+substring(a.COM,8-1,1)+substring(a.COM,8-2,1)+substring(a.COM,8-3,1)+substring(a.COM,8-4,1)+substring(a.COM,8-5,1)+substring(a.COM,8-6,1)+substring(a.COM,8-7,1) AS BIGINT))
		  *(1.0 + (CAST(substring(a.COM,8-0,1)+substring(a.COM,8-1,1)+substring(a.COM,8-2,1)+substring(a.COM,8-3,1)+substring(a.COM,8-4,1)+substring(a.COM,8-5,1)+substring(a.COM,8-6,1)+substring(a.COM,8-7,1) AS BIGINT) & 0x000FFFFFFFFFFFFF) * POWER(CAST(2 AS FLOAT), -52))
		  * POWER(CAST(2 AS FLOAT), (CAST(substring(a.COM,8-0,1)+substring(a.COM,8-1,1)+substring(a.COM,8-2,1)+substring(a.COM,8-3,1)+substring(a.COM,8-4,1)+substring(a.COM,8-5,1)+substring(a.COM,8-6,1)+substring(a.COM,8-7,1) AS BIGINT) & 0x7ff0000000000000) / 0x0010000000000000 - 1023)
		, ResultDfAmt = SIGN(CAST(substring(a.COM,32-0,1)+substring(a.COM,32-1,1)+substring(a.COM,32-2,1)+substring(a.COM,32-3,1)+substring(a.COM,32-4,1)+substring(a.COM,32-5,1)+substring(a.COM,32-6,1)+substring(a.COM,32-7,1) AS BIGINT))
		  *(1.0 + (CAST(substring(a.COM,32-0,1)+substring(a.COM,32-1,1)+substring(a.COM,32-2,1)+substring(a.COM,32-3,1)+substring(a.COM,32-4,1)+substring(a.COM,32-5,1)+substring(a.COM,32-6,1)+substring(a.COM,32-7,1) AS BIGINT) & 0x000FFFFFFFFFFFFF) * POWER(CAST(2 AS FLOAT), -52))
		  * POWER(CAST(2 AS FLOAT), (CAST(substring(a.COM,32-0,1)+substring(a.COM,32-1,1)+substring(a.COM,32-2,1)+substring(a.COM,32-3,1)+substring(a.COM,32-4,1)+substring(a.COM,32-5,1)+substring(a.COM,32-6,1)+substring(a.COM,32-7,1) AS BIGINT) & 0x7ff0000000000000) / 0x0010000000000000 - 1023)		
		, DefaultPortableAdditionCharge = SIGN(CAST(substring(a.COM,16-0,1)+substring(a.COM,16-1,1)+substring(a.COM,16-2,1)+substring(a.COM,16-3,1)+substring(a.COM,16-4,1)+substring(a.COM,16-5,1)+substring(a.COM,16-6,1)+substring(a.COM,16-7,1) AS BIGINT))
		  *(1.0 + (CAST(substring(a.COM,16-0,1)+substring(a.COM,16-1,1)+substring(a.COM,16-2,1)+substring(a.COM,16-3,1)+substring(a.COM,16-4,1)+substring(a.COM,16-5,1)+substring(a.COM,16-6,1)+substring(a.COM,16-7,1) AS BIGINT) & 0x000FFFFFFFFFFFFF) * POWER(CAST(2 AS FLOAT), -52))
		  * POWER(CAST(2 AS FLOAT), (CAST(substring(a.COM,16-0,1)+substring(a.COM,16-1,1)+substring(a.COM,16-2,1)+substring(a.COM,16-3,1)+substring(a.COM,16-4,1)+substring(a.COM,16-5,1)+substring(a.COM,16-6,1)+substring(a.COM,16-7,1) AS BIGINT) & 0x7ff0000000000000) / 0x0010000000000000 - 1023)
		, CAST(SUBSTRING(a.Com,364,14) as varchar(14)) as CGDTextCode
		, CAST(SUBSTRING(a.Com,63,1) as int) as OpenPrice
		, CAST(SUBSTRING(a.Com,119,1) as int) as [Off]
from	DNSYSCONFIG a
		left join DNSYSCONFIG_DETAIL b on a.CtrlCode = b.MasterCtrlCode and a.Code = b.Code and b.AdditionCode = 'EXT'
where	a.CtrlCode = 42179
		 