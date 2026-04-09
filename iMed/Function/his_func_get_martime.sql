-- DROP FUNCTION public.his_func_get_martime(varchar, varchar);

CREATE OR REPLACE FUNCTION public.his_func_get_martime(v_oid character varying, v_martype character varying)
 RETURNS character varying
 LANGUAGE plpgsql
AS $function$
DECLARE
	v_data character varying := '';
begin 
if v_martype != '' 
then
	select 	into v_data 
			case when v_martype = '1' 
			then string_agg(odm.mar_eid,'|' order by odm.order_drug_mar_id asc)
			when v_martype = '2'
			then string_agg(odm.mar_date || ' ' || odm.mar_time,'|' order by odm.order_drug_mar_id asc)
			end
	from 	order_drug_mar odm  
	where 	odm.order_item_id = v_oid
group by odm.order_item_id;
else v_data = null; 
end if;
RETURN v_data;
END;
$function$
;