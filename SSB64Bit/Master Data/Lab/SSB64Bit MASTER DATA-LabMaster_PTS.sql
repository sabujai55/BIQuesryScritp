use DNHOSPITAL
go

select 
	'PTS' as BU
	, lm.Code as LabCode
	, dbo.CutSortChar(lm.LocalName) as LabNameTH
	, dbo.CutSortChar(lm.EnglishName) as LabNameEN
	, delx2.GroupOfLabCode as GroupOfLabCode --เปลี่ยน
	, dbo.sysconname(delx2.GroupOfLabCode,42129,2) as GroupOfLabNameTH --เปลี่ยน
	, dbo.sysconname(delx2.GroupOfLabCode,42129,1) as GroupOfLabNameEN --เปลี่ยน
	, delm.ChartColourCode as ChartColour --เปลี่ยน
	, dbo.sysconname(delm.ChartColourCode,10151,2) as ChartColourNameTH --เปลี่ยน
	, dbo.sysconname(delm.ChartColourCode,10151,1) as ChartColourNameEN --เปลี่ยน
	, delm.SymptomaticCode as Symptomatic --เปลี่ยน
	, dbo.sysconname(delm.SymptomaticCode,42127,2) as SymptomaticNameTH --เปลี่ยน
	, dbo.sysconname(delm.SymptomaticCode,42127,1) as SymptomaticNameEN --เปลี่ยน
	, delm.SpecimenCode as Specimen --เปลี่ยน
	, dbo.sysconname(delm.SpecimenCode,42121,2) as SpecimenNameTH --เปลี่ยน
	, dbo.sysconname(delm.SpecimenCode,42121,1) as SpecimenNameEN --เปลี่ยน
	, delm.HNActivityCodeOPD as HNActivityOPD --เปลี่ยน
	, dbo.sysconname(delm.HNActivityCodeOPD,42093,2) as HNActivityOPDNameTH --เปลี่ยน
	, dbo.sysconname(delm.HNActivityCodeOPD,42093,1) as HNActivityOPDNameEN --เปลี่ยน
	, delm.HNActivityCodeIPD as HNActivityIPD --เปลี่ยน
	, dbo.sysconname(delm.HNActivityCodeIPD,42093,2) as HNActivityIPDNameTH --เปลี่ยน
	, dbo.sysconname(delm.HNActivityCodeIPD,42093,1) as HNActivityIPDNameEN --เปลี่ยน
	, delm.ResultUnitCode as ResultUnitCode --เปลี่ยน
	, dbo.sysconname(delm.ResultUnitCode,42125,2) as ResultUnitNameTH --เปลี่ยน
	, dbo.sysconname(delm.ResultUnitCode,42125,1) as ResultUnitNameEN --เปลี่ยน
	, delm.NormalLabCommentCode as NormalLabCommentCode --เปลี่ยน
	, dbo.sysconname(delm.NormalLabCommentCode,42601,2) as NormalLabCommentNameTH --เปลี่ยน
	, dbo.sysconname(delm.NormalLabCommentCode,42601,1) as NormalLabCommentNameEN --เปลี่ยน
	, delm.FacilityRmsNo as FacilityRMSNo --เปลี่ยน
	, dbo.sysconname(delm.FacilityRmsNo,42141,2) as FacilityRMSNoNameTH --เปลี่ยน
	, dbo.sysconname(delm.FacilityRmsNo,42141,1) as FacilityRMSNoNameEN --เปลี่ยน
	, delm.LabSpecimenMethod as LabSpecimenMethod --เปลี่ยน
	, dbo.sysconname(delm.LabSpecimenMethod,42122,2) as LabSpecimenMethodNameTH --เปลี่ยน
	, dbo.sysconname(delm.LabSpecimenMethod,42122,1) as LabSpecimenMethodNameEN --เปลี่ยน
	, delm.Abbreviate as Abbreviate --เปลี่ยน
	, delm.OnlyDoctorGroup as DoctorGroup --เปลี่ยน
	, dbo.sysconname(delm.OnlyDoctorGroup,42069,2) as DoctorGroupNameTH --เปลี่ยน
	, dbo.sysconname(delm.OnlyDoctorGroup,42069,1) as DoctorGroupNameEN --เปลี่ยน
	, delm.DefaultReqestQty as DefaultRequestQty --เปลี่ยน
	, delm.DefaultOutsideLaboratory as DefaultOutsideLab --เปลี่ยน
	, dbo.sysconname(delm.DefaultOutsideLaboratory,42048,2) as DefaultOutsideLabNameTH --เปลี่ยน
	, dbo.sysconname(delm.DefaultOutsideLaboratory,42048,1) as DefaultOutsideLabNameEN --เปลี่ยน
	, delm.CheckUpHNActivityCode as CheckUpHNActivity --เปลี่ยน
	, dbo.sysconname(delm.CheckUpHNActivityCode,42093,2) as CheckUpHNActivityNameTH --เปลี่ยน
	, dbo.sysconname(delm.CheckUpHNActivityCode,42093,1) as CheckUpHNActivityNameEN --เปลี่ยน
	, delm.Gender as Gender --เปลี่ยน
	, case when CAST(delm.Gender as int) = 0 then 'ไม่ระบุ'
		   when CAST(delm.Gender as int) = 1 then 'หญิง'
		   when CAST(delm.Gender as int) = 2 then 'ชาย'
		   end as GenderNameTH --เปลี่ยน
	, case when CAST(delm.Gender as int) = 0 then 'None'
		   when CAST(delm.Gender as int) = 1 then 'Female'
		   when CAST(delm.Gender as int) = 2 then 'Male'
		   end as GenderNameEN	 --เปลี่ยน   
	, delm.LabLockSpecimenType as LabLockSpecimenType
	, case when CAST(delm.LabLockSpecimenType as int) = 0 then 'None'
		   when CAST(delm.LabLockSpecimenType as int) = 1 then 'Specimen Require'
		   when CAST(delm.LabLockSpecimenType as int) = 2 then 'Specimen Collect Date Require'
		   end as LabLockSpecimenTypeName --เปลี่ยน
	, delm.AutoSelectAllSpecimen as AutoSlectAllSpecimen --เปลี่ยน
	, delm.TypeOfLabCode as TypeOfLabCode --เปลี่ยน
	, case when CAST(delm.TypeOfLabCode as int) = 0 then 'None'
		   when CAST(delm.TypeOfLabCode as int) = 1 then 'Organism'
		   when CAST(delm.TypeOfLabCode as int) = 2 then 'Test_Blood_Group'
		   when CAST(delm.TypeOfLabCode as int) = 3 then 'Coombs_Test_DCT'
		   when CAST(delm.TypeOfLabCode as int) = 4 then 'Coombs_Test_ICT'
		   when CAST(delm.TypeOfLabCode as int) = 5 then 'HIV'
		   when CAST(delm.TypeOfLabCode as int) = 9 then 'WBC_Count'
		   when CAST(delm.TypeOfLabCode as int) = 10 then 'WBC_Percent'
		   when CAST(delm.TypeOfLabCode as int) = 11 then 'RBC_Percent'
		   when CAST(delm.TypeOfLabCode as int) = 12 then 'NRBC'
		   when CAST(delm.TypeOfLabCode as int) = 13 then 'PapSmear'
		   when CAST(delm.TypeOfLabCode as int) = 14 then 'CD4'
		   when CAST(delm.TypeOfLabCode as int) = 15 then 'Viral_Load'
		   when CAST(delm.TypeOfLabCode as int) = 16 then 'Drug_Resistant'
		   when CAST(delm.TypeOfLabCode as int) = 17 then 'Gram_Stain'
		   when CAST(delm.TypeOfLabCode as int) = 19 then 'Ab_Indentification'
		   when CAST(delm.TypeOfLabCode as int) = 20 then 'HCT'
		   end as TypeOfLabName --เปลี่ยน
	, delm.LabResultStyle as LabResultStyle --เปลี่ยน
	, case when CAST(delm.LabResultStyle as int) = 0 then 'None'
		   when CAST(delm.LabResultStyle as int) = 1 then 'Normal'
		   when CAST(delm.LabResultStyle as int) = 2 then 'Figure'
		   when CAST(delm.LabResultStyle as int) = 4 then 'Multiple_Figure'
		   when CAST(delm.LabResultStyle as int) = 5 then 'Header'
		   when CAST(delm.LabResultStyle as int) = 6 then 'Never_Result'
		   when CAST(delm.LabResultStyle as int) = 7 then 'Auto_Generate_By_Formula'
		   end as LabResultStyleName  --เปลี่ยน
	, delm.NoDecimalResult as NoDecimalResult --เปลี่ยน
	, delm.MustBeFigure as MustBeFigure --เปลี่ยน
	, delm.SingleResultValueType as SingelResultValueType --เปลี่ยน
	, case when CAST(delm.SingleResultValueType as int) = 0 then 'None'
		   when CAST(delm.SingleResultValueType as int) = 1 then 'With_None'
		   when CAST(delm.SingleResultValueType as int) = 2 then 'Without_None'
		   end as SingelResultValueTypeName --เปลี่ยน
	, delm.LABAutoHideResultType  as AutoHideResultType --เปลี่ยน
	, case when CAST(delm.LABAutoHideResultType as int) = 0 then 'None'
		   when CAST(delm.LABAutoHideResultType as int) = 1 then 'Hide_When_Abnomal'
		   when CAST(delm.LABAutoHideResultType as int) = 2 then 'Always_Hide'
		   end as AutoHideResultTypeName --เปลี่ยน
	, delm.QtyToSplit as QtyToSplit --เปลี่ยน
	, delm.AdditionRequestLabCode_0 as AdditionRequestLabCode1 --เปลี่ยน
	, dbo.sysconname(delm.AdditionRequestLabCode_0,42136,2) as AdditionRequestLabCode1NameTH --เปลี่ยน
	, dbo.sysconname(delm.AdditionRequestLabCode_0,42136,1) as AdditionRequestLabCode1NameEN --เปลี่ยน
	, delm.AdditionRequestLabCode_1 as AdditionRequestLabCode2 --เปลี่ยน
	, dbo.sysconname(delm.AdditionRequestLabCode_1,42136,2) as AdditionRequestLabCode2NameTH --เปลี่ยน
	, dbo.sysconname(delm.AdditionRequestLabCode_1,42136,1) as AdditionRequestLabCode2NameEN --เปลี่ยน
	, delm.AdditionRequestLabCode_2 as AdditionRequestLabCode3 --เปลี่ยน
	, dbo.sysconname(delm.AdditionRequestLabCode_2,42136,2) as AdditionRequestLabCode3NameTH --เปลี่ยน
	, dbo.sysconname(delm.AdditionRequestLabCode_2,42136,1) as AdditionRequestLabCode3NameEN --เปลี่ยน
	, delm.AdditionRequestLabCode_3 as AdditionRequestLabCode4 --เปลี่ยน
	, dbo.sysconname(delm.AdditionRequestLabCode_3,42136,2) as AdditionRequestLabCode4NameTH --เปลี่ยน
	, dbo.sysconname(delm.AdditionRequestLabCode_3,42136,1) as AdditionRequestLabCode4NameEN --เปลี่ยน
	, delm.AdditionRequestLabCode_4 as AdditionRequestLabCode5 --เปลี่ยน
	, dbo.sysconname(delm.AdditionRequestLabCode_4,42136,2) as AdditionRequestLabCode5NameTH --เปลี่ยน
	, dbo.sysconname(delm.AdditionRequestLabCode_4,42136,1) as AdditionRequestLabCode5NameEN --เปลี่ยน
	, delm.AdditionRequestLabCode_5 as AdditionRequestLabCode6 --เปลี่ยน
	, dbo.sysconname(delm.AdditionRequestLabCode_5,42136,2) as AdditionRequestLabCode6NameTH --เปลี่ยน
	, dbo.sysconname(delm.AdditionRequestLabCode_5,42136,1) as AdditionRequestLabCode6NameEN --เปลี่ยน
	, delm.AppmntProcedureMethod as AppmntProcedureMethod --เปลี่ยน
	, dbo.sysconname(delm.AppmntProcedureMethod,43286,2) as AppmntProcedureMethodNameTH --เปลี่ยน
	, dbo.sysconname(delm.AppmntProcedureMethod,43286,1) as AppmntProcedureMethodNameEN --เปลี่ยน
	, delm.LABNormalValueType as LabNormalValueType --เปลี่ยน
	, case when CAST(delm.LABNormalValueType as int) = 0 then 'None'
		   when CAST(delm.LABNormalValueType as int) = 1 then 'Positive'
		   when CAST(delm.LABNormalValueType as int) = 2 then 'Negative'
		   end as LabNormalValueTypeName --เปลี่ยน
	, delm.FinalResultFromType as FinalResultFromType --เปลี่ยน
	, case when CAST(delm.FinalResultFromType as int) = 0 then 'None'
		   when CAST(delm.FinalResultFromType as int) = 1 then 'ResultValue'
		   when CAST(delm.FinalResultFromType as int) = 2 then 'ResultClassified'
		   end as FinalResultFromTypeName --เปลี่ยน
	, delm.TimeToBeDoneText as TimeToBeDoneText --เปลี่ยน
	, delm.ResultOnRequest as ResultOnRequest --เปลี่ยน
	, delm.RequestWithRemarks as RequestWithRemark --เปลี่ยน
	, delm.NeverChargeOnRequest as NeverChargeOnRequest --เปลี่ยน
	, delm.ShowHighPriceWarning as ShowHighPriceWarning --เปลี่ยน
	, delm.OpenPrice as OpenPrice --เปลี่ยน
	, delm.NeverShowUpOnHelp as NeverShowUpOnHelp --เปลี่ยน
	, delm.CanBeZeroPrice as CanBeZeroPrice --เปลี่ยน
	, delm.EntryWantedDate as EntryWantedDate --เปลี่ยน
	, delm.OffCode as OffCode --เปลี่ยน
	, delm.InfectionControl as InfectionControl --เปลี่ยน
	, delm.OneTimeUse as OneTimeUse --เปลี่ยน
	, delm.NeverStatistic as NeverStatistic --เปลี่ยน
	, delm.HostComputerAlwaysCheckNormalValue as HostComputerAlwaysCheckNormalValue --เปลี่ยน
				from DNSYSCONFIG lm
				--left join DNSYSCONFIG_DETAIL lx2 on lm.CtrlCode=lx2.MasterCtrlCode and lm.Code=lx2.Code and lx2.CtrlCode=60051 and lx2.AdditionCode='EXTEND2'
				left join DEVDECRYPT.dbo.PYTS_SETUP_LAB_CODE_DTL_EXTEND_2 delx2 on delx2.Code = lm.Code --เพิ่ม
				left join DEVDECRYPT.dbo.PYTS_SETUP_LAB_CODE delm on delm.Code = lm.Code
				where lm.CtrlCode = 42136
				