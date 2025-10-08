select * from patient p where fix_nationality_id = '' limit 10

select * from patient p where patient_id = '580000969951'

select * from order_item oi where patient_id = '580000969951'  and visit_id = '225052114211890301' --and item_id = 'PTDEPAK500WO'

select * from track_order_item toi   where patient_id = '580000969951'  and visit_id = '225052114211890301' and item_id = 'PTDEPAK500WO'

select * from visit v where visit_id = '225052114211890000'

select * from visit v where  patient_id = '580000969951'


select * from item i where item_code = 'PTDEPAK500WO'
