


select 
'PLR' as "BU"
, fi.code as "IcdCode"
, fi.description as "IcdNameTH"
, '' as "IcdNameEN"
, fi.is_not_dx as "Status"
from fix_icd9 fi 