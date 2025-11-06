-- DROP FUNCTION public.his_func_get_lastvisitid(varchar, varchar, varchar);

CREATE OR REPLACE FUNCTION public.his_func_get_lastvisitid(v_pid character varying, v_dept character varying, v_vid character varying)
 RETURNS character varying
 LANGUAGE plpgsql
AS $function$
DECLARE
	v_data character varying := '';
begin 
select  into v_data a.visit_id
from    visit a inner join attending_physician b on a.active = '1' and b.priority = '1' and a.visit_id = b.visit_id
		inner join base_department bd on b.base_department_id = bd.base_department_id and bd.account_product <> 'ADMIN'
where 	a.patient_id = v_pid
		and b.base_department_id = v_dept
		and a.visit_id < v_vid
order by a.visit_id desc 
limit 1;
RETURN v_data;
END;
$function$
;