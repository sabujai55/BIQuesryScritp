
select 
'PLC' as "BU" 
, v.patient_id as "PatientID"
, '' as "FacilityRmsNo"
, '' as "RequestNo"
, '' as "PTModeSuffixSmall"
, '' as "PTModeCode"
, '' as "PTModeNameTH"
, '' as "PTModeNameEN"
, '' as "PTSystemCode"
, '' as "PTSystemNameTH"
, '' as "PTSystemNameEN"
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
, PTT1.employee_id as "PTTherapistCode1"
, imed_get_employee_name(PTT1.employee_id) as "PTTherapistNameTH1"
, imed_get_employee_name_en(PTT1.employee_id) as "PTTherapistNameEN1"
, PTT2.employee_id as "PTTherapistCode2"
, imed_get_employee_name(PTT2.employee_id) as "PTTherapistNameTH2"
, imed_get_employee_name_en(PTT2.employee_id) as "PTTherapistNameEN2"
, PTT3.employee_id as "PTTherapistCode3"
, imed_get_employee_name(PTT3.employee_id) as "PTTherapistNameTH3"
, imed_get_employee_name_en(PTT3.employee_id) as "PTTherapistNameEN3"
, v.visit_date ||' '|| v.visit_time as "RegisterDateTime"
, '' as "StartDateTime"
, '' as "FinishDateTime"
, '' as "EntryDateTime"
, '' as "ChargeType"
, case when v.fix_visit_type_id = '0' then '0' else '1' end as "AtWard"
, case when v.fix_visit_type_id = '0' then 'OPD' else 'IPD' end as "IpdOpdType"
, p.plan_code as "RightCode"
, p.description as "RightNameTH"
, p.description as "RightNameEN"
, '' as "Qty"
from visit v
left join visit_queue vq on vq.visit_id = v.visit_id 
left join base_service_point bsp on bsp.base_service_point_id = vq.next_location_spid
left join visit_payment vp on vp.visit_id = v.visit_id
left join base_plan_group bpg on bpg.base_plan_group_id = vp.base_plan_group_id
left join plan p on p.plan_id = vp.plan_id
left join appointment a on a.make_appointment_visit_id = v.visit_id
left join admit a2 on a2.visit_id = v.visit_id
left join bed_management bm on bm.admit_id = a2.admit_id
left join base_service_point bsp2 on bsp2.base_service_point_id = bm.base_service_point_id
left join
	(
		select 	row_number() over(partition by v.visit_id order by ap2.attending_physician_id asc) as "row"
				, v.visit_id
				, ap2.employee_id
		from 	visit v 
		inner join attending_physician ap2 on ap2.visit_id = v.visit_id and ap2.base_department_id like '2701%'
	)PTT1 on PTT1.visit_id = v.visit_id and PTT1."row" = 1
left join
	(
		select 	row_number() over(partition by v.visit_id order by ap2.attending_physician_id asc) as "row"
				, v.visit_id
				, ap2.employee_id
		from 	visit v 
		inner join attending_physician ap2 on ap2.visit_id = v.visit_id and ap2.base_department_id like '2701%'
	)PTT2 on PTT2.visit_id = v.visit_id and PTT2."row" = 2
left join
	(
		select 	row_number() over(partition by v.visit_id order by ap2.attending_physician_id asc) as "row"
				, v.visit_id
				, ap2.employee_id
		from 	visit v 
		inner join attending_physician ap2 on ap2.visit_id = v.visit_id and ap2.base_department_id like '2701%'
	)PTT3 on PTT3.visit_id = v.visit_id and PTT3."row" = 3
WHERE bsp.base_department_id like '2701%' 
AND v.active = '1'
and v.visit_date BETWEEN '$P!{dBeginDate}' AND '$P!{dEndDate}'
ORDER BY v.visit_date, v.hn




