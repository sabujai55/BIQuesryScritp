select 	bs.site_code as "BU"
		, v.patient_id as "PatientID"
		, v.visit_id as "VisitID"
		, v.visit_date as "VisitDate"
		, format_vn(v.vn) as "VN"
		, ap.attending_physician_id as "PrescriptionNo"	--> 2026-07-30	Change Prescription from fix text "1" to attending_physician_id
		, row_number() over(partition by v.visit_id order by di.diagnosis_icd10_id asc) as "Suffix"	--> 2026-07-30	Change fix text "" to Row_number
		, bd.base_department_id as "ClinicCode"
		, bd.description_th as "ClinicNameTH"
		, bd.description_en as "ClinicNameEN"
		, ap.employee_id as "DoctorCode"	--> 2026-07-30	Add Doctor Prescription
		, e.prename || e.firstname || ' ' || e.lastname as "DoctorNameTH"	--> 2026-07-30	Add Doctor Prescription
		, e.intername as "DoctorNameEN" 	--> 2026-07-30	Add Doctor Prescription
		, di.diagnosis_datetime as "DiagDateTime"
		, di.icd10_code as "PrimaryDiagnosisCode"
		, di.icd10_name as "PrimaryDiagnosisNameTH"
		, '' as "PrimaryDiagnosisNameEN"
		, split_part(di9.icd9_code,'|',1) as "ICDCmCode1"
		, split_part(di9.icd9_name,'|',1) as "ICDCm1NameTH"
		, '' as "ICDCm1NameEN"
		, split_part(di9.icd9_code,'|',2) as "ICDCmCode2"
		, split_part(di9.icd9_name,'|',2) as "ICDCm2NameTH"
		, '' as "ICDCm2NameEN"
		, split_part(di9.icd9_code,'|',3) as "ICDCmCode3"
		, split_part(di9.icd9_name,'|',3) as "ICDCm3NameTH"
		, '' as "ICDCm3NameEN"
		, split_part(di9.icd9_code,'|',4) as "ICDCmCode4"
		, split_part(di9.icd9_name,'|',4) as "ICDCm4NameTH"
		, '' as "ICDCm4NameEN"
		, split_part(di9.icd9_code,'|',5) as "ICDCmCode5"
		, split_part(di9.icd9_name,'|',5) as "ICDCm5NameTH"
		, '' as "ICDCm5NameEN"
		, split_part(di9.icd9_code,'|',6) as "ICDCmCode6"
		, split_part(di9.icd9_name,'|',6) as "ICDCm6NameTH"
		, '' as "ICDCm6NameEN"
		, split_part(di9.icd9_code,'|',7) as "ICDCmCode7"
		, split_part(di9.icd9_name,'|',7) as "ICDCm7NameTH"
		, '' as "ICDCm7NameEN"
		, split_part(di9.icd9_code,'|',8) as "ICDCmCode8"
		, split_part(di9.icd9_name,'|',8) as "ICDCm8NameTH"
		, '' as "ICDCm8NameEN"
		, split_part(di9.icd9_code,'|',9) as "ICDCmCode9"
		, split_part(di9.icd9_name,'|',9) as "ICDCm9NameTH"
		, '' as "ICDCm9NameEN"
		, split_part(di9.icd9_code,'|',10) as "ICDCmCode10"
		, split_part(di9.icd9_name,'|',10) as "ICDCm10NameTH"
		, '' as "ICDCm10NameEN"
		, ap.employee_id as "EntryByUserCode"
		, e.prename || e.firstname || ' ' || e.lastname as "EntryByUserNameTH"
		, e.intername as "EntryByUserNameEN"
		, t.regist_date as "RegisterDate"
		, t.chronic_code as "ChronicCreteriaCode"
		, bcc.description_en as "ChronicCreteriaName" 
		, di.comments as "RemarksMemo"
		, split_part(die.icd10_code,'|',1) as "ECode"
		, split_part(die.icd10_name,'|',1) as "ECodeNameTH"
		, '' as "ECodeNameEN"
		, split_part(dicomo.icd10_code,'|',1) as "ComobidityCode1"
		, split_part(dicomo.icd10_name,'|',1) as "Comobidity1NameTH"
		, '' as "Comobidity1NameEN"
		, split_part(dicomo.icd10_code,'|',2) as "ComobidityCode2"
		, split_part(dicomo.icd10_name,'|',2) as "Comobidity2NameTH"
		, '' as "Comobidity2NameEN"
		, split_part(dicomo.icd10_code,'|',3) as "ComobidityCode3"
		, split_part(dicomo.icd10_name,'|',3) as "Comobidity3NameTH"
		, '' as "Comobidity3NameEN"
		, split_part(dicomo.icd10_code,'|',4) as "ComobidityCode4"
		, split_part(dicomo.icd10_name,'|',4) as "Comobidity4NameTH"
		, '' as "Comobidity4NameEN"
		, split_part(dicomo.icd10_code,'|',5) as "ComobidityCode5"
		, split_part(dicomo.icd10_name,'|',5) as "Comobidity5NameTH"
		, '' as "Comobidity5NameEN"
from 	visit v 
		inner join attending_physician ap on v.visit_id = ap.visit_id 
		inner join base_department bd on ap.base_department_id = bd.base_department_id and bd.account_product = 'COST'
		inner join employee e on ap.employee_id = e.employee_id
		inner join lateral 
		(
			select 	di.diagnosis_icd10_id
					, di.icd10_code
					, di.icd10_description as icd10_name
					, di.diagnosis_date || ' ' || di.diagnosis_time as diagnosis_datetime
					, di.comments
			from  	diagnosis_icd10 di 
			where 	di.visit_id = ap.visit_id 
					and di.doctor_eid = ap.employee_id 
					and di.fix_diagnosis_type_id = '1'
			order by di.diagnosis_date || di.diagnosis_time desc 
			limit 1
		)di on true
		left join lateral
		(
			select 	string_agg(di.icd9_code, '|' order by di.fix_operation_type_id, di.diagnosis_icd9_id asc) as icd9_code
					, string_agg(di.icd9_description, '|' order by di.fix_operation_type_id, di.diagnosis_icd9_id asc) as icd9_name
					, string_agg(di.date_in || ' ' || di.time_in, '|' order by di.fix_operation_type_id, di.diagnosis_icd9_id asc) as in_datetime
					, string_agg(di.date_out || ' ' || di.time_out, '|' order by di.fix_operation_type_id, di.diagnosis_icd9_id asc) as out_datetime
			from  	diagnosis_icd9 di 
			where 	di.visit_id = ap.visit_id 
					and di.doctor_eid = ap.employee_id 
		)di9 on true
		left join lateral 
		(
			select 	string_agg(di.icd10_code, '|' order by di.diagnosis_icd10_id asc) as icd10_code
					, string_agg(di.icd10_description, '|' order by di.diagnosis_icd10_id asc) as icd10_name
			from  	diagnosis_icd10 di 
			where 	di.visit_id = ap.visit_id 
					and di.doctor_eid = ap.employee_id 
					and di.fix_diagnosis_type_id = '5'
		)die on true
		left join lateral 
		(
			select 	string_agg(di.icd10_code, '|' order by di.diagnosis_icd10_id asc) as icd10_code
					, string_agg(di.icd10_description, '|' order by di.diagnosis_icd10_id asc) as icd10_name
			from  	diagnosis_icd10 di 
			where 	di.visit_id = ap.visit_id 
					and di.doctor_eid = ap.employee_id 
					and di.fix_diagnosis_type_id = '2'
		)dicomo on true
		left join personal_illness t on v.patient_id = t.patient_id and di.icd10_code = t.icd10_code
		left join base_chronic_criteria bcc on t.chronic_code = bcc.base_chronic_criteria_id
		, base_site bs
where 	1=1
		and v.visit_date = (current_date-1)::text
order by v.visit_id
		
		
