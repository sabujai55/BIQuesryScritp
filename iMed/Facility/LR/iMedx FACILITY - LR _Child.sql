



select 
'PLC'as "BU"
, p.patient_id as "PatientID"
, '' as "FacilityRmsNo"
, '' as "RequestNo"
, ln2.fix_infant_status 
, format_an(a.an) as "AN"
, a.admit_date
, ln2.infant_date
, '' as "HNBedNo"
, '' as "HNBedNameTH"
, '' as "HNBedNameEN"
, bm.base_service_point_id as "Ward"
, bsp.description as "WardNameTH"
, bsp.description as "WardNameEN"
, '' as "AdmCode"
, '' as "AdmNameTH"
, '' as "AdmNameEN"
, a.admit_doctor_eid as "AdmDoctor"
, imed_get_employee_name(a.admit_doctor_eid) as "AdmDoctorNameTH"
, imed_get_employee_name_en(a.admit_doctor_eid) as "AdmDoctorNameEN"
, vp.base_plan_group_id as "PatientType"
, bpg.description as "PatientTypeNameTH"
, bpg.description as "PatientTypeNameEN"
, p2.plan_code as "RightCode"
, p2.description as "RightNameTH"
, p2.description as "RightNameEN"
, p.fix_nationality_id as "NationalityCode"
, fn.description as "NationalityNameTH"
, fn.description as "NationalityNameEN"
, p.fix_race_id as "RaceCode"
, fr.description as "RaceNameTH"
, fr.description as "RaceNameEN"
, '' as "BornOrder"
, p.fix_gender_id as "Gender"
, '' as "GenderNameTH"
, fg.gender_name as "GenderNameEN"   
, p.prename||''||p.firstname as "FirstThaiName"
, p.lastname as "LastThaiName"
, p.intername as "FirstEnglishName"  --รวมกับนามสกุล
, '' as "LastEnglishName"
, p.birthdate as "BirthDateTime"
, d.death_date ||' '|| d.death_time as "DeadDateTime"
, '' as "LRAliveCode"
, '' as "LRAliveNameTH"
, '' as "LRAliveNameEN"
, '' as "LRMode"
, '' as "LRModeNameTH" 
, '' as "LRModeNameEN"
, '' as "IndicationCode1"
, '' as "IndicationNameTH1"
, '' as "IndicationNameEN1"
, '' as "IndicationCode2"
, '' as "IndicationNameTH2"
, '' as "IndicationNameEN2"
, '' as "IndicationCode3"
, '' as "IndicationNameTH3"
, '' as "IndicationNameEN3"
, '' as "NoGADay"
, ln2.weight as "WeightGm"
, ln2.body_length as "LengthCm"
, '' as "Temperature"
, '' as "Temperature2"
, '' as "HNLRExpireType"
, '' as "MentoOccipital"
, ln2.chest_length as "ChestCm"
, '' as "ApgarScoreOneMinute"
, '' as "ApgarScoreThreeMinute"
, '' as "ApgarScoreFiveMinute"
, '' as "ApgarScoreTenMinute"
, '' as "LRNewBornResultCode"
, '' as "LRNewBornResultNameTH"
, '' as "LRNewBornResultNameEN"
, '' as "LRNewBornResultCode2"
, '' as "LRNewBornResultNameTH2"
, '' as "LRNewBornResultNameEN2"
, '' as "LRNewBornResultCode3"
, '' as "LRNewBornResultNameTH3"
, '' as "LRNewBornResultNameEN3"
, '' as "LRMedicationCode1"
, '' as "LRMedicationNameTH1"
, '' as "LRMedicationNameEN1"
, '' as "LRMedicationCode2"
, '' as "LRMedicationNameTH2"
, '' as "LRMedicationNameEN2"
, '' as "IndicationOfOperation1"
, '' as "IndicationOfOperationNameTH1"
, '' as "IndicationOfOperationNameEN1"
, '' as "IndicationOfOperation2"
, '' as "IndicationOfOperationNameTH2"
, '' as "IndicationOfOperationNameEN2"
, '' as "AbnormalOnChildCode1"
, '' as "AbnormalOnChildNameTH1"
, '' as "AbnormalOnChildNameEN1"
, '' as "AbnormalOnChildCode2"
, '' as "AbnormalOnChildNameTH2"
, '' as "AbnormalOnChildNameEN2"
from lr_newborn ln2 
inner join patient p on p.patient_id = ln2.patient_id 
left join fix_gender fg on fg.fix_gender_id = p.fix_gender_id
left join fix_nationality fn on fn.fix_nationality_id = p.fix_nationality_id
left join admit a on a.patient_id = p.patient_id
left join visit_payment vp on vp.visit_id = a.visit_id --and vp.priority = '1'
left join base_plan_group bpg on bpg.base_plan_group_id = vp.base_plan_group_id
left join death d on d.patient_id = p.patient_id
left join fix_race fr on fr.fix_race_id = p.fix_race_id
left join bed_management bm on bm.admit_id = a.admit_id
left join base_service_point bsp on bsp.base_service_point_id = bm.base_service_point_id
left join plan p2 on p2.plan_id = vp.plan_id
where ln2.infant_date BETWEEN '$P!{dBeginDate}' AND '$P!{dEndDate}'
and ln2.infant_date = a.admit_date





