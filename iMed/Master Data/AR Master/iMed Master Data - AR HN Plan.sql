


select
'PLR' as "BU"
, p.payer_id as "ARCode"
, p.description as "ARNameTH"
, p.description_en as "ARNameEN"
, '' as "SuffixTiny"
, '' as "EffectiveDateFrom"
, '' as "EffectiveDateTo"
, '' as "HNReceiveRuleCode"
, '' as "DiscountCodeOPD"
, '' as "DiscountOPDNameTH"
, '' as "DiscountOPDNameEN"
, '' as "ReceiveCodeOPD"
, '' as "ReceiveOPDNameTH"
, '' as "ReceiveOPDNameEN"
, '' as "ReceiptFormOPD"
, '' as "ReceiptFormOPDNameTH"
, '' as "ReceiptFormOPDNameEN"
, '' as "ServiceChargeCodeOPD"
, '' as "ServiceChargeOPDNameTH"
, '' as "ServiceChargeOPDNameEN"
, '' as "ServiceChargeCodeNewOPD"
, '' as "ServiceChargeNewOPDNameTH"
, '' as "ServiceChargeNewOPDNameEN"
, '' as "DiscountCodeIPD"
, '' as "DiscountIPDNameTH"
, '' as "DiscountIPDNameEN"
, '' as "ReceiveCodeIPD"
, '' as "ReceiveIPDNameTH"
, '' as "ReceiveIPDNameEN"
, '' as "ReceiptFormIPD"
, '' as "ReceiptFormIPDNameTH"
, '' as "ReceiptFormIPDNameEN"
, '' as "ServiceChargeCodeIPD"
, '' as "ServiceChargeIPDNameTH"
, '' as "ServiceChargeIPDNameEN"
, '' as "RightCodeOPD"
, '' as "RightOPDNameTH"
, '' as "RightOPDNameEN"
, '' as "RightCodeIPD"
, '' as "RightIPDNameTH"
, '' as "RightIPDNameEN"
, '' as "RplGlAccCode"
, p.more_description as "RemarksMemo"
, '' as "LockReceiveCode"
, '' as "LockDiscountCode"
, '' as "LockReceiptForm"
, '' as "NeedCertificate"
, '' as "MustBeAR"
, '' as "ConfigTobeChange"
from payer p 
--limit 100









