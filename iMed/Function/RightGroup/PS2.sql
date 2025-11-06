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
		case 
		/*when pg.plan_group like '%PB%' and (pg.plan_group not like '%,SO%' or (pg.plan_group not like '%,N01%' or pg.plan_group like 'N01%')) then 'PB'*/
		when pg.plan_group ~ '(PB)' and  not(pg.plan_group ~ '(,N01|N01|,SO)') then 'PB'
		when pg.plan_group like '%SO01,%' then 
		/*
		  (
		  	case when pg.plan_group like '%IN%' then 'SW-IN'
		  	when pg.plan_group like '%CT%' then 'SW-CT'
		  	when pg.plan_group like '%PB%' then 'SW-PB'
		  	else substring(p.base_plan_group_id ,1,2) end
		  )
		 */
		 (
		  	case when pg.plan_group like '%IN%' then 'SW'
		  	when pg.plan_group like '%CT%' then 'SW'
			when pg.plan_group like '%CI%' then 'SW'
		  	when pg.plan_group like '%PB%' then 'SW'
		  	else substring(p.base_plan_group_id ,1,2) end
		  )
		 /*when (pg.plan_group like 'N01%' or pg.plan_group like 'N02%') then 'SC'*/
		 when (pg.plan_group like '%,N01%' or pg.plan_group like 'N01%') then 
		  (
		  	case when pg.plan_group like '%IN%' then 'SWC'
		  	when pg.plan_group like '%CT%' then 'SWC'
			when pg.plan_group like '%CI%' then 'SWC'
		  	when pg.plan_group like '%PB%' then 'SWC'
--		  	else substring(p.base_plan_group_id ,1,3) end
			else 'SC' end
		  )
		 else 
		 (
			case when position('_' in p.base_plan_group_id) > 0
			then left(substring(p.base_plan_group_id,1,position('_' in p.base_plan_group_id)-1),(length(substring(p.base_plan_group_id,1,position('_' in p.base_plan_group_id)-1))-2))
			else left(p.base_plan_group_id,length(p.base_plan_group_id)-2) end
		 ) end 
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
--								, substring(p.base_plan_group_id,1,2) as base_plan_group_id
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