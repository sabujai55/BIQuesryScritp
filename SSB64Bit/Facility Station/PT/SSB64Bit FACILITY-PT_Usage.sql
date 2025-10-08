select
		'PT2' as BU
		, pth.HN as PatientID
		, ptu.FacilityRmsNo
		, ptu.RequestNo
		, ptu.SuffixTiny
		, ptu.EntryDateTime
		, ptu.Store
		, dbo.sysconname(ptu.Store,20020,2) as StoreNameTH
		, dbo.sysconname(ptu.Store,20020,1) as StoreNameEN
		, ptu.StockCode
		, dbo.Stockname(ptu.StockCode,2) as StockNameTH
		, dbo.Stockname(ptu.StockCode,1) as StockNameEN
		, ptu.UnitCode
		, dbo.sysconname(ptu.UnitCode,20021,2) as UnitNameTH
		, dbo.sysconname(ptu.UnitCode,20021,1) as UnitNameEN
		, ptu.ReverseDrugControl
		, ptu.Qty
		, ptu.UnitPrice
		, ptu.Cost
		, ptu.ChargeAmt
		, ptu.RightCode
		, dbo.sysconname(ptu.RightCode,42086,2) as RightNameTH
		, dbo.sysconname(ptu.RightCode,42086,1) as RightNameEN
		, ptu.HNActivityCode
		,dbo.sysconname(ptu.HNActivityCode,42093,2) as HNActivityNameTH
		,dbo.sysconname(ptu.HNActivityCode,42093,1) as HNActivityNameEN
		, ptu.ChargeDateTime
		, Case when ptu.HNChargeType = 0 then 'None' 
		  when ptu.HNChargeType = 1 then 'Free' 
		  when ptu.HNChargeType = 2 then 'Refund'
		  when ptu.HNChargeType = 6 then 'Free Return'
		  end AS 'ChargeType'
		, case when ptu.IpdOpdType = 0 then 'None'
			   when ptu.IpdOpdType = 1 then 'IPD'
			   when ptu.IpdOpdType = 2 then 'OPD'
			   when ptu.IpdOpdType = 3 then 'Deposit'
			   when ptu.IpdOpdType = 4 then 'IPD OPD'
			   when ptu.IpdOpdType = 5 then 'LR'
			   when ptu.IpdOpdType = 6 then 'OR'
			   when ptu.IpdOpdType = 7 then 'LR OR'
		 end as IpdOpdType
		, ptu.EntryByUserCode
		, dbo.sysconname(ptu.EntryByUserCode,10031,2) as EntryByUserNameTH
		, dbo.sysconname(ptu.EntryByUserCode,10031,1) as EntryByUserNameEN
		, ptu.RemarksMemo
		, ptu.ComputerLocation
		, ptu.ImportParStock
				from HNPTREQ_USAGE ptu
				left join HNPTREQ_HEADER pth on ptu.FacilityRmsNo=pth.FacilityRmsNo and ptu.RequestNo=pth.RequestNo
				where ptu.RequestNo = 'PT02095-68'
