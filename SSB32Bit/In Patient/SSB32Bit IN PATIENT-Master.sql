select top 10 
		'PLS' as 'BU'
		,a.HN as 'PatientID'
		,CONVERT(varchar,a.ADMDATETIME,112)+a.AN as 'AdmitID'
		,a.ADMDATETIME as 'AdmitDateTime'
		,a.AN as 'AN'
		,a.ADMWARD as 'WardCode'
		,dbo.sysconname(a.ADMWARD,20024,2) as 'WardNameTH' 
		,dbo.sysconname(a.ADMWARD,20024,1) as 'WardNameEN' 
		,'' as 'WardDepartmentCode'
		,'' as 'WardDepartmentNameTH'
		,'' as 'WardDepartmentNameEN'
		,ipddoc.DOCTOR as 'DoctorMasterCode'
		,dbo.CutSortChar(doc.THAINAME) as 'DoctorMasterNameTH'
		,dbo.CutSortChar(doc.ENGLISHNAME) as 'DoctorMasterNameEN'
		,doc.CERTIFYPUBLICNO as 'DoctorCertificate'
		, doc.CLINIC as 'DoctorMasterClinicCode'
		, dbo.sysconname(doc.CLINIC,20016,2) as 'DoctorMasterClinicNameTH'
		, dbo.sysconname(doc.CLINIC,20016,1) as 'DoctorMasterClinicNameEN'
		, '' as 'DoctorMasterDepartmentCode'
		, '' as 'DoctorMasterDepartmentNameTH'
		, '' as 'DoctorMasterDepartmentNameEN'
		, doc.SPECIALTY+doc.SUBSPECIALTY as 'DoctorMasterSpecialtyCode'
		, dbo.CutSortChar(ssp.THAINAME) as 'DoctorMasterSpecialtyNameTH'
		, dbo.CutSortChar(ssp.ENGLISHNAME) as 'DoctorMasterSpecialtyNameEN'
		,a.DISCHARGETYPE as 'DischargeCode'
		,dbo.sysconname(a.DISCHARGETYPE,20044,2) as 'DischargeNameTH' 
		,dbo.sysconname(a.DISCHARGETYPE,20044,1) as 'DischargeNameEN' 
		,case when a.DISCHARGEDATETIME is null then 'Active' else 'Inactive' end as 'Status'
		,'' as 'AdmCount' 
		,a.ADMTYPE as 'AdmType' 
		,dbo.sysconname(a.ADMTYPE,20048,2) as 'AdmTypeNameTH'
		,dbo.sysconname(a.ADMTYPE,20048,1) as 'AdmTypeNameEN'
		,b.BEDNO as 'HNBedNo'
		,dbo.CutSortChar(bed.THAINAME) as 'HNBedNameTH'
		,dbo.CutSortChar(bed.ENGLISHNAME) as 'HNBedNameEN'
		,c.WARD as 'ActiveWardCode'
		,dbo.sysconname(c.WARD,20024,2) as 'ActiveWardNameTH'
		,dbo.sysconname(c.WARD,20024,1) as 'ActiveWardNameEN'
		,c.BEDNO as 'ActiveHNBedNo'
		,dbo.CutSortChar(bedactive.THAINAME) as 'ActiveHNBedNameTH'
		,dbo.CutSortChar(bedactive.ENGLISHNAME) as 'ActiveHNBedNameEN'
		, '' as 'DoctorDischargeDateTime'
		, dth.MAKEDATETIME as 'DrugTakeHomeDateTime'
		, lord.MAKEDATETIME as 'LastOrderDateTime'
		, a.WARDALLOWDISCHARGEDATETIME as 'WardAllowDischargeDateTime'
		, a.ACCOUNTALLOWRELEASEDATETIME as 'FinanceialDateTime'
		,a.DISCHARGEDATETIME as 'WardDischargeDateTime'
		,a.DIAGNOSESSTATUS as 'DiagnosisStatusType'
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
		end as 'DiagnosisStatusName'
		,a.USEDRIGHTCODE as 'DefaultRightCode'
		,dbo.sysconname(a.USEDRIGHTCODE,20019,2) as 'DefaultRightNameTH'
		,dbo.sysconname(a.USEDRIGHTCODE,20019,1) as 'DefaultRightNameEN'
		,'' as 'ReAdmitCode'
		,'' as 'ReAdmitNameTH'
		,'' as 'ReAdmitNameEN'
		,admfrom.CLINIC as 'AdmitLocationCode'
		,dbo.sysconname(admfrom.CLINIC,20016,2) as 'AdmitLocationNameTH'
		,dbo.sysconname(admfrom.CLINIC,20016,1) as 'AdmitLocationNameEN'
		, '' as 'AgencyCode'
		, '' as 'AgencyNameTH'
		, '' as 'AgencyNameEN'
				from ADMMASTER a 
				left join IPDDOCTOR ipddoc on a.AN=ipddoc.AN and ipddoc.SPECIALIZEDOCTORTYPE = 1
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
				left join (
						select ROW_NUMBER() over(partition by AN order by MAKEDATETIME desc) as seq 
						,MAKEDATETIME
						,AN
						from IPDDRUGHIST 
						where MEDICINEORDERTYPE = 3
				) dth on a.AN=dth.AN and dth.seq = 1 --DrugTakeHome
				left join (
					select ROW_NUMBER() over(partition by AN order by MAKEDATETIME desc) as seq 
					,MAKEDATETIME 
					,AN
					from IPDCHRG 
				) lord on a.AN=lord.AN and lord.seq=1 --LastOrder
				left join SYSCONFIG ssp on doc.SPECIALTY+doc.SUBSPECIALTY = REPLACE(ssp.CODE,' ','') and ssp.CTRLCODE = 20015