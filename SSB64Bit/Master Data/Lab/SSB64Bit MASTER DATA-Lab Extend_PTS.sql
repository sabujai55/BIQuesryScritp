SELECT 'PTS' as BU
	   , b.Code as MotherLabCode
	   , dbo.sysconname(b.Code,42136,2) as MotherLabNameTH
	   , dbo.sysconname(b.Code,42136,1) as MotherLabNameEN
	   , ROW_NUMBER() OVER(PARTITION BY b.code ORDER BY b.LabCode ) AS Suffix
	   , b.LabCode as LabCode
	   , dbo.sysconname(b.LabCode,42136,2) as LabCodeNameTH
	   , dbo.sysconname(b.LabCode,42136,1) as LabCodeNameEN
	   , c.OffCode as OffCode
			FROM dnsysconfig a
			inner join (
								SELECT 
				T.Code,
				T.Suffix, 
				LabChild.LabCode 
			FROM [DEVDECRYPT].[dbo].[PYTS_SETUP_LAB_CODE_DTL_EXTEND_LAB] AS T
			CROSS APPLY (
				VALUES 
					('LabCode1',  LabCode1),
					('LabCode2',  LabCode2),
					('LabCode3',  LabCode3),
					('LabCode4',  LabCode4),
					('LabCode5',  LabCode5),
					('LabCode6',  LabCode6),
					('LabCode7',  LabCode7),
					('LabCode8',  LabCode8),
					('LabCode9',  LabCode9),
					('LabCode10', LabCode10)
			) AS LabChild(LabSource,LabCode)
			WHERE LabChild.LabCode IS NOT NULL
						) as b ON b.Code =a.code  and a.CtrlCode = 42136
			inner join DEVDECRYPT.dbo.PYTS_SETUP_LAB_CODE c ON b.LabCode=c.Code