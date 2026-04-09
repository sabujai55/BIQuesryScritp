 select  'PLS' as 'BU'
		,lh.HN as 'PatientID'
		,lh.FacilityRmsNo as 'FacilityRmsNo'
		,lh.RequestNo as 'RequestNo'
		,lh.EntryDateTime as 'EntryDateTime'
		,lh.RequestDoctor as 'RequestDoctorCode'
		,dbo.Doctorname(lh.RequestDoctor,2) as 'RequestDoctorNameTH'
		,dbo.Doctorname(lh.RequestDoctor,1) as 'RequestDoctorNameEN'
		,'' as 'LabCodeSuffixTiny'
		,'' as 'SuffixTiny'
		,CAST(SUBSTRING(spm.COM,77,5) as varchar(5)) as 'SpecimenCode'
		,dbo.sysconname(CAST(SUBSTRING(spm.COM,77,5) as varchar(5)),20066,2) as 'SpecimenNameTH'
		,dbo.sysconname(CAST(SUBSTRING(spm.COM,77,5) as varchar(5)),20066,1) as 'SpecimenNameEN'
		,spm.CODE as 'RequestLabCode' --·°È‰¢ 09/02/69
		,dbo.CutSortChar(spm.THAINAME) as 'RequestLabNameTH' --·°È‰¢ 09/02/69
		,dbo.CutSortChar(spm.ENGLISHNAME) as 'RequestLabNameEN' --·°È‰¢ 09/02/69
		,ls.LabCode as 'LabCode'
		,dbo.sysconname(ls.LabCode,20067,2) as 'LabNameTH'
		,dbo.sysconname(ls.LabCode,20067,1) as 'LabNameEN'
		,ls.ResultValue as 'ResultValue'
		,'' as 'FacilityResultType'	
		,'' as 'FacilityResultName'
		,ls.RESULTCLASSIFIED as 'LABResultClassifiedType'
		,case
			when ls.RESULTCLASSIFIED = '0' then 'NONE'
			when ls.RESULTCLASSIFIED = '1' then 'NORMAL'
			when ls.RESULTCLASSIFIED = '2' then 'HI'
			when ls.RESULTCLASSIFIED = '3' then 'LO'
			when ls.RESULTCLASSIFIED = '4' then 'DIFFFROM_PREV'
			when ls.RESULTCLASSIFIED = '5' then 'ALLOW_ABNORMAL'
			when ls.RESULTCLASSIFIED = '6' then 'REACTIVE'
			when ls.RESULTCLASSIFIED = '7' then 'NON_REACTIVE'
			when ls.RESULTCLASSIFIED = '8' then 'NEGATIVE'
			when ls.RESULTCLASSIFIED = '9' then 'POSITIVE'
			when ls.RESULTCLASSIFIED = '10' then 'UNDIFFERENTAIL'
			when ls.RESULTCLASSIFIED = '91' then 'NORESULT'
			when ls.RESULTCLASSIFIED = '98' then 'ALERT'
			when ls.RESULTCLASSIFIED = '99' then 'ABNORMAL'
		end as 'LABResultClassifiedName'
		,ls.NormalResultValue as 'NormalResultValue'
		,ls.ResultDateTime as 'ResultDateTime'
		,ls.CONFIRMUSERCODE as 'ConfirmByUserCode'
		,dbo.sysconname(ls.CONFIRMUSERCODE,10000,2) as 'ConfirmByUserNameTH'
		,dbo.sysconname(ls.CONFIRMUSERCODE,10000,1) as 'ConfirmByUserNameEN'
		,ls.ENTRYDATETIME as 'ConfirmDateTime'
		,ls.RESULTBYUSERCODE as 'ApproveByUserCode'
		,dbo.sysconname(ls.RESULTBYUSERCODE,10000,2) as 'ApproveByUserNameTH'
		,dbo.sysconname(ls.RESULTBYUSERCODE,10000,1) as 'ApproveByUserNameEN'
		,ls.ApproveDateTime as 'ApproveDateTime'
		,ls.PreviousResultValue as 'PreviousResultValue'
		,'' as 'PreviousResultDateTime'
		,ls.CXLBYUSERCODE as 'CancelByUserCode'
		,dbo.sysconname(ls.CXLBYUSERCODE,10000,2) as 'CancelByUserNameTH'
		,dbo.sysconname(ls.CXLBYUSERCODE,10000,1) as 'CancelByUserNameEN'
		,ls.CXLDATETIME as 'CancelDateTime'
		,chk.REQUESTNO as 'CheckupNo'
		,case when lh.CLINIC is not null then lh.CLINIC else lh.WARD end as FromLocationCode
		,case when lh.CLINIC is not null then dbo.sysconname(lh.CLINIC,20016,2) else dbo.sysconname(lh.WARD,20024,2) end as FromLocationNameTH
		,case when lh.CLINIC is not null then dbo.sysconname(lh.CLINIC,20016,1) else dbo.sysconname(lh.WARD,20024,1) end as FromLocationNameEN
				from LABREQ lh
				left join LABRESULT ls on lh.REQUESTNO=ls.REQUESTNO and lh.FACILITYRMSNO=ls.FACILITYRMSNO
				inner join 
				(

					select	a.CODE as LabReqMtdCode

							, coalesce(dbo.cutsortchar(a.THAINAME),'') as description_th

							, coalesce(dbo.cutsortchar(a.ENGLISHNAME),'') as description_en

							, CAST(SUBSTRING(b.COM,0,6) as varchar(6)) as LabExtendCode

							, b.SUFFIX
 
					from	SYSCONFIG a 

							left join SYSCONFIG_DETAIL b on b.CTRLCODE = 10026 and a.CODE = b.CODE

					where	a.CTRLCODE = 20068

				)b on ls.LABREQUESTMETHOD = b.LabReqMtdCode and ls.LABCODE = b.LabExtendCode and ls.AMT = 0 --·°È‰¢ 09/02/69
				inner join SYSCONFIG spm on b.LabReqMtdCode=CAST(SUBSTRING(spm.COM,169,5) as varchar(5)) and b.LabReqMtdCode <> '' and spm.CTRLCODE = 20067  and CAST(SUBSTRING(spm.COM,243,1) as int) = 0 --·°È‰¢ 09/02/69
				left join view_setup_Lab vsl on ls.LABCODE=vsl.LabCode
				left join HNCHKUPFACX chk on lh.REQUESTNO = chk.FACILITYREQUESTNO and lh.FACILITYRMSNO=chk.FACILITYRMSNO