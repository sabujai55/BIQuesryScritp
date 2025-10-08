USE
SSBHOSPITAL
GO

select top 10
 'PLS' as 'BU'
,ptr.HN as 'PatientID'
,ptr.HN as 'HN'
,ROW_NUMBER() OVER(partition by ptr.hn Order By ptr.rightcode) as 'Suffix'
,ptr.RIGHTCODE as 'RightCode'
,dbo.sysconname(ptr.RIGHTCODE,20019,2) as 'RightNameTH' --แก้ไขวันที่ 24/02/2568
,dbo.sysconname(ptr.RIGHTCODE,20019,1) as 'RightNameEN' --เพิ่มวันที่ 24/02/2568
,isnull(ptr.SPONSOR,'') as 'SponsorCode'
,dbo.CutSortChar(ar.THAINAME)  as 'SponsorNameTH' --แก้ไขวันที่ 24/02/2568
,dbo.CutSortChar(ar.ENGLISHNAME) as 'SponsorNameEN' --เพิ่มวันที่ 24/02/2568
,'' as 'PolicyNo'
,'' as 'LimitAmt'
,isnull(ptr.REF ,'')as 'RefNo'
,isnull(ptr.VALIDFROM,'') as 'EffectiveDateTimeFrom'
,isnull(ptr.VALIDTILL,'') as 'EffectiveDateTimeTo'
,isnull(ptr.REMARKS,'') as 'Remark'
,ISNULL(dbo.sysconname(ptr.MAINHOSPITALCODE,20010,4),dbo.sysconname(ptr.MAINHOSPITALCODE,20010,4)) as 'HospitalMain'  
,ISNULL(dbo.sysconname(ptr.SUBHOSPITALCODE,20010,4),dbo.sysconname(ptr.SUBHOSPITALCODE,20010,4)) as 'HospitalSub'
		from PATIENT_RIGHT ptr
		left join SSBBACKOFFICE.dbo.ARMASTER ar on ptr.SPONSOR=ar.ARCODE

