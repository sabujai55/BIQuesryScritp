 
 


select  'PLC' as "BU"
	  , bm.bed_management_id as "BedID"
	  , a.patient_id as "PatientID"	--เพิ่ม 12/6/69
	  , a.admit_id as "AdmitID"
	  , format_an(a.an) as "AN"
	  , bm.move_date || ' ' || bm.move_time as "MakeDateTime"	--แก้ไข 12/6/69	  
	  , CASE WHEN COALESCE(a.begin_date, '') = '' THEN '' ELSE to_char(a.begin_date::timestamp, 'dd/mm/yyyy') || ' ' || substring(COALESCE(a.begin_time, ''), 1, 5) END AS "InDateTime"		--แก้ไข 12/6/69
	  , case WHEN COALESCE(a.end_date, '') = '' THEN '' ELSE to_char(a.end_date::timestamp, 'dd/mm/yyyy') || ' ' || substring(COALESCE(a.end_time, ''), 1, 5) END AS "OutDateTime"		--แก้ไข 12/6/69
	  , '' as "AckDateTime"
	  , '' as "StartRmsFeeDateTime"
	  , case WHEN COALESCE(a.modify_date, '') = '' THEN '' ELSE to_char(a.modify_date::timestamp, 'dd/mm/yyyy') || ' ' || substring(COALESCE(a.modify_time, ''), 1, 5) END AS "LastPostDateTime"	--แก้ไข 12/6/69
	  , bsp.base_service_point_id as "FromWardCode"
	  , bsp.description as "FromWardNameTH"
	  , '' as "FromWardNameEN"
	  , bsp.base_service_point_id as "ToWardCode"
	  , bsp.description as "ToWardNameTH"
	  , '' as "ToWardNameEN"
	  , bsp.base_service_point_id as "WardCode"
	  , bsp.description as "WardNameTH"
	  , '' as "WardNameEN"
	  , bm.bed_number as "HNBedNo"
	  , '' as "HNBedNameTH"
	  , '' as "HNBedNameEN"
	  , bm.base_room_type_id as "HNRmsTypeCode"
	  , brt.description as "HNRmsTypeNameTH"
	  , '' as "HNRmsTypeNameEN"
	  , '' as "TransferInReasonCode"
	  , '' as "TransferInReasonNameTH"
	  , '' as "TransferInReasonNameEN"
	  , '' as "TransferOutReasonCode"
	  , '' as "TransferOutReasonNameTH"
	  , '' as "TransferOutReasonNameEN"
	  , '' as "Remarks"
	  , a.modify_eid as "InByUserCode"
	  , e.prename || ' ' || e.firstname || '  ' || e.lastname as "InByUserNameTH"
	  , e.intername as "InByUserNameEN"
	  , '' as "OutByUserCode"
	  , '' as "OutByUserNameTH"
	  , '' as "OutByUserNameEN"
	  , case when a.is_observe != '1' then 0 else 1 end as "Observe"
	  , case when bm.current_bed = '3' then 0 else bm.current_bed::integer end as "PatientStay"	--แก้ไข 12/6/69
from admit a 
inner join bed_management bm on a.admit_id = bm.admit_id 
left join base_service_point bsp on bm.base_service_point_id = bsp.base_service_point_id 
left join base_room_type brt on bm.base_room_type_id = brt.base_room_type_id 
left join employee e on a.modify_eid = e.employee_id	--แก้ไข 12/6/69
--left join employee e2 on a.ipd_discharge_eid = e2.employee_id 
--where bm.bed_management_id = '224101120402114301'
--bm.current_bed in ('0','1')
--bm.current_bed = '1'
--limit 100



