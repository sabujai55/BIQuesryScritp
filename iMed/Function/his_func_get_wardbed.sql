-- DROP FUNCTION public.his_func_get_wardbed(varchar, int4);

CREATE OR REPLACE FUNCTION public.his_func_get_wardbed(v_aid character varying, v_type integer)
 RETURNS character varying
 LANGUAGE plpgsql
AS $function$
DECLARE
	v_data character varying := '';
begin 
if v_type is not null
then
	select 	into v_data
			case when v_type = 1 then ward_code
			when v_type = 2 then ward_name 
			when v_type = 3 then bed_number end
	from 
	(
		select 	bm.base_service_point_id as ward_code
				, bsp.description as ward_name
				, bm.bed_number
				, bm.move_date || ' ' || bm.move_time as move_in_datetime
				, bm.move_out_date || ' ' || bm.move_out_time as move_out_datetime
		from 	bed_management bm 
				inner join base_service_point bsp on bm.base_service_point_id = bsp.base_service_point_id 
		where 	bm.admit_id = v_aid
		order by bm.move_date || ' ' || bm.move_time desc 
		limit 1
	)a;
else v_data = null; 
end if;
RETURN v_data;
END;
$function$
;