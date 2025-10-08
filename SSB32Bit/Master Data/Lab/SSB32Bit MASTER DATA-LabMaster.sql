select
		  'PLS' as BU
		, lm.CODE as LabCode
		, dbo.CutSortChar(lm.THAINAME) as LabNameTH
		, dbo.CutSortChar(lm.ENGLISHNAME) as LabNameEN
		, Convert(varchar(2), substring(lm.COM,119,120)) as GroupOfLabCode
		, dbo.sysconname(Convert(varchar(2), substring(lm.COM,119,120)),20065,2) as GroupOfLabNameTH
		, dbo.sysconname(Convert(varchar(2), substring(lm.COM,119,120)),20065,1) as GroupOfLabNameEN
		, '' as ChartColour
		, '' as ChartColourNameTH
		, '' as ChartColourNameEN
		, CAST(SUBSTRING(ld.COM,17,7)as VARCHAR) as Symptomatic
		, dbo.sysconname(CAST(SUBSTRING(ld.COM,17,7)as VARCHAR),20507,2) as SymptomaticNameTH
		, dbo.sysconname(CAST(SUBSTRING(ld.COM,17,7)as VARCHAR),20507,1) as SymptomaticNameEN
		, CAST(SUBSTRING(lm.COM,77,5) as varchar(5)) as Specimen
		, dbo.sysconname(CAST(SUBSTRING(lm.COM,77,5) as varchar(5)),20066,2) as SpecimenNameTH
		, dbo.sysconname(CAST(SUBSTRING(lm.COM,77,5) as varchar(5)),20066,1) as SpecimenNameEN
		, CAST(SUBSTRING(lm.COM,101,6) as varchar(6)) as HNActivityOPD
		, dbo.sysconname(CAST(SUBSTRING(lm.COM,101,6) as varchar(6)),20023,2) as HNActivityOPDNameTH
		, dbo.sysconname(CAST(SUBSTRING(lm.COM,101,6) as varchar(6)),20023,1) as HNActivityOPDNameEN
		, CAST(SUBSTRING(lm.COM,107,6) as varchar(6)) as HNActivityIPD
		, dbo.sysconname(CAST(SUBSTRING(lm.COM,107,6) as varchar(6)),20023,2) as HNActivityIPDNameTH
		, dbo.sysconname(CAST(SUBSTRING(lm.COM,107,6) as varchar(6)),20023,1) as HNActivityIPDNameEN
		, CAST(SUBSTRING(lm.COM,57,5) as varchar(5)) as ResultUnitCode
		, dbo.sysconname(CAST(SUBSTRING(lm.COM,57,5) as varchar(5)),20071,2) as ResultUnitNameTH
		, dbo.sysconname(CAST(SUBSTRING(lm.COM,57,5) as varchar(5)),20071,1) as ResultUnitNameEN
		, '' as NormalLabCommentCode
		, '' as NormalLabCommentNameTH
		, '' as NormalLabCommentNameEN
		, CAST(SUBSTRING(lm.COM,113,5) as varchar(5)) as FacilityRMSNo
		, dbo.sysconname(CAST(SUBSTRING(lm.COM,113,5) as varchar(5)),20045,2) as FacilityRMSNoNameTH
		, dbo.sysconname(CAST(SUBSTRING(lm.COM,113,5) as varchar(5)),20045,1) as FacilityRMSNoNameEN
		, CAST(SUBSTRING(ld.com,11,5)as varchar) as LabSpecimenMethod
		, dbo.sysconname(CAST(SUBSTRING(ld.com,11,5)as varchar),20581,2) as LabSpecimenMethodNameTH
		, dbo.sysconname(CAST(SUBSTRING(ld.com,11,5)as varchar),20581,1) as LabSpecimenMethodNameEN
		, '' as Abbreviate
		, '' as DoctorGroup
		, '' as DoctorGroupNameTH
		, '' as DoctorGroupNameEN
		, '' as DefaultRequestQty
		, convert(varchar(5),substring(lm.COM,221,226)) as DefaultOutsideLab
		, dbo.sysconname(convert(varchar(5),substring(lm.COM,221,226)),20274,2) as DefaultOutsideLabNameTH
		, dbo.sysconname(convert(varchar(5),substring(lm.COM,221,226)),20274,1) as DefaultOutsideLabNameEN
		, '' as CheckUpHNActivity
		, '' as CheckUpHNActivityNameTH
		, '' as CheckUpHNActivityNameEN
		, '' as Gender
		, '' as GenderNameTH
		, '' as GenderNameEN
		, CAST(SUBSTRING(lm.COM,99,1)as int) as LabLockSpecimenType
		, case when CAST(SUBSTRING(lm.COM,99,1)as int) = 0 then 'None'
			   when CAST(SUBSTRING(lm.COM,99,1)as int) = 1 then 'Specimen Only'
			   when CAST(SUBSTRING(lm.COM,99,1)as int) = 2 then 'Specimen and Collecting Date'
			   end as LabLockSpecimenTypeName
		, '' as AutoSlectAllSpecimen
		, CAST(SUBSTRING(lm.COM,129,1)as int) as TypeOfLabCode
		, case when CAST(SUBSTRING(lm.COM,129,1)as int) = 0 then 'None'
			   when CAST(SUBSTRING(lm.COM,129,1)as int) = 1 then 'ORGANISM'
			   when CAST(SUBSTRING(lm.COM,129,1)as int) = 2 then 'TESTBLOODGROUP'
			   when CAST(SUBSTRING(lm.COM,129,1)as int) = 3 then 'COOMBS_TEST_DCT'
			   when CAST(SUBSTRING(lm.COM,129,1)as int) = 4 then 'COOMBS_TEST_ICT'
			   when CAST(SUBSTRING(lm.COM,129,1)as int) = 5 then 'HIV'
			   when CAST(SUBSTRING(lm.COM,129,1)as int) = 6 then 'CROSSMATCH'
			   when CAST(SUBSTRING(lm.COM,129,1)as int) = 7 then 'REQUEST_BLOOD'
			   when CAST(SUBSTRING(lm.COM,129,1)as int) = 8 then 'REQUEST_SEROLOGY'
			   when CAST(SUBSTRING(lm.COM,129,1)as int) = 9 then 'WBC_COUNT'
			   when CAST(SUBSTRING(lm.COM,129,1)as int) = 10 then 'WBC_PERCENT'
			   when CAST(SUBSTRING(lm.COM,129,1)as int) = 11 then 'RBC_PERCENT'
			   when CAST(SUBSTRING(lm.COM,129,1)as int) = 12 then 'NRBC'
			   when CAST(SUBSTRING(lm.COM,129,1)as int) = 13 then 'PAPSMEAR'
			   end as TypeOfLabName
		, CAST(SUBSTRING(lm.COM,125,1)as int) as LabResultStyle
		, case when CAST(SUBSTRING(lm.COM,125,1)as int) = 0 then 'NORMAL'
			   when CAST(SUBSTRING(lm.COM,125,1)as int) = 1 then 'FIGURE'
			   when CAST(SUBSTRING(lm.COM,125,1)as int) = 2 then 'BACTERIA'
			   when CAST(SUBSTRING(lm.COM,125,1)as int) = 3 then 'NORMAL_MULTI_FIGURE'
			   when CAST(SUBSTRING(lm.COM,125,1)as int) = 4 then 'HEAD_BACTERIA'
			   when CAST(SUBSTRING(lm.COM,125,1)as int) = 9 then 'NEVERRESULT'
			   end as LabResultStyleName
		, '' as NoDecimalResult
		, '' as MustBeFigure
		, '' as SingelResultValueType
		, '' as SingelResultValueTypeName
		, '' as AutoHideResultType
		, '' as AutoHideResultTypeName
		, '' as QtyToSplit
		, '' as AdditionRequestLabCode1
		, '' as AdditionRequestLabCode1NameTH
		, '' as AdditionRequestLabCode1NameEN
		, '' as AdditionRequestLabCode2
		, '' as AdditionRequestLabCode2NameTH
		, '' as AdditionRequestLabCode2NameEN
		, '' as AdditionRequestLabCode3
		, '' as AdditionRequestLabCode3NameTH
		, '' as AdditionRequestLabCode3NameEN
		, '' as AdditionRequestLabCode4
		, '' as AdditionRequestLabCode4NameTH
		, '' as AdditionRequestLabCode4NameEN
		, '' as AdditionRequestLabCode5
		, '' as AdditionRequestLabCode5NameTH
		, '' as AdditionRequestLabCode5NameEN
		, '' as AdditionRequestLabCode6
		, '' as AdditionRequestLabCode6NameTH
		, '' as AdditionRequestLabCode6NameEN
		, '' as AppmntProcedureMethod
		, '' as AppmntProcedureMethodNameTH
		, '' as AppmntProcedureMethodNameEN
		, '' as LabNormalValueType
		, '' as LabNormalValueTypeName
		, '' as FinalResultFromType
		, '' as FinalResultFromTypeName
		, '' as TimeToBeDoneText
		, '' as ResultOnRequest
		, CAST(SUBSTRING(lm.com,124,1)as int) as RequestWithRemark
		, CAST(SUBSTRING(lm.com,241,1)as int) as NeverChargeOnRequest
		, '' as ShowHighPriceWarning
		, CAST(SUBSTRING(lm.com,123,1)as int) as OpenPrice
		, CAST(SUBSTRING(lm.com,130,1)as int) as NeverShowUpOnHelp
		, CAST(SUBSTRING(ld.com,9,1)as int) as CanBeZeroPrice
		, CAST(SUBSTRING(lm.com,242,1)as int) as EntryWantedDate
		, CAST(SUBSTRING(lm.COM,243,1)as int) as OffCode
		, '' as InfectionControl
		, CAST(SUBSTRING(lm.COM,93,1)as int) as OneTimeUse
		, CAST(SUBSTRING(lm.COM,128,1)as int) as NeverStatistic
		, '' as HostComputerAlwaysCheckNormalValue
				from SYSCONFIG lm
				left join SYSCONFIG ld on lm.CODE=ld.CODE and ld.CTRLCODE = 20521
				where lm.CTRLCODE = 20067
