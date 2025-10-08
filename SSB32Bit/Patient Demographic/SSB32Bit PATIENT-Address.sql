use SSBHOSPITAL
go

select	top 10
		'PTP' as BU
		, a.HN as PatientID
		, a.HN
		, a.SUFFIX as Suffix
		, case when a.ADDRESSTYPE = 0 then '�������Ѩ�غѹ' 
		  when a.ADDRESSTYPE = 1 then '���ӧҹ' 
		  when a.ADDRESSTYPE = 2 then '����' 
		  when a.ADDRESSTYPE = 3 then '����������ѵû�ЪҪ�'
		  else '����к�' end as AddressType
		, coalesce(a.NOTIFIEDPERSON,'') as NotifiedPerson
		, coalesce(dbo.CutSortChar(sys01.THAIName), dbo.CutSortChar(sys01.EnglishName),'') as RelativeCode
		, coalesce(a.[ADDRESS],'') as [Address]
		, coalesce(dbo.Tambonname(a.PROVINCE, a.AMPHOE,a.TAMBON,4),'') as Tambon
		, coalesce(dbo.Amphoename(a.PROVINCE, a.AMPHOE, 4),'') as Amphor
		, coalesce(dbo.Provincename(a.PROVINCE, 4),'') as Province
		, coalesce(a.POSTALCODE,'') as PostalCode
		, coalesce(a.MOBILEPHONENO,'') as MobilePhoneNo
		, coalesce(a.TEL,'') as TelephoneNo
		, coalesce(a.EMAILADDRESS,'') as Email
		, case when a.PROVINCE is null then null else CONCAT(a.PROVINCE,'.',a.AMPHOE,'.',a.TAMBON) end as ProvinceComposeCode --�����ѹ��� 24/02/2568
from	PATIENT_ADDRESS a
		left join SYSCONFIG sys01 on sys01.CtrlCode = 10075 and sys01.Code = a.RELATIVETYPE