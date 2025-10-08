


select 
'PLR' as "BU"
, p.payer_id as "ARCode"
, p.description as "ARNameTH"
, p.description_en as "ARNameEN"
, '' as "ARAddressCode"
, p.home_id ||' '|| p.road as "Address1"
, p.fix_changwat_id as "Province"
, bpd_addr_changwat(p.fix_changwat_id) as "ProvinceNameTH"
, '' as "ProvinceNameEN"
, p.fix_amphur_id as "Amphoe"
, bpd_addr_amphur(p.fix_changwat_id,p.fix_amphur_id) as "AmphoeNameTH"
, '' as "AmphoeNameEN"
, p.fix_tambol_id as "Tambon"
, bpd_addr_tambol(p.fix_changwat_id||p.fix_amphur_id||p.fix_tambol_id) as "TambonNameTH"
, '' as "TambonNameEN"
, p.postcode as "PostalCode"
, p.telephone as "TelephoneNo"
, '' as "DeliveryRegion"
, '' as "DeliveryRegionNameTH"
, '' as "DeliveryRegionNameEN"
, '' as "FaxNo"
, '' as "CommunicableNo"
, '' as "PersonName"
, p.more_description as "RemarksMemo"
from payer p 
--limit 100

