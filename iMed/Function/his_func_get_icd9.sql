-- DROP FUNCTION public.his_func_get_icd9(varchar, varchar);

CREATE OR REPLACE FUNCTION public.his_func_get_icd9(v_vid character varying, v_optype character varying)
 RETURNS character varying
 LANGUAGE plpgsql
AS $function$
DECLARE
	v_data character varying := '';
begin 
if v_optype != '' 
then
	select 	into v_data 
			case when v_optype = '1' 
			then string_agg(di.icd9_code, '|' order by di.diagnosis_icd9_id)  
			when v_optype = '2'
			then string_agg((case when di.icd9_description != '' then di.icd9_description else di.beginning_operation end), '|' order by di.diagnosis_icd9_id)
			when v_optype = '3'
			then string_agg(di.doctor_eid, '|' order by di.diagnosis_icd9_id)
			when v_optype = '4'
			then string_agg((e.prename || e.firstname || ' ' || e.lastname), '|' order by di.diagnosis_icd9_id)
			when v_optype = '5'
			then string_agg((e.intername), '|' order by di.diagnosis_icd9_id)
			end
	from 	diagnosis_icd9 di 
			inner join fix_icd9 fi on di.icd9_code = fi.code
			left join employee e on di.doctor_eid = e.employee_id
	where 	di.visit_id = v_vid;
else v_data = null; 
end if;
RETURN v_data;
END;
$function$
;