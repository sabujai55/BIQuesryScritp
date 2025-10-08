use SSBLIVE
go

select	top 100 
		'PT2' as BU
		, a.HN as PatientID
		, a.FacilityRmsNo
		, a.RequestNo
		, a.EntryDateTime
		, a.RequestDoctor as RequestDoctorCode
		, dbo.CutSortChar(b.LocalName) as RequestDoctorNameTH
		, dbo.CutSortChar(b.EnglishName) as RequestDoctorNameEN
		, a.RightCode
		, dbo.CutSortChar(sys07.LocalName) as RightNameTH
		, dbo.CutSortChar(sys07.EnglishName) as RightNameEN
		, a.HNORRmsNo
		, dbo.CutSortChar(sys08.LocalName) as HNORRmsNoNameTH
		, dbo.CutSortChar(sys08.EnglishName) as HNORRmsNoNameEN
		, a.NPODateTime
		, a.AttendDateTime
		, a.ORConfirmDateTime
		, a.PrivateCase
		, c.[Description] as ORCaseType
		, case when a.ORClassifiedType = 1 then 'Major'
		  when a.ORClassifiedType = 2 then 'Minor'
		  when a.ORClassifiedType = 0 then 'None' end as ORClassifiedType
		, d.[Description] as ORVisitType
		, a.HoldRequest
		, a.ORBeginDateTimePlan
		, a.ORFinishDateTimePlan
		, a.ORBeginDateTimeActual
		, a.ORFinishDateTimeActual
		, a.AnesBeginDateTimePlan
		, a.AnesFinishDateTimePlan
		, a.AnesBeginDateTimeActual
		, a.AnesFinishDateTimeActual
		, (select replace(replace(cast(m.RemarksMemo as NVarchar(4000)),CHAR(10),' '),CHAR(13),' ') from HNORREQ_MEMO m where m.FacilityRmsNo = a.FacilityRmsNo and m.RequestNo = a.RequestNo and m.HNORRequestMemoType = 5) as PreDiagMemo
		, (select replace(replace(cast(m.RemarksMemo as NVarchar(4000)),CHAR(10),' '),CHAR(13),' ') from HNORREQ_MEMO m where m.FacilityRmsNo = a.FacilityRmsNo and m.RequestNo = a.RequestNo and m.HNORRequestMemoType = 14) as ICDCmMemo
		, a.ORPostureCode
		, dbo.CutSortChar(sys01.LocalName) as ORPostureNameTH
		, dbo.CutSortChar(sys01.EnglishName) as ORPostureNameEN
		, a.ORICDGroupCode
		, dbo.CutSortChar(sys02.LocalName) as ORICDGroupNameTH
		, dbo.CutSortChar(sys02.EnglishName) as ORICDGroupNameEN
		, a.ORICDCmGroupCode
		, dbo.CutSortChar(sys03.LocalName) as ORICDCMGroupNameTH
		, dbo.CutSortChar(sys03.EnglishName) as ORICDCMGroupNameEN
		, a.ORSpecialty
		, dbo.CutSortChar(sys04.LocalName) as ORSpecialtyNameTH
		, dbo.CutSortChar(sys04.EnglishName) as ORSpecialtyNameEN
		, e.[Description] as ORWithAnesType
		, a.ORReOperationReasonCode
		, dbo.CutSortChar(sys05.LocalName) as ORReOperationReasonNameTH
		, dbo.CutSortChar(sys05.EnglishName) as ORReOperationReasonNameEN
		, a.ORResultCode
		, dbo.CutSortChar(sys06.LocalName) as ORResultNameTH
		, dbo.CutSortChar(sys06.EnglishName) as ORResultNameEN
		, a.CxlDateTime
		, a.CxlByUserCode
		, dbo.CutSortChar(sys09.LocalName) as CxlByUserNameTH
		, dbo.CutSortChar(sys09.EnglishName) as CxlByUserNameEN
		, a.CxlReasonCode
		, dbo.CutSortChar(sys10.LocalName) as CxlReasonNameTH
		, dbo.CutSortChar(sys10.EnglishName) as CxlReasonNameEN
		, anes.AnesPhysicianCode1
		, anes.AnesPhysicianNameTH1
		, anes.AnesPhysicianNameEN1
		, anes.AnesPhysicianCode2
		, anes.AnesPhysicianNameTH2
		, anes.AnesPhysicianNameEN2
		, anes.AnesNurseCode
		, anes.AnesNurseNameTH
		, anes.AnesNurseNameEN
		, anes.ORPreMedicationCode1
		, anes.ORPreMedicationNameTH1
		, anes.ORPreMedicationNameEN1
		, anes.ORPreMedicationCode2
		, anes.ORPreMedicationNameTH2
		, anes.ORPreMedicationNameEN2
		, anes.ORPreMedicationCode3
		, anes.ORPreMedicationNameTH3
		, anes.ORPreMedicationNameEN3
		, anes.ORPreOpProblemCode1
		, anes.ORPreOpProblemNameTH1
		, anes.ORPreOpProblemNameEN1
		, anes.ORPreOpProblemCode2
		, anes.ORPreOpProblemNameTH2
		, anes.ORPreOpProblemNameEN2
		, anes.ORPreOpProblemCode3
		, anes.ORPreOpProblemNameTH3
		, anes.ORPreOpProblemNameEN3
		, anes.TypeOfAnesthesia1
		, anes.TypeOfAnesthesiaNameTH1
		, anes.TypeOfAnesthesiaNameEN1
		, anes.TypeOfAnesthesia2
		, anes.TypeOfAnesthesiaNameTH2
		, anes.TypeOfAnesthesiaNameEN2
		, anes.AnesTechniqueCode1
		, anes.AnesTechniqueNameTH1
		, anes.AnesTechniqueNameEN1
		, anes.AnesTechniqueCode2
		, anes.AnesTechniqueNameTH2
		, anes.AnesTechniqueNameEN2
		, anes.AnesTechniqueCode3
		, anes.AnesTechniqueNameTH3
		, anes.AnesTechniqueNameEN3
		, anes.AnesTechniqueCode4
		, anes.AnesTechniqueNameTH4
		, anes.AnesTechniqueNameEN4
		, anes.HNORReverseType
		, anes.AnesReasonCode
		, anes.AnesReasonNameTH
		, anes.AnesReasonNameEN
		, anes.ORPostOPComplicationCode1
		, anes.ORPostOPComplicationNameTH1
		, anes.ORPostOPComplicationNameEN1
		, anes.ORPostOPComplicationCode2
		, anes.ORPostOPComplicationNameTH2
		, anes.ORPostOPComplicationNameEN2
		, anes.ORPostOPComplicationCode3
		, anes.ORPostOPComplicationNameTH3
		, anes.ORPostOPComplicationNameEN3
		, anes.ORInductionDrugCode1
		, anes.ORInductionDrugNameTH1
		, anes.ORInductionDrugNameEN1
		, anes.ORInductionDrugCode2
		, anes.ORInductionDrugNameTH2
		, anes.ORInductionDrugNameEN2
		, anes.ORInductionDrugCode3
		, anes.ORInductionDrugNameTH3
		, anes.ORInductionDrugNameEN3
		, anes.ORInductionDrugCode4
		, anes.ORInductionDrugNameTH4
		, anes.ORInductionDrugNameEN4
		, anes.ORIntubationCode
		, anes.ORIntubationNameTH
		, anes.ORIntubationNameEN
		, anes.ORMaintenanceDrugCode
		, anes.ORMaintenanceDrugNameTH
		, anes.ORMaintenanceDrugNameEN
		, anes.ORPersonWorkingGroupNo
		, anes.Remarks
from	HNORREQ_HEADER a 
		left join HNDOCTOR_MASTER b on a.RequestDoctor = b.Doctor
		left join v_FixORCaseType c on a.ORCaseType = c.FixORCaseTypeID
		left join v_FixORVisitType d on a.ORVisitType = d.FixORVisitTypeId
		LEFT join v_FixORWithAnesType e on a.ORWithAnesType = e.FixORWithAnesTypeID
		left join DNSYSCONFIG sys01 on sys01.CtrlCode = 42726 and a.ORPostureCode = sys01.Code
		left join DNSYSCONFIG sys02 on sys02.CtrlCode = 42753 and a.ORICDGroupCode = sys02.Code
		left join DNSYSCONFIG sys03 on sys03.CtrlCode = 42758 and a.ORICDCmGroupCode = sys03.Code
		left join DNSYSCONFIG sys04 on sys04.CtrlCode = 42729 and a.ORSpecialty = sys04.Code
		left join DNSYSCONFIG sys05 on sys05.CtrlCode = 42766 and a.ORReOperationReasonCode = sys05.Code
		left join DNSYSCONFIG sys06 on sys06.CtrlCode = 42773 and a.ORResultCode = sys06.Code
		left join DNSYSCONFIG sys07 on sys07.CtrlCode = 42086 and a.RightCode = sys07.Code
		left join DNSYSCONFIG sys08 on sys08.CtrlCode = 42721 and a.HNORRmsNo = sys08.Code
		left join DNSYSCONFIG sys09 on sys09.CtrlCode = 10031 and a.CxlByUserCode = sys09.Code
		left join DNSYSCONFIG sys10 on sys10.CtrlCode = 43165 and a.CxlReasonCode = sys10.Code
		left join   
		(
			select  'PT2' as BU
					, a.FacilityRmsNo
					, a.RequestNo
					--, COUNT(b.RequestNo) as cnt 
					, b.Doctor as AnesPhysicianCode1
					, dbo.CutSortChar(d.LocalName) as AnesPhysicianNameTH1
					, dbo.CutSortChar(d.EnglishName) as AnesPhysicianNameEN1
					, b.Doctor2 as AnesPhysicianCode2
					, dbo.CutSortChar(d2.LocalName) as AnesPhysicianNameTH2
					, dbo.CutSortChar(d2.EnglishName) as AnesPhysicianNameEN2
					, b.AnesNurseCode
					, dbo.CutSortChar(sys01.LocalName) as AnesNurseNameTH
					, dbo.CutSortChar(sys01.EnglishName) as AnesNurseNameEN
					, b.ORPreMedicationCode1
					, dbo.CutSortChar(sys02.LocalName) as ORPreMedicationNameTH1
					, dbo.CutSortChar(sys02.EnglishName) as ORPreMedicationNameEN1
					, b.ORPreMedicationCode2
					, dbo.CutSortChar(sys03.LocalName) as ORPreMedicationNameTH2
					, dbo.CutSortChar(sys03.EnglishName) as ORPreMedicationNameEN2
					, b.ORPreMedicationCode3
					, dbo.CutSortChar(sys04.LocalName) as ORPreMedicationNameTH3
					, dbo.CutSortChar(sys04.EnglishName) as ORPreMedicationNameEN3
					, b.ORPreOpProblemCode1
					, dbo.CutSortChar(sys05.LocalName) as ORPreOpProblemNameTH1
					, dbo.CutSortChar(sys05.EnglishName) as ORPreOpProblemNameEN1
					, b.ORPreOpProblemCode2
					, dbo.CutSortChar(sys06.LocalName) as ORPreOpProblemNameTH2
					, dbo.CutSortChar(sys06.EnglishName) as ORPreOpProblemNameEN2
					, b.ORPreOpProblemCode3
					, dbo.CutSortChar(sys07.LocalName) as ORPreOpProblemNameTH3
					, dbo.CutSortChar(sys07.EnglishName) as ORPreOpProblemNameEN3
					, b.TypeOfAnesthesia1
					, dbo.CutSortChar(sys08.LocalName) as TypeOfAnesthesiaNameTH1
					, dbo.CutSortChar(sys08.EnglishName) as TypeOfAnesthesiaNameEN1
					, b.TypeOfAnesthesia2
					, dbo.CutSortChar(sys09.LocalName) as TypeOfAnesthesiaNameTH2
					, dbo.CutSortChar(sys09.EnglishName) as TypeOfAnesthesiaNameEN2
					, b.AnesTechniqueCode1
					, dbo.CutSortChar(sys10.LocalName) as AnesTechniqueNameTH1
					, dbo.CutSortChar(sys10.EnglishName) as AnesTechniqueNameEN1
					, b.AnesTechniqueCode2
					, dbo.CutSortChar(sys11.LocalName) as AnesTechniqueNameTH2
					, dbo.CutSortChar(sys11.EnglishName) as AnesTechniqueNameEN2
					, b.AnesTechniqueCode3
					, dbo.CutSortChar(sys12.LocalName) as AnesTechniqueNameTH3
					, dbo.CutSortChar(sys12.EnglishName) as AnesTechniqueNameEN3
					, b.AnesTechniqueCode4
					, dbo.CutSortChar(sys13.LocalName) as AnesTechniqueNameTH4
					, dbo.CutSortChar(sys13.EnglishName) as AnesTechniqueNameEN4
					, c.[Description] as HNORReverseType
					, b.AnesReasonCode
					, dbo.CutSortChar(sys14.LocalName) as AnesReasonNameTH
					, dbo.CutSortChar(sys14.EnglishName) as AnesReasonNameEN
					, b.ORPostOPComplicationCode1
					, dbo.CutSortChar(sys15.LocalName) as ORPostOPComplicationNameTH1
					, dbo.CutSortChar(sys15.EnglishName) as ORPostOPComplicationNameEN1
					, b.ORPostOPComplicationCode2
					, dbo.CutSortChar(sys16.LocalName) as ORPostOPComplicationNameTH2
					, dbo.CutSortChar(sys16.EnglishName) as ORPostOPComplicationNameEN2
					, b.ORPostOPComplicationCode3
					, dbo.CutSortChar(sys17.LocalName) as ORPostOPComplicationNameTH3
					, dbo.CutSortChar(sys17.EnglishName) as ORPostOPComplicationNameEN3
					, b.ORInductionDrugCode1
					, dbo.CutSortChar(sys18.LocalName) as ORInductionDrugNameTH1
					, dbo.CutSortChar(sys18.EnglishName) as ORInductionDrugNameEN1
					, b.ORInductionDrugCode2
					, dbo.CutSortChar(sys19.LocalName) as ORInductionDrugNameTH2
					, dbo.CutSortChar(sys19.EnglishName) as ORInductionDrugNameEN2
					, b.ORInductionDrugCode3
					, dbo.CutSortChar(sys20.LocalName) as ORInductionDrugNameTH3
					, dbo.CutSortChar(sys20.EnglishName) as ORInductionDrugNameEN3
					, b.ORInductionDrugCode4
					, dbo.CutSortChar(sys21.LocalName) as ORInductionDrugNameTH4
					, dbo.CutSortChar(sys21.EnglishName) as ORInductionDrugNameEN4
					, b.ORIntubationCode
					, dbo.CutSortChar(sys22.LocalName) as ORIntubationNameTH
					, dbo.CutSortChar(sys22.EnglishName) as ORIntubationNameEN
					, b.ORMaintenanceDrugCode
					, dbo.CutSortChar(sys23.LocalName) as ORMaintenanceDrugNameTH
					, dbo.CutSortChar(sys23.EnglishName) as ORMaintenanceDrugNameEN
					, b.ORPersonWorkingGroupNo
					, b.Remarks
			from	HNORREQ_HEADER a 
					inner join HNORREQ_PLAN b on a.FacilityRmsNo = b.FacilityRmsNo and a.RequestNo = b.RequestNo
					left join v_FixHNORReverseType c on b.HNORReverseType = c.FixNORReverseTypeId
					left join HNDOCTOR_MASTER d on b.Doctor = d.Doctor
					left join HNDOCTOR_MASTER d2 on b.Doctor2 = d2.Doctor
					left join DNSYSCONFIG sys01 on sys01.CtrlCode = 42701 and b.AnesNurseCode = sys01.Code

			--		*********************************** ORPreMedicationCode ***********************************
					left join DNSYSCONFIG sys02 on sys02.CtrlCode = 42731 and b.ORPreMedicationCode1 = sys02.Code
					left join DNSYSCONFIG sys03 on sys03.CtrlCode = 42731 and b.ORPreMedicationCode2 = sys03.Code
					left join DNSYSCONFIG sys04 on sys04.CtrlCode = 42731 and b.ORPreMedicationCode3 = sys04.Code

			--		*********************************** ORPreOpProblemCode ***********************************
					left join DNSYSCONFIG sys05 on sys05.CtrlCode = 42825 and b.ORPreOpProblemCode1 = sys05.Code
					left join DNSYSCONFIG sys06 on sys06.CtrlCode = 42825 and b.ORPreOpProblemCode2 = sys06.Code
					left join DNSYSCONFIG sys07 on sys07.CtrlCode = 42825 and b.ORPreOpProblemCode3 = sys07.Code

			--		*********************************** TypeOfAnesthesia ***********************************
					left join DNSYSCONFIG sys08 on sys08.CtrlCode = 42394 and b.TypeOfAnesthesia1 = sys08.Code
					left join DNSYSCONFIG sys09 on sys09.CtrlCode = 42394 and b.TypeOfAnesthesia2 = sys09.Code

			--		*********************************** AnesTechniqueCode ***********************************
					left join DNSYSCONFIG sys10 on sys10.CtrlCode = 42736 and b.AnesTechniqueCode1 = sys10.Code
					left join DNSYSCONFIG sys11 on sys11.CtrlCode = 42736 and b.AnesTechniqueCode2 = sys11.Code
					left join DNSYSCONFIG sys12 on sys12.CtrlCode = 42736 and b.AnesTechniqueCode3 = sys12.Code
					left join DNSYSCONFIG sys13 on sys13.CtrlCode = 42736 and b.AnesTechniqueCode4 = sys13.Code
			--		*********************************** AnesReasonCode ***********************************
					left join DNSYSCONFIG sys14 on sys14.CtrlCode = 42736 and b.AnesReasonCode = sys14.Code

			--		*********************************** ORPostOPComplicationCode ***********************************
					left join DNSYSCONFIG sys15 on sys15.CtrlCode = 42751 and b.ORPostOPComplicationCode1 = sys15.Code
					left join DNSYSCONFIG sys16 on sys16.CtrlCode = 42751 and b.ORPostOPComplicationCode2 = sys16.Code
					left join DNSYSCONFIG sys17 on sys17.CtrlCode = 42751 and b.ORPostOPComplicationCode3 = sys17.Code

			--		*********************************** ORInductionDrugCode ***********************************
					left join DNSYSCONFIG sys18 on sys18.CtrlCode = 42744 and b.ORInductionDrugCode1 = sys18.Code
					left join DNSYSCONFIG sys19 on sys19.CtrlCode = 42744 and b.ORInductionDrugCode2 = sys19.Code
					left join DNSYSCONFIG sys20 on sys20.CtrlCode = 42744 and b.ORInductionDrugCode3 = sys20.Code
					left join DNSYSCONFIG sys21 on sys21.CtrlCode = 42744 and b.ORInductionDrugCode4 = sys21.Code

			--		*********************************** ORIntubationCode ***********************************
					left join DNSYSCONFIG sys22 on sys22.CtrlCode = 42744 and b.ORIntubationCode = sys22.Code

			--		*********************************** ORMaintenanceDrugCode ***********************************
					left join DNSYSCONFIG sys23 on sys23.CtrlCode = 42743 and b.ORMaintenanceDrugCode = sys23.Code

			where	a.ORBeginDateTimePlan between '2025-01-01 00:00:00' and '2025-05-07 23:59:59'
					and b.TypeOfAnesthesia1 is not null
					and b.AnesTechniqueCode1 is not null
		)anes on a.FacilityRmsNo = anes.FacilityRmsNo and a.RequestNo = anes.RequestNo
where	a.ORBeginDateTimePlan between '2025-05-01 00:00:00' and '2025-05-01 23:59:59' and a.CxlByUserCode is not null
order by a.EntryDateTime desc