





select
'PLR' as "BU"
, bosc.base_order_sub_category_id as "HNActivityCode"
, bosc.description as "HNActivityNameTH"
, '' as "HNActivityNameEN"
, '' as "IncomeSummaryCode"
, '' as "IncomeSummaryNameTH"
, '' as "IncomeSummaryNameEN"
, bosc.base_order_category_id as "HNActivityCategoryCode"
, boc.description as "HNActivityCategoryNameTH"
, '' as "HNActivityCategoryNameEN"
, '' as "ARActivityCode"
, '' as "ARActivityNameTH"
, '' as "ARActivityNameEN"
, '' as "HospitalActivityTypeId"
, '' as "HospitalActivityTypeName"
, '' as "TypeofTransfertoDFId"
, '' as "TypeofTransfertoDFName"
from base_order_sub_category bosc
left join base_order_category boc on boc.base_order_category_id = bosc.base_order_category_id


