use SSBLIVE
go

select	'PT2' as BU
		, a.HN as PatientID
		, a.FacilityRmsNo
		, a.RequestNo
		, b.VisitDateTime
		, d.[description] as HNORVisitLocation
		, case when b.HNORVisitType = 0 then 'None'
		  when b.HNORVisitType = 1 then 'Pre'
		  when b.HNORVisitType = 2 then 'During'
		  when b.HNORVisitType = 3 then 'Post'
		  end as HNORVisitType
		, case when b.ORAnesType = 0 then 'None'
		  when b.ORAnesType = 1 then 'OR'
		  when b.ORAnesType = 2 then 'ANES'
		  end as ORAnesType
		, b.NurseCode
		, dbo.CutSortChar(sys01.LocalName) as NurseNameTH
		, dbo.CutSortChar(sys01.EnglishName) as NurseNameEN
		, b.Doctor
		, dbo.CutSortChar(c.LocalName) as RequestDoctorNameTH
		, dbo.CutSortChar(c.EnglishName) as RequestDoctorNameEN
from	HNORREQ_HEADER a
		inner join HNORREQ_VISIT b on a.FacilityRmsNo = b.FacilityRmsNo and a.RequestNo = b.RequestNo
		left join HNDOCTOR_MASTER c on b.Doctor = c.Doctor
		left join v_FixHNORVisitLocation d on b.HNORVisitLocation = d.FixHNORVisitLocationId
		left join DNSYSCONFIG sys01 on sys01.CtrlCode = 42701 and b.NurseCode = sys01.Code
where	a.ORBeginDateTimePlan between '2025-01-01 00:00:00' and '2025-01-01 23:59:59'