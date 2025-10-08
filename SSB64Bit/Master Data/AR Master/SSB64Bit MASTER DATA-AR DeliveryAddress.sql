select  
	'PT2' as BU
	, ard.ARCode
	, dbo.CutSortChar(ar.LocalName) as ARNameTH
	, dbo.CutSortChar(ar.EnglishName) as ARNameEN
	, ard.ARAddressCode
	, ard.Address1
	, ard.Province
	, dbo.Provincename(ard.Province,2) as ProvinceNameTH
	, dbo.Provincename(ard.Province,1) as ProvinceNameEN
	, ard.Amphoe
	, dbo.Amphoename(ard.Province,ard.Amphoe,2) as AmphoeNameTH
	, dbo.Amphoename(ard.Province,ard.Amphoe,1) as AmphoeNameEN
	, ard.Tambon
	, dbo.Tambonname(ard.Province,ard.Amphoe,ard.Tambon,2) as TambonNameTH
	, dbo.Tambonname(ard.Province,ard.Amphoe,ard.Tambon,2) as TambonNameEN
	, ard.PostalCode
	, ard.TelephoneNo
	, ard.DeliveryRegion
	, dbo.sysconname(ard.DeliveryRegion,36158,2) as DeliveryRegionNameTH
	, dbo.sysconname(ard.DeliveryRegion,36158,1) as DeliveryRegionNameEN
	, ard.FaxNo
	, ard.CommunicableNo
	, ard.PersonName
	, ard.RemarksMemo
		from ARMASTER_DELIVERYADDR ard
		inner join ARMASTER ar on ard.ARCode=ar.ARCode