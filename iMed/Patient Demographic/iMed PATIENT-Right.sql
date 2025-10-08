select 'PLC' as "BU"
,v.patient_id  as "PatientID"
,format_hn(v.hn) as "HN"
,ROW_NUMBER() over(partition by patient_id  order by vp.priority ) as "Suffix"
,vp.plan_code as "RightCode"
,p.description as "RightNameTH"
,'' as "RightNameEN"
,vp.payer_id  as "SponsorCode"
,p2.description as "SponsorNameTH"
,'' as "SponsorNameEN"
,'' as "PolicyNo"
,vp.credit_limit::float  as "LimitAmt"
,vp.card_id as "RefNo"
,case when vp.inspire_date = '' then null else vp.inspire_date::timestamp end  as "EffectiveDateTimeFrom"
,case when vp.expire_date = '' then null else vp.expire_date::timestamp end as "EffectiveDateTimeTo"
,vp.note as "Remark"
,bo.full_name as "HospitalMain"
,bo2.full_name as "HospitalSub"
from visit_payment vp 
inner join (select ROW_NUMBER() over(partition by patient_id  order by visit_date desc) as suffix
			,v.patient_id
			,v.hn
			,v.visit_id
			from visit v )v on vp.visit_id = v.visit_id and v.suffix = '1'
left join plan p on vp.plan_code = p.plan_code
left join payer p2 on vp.payer_id = p2.payer_id
left join base_office bo on vp.main_hospital_code = bo.base_office_id --MainHospital
left join base_office bo2 on vp.sub_hospital_code = bo2.base_office_id --SubHospital
--limit 10