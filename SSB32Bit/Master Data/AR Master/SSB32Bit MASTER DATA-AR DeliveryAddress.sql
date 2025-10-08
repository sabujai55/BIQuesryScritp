select
		 'PLS' as BU
		, ard.CODE as ARCode
		, dbo.CutSortChar(arm.THAINAME) as ARNameTH
		, dbo.CutSortChar(arm.ENGLISHNAME) as ARNameEN
		, ard.ADDITIONCODE as ARAddressCode
		, (CASE WHEN RIGHT(cast(substring(com,115,charindex('^',substring(com,115,120))) as varchar(120)),1) ='^' 
						 THEN cast(substring(com,115,charindex('^',substring(com,115,120))-1) as varchar(120))
						 ELSE cast(substring(com,115,120) as varchar(120)) end) as Address1
		, cast(substring(com,175,2) as varchar(2)) as Province
		, dbo.Provincename(cast(substring(com,175,2) as varchar(2)),2) as ProvinceNameTH
		, dbo.Provincename(cast(substring(com,175,2) as varchar(2)),1) as ProvinceNameEN
		, cast(substring(com,179,2) as varchar(2)) as Amphoe
		, dbo.Amphoename(cast(substring(com,175,2) as varchar(2)),cast(substring(com,179,2) as varchar(2)),2) as AmphoeNameTH
		, dbo.Amphoename(cast(substring(com,175,2) as varchar(2)),cast(substring(com,179,2) as varchar(2)),1) as AmphoeNameEN
		, cast(substring(com,183,2) as varchar(2)) as Tambon
		, dbo.Tambonname(cast(substring(com,175,2) as varchar(2)),cast(substring(com,179,2) as varchar(2)),cast(substring(com,183,2) as varchar(2)),2) as TambonNameTH
		, dbo.Tambonname(cast(substring(com,175,2) as varchar(2)),cast(substring(com,179,2) as varchar(2)),cast(substring(com,183,2) as varchar(2)),1) as TambonNameEN
		, COALESCE(cast(substring(com,187,5) as varchar(5)),'-') as PostalCode
		, CASE WHEN RIGHT(cast(substring(com,51,charindex('^',substring(com,51,16))) as varchar(16)),1) ='^' 
								 THEN cast(substring(com,51,charindex('^',substring(com,51,16))-1) as varchar(16))
								 ELSE cast(substring(com,51,16) as varchar(16)) END as TelephoneNo
		, CAST(SUBSTRING(com,207,5)as varchar) as DeliveryRegion
		, dbo.sysconname(CAST(SUBSTRING(com,207,5)as varchar),40065,2) as DeliveryRegionNameTH
		, dbo.sysconname(CAST(SUBSTRING(com,207,5)as varchar),40065,1) as DeliveryRegionNameEN
		, CASE WHEN RIGHT(cast(substring(com,67,charindex('^',substring(com,67,28))) as varchar(28)),1) ='^' 
								 THEN cast(substring(com,67,charindex('^',substring(com,67,28))-1) as varchar(28))
								 ELSE cast(substring(com,67,28) as varchar(16)) END as FaxNo
		, '' as CommunicableNo
		, CASE WHEN RIGHT(cast(substring(com,1,charindex('^',substring(com,1,50))) as varchar(50)),1) ='^' 
								 THEN cast(substring(com,1,charindex('^',substring(com,1,50))-1) as varchar(50))
								 ELSE cast(substring(com,1,50) as varchar(50)) END as PersonName
		, arm.MEMO as RemarksMemo
				from SYSCONFIG_DETAIL ard
				left join SSBBACKOFFICE.dbo.ARMASTER arm on ard.CODE=arm.ARCODE 
				where ard.CTRLCODE = 10024