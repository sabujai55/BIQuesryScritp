



select 
'PLR' as "BU"
, p.payer_id as "ARCode"
, p.description as "ARNameTH"
, p.description_en as "ARNameEN"
, '' as "SuffixTiny"
, '' as "CustomerDept"
, '' as "MaleFacilityRequestMethod"
, '' as "MaleFacilityRequestMethodNameTH"
, '' as "MaleFacilityRequestMethodNameEN"
, '' as "FemaleFacilityRequestMethod"
, '' as "FemaleFacilityRequestMethodNameTH"
, '' as "FemaleFacilityRequestMethodNameEN"
, p.more_description as "RemarksMemo"
, '' as "EffDateFrom"
, '' as "EffDateTo"
from payer p 
--limit 100


