select 
'PLS' as 'BU'
, CtrlCode
, Code
, dbo.CutSortChar(ENGLISHNAME) as 'EnglishName'
, dbo.CutSortChar(THAINAME) as 'ThaiName'
from SYSCONFIG