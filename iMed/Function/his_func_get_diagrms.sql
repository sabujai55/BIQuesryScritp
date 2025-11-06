-- DROP FUNCTION public.his_func_get_diagrms(varchar, varchar, int4);

CREATE OR REPLACE FUNCTION public.his_func_get_diagrms(v_vid character varying, v_eid character varying, v_code integer)
 RETURNS character varying
 LANGUAGE plpgsql
AS $function$
DECLARE
	v_data character varying := '';
begin 
	select 	into v_data 
			case when v_code = 1 then bsp.base_service_point_id 
			when v_code = 2 then bsp.description end
	from 	visit_queue vq  
			join base_service_point bsp on vq.next_location_spid = bsp.base_service_point_id  
	where 	vq.visit_id = v_vid
			and vq.next_operate_eid = v_eid
			and bsp.fix_service_point_group_id = '2'
	order by vq.visit_queue_id asc limit 1;
RETURN v_data;
END;
$function$
;