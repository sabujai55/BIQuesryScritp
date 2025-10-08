




select
'PLR' as "BU"
, p.payer_id as "ARCode"
, p.description as "ARNameTH"
, p.description_en  as "ARNameEN"
, '' as "ARComposeCategory"
, '' as "ARComposeCategoryNameTH"
, '' as "ARComposeCategoryNameEN"
, '' as "ComposeDept"
, '' as "ComposeDeptNameTH"
, '' as "ComposeDeptNameEN"
, '' as "ARGradeCode"
, '' as "ARGradeCodeNameTH"
, '' as "ARGradeCodeNameEN"
, '' as "ARMainCode"
, '' as "ARMainNameTH"
, '' as "ARMainNameEN"
, '' as "SalesPerson"
, '' as "SalesPersonNameTH"
, '' as "SalesPersonNameEN"
, '' as "OtherSystemARCode"
, p.tax_id as "TaxId"
, '' as "StockActivityMethod"
, '' as "StockActivityMethodNameTH"
, '' as "StockActivityMethodNameEN"
, '' as "Currency"
, '' as "CurrencyNameTH"
, '' as "CurrencyNameEN"
, '' as "TermOfPayment"
, '' as "TermOfPaymentNameTH"
, '' as "TermOfPaymentNameEN"
, '' as "MakeDateTime"
, '' as "FirstDateTime"
, p.last_update as "LastUpdateDateTime"
, '' as "TerminateDate"
, '' as "DeletedDateTime"
, '' as "EffectiveDateFrom"
, '' as "EffectiveDateTo"
, '' as "RegisterNo"
, '' as "BillCollector"
, '' as "BillCollectorNameTH"
, '' as "BillCollectorNameEN"
, '' as "DeliveryByCode"
, '' as "DeliveryByNameTH"
, '' as "DeliveryByNameEN"
, '' as "DeliveryRegion"
, '' as "DeliveryRegionNameTH"
, '' as "DeliveryRegionNameEN"
, p.home_id ||' '|| p.road as "Address1"
, p.fix_changwat_id as "ProvinceComposeCode"
, bpd_addr_changwat(p.fix_changwat_id) as "ProvinceComposeNameTH"
, '' as "ProvinceComposeNameEN"
, p.postcode as "PostalCode"
, '' as "CountryCode"
, '' as "CountryNameTH"
, '' as "CountryNameEN"
, '' as "CommunicableNo"
, p.telephone as "TelephoneNo"
, '' as "FaxNo"
from payer p 
--limit 10









