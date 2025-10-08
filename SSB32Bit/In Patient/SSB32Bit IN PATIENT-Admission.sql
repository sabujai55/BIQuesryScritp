select top 10 
		'PLS' as 'BU'
		,a.HN as 'PatientID'
		,CONVERT(varchar,a.ADMDATETIME,112)+a.AN as 'AdmitID'
		,a.ADMDATETIME as 'AdmitDateTime'
		,a.ADMTYPE as 'AdmitCode'
		,dbo.sysconname(a.ADMTYPE,20048,4) as 'AdmitName'
		,a.AN as 'AN'
		,a.ADMWARD as 'WardCode'
		,dbo.sysconname(a.ADMWARD,20024,2) as 'WardNameTH' --����ѹ��� 28/02/2568
		,dbo.sysconname(a.ADMWARD,20024,1) as 'WardNameEN' --�����ѹ��� 28/02/2568
		,ipddoc.DOCTOR as 'DoctorCode'
		,dbo.CutSortChar(doc.THAINAME) as 'DoctorNameTH'
		,dbo.CutSortChar(doc.ENGLISHNAME) as 'DoctorNameEN'
		,doc.CERTIFYPUBLICNO as 'DoctorCertificate'
		,'' as 'WardDepartmentCode' --����ѹ��� 28/02/2568
		,'' as 'WardDepartmentNameTH' --�����ѹ��� 28/02/2568
		,'' as 'WardDepartmentNameEN' --�����ѹ��� 28/02/2568
		,a.DISCHARGETYPE as 'DischargeCode'
		,dbo.sysconname(a.DISCHARGETYPE,20044,2) as 'DischargeNameTH' --����ѹ��� 28/02/2568
		,dbo.sysconname(a.DISCHARGETYPE,20044,1) as 'DischargeNameEN' --�����ѹ��� 28/02/2568
		,case when a.DISCHARGEDATETIME is null then 'Active' else 'Inactive' end as 'Status'
		,'' as 'AdmCount' --�����ѹ��� 28/02/2568
		,a.ADMTYPE as 'AdmType' --�����ѹ��� 28/02/2568
		,dbo.sysconname(a.ADMTYPE,20048,2) as 'AdmTypeNameTH' --�����ѹ��� 28/02/2568
		,dbo.sysconname(a.ADMTYPE,20048,1) as 'AdmTypeNameEN' --�����ѹ��� 28/02/2568
		,b.BEDNO as 'HNBedNo' --�����ѹ��� 28/02/2568
		,dbo.CutSortChar(bed.THAINAME) as 'HNBedNameTH' --�����ѹ��� 28/02/2568
		,dbo.CutSortChar(bed.ENGLISHNAME) as 'HNBedNameEN' --�����ѹ��� 28/02/2568
		,a.WARDALLOWDISCHARGEDATETIME as 'WardAllowDischargeDateTime' --�����ѹ��� 28/02/2568
		,c.WARD as 'ActiveWardCode' --�����ѹ��� 28/02/2568
		,dbo.sysconname(c.WARD,20024,2) as 'ActiveWardNameTH' --�����ѹ��� 28/02/2568
		,dbo.sysconname(c.WARD,20024,1) as 'ActiveWardNameEN' --�����ѹ��� 28/02/2568
		,c.BEDNO as 'ActiveHNBedNo' --�����ѹ��� 28/02/2568
		,dbo.CutSortChar(bedactive.THAINAME) as 'ActiveHNBedNameTH' --�����ѹ��� 28/02/2568
		,dbo.CutSortChar(bedactive.ENGLISHNAME) as 'ActiveHNBedNameEN' --�����ѹ��� 28/02/2568
		,a.DISCHARGEDATETIME as 'DischargeDateTime' --�����ѹ��� 28/02/2568
		,a.DIAGNOSESSTATUS as 'DiagnosisStatusType' --�����ѹ��� 28/02/2568
		,case 
			when a.DIAGNOSESSTATUS = 0 then 'None' 
			when a.DIAGNOSESSTATUS = 1 then 'Recovery' 
			when a.DIAGNOSESSTATUS = 2 then 'Improved' 
			when a.DIAGNOSESSTATUS = 3 then 'Not_Improved' 
			when a.DIAGNOSESSTATUS = 7 then 'DEAD' 
			when a.DIAGNOSESSTATUS = 8 then 'DEAD_NOAUTOPSY' 
			when a.DIAGNOSESSTATUS = 9 then 'DEAD_AUTOPSY' 
			when a.DIAGNOSESSTATUS = 10 then 'DEAD_STILLBERTH' 
			when a.DIAGNOSESSTATUS = 11 then 'NORMAL_DELIVERY' 
			when a.DIAGNOSESSTATUS = 12 then 'UNDERIVER' 
			when a.DIAGNOSESSTATUS = 13 then 'NORMAL_CHILD_DC_WITH_MOTHER' 
			when a.DIAGNOSESSTATUS = 14 then 'NORMAL_CHILD_DC_SEPRATELY' 
		end as 'DiagnosisStatusName' --�����ѹ��� 28/02/2568
		,a.USEDRIGHTCODE as 'DefaultRightCode' --�����ѹ��� 28/02/2568
		,dbo.sysconname(a.USEDRIGHTCODE,20019,2) as 'DefaultRightNameTH' --�����ѹ��� 28/02/2568
		,dbo.sysconname(a.USEDRIGHTCODE,20019,1) as 'DefaultRightNameEN' --�����ѹ��� 28/02/2568
		,'' as 'ReAdmitCode' --�����ѹ��� 28/02/2568
		,'' as 'ReAdmitNameTH' --�����ѹ��� 28/02/2568
		,'' as 'ReAdmitNameEN' --�����ѹ��� 28/02/2568
		,admfrom.CLINIC as 'AdmitLocationCode' --�����ѹ��� 28/02/2568
		,dbo.sysconname(admfrom.CLINIC,20016,2) as 'AdmitLocationNameTH' --�����ѹ��� 28/02/2568
		,dbo.sysconname(admfrom.CLINIC,20016,1) as 'AdmitLocationNameEN' --�����ѹ��� 28/02/2568
				from ADMMASTER a 
				left join IPDDOCTOR ipddoc on a.AN=ipddoc.AN and ipddoc.THISDOCTORADM = 1
				left join HNDOCTOR doc on ipddoc.DOCTOR=doc.DOCTOR
				left join (
						select ROW_NUMBER() over(partition by AN order by INDATETIME asc) as seq
						,AN
						,MAKEDATETIME
						,INDATETIME
						,OUTDATETIME
						,BEDNO
						,WARD
						from ADMBED
				) b on a.AN=b.AN and b.seq = 1
				left join HNBEDINV bed on b.BEDNO=bed.BEDNO
				left join (
						select ROW_NUMBER() over(partition by AN order by INDATETIME desc) as seq
						,AN
						,MAKEDATETIME
						,INDATETIME
						,OUTDATETIME
						,BEDNO
						,WARD
						from ADMBED
				) c on a.AN=c.AN and c.seq = 1
				left join HNBEDINV bedactive on c.BEDNO=bedactive.BEDNO 
				left join (
						select a.HN
						,a.AN
						,a.ADMDATETIME
						,b.VISITDATE
						,b.VN
						,c.CLINIC
						from ADMMASTER a
						inner join VNMST b on a.HN=b.HN and CONVERT(DATE,a.ADMDATETIME) = CONVERT(DATE,b.VISITDATE)
						inner join VNPRES c on b.VISITDATE=c.VISITDATE and b.VN=c.VN and c.CLOSEVISITTYPE = '8'
				) admfrom on a.AN=admfrom.AN and a.HN=admfrom.HN