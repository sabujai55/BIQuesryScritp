


select 
'PLC' as "BU" 
, v.patient_id as "PatientID"
, '' as "FacilityRmsNo"
, '' as "RequestNo"
, di.diagnosis_date ||' '|| di.diagnosis_time as "DiagDateTime"
, di.icd10_code as "PTDiagCode"
, di.icd10_description as "PTDiagNameTH"
, di.icd10_description as "PTDiagNameEN"
, '' as "PTSystemCode"
, '' as "PTSystemNameTH"
, '' as "PTSystemNameEN"
, '' as "PTStopReasonCode"
, '' as "PTStopReasonNameTH"
, '' as "PTStopReasonNameEN"
, '' as "OrganCode1"
, '' as "OrganNameTH1"
, '' as "OrganNameEN1"
, '' as "OrganCode2"
, '' as "OrganNameTH2"
, '' as "OrganNameEN2"
, '' as "OrganCode3"
, '' as "OrganNameTH3"
, '' as "OrganNameEN3"
, '' as "OrganPosition1"
, '' as "OrganPositionNameTH1"
, '' as "OrganPositionNameEN1"
, '' as "OrganPosition2"
, '' as "OrganPositionNameTH2"
, '' as "OrganPositionNameEN2"
, '' as "OrganPosition3"
, '' as "OrganPositionNameTH3"
, '' as "OrganPositionNameEN3"
, '' as "EntryDateTime"
, ap.employee_id as "PTTherapistCode"
, imed_get_employee_name(ap.employee_id) as "PTTherapistNameTH"
, imed_get_employee_name_en(ap.employee_id) as "PTTherapistNameEN"
, '' as "RefToHospital"
, '' as "RefToHospitalNameTH"
, '' as "RefToHospitalNameEN"
, '' as "RefToCode"
, '' as "RefToNameTH"
, '' as "RefToNameEN"
, '' as "RefToRefNo"
, '' as "FollowUp"
, '' as "FacilityResultType"
, '' as "HNPTTreatmentType"
, '' as "HNPTStatusType"
, case when v.fix_visit_type_id = '0' then 'OPD' else 'IPD' end as "IpdOpdType"
, '' as "RemarksMemo"
, di2.icd9_code as "ICDCmCode"
, di2.icd9_description as "ICDCmNameTH"
, di2.icd9_description as "ICDCmNameEN"
from visit v
left join visit_queue vq on vq.visit_id = v.visit_id 
left join base_service_point bsp on bsp.base_service_point_id = vq.next_location_spid
left join attending_physician ap on ap.visit_id = v.visit_id and ap.base_department_id like '2701%'
left join diagnosis_icd10 di on di.visit_id = v.visit_id and di.base_clinic_id like '2701%'
left join diagnosis_icd9 di2 on di2.visit_id = v.visit_id and di2.base_clinic_id like '2701%'
left join attending_physicial_discharge apd on apd.visit_id = v.visit_id
WHERE bsp.base_department_id like '2701%' 
AND v.active = '1'
and v.visit_date BETWEEN '$P!{dBeginDate}' AND '$P!{dEndDate}'
ORDER BY v.visit_date, v.hn


