select * from 
(
select 'PLC' as "BU"
	, v.patient_id as "PatientID"
	, '' as "FacilityRmsNo"
	, ax.assign_order_number as "RequestNo"
	, oi.verify_date ||' '|| oi.verify_time as "EntryDateTime"
	, ax.assign_order_number as "RequestDoctorCode"
	, e.prename ||''|| e.firstname ||' '|| e.lastname as "RequestDoctorNameTH"
	, e.intername as "RequestDoctorNameEN"
	, '' as "AcknowledgeDateTime"
	, '' as "ResultSuffixSmall"
	, i.item_code as "XrayCode"
	, i.common_name as "XrayNameTH"
	, '' as "XrayNameEN"
	, ax.complete_date ||' '|| ax.complete_time as "ConfirmResultDateTime"
	, xr.report_eid as "ResultDoctorCode"
	, e2.prename ||''|| e2.firstname ||' '|| e2.lastname as "ResultDoctorNameTH"
	, e2.intername as "ResultDoctorNameEN"
	, '' as "ResultMemo"
	, '' as "CancelByUserCode"
	, '' as "CancelByUserNameTH"
	, '' as "CancelByUserNameEN"
	, '' as "CancelDateTime"
	from order_item oi 
	left join visit v on v.visit_id = oi.visit_id
	left join item i on i.item_id = oi.item_id
	left join base_specimen bs on bs.base_specimen_id = oi.base_specimen_id 
	left join assign_xray ax on ax.visit_id = v.visit_id
	left join employee e on e.employee_id = ax.assign_doctor_eid
	left join xray_result xr on xr.assign_xray_id = ax.assign_xray_id
	left join employee e2 on e2.employee_id = xr.report_eid 
	where oi.fix_item_type_id = '2'
	--and oi.verify_date BETWEEN '$P!{dBeginDate}' AND '$P!{dEndDate}'
	union all
select 'PLC' as "BU"
	, v.patient_id as "PatientID"
	, '' as "FacilityRmsNo"
	, ax.assign_order_number as "RequestNo"
	, toi.track_date ||' '|| toi.track_time as "EntryDateTime"
	, ax.assign_order_number as "RequestDoctorCode"
	, e.prename ||''|| e.firstname ||' '|| e.lastname as "RequestDoctorNameTH"
	, e.intername as "RequestDoctorNameEN"
	, '' as "AcknowledgeDateTime"
	, '' as "ResultSuffixSmall"
	, i.item_code as "XrayCode"
	, i.common_name as "XrayNameTH"
	, '' as "XrayNameEN"
	, ax.complete_date ||' '|| ax.complete_time as "ConfirmResultDateTime"
	, xr.report_eid as "ResultDoctorCode"
	, e2.prename ||''|| e2.firstname ||' '|| e2.lastname as "ResultDoctorNameTH"
	, e2.intername as "ResultDoctorNameEN"
	, '' as "ResultMemo"
	, toi.track_actor as "CancelByUserCode"
	, e3.prename ||''|| e3.firstname ||' '|| e3.lastname as "CancelByUserNameTH"
	, e3.intername as "CancelByUserNameEN"
	, toi.track_date ||' '|| toi.track_time as "CancelDateTime"
	from track_order_item toi 
	left join order_item oi on oi.order_item_id = toi.order_item_id
	left join visit v on v.visit_id = oi.visit_id
	left join item i on i.item_id = oi.item_id
	left join base_specimen bs on bs.base_specimen_id = oi.base_specimen_id 
	left join assign_xray ax on ax.visit_id = v.visit_id
	left join employee e on e.employee_id = ax.assign_doctor_eid
	left join xray_result xr on xr.assign_xray_id = ax.assign_xray_id
	left join employee e2 on e2.employee_id = xr.report_eid 
	left join employee e3 on e3.employee_id = toi.track_actor
	where oi.fix_item_type_id = '2'
	--and oi.verify_date BETWEEN '$P!{dBeginDate}' AND '$P!{dEndDate}'
) dataopd --limit 100
