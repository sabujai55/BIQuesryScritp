use SSBLIVE
go

--with cxl_dc as 
--(
--	select	distinct AN
--	from	HNIPD_LOG 
--	where	MakeDateTime between '2025-01-01 00:00:00' and '2025-12-31 23:59:59'
--			and IpdMasterLogType = 22
--),
--dc as
--(
--	select	ROW_NUMBER() over(partition by AN order by MakeDateTime asc) as rowid
--			, AN
--			, MakeDateTime
--			, RemarksMemo
--	from	HNIPD_LOG 
--	where	MakeDateTime between '2025-01-01 00:00:00' and '2025-12-31 23:59:59'
--			and IpdMasterLogType = 21
--)

--select	a.AN
--		, b.MakeDateTime
--from	cxl_dc a
--		left join dc b on b.rowid = 1 and a.AN = b.AN

select	AVG(aa.NumberDay)
from	
(
select	a.AN
		, a.AdmDateTime
		, a.DischargeDateTime
		, dc.MakeDateTime as log_dc_date
		, cxldc.MakeDateTime as log_cxldc_date
		, DATEDIFF(DAY,dc.MakeDateTime,cxldc.MakeDateTime) as NumberDay
from	HNIPD_MASTER a
		inner join 
		(
			select	ROW_NUMBER() over(partition by AN order by MakeDateTime asc) as rowid
					, AN
					, MakeDateTime
					, RemarksMemo
			from	HNIPD_LOG 
			where	MakeDateTime between '2025-01-01 00:00:00' and '2025-12-31 23:59:59'
					and IpdMasterLogType = 21	
		)dc on dc.rowid = 1 and a.AN = dc.AN
		inner join 
		(
			select	ROW_NUMBER() over(partition by AN order by MakeDateTime asc) as rowid
					, AN
					, MakeDateTime
					, RemarksMemo
			from	HNIPD_LOG 
			where	MakeDateTime between '2025-01-01 00:00:00' and '2025-12-31 23:59:59'
					and IpdMasterLogType = 22	
		)cxldc on cxldc.rowid = 1 and cxldc.AN = dc.AN
where	a.AN in 
(
	select	AN
	from	HNIPD_LOG 
	where	MakeDateTime between '2025-01-01 00:00:00' and '2025-12-31 23:59:59'
			and IpdMasterLogType = 22
)
)aa

