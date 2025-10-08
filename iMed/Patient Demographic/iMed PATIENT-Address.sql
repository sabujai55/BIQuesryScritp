select p."BU"
		, p."PatientID"
		, p."HN"
		, row_number() over(partition by p."PatientID" order by p."PatientID") as "Suffix"
		, p."AddressType"
		, p."NotifiedPerson"
		, p."Relative"
		, p."Address"
		, p."Tambon"
		, p."Amphoe"
		, p."Province"
		, p."PostalCode"
		, p."MobilePhoneNo"
		, p."Telephone"
		, p."Email"
		, p."ProvinceComposeCode"
from 
(
select 	'PLC' as "BU"
		, pa.patient_id as "PatientID"
		, format_hn(p.hn) as "HN"
		--, row_number() over(partition by pa.patient_id order by pa.patient_address_id) as "Suffix"
		, case when pa.fix_address_type_id = '1' then 'ที่อยู่ปัจจุบัน'
		  when pa.fix_address_type_id = '2' then 'ที่อยู่ตามบัตรประชาชน'
		  when pa.fix_address_type_id = '3' then 'ที่ทำงาน'
		  else 'ไม่ระบุ' end as "AddressType"
		, '' as "NotifiedPerson"
		, '' as "Relative"
		, pa.home_id as "Address"
		, bpd_addr_tambol(pa.fix_changwat_id||pa.fix_amphur_id||pa.fix_tambol_id) as "Tambon"
		, bpd_addr_amphur(pa.fix_changwat_id,pa.fix_amphur_id) as "Amphoe"
		, bpd_addr_changwat(pa.fix_changwat_id) as "Province"
		, p.postcode as "PostalCode"
		, '' as "MobilePhoneNo"
		, pa.telephone as "Telephone"
		, '' as "Email"
		, pa.fix_changwat_id ||'.'|| pa.fix_amphur_id ||'.'|| pa.fix_tambol_id as "ProvinceComposeCode"
from 	patient_address pa 
		inner join patient p on pa.patient_id = p.patient_id 
--where 	pa.patient_id in (select v.patient_id from visit v where v.visit_date = '2024-08-27')
--limit 10
union all
select 	'PLC' as "BU"
		, pc.patient_id as "PatientID"
		, format_hn(p.hn) as "HN"
		--, row_number() over(partition by pc.patient_id order by pc.patient_contact_id) as "Suffix"
		, 'ที่อยู่ญาติ' as "AddressType"
		, pc.firstname || ' ' || pc.lastname as "NotifiedPerson"
		, pc.relate_text as "Relative"
		, pc.home_id as "Address"
		, bpd_addr_tambol(pc.fix_changwat_id||pc.fix_amphur_id||pc.fix_tambol_id) as "Tambon"
		, bpd_addr_amphur(pc.fix_changwat_id,pc.fix_amphur_id) as "Amphoe"
		, bpd_addr_changwat(pc.fix_changwat_id) as "Province"
		, p.postcode as "PostalCode"
		, '' as "MobilePhoneNo"
		, pc.telephone as "Telephone"
		, pc.email as "Email"
		, pc.fix_changwat_id ||'.'|| pc.fix_amphur_id ||'.'|| pc.fix_tambol_id as "ProvinceComposeCode"
from 	patient_contact pc  
		inner join patient p on pc.patient_id = p.patient_id 
--where 	pc.patient_id in (select v.patient_id from visit v where v.visit_date = '2024-08-27')
--limit 10
)p 