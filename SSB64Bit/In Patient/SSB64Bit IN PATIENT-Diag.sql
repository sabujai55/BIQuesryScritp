select top 10
'PT2' as BU,
adm.HN as PatientID,
CONVERT(varchar,adm.AdmDateTime,112)+adm.AN as AdmitID,
adm.AdmDateTime as AdmitDate,
adm.AN as AN,
ipddiag.SuffixTiny as Suffix,
adm.AdmWard as LocationCode,
dbo.sysconname(adm.AdmWard,42201,2) as LocationNameTH, --����ѹ��� 03/03/2568
dbo.sysconname(adm.AdmWard,42201,1) as LocationNameEN, --�����ѹ��� 03/03/2568
ipddiag.DiagDateTime as DiagDateTime,
ipddiag.ICDCode as ICDCode,
SUBSTRING(icd.EnglishName,2,500) as ICDName,
ipddiag.IcdCmCode1 as ICDCmCode1,
SUBSTRING(icdcm1.EnglishName,2,500) as ICDCmName1,
ipddiag.IcdCmCode2 as ICDCmCode2,
SUBSTRING(icdcm2.EnglishName,2,500) as ICDCmName2,
ipddiag.IcdCmCode3 as ICDCmCode3,
SUBSTRING(icdcm3.EnglishName,2,500) as ICDCmName3,
ipddiag.IcdCmCode4 as ICDCmCode4,
SUBSTRING(icdcm4.EnglishName,2,500) as ICDCmName4,
ipddiag.IcdCmCode5 as ICDCmCode5,
SUBSTRING(icdcm5.EnglishName,2,500) as ICDCmName5,
ipddiag.IcdCmCode6 as ICDCmCode6,
SUBSTRING(icdcm6.EnglishName,2,500) as ICDCmName6,
ipddiag.IcdCmCode7 as ICDCmCode7,
SUBSTRING(icdcm7.EnglishName,2,500) as ICDCmName7,
ipddiag.IcdCmCode8 as ICDCmCode8,
SUBSTRING(icdcm8.EnglishName,2,500) as ICDCmName8,
ipddiag.IcdCmCode9 as ICDCmCode9,
SUBSTRING(icdcm9.EnglishName,2,500) as ICDCmName9,
ipddiag.IcdCmCode10 as ICDCmCode10,
SUBSTRING(icdcm10.EnglishName,2,500) as ICDCmName10,
ipddiag.EntryByUserCode as EntryByUserCode, --����ѹ��� 03/03/2568
dbo.sysconname(ipddiag.EntryByUserCode,10031,2) as EntryByUserNameTH, --�����ѹ��� 03/03/2568
dbo.sysconname(ipddiag.EntryByUserCode,10031,1) as EntryByUserNameEN, --�����ѹ��� 03/03/2568
ipddiag.RegisterDate as RegisterDate,
ipddiag.ChronicCreteriaCode as ChronicCreteriaCode,
'' as ChronicCreteriaName,
ipddiag.Doctor as DoctorCode, --�����ѹ��� 03/03/2568
dbo.CutSortChar(doc.LocalName) as DoctorNameTH, --�����ѹ��� 03/03/2568
dbo.CutSortChar(doc.EnglishName) as DoctorNameEN, --�����ѹ��� 03/03/2568
ipddiag.ECode, --�����ѹ��� 03/03/2568
dbo.CutSortChar(icde.EnglishName) as ECodeName, --�����ѹ��� 03/03/2568
ipddiag.RemarksMemo, --�����ѹ��� 03/03/2568
ipddiag.UnderlyingICDCode1, --�����ѹ��� 03/03/2568
dbo.CutSortChar(un1.EnglishName) as UnderlyingICDName1, --�����ѹ��� 03/03/2568
ipddiag.UnderlyingICDCode2, --�����ѹ��� 03/03/2568
dbo.CutSortChar(un2.EnglishName) as UnderlyingICDName2, --�����ѹ��� 03/03/2568
ipddiag.UnderlyingICDCode3, --�����ѹ��� 03/03/2568
dbo.CutSortChar(un3.EnglishName) as UnderlyingICDName3, --�����ѹ��� 03/03/2568
ipddiag.UnderlyingICDCode4, --�����ѹ��� 03/03/2568
dbo.CutSortChar(un4.EnglishName) as UnderlyingICDName4, --�����ѹ��� 03/03/2568
ipddiag.UnderlyingICDCode5, --�����ѹ��� 03/03/2568
dbo.CutSortChar(un5.EnglishName) as UnderlyingICDName5, --�����ѹ��� 03/03/2568
ipddiag.ComplicationsICDCode1, --�����ѹ��� 03/03/2568
dbo.CutSortChar(com1.EnglishName) as ComplicationsICDName1, --�����ѹ��� 03/03/2568
ipddiag.ComplicationsICDCode2, --�����ѹ��� 03/03/2568
dbo.CutSortChar(com2.EnglishName) as ComplicationsICDName2, --�����ѹ��� 03/03/2568
ipddiag.ComplicationsICDCode3, --�����ѹ��� 03/03/2568
dbo.CutSortChar(com3.EnglishName) as ComplicationsICDName3, --�����ѹ��� 03/03/2568
ipddiag.ComplicationsICDCode4, --�����ѹ��� 03/03/2568
dbo.CutSortChar(com4.EnglishName) as ComplicationsICDName4, --�����ѹ��� 03/03/2568
ipddiag.ComplicationsICDCode5, --�����ѹ��� 03/03/2568
dbo.CutSortChar(com5.EnglishName) as ComplicationsICDName5, --�����ѹ��� 03/03/2568
ipddiag.OtherICDCode1, --�����ѹ��� 03/03/2568
dbo.CutSortChar(ot1.EnglishName) as OtherICDName1, --�����ѹ��� 03/03/2568
ipddiag.OtherICDCode2, --�����ѹ��� 03/03/2568
dbo.CutSortChar(ot2.EnglishName) as OtherICDName2, --�����ѹ��� 03/03/2568
ipddiag.OtherICDCode3, --�����ѹ��� 03/03/2568
dbo.CutSortChar(ot3.EnglishName) as OtherICDName3, --�����ѹ��� 03/03/2568
ipddiag.OtherICDCode4, --�����ѹ��� 03/03/2568
dbo.CutSortChar(ot4.EnglishName) as OtherICDName4, --�����ѹ��� 03/03/2568
ipddiag.OperationDoctor1, --�����ѹ��� 03/03/2568
dbo.Doctorname(ipddiag.OperationDoctor1,2) as OperationDoctorName1, --�����ѹ��� 03/03/2568
ipddiag.OperationDoctor2, --�����ѹ��� 03/03/2568
dbo.Doctorname(ipddiag.OperationDoctor2,2) as OperationDoctorName2, --�����ѹ��� 03/03/2568
ipddiag.OperationDoctor3, --�����ѹ��� 03/03/2568
dbo.Doctorname(ipddiag.OperationDoctor3,2) as OperationDoctorName3, --�����ѹ��� 03/03/2568
ipddiag.OperationDoctor4, --�����ѹ��� 03/03/2568
dbo.Doctorname(ipddiag.OperationDoctor4,2) as OperationDoctorName4, --�����ѹ��� 03/03/2568
ipddiag.OperationDoctor5, --�����ѹ��� 03/03/2568
dbo.Doctorname(ipddiag.OperationDoctor5,2) as OperationDoctorName5, --�����ѹ��� 03/03/2568
ipddiag.OperationDoctor6, --�����ѹ��� 03/03/2568
dbo.Doctorname(ipddiag.OperationDoctor6,2) as OperationDoctorName6, --�����ѹ��� 03/03/2568
ipddiag.OperationDoctor7, --�����ѹ��� 03/03/2568
dbo.Doctorname(ipddiag.OperationDoctor7,2) as OperationDoctorName7, --�����ѹ��� 03/03/2568
ipddiag.OperationDoctor8, --�����ѹ��� 03/03/2568
dbo.Doctorname(ipddiag.OperationDoctor8,2) as OperationDoctorName8, --�����ѹ��� 03/03/2568
ipddiag.OperationDoctor9, --�����ѹ��� 03/03/2568
dbo.Doctorname(ipddiag.OperationDoctor9,2) as OperationDoctorName9, --�����ѹ��� 03/03/2568
ipddiag.OperationDoctor10, --�����ѹ��� 03/03/2568
dbo.Doctorname(ipddiag.OperationDoctor10,2) as OperationDoctorName10 --�����ѹ��� 03/03/2568
		from HNIPD_MASTER adm
		left join HNIPD_DIAG ipddiag on adm.AN=ipddiag.AN
		left join HNICD_MASTER icd on ipddiag.ICDCode = icd.IcdCode
		left join HNICDCM_MASTER icdcm1 on ipddiag.IcdCmCode1=icdcm1.IcdCmCode
		left join HNICDCM_MASTER icdcm2 on ipddiag.IcdCmCode2=icdcm2.IcdCmCode
		left join HNICDCM_MASTER icdcm3 on ipddiag.IcdCmCode3=icdcm3.IcdCmCode
		left join HNICDCM_MASTER icdcm4 on ipddiag.IcdCmCode4=icdcm4.IcdCmCode
		left join HNICDCM_MASTER icdcm5 on ipddiag.IcdCmCode5=icdcm5.IcdCmCode
		left join HNICDCM_MASTER icdcm6 on ipddiag.IcdCmCode6=icdcm6.IcdCmCode
		left join HNICDCM_MASTER icdcm7 on ipddiag.IcdCmCode7=icdcm7.IcdCmCode
		left join HNICDCM_MASTER icdcm8 on ipddiag.IcdCmCode8=icdcm8.IcdCmCode
		left join HNICDCM_MASTER icdcm9 on ipddiag.IcdCmCode9=icdcm9.IcdCmCode
		left join HNICDCM_MASTER icdcm10 on ipddiag.IcdCmCode10=icdcm10.IcdCmCode
		left join HNDOCTOR_MASTER doc on ipddiag.Doctor = doc.Doctor
		left join HNICD_MASTER icde on ipddiag.ECode = icde.IcdCode
		left join HNICD_MASTER un1 on ipddiag.UnderlyingICDCode1 = un1.IcdCode
		left join HNICD_MASTER un2 on ipddiag.UnderlyingICDCode2 = un2.IcdCode
		left join HNICD_MASTER un3 on ipddiag.UnderlyingICDCode3 = un3.IcdCode
		left join HNICD_MASTER un4 on ipddiag.UnderlyingICDCode4 = un4.IcdCode
		left join HNICD_MASTER un5 on ipddiag.UnderlyingICDCode5 = un5.IcdCode
		left join HNICD_MASTER com1 on ipddiag.ComplicationsICDCode1 = com1.IcdCode
		left join HNICD_MASTER com2 on ipddiag.ComplicationsICDCode2 = com2.IcdCode
		left join HNICD_MASTER com3 on ipddiag.ComplicationsICDCode3 = com3.IcdCode
		left join HNICD_MASTER com4 on ipddiag.ComplicationsICDCode4 = com4.IcdCode
		left join HNICD_MASTER com5 on ipddiag.ComplicationsICDCode5 = com5.IcdCode
		left join HNICD_MASTER ot1 on ipddiag.OtherICDCode1 = ot1.IcdCode
		left join HNICD_MASTER ot2 on ipddiag.OtherICDCode2 = ot2.IcdCode
		left join HNICD_MASTER ot3 on ipddiag.OtherICDCode3 = ot3.IcdCode
		left join HNICD_MASTER ot4 on ipddiag.OtherICDCode4 = ot4.IcdCode
		--where ipddiag.ChronicCreteriaCode is not null
		
