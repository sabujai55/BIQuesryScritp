
select	
		 'PTS' as BU
		, a.Code as XrayCode
		, coalesce(dbo.CutSortChar(a.LocalName),'') as XrayNameTH
		, coalesce(dbo.CutSortChar(a.EnglishName),'') as XrayNameEN
		, c.DefaultXrayExposureMachine as DefaultXrayExposureMachine --modify 2026-03-17
		, coalesce(dbo.sysconname(c.DefaultXrayExposureMachine,42175,2),'') as DefaultXrayExposureMachineNameTH --modify 2026-03-17
		, coalesce(dbo.sysconname(c.DefaultXrayExposureMachine,42175,1),'') as DefaultXrayExposureMachineNameEN --modify 2026-03-17
		, c.TypeOfXrayCode as TypeOfXrayId --modify 2026-03-17
		, case when c.TypeOfXrayCode = 0 then 'None'
		  when c.TypeOfXrayCode = 1 then 'Breast Cancer Screening'
		  when c.TypeOfXrayCode = 2 then 'Dental InsideMouth'
		  when c.TypeOfXrayCode = 3 then 'Dental OutsideMouth'
		  end as TypeOfXrayName --modify 2026-03-17
		, d.GroupOfXrayCode as GroupOfXrayCode --modify 2026-03-17
		, coalesce(dbo.sysconname(d.GroupOfXrayCode,42171,2),'') as GroupOfXrayNameTH --modify 2026-03-17
		, coalesce(dbo.sysconname(d.GroupOfXrayCode,42171,1),'') as GroupOfXrayNameEN --modify 2026-03-17
		, c.OrganCode as Organ --modify 2026-03-17
		, coalesce(dbo.sysconname(c.OrganCode,42181,2),'') as OrganNameTH --modify 2026-03-17
		, coalesce(dbo.sysconname(c.OrganCode,42181,1),'') as OrganNameEN --modify 2026-03-17
		, c.OrganPosition as OrganPosition --modify 2026-03-17
		, coalesce(dbo.sysconname(c.OrganPosition,42182,2),'') as OrganPositionNameTH --modify 2026-03-17
		, coalesce(dbo.sysconname(c.OrganPosition,42182,1),'') as OrganPositionNameEN --modify 2026-03-17
		, c.UsageMethod as UsageMethod --modify 2026-03-17
		, coalesce(dbo.sysconname(c.UsageMethod,20121,2),'') as UsageMethodNameTH --modify 2026-03-17
		, coalesce(dbo.sysconname(c.UsageMethod,20121,1),'') as UsageMethodNameEN --modify 2026-03-17
		, c.FacilityRmsNo as FacilityRmsNo --modify 2026-03-17
		, coalesce(dbo.sysconname(c.FacilityRmsNo,42141,2),'') as FacilityRmsNoNameTH --modify 2026-03-17
		, coalesce(dbo.sysconname(c.FacilityRmsNo,42141,1),'') as FacilityRmsNoNameEN --modify 2026-03-17
		, c.HNActivityCodeOPD as HNActivityCodeOPD --modify 2026-03-17
		, coalesce(dbo.sysconname(c.HNActivityCodeOPD,42093,2),'') as HNActivityOPDNameTH --modify 2026-03-17
		, coalesce(dbo.sysconname(c.HNActivityCodeOPD,42093,1),'') as HNActivityOPDNameEN --modify 2026-03-17
		, c.HNActivityCodeIPD as HNActivityCodeIPD --modify 2026-03-17
		, coalesce(dbo.sysconname(c.HNActivityCodeIPD,42093,2),'') as HNActivityIPDNameTH --modify 2026-03-17
		, coalesce(dbo.sysconname(c.HNActivityCodeIPD,42093,1),'') as HNActivityIPDNameEN --modify 2026-03-17
		, c.CheckUpHNActivityCode as HNActivityCodeCheckUp --modify 2026-03-17
		, coalesce(dbo.sysconname(c.CheckUpHNActivityCode,42093,2),'') as HNActivityCheckUpNameTH --modify 2026-03-17
		, coalesce(dbo.sysconname(c.CheckUpHNActivityCode,42093,1),'') as HNActivityCheckUpNameEN --modify 2026-03-17
		, c.DFOnResultTreatmentCode as DFOnResultTreatmentCode --modify 2026-03-17
		, coalesce(dbo.sysconname(c.DFOnResultTreatmentCode,42075,2),'') as DFOnResultTreatmentNameTH --modify 2026-03-17
		, coalesce(dbo.sysconname(c.DFOnResultTreatmentCode,42075,1),'') as DFOnResultTreatmentNameEN --modify 2026-03-17
		, c.DFOnSpecialResultTreatmentCode as DFOnSpecialResultTreatmentCode --modify 2026-03-17
		, coalesce(dbo.sysconname(c.DFOnSpecialResultTreatmentCode,42075,2),'') as DFOnSpecialResultTreatmentNameTH --modify 2026-03-17
		, coalesce(dbo.sysconname(c.DFOnSpecialResultTreatmentCode,42075,1),'') as DFOnSpecialResultTreatmentNameEN --modify 2026-03-17
		, c.XrayResultCategoryCode as XrayResultCategoryCode --modify 2026-03-17
		, coalesce(dbo.sysconname(c.XrayResultCategoryCode,42170,2),'') as XrayResultCategoryNameTH --modify 2026-03-17
		, coalesce(dbo.sysconname(c.XrayResultCategoryCode,42170,1),'') as XrayResultCategoryNameEN --modify 2026-03-17
		, c.DefaultPrice as DefaultPrice --modify 2026-03-17
		, c.ResultDfAmt as ResultDfAmt --modify 2026-03-17
		, c.DefaultPortableAdditionCharge as DefaultPortableAdditionCharge --modify 2026-03-17
		, d.CGDTextCode as CGDTextCode --modify 2026-03-17
		, c.OpenPrice as OpenPrice --modify 2026-03-17
		, c.OffCode as [Off] --modify 2026-03-17
from	DNSYSCONFIG a
		left join DNSYSCONFIG_DETAIL b on a.CtrlCode = b.MasterCtrlCode and a.Code = b.Code and b.AdditionCode = 'EXT'
		left join DEVDECRYPT.dbo.PYTS_SETUP_XRAY_CODE c on a.Code=c.Code --modify 2026-03-17
		left join DEVDECRYPT.dbo.PYTS_SETUP_XRAY_CODE_DTL_EXT d on a.Code=d.Code --modify 2026-03-17
where	a.CtrlCode = 42179
		 