select

	case when lastvs.visit_id is null then 'N' else 'O' end as "NewClinic"

from 	visit v 
inner join attending_physician ap on v.visit_id = ap.visit_id and v.active = '1'
left join
		(
			select  row_number () over(partition by a.patient_id, b.base_department_id order by a.visit_id asc) as rowid
					, a.patient_id
					, a.visit_id
					, a.visit_date
					, b.base_department_id
			from    visit a inner join attending_physician b on a.active = '1' and b.priority = '1' and a.visit_id = b.visit_id
					inner join base_department bd on b.base_department_id = bd.base_department_id and bd.account_product <> 'ADMIN'
					
			where 	a.visit_id  in (select visit_id from visit where visit_date between #dBeginDate# and #dEndDate#)
		)lastvs on lastvs.rowid = 1 and v.patient_id = lastvs.patient_id and ap.base_department_id  = lastvs.base_department_id and v.visit_id <> lastvs.visit_id