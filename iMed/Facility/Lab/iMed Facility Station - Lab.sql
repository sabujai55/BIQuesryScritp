select * from 
(
select 'PLC' as "BU"
	, v.patient_id as "PatientID"
	, '' as "FacilityRmsNo"
	, al."ln" as "RequestNo"
	, oi.verify_date ||' '|| oi.verify_time as "EntryDateTime"
	, al.assign_doctor_eid as "RequestDoctorCode"
	, e.prename ||''|| e.firstname ||' '|| e.lastname as "RequestDoctorNameTH"
	, e.intername as "RequestDoctorNameEN"
	, row_number() over(partition by oi.order_item_id order by oi.visit_id) as "LabCodeSuffixTiny"
	, '' as "SuffixTiny"
	, oi.base_specimen_id as "SpecimenCode"
	, bs.description as "SpecimenNameTH"
	, '' as "SpecimenNameEN"
	, al."ln"  as "RequestLabCode"
	, '' as "RequestLabNameTH"
	, '' as "RequestLabNameEN"
	, i.item_code as "LabCode"
	, i.common_name as "LabNameTH"
	, '' as "LabNameEN"
	, '' as "ResultValue"
	, '' as "FacilityResultType"
	, '' as "FacilityResultName"
	, '' as "LABResultClassifiedType"
	, '' as "LABResultClassifiedName"
	, '' as "NormalResultValue"
	, lr.report_date ||' '|| lr.report_time as "ResultDateTime"
	, lr.verify_specimen_eid as "ConfirmByUserCode"
	, e2.prename ||''|| e2.firstname ||' '|| e2.lastname as"ConfirmByUserNameTH"
	, e2.intername as "ConfirmByUserNameEN"
	, lr.verify_specimen_date ||' '|| lr.verify_specimen_time as "ConfirmDateTime"
	, lr.collect_specimen_eid as "ApproveByUserCode"
	, e3.prename ||''|| e3.firstname ||' '|| e3.lastname  as "ApproveByUserNameTH"
	, e3.intername as "ApproveByUserNameEN"
	, lr.collect_specimen_date ||' '|| lr.collect_specimen_time as "ApproveDateTime"
	, '' as "PreviousResultValue"
	, '' as "PreviousResultDateTime"
	, '' as "CancelByUserCode"
	, '' as "CancelByUserNameTH"
	, '' as "CancelByUserNameEN"
	, '' as "CancelDateTime"
	, '' AS "CheckupNo"
	from order_item oi 
	left join visit v on v.visit_id = oi.visit_id
	left join item i on i.item_id = oi.item_id
	left join base_specimen bs on bs.base_specimen_id = oi.base_specimen_id 
	left join assign_lab al on al.visit_id = v.visit_id
	left join employee e on e.employee_id = al.assign_doctor_eid
	left join lab_result lr on lr.assign_lab_id = al.assign_lab_id 
	left join employee e2 on e2.employee_id = lr.verify_specimen_eid 
	left join employee e3 on e3.employee_id = lr.collect_specimen_eid 
	where oi.fix_item_type_id = '1' 
	--and oi.verify_date BETWEEN '$P!{dBeginDate}' AND '$P!{dEndDate}'
	union all
select 'PLC' as "BU"
	, v.patient_id as "PatientID"
	, '' as "FacilityRmsNo"
	, al."ln" as "RequestNo"
	, oi.verify_date ||' '|| oi.verify_time as "EntryDateTime"
	, al.assign_doctor_eid as "RequestDoctorCode"
	, e.prename ||''|| e.firstname ||' '|| e.lastname as "RequestDoctorNameTH"
	, e.intername as "RequestDoctorNameEN"
	, row_number() over(partition by oi.order_item_id order by oi.visit_id) as "LabCodeSuffixTiny"
	, '' as "SuffixTiny"
	, oi.base_specimen_id as "SpecimenCode"
	, bs.description as "SpecimenNameTH"
	, '' as "SpecimenNameEN"
	, al."ln"  as "RequestLabCode"
	, '' as "RequestLabNameTH"
	, '' as "RequestLabNameEN"
	, i.item_code as "LabCode"
	, i.common_name as "LabNameTH"
	, '' as "LabNameEN"
	, '' as "ResultValue"
	, '' as "FacilityResultType"
	, '' as "FacilityResultName"
	, '' as "LABResultClassifiedType"
	, '' as "LABResultClassifiedName"
	, '' as "NormalResultValue"
	, lr.report_date ||' '|| lr.report_time as "ResultDateTime"
	, lr.verify_specimen_eid as "ConfirmByUserCode"
	, e2.prename ||''|| e2.firstname ||' '|| e2.lastname as"ConfirmByUserNameTH"
	, e2.intername as "ConfirmByUserNameEN"
	, lr.verify_specimen_date ||' '|| lr.verify_specimen_time as "ConfirmDateTime"
	, lr.collect_specimen_eid as "ApproveByUserCode"
	, e3.prename ||''|| e3.firstname ||' '|| e3.lastname  as "ApproveByUserNameTH"
	, e3.intername as "ApproveByUserNameEN"
	, lr.collect_specimen_date ||' '|| lr.collect_specimen_time as "ApproveDateTime"
	, '' as "PreviousResultValue"
	, '' as "PreviousResultDateTime"
	, toi.track_actor as "CancelByUserCode"
	, e4.prename ||''|| e4.firstname ||' '|| e4.lastname as "CancelByUserNameTH"
	, e4.intername as "CancelByUserNameEN"
	, toi.track_date ||' '|| toi.track_time as "CancelDateTime"
	, '' AS "CheckupNo"
	from track_order_item toi 
	left join order_item oi on oi.order_item_id = toi.order_item_id  
	left join visit v on v.visit_id = toi.visit_id
	left join item i on i.item_id = oi.item_id
	left join base_specimen bs on bs.base_specimen_id = oi.base_specimen_id 
	left join assign_lab al on al.visit_id = v.visit_id
	left join employee e on e.employee_id = al.assign_doctor_eid
	left join lab_result lr on lr.assign_lab_id = al.assign_lab_id 
	left join employee e2 on e2.employee_id = lr.verify_specimen_eid 
	left join employee e3 on e3.employee_id = lr.collect_specimen_eid 
	left join employee e4 on e4.employee_id = toi.track_actor
	where oi.fix_item_type_id = '1'
	--and toi.verify_date BETWEEN '$P!{dBeginDate}' AND '$P!{dEndDate}'
) dataopd --limit 10
