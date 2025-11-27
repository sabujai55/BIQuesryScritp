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
	, '' as "LabCodeSuffixTiny"
	, '' as "SuffixTiny"
	, oi.base_specimen_id as "SpecimenCode"
	, bs.description as "SpecimenNameTH"
	, '' as "SpecimenNameEN"
	, i.item_code  as "RequestLabCode"
	, i.common_name as "RequestLabNameTH"
	, '' as "RequestLabNameEN"
	, lt.template_lab_test_id as "LabCode"
	, lt."name" as "LabNameTH"
	, '' as "LabNameEN"
	, lt.value as "ResultValue"
	, '' as "FacilityResultType"
	, '' as "FacilityResultName"
	, '' as "LABResultClassifiedType"
	, '' as "LABResultClassifiedName"
	, '' as "NormalResultValue"
	, lr.report_date ||' '|| lr.report_time as "ResultDateTime"
	, '' as "ConfirmByUserCode"
	, '' as"ConfirmByUserNameTH"
	, '' as "ConfirmByUserNameEN"
	, '' as "ConfirmDateTime"
	, lr.approve_eid as "ApproveByUserCode"
	, e3.prename ||''|| e3.firstname ||' '|| e3.lastname  as "ApproveByUserNameTH"
	, e3.intername as "ApproveByUserNameEN"
	, lr.approve_date ||' '|| lr.approve_time as "ApproveDateTime"
	, '' as "PreviousResultValue"
	, '' as "PreviousResultDateTime"
	, '' as "CancelByUserCode"
	, '' as "CancelByUserNameTH"
	, '' as "CancelByUserNameEN"
	, '' as "CancelDateTime"
	, oi.verify_spid as "FromLocationCode"
	, bd.description as "FromLocationNameTH"
	, '' as "FromLocationNameEN"
	from order_item oi
	inner join visit v on v.visit_id = oi.visit_id and oi.fix_item_type_id = '1'
	inner join item i on i.item_id = oi.item_id
	inner join assign_lab al on al.visit_id = v.visit_id and oi.assigned_ref_no = al."ln"
	inner join lab_result lr on lr.assign_lab_id = al.assign_lab_id and lr.visit_id = v.visit_id and lr.order_item_id = oi.order_item_id
	inner join lab_test lt on lt.order_item_id = oi.order_item_id and lt.lab_result_id = lr.lab_result_id
	left join base_specimen bs on bs.base_specimen_id = oi.base_specimen_id
	left join employee e on e.employee_id = al.assign_doctor_eid
	left join employee e2 on e2.employee_id = lr.verify_specimen_eid
	left join employee e3 on e3.employee_id = lr.approve_eid
	left join base_service_point bsp on bsp.base_service_point_id = oi.verify_spid
	left join base_department bd on bd.base_department_id = bsp.base_department_id
--	where oi.fix_item_type_id = '1' 
--	and v.patient_id = '570000944229'
--	and lt.value != ''
	union all
select 'PLC' as "BU"
	, v.patient_id as "PatientID"
	, '' as "FacilityRmsNo"
	, al."ln" as "RequestNo"
	, toi.verify_date ||' '|| toi.verify_time as "EntryDateTime"
	, al.assign_doctor_eid as "RequestDoctorCode"
	, e.prename ||''|| e.firstname ||' '|| e.lastname as "RequestDoctorNameTH"
	, e.intername as "RequestDoctorNameEN"
	, '' as "LabCodeSuffixTiny"
	, '' as "SuffixTiny"
	, toi.base_specimen_id as "SpecimenCode"
	, bs.description as "SpecimenNameTH"
	, '' as "SpecimenNameEN"
	, i.item_code  as "RequestLabCode"
	, i.common_name as "RequestLabNameTH"
	, '' as "RequestLabNameEN"
	, lt.template_lab_test_id as "LabCode"
	, lt."name" as "LabNameTH"
	, '' as "LabNameEN"
	, lt.value as "ResultValue"
	, '' as "FacilityResultType"
	, '' as "FacilityResultName"
	, '' as "LABResultClassifiedType"
	, '' as "LABResultClassifiedName"
	, '' as "NormalResultValue"
	, lr.report_date ||' '|| lr.report_time as "ResultDateTime"
	, '' as "ConfirmByUserCode"
	, '' as"ConfirmByUserNameTH"
	, '' as "ConfirmByUserNameEN"
	, '' as "ConfirmDateTime"
	, lr.approve_eid as "ApproveByUserCode"
	, e3.prename ||''|| e3.firstname ||' '|| e3.lastname  as "ApproveByUserNameTH"
	, e3.intername as "ApproveByUserNameEN"
	, lr.approve_date ||' '|| lr.approve_time as "ApproveDateTime"
	, '' as "PreviousResultValue"
	, '' as "PreviousResultDateTime"
	, toi.track_actor as "CancelByUserCode"
	, e4.prename ||''|| e4.firstname ||' '|| e4.lastname as "CancelByUserNameTH"
	, e4.intername as "CancelByUserNameEN"
	, toi.track_date ||' '|| toi.track_time as "CancelDateTime"
	, toi.verify_spid as "FromLocationCode"
	, bd.description as "FromLocationNameTH"
	, '' as "FromLocationNameEN"
	from track_order_item toi
	inner join visit v on v.visit_id = toi.visit_id and toi.fix_item_type_id = '1'
	inner join item i on i.item_id = toi.item_id
	inner join assign_lab al on al.visit_id = v.visit_id and toi.assigned_ref_no = al."ln"
	inner join lab_result lr on lr.assign_lab_id = al.assign_lab_id and lr.visit_id = v.visit_id and lr.order_item_id = toi.order_item_id
	inner join lab_test lt on lt.order_item_id = toi.order_item_id and lt.lab_result_id = lr.lab_result_id
	left join base_specimen bs on bs.base_specimen_id = toi.base_specimen_id
	left join employee e on e.employee_id = al.assign_doctor_eid
	left join employee e3 on e3.employee_id = lr.approve_eid
	left join employee e4 on e4.employee_id = toi.track_actor
	left join base_service_point bsp on bsp.base_service_point_id = toi.verify_spid
	left join base_department bd on bd.base_department_id = bsp.base_department_id
--	where oi.fix_item_type_id = '1'
--	and v.patient_id = '570000944229'
--	and lt.value != ''
) dataopd 
limit 100






