

select
'PLK' as "BU"
, tlt.template_lab_test_id as "LabCode"
, tlt."name" as "LabNameTH"
, '' as "LabNameEN"
, '' as "Suffix"
, '' as "Specimen"
, '' as "SpecimenNameTH"
, '' as "SpecimenNameEN"
, coalesce(tlnv.normal_value_min, '') as "NormalValueFrom"
, coalesce(tlnv.normal_value_max, '') as "NormalValueTo"
, '' as "AgeYearFrom"
, '' as "AgeMonthFrom"
, '' as "AgeDayFrom"
, '' as "AgeYearTo"
, '' as "AgeMonthTo"
, '' as "AgeDayTo"
, '' as "ValidFrom"
, '' as "ValidTo"
, tlnv.fix_lab_normal_value_type_id as "Gender"
, case when tlnv.fix_lab_normal_value_type_id = '1' then 'ผู้ป่วยทุกประเภท'
when tlnv.fix_lab_normal_value_type_id = '2' then 'ผู้ป่วยเด็ก'
when tlnv.fix_lab_normal_value_type_id = '3' then 'ผู้ป่วยผู้ชาย'
when tlnv.fix_lab_normal_value_type_id = '4' then 'ผู้ป่วยผู้หญิง'
when tlnv.fix_lab_normal_value_type_id = '5' then 'ผู้ป่วยชรา' else 'None'end as "GenderNameTH"
, '' as "GenderNameEN"
, '' as "NormalName"
, '' as "LowName"
, '' as "HighName"
from template_lab_test tlt 
left join template_lab_normal_value tlnv on tlt.template_lab_test_id = tlnv.template_lab_test_id
left join template_lab_item tli on tli.template_lab_test_id = tlt.template_lab_test_id 
--left join item i on i.item_id = tli.item_id
--where  tli.item_id = 'L3349' and i.fix_item_type_id = '1'
--mit 100
