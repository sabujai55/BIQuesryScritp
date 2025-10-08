WITH Mother (MotherCode,ExtendLab)
AS
(
SELECT DISTINCT Code as MotherCode ,cast(substring(com,1,9) as varchar) 
FROM dnsysconfig_detail
WHERE ctrlcode='60051' and additioncode='ExtendLabCode' and suffix=1

UNION ALL

SELECT DISTINCT Code as MotherCode ,cast(substring(com,11,9) as varchar)
FROM dnsysconfig_detail
WHERE ctrlcode='60051' and additioncode='ExtendLabCode' and suffix=1
	
UNION ALL

SELECT DISTINCT Code as MotherCode ,cast(substring(com,21,9) as varchar)
FROM dnsysconfig_detail
WHERE ctrlcode='60051' and additioncode='ExtendLabCode' and suffix=1

UNION ALL

SELECT DISTINCT Code as MotherCode ,cast(substring(com,31,9) as varchar)
FROM dnsysconfig_detail
WHERE ctrlcode='60051' and additioncode='ExtendLabCode' and suffix=1
	
UNION ALL

SELECT DISTINCT Code as MotherCode ,cast(substring(com,41,9) as varchar)
FROM dnsysconfig_detail
WHERE ctrlcode='60051' and additioncode='ExtendLabCode' and suffix=1

UNION ALL

SELECT DISTINCT Code as MotherCode ,cast(substring(com,51,9) as varchar)
FROM dnsysconfig_detail
WHERE ctrlcode='60051' and additioncode='ExtendLabCode' and suffix=1
	
UNION ALL

SELECT DISTINCT Code as MotherCode ,cast(substring(com,61,9) as varchar)
FROM dnsysconfig_detail
WHERE ctrlcode='60051' and additioncode='ExtendLabCode' and suffix=1

UNION ALL

SELECT DISTINCT Code as MotherCode ,cast(substring(com,71,9) as varchar)
FROM dnsysconfig_detail
WHERE ctrlcode='60051' and additioncode='ExtendLabCode' and suffix=1 

UNION ALL

SELECT DISTINCT Code as MotherCode ,cast(substring(com,81,9) as varchar)
FROM dnsysconfig_detail
WHERE ctrlcode='60051' and additioncode='ExtendLabCode' and suffix=1

UNION ALL

SELECT DISTINCT Code as MotherCode ,cast(substring(com,91,9) as varchar)
FROM dnsysconfig_detail
WHERE ctrlcode='60051' and additioncode='ExtendLabCode' and suffix=1

UNION ALL

SELECT DISTINCT Code as MotherCode ,cast(substring(com,101,9) as varchar)
FROM dnsysconfig_detail
WHERE ctrlcode='60051' and additioncode='ExtendLabCode' and suffix=1

UNION ALL

SELECT DISTINCT Code as MotherCode ,cast(substring(com,111,9) as varchar)
FROM dnsysconfig_detail
WHERE ctrlcode='60051' and additioncode='ExtendLabCode' and suffix=1

UNION ALL

SELECT DISTINCT Code as MotherCode ,cast(substring(com,121,9) as varchar)
FROM dnsysconfig_detail
WHERE ctrlcode='60051' and additioncode='ExtendLabCode' and suffix=1

UNION ALL

SELECT DISTINCT Code as MotherCode ,cast(substring(com,131,9) as varchar)
FROM dnsysconfig_detail
WHERE ctrlcode='60051' and additioncode='ExtendLabCode' and suffix=1

UNION ALL

SELECT DISTINCT Code as MotherCode ,cast(substring(com,141,9) as varchar)
FROM dnsysconfig_detail
WHERE ctrlcode='60051' and additioncode='ExtendLabCode' and suffix=1

UNION ALL

SELECT DISTINCT Code as MotherCode ,cast(substring(com,151,9) as varchar)
FROM dnsysconfig_detail
WHERE ctrlcode='60051' and additioncode='ExtendLabCode' and suffix=1

UNION ALL

SELECT DISTINCT Code as MotherCode ,cast(substring(com,161,9) as varchar)
FROM dnsysconfig_detail
WHERE ctrlcode='60051' and additioncode='ExtendLabCode' and suffix=1

UNION ALL

SELECT DISTINCT Code as MotherCode ,cast(substring(com,171,9) as varchar)
FROM dnsysconfig_detail
WHERE ctrlcode='60051' and additioncode='ExtendLabCode' and suffix=1

UNION ALL

SELECT DISTINCT Code as MotherCode ,cast(substring(com,181,9) as varchar)
FROM dnsysconfig_detail
WHERE ctrlcode='60051' and additioncode='ExtendLabCode' and suffix=1

UNION ALL

SELECT DISTINCT Code as MotherCode ,cast(substring(com,191,9) as varchar)
FROM dnsysconfig_detail
WHERE ctrlcode='60051' and additioncode='ExtendLabCode' and suffix=1
	
UNION ALL

SELECT DISTINCT Code as MotherCode ,cast(substring(com,1,9) as varchar)
FROM dnsysconfig_detail
WHERE ctrlcode='60051' and additioncode='ExtendLabCode' and suffix=2

UNION ALL

SELECT DISTINCT Code as MotherCode ,cast(substring(com,11,9) as varchar)
FROM dnsysconfig_detail
WHERE ctrlcode='60051' and additioncode='ExtendLabCode' and suffix=2
	
UNION ALL

SELECT DISTINCT Code as MotherCode ,cast(substring(com,21,9) as varchar)
FROM dnsysconfig_detail
WHERE ctrlcode='60051' and additioncode='ExtendLabCode' and suffix=2

UNION ALL

SELECT DISTINCT Code as MotherCode ,cast(substring(com,31,9) as varchar)
FROM dnsysconfig_detail
WHERE ctrlcode='60051' and additioncode='ExtendLabCode' and suffix=2
	
UNION ALL

SELECT DISTINCT Code as MotherCode ,cast(substring(com,41,9) as varchar)
FROM dnsysconfig_detail
WHERE ctrlcode='60051' and additioncode='ExtendLabCode' and suffix=2

UNION ALL

SELECT DISTINCT Code as MotherCode ,cast(substring(com,51,9) as varchar)
FROM dnsysconfig_detail
WHERE ctrlcode='60051' and additioncode='ExtendLabCode' and suffix=2
	
UNION ALL

SELECT DISTINCT Code as MotherCode ,cast(substring(com,61,9) as varchar)
FROM dnsysconfig_detail
WHERE ctrlcode='60051' and additioncode='ExtendLabCode' and suffix=2

UNION ALL

SELECT DISTINCT Code as MotherCode ,cast(substring(com,71,9) as varchar)
FROM dnsysconfig_detail
WHERE ctrlcode='60051' and additioncode='ExtendLabCode' and suffix=2

UNION ALL

SELECT DISTINCT Code as MotherCode ,cast(substring(com,81,9) as varchar)
FROM dnsysconfig_detail
WHERE ctrlcode='60051' and additioncode='ExtendLabCode' and suffix=2

UNION ALL

SELECT DISTINCT Code as MotherCode ,cast(substring(com,91,9) as varchar)
FROM dnsysconfig_detail
WHERE ctrlcode='60051' and additioncode='ExtendLabCode' and suffix=2

UNION ALL

SELECT DISTINCT Code as MotherCode ,cast(substring(com,101,9) as varchar)
FROM dnsysconfig_detail
WHERE ctrlcode='60051' and additioncode='ExtendLabCode' and suffix=2

UNION ALL

SELECT DISTINCT Code as MotherCode ,cast(substring(com,111,9) as varchar)
FROM dnsysconfig_detail
WHERE ctrlcode='60051' and additioncode='ExtendLabCode' and suffix=2

UNION ALL

SELECT DISTINCT Code as MotherCode ,cast(substring(com,121,9) as varchar)
FROM dnsysconfig_detail
WHERE ctrlcode='60051' and additioncode='ExtendLabCode' and suffix=2

UNION ALL

SELECT DISTINCT Code as MotherCode ,cast(substring(com,131,9) as varchar)
FROM dnsysconfig_detail
WHERE ctrlcode='60051' and additioncode='ExtendLabCode' and suffix=2

UNION ALL

SELECT DISTINCT Code as MotherCode ,cast(substring(com,141,9) as varchar)
FROM dnsysconfig_detail
WHERE ctrlcode='60051' and additioncode='ExtendLabCode' and suffix=2

UNION ALL

SELECT DISTINCT Code as MotherCode ,cast(substring(com,151,9) as varchar)
FROM dnsysconfig_detail
WHERE ctrlcode='60051' and additioncode='ExtendLabCode' and suffix=2

UNION ALL

SELECT DISTINCT Code as MotherCode ,cast(substring(com,161,9) as varchar)
FROM dnsysconfig_detail
WHERE ctrlcode='60051' and additioncode='ExtendLabCode' and suffix=2

UNION ALL

SELECT DISTINCT Code as MotherCode ,cast(substring(com,171,9) as varchar)
FROM dnsysconfig_detail
WHERE ctrlcode='60051' and additioncode='ExtendLabCode' and suffix=2

UNION ALL

SELECT DISTINCT Code as MotherCode ,cast(substring(com,181,9) as varchar)
FROM dnsysconfig_detail
WHERE ctrlcode='60051' and additioncode='ExtendLabCode' and suffix=2

UNION ALL

SELECT DISTINCT Code as MotherCode ,cast(substring(com,191,9) as varchar)
FROM dnsysconfig_detail
WHERE ctrlcode='60051' and additioncode='ExtendLabCode' and suffix=2
	
UNION ALL	

SELECT DISTINCT Code as MotherCode ,cast(substring(com,1,9) as varchar) 
FROM dnsysconfig_detail
WHERE ctrlcode='60051' and additioncode='ExtendLabCode' and suffix=3

UNION ALL

SELECT DISTINCT Code as MotherCode ,cast(substring(com,11,9) as varchar)
FROM dnsysconfig_detail
WHERE ctrlcode='60051' and additioncode='ExtendLabCode' and suffix=3
	
UNION ALL

SELECT DISTINCT Code as MotherCode ,cast(substring(com,21,9) as varchar)
FROM dnsysconfig_detail
WHERE ctrlcode='60051' and additioncode='ExtendLabCode' and suffix=3

UNION ALL

SELECT DISTINCT Code as MotherCode ,cast(substring(com,31,9) as varchar)
FROM dnsysconfig_detail
WHERE ctrlcode='60051' and additioncode='ExtendLabCode' and suffix=3
	
UNION ALL

SELECT DISTINCT Code as MotherCode ,cast(substring(com,41,9) as varchar)
FROM dnsysconfig_detail
WHERE ctrlcode='60051' and additioncode='ExtendLabCode' and suffix=3

UNION ALL

SELECT DISTINCT Code as MotherCode ,cast(substring(com,51,9) as varchar)
FROM dnsysconfig_detail
WHERE ctrlcode='60051' and additioncode='ExtendLabCode' and suffix=3
	
UNION ALL

SELECT DISTINCT Code as MotherCode ,cast(substring(com,61,9) as varchar)
FROM dnsysconfig_detail
WHERE ctrlcode='60051' and additioncode='ExtendLabCode' and suffix=3

UNION ALL

SELECT DISTINCT Code as MotherCode ,cast(substring(com,71,9) as varchar)
FROM dnsysconfig_detail
WHERE ctrlcode='60051' and additioncode='ExtendLabCode' and suffix=3

UNION ALL

SELECT DISTINCT Code as MotherCode ,cast(substring(com,81,9) as varchar)
FROM dnsysconfig_detail
WHERE ctrlcode='60051' and additioncode='ExtendLabCode' and suffix=3

UNION ALL

SELECT DISTINCT Code as MotherCode ,cast(substring(com,91,9) as varchar)
FROM dnsysconfig_detail
WHERE ctrlcode='60051' and additioncode='ExtendLabCode' and suffix=3

UNION ALL

SELECT DISTINCT Code as MotherCode ,cast(substring(com,101,9) as varchar)
FROM dnsysconfig_detail
WHERE ctrlcode='60051' and additioncode='ExtendLabCode' and suffix=3

UNION ALL

SELECT DISTINCT Code as MotherCode ,cast(substring(com,111,9) as varchar)
FROM dnsysconfig_detail
WHERE ctrlcode='60051' and additioncode='ExtendLabCode' and suffix=3

UNION ALL

SELECT DISTINCT Code as MotherCode ,cast(substring(com,121,9) as varchar)
FROM dnsysconfig_detail
WHERE ctrlcode='60051' and additioncode='ExtendLabCode' and suffix=3

UNION ALL

SELECT DISTINCT Code as MotherCode ,cast(substring(com,131,9) as varchar)
FROM dnsysconfig_detail
WHERE ctrlcode='60051' and additioncode='ExtendLabCode' and suffix=3

UNION ALL

SELECT DISTINCT Code as MotherCode ,cast(substring(com,141,9) as varchar)
FROM dnsysconfig_detail
WHERE ctrlcode='60051' and additioncode='ExtendLabCode' and suffix=3

UNION ALL

SELECT DISTINCT Code as MotherCode ,cast(substring(com,151,9) as varchar)
FROM dnsysconfig_detail
WHERE ctrlcode='60051' and additioncode='ExtendLabCode' and suffix=3

UNION ALL

SELECT DISTINCT Code as MotherCode ,cast(substring(com,161,9) as varchar)
FROM dnsysconfig_detail
WHERE ctrlcode='60051' and additioncode='ExtendLabCode' and suffix=3

UNION ALL

SELECT DISTINCT Code as MotherCode ,cast(substring(com,171,9) as varchar)
FROM dnsysconfig_detail
WHERE ctrlcode='60051' and additioncode='ExtendLabCode' and suffix=3

UNION ALL

SELECT DISTINCT Code as MotherCode ,cast(substring(com,181,9) as varchar)
FROM dnsysconfig_detail
WHERE ctrlcode='60051' and additioncode='ExtendLabCode' and suffix=3

UNION ALL

SELECT DISTINCT Code as MotherCode ,cast(substring(com,191,9) as varchar)
FROM dnsysconfig_detail
WHERE ctrlcode='60051' and additioncode='ExtendLabCode' and suffix=3

UNION ALL

SELECT DISTINCT Code as MotherCode ,cast(substring(com,1,9) as varchar)
FROM dnsysconfig_detail
WHERE ctrlcode='60051' and additioncode='ExtendLabCode' and suffix=4

UNION ALL

SELECT DISTINCT Code as MotherCode ,cast(substring(com,11,9) as varchar)
FROM dnsysconfig_detail
WHERE ctrlcode='60051' and additioncode='ExtendLabCode' and suffix=4
	
UNION ALL

SELECT DISTINCT Code as MotherCode ,cast(substring(com,21,9) as varchar)
FROM dnsysconfig_detail
WHERE ctrlcode='60051' and additioncode='ExtendLabCode' and suffix=4

UNION ALL

SELECT DISTINCT Code as MotherCode ,cast(substring(com,31,9) as varchar)
FROM dnsysconfig_detail
WHERE ctrlcode='60051' and additioncode='ExtendLabCode' and suffix=4
	
UNION ALL

SELECT DISTINCT Code as MotherCode ,cast(substring(com,41,9) as varchar)
FROM dnsysconfig_detail
WHERE ctrlcode='60051' and additioncode='ExtendLabCode' and suffix=4

UNION ALL

SELECT DISTINCT Code as MotherCode ,cast(substring(com,51,9) as varchar)
FROM dnsysconfig_detail
WHERE ctrlcode='60051' and additioncode='ExtendLabCode' and suffix=4
	
UNION ALL

SELECT DISTINCT Code as MotherCode ,cast(substring(com,61,9) as varchar)
FROM dnsysconfig_detail
WHERE ctrlcode='60051' and additioncode='ExtendLabCode' and suffix=4

UNION ALL

SELECT DISTINCT Code as MotherCode ,cast(substring(com,71,9) as varchar)
FROM dnsysconfig_detail
WHERE ctrlcode='60051' and additioncode='ExtendLabCode' and suffix=4 

UNION ALL

SELECT DISTINCT Code as MotherCode ,cast(substring(com,81,9) as varchar)
FROM dnsysconfig_detail
WHERE ctrlcode='60051' and additioncode='ExtendLabCode' and suffix=4

UNION ALL

SELECT DISTINCT Code as MotherCode ,cast(substring(com,91,9) as varchar)
FROM dnsysconfig_detail
WHERE ctrlcode='60051' and additioncode='ExtendLabCode' and suffix=4

UNION ALL

SELECT DISTINCT Code as MotherCode ,cast(substring(com,101,9) as varchar)
FROM dnsysconfig_detail
WHERE ctrlcode='60051' and additioncode='ExtendLabCode' and suffix=4

UNION ALL

SELECT DISTINCT Code as MotherCode ,cast(substring(com,111,9) as varchar)
FROM dnsysconfig_detail
WHERE ctrlcode='60051' and additioncode='ExtendLabCode' and suffix=4

UNION ALL

SELECT DISTINCT Code as MotherCode ,cast(substring(com,121,9) as varchar)
FROM dnsysconfig_detail
WHERE ctrlcode='60051' and additioncode='ExtendLabCode' and suffix=4

UNION ALL

SELECT DISTINCT Code as MotherCode ,cast(substring(com,131,9) as varchar)
FROM dnsysconfig_detail
WHERE ctrlcode='60051' and additioncode='ExtendLabCode' and suffix=4

UNION ALL

SELECT DISTINCT Code as MotherCode ,cast(substring(com,141,9) as varchar)
FROM dnsysconfig_detail
WHERE ctrlcode='60051' and additioncode='ExtendLabCode' and suffix=4

UNION ALL

SELECT DISTINCT Code as MotherCode ,cast(substring(com,151,9) as varchar)
FROM dnsysconfig_detail
WHERE ctrlcode='60051' and additioncode='ExtendLabCode' and suffix=4

UNION ALL

SELECT DISTINCT Code as MotherCode ,cast(substring(com,161,9) as varchar)
FROM dnsysconfig_detail
WHERE ctrlcode='60051' and additioncode='ExtendLabCode' and suffix=4

UNION ALL

SELECT DISTINCT Code as MotherCode ,cast(substring(com,171,9) as varchar)
FROM dnsysconfig_detail
WHERE ctrlcode='60051' and additioncode='ExtendLabCode' and suffix=4

UNION ALL

SELECT DISTINCT Code as MotherCode ,cast(substring(com,181,9) as varchar)
FROM dnsysconfig_detail
WHERE ctrlcode='60051' and additioncode='ExtendLabCode' and suffix=4

UNION ALL

SELECT DISTINCT Code as MotherCode ,cast(substring(com,191,9) as varchar)
FROM dnsysconfig_detail
WHERE ctrlcode='60051' and additioncode='ExtendLabCode' and suffix=4

UNION ALL

SELECT DISTINCT Code as MotherCode ,cast(substring(com,1,9) as varchar)
FROM dnsysconfig_detail
WHERE ctrlcode='60051' and additioncode='ExtendLabCode' and suffix=5

UNION ALL

SELECT DISTINCT Code as MotherCode ,cast(substring(com,11,9) as varchar)
FROM dnsysconfig_detail
WHERE ctrlcode='60051' and additioncode='ExtendLabCode' and suffix=5
	
UNION ALL

SELECT DISTINCT Code as MotherCode ,cast(substring(com,21,9) as varchar)
FROM dnsysconfig_detail
WHERE ctrlcode='60051' and additioncode='ExtendLabCode' and suffix=5

UNION ALL

SELECT DISTINCT Code as MotherCode ,cast(substring(com,31,9) as varchar)
FROM dnsysconfig_detail
WHERE ctrlcode='60051' and additioncode='ExtendLabCode' and suffix=5
	
UNION ALL

SELECT DISTINCT Code as MotherCode ,cast(substring(com,41,9) as varchar)
FROM dnsysconfig_detail
WHERE ctrlcode='60051' and additioncode='ExtendLabCode' and suffix=5

UNION ALL

SELECT DISTINCT Code as MotherCode ,cast(substring(com,51,9) as varchar)
FROM dnsysconfig_detail
WHERE ctrlcode='60051' and additioncode='ExtendLabCode' and suffix=5
	
UNION ALL

SELECT DISTINCT Code as MotherCode ,cast(substring(com,61,9) as varchar)
FROM dnsysconfig_detail
WHERE ctrlcode='60051' and additioncode='ExtendLabCode' and suffix=5

UNION ALL

SELECT DISTINCT Code as MotherCode ,cast(substring(com,71,9) as varchar)
FROM dnsysconfig_detail
WHERE ctrlcode='60051' and additioncode='ExtendLabCode' and suffix=5 

UNION ALL

SELECT DISTINCT Code as MotherCode ,cast(substring(com,81,9) as varchar)
FROM dnsysconfig_detail
WHERE ctrlcode='60051' and additioncode='ExtendLabCode' and suffix=5

UNION ALL

SELECT DISTINCT Code as MotherCode ,cast(substring(com,91,9) as varchar)
FROM dnsysconfig_detail
WHERE ctrlcode='60051' and additioncode='ExtendLabCode' and suffix=5

UNION ALL

SELECT DISTINCT Code as MotherCode ,cast(substring(com,101,9) as varchar)
FROM dnsysconfig_detail
WHERE ctrlcode='60051' and additioncode='ExtendLabCode' and suffix=5

UNION ALL

SELECT DISTINCT Code as MotherCode ,cast(substring(com,111,9) as varchar)
FROM dnsysconfig_detail
WHERE ctrlcode='60051' and additioncode='ExtendLabCode' and suffix=5

UNION ALL

SELECT DISTINCT Code as MotherCode ,cast(substring(com,121,9) as varchar)
FROM dnsysconfig_detail
WHERE ctrlcode='60051' and additioncode='ExtendLabCode' and suffix=5

UNION ALL

SELECT DISTINCT Code as MotherCode ,cast(substring(com,131,9) as varchar)
FROM dnsysconfig_detail
WHERE ctrlcode='60051' and additioncode='ExtendLabCode' and suffix=5

UNION ALL

SELECT DISTINCT Code as MotherCode ,cast(substring(com,141,9) as varchar)
FROM dnsysconfig_detail
WHERE ctrlcode='60051' and additioncode='ExtendLabCode' and suffix=5

UNION ALL

SELECT DISTINCT Code as MotherCode ,cast(substring(com,151,9) as varchar)
FROM dnsysconfig_detail
WHERE ctrlcode='60051' and additioncode='ExtendLabCode' and suffix=5

UNION ALL

SELECT DISTINCT Code as MotherCode ,cast(substring(com,161,9) as varchar)
FROM dnsysconfig_detail
WHERE ctrlcode='60051' and additioncode='ExtendLabCode' and suffix=5

UNION ALL

SELECT DISTINCT Code as MotherCode ,cast(substring(com,171,9) as varchar)
FROM dnsysconfig_detail
WHERE ctrlcode='60051' and additioncode='ExtendLabCode' and suffix=5

UNION ALL

SELECT DISTINCT Code as MotherCode ,cast(substring(com,181,9) as varchar)
FROM dnsysconfig_detail
WHERE ctrlcode='60051' and additioncode='ExtendLabCode' and suffix=5

UNION ALL

SELECT DISTINCT Code as MotherCode ,cast(substring(com,191,9) as varchar)
FROM dnsysconfig_detail
WHERE ctrlcode='60051' and additioncode='ExtendLabCode' and suffix=5
)

---------------------------------------------

SELECT 'PT2' as BU
	   , MotherCode as MotherLabCode
	   , dbo.sysconname(MotherCode,42136,2) as MotherLabNameTH
	   , dbo.sysconname(MotherCode,42136,1) as MotherLabNameEN
	   , ROW_NUMBER() OVER(PARTITION BY MotherCode ORDER BY b.MotherCode ) AS Suffix
	   , a.Code as LabCode
	   , dbo.sysconname(a.Code,42136,2) as LabCodeNameTH
	   , dbo.sysconname(a.Code,42136,1) as LabCodeNameEN
	   , cast(substring(com,105,1) as int) as OffCode
FROM dnsysconfig a
LEFT JOIN Mother b ON b.ExtendLab =a.code  and a.CtrlCode = 42136
WHERE b.MotherCode is not null
