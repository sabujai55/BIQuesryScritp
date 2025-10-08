select 	'PLK' as "BU"
		, i.item_code as "MotherLabCode"
		, i.print_name  as "MotherLabNameTH"
		, i.common_name as "MotherLabNameEN"
		, t.result_position::int + 1 as "Suffix"
		, t.template_lab_test_id as "LabCode"
		, t2."name" as "LabCodeNameTH"
		, t2."name" as "LabCodeNameEN"
		, '' as "OffCode"
from 	item i 
		join template_lab_item t on t.item_id = i.item_id
		join template_lab_test t2 on t2.template_lab_test_id = t.template_lab_test_id
order by i.item_code, t.result_position