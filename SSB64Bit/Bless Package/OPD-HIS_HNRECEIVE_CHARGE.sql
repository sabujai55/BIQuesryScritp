use SSBLIVE	
go

select	'PT2' as BU
		, 'OPD' as OPD_IPD
		, a.VisitDate as Visitdate_AdmDateTime
		, a.VN as VN_AN
		, a.PrescriptionNo
		, NULL as IPDChargeDateTime
		, NULL as IPDChargeSuffixTiny 
from	HNOPD_PRESCRIP a
		left join HNOPD_PRESCRIP_TREATMENT b on b.VisitDate = a.VisitDate and b.VN = a.VN and b.PrescriptionNo = a.PrescriptionNo
		inner join 
		(
			select	distinct 
					a2.VisitDate
					, a2.VN
			from	HNOPD_PRESCRIP a2
			where	1=1
					and a2.HNPackageCode is not null 
		)hp on hp.VisitDate = a.VisitDate and hp.VN = a.VN
where	1=1
		and a.VisitDate between '2026-11-01' and '2026-11-20'
		