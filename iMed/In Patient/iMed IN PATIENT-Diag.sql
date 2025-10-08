select 'PLC' as "BU"
, a.patient_id as "PatientID"
, a.admit_id as "AdmitID"
, a.admit_date as "AdmitDate"
, format_an(a.an) as "AN"
--, ROW_NUMBER() OVER (PARTITION BY v.visit_id ORDER BY (v.visit_id) ) as "PrescriptionNo"
, '' as "Suffix"
, bd.base_department_id as "LocationCode"
, bd.description_th as "LocationNameTH"
, bd.description_en as "LocationNameEN"
, di.diagnosis_date ||' '|| di.diagnosis_time as "DiagDateTime"
, di.fix_diagnosis_type_id as "DiagnosisRecordType"
, e2.prename || e2.firstname || ' ' || e2.lastname as "DiagnosisRecordName"
, di.icd10_code as "ICDCode"
, di.icd10_description as "ICDName"
, coalesce(di9_1.icd9_code,'') as "ICDCmCode1"
, coalesce(di9_1.icd9_description,'') as "ICDCmName1"
, coalesce(di9_2.icd9_code,'') as "ICDCmCode2"
, coalesce(di9_2.icd9_description,'') as "ICDCmName2"
, coalesce(di9_3.icd9_code,'') as "ICDCmCode3"
, coalesce(di9_3.icd9_description,'') as "ICDCmName3"
, coalesce(di9_4.icd9_code,'') as "ICDCmCode4"
, coalesce(di9_4.icd9_description,'') as "ICDCmName4"
, coalesce(di9_5.icd9_code,'') as "ICDCmCode5"
, coalesce(di9_5.icd9_description,'') as "ICDCmName5"
, coalesce(di9_6.icd9_code,'') as "ICDCmCode6"
, coalesce(di9_6.icd9_description,'') as "ICDCmName6"
, coalesce(di9_7.icd9_code,'') as "ICDCmCode7"
, coalesce(di9_7.icd9_description,'') as "ICDCmName7"
, coalesce(di9_8.icd9_code,'') as "ICDCmCode8"
, coalesce(di9_8.icd9_description,'') as "ICDCmName8"
, coalesce(di9_9.icd9_code,'') as "ICDCmCode9"
, coalesce(di9_9.icd9_description,'') as "ICDCmName9"
, coalesce(di9_10.icd9_code,'') as "ICDCmCode10"
, coalesce(di9_10.icd9_description,'') as "ICDCmName10"
, di2.modify_eid as "EntryByUserCode"
, e.prename || e.firstname || ' ' || e.lastname as "EntryByUserNameTH"
, e.intername as "EntryByUserNameEN"
, di2.modify_date as "RegisterDate"
, chonic.chronic_code as "ChronicCreteriaCode"
, chonic.description_th as "ChronicCreteriaName"
, '' as "DoctorCode"
, '' as "DoctorNameTH"
, '' as "DoctorNameEN"
, coalesce(ecode.icd10_code,'') as "ECode"
, coalesce(ecode.icd10_description,'') as "ECodeName"
, '' as "RemarksMemo"
, '' as "UnderlyingICDCode1"
, coalesce(udl1.illness_name,'') as "UnderlyingICDName1"
, '' as "UnderlyingICDCode2"
, coalesce(udl2.illness_name,'') as "UnderlyingICDName2"
, '' as "UnderlyingICDCode3"
, coalesce(udl3.illness_name,'') as "UnderlyingICDName3"
, '' as "UnderlyingICDCode4"
, coalesce(udl4.illness_name,'') as "UnderlyingICDName4"
, '' as "UnderlyingICDCode5"
, coalesce(udl5.illness_name,'') as "UnderlyingICDName5"
, coalesce(di10_cpt1.icd10_code,'') as "ComplicationsICDCode1"
, coalesce(di10_cpt1.icd10_description,'') as "ComplicationsICDName1"
, coalesce(di10_cpt2.icd10_code,'') as "ComplicationsICDCode2"
, coalesce(di10_cpt2.icd10_description,'') as "ComplicationsICDName2"
, coalesce(di10_cpt3.icd10_code,'') as "ComplicationsICDCode3"
, coalesce(di10_cpt3.icd10_description,'') as "ComplicationsICDName3"
, coalesce(di10_cpt4.icd10_code,'') as "ComplicationsICDCode4"
, coalesce(di10_cpt4.icd10_description,'') as "ComplicationsICDName4"
, coalesce(di10_cpt5.icd10_code,'') as "ComplicationsICDCode5"
, coalesce(di10_cpt5.icd10_description,'') as "ComplicationsICDName5"
, coalesce(di10_oth1.icd10_code,'') as "OtherICDCode1"
, coalesce(di10_oth1.icd10_description,'') as "OtherICDName1"
, coalesce(di10_oth2.icd10_code,'') as "OtherICDCode2"
, coalesce(di10_oth2.icd10_description,'') as "OtherICDName2"
, coalesce(di10_oth3.icd10_code,'') as "OtherICDCode3"
, coalesce(di10_oth3.icd10_description,'') as "OtherICDName3"
, coalesce(di10_oth4.icd10_code,'') as "OtherICDCode4"
, coalesce(di10_oth4.icd10_description,'') as "OtherICDName4"
, coalesce(opr1.set_doctor_eid ,'') as "OperationDoctorCode1"
, coalesce(opr1.name,'') as "OperationDoctorName1"
, coalesce(opr2.set_doctor_eid ,'') as "OperationDoctorCode2"
, coalesce(opr2.name,'') as "OperationDoctorName2"
, coalesce(opr2.set_doctor_eid ,'') as "OperationDoctorCode3"
, coalesce(opr2.name,'') as "OperationDoctorName3"
, coalesce(opr2.set_doctor_eid ,'') as "OperationDoctorCode4"
, coalesce(opr2.name,'') as "OperationDoctorName4"
, coalesce(opr2.set_doctor_eid ,'') as "OperationDoctorCode5"
, coalesce(opr2.name,'') as "OperationDoctorName5"
, coalesce(opr2.set_doctor_eid ,'') as "OperationDoctorCode6"
, coalesce(opr2.name,'') as "OperationDoctorName6"
, coalesce(opr2.set_doctor_eid ,'') as "OperationDoctorCode7"
, coalesce(opr2.name,'') as "OperationDoctorName7"
, coalesce(opr2.set_doctor_eid ,'') as "OperationDoctorCode8"
, coalesce(opr2.name,'') as "OperationDoctorName8"
, coalesce(opr2.set_doctor_eid ,'') as "OperationDoctorCode9"
, coalesce(opr2.name,'') as "OperationDoctorName9"
, coalesce(opr2.set_doctor_eid ,'') as "OperationDoctorCode10"
, coalesce(opr2.name,'') as "OperationDoctorName10"
from admit a 
left join base_department bd on bd.base_department_id = a.base_department_id 
left join diagnosis_icd10 di on di.visit_id = a.visit_id 
left join diagnosis_icd9 di2 on di2.visit_id = a.visit_id
left join employee e2 on e2.employee_id = di.doctor_eid 
left join employee e on e.employee_id = di2.modify_eid
left join patient p on p.patient_id = a.patient_id
left join op_set os on os.patient_id = p.patient_id
left join
	(
		select 	row_number() over(partition by v.visit_id order by di9_1.diagnosis_icd9_id asc) as "row"
				, v.visit_id
				, di9_1.icd9_code
				, di9_1.icd9_description
		from 	visit v 
		inner join diagnosis_icd9 di9_1 on v.visit_id = di9_1.visit_id
	)di9_1 on di9_1.visit_id = a.visit_id and di9_1."row" = 1
left join
	(
		select 	row_number() over(partition by v.visit_id order by di9_2.diagnosis_icd9_id asc) as "row"
				, v.visit_id
				, di9_2.icd9_code
				, di9_2.icd9_description
		from 	visit v 
		inner join diagnosis_icd9 di9_2 on v.visit_id = di9_2.visit_id
	)di9_2 on di9_2.visit_id = a.visit_id and di9_2."row" = 2
left join
	(
		select 	row_number() over(partition by v.visit_id order by di9_3.diagnosis_icd9_id asc) as "row"
				, v.visit_id
				, di9_3.icd9_code
				, di9_3.icd9_description
		from 	visit v 
		inner join diagnosis_icd9 di9_3 on v.visit_id = di9_3.visit_id
	)di9_3 on di9_3.visit_id = a.visit_id and di9_3."row" = 3
left join
	(
		select 	row_number() over(partition by v.visit_id order by di9_4.diagnosis_icd9_id asc) as "row"
				, v.visit_id
				, di9_4.icd9_code
				, di9_4.icd9_description
		from 	visit v 
		inner join diagnosis_icd9 di9_4 on v.visit_id = di9_4.visit_id
	)di9_4 on di9_4.visit_id = a.visit_id and di9_4."row" = 4
left join
	(
		select 	row_number() over(partition by v.visit_id order by di9_5.diagnosis_icd9_id asc) as "row"
				, v.visit_id
				, di9_5.icd9_code
				, di9_5.icd9_description
		from 	visit v 
		inner join diagnosis_icd9 di9_5 on v.visit_id = di9_5.visit_id
	)di9_5 on di9_5.visit_id = a.visit_id and di9_5."row" = 5
left join
	(
		select 	row_number() over(partition by v.visit_id order by di9_6.diagnosis_icd9_id asc) as "row"
				, v.visit_id
				, di9_6.icd9_code
				, di9_6.icd9_description
		from 	visit v 
		inner join diagnosis_icd9 di9_6 on v.visit_id = di9_6.visit_id
	)di9_6 on di9_6.visit_id = a.visit_id and di9_6."row" = 6
left join
	(
		select 	row_number() over(partition by v.visit_id order by di9_7.diagnosis_icd9_id asc) as "row"
				, v.visit_id
				, di9_7.icd9_code
				, di9_7.icd9_description
		from 	visit v 
		inner join diagnosis_icd9 di9_7 on v.visit_id = di9_7.visit_id
	)di9_7 on di9_7.visit_id = a.visit_id and di9_7."row" = 7
left join
	(
		select 	row_number() over(partition by v.visit_id order by di9_8.diagnosis_icd9_id asc) as "row"
				, v.visit_id
				, di9_8.icd9_code
				, di9_8.icd9_description
		from 	visit v 
		inner join diagnosis_icd9 di9_8 on v.visit_id = di9_8.visit_id
	)di9_8 on di9_8.visit_id = a.visit_id and di9_8."row" = 8
left join
	(
		select 	row_number() over(partition by v.visit_id order by di9_9.diagnosis_icd9_id asc) as "row"
				, v.visit_id
				, di9_9.icd9_code
				, di9_9.icd9_description
		from 	visit v 
		inner join diagnosis_icd9 di9_9 on v.visit_id = di9_9.visit_id
	)di9_9 on di9_9.visit_id = a.visit_id and di9_9."row" = 9
left join
	(
		select 	row_number() over(partition by v.visit_id order by di9_10.diagnosis_icd9_id asc) as "row"
				, v.visit_id
				, di9_10.icd9_code
				, di9_10.icd9_description
		from 	visit v 
		inner join diagnosis_icd9 di9_10 on v.visit_id = di9_10.visit_id
	)di9_10 on di9_10.visit_id = a.visit_id and di9_10."row" = 10
left join
	(
		select 	row_number() over(partition by pi2.patient_id order by pi2.modify_date || pi2.modify_time asc) as "row"
				, pi2.patient_id 
				, pi2.personal_illness_id 
				, pi2.chronic_code
				, bcc.description_th 
		from 	personal_illness pi2 
		left join base_chronic_criteria bcc on bcc.base_chronic_criteria_id = pi2.chronic_code
	)chonic on chonic.patient_id = p.patient_id and chonic."row" = 1
left join
    (
    	select   a.visit_id
                 , c.icd10_code
                 , c.icd10_description
        from      visit a inner join attending_physician b on b.priority = '1' and a.visit_id = b.visit_id
        inner join diagnosis_icd10 c on c.fix_diagnosis_type_id = '5' and c.icd10_code <> '' and a.visit_id = c.visit_id
    )ecode on a.visit_id = ecode.visit_id	
left join
	(
		select 	row_number() over(partition by pi2.patient_id order by pi2.modify_date || pi2.modify_time asc) as "row"
				, pi2.patient_id 
				, pi2.personal_illness_id 
				, pi2.illness_name
				, pi2.chronic_code
		from 	personal_illness pi2 
	)udl1 on udl1.patient_id = p.patient_id and udl1."row" = 1
left join
	(
		select 	row_number() over(partition by pi2.patient_id order by pi2.modify_date || pi2.modify_time asc) as "row"
				, pi2.patient_id 
				, pi2.personal_illness_id 
				, pi2.illness_name
				, pi2.chronic_code
		from 	personal_illness pi2 
	)udl2 on udl2.patient_id = p.patient_id and udl2."row" = 2
left join
	(
		select 	row_number() over(partition by pi2.patient_id order by pi2.modify_date || pi2.modify_time asc) as "row"
				, pi2.patient_id 
				, pi2.personal_illness_id 
				, pi2.illness_name
				, pi2.chronic_code
		from 	personal_illness pi2 
	)udl3 on udl3.patient_id = p.patient_id and udl3."row" = 3
left join
	(
		select 	row_number() over(partition by pi2.patient_id order by pi2.modify_date || pi2.modify_time asc) as "row"
				, pi2.patient_id 
				, pi2.personal_illness_id 
				, pi2.illness_name
				, pi2.chronic_code
		from 	personal_illness pi2 
	)udl4 on udl4.patient_id = p.patient_id and udl4."row" = 4
left join
	(
		select 	row_number() over(partition by pi2.patient_id order by pi2.modify_date || pi2.modify_time asc) as "row"
				, pi2.patient_id 
				, pi2.personal_illness_id 
				, pi2.illness_name
				, pi2.chronic_code
		from 	personal_illness pi2 
	)udl5 on udl5.patient_id = p.patient_id and udl5."row" = 5
left join
	(
		select 	row_number() over(partition by v.visit_id order by di10_cpt1.diagnosis_icd10_id asc) as "row"
				, v.visit_id
				, di10_cpt1.icd10_code
				, di10_cpt1.icd10_description
		from 	visit v 
		inner join diagnosis_icd10 di10_cpt1 on v.visit_id = di10_cpt1.visit_id and di10_cpt1.fix_diagnosis_type_id = '3'
	)di10_cpt1 on di10_cpt1.visit_id = a.visit_id and di10_cpt1."row" = 1
left join
	(
		select 	row_number() over(partition by v.visit_id order by di10_cpt2.diagnosis_icd10_id asc) as "row"
				, v.visit_id
				, di10_cpt2.icd10_code
				, di10_cpt2.icd10_description
		from 	visit v 
		inner join diagnosis_icd10 di10_cpt2 on v.visit_id = di10_cpt2.visit_id and di10_cpt2.fix_diagnosis_type_id = '3'
	)di10_cpt2 on di10_cpt2.visit_id = a.visit_id and di10_cpt2."row" = 2
left join
	(
		select 	row_number() over(partition by v.visit_id order by di10_cpt3.diagnosis_icd10_id asc) as "row"
				, v.visit_id
				, di10_cpt3.icd10_code
				, di10_cpt3.icd10_description
		from 	visit v 
		inner join diagnosis_icd10 di10_cpt3 on v.visit_id = di10_cpt3.visit_id and di10_cpt3.fix_diagnosis_type_id = '3'
	)di10_cpt3 on di10_cpt3.visit_id = a.visit_id and di10_cpt3."row" = 3
left join
	(
		select 	row_number() over(partition by v.visit_id order by di10_cpt4.diagnosis_icd10_id asc) as "row"
				, v.visit_id
				, di10_cpt4.icd10_code
				, di10_cpt4.icd10_description
		from 	visit v 
		inner join diagnosis_icd10 di10_cpt4 on v.visit_id = di10_cpt4.visit_id and di10_cpt4.fix_diagnosis_type_id = '3'
	)di10_cpt4 on di10_cpt4.visit_id = a.visit_id and di10_cpt4."row" = 4
left join
	(
		select 	row_number() over(partition by v.visit_id order by di10_cpt5.diagnosis_icd10_id asc) as "row"
				, v.visit_id
				, di10_cpt5.icd10_code
				, di10_cpt5.icd10_description
		from 	visit v 
		inner join diagnosis_icd10 di10_cpt5 on v.visit_id = di10_cpt5.visit_id and di10_cpt5.fix_diagnosis_type_id = '3'
	)di10_cpt5 on di10_cpt5.visit_id = a.visit_id and di10_cpt5."row" = 5
left join
	(
		select 	row_number() over(partition by v.visit_id order by di10_oth1.diagnosis_icd10_id asc) as "row"
				, v.visit_id
				, di10_oth1.icd10_code
				, di10_oth1.icd10_description
		from 	visit v 
		inner join diagnosis_icd10 di10_oth1 on v.visit_id = di10_oth1.visit_id and di10_oth1.fix_diagnosis_type_id = '4'
	)di10_oth1 on di10_oth1.visit_id = a.visit_id and di10_oth1."row" = 1
left join
	(
		select 	row_number() over(partition by v.visit_id order by di10_oth2.diagnosis_icd10_id asc) as "row"
				, v.visit_id
				, di10_oth2.icd10_code
				, di10_oth2.icd10_description
		from 	visit v 
		inner join diagnosis_icd10 di10_oth2 on v.visit_id = di10_oth2.visit_id and di10_oth2.fix_diagnosis_type_id = '4'
	)di10_oth2 on di10_oth2.visit_id = a.visit_id and di10_oth1."row" = 2
left join
	(
		select 	row_number() over(partition by v.visit_id order by di10_oth3.diagnosis_icd10_id asc) as "row"
				, v.visit_id
				, di10_oth3.icd10_code
				, di10_oth3.icd10_description
		from 	visit v 
		inner join diagnosis_icd10 di10_oth3 on v.visit_id = di10_oth3.visit_id and di10_oth3.fix_diagnosis_type_id = '4'
	)di10_oth3 on di10_oth3.visit_id = a.visit_id and di10_oth3."row" = 3
left join
	(
		select 	row_number() over(partition by v.visit_id order by di10_oth4.diagnosis_icd10_id asc) as "row"
				, v.visit_id
				, di10_oth4.icd10_code
				, di10_oth4.icd10_description
		from 	visit v 
		inner join diagnosis_icd10 di10_oth4 on v.visit_id = di10_oth4.visit_id and di10_oth4.fix_diagnosis_type_id = '4'
	)di10_oth4 on di10_oth4.visit_id = a.visit_id and di10_oth4."row" = 4
left join
	(
		select 	row_number() over(partition by os2.patient_id order by os2.set_date || os2.set_time  asc) as "row"
				, os2.set_doctor_eid 
				, os2.patient_id 
				, e3.prename || e3.firstname || ' ' || e3.lastname as "name"
		from 	op_set os2 
		left join employee e3 on e3.employee_code = os2.set_doctor_eid
	)opr1 on opr1.patient_id = p.patient_id and opr1."row" = 1
left join
	(
		select 	row_number() over(partition by os2.patient_id order by os2.set_date || os2.set_time  asc) as "row"
				, os2.set_doctor_eid 
				, os2.patient_id 
				, e3.prename || e3.firstname || ' ' || e3.lastname as "name"
		from 	op_set os2 
		left join employee e3 on e3.employee_code = os2.set_doctor_eid
	)opr2 on opr2.patient_id = p.patient_id and opr2."row" = 2
left join
	(
		select 	row_number() over(partition by os2.patient_id order by os2.set_date || os2.set_time  asc) as "row"
				, os2.set_doctor_eid 
				, os2.patient_id 
				, e3.prename || e3.firstname || ' ' || e3.lastname as "name"
		from 	op_set os2 
		left join employee e3 on e3.employee_code = os2.set_doctor_eid
	)opr3 on opr3.patient_id = p.patient_id and opr3."row" = 3
left join
	(
		select 	row_number() over(partition by os2.patient_id order by os2.set_date || os2.set_time  asc) as "row"
				, os2.set_doctor_eid 
				, os2.patient_id 
				, e3.prename || e3.firstname || ' ' || e3.lastname as "name"
		from 	op_set os2 
		left join employee e3 on e3.employee_code = os2.set_doctor_eid
	)opr4 on opr4.patient_id = p.patient_id and opr4."row" = 4
left join
	(
		select 	row_number() over(partition by os2.patient_id order by os2.set_date || os2.set_time  asc) as "row"
				, os2.set_doctor_eid 
				, os2.patient_id 
				, e3.prename || e3.firstname || ' ' || e3.lastname as "name"
		from 	op_set os2 
		left join employee e3 on e3.employee_code = os2.set_doctor_eid
	)opr5 on opr5.patient_id = p.patient_id and opr5."row" = 5
left join
	(
		select 	row_number() over(partition by os2.patient_id order by os2.set_date || os2.set_time  asc) as "row"
				, os2.set_doctor_eid 
				, os2.patient_id 
				, e3.prename || e3.firstname || ' ' || e3.lastname as "name"
		from 	op_set os2 
		left join employee e3 on e3.employee_code = os2.set_doctor_eid
	)opr6 on opr6.patient_id = p.patient_id and opr6."row" =6
left join
	(
		select 	row_number() over(partition by os2.patient_id order by os2.set_date || os2.set_time  asc) as "row"
				, os2.set_doctor_eid 
				, os2.patient_id 
				, e3.prename || e3.firstname || ' ' || e3.lastname as "name"
		from 	op_set os2 
		left join employee e3 on e3.employee_code = os2.set_doctor_eid
	)opr7 on opr7.patient_id = p.patient_id and opr7."row" = 7
left join
	(
		select 	row_number() over(partition by os2.patient_id order by os2.set_date || os2.set_time  asc) as "row"
				, os2.set_doctor_eid 
				, os2.patient_id 
				, e3.prename || e3.firstname || ' ' || e3.lastname as "name"
		from 	op_set os2 
		left join employee e3 on e3.employee_code = os2.set_doctor_eid
	)opr8 on opr8.patient_id = p.patient_id and opr8."row" = 8
left join
	(
		select 	row_number() over(partition by os2.patient_id order by os2.set_date || os2.set_time  asc) as "row"
				, os2.set_doctor_eid 
				, os2.patient_id 
				, e3.prename || e3.firstname || ' ' || e3.lastname as "name"
		from 	op_set os2 
		left join employee e3 on e3.employee_code = os2.set_doctor_eid
	)opr9 on opr9.patient_id = p.patient_id and opr9."row" = 9
left join
	(
		select 	row_number() over(partition by os2.patient_id order by os2.set_date || os2.set_time  asc) as "row"
				, os2.set_doctor_eid 
				, os2.patient_id 
				, e3.prename || e3.firstname || ' ' || e3.lastname as "name"
		from 	op_set os2 
		left join employee e3 on e3.employee_code = os2.set_doctor_eid
	)opr10 on opr10.patient_id = p.patient_id and opr10."row" = 10
--where format_an(a.an) = 'O16-680226-0181'
--where a.admit_id = '124061413513234501'
--limit 10