-- DROP FUNCTION public.visit_rightgroup(varchar);

CREATE OR REPLACE FUNCTION public.visit_rightgroup(character varying)
 RETURNS character varying
 LANGUAGE plpgsql
AS $function$
DECLARE
	v_vid ALIAS FOR $1;
	v_rightgroup VARCHAR := '';
BEGIN	if v_vid is not null or v_vid <> '' then 
select 	into v_rightgroup  
		case when pg.plan_group like '%SO01%' then 
		  (
		  	case when pg.plan_group like '%PB%' then 'SW-PB'
			when pg.plan_group like '%IN%' then 'SW-IN'
		  	when pg.plan_group like '%CT%' then 'SW-CT'
		  	when pg.plan_group like '%CI%' then 'SW-CI'	--11-03-2025 เมล์คุณคนิตย์เมื่อ 06/03/68
		  	else substring(p.base_plan_group_id ,1,2) end
		  )
		 when pg.plan_group like '%PB%' and pg.plan_group not like '%SO%' 	 then 'PB'
		 else substring(p.base_plan_group_id ,1,2) end 
from 	visit_payment vp inner join plan p on vp.plan_id = p.plan_id and vp.priority = '1'
		left join 
		(
			select	plan.visit_id
					, string_agg(plan.base_plan_group_id,',' order by plan.priority) as plan_group 
			from 	
					(
						select 	row_number() over(partition by vp.visit_id, p.base_plan_group_id order by vp.priority||p.base_plan_group_id) as rowid
								, vp.visit_id 
								, priority 
								, p.base_plan_group_id  
						from 	visit_payment vp inner join plan p on vp.plan_id = p.plan_id  
						where 	vp.visit_id = v_vid
								and p.base_plan_group_id <> 'FE'
					)plan
			where 	plan.rowid = 1
			group by plan.visit_id
		)pg on vp.visit_id = pg.visit_id
where 	vp.visit_id = v_vid;
	END IF;
	RETURN v_rightgroup;
END;
$function$
;