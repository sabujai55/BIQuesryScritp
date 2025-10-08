select top 10 'PLS' as 'BU'
,a.HN as 'PatientID'
,a.HN
,a.APPOINTMENTNO as 'AppointmentNo'
,a.APPOINTMENTDATETIME as 'AppointmentDateTime'
,a.APPOINTMENTWITHDOCTOR as 'DoctorCode'
,SUBSTRING(doc.THAINAME,2,len(doc.THAINAME)) as 'DoctorNameTH'
,SUBSTRING(doc.ENGLISHNAME,2,LEN(doc.ENGLISHNAME)) as 'DoctorNameEN'
,doc.CERTIFYPUBLICNO as 'DoctorCertificate'
,a.APPOINTMENTWITHCLINIC as 'LocationCode' 
,dbo.sysconname(a.APPOINTMENTWITHCLINIC,20016,2) as 'LocationNameTH' --แก้ไขวันที่ 24/02/2568
,dbo.sysconname(a.APPOINTMENTWITHCLINIC,20016,1) as 'LocationNameEN' --เพิ่ม 24/02/2568
,null as 'AppointmentTimeType'
,a.NOMINUTES as 'NoMinuteDuration'
,a.MAKEDATETIME as 'EntryDateTime'
,a.USEDRIGHTCODE as 'RightCode'
,dbo.sysconname(a.USEDRIGHTCODE,20019,2) as 'RightNameTH' --แก้ไขวันที่ 24/02/2568
,dbo.sysconname(a.USEDRIGHTCODE,20019,1) as 'RightNameEN' --เพิ่ม 24/02/2568
,a.PROCEDURECODE as 'AppointmentProcedureCode1'
,dbo.sysconname(a.PROCEDURECODE,20109,4) as 'AppointmentProcedureName1'
,a.PROCEDURECODE2 as 'AppointmentProcedureCode2'
,dbo.sysconname(a.PROCEDURECODE2,20109,4) as 'AppointmentProcedureName2'
,a.PROCEDURECODE3 as 'AppointmentProcedureCode3'
,dbo.sysconname(a.PROCEDURECODE3,20109,4) as 'AppointmentProcedureName3'
,a.PROCEDURECODE4 as 'AppointmentProcedureCode4'
,dbo.sysconname(a.PROCEDURECODE4,20109,4) as 'AppointmentProcedureName4'
,null as 'AppointmentProcedureCode5'
,null as 'AppointmentProcedureName5'
,a.ENTRYBYUSERCODE as 'EntryByUserCode' --แก้ไขวันที่ 24/02/2568
,dbo.sysconname(a.ENTRYBYUSERCODE,10000,2) as 'EntryByUserNameTH' --เพิ่ม 24/02/2568
,dbo.sysconname(a.ENTRYBYUSERCODE,10000,1) as 'EntryByUserNameEN' --เพิ่ม 24/02/2568
,pat.MOBILEPHONENO as 'MobilePhoneNo'
,pat.TEL as 'Telephone'
		from HNAPPMNT a
		left join HNDOCTOR doc on a.APPOINTMENTWITHDOCTOR=doc.DOCTOR
		left join PATIENT_ADDRESS pat on a.HN=pat.HN and pat.SUFFIX = 1
