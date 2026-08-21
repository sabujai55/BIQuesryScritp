-- DROP FUNCTION public.format_hn(varchar);

CREATE OR REPLACE FUNCTION public.format_hn(character varying)
 RETURNS character varying
 LANGUAGE plpgsql
AS $function$
DECLARE

	v_hn ALIAS FOR $1;
    v_result VARCHAR := '';
    v_bu_code VARCHAR := '';

BEGIN
    
    IF LENGTH(v_hn) > 3 AND v_hn IS NOT NULL THEN
        SELECT INTO v_bu_code bu_code FROM base_site;
        v_result := v_bu_code||'-'
                  || substring(v_hn,0,3) || '-' || right(v_hn,6);
    ELSE
        v_result := '';
    END IF;

	RETURN v_result;

END
$function$
;