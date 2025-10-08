




--In
select 
'PLK' as "BU"
, v.patient_id as "PatientID"
, ri.refer_date ||' '|| ri.refer_time as "Date"
, case when v.fix_visit_type_id = '0' then format_vn(v.vn) else format_an(v.an) end as "VN/AN"
, ri.refer_eid as "DoctorCode"
, imed_get_employee_name(ri.refer_eid) as "DoctorNameTH"
, imed_get_employee_name_en(ri.refer_eid) as "DoctorNameEN"
, 'ReferIn' as "Refer"
, ri.refer_type as "ReferType"
, CONCAT(type1.type1,' ',type2.type2,' ',type3.type3,' ',type4.type4) as "ReferTypeNameTH"
, '' as "ReferTypeNameEN"
, ri.base_office_id as "ReferHospital"
, bo.full_name as "ReferHospitalNameTH"
, bo.full_name as "ReferHospitalNameEN"
, '' as "Remarks"
, ri.diagnosis as "Diag"
, '' as "DiagNameTH"
, '' as "DiagNameEN"
from visit v
left join refer_in ri on ri.visit_id = v.visit_id
left join --type1
		(
			select 	ri1.visit_id 
			 		, case when substring(ri1.refer_type,1,1) = '1' then 'วินิจฉัย' else '' end as type1
			from 	refer_in ri1 
			where 	ri1.refer_type like '1%'
		)type1 on type1.visit_id = v.visit_id
left join --type2
		(
			select 	ri2.visit_id 
			 		, case when substring(ri2.refer_type,2,1) = '1' then 'รักษา'else '' end as type2
			from 	refer_in ri2 
			where 	ri2.refer_type like '_1%'
		)type2 on type2.visit_id = v.visit_id
left join --type3
		(
			select 	ri3.visit_id 
			 		, case when substring(ri3.refer_type,3,1) = '1' then 'รับรักษาไว้ต่อเนื่อง' else '' end as type3
			from 	refer_in ri3
			where 	ri3.refer_type like '__1%'
		)type3 on type3.visit_id = v.visit_id
left join --type4
		(
			select 	ri4.visit_id 
			 		, case when substring(ri4.refer_type,4,1) = '1' then 'ตามความต้องการของผู้ป่วย' else '' end as type4
			from 	refer_in ri4
			where 	ri4.refer_type like '___1%'
		)type4 on type4.visit_id = v.visit_id
left join base_office bo on bo.base_office_id = ri.base_office_id
where ri.refer_date between '$P!{dBeginDate}' and '$P!{dEndDate}'
--and format_vn(v.vn) = 'O53-680302-1802' 
union all 
--Out
select 
'PLK' as "BU"
, v.patient_id as "PatientID"
, ro.refer_date ||' '|| ro.refer_time as "Date"
, case when v.fix_visit_type_id = '0' then format_vn(v.vn) else format_an(v.an) end as "VN/AN"
, ro.refer_eid as "DoctorCode"
, imed_get_employee_name(ro.refer_eid) as "DoctorNameTH"
, imed_get_employee_name_en(ro.refer_eid) as "DoctorNameEN"
, 'ReferOut' as "Refer"
, '' as "ReferType"
, '' as "ReferTypeNameTH"
, '' as "ReferTypeNameEN"
, ro.base_office_id as "ReferHospital"
, bo.full_name as "ReferHospitalNameTH"
, bo.full_name as "ReferHospitalNameEN"
, '' as "Remarks"
, ro.diagnosis as "Diag"
, '' as "DiagNameTH"
, '' as "DiagNameEN"
from visit v
left join refer_out ro on ro.visit_id = v.visit_id
left join base_office bo on bo.base_office_id = ro.base_office_id
where ro.refer_date between '$P!{dBeginDate}' and '$P!{dEndDate}'
--and format_vn(v.vn) = 'O53-680302-1802' 

