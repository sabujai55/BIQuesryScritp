select top 1000
'PLS' as 'BU'
,a.HN as 'PatientID'
,CONVERT(varchar,a.ADMDATETIME,112)+a.AN as 'AdmitID'
,doc.AN
,doc.ENTRYDOCDATETIME as 'MakeDateTime'
,doc.Doctor as 'DoctorCode'
,dbo.CutSortChar(dm.THAINAME) as 'DoctorNameTH'
,dbo.CutSortChar(dm.EnglishName) as 'DoctorNameEN'
,doc.PRIVATECASE as 'PrivateCase'
,doc.SPECIALIZEDOCTORTYPE as 'DoctorType'
,case
	when doc.SPECIALIZEDOCTORTYPE = '0' then 'CONSULT'
	when doc.SPECIALIZEDOCTORTYPE = '1' then 'MASTER'
	when doc.SPECIALIZEDOCTORTYPE = '2' then 'OR'
	when doc.SPECIALIZEDOCTORTYPE = '3' then 'ANESTHESIOLOGIST'
	when doc.SPECIALIZEDOCTORTYPE = '4' then 'LR'
	when doc.SPECIALIZEDOCTORTYPE = '5' then 'PT'
	when doc.SPECIALIZEDOCTORTYPE = '6' then 'NURSE_LR'
	when doc.SPECIALIZEDOCTORTYPE = '7' then 'NURSE_OR_ASSISTANT'
	when doc.SPECIALIZEDOCTORTYPE = '8' then 'NURSE_OR_SCRUB'
	when doc.SPECIALIZEDOCTORTYPE = '9' then 'NURSE_OR_CIRCULATE'
	when doc.SPECIALIZEDOCTORTYPE = '10' then 'NONE'
end as 'DoctorTypeName'
,doc.THISDOCTORADM
,doc.THISDOCTORDISCHARGE
,doc.RemarksMemo
		from IPDDOCTOR doc
		left join ADMMASTER a on doc.AN=a.AN
		left join HNDOCTOR dm on doc.Doctor=dm.Doctor
		order by doc.AN desc