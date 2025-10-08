USE
SSBLIVE
GO

select top 10
 'PT2' as 'BU'
,HN as 'PatientID'
,HN as 'HN'
,ROW_NUMBER() OVER(partition by ptr.hn Order By ptr.rightcode) as 'Suffix'
,ptr.RIGHTCODE as 'RightCode'
,dbo.sysconname(ptr.RIGHTCODE,42086,2) as 'RightNameTH' --แก้ไขวันที่ 24/02/2568
,dbo.sysconname(ptr.RIGHTCODE,42086,1) as 'RightNameEN' --เพิ่มวันที่ 24/02/2568
,ptr.ARCode as 'SponsorCode'
,dbo.CutSortChar(ar.LocalName)  as 'SponsorNameTH' --แก้ไขวันที่ 24/02/2568
,dbo.CutSortChar(ar.ENGLISHNAME) as 'SponsorNameEN' --เพิ่มวันที่ 24/02/2568
,PolicyNo as 'PolicyNo'
,LimitAmt as 'LimitAmt'
,ptr.RefRightKeyNo as 'RefNo'
,ptr.VALIDFROM as 'EffectiveDateTimeFrom'
,ptr.VALIDTILL as 'EffectiveDateTimeTo'
,ptr.REMARKS as 'Remark'
,ISNULL(dbo.sysconname(ptr.MainHospital,42025,4),dbo.sysconname(ptr.MainHospital,42025,4)) as 'HospitalMain'  
,ISNULL(dbo.sysconname(ptr.SubHospital,42025,4),dbo.sysconname(ptr.SubHospital,42025,4)) as 'HospitalSub'
		from HNPAT_RIGHT ptr
		left join ARMASTER ar on ptr.ARCode=ar.ARCode

