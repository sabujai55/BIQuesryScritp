select 'PLC' as "BU"
, p.patient_id as "PatientID"
, format_hn(p.hn) as "HN"
, p.prename as "PreNameTH"
, p.firstname as "FirstNameTH"
, p.lastname as "LastNameTH"
, '' as "PreNameEN"
, p.intername as "FirstNameEN"
, '' as "LastNameEN"
, p.birthdate as "BirthDateTime"
, case when p.fix_gender_id = '1' then '���'
  when p.fix_gender_id = '2' then '˭ԧ' else '����к�' end as "Gender"
, p.blood_group as "BloodGroup"
, p.pid as "IDCardNo"
, p.passport_no as "Passport"
, fr.description as "Race"
, fn.description as "Nationality"
, br.description as "Religion"
, p.home_id ||' '|| p.village as "Address"
, bpd_addr_tambol(p.fix_changwat_id||p.fix_amphur_id||p.fix_tambol_id) as "Tambon"
, bpd_addr_amphur(p.fix_changwat_id,p.fix_amphur_id) as "Amphoe"
, bpd_addr_changwat(p.fix_changwat_id) as "Province"
, p.postcode as "PostalCode"
, p.mobile as "MobilePhoneNo"
, p.telephone as "Telephone"
, p.email as "Email"
, bpg.description as "PatientType"
, d.death_date || ' ' || d.death_time as "DeadDateTime"
, fm.description as "MaritalStatus"
, '' as "MedicalDeleteDateTime"
, vt.description as "VIPType"
, p.crm as "VIPRemark"
, '' as "VisitAllow"
, fo.description as "Occupation"
, d.death_date || ' ' || d.death_time as "DeadDateTime"
, '' as "FileDeletedDate"
, '' as "PrivateDoctorCode"
, '' as "CommunicableNo"
, p.modify_date ||' '|| p.modify_time as "CreatePatientDate"
, p.modify_date ||' '|| p.modify_time as "LastUpdateDateTime"
, '' as "BirthPlace"
from patient p  
left join fix_nationality fn on fn.fix_nationality_id = p.fix_nationality_id 
left join base_religion br on br.base_religion_id = p.religion
left join vip_type vt on vt.vip_type_id = p.vip_type_id
left join fix_marriage fm on fm.fix_marriage_id = p.fix_marriage_id 
left join base_patient_group bpg on bpg.base_patient_group_id = p.base_patient_group_id
left join fix_race fr on fr.fix_race_id = p.fix_race_id
left join fix_occupation fo on fo.fix_occupation_id = p.fix_occupation_id
left join death d on d.patient_id = p.patient_id 
--where format_hn(p.hn) = '16-67-006569'
order by format_hn(p.hn) asc

