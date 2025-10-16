use SSBLIVE
go

select top 10 
		'PT2'as 'BU'
		,apm.HN as 'PatientID'
		,apm.HN as 'HN'
		,apm.AppointmentNo as 'AppointmentNo'
		,apm.AppointDateTime as 'AppointmentDateTime'
		,apm.Doctor as 'DoctorCode'
		,dbo.CutSortChar(doc.LocalName) as 'DoctorNameTH'
		,dbo.CutSortChar(doc.EnglishName) as 'DoctorNameEN'
		,doc.CertifyPublicNo as 'DoctorCertificate'
		, doc.Clinic as DoctorClinicCode
		, dbo.sysconname(doc.Clinic,42203,2) as DoctorClinicNameTH
		, dbo.sysconname(doc.Clinic,42203,1) as DoctorClinicNameEN
		, doc.ComposeDept as DoctorDepartmentCode
		, dbo.sysconname(doc.ComposeDept,10145,2) as DoctorDepartmentNameTH
		, dbo.sysconname(doc.ComposeDept,10145,1) as DoctorDepartmentNameEN
		, doc.Specialty as DoctorSpecialtyCode
		, dbo.sysconname(doc.Specialty,42197,2) as DoctorSpecialtyNameTH
		, dbo.sysconname(doc.Specialty,42197,1) as DoctorSpecialtyNameEN
		,apm.Clinic as ClinicCode
		,dbo.sysconname(apm.Clinic,42203,2) as ClinicNameTH --����ѹ��� 24/02/2568
		,dbo.sysconname(apm.Clinic,42203,1) as ClinicNameEN --���� 24/02/2568
		,CAST(SUBSTRING(cndp.Com,27,13)as varchar) as ClinicDepartmentCode
		,dbo.sysconname(CAST(SUBSTRING(cndp.Com,27,13)as varchar),10145,2) as ClinicDepartmentNameTH
		,dbo.sysconname(CAST(SUBSTRING(cndp.Com,27,13)as varchar),10145,1) as ClinicDepartmentNameEN
		,case when apm.LastHNAppointmentLogType = 0 Then 'None'
			  when apm.LastHNAppointmentLogType = 3 Then 'Confirmed'
			  when apm.LastHNAppointmentLogType = 4 Then 'Cxl'
			  when apm.LastHNAppointmentLogType = 5 Then 'Cannot_Contact'
			  when apm.LastHNAppointmentLogType = 6 Then 'Change_Time'
			  when apm.LastHNAppointmentLogType = 7 Then 'Change_Date'
			  when apm.LastHNAppointmentLogType = 12 Then 'Attended'
			  when apm.LastHNAppointmentLogType = 13 Then 'Checked_Out'
			  end as 'AppointmentLogType'
		,apm.NoMinuteDuration as 'NoMinuteDuration'
		,apm.EntryDateTime as 'EntryDateTime'
		,apm.RightCode as 'RightCode'
		,dbo.sysconname(apm.RIGHTCODE,42086,2) as 'RightNameTH' --����ѹ��� 24/02/2568
		,dbo.sysconname(apm.RIGHTCODE,42086,1) as 'RightNameEN' --���� 24/02/2568
		,apm.AppmntProcedureCode1 as 'AppointmentProcedureCode1'
		,dbo.sysconname(apm.AppmntProcedureCode1,42211,4) as 'AppointmentProcedureName1'
		,apm.AppmntProcedureCode2 as 'AppointmentProcedureCode2'
		,dbo.sysconname(apm.AppmntProcedureCode2,42211,4) as 'AppointmentProcedureName2'
		,apm.AppmntProcedureCode3 as 'AppointmentProcedureCode3'
		,dbo.sysconname(apm.AppmntProcedureCode3,42211,4) as 'AppointmentProcedureName3'
		,apm.AppmntProcedureCode4 as 'AppointmentProcedureCode4'
		,dbo.sysconname(apm.AppmntProcedureCode4,42211,4) as 'AppointmentProcedureName4'
		,apm.AppmntProcedureCode5 as 'AppointmentProcedureCode5'
		,dbo.sysconname(apm.AppmntProcedureCode5,42211,4) as 'AppointmentProcedureName5'
		,apm.EntryByUserCode as 'EntryByUserCode' --����ѹ��� 24/02/2568
		,dbo.sysconname(apm.EntryByUserCode,10031,2) as 'EntryByUserNameTH' --���� 24/02/2568
		,dbo.sysconname(apm.EntryByUserCode,10031,1) as 'EntryByUserNameEN' --���� 24/02/2568
		,apm.MobilePhone as 'MobilePhoneNo'
		,apm.TelephoneNo as 'Telephone'
from	HNAPPMNT_HEADER apm
		left join HNDOCTOR_MASTER doc on apm.Doctor=doc.Doctor
		left join DNSYSCONFIG cndp on apm.Clinic = cndp.Code and cndp.CtrlCode = 42203
where	apm.AppointDateTime >= GETDATE()