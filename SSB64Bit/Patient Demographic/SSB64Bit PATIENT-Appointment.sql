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
,apm.Clinic as 'LocationCode'
,dbo.sysconname(apm.Clinic,42203,2) as 'LocationNameTH' --แก้ไขวันที่ 24/02/2568
,dbo.sysconname(apm.Clinic,42203,1) as 'LocationNameEN' --เพิ่ม 24/02/2568
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
,dbo.sysconname(apm.RIGHTCODE,42086,2) as 'RightNameTH' --แก้ไขวันที่ 24/02/2568
,dbo.sysconname(apm.RIGHTCODE,42086,1) as 'RightNameEN' --เพิ่ม 24/02/2568
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
,apm.EntryByUserCode as 'EntryByUserCode' --แก้ไขวันที่ 24/02/2568
,dbo.sysconname(apm.EntryByUserCode,10031,2) as 'EntryByUserNameTH' --เพิ่ม 24/02/2568
,dbo.sysconname(apm.EntryByUserCode,10031,1) as 'EntryByUserNameEN' --เพิ่ม 24/02/2568
,apm.MobilePhone as 'MobilePhoneNo'
,apm.TelephoneNo as 'Telephone'
		from HNAPPMNT_HEADER apm
		left join HNDOCTOR_MASTER doc on apm.Doctor=doc.Doctor