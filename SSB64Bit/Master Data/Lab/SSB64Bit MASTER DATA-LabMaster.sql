select 
	'PT2' as BU
	, lm.Code as LabCode
	, dbo.CutSortChar(lm.LocalName) as LabNameTH
	, dbo.CutSortChar(lm.EnglishName) as LabNameEN
	, CAST(SUBSTRING(lx2.com,1,7)as varchar) as GroupOfLabCode
	, dbo.sysconname(CAST(SUBSTRING(lx2.com,1,7)as varchar),42129,2) as GroupOfLabNameTH
	, dbo.sysconname(CAST(SUBSTRING(lx2.com,1,7)as varchar),42129,1) as GroupOfLabNameEN
	, CAST(SUBSTRING(lm.com,31,3)as varchar) as ChartColour
	, dbo.sysconname(CAST(SUBSTRING(lm.com,31,3)as varchar),10151,2) as ChartColourNameTH
	, dbo.sysconname(CAST(SUBSTRING(lm.com,31,3)as varchar),10151,1) as ChartColourNameEN
	, CAST(SUBSTRING(lm.com,106,7)as varchar) as Symptomatic
	, dbo.sysconname(CAST(SUBSTRING(lm.com,106,7)as varchar),42127,2) as SymptomaticNameTH
	, dbo.sysconname(CAST(SUBSTRING(lm.com,106,7)as varchar),42127,1) as SymptomaticNameEN
	, CAST(SUBSTRING(lm.com,126,7)as varchar) as Specimen
	, dbo.sysconname(CAST(SUBSTRING(lm.com,126,7)as varchar),42121,2) as SpecimenNameTH
	, dbo.sysconname(CAST(SUBSTRING(lm.com,126,7)as varchar),42121,1) as SpecimenNameEN
	, CAST(SUBSTRING(lm.com,47,6)as varchar) as HNActivityOPD
	, dbo.sysconname(CAST(SUBSTRING(lm.com,47,6)as varchar),42093,2) as HNActivityOPDNameTH
	, dbo.sysconname(CAST(SUBSTRING(lm.com,47,6)as varchar),42093,1) as HNActivityOPDNameEN
	, CAST(SUBSTRING(lm.com,53,6)as varchar) as HNActivityIPD
	, dbo.sysconname(CAST(SUBSTRING(lm.com,53,6)as varchar),42093,2) as HNActivityIPDNameTH
	, dbo.sysconname(CAST(SUBSTRING(lm.com,53,6)as varchar),42093,1) as HNActivityIPDNameEN
	, CAST(SUBSTRING(lm.com,59,5)as varchar) as ResultUnitCode
	, dbo.sysconname( CAST(SUBSTRING(lm.com,59,5)as varchar),42125,2) as ResultUnitNameTH
	, dbo.sysconname( CAST(SUBSTRING(lm.com,59,5)as varchar),42125,1) as ResultUnitNameEN
	, CAST(SUBSTRING(lm.Com,216,9)as varchar) as NormalLabCommentCode
	, dbo.sysconname(CAST(SUBSTRING(lm.Com,216,9)as varchar),42601,2) as NormalLabCommentNameTH
	, dbo.sysconname(CAST(SUBSTRING(lm.Com,216,9)as varchar),42601,1) as NormalLabCommentNameEN
	, CAST(SUBSTRING(lm.com,140,7)as varchar) as FacilityRMSNo
	, dbo.sysconname(CAST(SUBSTRING(lm.com,140,7)as varchar),42141,2) as FacilityRMSNoNameTH
	, dbo.sysconname(CAST(SUBSTRING(lm.com,140,7)as varchar),42141,1) as FacilityRMSNoNameEN
	, CAST(SUBSTRING(lm.Com,134,5)as varchar) as LabSpecimenMethod
	, dbo.sysconname(CAST(SUBSTRING(lm.Com,134,5)as varchar),42122,2) as LabSpecimenMethodNameTH
	, dbo.sysconname(CAST(SUBSTRING(lm.Com,134,5)as varchar),42122,1) as LabSpecimenMethodNameEN
	, CAST(SUBSTRING(lm.Com,79,12)as varchar) as Abbreviate
	, CAST(SUBSTRING(lm.Com,146,7)as varchar) as DoctorGroup
	, dbo.sysconname( CAST(SUBSTRING(lm.Com,146,7)as varchar),42069,2) as DoctorGroupNameTH
	, dbo.sysconname( CAST(SUBSTRING(lm.Com,146,7)as varchar),42069,1) as DoctorGroupNameEN
	, CAST(SUBSTRING(lm.Com,22,8)as int) as DefaultRequestQty
	, CAST(SUBSTRING(lm.Com,73,5)as varchar) as DefaultOutsideLab
	, dbo.sysconname(CAST(SUBSTRING(lm.Com,73,5)as varchar),42048,2) as DefaultOutsideLabNameTH
	, dbo.sysconname(CAST(SUBSTRING(lm.Com,73,5)as varchar),42048,1) as DefaultOutsideLabNameEN
	, CAST(SUBSTRING(lm.Com,41,6)as varchar) as CheckUpHNActivity
	, dbo.sysconname(CAST(SUBSTRING(lm.Com,41,6)as varchar),42093,2) as CheckUpHNActivityNameTH
	, dbo.sysconname(CAST(SUBSTRING(lm.Com,41,6)as varchar),42093,1) as CheckUpHNActivityNameEN
	, CAST(SUBSTRING(lm.Com,116,1)as int) as Gender
	, case when CAST(SUBSTRING(lm.Com,116,1)as int) = 0 then 'ไม่ระบุ'
		   when CAST(SUBSTRING(lm.Com,116,1)as int) = 1 then 'หญิง'
		   when CAST(SUBSTRING(lm.Com,116,1)as int) = 2 then 'ชาย'
		   end as GenderNameTH
	, case when CAST(SUBSTRING(lm.Com,116,1)as int) = 0 then 'None'
		   when CAST(SUBSTRING(lm.Com,116,1)as int) = 1 then 'Female'
		   when CAST(SUBSTRING(lm.Com,116,1)as int) = 2 then 'Male'
		   end as GenderNameEN	   
	, CAST(SUBSTRING(lm.Com,95,1)as int) as LabLockSpecimenType
	, case when CAST(SUBSTRING(lm.Com,95,1)as int) = 0 then 'None'
		   when CAST(SUBSTRING(lm.Com,95,1)as int) = 1 then 'Specimen Require'
		   when CAST(SUBSTRING(lm.Com,95,1)as int) = 2 then 'Specimen Collect Date Require'
		   end as LabLockSpecimenTypeName
	, CAST(SUBSTRING(lm.Com,120,1)as int) as AutoSlectAllSpecimen
	, CAST(SUBSTRING(lm.Com,104,1)as int) as TypeOfLabCode
	, case when CAST(SUBSTRING(lm.Com,104,1)as int) = 0 then 'None'
		   when CAST(SUBSTRING(lm.Com,104,1)as int) = 1 then 'Organism'
		   when CAST(SUBSTRING(lm.Com,104,1)as int) = 2 then 'Test_Blood_Group'
		   when CAST(SUBSTRING(lm.Com,104,1)as int) = 3 then 'Coombs_Test_DCT'
		   when CAST(SUBSTRING(lm.Com,104,1)as int) = 4 then 'Coombs_Test_ICT'
		   when CAST(SUBSTRING(lm.Com,104,1)as int) = 5 then 'HIV'
		   when CAST(SUBSTRING(lm.Com,104,1)as int) = 9 then 'WBC_Count'
		   when CAST(SUBSTRING(lm.Com,104,1)as int) = 10 then 'WBC_Percent'
		   when CAST(SUBSTRING(lm.Com,104,1)as int) = 11 then 'RBC_Percent'
		   when CAST(SUBSTRING(lm.Com,104,1)as int) = 12 then 'NRBC'
		   when CAST(SUBSTRING(lm.Com,104,1)as int) = 13 then 'PapSmear'
		   when CAST(SUBSTRING(lm.Com,104,1)as int) = 14 then 'CD4'
		   when CAST(SUBSTRING(lm.Com,104,1)as int) = 15 then 'Viral_Load'
		   when CAST(SUBSTRING(lm.Com,104,1)as int) = 16 then 'Drug_Resistant'
		   when CAST(SUBSTRING(lm.Com,104,1)as int) = 17 then 'Gram_Stain'
		   when CAST(SUBSTRING(lm.Com,104,1)as int) = 19 then 'Ab_Indentification'
		   when CAST(SUBSTRING(lm.Com,104,1)as int) = 20 then 'HCT'
		   end as TypeOfLabName
	, CAST(SUBSTRING(lm.Com,103,1)as int) as LabResultStyle
	, case when CAST(SUBSTRING(lm.Com,103,1)as int) = 0 then 'None'
		   when CAST(SUBSTRING(lm.Com,103,1)as int) = 1 then 'Normal'
		   when CAST(SUBSTRING(lm.Com,103,1)as int) = 2 then 'Figure'
		   when CAST(SUBSTRING(lm.Com,103,1)as int) = 4 then 'Multiple_Figure'
		   when CAST(SUBSTRING(lm.Com,103,1)as int) = 5 then 'Header'
		   when CAST(SUBSTRING(lm.Com,103,1)as int) = 6 then 'Never_Result'
		   when CAST(SUBSTRING(lm.Com,103,1)as int) = 7 then 'Auto_Generate_By_Formula'
		   end as LabResultStyleName 
	, CAST(SUBSTRING(lm.Com,319,1)as int) as NoDecimalResult
	, CAST(SUBSTRING(lm.Com,215,1)as int) as MustBeFigure
	, CAST(SUBSTRING(lm.Com,307,1)as int) as SingelResultValueType
	, case when CAST(SUBSTRING(lm.Com,307,1)as int) = 0 then 'None'
		   when CAST(SUBSTRING(lm.Com,307,1)as int) = 1 then 'With_None'
		   when CAST(SUBSTRING(lm.Com,307,1)as int) = 2 then 'Without_None'
		   end as SingelResultValueTypeName
	, CAST(SUBSTRING(lm.Com,92,1)as int) as AutoHideResultType
	, case when CAST(SUBSTRING(lm.Com,92,1)as int) = 0 then 'None'
		   when CAST(SUBSTRING(lm.Com,92,1)as int) = 1 then 'Hide_When_Abnomal'
		   when CAST(SUBSTRING(lm.Com,92,1)as int) = 2 then 'Always_Hide'
		   end as AutoHideResultTypeName
	, CAST(SUBSTRING(lm.Com,114,1)as int) as QtyToSplit
	, CAST(SUBSTRING(lm.Com,401,9)as varchar) as AdditionRequestLabCode1
	, dbo.sysconname(CAST(SUBSTRING(lm.Com,401,9)as varchar),42136,2) as AdditionRequestLabCode1NameTH
	, dbo.sysconname(CAST(SUBSTRING(lm.Com,401,9)as varchar),42136,1) as AdditionRequestLabCode1NameEN
	, CAST(SUBSTRING(lm.Com,411,9)as varchar) as AdditionRequestLabCode2
	, dbo.sysconname(CAST(SUBSTRING(lm.Com,411,9)as varchar),42136,2) as AdditionRequestLabCode2NameTH
	, dbo.sysconname(CAST(SUBSTRING(lm.Com,411,9)as varchar),42136,1) as AdditionRequestLabCode2NameEN
	, CAST(SUBSTRING(lm.Com,421,9)as varchar) as AdditionRequestLabCode3
	, dbo.sysconname(CAST(SUBSTRING(lm.Com,421,9)as varchar),42136,2) as AdditionRequestLabCode3NameTH
	, dbo.sysconname(CAST(SUBSTRING(lm.Com,421,9)as varchar),42136,1) as AdditionRequestLabCode3NameEN
	, CAST(SUBSTRING(lm.Com,431,9)as varchar) as AdditionRequestLabCode4
	, dbo.sysconname(CAST(SUBSTRING(lm.Com,431,9)as varchar),42136,2) as AdditionRequestLabCode4NameTH
	, dbo.sysconname(CAST(SUBSTRING(lm.Com,431,9)as varchar),42136,1) as AdditionRequestLabCode4NameEN
	, CAST(SUBSTRING(lm.Com,441,9)as varchar) as AdditionRequestLabCode5
	, dbo.sysconname(CAST(SUBSTRING(lm.Com,441,9)as varchar),42136,2) as AdditionRequestLabCode5NameTH
	, dbo.sysconname(CAST(SUBSTRING(lm.Com,441,9)as varchar),42136,1) as AdditionRequestLabCode5NameEN
	, CAST(SUBSTRING(lm.Com,451,9)as varchar) as AdditionRequestLabCode6
	, dbo.sysconname(CAST(SUBSTRING(lm.Com,451,9)as varchar),42136,2) as AdditionRequestLabCode6NameTH
	, dbo.sysconname(CAST(SUBSTRING(lm.Com,451,9)as varchar),42136,1) as AdditionRequestLabCode6NameEN
	, CAST(SUBSTRING(lm.Com,393,7)as varchar) as AppmntProcedureMethod
	, dbo.sysconname(CAST(SUBSTRING(lm.Com,393,7)as varchar),43286,2) as AppmntProcedureMethodNameTH
	, dbo.sysconname(CAST(SUBSTRING(lm.Com,393,7)as varchar),43286,1) as AppmntProcedureMethodNameEN
	, CAST(SUBSTRING(lm.Com,154,1)as int) as LabNormalValueType
	, case when CAST(SUBSTRING(lm.Com,154,1)as int) = 0 then 'None'
		   when CAST(SUBSTRING(lm.Com,154,1)as int) = 1 then 'Positive'
		   when CAST(SUBSTRING(lm.Com,154,1)as int) = 2 then 'Negative'
		   end as LabNormalValueTypeName
	, CAST(SUBSTRING(lm.Com,121,1)as int) as FinalResultFromType
	, case when CAST(SUBSTRING(lm.Com,121,1)as int) = 0 then 'None'
		   when CAST(SUBSTRING(lm.Com,121,1)as int) = 1 then 'ResultValue'
		   when CAST(SUBSTRING(lm.Com,121,1)as int) = 2 then 'ResultClassified'
		   end as FinalResultFromTypeName
	, CONCAT(CAST(SUBSTRING(lm.Com,227,1)as varchar),CAST(SUBSTRING(lm.Com,229,1)as varchar),CAST(SUBSTRING(lm.Com,231,1)as varchar)
		    ,CAST(SUBSTRING(lm.Com,233,1)as varchar),CAST(SUBSTRING(lm.Com,235,1)as varchar),CAST(SUBSTRING(lm.Com,237,1)as varchar)
			,CAST(SUBSTRING(lm.Com,239,1)as varchar),CAST(SUBSTRING(lm.Com,241,1)as varchar),CAST(SUBSTRING(lm.Com,243,1)as varchar)
			,CAST(SUBSTRING(lm.Com,245,1)as varchar),CAST(SUBSTRING(lm.Com,247,1)as varchar),CAST(SUBSTRING(lm.Com,249,1)as varchar)
			,CAST(SUBSTRING(lm.Com,251,1)as varchar),CAST(SUBSTRING(lm.Com,253,1)as varchar),CAST(SUBSTRING(lm.Com,255,1)as varchar)
			,CAST(SUBSTRING(lm.Com,257,1)as varchar),CAST(SUBSTRING(lm.Com,259,1)as varchar),CAST(SUBSTRING(lm.Com,261,1)as varchar)
			,CAST(SUBSTRING(lm.Com,263,1)as varchar),CAST(SUBSTRING(lm.Com,265,1)as varchar)) as TimeToBeDoneText
	, CAST(SUBSTRING(lm.Com,117,1)as int) as ResultOnRequest
	, CAST(SUBSTRING(lm.Com,94,1)as int) as RequestWithRemark
	, CAST(SUBSTRING(lm.Com,101,1)as int) as NeverChargeOnRequest
	, CAST(SUBSTRING(lm.Com,115,1)as int) as ShowHighPriceWarning
	, CAST(SUBSTRING(lm.Com,97,1)as int) as OpenPrice
	, CAST(SUBSTRING(lm.Com,100,1)as int) as NeverShowUpOnHelp
	, CAST(SUBSTRING(lm.Com,98,1)as int) as CanBeZeroPrice
	, CAST(SUBSTRING(lm.Com,102,1)as int) as EntryWantedDate
	, CAST(SUBSTRING(lm.Com,105,1)as int) as OffCode
	, CAST(SUBSTRING(lm.Com,318,1)as int) as InfectionControl
	, CAST(SUBSTRING(lm.Com,91,1)as int) as OneTimeUse
	, CAST(SUBSTRING(lm.Com,99,1)as int) as NeverStatistic
	, CAST(SUBSTRING(lm.Com,469,1)as int) as HostComputerAlwaysCheckNormalValue
				from DNSYSCONFIG lm
				left join DNSYSCONFIG_DETAIL lx2 on lm.CtrlCode=lx2.MasterCtrlCode and lm.Code=lx2.Code and lx2.CtrlCode=60051 and lx2.AdditionCode='EXTEND2'
				where lm.CtrlCode = 42136
