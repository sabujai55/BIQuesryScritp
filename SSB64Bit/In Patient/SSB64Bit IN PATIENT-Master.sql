use SSBLIVE
go

select 'PT2' as 'BU'
		,a.HN as 'PatientID'
		,CONVERT(varchar,a.ADMDATETIME,112)+a.AN as 'AdmitID'
		,a.ADMDATETIME as 'AdmitDateTime'
		,a.AN as 'AN'
		,a.ADMWARD as 'WardCode'
		,dbo.sysconname(a.ADMWARD,42201,2) as 'WardNameTH' --แก้ไขวันที่ 27/02/2568
		,dbo.sysconname(a.ADMWARD,42201,1) as 'WardNameEN' --เพิ่มวันที่ 27/02/2568
		,CAST(SUBSTRING(syw.Com,36,13)as varchar) as 'WardDepartmentCode'  --แก้ไขวันที่ 27/02/2568
		,dbo.sysconname(CAST(SUBSTRING(syw.Com,36,13)as varchar),10145,2) as 'WardDepartmentNameTH' --เพิ่มวันที่ 27/02/2568
		,dbo.sysconname(CAST(SUBSTRING(syw.Com,36,13)as varchar),10145,1) as 'WardDepartmentNameEN' --เพิ่มวันที่ 27/02/2568
		, dm.DoctorMasterCode
		, dm.DoctorMasterNameTH
		, dm.DoctorMasterNameEN
		, dm.DoctorCertificate
		, dm.DoctorMasterClinicCode
		, dm.DoctorMasterClinicNameTH
		, dm.DoctorMasterClinicNameEN
		, dm.DoctorMasterDepartmentCode
		, dm.DoctorMasterDepartmentNameTH
		, dm.DoctorMasterDepartmentNameEN
		, dm.DoctorMasterSpecialtyCode
		, dm.DoctorMasterSpecialtyNameTH
		, dm.DoctorMasterSpecialtyNameEN
		,a.DischargeCode as 'DischargeCode'
		,dbo.sysconname(a.DischargeCode,42262,2) as 'DischargeNameTH' --แก้ไขวันที่ 27/02/2568
		,dbo.sysconname(a.DischargeCode,42262,1) as 'DischargeNameEN' --เพิ่มวันที่ 27/02/2568
		,case when a.DISCHARGEDATETIME is null then 'Active' else 'Inactive' end as 'Status'
		,a.AdmCount --เพิ่มวันที่ 27/02/2568
		,a.AdmCode as AdmType --เพิ่มวันที่ 27/02/2568
		,dbo.sysconname(a.AdmCode,42396,2) as 'AdmTypeNameTH' --เพิ่มวันที่ 27/02/2568
		,dbo.sysconname(a.AdmCode,42396,1) as 'AdmTypeNameEN' --เพิ่มวันที่ 27/02/2568
		,a.AdmHNBedNo as 'HNBedNo' --เพิ่มวันที่ 27/02/2568
		,dbo.sysconname(a.AdmHNBedNo,42421,2) as 'HNBedNameTH' --เพิ่มวันที่ 27/02/2568
		,dbo.sysconname(a.AdmHNBedNo,42421,1) as 'HNBedNameEN' --เพิ่มวันที่ 27/02/2568
		,a.ActiveWard as 'ActiveWardCode' --เพิ่มวันที่ 27/02/2568
		,dbo.sysconname(a.ActiveWard,42201,2) as 'ActiveWardNameTH' --เพิ่มวันที่ 27/02/2568
		,dbo.sysconname(a.ActiveWard,42201,1) as 'ActiveWardNameEN' --เพิ่มวันที่ 27/02/2568
		,a.ActiveHNBedNo as 'ActiveHNBedNo' --เพิ่มวันที่ 27/02/2568
		,dbo.sysconname(a.ActiveHNBedNo,42421,2) as 'ActiveHNBedNameTH' --เพิ่มวันที่ 27/02/2568
		,dbo.sysconname(a.ActiveHNBedNo,42421,1) as 'ActiveHNBedNameEN' --เพิ่มวันที่ 27/02/2568
		, a.PlanDischargeDateTime as DoctorDischargeDateTime
		, a.MedicalTakeHomeDateTime as DrugTakeHomeDateTime
		, (select top 1 c.IPDChargeDateTime From HNIPD_CHARGE c where c.AN = a.AN and c.VoidDateTime is null order by c.IPDChargeDateTime) as LastOrderDateTime
		, a.WardAllowDischargeDateTime
		, a.AccountAllowReleaseDateTime as FinancialDateTime
		, a.DischargeDateTime as WardDischargeDateTime
		,a.DiagnosisStatusType --เพิ่มวันที่ 27/02/2568
		,case 
			when a.DiagnosisStatusType = 0 then 'None' 
			when a.DiagnosisStatusType = 1 then 'Recovery' 
			when a.DiagnosisStatusType = 2 then 'Improved' 
			when a.DiagnosisStatusType = 3 then 'Not_Improved' 
			when a.DiagnosisStatusType = 4 then 'Expire_No_Autopsy' 
			when a.DiagnosisStatusType = 5 then 'Expire_Autopsy' 
			when a.DiagnosisStatusType = 6 then 'Expire_Still_Berth' 
			when a.DiagnosisStatusType = 7 then 'Normal_Deliver' 
			when a.DiagnosisStatusType = 8 then 'Un_Deliver' 
			when a.DiagnosisStatusType = 9 then 'Normal_Child_DC_With_Mother' 
			when a.DiagnosisStatusType = 10 then 'Normal_Child_DC_Separate' 
		end as 'DiagnosisStatusName'
		,a.DefaultRightCode --เพิ่มวันที่ 27/02/2568
		,dbo.sysconname(a.DefaultRightCode,42086,2) as 'DefaultRightNameTH' --เพิ่มวันที่ 27/02/2568
		,dbo.sysconname(a.DefaultRightCode,42086,1) as 'DefaultRightNameEN' --เพิ่มวันที่ 27/02/2568
		,a.ReAdmCode as ReAdmitCode --เพิ่มวันที่ 27/02/2568
		,dbo.sysconname(a.ReAdmCode,43583,2) as 'ReAdmitNameTH' --เพิ่มวันที่ 27/02/2568
		,dbo.sysconname(a.ReAdmCode,43583,1) as 'ReAdmitNameEN' --เพิ่มวันที่ 27/02/2568
		,a.FromClinic as 'AdmitLocationCode' --เพิ่มวันที่ 27/02/2568
		,dbo.sysconname(a.FromClinic,42203,2) as 'AdmitLocationNameTH' --เพิ่มวันที่ 27/02/2568
		,dbo.sysconname(a.FromClinic,42203,1) as 'AdmitLocationNameEN' --เพิ่มวันที่ 27/02/2568
		, a.InsuranceSalesAgent as AgencyCode
		, dbo.sysconname(a.InsuranceSalesAgent,43961,2) as AgencyNameTH
		, dbo.sysconname(a.InsuranceSalesAgent,43961,1) as AgencyNameEN
from	HNIPD_MASTER a
		left join HNDOCTOR_MASTER doc on a.AdmDoctor=doc.Doctor
		left join DNSYSCONFIG syw on a.AdmWard = syw.Code and syw.CtrlCode = 42201
		left join 
		(
			select	a.AN
					, a.Doctor as DoctorMasterCode
					, dbo.CutSortChar(b.LocalName) as DoctorMasterNameTH
					, dbo.CutSortChar(b.EnglishName) as DoctorMasterNameEN
					, b.CertifyPublicNo as DoctorCertificate
					, b.Clinic as DoctorMasterClinicCode
					, dbo.sysconname(b.Clinic,42203,2) as DoctorMasterClinicNameTH
					, dbo.sysconname(b.Clinic,42203,1) as DoctorMasterClinicNameEN
					, b.ComposeDept as DoctorMasterDepartmentCode
					, dbo.sysconname(b.ComposeDept,10145,2) as DoctorMasterDepartmentNameTH
					, dbo.sysconname(b.ComposeDept,10145,1) as DoctorMasterDepartmentNameEN
					, b.Specialty as DoctorMasterSpecialtyCode
					, dbo.sysconname(b.Specialty,42197,2) as DoctorMasterSpecialtyNameTH
					, dbo.sysconname(b.Specialty,42197,1) as DoctorMasterSpecialtyNameEN
					, a.PrivateCase
			from	HNIPD_DOCTOR a
					join HNDOCTOR_MASTER b on a.Doctor = b.doctor
			where	a.AN in (select am.AN from HNIPD_MASTER am where am.AdmDateTime between GETDATE()-5 and GETDATE())
					and a.HNDoctorConsultType = 2 
					and a.OffFromDateTime is null
		)dm on a.AN = dm.AN
where	a.AdmDateTime between GETDATE()-5 and GETDATE()

