-- DROP FUNCTION public.his_func_get_diagnosis(varchar, varchar, varchar);

CREATE OR REPLACE FUNCTION public.his_func_get_diagnosis(v_vid character varying, v_dxtype character varying, v_optype character varying)
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
			then string_agg(di.icd10_code, '|' order by di.diagnosis_icd10_id)  
			when v_optype = '2'
			then string_agg((case when di.icd10_description != '' then di.icd10_description else di.beginning_diagnosis end), '|' order by di.diagnosis_icd10_id)
			end
	from 	diagnosis_icd10 di 
	where 	di.visit_id = v_vid
			and di.fix_diagnosis_type_id = v_dxtype;
else v_data = null; 
end if;
RETURN v_data;
END;
$function$
;