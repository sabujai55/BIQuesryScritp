


select 'PLR' as "BU"
, fi.code as "IcdCode"
, fi.description as "IcdNameTH"
, '' as "IcdNameEN"
, fi.is_chronic as "IsChronic"
, fi.is_secret as "IsSecret"
, '' as "Status"
from fix_icd10 fi 


select * from fix_icd10 fi limit 100



select * from diagnosis_icd10 di limit 100


