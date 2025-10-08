select 	'PLD' as "BU"
		, os.or_location_id as "FacilityRmsNo"
		, or2.or_number as "RequestNo"
		, or2.registered_date || ' ' || or2.registered_time as "EntryDateTime"
		, os.set_doctor_eid as "RequestDoctorCode"
		, e.prename || e.firstname || ' ' || e.lastname as "RequestDoctorNameTH"
		, e.intername as "RequestDoctorNameEN"
		, p.plan_code as "RightCode"
		, '' as "RightNameTH"
		, p.description_en as "RightNameEN"
		, or2.base_op_room_id as "HNORRmsNo"
		, bor.description as "HNORRmsNoNameTH"
		, '' as "HNORRmsNoNameEN"
		, os.refrain_food_date || ' ' || os.refrain_food_time as "NPODateTime"
		, os.op_appoint_date || ' ' || os.op_appoint_time as "AttendDateTime"
		, os.accept_date || ' ' || os.accept_time as "ORConfirmDateTime"
		, '0' as "PrivateCase"
		, os.fix_op_status_id as "ORCaseType"
		, bot.description as "ORClassifiedType"
		, '0' as "HoldRequest"
		, os.op_appoint_date || ' ' || os.op_appoint_time as "ORBeginDateTimePlan"
		, (os.op_appoint_date || ' ' || os.op_appoint_time)::timestamp + (((os.estimate_hour::int * 60) + (os.estimate_minute::int)) || ' minute')::interval as "ORFinishDateTimePlan"
		, or2.start_date || ' ' || or2.start_time as "ORBeginDateTimeActual"
		, or2.finish_date || ' ' || or2.finish_time as "ORFinishDateTimeActual"
		, or2.start_anes_date || ' ' || or2.start_anes_time as "AnesBeginDateTimeActual"
		, or2.finish_anes_date || ' ' || or2.finish_anes_time as "AnesFinishDateTimeActual"
		, '' as "ORPostureCode"
		, '' as "ORPostureNameTH"
		, '' as "ORPostureNameEN"
		, (select orp.employee_id from op_registered_physician orp where orp.op_registered_id = or2.op_registered_id and orp.base_op_role_id = 'SG' order by orp.op_registered_physician_id desc limit 1) as "SG"
		, or2.*
from 	op_registered or2 
		join op_set os on or2.op_registered_id = os.op_registered_id 
		join visit_payment vp on or2.visit_id = vp.visit_id and vp.priority = '1'
		join plan p on vp.plan_id = p.plan_id 
		left join employee e on os.set_doctor_eid = e.employee_id 
		left join base_op_room bor on or2.base_op_room_id = bor.base_op_room_id 
		left join base_op_type bot on or2.base_op_type_id = bot.base_op_type_id 
where 	or2.registered_date between '$P!{dBeginDate}' and '$P!{dEndDate}'


select * from op_registered_physician orp where orp.op_registered_id = '125010808555531301';

select * from op_registered or2 where or_number = 'OR255829';

select * from op_set os where op_registered_id = '125050907283504201'