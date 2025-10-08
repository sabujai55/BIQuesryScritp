select 'PLR' as "BU"
, or2.op_registered_id 
, p.patient_id as "PatientID"
, os.or_location_id as "FacilityRmsNo"
, or2.or_number as "RequestNo"
, '1' as "SuffixTiny"
, icd_1.icd10_code as "ICDCode1"
, icd_1.diagnosis_name as "ICDNameTH1"
, '' as "ICDNameEN1"
, icd_2.icd10_code as "ICDCode2"
, icd_2.diagnosis_name as "ICDNameTH2"
, '' as "ICDNameEN2"
, '' as "OrganCode"
, '' as "OrganNameTH"
, '' as "OrganNameEN"
, os.set_doctor_eid as "Doctor"
, e.prename || e.firstname ||' '|| e.lastname as "DoctorNameTH"
, e.intername as "DoctorNameEN"
, icdm_1.icd9_code as "ICDCmCode1"
, icdm_1.operation_name as "ICDCMNameTH1"
, '' as "ICDCMNameEN1"
, icdm_2.icd9_code as "ICDCmCode2"
, icdm_2.operation_name as "ICDCMNameTH2"
, '' as "ICDCMNameEN2"
, icdm_3.icd9_code as "ICDCmCode3"
, icdm_3.operation_name as "ICDCMNameTH3"
, '' as "ICDCMNameEN3"
, icdm_4.icd9_code as "ICDCmCode4"
, icdm_4.operation_name as "ICDCMNameTH4"
, '' as "ICDCMNameEN4"
, or2.base_op_clinic_id as "ORSpecialty"
, boc.description as "ORSpecialtyNameTH"
, '' as "ORSpecialtyNameEN"
, '' as "HNOREndoscopeType"
, oor.record_date ||' '|| oor.record_time as "ConfirmDoctorDateTime"
, '' as "DiagDateTime"
, or2.start_date ||' '|| or2.start_time as "ORStartDateTime"
, or2.finish_date ||' '|| or2.finish_time  as "ORFinishDateTime"
--, or2.base_op_wound_id
, bow.description as "HNWoundType"
, '' as "Memo"
from op_registered or2 
left join op_set os on os.op_registered_id = or2.op_registered_id
left join patient p on p.patient_id = or2.patient_id
left join base_op_wound bow on bow.base_op_wound_id = or2.base_op_wound_id
left join base_op_clinic boc on boc.base_op_clinic_id = or2.base_op_clinic_id
left join op_operation_result oor on oor.op_registered_id = or2.op_registered_id
left join employee e on e.employee_id = os.set_doctor_eid
left join 
	(select ROW_NUMBER() OVER (PARTITION BY ord.op_registered_id ORDER BY (ord.op_registered_diagnosis_id)asc) as seq
		, ord.op_registered_id 
		, ord.icd10_code 
		, ord.diagnosis_name 
	from op_registered_diagnosis ord) icd_1 on or2.op_registered_id = icd_1.op_registered_id and icd_1.seq = 1
left join 
	(select ROW_NUMBER() OVER (PARTITION BY ord.op_registered_id ORDER BY (ord.op_registered_diagnosis_id)asc) as seq
		, ord.op_registered_id 
		, ord.icd10_code 
		, ord.diagnosis_name 
	from op_registered_diagnosis ord) icd_2 on or2.op_registered_id = icd_2.op_registered_id and icd_2.seq = 2
left join 
	(select ROW_NUMBER() OVER (PARTITION BY oro.op_registered_id ORDER BY (oro.op_registered_operation_id)asc) as seq
		, oro.op_registered_id 
		, oro.icd9_code 
		, oro.operation_name 
	from op_registered_operation oro) icdm_1 on or2.op_registered_id = icdm_1.op_registered_id and icdm_1.seq = 1
left join 
	(select ROW_NUMBER() OVER (PARTITION BY oro.op_registered_id ORDER BY (oro.op_registered_operation_id)asc) as seq
		, oro.op_registered_id 
		, oro.icd9_code 
		, oro.operation_name 
	from op_registered_operation oro) icdm_2 on or2.op_registered_id = icdm_2.op_registered_id and icdm_2.seq = 2
left join 
	(select ROW_NUMBER() OVER (PARTITION BY oro.op_registered_id ORDER BY (oro.op_registered_operation_id)asc) as seq
		, oro.op_registered_id 
		, oro.icd9_code 
		, oro.operation_name 
	from op_registered_operation oro) icdm_3 on or2.op_registered_id = icdm_3.op_registered_id and icdm_3.seq = 3
left join 
	(select ROW_NUMBER() OVER (PARTITION BY oro.op_registered_id ORDER BY (oro.op_registered_operation_id)asc) as seq
		, oro.op_registered_id 
		, oro.icd9_code 
		, oro.operation_name 
	from op_registered_operation oro) icdm_4 on or2.op_registered_id = icdm_4.op_registered_id and icdm_4.seq = 4
where or2.registered_date between '$P!{dBeginDate}' and '$P!{dEndDate}'
--where or2.op_registered_id = '520092812554081401'





