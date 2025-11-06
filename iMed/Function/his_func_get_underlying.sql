-- DROP FUNCTION public.his_func_get_underlying(varchar, int4);

CREATE OR REPLACE FUNCTION public.his_func_get_underlying(v_pid character varying, v_type integer)
 RETURNS character varying
 LANGUAGE plpgsql
AS $function$
DECLARE
	v_data character varying := '';
begin 
if v_type is not null
then
	select 	into v_data
			case when v_type = 1 then icdcode
			when v_type = 2 then icdname end
	from 
	(
	select 	pi2.patient_id 
			, string_agg(case when pi2.icd10_code != '' then pi2.icd10_code else '' end,'|' order by pi2.personal_illness_id) as icdcode 
			, string_agg(case when pi2.icd10_code != '' then pi2.icd10_des  else pi2.illness_name end,'|' order by pi2.personal_illness_id) as icdname
	from 	personal_illness pi2 
	where 	pi2.patient_id = v_pid
			and lower(pi2.illness_name) not in ('no','none')
	group by pi2.patient_id
	)a;
else v_data = null; 
end if;
RETURN v_data;
END;
$function$
;