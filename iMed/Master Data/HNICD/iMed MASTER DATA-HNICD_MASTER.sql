


select 'PLR' as "BU"
, fi.code as "IcdCode"
, fi.description as "IcdNameTH"
, '' as "IcdNameEN"
, fi.is_chronic as "IsChronic"
, fi.is_secret as "IsSecret"
, case when fi.is_not_dx = '1' then 'Inactive' else 'Active' end as "Status"
from fix_icd10 fi 

