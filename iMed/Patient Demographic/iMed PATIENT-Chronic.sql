select 	'PLC' as "BU"
		, pi2.patient_id as "PatientID"
		, format_hn(p.hn) as "HN"
		, pi2.icd10_code as "ICDCode"
		, fi.description as "ICDNameTH"
		, '' as "ICDNameEN"
		, pi2.regist_date as "RegisterDate"
		, pi2.chronic_code as "ChronicCreteriaCode"
		, bcc.description_th as "ChronicCreteriaNameTH"
		, bcc.description_en as "ChronicCreteriaNameEN"
		, '' as "FirstDate"
		, e.employee_id as "RegisterDoctor"
		, e.prename || e.firstname || ' ' || e.lastname as "RegisterDoctorNameTH"
		, e.intername as "RegisterDoctorNameEN"
		, e.profession_code as "RegisterDoctorCertificate"		
		, e2.employee_code as "EntryByUserCode"
		, e2.prename || e2.firstname || ' ' || e2.lastname as "EntryByUserNameTH"
		, e2.intername as "EntryByUserNameEN"
from 	personal_illness pi2 
		inner join patient p on pi2.patient_id = p.patient_id 
		inner join fix_icd10 fi on pi2.icd10_code = fi.code 
		left join base_chronic_criteria bcc on pi2.chronic_code = bcc.base_chronic_criteria_id 
		left join employee e on pi2.modify_eid = e.employee_id and e.fix_employee_type_id = '2'
		left join employee e2 on pi2.modify_eid = e2.employee_id
--where 	left(pi2.regist_date,4) = '2024'
order by pi2.regist_date desc 
limit 10