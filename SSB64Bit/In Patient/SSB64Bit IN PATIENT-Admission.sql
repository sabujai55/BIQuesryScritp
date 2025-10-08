select top 10
		'PT2' as 'BU'
		,a.HN as 'PatientID'
		,CONVERT(varchar,a.ADMDATETIME,112)+a.AN as 'AdmitID'
		,a.ADMDATETIME as 'AdmitDateTime'
		,a.AdmCode as 'AdmitCode'
		,dbo.sysconname(a.AdmCode,42396,4) as 'AdmitName'
		,a.AN as 'AN'
		,a.ADMWARD as 'WardCode'
		,dbo.sysconname(a.ADMWARD,42201,2) as 'WardNameTH' --����ѹ��� 27/02/2568
		,dbo.sysconname(a.ADMWARD,42201,1) as 'WardNameEN' --�����ѹ��� 27/02/2568
		,a.AdmDoctor as 'DoctorCode'
		,dbo.CutSortChar(doc.LocalName) as 'DoctorNameTH' 
		,dbo.CutSortChar(doc.ENGLISHNAME) as 'DoctorNameEN' 
		,doc.CERTIFYPUBLICNO as 'DoctorCertificate' 
		,CAST(SUBSTRING(syw.Com,36,13)as varchar) as 'WardDepartmentCode'  --����ѹ��� 27/02/2568
		,dbo.sysconname(CAST(SUBSTRING(syw.Com,36,13)as varchar),10145,2) as 'WardDepartmentNameTH' --�����ѹ��� 27/02/2568
		,dbo.sysconname(CAST(SUBSTRING(syw.Com,36,13)as varchar),10145,1) as 'WardDepartmentNameEN' --�����ѹ��� 27/02/2568
		,a.DischargeCode as 'DischargeCode'
		,dbo.sysconname(a.DischargeCode,42262,2) as 'DischargeNameTH' --����ѹ��� 27/02/2568
		,dbo.sysconname(a.DischargeCode,42262,1) as 'DischargeNameEN' --�����ѹ��� 27/02/2568
		,case when a.DISCHARGEDATETIME is null then 'Active' else 'Inactive' end as 'Status'
		,a.AdmCount --�����ѹ��� 27/02/2568
		,a.AdmCode --�����ѹ��� 27/02/2568
		,dbo.sysconname(a.AdmCode,42396,2) as 'AdmTypeNameTH' --�����ѹ��� 27/02/2568
		,dbo.sysconname(a.AdmCode,42396,1) as 'AdmTypeNameEN' --�����ѹ��� 27/02/2568
		,a.AdmHNBedNo as 'HNBedNo' --�����ѹ��� 27/02/2568
		,dbo.sysconname(a.AdmHNBedNo,42421,2) as 'HNBedNameTH' --�����ѹ��� 27/02/2568
		,dbo.sysconname(a.AdmHNBedNo,42421,1) as 'HNBedNameEN' --�����ѹ��� 27/02/2568
		,a.WardAllowDischargeDateTime --�����ѹ��� 27/02/2568
		,a.ActiveWard as 'ActiveWardCode' --�����ѹ��� 27/02/2568
		,dbo.sysconname(a.ActiveWard,42201,2) as 'ActiveWardNameTH' --�����ѹ��� 27/02/2568
		,dbo.sysconname(a.ActiveWard,42201,1) as 'ActiveWardNameEN' --�����ѹ��� 27/02/2568
		,a.ActiveHNBedNo as 'ActiveHNBedNo' --�����ѹ��� 27/02/2568
		,dbo.sysconname(a.ActiveHNBedNo,42421,2) as 'ActiveHNBedNameTH' --�����ѹ��� 27/02/2568
		,dbo.sysconname(a.ActiveHNBedNo,42421,1) as 'ActiveHNBedNameEN' --�����ѹ��� 27/02/2568
		,a.DischargeDateTime --�����ѹ��� 27/02/2568
		,a.DiagnosisStatusType --�����ѹ��� 27/02/2568
		,case 
			when a.DiagnosisStatusType = 0 then 'None' 
			when a.DiagnosisStatusType = 1 then 'Recovery' 
			when a.DiagnosisStatusType = 2 then 'Improved' 
			when a.DiagnosisStatusType = 3 then 'Not_Improved' 
			when a.DiagnosisStatusType = 4 then 'Expire_No_Autopsy' 
			when a.DiagnosisStatusType = 5 then 'Expire_Autopsy' 
			when a.DiagnosisStatusType = 6 then 'Expire_Still_Berth' 
			when a.DiagnosisStatusType = 7 then 'Normal_Deliver' 
			when a.DiagnosisStatusType = 8 then 'Un_Deliver' 
			when a.DiagnosisStatusType = 9 then 'Normal_Child_DC_With_Mother' 
			when a.DiagnosisStatusType = 10 then 'Normal_Child_DC_Separate' 
		end as 'DiagnosisStatusName'
		,a.DefaultRightCode --�����ѹ��� 27/02/2568
		,dbo.sysconname(a.DefaultRightCode,42086,2) as 'DefaultRightNameTH' --�����ѹ��� 27/02/2568
		,dbo.sysconname(a.DefaultRightCode,42086,1) as 'DefaultRightNameEN' --�����ѹ��� 27/02/2568
		,a.ReAdmCode --�����ѹ��� 27/02/2568
		,dbo.sysconname(a.ReAdmCode,43583,2) as 'ReAdmitNameTH' --�����ѹ��� 27/02/2568
		,dbo.sysconname(a.ReAdmCode,43583,1) as 'ReAdmitNameEN' --�����ѹ��� 27/02/2568
		,a.FromClinic as 'AdmitLocationCode' --�����ѹ��� 27/02/2568
		,dbo.sysconname(a.FromClinic,42203,2) as 'AdmitLocationNameTH' --�����ѹ��� 27/02/2568
		,dbo.sysconname(a.FromClinic,42203,1) as 'AdmitLocationNameEN' --�����ѹ��� 27/02/2568
			from HNIPD_MASTER a
			left join HNDOCTOR_MASTER doc on a.AdmDoctor=doc.Doctor
			left join DNSYSCONFIG syw on a.AdmWard = syw.Code and syw.CtrlCode = 42201