select top 10 
'PLS' as 'BU' ,
vnm.HN as 'PatientID' ,
convert(varchar,vnm.VISITDATE,112)+convert(varchar,vnm.VN)+'1' as 'VisitID' ,
vnm.VISITDATE as 'VisitDate' ,
vnm.VN as 'VN' ,
'1' as 'Suffix' ,
--vnp.CLINIC as 'LocationCode' ,-- ตัดออก 14/10/68
--dbo.sysconname(vnp.CLINIC,20016,2) as 'LocationNameTH' , -- ตัดออก 14/10/68
--dbo.sysconname(vnp.CLINIC,20016,1) as 'LocationNameEN' , -- ตัดออก 14/10/68
vnm.VISITINBYUSERID as 'EntryByUserCode' ,
dbo.sysconname(vnm.VISITINBYUSERID,10000,2) as 'EntryByUserNameTH' ,
dbo.sysconname(vnm.VISITINBYUSERID,10000,1) as 'EntryByUserNameEN' ,
vnm.VISITINDATETIME as	'EntryDateTime' ,
vnm.BODYWEIGHT as	'BodyWeight' ,
vnm.HEIGHT as	'Height' ,
convert(decimal(10,2) , (case when vnm.BODYWEIGHT = 0 then null else vnm.BODYWEIGHT end ) / ((case when vnm.HEIGHT = 0 then null else (vnm.HEIGHT/100)*(vnm.HEIGHT/100) end) )) as 'BMI' ,
vnm.POSTBPHIGH as 'PostBpSystolic' ,
vnm.POSTBPLOW as 'PostBpDiastolic' ,
vnm.BPHIGH as 'BpSystolic' ,
vnm.BPLOW as 'BpDiastolic' ,
vnm.TEMPERATURE as 'Temperature' ,
vnm.TEXTPULSERATE as 'PulseRate' ,
vnm.TEXTRESPIRERATE as 'RespirationRate' ,
'' as 'PainScale' ,
'' as 'O2Sat' ,
'' as 'Remark' 
		from VNMST vnm