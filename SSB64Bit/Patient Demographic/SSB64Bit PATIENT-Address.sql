use SSBLIVE
go
	
select	top 10 
		'PT2' as BU
		, a.HN as PatientID
		, a.SuffixTiny as Suffix
		, coalesce(dbo.CutSortChar(sys01.LocalName), dbo.CutSortChar(sys01.EnglishName)) as AddressType
		, a.NotifiedPerson
		, coalesce(dbo.CutSortChar(sys02.LocalName), dbo.CutSortChar(sys02.EnglishName)) as RelativeCode
		, a.Address1
		, dbo.TambonnameNew(a.ProvinceComposeCode,4) as Tambon
		, dbo.AmphoenameNew (a.ProvinceComposeCode,4) as Amphor
		, dbo.ProvincenameNew(a.ProvinceComposeCode,4) as Province
		, a.PostalCode 
		, a.MobilePhone as MobilePhoneNo
		, a.TelephoneNo
		, b.EMailAddress as Email
		, a.ProvinceComposeCode --เพิ่มวันที่ 24/02/2568
from	HNPAT_ADDRESS a
		left join HNPAT_EMAIL b on a.HN=b.HN and b.HNEMailAddressType = 1
		left join DNSYSCONFIG sys01 on sys01.CtrlCode = 10298 and sys01.Code = a.AddressType
		left join DNSYSCONFIG sys02 on sys02.CtrlCode = 10192 and sys02.Code = a.RelativeCode
