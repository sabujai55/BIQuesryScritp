--'$P!{dBeginDate}'
--'$P!{dEndDate}'
--'$P!{cVisitTypeID}'
--'$P!{cServicePointId}'
--'$P!{cBaseDepartment}'
--'$P!{bPlan}'
--WITH myconstants (dBeginDate, dEndDate) AS (VALUES (#dBeginDate# , #dEndDate#))
--WITH myconstants (dBeginDate, dEndDate) AS (VALUES ('2023-04-22', '2023-04-22'))
select 	v.visit_id
		, to_char(v.visit_date::timestamp, 'dd/mm/yyyy') as "VisitDate"
		, to_char((v.visit_date || ' ' || v.visit_time)::timestamp, 'dd/mm/yyyy HH24:MI:SS')   as "RegInDateTime"
		, format_vn(v.vn) as "VN"
		, format_hn(v.hn) as "HN"
		, p.prename || p.firstname || ' ' || p.lastname as "PatientName"
		, split_part(v.patient_age,'-',1) as "Age"
		, case when p.pid != '' then chr(39)|| p.pid else '' end as pid
		, p.home_id as "Address"
		, p.place_name as "Village"
		, p.village as "Moo"
		, bpd_addr_tambol(p.fix_changwat_id||p.fix_amphur_id||p.fix_tambol_id) as "Tambon"
		, bpd_addr_amphur(p.fix_changwat_id,p.fix_amphur_id) as "Amphoe"
		, bpd_addr_changwat(p.fix_changwat_id) as "Province"
		, bpg.description as "PatientGroup"
		, bpt.description as "PatientType"
		, vp.plan_code as rightcode
		, p2.description as rightname
		--, find_plan_group(v.visit_id) as rightgroup
		, visit_rightgroup(v.visit_id) as rightgroup
		--, find_visit_plan_group(v.visit_id) as rightgroup2
		, visit_rightgroup2(v.visit_id) as rightgroup2
		, find_visit_all_plan_group(v.visit_id) as all_rightgroup
		, case when p.fix_gender_id = '1' then 'ชาย' when p.fix_gender_id = '2' then 'หญิง' else '' end as gender
		, ap.base_department_id
		, ap.employee_id as "DoctorCode"
		, e.prename || e.firstname || ' ' || e.lastname as "DoctorName"
		, e.profession_code
		, e.care_provider_code as "Specialty"
		, bd3.description as "SubSpecialty"
		, coalesce(sp."DiagRms",'') as "DiagRms"
		, ap.base_department_id as "ClinicCode"
		, bd.description as "ClinicName"
		, case when ap.base_department_id  = '2401' then 'Hemo'
		  when e.care_provider_group_code is null or e.care_provider_group_code = '' then 'Other'
		  else e.care_provider_group_code end as "ClinicGroup"
		, nd."CloseVisitType"
		, nd."CloseVisitName"
		, case when v.new_patient = '1' then 'N' else 'O' end as "NewHos"
		, case when lastvs.visit_id is null then 'N' else 'O' end as "NewClinic"
		, sum(case when v.fix_visit_type_id = '0' and oi.fix_item_type_id not in ('0','10')  then oi.sum_charge else 0 end) as "TreatmentAmt"
		, sum(case when v.fix_visit_type_id = '0' and oi.fix_item_type_id = '10' then oi.sum_charge else 0 end) as "DFTreatmentAmt"
		, sum(case when v.fix_visit_type_id = '0' and oi.fix_item_type_id = '0' then oi.sum_charge else 0 end) as "MedicineAmt"
		, sum(case when v.fix_visit_type_id = '0' then oi.sum_charge else 0 end) as "TotalAmt"
		, di.icd10_code as "PrimaryDiagCode" --**
		, case when di.icd10_code != '' then di.icd10_description else di.beginning_diagnosis end as "PrimaryDiagName"
		, '' as "RemarksMemo"
		, di2.icd10_code as "ECode"
		, case when di2.icd10_code != '' then di2.icd10_description else di2.beginning_diagnosis end as "ECodeName"
		, split_part(como.icd10_code,',',1) as  "ComobidityCode1"
		, split_part(como.icd10_description,',',1) as  "ComobidityName1"
		, split_part(como.icd10_code,',',2) as  "ComobidityCode2"
		, split_part(como.icd10_description,',',2) as  "ComobidityName2"
		, split_part(como.icd10_code,',',3) as  "ComobidityCode3"
		, split_part(como.icd10_description,',',3) as  "ComobidityName3"
		, split_part(como.icd10_code,',',4) as  "ComobidityCode4"
		, split_part(como.icd10_description,',',4) as  "ComobidityName4"
		, split_part(como.icd10_code,',',5) as  "ComobidityCode5"
		, split_part(como.icd10_description,',',5) as  "ComobidityName5"
		, case when v.new_patient  = '1' and lastvs.visit_id is null then 'NewNew'
		  when v.new_patient = '0' and lastvs.visit_id is null then 'OldNew'
		  when v.new_patient = '0' and lastvs.visit_id is not null then 'OldOld' end as "Type"
		, case when apd.fix_discharge_status = 'Admit' and v.fix_visit_type_id = '1' then 'Admit'
		  when find_admit_flag(v.visit_id) =  '0' and v.fix_visit_type_id = '1' and ap.priority = '1' then 'Admit'
		  else '' end as "Admit"
		, case when v.new_patient = '1' and lastvs.visit_id is null then 'New'
		  when v.new_patient  = '0' and lastvs.visit_id is null then 'Old'
		  when v.new_patient  = '0' and lastvs.visit_id is not null then 'Old' end as "New-Old"
		, vp.payer_id as "Sponsor"
		, p3.description as "SponsorName"
		, '' as "CompanyNo"
		, coalesce(pa.place_name,'') as CompanyName
		, coalesce(rec_mtd.receive_code,'') as "ReceiveCode"
		, coalesce((select vs1.pulse from vital_sign_opd vs1 where vs1.pulse <> '' and v.visit_id = vs1.visit_id order by vital_sign_opd_id desc limit 1),'') as "TextPulseRate"
		, coalesce((select vs2.respiration from vital_sign_opd vs2 where vs2.respiration <> '' and v.visit_id = vs2.visit_id order by vital_sign_opd_id desc limit 1),'') as "TextRespireRate"
		, coalesce(split_part(bp.pressure_max,',',1),'')  as "BPHigh"
		, coalesce(split_part(bp.pressure_min,',',1),'')  as "BPLow"
		, coalesce(split_part(bp.pressure_max,',',2),'') as "PostBPHigh"
		, coalesce(split_part(bp.pressure_min,',',2),'') as "PostBPLow"
		, coalesce((select vs5.weight from vital_sign_opd vs5 where vs5.weight <> '' and v.visit_id = vs5.visit_id order by vital_sign_opd_id desc limit 1),'') as "BodyWeight"
		, coalesce((select vs6.height from vital_sign_opd vs6 where vs6.height <> '' and v.visit_id = vs6.visit_id order by vital_sign_opd_id desc limit 1),'') as "height"
		, coalesce((select vs7.temperature from vital_sign_opd vs7 where vs7.temperature <> '' and v.visit_id = vs7.visit_id order by vital_sign_opd_id desc limit 1),'') as "Temperature"
		, e2.prename || e2.firstname || ' ' || e2.lastname as "UserName"
		, p.blood_group as "Blood"
		, case when p.telephone != '' then chr(39) || p.telephone else '' end as "Tel"
		, case when p.mobile != '' then chr(39) || p.mobile else '' end as "MobilePhone"
		, p.email as "EmailAddress"
		, case when (select patient_id from drug_allergy da where v.patient_id = da.patient_id limit 1) is not null then 'มี' else '' end  as "Allergy"
		, case when (select patient_id from personal_illness pi where v.patient_id = pi.patient_id limit 1) is not null then 'มี' else '' end  as "Chronic"
		, 'Y' as "PatientPicture"
		, br.description as "Religion"
		, fn.description as "Nationality"
		, fr.description as "Race"
		, e.care_provider_group_code as "Cluster"
		, bpg2.description as "PlanGroup"
		, case when (v.doctor_discharge_date != '' and v.doctor_discharge_time != '') then to_char((v.doctor_discharge_date  || ' ' || v.doctor_discharge_time)::timestamp, 'dd/mm/yyyy HH24:MI:SS') else null end as "CloseVisitDateTime"
		, case when (v.financial_discharge_date != '' and v.financial_discharge_time != '') then to_char((v.financial_discharge_date  || ' ' || v.financial_discharge_time)::timestamp, 'dd/mm/yyyy HH24:MI:SS') else null end as "DischargeDateTime"
		, split_part(com.icd10_code,',',1) as  "ComplicationCode1"
		, split_part(com.icd10_description,',',1) as  "ComplicationName1"
		, split_part(com.icd10_code,',',2) as  "ComplicationCode2"
		, split_part(com.icd10_description,',',2) as  "ComplicationName2"
		, split_part(com.icd10_code,',',3) as  "ComplicationCode3"
		, split_part(com.icd10_description,',',3) as  "ComplicationName3"
		, split_part(com.icd10_code,',',4) as  "ComplicationCode4"
		, split_part(com.icd10_description,',',4) as  "ComplicationName4"
		, split_part(com.icd10_code,',',5) as  "ComplicationCode5"
		, split_part(com.icd10_description,',',5) as  "ComplicationName5"
		, split_part(cm.icd9_code,',',1) as  "ICD9Code1"
		, split_part(cm.icd9_description,',',1) as  "ICD9Description1"
		, split_part(cm.icd9_code,',',2) as  "ICD9Code2"
		, split_part(cm.icd9_description,',',2) as  "ICD9Description2"
		, split_part(cm.icd9_code,',',3) as  "ICD9Code3"
		, split_part(cm.icd9_description,',',3) as  "ICD9Description3"
		, split_part(cm.icd9_code,',',4) as  "ICD9Code4"
		, split_part(cm.icd9_description,',',4) as  "ICD9Description4"
		, split_part(cm.icd9_code,',',5) as  "ICD9Code5"
		, split_part(cm.icd9_description,',',5) as  "ICD9Description5"
		, split_part(cm.icd9_code,',',6) as  "ICD9Code6"
		, split_part(cm.icd9_description,',',6) as  "ICD9Description6"
		, split_part(oro.prod_code,',',1) as  "ProcedureIcdCmCode"
		, split_part(oro.prod_description,',',1) as  "ProcedureIcdCmName"
		, split_part(oro.prod_code,',',2) as  "ProcedureIcdCmCode2"
		, split_part(oro.prod_description,',',2) as  "ProcedureIcdCmName2"
		, split_part(oro.prod_code,',',3) as  "ProcedureIcdCmCode3"
		, split_part(oro.prod_description,',',3) as  "ProcedureIcdCmName3"
		, split_part(oro.prod_code,',',4) as  "ProcedureIcdCmCode4"
		, split_part(oro.prod_description,',',4) as  "ProcedureIcdCmName4"
		, split_part(oro.prod_code,',',5) as  "ProcedureIcdCmCode5"
		, split_part(oro.prod_description,',',5) as  "ProcedureIcdCmName5"
		, coalesce(vt.description,'') as vip_type
		, coalesce(sum(case when v.fix_visit_type_id = '0' and oi.base_order_category_id = '032' then oi.sum_charge else 0 end),0) as "รายได้ค่ายา"--
		, coalesce(sum(case when v.fix_visit_type_id = '0' and oi.base_order_category_id = '035' then oi.sum_charge else 0 end),0) as "รายได้วัสดุสิ้นเปลือง"--
		, coalesce(sum(case when v.fix_visit_type_id = '0' and oi.base_order_category_id = '001' then oi.sum_charge else 0 end),0) as "รายได้ห้องสังเกตการณ์"--
		, coalesce(sum(case when v.fix_visit_type_id = '0' and oi.base_order_category_id = '003' then oi.sum_charge else 0 end),0) as "รายได้ค่าห้องรอคลอด"--
		, coalesce(sum(case when v.fix_visit_type_id = '0' and oi.base_order_category_id = '004' then oi.sum_charge else 0 end),0) as "รายได้ค่าห้องคลอด"--
		, coalesce(sum(case when v.fix_visit_type_id = '0' and oi.base_order_category_id = '005' then oi.sum_charge else 0 end),0) as "รายได้ค่าห้องICU"--
		, coalesce(sum(case when v.fix_visit_type_id = '0' and oi.base_order_category_id = '006' then oi.sum_charge else 0 end),0) as "รายได้ค่าห้องพักฟื้น"--
		, coalesce(sum(case when v.fix_visit_type_id = '0' and oi.base_order_category_id = '007' then oi.sum_charge else 0 end),0) as "รายได้ค่าห้องผ่าตัด"--
		, coalesce(sum(case when v.fix_visit_type_id = '0' and oi.base_order_category_id = '008' then oi.sum_charge else 0 end),0) as "รายได้ค่าล้างไต"--
		, coalesce(sum(case when v.fix_visit_type_id = '0' and oi.base_order_category_id = '009' then oi.sum_charge else 0 end),0) as "รายได้ค่าดมยา"--
		, coalesce(sum(case when v.fix_visit_type_id = '0' and oi.base_order_category_id = '010' then oi.sum_charge else 0 end),0) as "รายได้ค่าสลายนิ่ว"--
		, coalesce(sum(case when v.fix_visit_type_id = '0' and oi.base_order_category_id = '011' then oi.sum_charge else 0 end),0) as "รายได้ค่าตรวจนิ่ว"--
		, coalesce(sum(case when v.fix_visit_type_id = '0' and oi.base_order_category_id = '012' then oi.sum_charge else 0 end),0) as "รายได้ค่าบริการพยาบาล"--
		, coalesce(sum(case when v.fix_visit_type_id = '0' and oi.base_order_category_id = '013' then oi.sum_charge else 0 end),0) as "รายได้ค่าบริการอื่นๆ"--
		, coalesce(sum(case when v.fix_visit_type_id = '0' and oi.base_order_category_id = '014' then oi.sum_charge else 0 end),0) as "รายได้ค่าพยาบาลพิเศษ"--
		, coalesce(sum(case when v.fix_visit_type_id = '0' and oi.base_order_category_id = '015' then oi.sum_charge else 0 end),0) as "รายได้ค่าเอ็กซเรย์"--
		, coalesce(sum(case when v.fix_visit_type_id = '0' and oi.base_order_category_id = '016' then oi.sum_charge else 0 end),0) as "รายได้ค่าเอ็กซเรย์คอม"--
		, coalesce(sum(case when v.fix_visit_type_id = '0' and oi.base_order_category_id = '017' then oi.sum_charge else 0 end),0) as "รายได้ค่า Ultrasound"--
		, coalesce(sum(case when v.fix_visit_type_id = '0' and oi.base_order_category_id = '018' then oi.sum_charge else 0 end),0) as "รายได้ค่า MRI"--
		, coalesce(sum(case when v.fix_visit_type_id = '0' and oi.base_order_category_id = '019' then oi.sum_charge else 0 end),0) as "รายได้ค่า Mammogram"--
		, coalesce(sum(case when v.fix_visit_type_id = '0' and oi.base_order_category_id = '020' then oi.sum_charge else 0 end),0) as "รายได้ค่าทำ Bone Density"--
		, coalesce(sum(case when v.fix_visit_type_id = '0' and oi.base_order_category_id = '021' then oi.sum_charge else 0 end),0) as "รายได้ค่า DSI Angiography"--
		, coalesce(sum(case when v.fix_visit_type_id = '0' and oi.base_order_category_id = '022' then oi.sum_charge else 0 end),0) as "รายได้ห้องปฎิบัติการ"--
		, coalesce(sum(case when v.fix_visit_type_id = '0' and oi.base_order_category_id = '023' then oi.sum_charge else 0 end),0) as "ห้องปฎิบัติการ-ภายนอก"--
		, coalesce(sum(case when v.fix_visit_type_id = '0' and oi.base_order_category_id = '024' then oi.sum_charge else 0 end),0) as "รายได้ค่าทำ Laser"--
		, coalesce(sum(case when v.fix_visit_type_id = '0' and oi.base_order_category_id = '025' then oi.sum_charge else 0 end),0) as "รายได้ค่าทำ EKG"--
		, coalesce(sum(case when v.fix_visit_type_id = '0' and oi.base_order_category_id = '026' then oi.sum_charge else 0 end),0) as "รายได้ค่า EEG"--
		, coalesce(sum(case when v.fix_visit_type_id = '0' and oi.base_order_category_id = '027' then oi.sum_charge else 0 end),0) as "รายได้ค่าทำ Exercise Stress Test"--
		, coalesce(sum(case when v.fix_visit_type_id = '0' and oi.base_order_category_id = '028' then oi.sum_charge else 0 end),0) as "รายได้ค่า Echo"--
		, coalesce(sum(case when v.fix_visit_type_id = '0' and oi.base_order_category_id = '029' then oi.sum_charge else 0 end),0) as "รายได้ค่า Holter"--
		, coalesce(sum(case when v.fix_visit_type_id = '0' and oi.base_order_category_id = '030' then oi.sum_charge else 0 end),0) as "ค่าตรวจสมรรถภาพปอด"--
		, coalesce(sum(case when v.fix_visit_type_id = '0' and oi.base_order_category_id = '031' then oi.sum_charge else 0 end),0) as "รายได้ปฎิบัติการแพทย์อื่นๆ"--
		, coalesce(sum(case when v.fix_visit_type_id = '0' and oi.base_order_category_id = '033' then oi.sum_charge else 0 end),0) as "รายได้ค่าบริการโลหิต"--
		, coalesce(sum(case when v.fix_visit_type_id = '0' and oi.base_order_category_id = '034' then oi.sum_charge else 0 end),0) as "รายได้ค่าอ๊อกซิเจน"--
		, coalesce(sum(case when v.fix_visit_type_id = '0' and oi.base_order_category_id = '036' then oi.sum_charge else 0 end),0) as "รายได้ค่ากายภาพบำบัด"--
		, coalesce(sum(case when v.fix_visit_type_id = '0' and oi.base_order_category_id = '037' then oi.sum_charge else 0 end),0) as "รายได้ค่ารถพยาบาล"--
		, coalesce(sum(case when v.fix_visit_type_id = '0' and oi.base_order_category_id = '038' then oi.sum_charge else 0 end),0) as "รายได้ค่าอาหารคนไข้"--
		, coalesce(sum(case when v.fix_visit_type_id = '0' and oi.base_order_category_id = '039' then oi.sum_charge else 0 end),0) as "รายได้ค่าโทรศัพท์"--
		, coalesce(sum(case when v.fix_visit_type_id = '0' and oi.base_order_category_id = '040' then oi.sum_charge else 0 end),0) as "ค่าใช้อุปกรณ์การแพทย์"--
		, coalesce(sum(case when v.fix_visit_type_id = '0' and oi.base_order_category_id = '041' then oi.sum_charge else 0 end),0) as "ใบเคลมหรือใบรับรองแพทย์"--
		, coalesce(sum(case when v.fix_visit_type_id = '0' and oi.base_order_category_id = '042' then oi.sum_charge else 0 end),0) as "รายได้ค่าฉีดศพ"--
		, coalesce(sum(case when v.fix_visit_type_id = '0' and oi.base_order_category_id = '043' then oi.sum_charge else 0 end),0) as "ค่าแพทย์ทั่วไป"--
		, coalesce(sum(case when v.fix_visit_type_id = '0' and oi.base_order_category_id = '044' then oi.sum_charge else 0 end),0) as "ค่าแพทย์ผ่าตัด"--
		, coalesce(sum(case when v.fix_visit_type_id = '0' and oi.base_order_category_id = '045' then oi.sum_charge else 0 end),0) as "ค่าแพทย์ทันตกรรม"--
		, coalesce(sum(case when v.fix_visit_type_id = '0' and oi.base_order_category_id = '046' then oi.sum_charge else 0 end),0) as "ค่าแพทย์อ่านผล"--
		, coalesce(sum(case when v.fix_visit_type_id = '0' and oi.base_order_category_id = '047' then oi.sum_charge else 0 end),0) as "ค่าแพทย์อื่นๆ"--
		, coalesce(sum(case when v.fix_visit_type_id = '0' and oi.base_order_category_id = '048' then oi.sum_charge else 0 end),0) as "รายได้การขายอาหารญาติ"--
		, coalesce(sum(case when v.fix_visit_type_id = '0' and oi.base_order_category_id = '049' then oi.sum_charge else 0 end),0) as "รายได้รับเลี้ยงเด็ก"--
		, coalesce(sum(case when v.fix_visit_type_id = '0' and oi.base_order_category_id = '070' then oi.sum_charge else 0 end),0) as "รายได้ทันตกรรม"--
		, coalesce(sum(case when v.fix_visit_type_id = '0' and oi.base_order_category_id = '101' then oi.sum_charge else 0 end),0) as "ส่วนลดทั่วไป"--xx
		, coalesce(sum(case when v.fix_visit_type_id = '0' and oi.base_order_category_id = '102' then oi.sum_charge else 0 end),0) as "ส่วนลดบริษัทคู่สัญญา"--xx
		, coalesce(sum(case when v.fix_visit_type_id = '0' and oi.base_order_category_id = '103' then oi.sum_charge else 0 end),0) as "ส่วนลดตรวจสุขภาพ"--xx
		, coalesce(sum(case when v.fix_visit_type_id = '0' and oi.base_order_category_id = '104' then oi.sum_charge else 0 end),0) as "ส่วนลดบริการเหมาจ่าย"--xx
		, coalesce(sum(case when v.fix_visit_type_id = '0' and oi.plan_id = 'GV_0005_000' then oi.sum_charge else 0 end),0) as sso_amt
		,	TB."CloseVisitDateTime"
		,	TB."AppointmentDateTime"
		,	TB."Ack_Nurse"
		, 	TB."Checkin"
		,	TB."First LabCode"
		,	TB."First XrayCode"
		, 	TB."Checkout"
		,	TB."DoctorApprovePrescription"
		,	TB."DrugAck"
		,	TB."Receipt"
from 	visit v inner join attending_physician ap on v.visit_id = ap.visit_id and v.active = '1'
		left join base_patient_group bpg on v.base_patient_group_id = bpg.base_patient_group_id
		left join base_patient_type bpt on v.base_patient_type_id = bpt.base_patient_type_id
		inner join base_department bd on ap.base_department_id = bd.base_department_id and bd.account_product = 'COST'
		left join employee e on ap.employee_id = e.employee_id
		left join employee e2 on v.visit_eid = e2.employee_id
		left join base_department bd3 on e.base_med_department_id = bd3.base_department_id
		inner join patient p on v.patient_id = p.patient_id
		left join base_religion br on p.religion = br.base_religion_id
		left join fix_race fr on p.fix_race_id = fr.fix_race_id
		left join fix_nationality fn on p.fix_nationality_id = fn.fix_nationality_id
		left join patient_address pa on p.patient_id = pa.patient_id and pa.fix_address_type_id = '3'
		inner join visit_payment vp on v.visit_id = vp.visit_id and vp.priority = '1'
		left join plan p2 on vp.plan_id = p2.plan_id
		left join payer p3 on vp.payer_id = p3.payer_id
		left join base_plan_group bpg2 on p3.base_plan_group_id = bpg2.base_plan_group_id
		left join diagnosis_icd10 di on ap.visit_id = di.visit_id and di.fix_diagnosis_type_id = '1' and ap.employee_id = di.doctor_eid
		left join diagnosis_icd10 di2 on ap.visit_id = di2.visit_id and di2.fix_diagnosis_type_id = '5' and ap.employee_id = di2.doctor_eid  --"ECode"
		left join attending_physicial_discharge apd on ap.visit_id = apd.visit_id and ap.attending_physician_id = apd.attending_physician_id
		left join vip_type vt on p.vip_type_id = vt.vip_type_id
		left join doctor_discharge_opd as diso on v.visit_id = diso.visit_id
--**************************************** Order Charge ****************************************
		left join
		(
			select 	v.visit_id
					, oi.fix_item_type_id
					, oi.base_order_category_id
					, oi.plan_id
					, case when oi.order_doctor_eid != '' and ap.employee_id is not null then oi.order_doctor_eid
					  else (select employee_id from attending_physician ap where ap.visit_id = v.visit_id and ap.priority = '1' ) end as link_doctor_id
					--, case when ap.erp_department_code is not null then bd.erp_department_code
					--  else (select bd2.erp_department_code from attending_physician ap2 inner join base_department bd2 on ap2.base_department_id = bd2.base_department_id where ap2.visit_id = v.visit_id and ap2.priority = '1')
					--  end as link_department_id
					, case when ap.base_department_id != '' then ap.base_department_id 
					  else (select ap2.base_department_id  from attending_physician ap2 where ap2.visit_id = v.visit_id and ap2.priority = '1')
					  end as link_department_id
					, sum(case when oi.fix_set_type_id = '2' then (oi.original_unit_price::decimal * oi.quantity::decimal) else (oi.unit_price_sale::decimal * oi.quantity::decimal) end) as sum_charge
			from 	visit v inner join order_item oi on v.visit_id = oi.visit_id
					inner join base_service_point bsp  on oi.order_spid = bsp.base_service_point_id
					left join base_department bd on bsp.base_department_id = bd.base_department_id and bd.account_product = 'COST'
					left join attending_physician ap on  oi.visit_id = ap.visit_id and oi.order_doctor_eid = ap.employee_id and bsp.base_department_id = ap.base_department_id 
					/*
					left join
					(
						select 	ap.visit_id
								, ap.priority
								, bd.erp_department_code
								, ap.employee_id
						from 	attending_physician ap inner join base_department bd on ap.base_department_id = bd.base_department_id
						where 	ap.visit_id  = '123041708084559601'
					)ap on ap.visit_id = oi.visit_id and oi.order_doctor_eid = ap.employee_id and bd.erp_department_code = ap.erp_department_code
					*/
					
			where 	v.visit_date between #dBeginDate# and #dEndDate#
					and oi.fix_set_type_id != '1'
			group by
			v.visit_id
			, oi.fix_item_type_id
			, oi.base_order_category_id
			, oi.plan_id
			, case when oi.order_doctor_eid != '' and ap.employee_id is not null then oi.order_doctor_eid
			  else (select employee_id from attending_physician ap where ap.visit_id = v.visit_id and ap.priority = '1' ) end
			--, case when ap.erp_department_code is not null then bd.erp_department_code
			--  else (select bd2.erp_department_code from attending_physician ap2 inner join base_department bd2 on ap2.base_department_id = bd2.base_department_id where ap2.visit_id = v.visit_id and ap2.priority = '1') end
			, case when ap.base_department_id != '' then ap.base_department_id 
			  else (select ap2.base_department_id  from attending_physician ap2 where ap2.visit_id = v.visit_id and ap2.priority = '1') end
		)oi on ap.visit_id = oi.visit_id and bd.base_department_id  = oi.link_department_id and ap.employee_id = oi.link_doctor_id
--**************************************** Nurse Discharge ****************************************
		left join
		(
			select 	row_number() over(partition by nd.visit_id, nd.attending_physician_id order by nd.assess_date || ' ' || nd.assess_time desc) as rowid
 					, nd.visit_id
					, nd.attending_physician_id
					, nd.fix_discharge_status as "CloseVisitType"
					, case when nd.fix_discharge_status = '51' then 'Home'
					  when nd.fix_discharge_status = '52' then 'Death'
					  when nd.fix_discharge_status = '53' then 'Consult'
					  when nd.fix_discharge_status = '54' then 'Refer'
					  when nd.fix_discharge_status = 'Admit' then 'Admission Ward/ICU/CCU'
					  when nd.fix_discharge_status = 'OR' then 'Operation room'
					  when nd.fix_discharge_status = 'LR' then 'Delivery room' end as "CloseVisitName"
			from 	nurse_discharge nd
			
			where 	nd.visit_id in (select visit_id from visit where visit_date between #dBeginDate# and #dEndDate#)
		)nd on ap.visit_id = nd.visit_id and ap.attending_physician_id = nd.attending_physician_id and nd.rowid =1
--**************************************** DiagRms ****************************************
		left join
		(
			select  row_number() over(partition by visit_id, next_department_id) as rowid
					, visit_id
					, a.next_operate_eid
					, bd.base_department_id 
					, bd.erp_department_code
					, a.next_location_spid as location_spid
					, a.next_location_spid || ' : ' || b.description  as "DiagRms"
			from	visit_queue a inner join base_service_point b on a.next_location_spid = b.base_service_point_id and b.fix_service_point_group_id = '2'
					inner join base_department bd on b.base_department_id = bd.base_department_id
					
			where   a.visit_id  in (select visit_id from visit where visit_date between #dBeginDate# and #dEndDate#)
					and (case when '0' = '0' then '1' else a.next_location_spid = '$P!{cServicePointId}' end)
		)sp on sp.rowid = 1 and ap.visit_id = sp.visit_id and ap.employee_id  = sp.next_operate_eid and ap.base_department_id  = sp.base_department_id
--**************************************** Option Select Location ****************************************
		inner join
		(
			select  distinct visit_id
			from	visit_queue vq
			
			where   vq.visit_id   in (select visit_id from visit where visit_date between #dBeginDate# and #dEndDate#)
					and (case when '0' = '0' then '1' else vq.next_location_spid = '$P!{cServicePointId}' end)
		)sp2 on v.visit_id = sp2.visit_id
--**************************************** Last Visit ****************************************
		left join
		(
			select  row_number () over(partition by a.patient_id, b.base_department_id order by a.visit_id asc) as rowid
					, a.patient_id
					, a.visit_id
					, a.visit_date
					, b.base_department_id
			from    visit a inner join attending_physician b on a.active = '1' and b.priority = '1' and a.visit_id = b.visit_id
					inner join base_department bd on b.base_department_id = bd.base_department_id and bd.account_product <> 'ADMIN'
					
			where 	a.visit_id  in (select visit_id from visit where visit_date between #dBeginDate# and #dEndDate#)
		)lastvs on lastvs.rowid = 1 and v.patient_id = lastvs.patient_id and ap.base_department_id  = lastvs.base_department_id and v.visit_id <> lastvs.visit_id
--**************************************** Dx Comorbidity ****************************************
		left join
		(
			select 	di.visit_id
					, di.doctor_eid
					, string_agg(di.icd10_code,',' order by di.diagnosis_icd10_id asc) as icd10_code
					, string_agg(di.icd10_description,',' order by di.diagnosis_icd10_id asc) as icd10_description
			from 	diagnosis_icd10 di
			where 	di.visit_id in (select visit_id from visit where visit_date between #dBeginDate# and #dEndDate#)
					and di.fix_diagnosis_type_id = '2'
			group by di.visit_id, di.doctor_eid
		)como on ap.visit_id = como.visit_id and ap.employee_id = como.doctor_eid
--**************************************** Dx Complication ****************************************
		left join
		(
			select 	di.visit_id
					, di.doctor_eid
					, string_agg(di.icd10_code,',' order by di.diagnosis_icd10_id asc) as icd10_code
					, string_agg(di.icd10_description,',' order by di.diagnosis_icd10_id asc) as icd10_description
			from 	diagnosis_icd10 di
			where 	di.visit_id in (select visit_id from visit where visit_date between #dBeginDate# and #dEndDate#)
					and di.fix_diagnosis_type_id = '3'
			group by di.visit_id, di.doctor_eid
		)com on ap.visit_id = com.visit_id and ap.employee_id = com.doctor_eid
--**************************************** ICD9 ****************************************
		left join
		(
			SELECT 	di.visit_id
				    , di.doctor_eid
				    , string_agg(di.icd9_code,',' order by di.fix_operation_type_id, di.diagnosis_icd9_id asc) as icd9_code
					, string_agg(di.icd9_description,',' order by di.fix_operation_type_id, di.diagnosis_icd9_id asc) as icd9_description
		   	FROM 	diagnosis_icd9 di
		   	where 	di.visit_id in (select visit_id from visit where visit_date between #dBeginDate# and #dEndDate#)
		   			and di.icd9_code <> ''
		   	group by di.visit_id , di.doctor_eid
		)cm on ap.visit_id = cm.visit_id and ap.employee_id = cm.doctor_eid
--**************************************** Procedure ****************************************
		left join
		(
			SELECT 	or2.visit_id
					, os.set_doctor_eid
					, string_agg(oro.icd9_code ,',' order by oro.op_registered_operation_id  asc) as prod_code
					, string_agg(oro.operation_name ,',' order by oro.op_registered_operation_id asc) as prod_description
			FROM 	op_registered or2 inner join op_registered_operation oro on or2.op_registered_id = oro.op_registered_id
					inner join op_set os on or2.op_set_id = os.op_set_id
			where 	or2.visit_id in (select visit_id from visit where visit_date between #dBeginDate# and #dEndDate#)
			group by or2.visit_id  , os.set_doctor_eid
		)oro on ap.visit_id = oro.visit_id and ap.employee_id = oro.set_doctor_eid
--**************************************** Receive Code ****************************************
		left join
		(
			select  a.visit_id
					, concatenate(distinct b.base_paid_method_id) as receive_code
			from    receipt a inner join receipt_paid_method b on a.fix_receipt_type_id in ('1','6','7') and a.fix_receipt_status_id  = '2' and a.receipt_id = b.receipt_id
			where 	a.visit_id in (select visit_id from visit where visit_date between #dBeginDate# and #dEndDate#)
			group by a.visit_id
		)rec_mtd on v.visit_id = rec_mtd.visit_id
--**************************************** VitalSign BP ****************************************
		left join
		(
			select 	vso.visit_id
					, string_agg(vso.pressure_max,',' order by vso.measure_date || ' ' || vso.measure_time desc) as pressure_max
					, string_agg(vso.pressure_min,',' order by vso.measure_date || ' ' || vso.measure_time desc) as pressure_min
			from 	vital_sign_opd vso inner join visit v on vso.visit_id = v.visit_id
			where 	v.visit_id in (select visit_id from visit where visit_date between #dBeginDate# and #dEndDate#)
					and (vso.pressure_max != '' and vso.pressure_min  != '')
			group by
			vso.visit_id
		)bp on v.visit_id = bp.visit_id
left join 
		(
			select 	distinct
					a.visit_id
				,	a.doctor_discharge_date || ' ' || a.doctor_discharge_time as "CloseVisitDateTime"
				,	d.appoint_date || ' ' || d.appoint_time as "AppointmentDateTime"
				,	(select aa.nurse_assess_date || ' ' || aa.nurse_assess_time from vital_sign_extend as aa where b.attending_physician_id = aa.attending_physician_id and aa.nurse_eid <> '' order by aa.nurse_assess_date,aa.nurse_assess_time desc limit 1) as "Ack_Nurse"
				, 	b.begin_date || ' ' || b.begin_time as "Checkin"
				,	b.employee_id
				,	(select aa.verify_date || ' ' || aa.verify_time from order_item as aa where a.visit_id = aa.visit_id and aa.fix_item_type_id = '1' order by aa.verify_date,aa.verify_time asc limit 1) as "First LabCode"
				,	(select aa.verify_date || ' ' || aa.verify_time from order_item as aa where a.visit_id = aa.visit_id and aa.fix_item_type_id = '2' order by aa.verify_date,aa.verify_time asc limit 1) as "First XrayCode"
				, 	b.finish_date || ' ' || b.finish_time  as "Checkout"
				,	(select aa.approve_date || ' ' || aa.approve_time from prescription as aa where a.visit_id = aa.visit_id and aa.assign_doctor_eid = b.employee_id order by aa.approve_date,aa.approve_time desc limit 1)as "DoctorApprovePrescription"
				,	(select aa.execute_date || ' ' || aa.execute_time from order_item as aa where a.visit_id = aa.visit_id and (select pn from prescription as aa where a.visit_id = aa.visit_id and aa.assign_doctor_eid = b.employee_id order by aa.approve_date,aa.approve_time desc limit 1)  = aa.assigned_ref_no order by aa.execute_date,aa.execute_time desc limit 1) as "DrugAck"
				,	(select aa.receive_date || ' ' || aa.receive_time from receipt as aa where a.visit_id = aa.visit_id order by aa.receive_date,aa.receive_time desc limit 1) as "Receipt"
			from visit as a 
			left join attending_physician as b on a.visit_id = b.visit_id and b.priority = '1'
			left join appointment as d on a.visit_id = d.visit_id
			--left join prescription as e on a.visit_id = e.visit_id and e.assign_doctor_eid = b.employee_id
			where 	a.visit_date between #dBeginDate# and #dEndDate#
		)TB on TB.visit_id = v.visit_id and ap.employee_id = TB.employee_id
		
where 	
		v.visit_date between #dBeginDate# and #dEndDate#
		and (case when 'all' = 'all' then '1' else v.fix_visit_type_id = '$P!{cVisitTypeID}' end)
		and (case when 'all' = 'all' then '1' else ap.base_department_id = '$P!{cBaseDepartment}' end)
		--and (case when '$P!{cServicePointId}' = '0' then '1' else sp.location_spid = '$P!{cServicePointId}' end)
		and (case when 'all' = 'all' then '1' else p2.plan_code = '$P!{bPlan}' end)
group by
v.visit_id
, to_char(v.visit_date::timestamp, 'dd/mm/yyyy')
, to_char((v.visit_date || ' ' || v.visit_time)::timestamp, 'dd/mm/yyyy HH24:MI:SS')
, format_vn(v.vn)
, format_hn(v.hn)
, p.prename || p.firstname || ' ' || p.lastname
, split_part(v.patient_age,'-',1)
, p.home_id
, p.place_name
, p.village
, bpd_addr_tambol(p.fix_changwat_id||p.fix_amphur_id||p.fix_tambol_id)
, bpd_addr_amphur(p.fix_changwat_id,p.fix_amphur_id)
, bpd_addr_changwat(p.fix_changwat_id)
, bpg.description
, bpt.description
, vp.plan_code
, p2.description
, find_plan_group(v.visit_id)
--, find_visit_plan_group(v.visit_id)
, p2.base_plan_group_id
, find_visit_all_plan_group(v.visit_id)
, case when p.fix_gender_id = '1' then 'ชาย' when p.fix_gender_id = '2' then 'หญิง' else '' end
, ap.base_department_id
, ap.employee_id
, e.prename || e.firstname || ' ' || e.lastname
, e.care_provider_code
, bd3.description
, sp."DiagRms"
, ap.base_department_id
, bd.description
, case when ap.base_department_id  = '2401' then 'Hemo'
  when e.care_provider_group_code is null or e.care_provider_group_code = '' then 'Other'
  else e.care_provider_group_code end
, nd."CloseVisitType"
, nd."CloseVisitName"
, case when v.new_patient = '1' then 'N' else 'O' end
, case when lastvs.visit_id is null then 'N' else 'O' end
, di.icd10_code
, case when di.icd10_code != '' then di.icd10_description else di.beginning_diagnosis end
, di2.icd10_code
, case when di2.icd10_code != '' then di2.icd10_description else di2.beginning_diagnosis end
, split_part(como.icd10_code,',',1)
, split_part(como.icd10_description,',',1)
, split_part(como.icd10_code,',',2)
, split_part(como.icd10_description,',',2)
, split_part(como.icd10_code,',',3)
, split_part(como.icd10_description,',',3)
, split_part(como.icd10_code,',',4)
, split_part(como.icd10_description,',',4)
, split_part(como.icd10_code,',',5)
, split_part(como.icd10_description,',',5)
, case when v.new_patient  = '1' and lastvs.visit_id is null then 'NewNew'
  when v.new_patient = '0' and lastvs.visit_id is null then 'OldNew'
  when v.new_patient = '0' and lastvs.visit_id is not null then 'OldOld' end
, case when apd.fix_discharge_status = 'Admit' and v.fix_visit_type_id = '1' then 'Admit'
  when find_admit_flag(v.visit_id) =  '0' and v.fix_visit_type_id = '1' and ap.priority = '1' then 'Admit'
  else '' end
, case when v.new_patient = '1' and lastvs.visit_id is null then 'New'
  when v.new_patient  = '0' and lastvs.visit_id is null then 'Old'
  when v.new_patient  = '0' and lastvs.visit_id is not null then 'Old' end
, vp.payer_id
, p3.description
, pa.place_name
, coalesce(rec_mtd.receive_code,'')
, coalesce(split_part(bp.pressure_max,',',1),'')
, coalesce(split_part(bp.pressure_min,',',1),'')
, coalesce(split_part(bp.pressure_max,',',2),'')
, coalesce(split_part(bp.pressure_min,',',2),'')
, e2.prename || e2.firstname || ' ' || e2.lastname
, p.blood_group
, p.telephone
, p.mobile
, p.email
, br.description
, fn.description
, fr.description
, e.care_provider_group_code
, p.pid
, e.profession_code
, bpg2.description
, case when (v.doctor_discharge_date != '' and v.doctor_discharge_time != '') then to_char((v.doctor_discharge_date  || ' ' || v.doctor_discharge_time)::timestamp, 'dd/mm/yyyy HH24:MI:SS') else null end
, split_part(com.icd10_code,',',1)
, split_part(com.icd10_description,',',1)
, split_part(com.icd10_code,',',2)
, split_part(com.icd10_description,',',2)
, split_part(com.icd10_code,',',3)
, split_part(com.icd10_description,',',3)
, split_part(com.icd10_code,',',4)
, split_part(com.icd10_description,',',4)
, split_part(com.icd10_code,',',5)
, split_part(com.icd10_description,',',5)
, split_part(cm.icd9_code,',',1)
, split_part(cm.icd9_description,',',1)
, split_part(cm.icd9_code,',',2)
, split_part(cm.icd9_description,',',2)
, split_part(cm.icd9_code,',',3)
, split_part(cm.icd9_description,',',3)
, split_part(cm.icd9_code,',',4)
, split_part(cm.icd9_description,',',4)
, split_part(cm.icd9_code,',',5)
, split_part(cm.icd9_description,',',5)
, split_part(cm.icd9_code,',',6)
, split_part(cm.icd9_description,',',6)
, split_part(oro.prod_code,',',1)
, split_part(oro.prod_description,',',1)
, split_part(oro.prod_code,',',2)
, split_part(oro.prod_description,',',2)
, split_part(oro.prod_code,',',3)
, split_part(oro.prod_description,',',3)
, split_part(oro.prod_code,',',4)
, split_part(oro.prod_description,',',4)
, split_part(oro.prod_code,',',5)
, split_part(oro.prod_description,',',5)
, ap.priority
, vt.description
		,	TB."CloseVisitDateTime"
		,	TB."AppointmentDateTime"
		,	TB."Ack_Nurse"
		, 	TB."Checkin"
		,	TB."First LabCode"
		,	TB."First XrayCode"
		, 	TB."Checkout"
		,	TB."DoctorApprovePrescription"
		,	TB."DrugAck"
		,	TB."Receipt"
order by v.visit_id , ap.priority

