with setup_labreqmtd as
(
select	a.CODE as LabReqMtdCode
		, coalesce(dbo.cutsortchar(a.THAINAME),'') as description_th
		, coalesce(dbo.cutsortchar(a.ENGLISHNAME),'') as description_en
		, CAST(SUBSTRING(b.COM,0,6) as varchar(6)) as LabExtendCode
		, b.SUFFIX

from	SYSCONFIG a 
		left join SYSCONFIG_DETAIL b on b.CTRLCODE = 10026 and a.CODE = b.CODE
where	a.CTRLCODE = 20068
)
select
		  'PLS' as BU
		, lm.[CODE] as MotherLabCode
		, dbo.CutSortChar(lm.THAINAME) as MotherLabNameTH
		, dbo.CutSortChar(lm.ENGLISHNAME) as MotherLabNameEN
		, lmt.SUFFIX as Suffix
		, lmt.LabExtendCode as LabCode
		, dbo.sysconname(lmt.LabExtendCode,20067,2) as LabCodeNameTH
		, dbo.sysconname(lmt.LabExtendCode,20067,1) as LabCodeNameEN
		, (select CAST(SUBSTRING(A.COM,243,1)as int) from SYSCONFIG A where A.CTRLCODE = 20067 and A.CODE=lmt.LabExtendCode) as OffCode
				from setup_labreqmtd lmt
				inner join SYSCONFIG lm on lmt.LabReqMtdCode=CAST(SUBSTRING(lm.COM,169,5) as varchar(5)) and lmt.LabReqMtdCode <> '' and lm.CTRLCODE = 20067
				
