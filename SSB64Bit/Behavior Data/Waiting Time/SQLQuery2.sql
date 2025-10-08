select	* 
from	HNOPD_LOG 
where	VisitDate = '2025-05-30' 
		and VN = '001' 
		and OpdMasterLogType in (22,23,24)
order by MakeDateTime asc;

select	a.VisitDate
		, a.VN
		, a.PrescriptionNo
		, b.MakeDateTime
from	HNPAT_REQFAC a 
		inner join HNLABREQ_LOG b on a.FacilityRmsNo = b.FacilityRmsNo and a.RequestNo = b.RequestNo
where	a.HN = '65485/60'
		and b.HNLABRequestLogType = 6;

select	pq.VisitDate
		, pq.VN
		, pq.PrescriptionNo
		, xl.MakeDateTime
		, xl.RequestNo
from	HNPAT_REQFAC pq
		inner join HNXRAYREQ_LOG xl on pq.FacilityRmsNo = xl.FacilityRmsNo and pq.RequestNo = xl.RequestNo
where	pq.HN = '65485/60'
		and xl.HNXRayRequestLogType = 1;
