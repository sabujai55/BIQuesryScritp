 select  'PLR' as "BU"
	  , a.patient_id as "PatientID"
	  , a.admit_id as "AdmitID"
	  , format_an(a.an) as "AN"
	  , bm.move_date || ' ' || bm.move_time as "MakeDateTime"
	  , bm.move_date || ' ' || bm.move_time as "InDateTime"
	  , bm.move_out_date || ' ' || bm.move_out_time as "OutDateTime"
	  , bm.move_date || ' ' || bm.move_time as "AckDateTime" --> For iMed Ver.2
-- 	  , bm.arrival_date || ' ' || bm.arrival_time  as "AckDateTime"  --> For iMedx
	  , '' as "StartRmsFeeDateTime"
	  , '' as "LastPostDateTime"
	  , '' as "FromWardCode"
	  , '' as "FromWardNameTH"
	  , '' as "FromWardNameEN"
	  , '' as "ToWardCode"
	  , '' as "ToWardNameTH"
	  , '' as "ToWardNameEN"
	  , bsp.base_service_point_id as "WardCode"
	  , bsp.description as "WardNameTH"
	  , bsp.description as "WardNameEN"
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
	  , a.admit_eid as "InByUserCode"
	  , e.prename || ' ' || e.firstname || '  ' || e.lastname as "InByUserNameTH"
	  , e.intername as "InByUserNameEN"
	  , a.ipd_discharge as "OutByUserCode"
	  , e2.prename || ' ' || e2.firstname || '  ' || e2.lastname as "OutByUserNameTH"
	  , e2.intername as "OutByUserNameEN"
	  , case when a.is_observe != '1' then 0 else 1 end as "Observe"
	  , bm.current_bed as "PatientStay"
from admit a 
inner join bed_management bm on a.admit_id = bm.admit_id 
left join base_service_point bsp on bm.base_service_point_id = bsp.base_service_point_id 
left join base_room_type brt on bm.base_room_type_id = brt.base_room_type_id 
left join employee e on a.admit_eid = e.employee_id 
left join employee e2 on a.ipd_discharge_eid = e2.employee_id 
--order by a.admit_id desc 
limit 100








