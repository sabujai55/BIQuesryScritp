select 
'PT2' as 'BU'
, CtrlCode
, Code
, dbo.CutSortChar(EnglishName) as 'EnglishName'
, dbo.CutSortChar(LocalName) as 'ThaiName'
from DNSYSCONFIG