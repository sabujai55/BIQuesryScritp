
select
'PLC' as "BU"
,v.patient_id as "PatientID" --modify 29/4/69
,v.visit_id  as "VisitID"
,v.visit_date  as "VisitDate"
,format_vn(v.vn) as "VN"
,ap.attending_physician_id  as "PrescriptionNo"	--> 2026-08-06	Add PrescriptionNo
,vp.plan_code as "RightCode"
,p.description as "RightNameTH"
,'' as "RightNameEN"
,vp.payer_id  as "SponsorCode"
,p2.description as "SponsorNameTH"
,p2.description_en as "SponsorNameEN"
,'' as "PolicyNo"
,vp.credit_limit::float  as "LimitAmt"
,vp.card_id as "RefNo"
,case when vp.inspire_date = '' then null else vp.inspire_date::timestamp end  as "EffectiveDateTimeFrom"
,case when vp.expire_date = '' then null else vp.expire_date::timestamp end as "EffectiveDateTimeTo"
,vp.note as "Remark"
,bo.full_name as "HospitalMain"
,bo2.full_name as "HospitalSub"
,'' AS "CompanyNo"
,'' AS "CompanyNameTH"
,'' as "CompanyNameEN"
from visit_payment vp 
inner join visit v on vp.visit_id = v.visit_id --แก้ไขจาก left เป็น inner 4-2-69--
INNER JOIN attending_physician ap on ap.visit_id = v.visit_id and ap.priority = '1'	--> 2026-08-06	Add PrescriptionNo
left join plan p on vp.plan_code = p.plan_code
left join payer p2 on vp.payer_id = p2.payer_id
left join base_office bo on vp.main_hospital_code = bo.base_office_id --MainHospital
left join base_office bo2 on vp.sub_hospital_code = bo2.base_office_id --SubHospital
--where v.visit_date = '2024-03-01'
--where format_vn(v.vn)='O16-670704-0089'
--limit 10
