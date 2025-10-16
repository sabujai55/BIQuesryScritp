use SSBLIVE
go

select	'PT2' as 'BU'
		,vnm.HN as 'PatientID'
		,convert(varchar,vnd.VISITDATE,112)+convert(varchar,vnd.VN)+convert(varchar,vnd.PrescriptionNo) as 'VisitID'
		,vnd.VisitDate as 'VisitDate'
		,vnd.VN as 'VN'
		,vnd.PrescriptionNo as 'PrescriptionNo'
		,vnd.SuffixSmall as 'Suffix'
		,vnp.Clinic as ClinicCode
		,dbo.sysconname(vnp.Clinic,42203,2) as ClinicNameTH
		,dbo.sysconname(vnp.Clinic,42203,1) as ClinicNameEN
		,vnd.DiagDateTime as 'DiagDateTime'
		, vnd.ICDCode as PrimaryCode
		, dbo.ICDname(vnd.ICDCode,2) as PrimaryNameTH
		, dbo.ICDname(vnd.ICDCode,1) as PrimaryNameEN

		,vnd.IcdCmCode1 as 'ICDCmCode1'
		, dbo.ICDCMname(vnd.IcdCmCode1,2) as ICDCM1NameTH
		, dbo.ICDCMname(vnd.IcdCmCode1,1) as ICDCM1NameEN
		,vnd.IcdCmCode2 as 'ICDCmCode2'
		, dbo.ICDCMname(vnd.IcdCmCode2,2) as ICDCM2NameTH
		, dbo.ICDCMname(vnd.IcdCmCode2,1) as ICDCM2NameEN
		,vnd.IcdCmCode3 as 'ICDCmCode3'
		, dbo.ICDCMname(vnd.IcdCmCode3,2) as ICDCM3NameTH
		, dbo.ICDCMname(vnd.IcdCmCode3,1) as ICDCM3NameEN
		,vnd.IcdCmCode4 as 'ICDCmCode4'
		, dbo.ICDCMname(vnd.IcdCmCode4,2) as ICDCM4NameTH
		, dbo.ICDCMname(vnd.IcdCmCode4,1) as ICDCM4NameEN
		,vnd.IcdCmCode5 as 'ICDCmCode5'
		, dbo.ICDCMname(vnd.IcdCmCode5,2) as ICDCM5NameTH
		, dbo.ICDCMname(vnd.IcdCmCode5,1) as ICDCM5NameEN
		,vnd.IcdCmCode6 as 'ICDCmCode6'
		, dbo.ICDCMname(vnd.IcdCmCode6,2) as ICDCM6NameTH
		, dbo.ICDCMname(vnd.IcdCmCode6,1) as ICDCM6NameEN
		,vnd.IcdCmCode7 as 'ICDCmCode7'
		, dbo.ICDCMname(vnd.IcdCmCode7,2) as ICDCM7NameTH
		, dbo.ICDCMname(vnd.IcdCmCode7,1) as ICDCM7NameEN
		,vnd.IcdCmCode8 as 'ICDCmCode8'
		, dbo.ICDCMname(vnd.IcdCmCode8,2) as ICDCM8NameTH
		, dbo.ICDCMname(vnd.IcdCmCode8,1) as ICDCM8NameEN
		,vnd.IcdCmCode9 as 'ICDCmCode9'
		, dbo.ICDCMname(vnd.IcdCmCode9,2) as ICDCM9NameTH
		, dbo.ICDCMname(vnd.IcdCmCode9,1) as ICDCM9NameEN
		,vnd.IcdCmCode10 as 'ICDCmCode10'
		, dbo.ICDCMname(vnd.IcdCmCode10,2) as ICDCM10NameTH
		, dbo.ICDCMname(vnd.IcdCmCode10,1) as ICDCM10NameEN
		,vnd.EntryByUserCode as 'EntryByUserCode'
		,dbo.sysconname(vnd.EntryByUserCode,10031,2) as 'EntryByUserNameTH' --เปลี่ยน จาก Code เป็น Name
		,dbo.sysconname(vnd.EntryByUserCode,10031,1) as 'EntryByUserNameEN'
		,vnd.RegisterDate as 'RegisterDate'
		,vnd.ChronicCreteriaCode as 'ChronicCreteriaCode'
		,dbo.sysconname(vnd.ChronicCreteriaCode,43523,4) as 'ChronicCreteriaName'
		,vnd.RemarksMemo as 'RemarksMemo' --เพิ่มวันที่ 17/02/2568
		,vnd.ECode as 'ECode' --เพิ่มวันที่ 17/02/2568
		, dbo.ICDname(vnd.ECode,2) as ECodeNameTH
		, dbo.ICDname(vnd.ECode,1) as ECodeNameEN
		, dbo.GetDiagComorbidity(vnd.VisitDate, vnd.VN, vnd.PrescriptionNo,1) as ComobidityCode1
		, dbo.ICDname(dbo.GetDiagComorbidity(vnd.VisitDate, vnd.VN, vnd.PrescriptionNo,1),2) as Comobidity1NameTH
		, dbo.ICDname(dbo.GetDiagComorbidity(vnd.VisitDate, vnd.VN, vnd.PrescriptionNo,1),1) as Comobidity1NameEN
		, dbo.GetDiagComorbidity(vnd.VisitDate, vnd.VN, vnd.PrescriptionNo,2) as ComobidityCode2
		, dbo.ICDname(dbo.GetDiagComorbidity(vnd.VisitDate, vnd.VN, vnd.PrescriptionNo,2),2) as Comobidity2NameTH
		, dbo.ICDname(dbo.GetDiagComorbidity(vnd.VisitDate, vnd.VN, vnd.PrescriptionNo,2),1) as Comobidity2NameEN
		, dbo.GetDiagComorbidity(vnd.VisitDate, vnd.VN, vnd.PrescriptionNo,3) as ComobidityCode3
		, dbo.ICDname(dbo.GetDiagComorbidity(vnd.VisitDate, vnd.VN, vnd.PrescriptionNo,3),2) as Comobidity3NameTH
		, dbo.ICDname(dbo.GetDiagComorbidity(vnd.VisitDate, vnd.VN, vnd.PrescriptionNo,3),1) as Comobidity3NameEN
		, dbo.GetDiagComorbidity(vnd.VisitDate, vnd.VN, vnd.PrescriptionNo,4) as ComobidityCode4
		, dbo.ICDname(dbo.GetDiagComorbidity(vnd.VisitDate, vnd.VN, vnd.PrescriptionNo,4),2) as Comobidity4NameTH
		, dbo.ICDname(dbo.GetDiagComorbidity(vnd.VisitDate, vnd.VN, vnd.PrescriptionNo,4),1) as Comobidity4NameEN
		, dbo.GetDiagComorbidity(vnd.VisitDate, vnd.VN, vnd.PrescriptionNo,5) as ComobidityCode5
		, dbo.ICDname(dbo.GetDiagComorbidity(vnd.VisitDate, vnd.VN, vnd.PrescriptionNo,5),2) as Comobidity5NameTH
		, dbo.ICDname(dbo.GetDiagComorbidity(vnd.VisitDate, vnd.VN, vnd.PrescriptionNo,5),1) as Comobidity5NameEN
from	HNOPD_PRESCRIP_DIAG vnd
		inner join HNOPD_PRESCRIP vnp on vnd.VN=vnp.VN and vnd.VisitDate=vnp.VisitDate and vnd.PrescriptionNo=vnp.PrescriptionNo
		inner join HNOPD_MASTER vnm on vnd.VN=vnm.VN and vnd.VisitDate=vnm.VisitDate
		inner join HNICD_MASTER icd on vnd.ICDCode=icd.IcdCode and vnd.DiagnosisRecordType = 1
		left join HNICD_MASTER icde on vnd.ECode=icde.IcdCode
where	vnd.VisitDate = CAST(GETDATE()-1 as date)

