select 'PLC' as "BU"
, v.patient_id as "PatientID"
, v.visit_id as "VisitID"
, v.visit_date as "VisitDate"
, format_vn(v.vn) as "VN"
, ROW_NUMBER() OVER (PARTITION BY v.visit_id ORDER BY (v.visit_id) ) as "PrescriptionNo"
, '' as "Suffix"
--���
, bd.base_department_id as "ClinicCode"
, bd.description_th as "ClinicNameTH"
, bd.description_en as "ClinicNameEN"
--
, di.diagnosis_date ||' '|| di.diagnosis_time as "DiagDateTime"
--��
, di.icd10_code as "PrimaryCode"
, di.icd10_description as "PrimaryNameTH"
, '' as "PrimaryNameEN"
--
--����
, coalesce(di9_1.icd9_code,'') as "ICDCmCode1"
, coalesce(di9_1.icd9_description,'') as "ICDCm1NameTH"
, '' as "ICDCm1NameEN"
, coalesce(di9_2.icd9_code,'') as "ICDCmCode2"
, coalesce(di9_2.icd9_description,'') as "ICDCm2NameTH"
, '' as "ICDCm2NameEN"
, coalesce(di9_3.icd9_code,'') as "ICDCmCode3"
, coalesce(di9_3.icd9_description,'') as "ICDCm3NameTH"
, '' as "ICDCm3NameEN"
, coalesce(di9_4.icd9_code,'') as "ICDCmCode4"
, coalesce(di9_4.icd9_description,'') as "ICDCm4NameTH"
, '' as "ICDCm4NameEN"
, coalesce(di9_5.icd9_code,'') as "ICDCmCode5"
, coalesce(di9_5.icd9_description,'') as "ICDCm5NameTH"
, '' as "ICDCm5NameEN"
, coalesce(di9_6.icd9_code,'') as "ICDCmCode6"
, coalesce(di9_6.icd9_description,'') as "ICDCm6NameTH"
, '' as "ICDCm6NameEN"
, coalesce(di9_7.icd9_code,'') as "ICDCmCode7"
, coalesce(di9_7.icd9_description,'') as "ICDCm7NameTH"
, '' as "ICDCm7NameEN"
, coalesce(di9_8.icd9_code,'') as "ICDCmCode8"
, coalesce(di9_8.icd9_description,'') as "ICDCm8NameTH"
, '' as "ICDCm8NameEN"
, coalesce(di9_9.icd9_code,'') as "ICDCmCode9"
, coalesce(di9_9.icd9_description,'') as "ICDCm9NameTH"
, '' as "ICDCm9NameEN"
, coalesce(di9_10.icd9_code,'') as "ICDCmCode10"
, coalesce(di9_10.icd9_description,'') as "ICDCm10NameTH"
, '' as "ICDCm10NameEN"
--
, di2.modify_eid as "EntryByUserCode"
, e.prename || e.firstname || ' ' || e.lastname as "EntryByUserNameTH"
, e.intername as "EntryByUserNameEN"
, di2.modify_date as "RegisterDate"
, '' as "ChronicCreteriaCode"
, '' as "ChronicCreteriaName"
, '' as "RemarksMemo"
, coalesce(ecode.icd10_code,'') as "ECode"
, coalesce(ecode.icd10_description,'') as "ECodeName"
--����
, coalesce(di10_1.icd10_code,'') as "ComobidityCode1"
, coalesce(di10_1.icd10_description,'') as "Comobidity1NameTH"
, '' as "Comobidity1NameEN"
, coalesce(di10_2.icd10_code,'') as "ComobidityCode2"
, coalesce(di10_2.icd10_description,'') as "Comobidity2NameTH"
, '' as "Comobidity2NameEN"
, coalesce(di10_3.icd10_code,'') as "ComobidityCode3"
, coalesce(di10_3.icd10_description,'') as "Comobidity3NameTH"
, '' as "Comobidity3NameEN"
, coalesce(di10_4.icd10_code,'') as "ComobidityCode4"
, coalesce(di10_4.icd10_description,'') as "Comobidity4NameTH"
, '' as "Comobidity4NameEN"
, coalesce(di10_5.icd10_code,'') as "ComobidityCode5"
, coalesce(di10_5.icd10_description,'') as "Comobidity5NameTH"
, '' as "Comobidity5NameEN"
--
from visit v 
left join attending_physician ap on v.visit_id = ap.visit_id 
left join base_department bd on ap.base_department_id = bd.base_department_id and bd.account_product  = 'COST'
left join diagnosis_icd10 di on v.visit_id = di.visit_id and di.fix_diagnosis_type_id = '1' and ap.employee_id = di.doctor_eid 
left join diagnosis_icd9 di2 on di2.visit_id = v.visit_id 
left join employee e on e.employee_id = di2. modify_eid
left join employee e2 on e2.employee_code = di.doctor_eid 
left join patient p on p.patient_id = v.patient_id
--icd_9
left join
	(
		select 	row_number() over(partition by v.visit_id order by di9_1.diagnosis_icd9_id asc) as "row"
				, v.visit_id
				, di9_1.icd9_code
				, di9_1.icd9_description
		from 	visit v 
		inner join diagnosis_icd9 di9_1 on v.visit_id = di9_1.visit_id
	)di9_1 on di9_1.visit_id = v.visit_id and di9_1."row" = 1
left join
	(
		select 	row_number() over(partition by v.visit_id order by di9_2.diagnosis_icd9_id asc) as "row"
				, v.visit_id
				, di9_2.icd9_code
				, di9_2.icd9_description
		from 	visit v 
		inner join diagnosis_icd9 di9_2 on v.visit_id = di9_2.visit_id
	)di9_2 on di9_2.visit_id = v.visit_id and di9_2."row" = 2
left join
	(
		select 	row_number() over(partition by v.visit_id order by di9_3.diagnosis_icd9_id asc) as "row"
				, v.visit_id
				, di9_3.icd9_code
				, di9_3.icd9_description
		from 	visit v 
		inner join diagnosis_icd9 di9_3 on v.visit_id = di9_3.visit_id
	)di9_3 on di9_3.visit_id = v.visit_id and di9_3."row" = 3
left join
	(
		select 	row_number() over(partition by v.visit_id order by di9_4.diagnosis_icd9_id asc) as "row"
				, v.visit_id
				, di9_4.icd9_code
				, di9_4.icd9_description
		from 	visit v 
		inner join diagnosis_icd9 di9_4 on v.visit_id = di9_4.visit_id
	)di9_4 on di9_4.visit_id = v.visit_id and di9_4."row" = 4
left join
	(
		select 	row_number() over(partition by v.visit_id order by di9_5.diagnosis_icd9_id asc) as "row"
				, v.visit_id
				, di9_5.icd9_code
				, di9_5.icd9_description
		from 	visit v 
		inner join diagnosis_icd9 di9_5 on v.visit_id = di9_5.visit_id
	)di9_5 on di9_5.visit_id = v.visit_id and di9_5."row" = 5
left join
	(
		select 	row_number() over(partition by v.visit_id order by di9_6.diagnosis_icd9_id asc) as "row"
				, v.visit_id
				, di9_6.icd9_code
				, di9_6.icd9_description
		from 	visit v 
		inner join diagnosis_icd9 di9_6 on v.visit_id = di9_6.visit_id
	)di9_6 on di9_6.visit_id = v.visit_id and di9_6."row" = 6
left join
	(
		select 	row_number() over(partition by v.visit_id order by di9_7.diagnosis_icd9_id asc) as "row"
				, v.visit_id
				, di9_7.icd9_code
				, di9_7.icd9_description
		from 	visit v 
		inner join diagnosis_icd9 di9_7 on v.visit_id = di9_7.visit_id
	)di9_7 on di9_7.visit_id = v.visit_id and di9_7."row" = 7
left join
	(
		select 	row_number() over(partition by v.visit_id order by di9_8.diagnosis_icd9_id asc) as "row"
				, v.visit_id
				, di9_8.icd9_code
				, di9_8.icd9_description
		from 	visit v 
		inner join diagnosis_icd9 di9_8 on v.visit_id = di9_8.visit_id
	)di9_8 on di9_8.visit_id = v.visit_id and di9_8."row" = 8
left join
	(
		select 	row_number() over(partition by v.visit_id order by di9_9.diagnosis_icd9_id asc) as "row"
				, v.visit_id
				, di9_9.icd9_code
				, di9_9.icd9_description
		from 	visit v 
		inner join diagnosis_icd9 di9_9 on v.visit_id = di9_9.visit_id
	)di9_9 on di9_9.visit_id = v.visit_id and di9_9."row" = 9
left join
	(
		select 	row_number() over(partition by v.visit_id order by di9_10.diagnosis_icd9_id asc) as "row"
				, v.visit_id
				, di9_10.icd9_code
				, di9_10.icd9_description
		from 	visit v 
		inner join diagnosis_icd9 di9_10 on v.visit_id = di9_10.visit_id
	)di9_10 on di9_10.visit_id = v.visit_id and di9_10."row" = 10
--icd_10
left join
	(
		select 	row_number() over(partition by v.visit_id order by di10_1.diagnosis_icd10_id asc) as "row"
				, v.visit_id
				, di10_1.icd10_code
				, di10_1.icd10_description
		from 	visit v 
		inner join diagnosis_icd10 di10_1 on v.visit_id = di10_1.visit_id
	)di10_1 on di10_1.visit_id = v.visit_id and di10_1."row" = 1
left join
	(
		select 	row_number() over(partition by v.visit_id order by di10_2.diagnosis_icd10_id asc) as "row"
				, v.visit_id
				, di10_2.icd10_code
				, di10_2.icd10_description
		from 	visit v 
		inner join diagnosis_icd10 di10_2 on v.visit_id = di10_2.visit_id
	)di10_2 on di10_2.visit_id = v.visit_id and di10_2."row" = 2
left join
	(
		select 	row_number() over(partition by v.visit_id order by di10_3.diagnosis_icd10_id asc) as "row"
				, v.visit_id
				, di10_3.icd10_code
				, di10_3.icd10_description
		from 	visit v 
		inner join diagnosis_icd10 di10_3 on v.visit_id = di10_3.visit_id
	)di10_3 on di10_3.visit_id = v.visit_id and di10_3."row" = 3
left join
	(
		select 	row_number() over(partition by v.visit_id order by di10_4.diagnosis_icd10_id asc) as "row"
				, v.visit_id
				, di10_4.icd10_code
				, di10_4.icd10_description
		from 	visit v 
		inner join diagnosis_icd10 di10_4 on v.visit_id = di10_4.visit_id
	)di10_4 on di10_4.visit_id = v.visit_id and di10_4."row" = 4
left join
	(
		select 	row_number() over(partition by v.visit_id order by di10_5.diagnosis_icd10_id asc) as "row"
				, v.visit_id
				, di10_5.icd10_code
				, di10_5.icd10_description
		from 	visit v 
		inner join diagnosis_icd10 di10_5 on v.visit_id = di10_5.visit_id
	)di10_5 on di10_5.visit_id = v.visit_id and di10_5."row" = 5
left join
    (
    	select   a.visit_id
                 , c.icd10_code
                 , c.icd10_description
        from      visit a inner join attending_physician b on b.priority = '1' and a.visit_id = b.visit_id
        inner join diagnosis_icd10 c on c.fix_diagnosis_type_id = '5' and c.icd10_code <> '' and a.visit_id = c.visit_id
    )ecode on v.visit_id = ecode.visit_id
--where format_vn(v.vn) = '63-00000064'
--where format_vn(v.vn) = 'O16-670704-0089'
--where format_vn(v.vn) = 'O16-671016-0272'
--    limit 100