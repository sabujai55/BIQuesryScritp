-- DROP FUNCTION public.visit_rightgroup(varchar);

CREATE OR REPLACE FUNCTION public.visit_rightgroup(v_vid character varying)
 RETURNS character varying
 LANGUAGE plpgsql
AS $function$
DECLARE
	v_rightgroup VARCHAR := '';
BEGIN	if v_vid is not null or v_vid <> '' then 
select 	into v_rightgroup 
		case 
		when (select ap.base_department_id from attending_physician ap where ap.visit_id = v_vid and ap.priority = '1') = '3026'  then 'HE'
		when pg.plan_group like '%SO%' then 
		  (
		  	case 
			when pg.plan_group like '%IN%' then 'SW-IN'
			when (pg.plan_group like '%CO%' or pg.plan_group like '%CI%' or pg.plan_group like '%CT%') then 'SW-CO'
			when pg.plan_group like '%PB%' then 'SW-PB'
			else substring(split_part(pg.plan_group,',',1),1,2) end
		  )
		 when p.subtype != '' then 
			(
				case when (p.subtype like 'CO%' or p.subtype like 'CI%' or p.subtype like 'CT%') then 'CO'
				else substring(p.subtype,1,2) end 
			)
		 when pg.plan_group like '%PB%' and pg.plan_group not like '%,SO%' then 'PB'
		 else substring(split_part(pg.plan_group,',',1),1,2) end 
from 	visit_payment vp inner join plan p on vp.plan_id = p.plan_id and vp.priority = '1'
		inner join base_plan_group bpg2 on p.base_plan_group_id = bpg2.base_plan_group_id 
		left join 
		(
			select	plan.visit_id
					, string_agg(plan.base_plan_group_id,',' order by plan.priority) as plan_group 
			from 	
					(
						select 	row_number() over(partition by vp.visit_id, p.base_plan_group_id order by vp.priority||bpg.group_type) as rowid
								, vp.visit_id 
								, priority 
								, case when vp.contract_office_id = '0306155002A' then 'UCEP' 
  								  when p.subtype != '' then p.subtype
								  else bpg.group_type end as base_plan_group_id 
						from 	visit_payment vp inner join plan p on vp.plan_id = p.plan_id  
								inner join base_plan_group bpg on p.base_plan_group_id = bpg.base_plan_group_id 
						where 	vp.visit_id = v_vid
								and bpg.group_type not in  ('FE', 'DISCOUNT')
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