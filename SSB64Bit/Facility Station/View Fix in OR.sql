use SSBLIVE
go

create view v_FixORCaseType as
(
	select 0 as FixORCaseTypeId, 'None' as [Description]
	union all 
	select 1 as FixORCaseTypeId, 'Emergency' as [Description]
	union all 
	select 2 as FixORCaseTypeId, 'Urgency' as [Description]
	union all 
	select 3 as FixORCaseTypeId, 'Elective' as [Description]
);

create view v_FixORVisitType as
(
	select 0 as FixORVisitTypeId, 'None' as [Description]
	union all 
	select 1 as FixORVisitTypeId, 'OPD' as [Description]
	union all 
	select 2 as FixORVisitTypeId, 'IPD' as [Description]
	union all 
	select 3 as FixORVisitTypeId, 'OPD_Admit_After_Surgery' as [Description]
	union all 
	select 4 as FixORVisitTypeId, 'OPD_Admit_By_Complication' as [Description]
);

create view v_FixORWithAnesType as
(
	select 0 as FixORWithAnesTypeId, 'None' as [Description]
	union all 
	select 1 as FixORWithAnesTypeId, 'OR_Only' as [Description]
	union all 
	select 2 as FixORWithAnesTypeId, 'Anes_Only' as [Description]
	union all 
	select 3 as FixORWithAnesTypeId, 'OR_Anes' as [Description]
	union all 
	select 4 as FixORWithAnesTypeId, 'OR_Anes_With_Surgeon_Contact' as [Description]
	union all 
	select 5 as FixORWithAnesTypeId, 'OR_Anes_With_OR_Contact' as [Description]
);

create view v_FixHNORReverseType as
(
	select 0 as FixNORReverseTypeId, 'None' as [Description]
	union all 
	select 1 as FixNORReverseTypeId, 'Yes' as [Description]
	union all 
	select 2 as FixNORReverseTypeId, 'No' as [Description]
	union all 
	select 3 as FixNORReverseTypeId, 'Re_Reserve' as [Description]
);

create view v_FixHNWoundType as
(
	select 0 as FixHNWoundTypeId, 'None' as [Description]
	union all 
	select 1 as FixHNWoundTypeId, 'Clean' as [Description]
	union all 
	select 2 as FixHNWoundTypeId, 'Clean_Contamination' as [Description]
	union all 
	select 3 as FixHNWoundTypeId, 'Contamination' as [Description]
	union all 
	select 4 as FixHNWoundTypeId, 'Dirty' as [Description]
);


create view v_FixHNORPersonType as
(
	select 0 as FixHNORPersonTypeId, 'None' as [Description]
	union all 
	select 1 as FixHNORPersonTypeId, 'Instrument_Nurse' as [Description]
	union all 
	select 2 as FixHNORPersonTypeId, 'Scrub_Nurse' as [Description]
	union all 
	select 3 as FixHNORPersonTypeId, 'Circulate_Nurse' as [Description]
	union all 
	select 4 as FixHNORPersonTypeId, 'Anesthesiologist' as [Description]
	union all 
	select 5 as FixHNORPersonTypeId, 'Surgeon' as [Description]
	union all 
	select 6 as FixHNORPersonTypeId, 'Assistant_Nurse' as [Description]
	union all 
	select 7 as FixHNORPersonTypeId, 'Perfusionist' as [Description]
	union all 
	select 8 as FixHNORPersonTypeId, 'Swab_Nurse' as [Description]
	union all 
	select 9 as FixHNORPersonTypeId, 'Nurse_Anesthetist' as [Description]
	union all 
	select 10 as FixHNORPersonTypeId, 'Assistant_Surgeon' as [Description]
	union all 
	select 11 as FixHNORPersonTypeId, 'Surgeon_Nurse' as [Description]
);

create view v_FixHNORVisitLocation as
(
	select 0 as FixHNORVisitLocationId, 'None' as [Description]
	union all 
	select 1 as FixHNORVisitLocationId, 'Ward' as [Description]
	union all 
	select 2 as FixHNORVisitLocationId, 'OR' as [Description]
	union all 
	select 3 as FixHNORVisitLocationId, 'ICU' as [Description]
	union all 
	select 4 as FixHNORVisitLocationId, 'ER' as [Description]
	union all 
	select 5 as FixHNORVisitLocationId, 'RR' as [Description]
	union all 
	select 6 as FixHNORVisitLocationId, 'Prep' as [Description]
	union all 
	select 7 as FixHNORVisitLocationId, 'CCU' as [Description]
	union all 
	select 8 as FixHNORVisitLocationId, 'OPD' as [Description]
);

select * from DNSYSCONFIG where Code = '535425'