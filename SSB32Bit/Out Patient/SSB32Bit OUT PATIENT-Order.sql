select  'PLS' as 'BU' , datamst.*
		from 
			((
				select  
						CONVERT(varchar,vnt.VISITDATE,112)+CONVERT(varchar,vnt.VN)+CONVERT(varchar,vnt.MAKEDATETIME,112)+CONVERT(varchar,vnt.SUBSUFFIX) as 'OrderID'
						,vnm.HN as 'PatientID'
						,CONVERT(varchar,vnp.VISITDATE,112)+CONVERT(varchar,vnp.VN)+CONVERT(varchar,vnp.SUFFIX) as 'VisitID'
						,vnt.VISITDATE as 'VisitDate'
						,vnt.VN
						,vnt.SUFFIX as 'PrescriptionNo'
						,vnt.MAKEDATETIME as 'MakeDateTime'
						,'Treatment' as 'ItemType'
						,case when vnt.TREATMENTCODE is null then vnt.CHARGECODE else vnt.TREATMENTCODE end  as 'ItemCode'
						,case when vnt.TREATMENTCODE is null then dbo.sysconname(vnt.CHARGECODE,20023,2) else dbo.sysconname(vnt.TREATMENTCODE,20051,2) end as 'ItemNameTH' --แก้ไขวันที่ 27/02/2568
						,case when vnt.TREATMENTCODE is null then dbo.sysconname(vnt.CHARGECODE,20023,1) else dbo.sysconname(vnt.TREATMENTCODE,20051,1) end as 'ItemNameEN' --เพิ่มวันที่ 27/02/2568
						,vnt.CHARGECODE as 'ActivityCode'
						,dbo.sysconname(vnt.CHARGECODE,20023,2) as 'ActivityNameTH' --แก้ไขวันที่ 27/02/2568
						,dbo.sysconname(vnt.CHARGECODE,20023,1) as 'ActivityNameEN' --เพิ่มวันที่ 27/02/2568
						,'' as 'UnitCode'
						,'' as 'UnitNameTH' --แก้ไขวันที่ 27/02/2568
						,'' as 'UnitNameEN' --เพิ่มวันที่ 27/02/2568
						,case when vnt.REVERSE = 1 then vnt.QTY*-1 else vnt.QTY end as 'QTY'
						,'' as 'UnitPrice'
						,case when vnt.REVERSE = 1 then vnt.AMT*-1 else vnt.AMT end as 'ChargeAmt'
						,case when vnt.TYPEOFCHARGE = 0 then 'Charge'
							  when vnt.TYPEOFCHARGE = 1 then 'Free'
							  when vnt.TYPEOFCHARGE = 2 then 'Refund'
							  when vnt.TYPEOFCHARGE = 3 then 'Cxl'
							  when vnt.TYPEOFCHARGE = 4 then 'Usage FOC'
							  when vnt.TYPEOFCHARGE = 5 then 'Never Charge'
							  when vnt.TYPEOFCHARGE = 6 then 'Adjust'
							  when vnt.TYPEOFCHARGE = 7 then 'Return Usage FOC' end as 'ChargeType'
						,vnt.MAKEDATETIME as 'ChargeDateTime'
						,dbo.sysconname(vnt.FACILITYRMS,20045,4) as 'EntryByFacility'
						,vnt.FACILITYREF as 'RefNo'
						,vnt.CXLBYUSERCODE as 'CancelByUserCode' --แก้ไขวันที่ 27/02/2568
						,dbo.sysconname(vnt.CXLBYUSERCODE,10000,2) as 'CancelByUserNameTH' --เพิ่มวันที่ 27/02/2568
						,dbo.sysconname(vnt.CXLBYUSERCODE,10000,1) as 'CancelByUserNameEN' --เพิ่มวันที่ 27/02/2568
						,vnt.CXLDATETIME as 'CancelDateTime'
						,'' as 'TreatmentDateTimeFrom'
						,'' as 'TreatmentDateTimeTo'
						,case when vnt.TREATMENTCODE like 'DF%' then vnt.DOCTOR else '' end as 'DFDoctor'
						,vnt.RIGHTCODE as 'RightCode'
						,dbo.sysconname(vnt.RIGHTCODE,20019,2) as 'RightNameTH' --แก้ไขวันที่ 27/02/2568
						,dbo.sysconname(vnt.RIGHTCODE,20019,1) as 'RightNameEN' --เพิ่มวันที่ 27/02/2568
						,'' as 'StoreCode'
						,'' as 'StoreNameTH' --แก้ไขวันที่ 27/02/2568
						,'' as 'StoreNameEN' --เพิ่มวันที่ 27/02/2568
						,'' as 'DoseType'
						,'' as 'DoseCode'
						,'' as 'DoseQTY'
						,'' as 'DoseUnit'
						,'' as 'DoseFreqCode'
						,'' as 'AuxLabel1'
						,'' as 'AuxLabel2'
						,'' as 'AuxLabel3'
						,'' as 'EntryByFacilityMethodCode'
						,'' as 'EntryByFacilityMethodNameTH' --แก้ไขวันที่ 27/02/2568
						,'' as 'EntryByFacilityMethodNameEN' --เพิ่มวันที่ 27/02/2568
						,'' as 'Checkup'
						,'' as 'DoseMemo'
						,case when (Convert(int, substring(sc.com,51,1)) =0 ) Then 0
						when (Convert(int, substring(sc.com,51,1)) =1 ) Then 1 end as 'FlagDF' --เพิ่มวันที่ 17/02/2568
						,CAST(SUBSTRING(act.COM,91,3)as varchar) as 'ActivityCategoryCode' --เพิ่มวันที่ 27/02/2568
						,dbo.sysconname(CAST(SUBSTRING(act.COM,91,3)as varchar),10051,2) as 'ActivityCategoryNameTH' --เพิ่มวันที่ 27/02/2568
						,dbo.sysconname(CAST(SUBSTRING(act.COM,91,3)as varchar),10051,1) as 'ActivityCategoryNameEN' --เพิ่มวันที่ 27/02/2568
						from VNTREAT vnt
						left join VNPRES vnp on vnt.VN=vnp.VN and vnt.VISITDATE=vnp.VISITDATE and vnt.SUFFIX=vnp.SUFFIX
						left join VNMST vnm on vnp.VN=vnm.VN and vnp.VISITDATE=vnm.VISITDATE
						left join SYSCONFIG sc on vnt.TREATMENTCODE=sc.CODE and sc.CTRLCODE = 20051
						left join SYSCONFIG act on vnt.CHARGECODE=act.CODE and act.CTRLCODE = 20023
						where vnt.FACILITYSYSTEM not in (9,8,4,6)
		)  
		union all
		(
				select  
						CONVERT(varchar,vnmed.VISITDATE,112)+CONVERT(varchar,vnmed.VN)+CONVERT(varchar,vnmed.MAKEDATETIME,112)+CONVERT(varchar,vnmed.SUBSUFFIX) as 'OrderID'
						,vnm.HN as 'PatientID'
						,CONVERT(varchar,vnp.VISITDATE,112)+CONVERT(varchar,vnp.VN)+CONVERT(varchar,vnp.SUFFIX) as 'VisitID'
						,vnmed.VISITDATE as 'VisitDate'
						,vnmed.VN
						,vnmed.SUFFIX as 'PrescriptionNo'
						,vnmed.MAKEDATETIME as 'MakeDateTime'
						,case when stm.MEDICALSUPPLY = 1 then 'Usage' else 'Medicine' end as 'ItemType'
						,vnmed.STOCKCODE  as 'ItemCode'
						,substring(stm.THAINAME,2,len(stm.THAINAME)) as 'ItemNameTH' --แก้ไขวันที่ 27/02/2568
						,substring(stm.ENGLISHNAME,2,len(stm.ENGLISHNAME)) as 'ItemNameEN' --เพิ่มวันที่ 27/02/2568
						,vnmed.CHARGECODE as 'ActivityCode'
						,dbo.sysconname(vnmed.CHARGECODE,20023,2) as 'ActivityNameTH' --แก้ไขวันที่ 27/02/2568
						,dbo.sysconname(vnmed.CHARGECODE,20023,1) as 'ActivityNameEN' --เพิ่มวันที่ 27/02/2568
						,vnmed.UNITCODE as 'UnitCode'
						,dbo.sysconname(vnmed.UNITCODE,40016,2) as 'UnitNameTH' --แก้ไขวันที่ 27/02/2568
						,dbo.sysconname(vnmed.UNITCODE,40016,1) as 'UnitNameEN' --เพิ่มวันที่ 27/02/2568
						,case when vnmed.REVERSE = 1 then vnmed.QTY*-1 else vnmed.QTY end as 'QTY'
						,vnmed.UNITPRICE as 'UnitPrice'
						,case when vnmed.REVERSE = 1 then vnmed.AMT*-1 else vnmed.AMT end as 'ChargeAmt'
						,case when vnmed.TYPEOFCHARGE = 0 then 'Charge'
							  when vnmed.TYPEOFCHARGE = 1 then 'Free'
							  when vnmed.TYPEOFCHARGE = 2 then 'Refund'
							  when vnmed.TYPEOFCHARGE = 3 then 'Cxl'
							  when vnmed.TYPEOFCHARGE = 4 then 'Usage FOC'
							  when vnmed.TYPEOFCHARGE = 5 then 'Never Charge'
							  when vnmed.TYPEOFCHARGE = 6 then 'Adjust'
							  when vnmed.TYPEOFCHARGE = 7 then 'Return Usage FOC' end as 'ChargeType'
						,vnmed.MAKEDATETIME as 'ChargeDateTime'
						,'' as 'EntryByFacility'
						,vnmed.ORDERREF as 'RefNo'
						,vnmed.CXLBYUSERCODE as 'CancelByUserCode' --แก้ไขวันที่ 27/02/2568
						,dbo.sysconname(vnmed.CXLBYUSERCODE,10000,2) as 'CancelByUserNameTH' --เพิ่มวันที่ 27/02/2568
						,dbo.sysconname(vnmed.CXLBYUSERCODE,10000,1) as 'CancelByUserNameEN' --เพิ่มวันที่ 27/02/2568
						,vnmed.CXLDATETIME as 'CancelDateTime'
						,'' as 'TreatmentDateTimeFrom'
						,'' as 'TreatmentDateTimeTo'
						,'' as 'DFDoctor'
						,vnmed.RIGHTCODE as 'RightCode'
						,dbo.sysconname(vnmed.RIGHTCODE,20019,2) as 'RightNameTH' --แก้ไขวันที่ 27/02/2568
						,dbo.sysconname(vnmed.RIGHTCODE,20019,1) as 'RightNameEN' --เพิ่มวันที่ 27/02/2568
						,vnmed.STORE as 'StoreCode'
						,dbo.sysconname(vnmed.STORE,40010,2) as 'StoreNameTH' --แก้ไขวันที่ 27/02/2568
						,dbo.sysconname(vnmed.STORE,40010,1) as 'StoreNameEN' --เพิ่มวันที่ 27/02/2568
						,dbo.sysconname(vnmed.DOSETYPE,20031,4) as 'DoseType'
						,dbo.sysconname(vnmed.DOSECODE,20032,4) as 'DoseCode'
						,dbo.sysconname(vnmed.DOSEQTYCODE,20033,4) as 'DoseQTY'
						,dbo.sysconname(vnmed.DOSEUNITCODE,20034,4) as 'DoseUnit'
						,'' as 'DoseFreqCode'
						,dbo.sysconname(vnmed.AUXLABEL1,20030,4) as 'AuxLabel1'
						,dbo.sysconname(vnmed.AUXLABEL2,20030,4) as 'AuxLabel2'
						,dbo.sysconname(vnmed.AUXLABEL3,20030,4) as 'AuxLabel3'
						,'' as 'EntryByFacilityMethodCode'
						,'' as 'EntryByFacilityMethodNameTH' --แก้ไขวันที่ 27/02/2568
						,'' as 'EntryByFacilityMethodNameEN' --เพิ่มวันที่ 27/02/2568
						,'' as 'Checkup'
						,vnmed.DOSEMEMO as 'DoseMemo'
						,0 as 'FlagDF' --เพิ่มวันที่ 17/02/2568
						,CAST(SUBSTRING(act.COM,91,3)as varchar) as 'ActivityCategoryCode' --เพิ่มวันที่ 27/02/2568
						,dbo.sysconname(CAST(SUBSTRING(act.COM,91,3)as varchar),10051,2) as 'ActivityCategoryNameTH' --เพิ่มวันที่ 27/02/2568
						,dbo.sysconname(CAST(SUBSTRING(act.COM,91,3)as varchar),10051,1) as 'ActivityCategoryNameEN' --เพิ่มวันที่ 27/02/2568
						from VNMEDICINE vnmed
						left join VNPRES vnp on vnmed.VN=vnp.VN and vnmed.VISITDATE=vnp.VISITDATE and vnmed.SUFFIX=vnp.SUFFIX
						left join VNMST vnm on vnp.VN=vnm.VN and vnp.VISITDATE=vnm.VISITDATE
						left join SSBSTOCK.dbo.STOCK_MASTER stm on vnmed.STOCKCODE=stm.STOCKCODE
						left join SYSCONFIG act on vnmed.CHARGECODE=act.CODE and act.CTRLCODE = 20023
		) 
		union all
		(
			select  
						CONVERT(varchar,l.CHARGETOVISITDATE,112)+CONVERT(varchar,l.CHARGETOVN)+CONVERT(varchar,l.ENTRYDATETIME,112)+CONVERT(varchar,vnt.SUBSUFFIX) as 'OrderID'
						,vnm.HN as 'PatientID'
						,CONVERT(varchar,vnp.VISITDATE,112)+CONVERT(varchar,vnp.VN)+CONVERT(varchar,vnp.SUFFIX) as 'VisitID'
						,vnt.VISITDATE as 'VisitDate'
						,vnt.VN
						,vnt.SUFFIX as 'PrescriptionNo'
						,l.ENTRYDATETIME as 'MakeDateTime'
						,'Lab' as 'ItemType'
						,lr.LABCODE as 'ItemCode'
						,dbo.sysconname(lr.LABCODE,20067,2) as 'ItemNameTH' --แก้ไขวันที่ 27/02/2568
						,dbo.sysconname(lr.LABCODE,20067,1) as 'ItemNameEN' --เพิ่มวันที่ 27/02/2568
						,lr.CHARGECODE as 'ActivityCode'
						,dbo.sysconname(lr.CHARGECODE,20023,2) as 'ActivityNameTH' --แก้ไขวันที่ 27/02/2568
						,dbo.sysconname(lr.CHARGECODE,20023,1) as 'ActivityNameEN' --เพิ่มวันที่ 27/02/2568
						,'' as 'UnitCode'
						,'' as 'UnitNameTH' --แก้ไขวันที่ 27/02/2568
						,'' as 'UnitNameEN' --เพิ่มวันที่ 27/02/2568
						,lr.QTY as 'QTY'
						,lr.AMT as 'UnitPrice'
						,lr.AMT as 'ChargeAmt'
						,case when lr.TYPEOFCHARGE = 0 then 'Charge'
							  when lr.TYPEOFCHARGE = 1 then 'Free'
							  when lr.TYPEOFCHARGE = 2 then 'Refund'
							  when lr.TYPEOFCHARGE = 3 then 'Cxl'
							  when lr.TYPEOFCHARGE = 4 then 'Usage FOC'
							  when lr.TYPEOFCHARGE = 5 then 'Never Charge'
							  when lr.TYPEOFCHARGE = 6 then 'Adjust'
							  when lr.TYPEOFCHARGE = 7 then 'Return Usage FOC' end as 'ChargeType'
						,l.CHARGEDATETIME as 'ChargeDateTime'
						,dbo.sysconname(lr.FACILITYRMSNO,20045,4) as 'EntryByFacility'
						,lr.REQUESTNO as 'RefNo'
						,lr.CXLBYUSERCODE as 'CancelByUserCode' --แก้ไขวันที่ 27/02/2568
						,dbo.sysconname(lr.CXLBYUSERCODE,10000,2) as 'CancelByUserNameTH' --เพิ่มวันที่ 27/02/2568
						,dbo.sysconname(lr.CXLBYUSERCODE,10000,1) as 'CancelByUserNameEN' --เพิ่มวันที่ 27/02/2568
						,lr.CXLDATETIME as 'CancelDateTime'
						,'' as 'TreatmentDateTimeFrom'
						,'' as 'TreatmentDateTimeTo'
						,'' as 'DFDoctor'
						,l.RIGHTCODE as 'RightCode'
						,dbo.sysconname(l.RIGHTCODE,20019,2) as 'RightNameTH' --แก้ไขวันที่ 27/02/2568
						,dbo.sysconname(l.RIGHTCODE,20019,1) as 'RightNameEN' --เพิ่มวันที่ 27/02/2568
						,'' as 'StoreCode'
						,'' as 'StoreNameTH' --แก้ไขวันที่ 27/02/2568
						,'' as 'StoreNameEN' --เพิ่มวันที่ 27/02/2568
						,'' as 'DoseType'
						,'' as 'DoseCode'
						,'' as 'DoseQTY'
						,'' as 'DoseUnit'
						,'' as 'DoseFreqCode'
						,'' as 'AuxLabel1'
						,'' as 'AuxLabel2'
						,'' as 'AuxLabel3'
						,'' as 'EntryByFacilityMethodCode'
						,'' as 'EntryByFacilityMethodNameTH' --แก้ไขวันที่ 27/02/2568
						,'' as 'EntryByFacilityMethodNameEN' --เพิ่มวันที่ 27/02/2568
						,'' as 'Checkup'
						,'' as 'DoseMemo'
						,0 as 'FlagDF' --เพิ่มวันที่ 17/02/2568
						,CAST(SUBSTRING(act.COM,91,3)as varchar) as 'ActivityCategoryCode' --เพิ่มวันที่ 27/02/2568
						,dbo.sysconname(CAST(SUBSTRING(act.COM,91,3)as varchar),10051,2) as 'ActivityCategoryNameTH' --เพิ่มวันที่ 27/02/2568
						,dbo.sysconname(CAST(SUBSTRING(act.COM,91,3)as varchar),10051,1) as 'ActivityCategoryNameEN' --เพิ่มวันที่ 27/02/2568
						from LABREQ l
						left join LABRESULT lr on l.REQUESTNO=lr.REQUESTNO and l.FACILITYRMSNO=lr.FACILITYRMSNO
						left join VNTREAT vnt on l.CHARGETOVN=vnt.VN and l.CHARGETOVISITDATE=vnt.VISITDATE and l.FACILITYRMSNO=vnt.FACILITYRMS and l.REQUESTNO=vnt.FACILITYREF and vnt.FACILITYSYSTEM = 9
						left join VNPRES vnp on vnt.VN=vnp.VN and vnt.VISITDATE=vnp.VISITDATE and vnt.SUFFIX=vnp.SUFFIX
						left join VNMST vnm on vnp.VN=vnm.VN and vnp.VISITDATE=vnm.VISITDATE
						left join SYSCONFIG act on lr.CHARGECODE=act.CODE and act.CTRLCODE = 20023
						
		) 
		union all
		(
				select 
						CONVERT(varchar,x.CHARGETOVISITDATE,112)+CONVERT(varchar,x.CHARGETOVN)+CONVERT(varchar,x.ENTRYDATETIME,112)+CONVERT(varchar,vnt.SUBSUFFIX) as 'OrderID'
						,vnm.HN as 'PatientID'
						,CONVERT(varchar,vnp.VISITDATE,112)+CONVERT(varchar,vnp.VN)+CONVERT(varchar,vnp.SUFFIX) as 'VisitID'
						,vnt.VISITDATE as 'VisitDate'
						,vnt.VN
						,vnt.SUFFIX as 'PrescriptionNo'
						,x.ENTRYDATETIME as 'MakeDateTime'
						,'Xray' as 'ItemType'
						,xr.XRAYCODE as 'ItemCode'
						,dbo.sysconname(xr.XRAYCODE,20073,2) as 'ItemNameTH' --แก้ไขวันที่ 27/02/2568
						,dbo.sysconname(xr.XRAYCODE,20073,1) as 'ItemNameEN' --เพิ่มวันที่ 27/02/2568
						,xr.CHARGECODE as 'ActivityCode'
						,dbo.sysconname(xr.CHARGECODE,20023,2) as 'ActivityNameTH' --แก้ไขวันที่ 27/02/2568
						,dbo.sysconname(xr.CHARGECODE,20023,1) as 'ActivityNameEN' --เพิ่มวันที่ 27/02/2568
						,'' as 'UnitCode'
						,'' as 'UnitNameTH' --แก้ไขวันที่ 27/02/2568
						,'' as 'UnitNameEN' --เพิ่มวันที่ 27/02/2568
						,'1' as 'QTY'
						,xr.AMT as 'UnitPrice'
						,xr.AMT as 'ChargeAmt'
						,case when xr.TYPEOFCHARGE = 0 then 'Charge'
							  when xr.TYPEOFCHARGE = 1 then 'Free'
							  when xr.TYPEOFCHARGE = 2 then 'Refund'
							  when xr.TYPEOFCHARGE = 3 then 'Cxl'
							  when xr.TYPEOFCHARGE = 4 then 'Usage FOC'
							  when xr.TYPEOFCHARGE = 5 then 'Never Charge'
							  when xr.TYPEOFCHARGE = 6 then 'Adjust'
							  when xr.TYPEOFCHARGE = 7 then 'Return Usage FOC' end as 'ChargeType'
						,x.CHARGEDATETIME as 'ChargeDateTime'
						,dbo.sysconname(xr.FACILITYRMSNO,20045,4) as 'EntryByFacility'
						,xr.REQUESTNO as 'RefNo'
						,xr.CXLBYUSERCODE as 'CancelByUserCode' --แก้ไขวันที่ 27/02/2568
						,dbo.sysconname(xr.CXLBYUSERCODE,10000,2) as 'CancelByUserNameTH' --เพิ่มวันที่ 27/02/2568
						,dbo.sysconname(xr.CXLBYUSERCODE,10000,1) as 'CancelByUserNameEN' --เพิ่มวันที่ 27/02/2568
						,xr.CXLDATETIME as 'CancelDateTime'
						,'' as 'TreatmentDateTimeFrom'
						,'' as 'TreatmentDateTimeTo'
						,'' as 'DFDoctor'
						,x.RIGHTCODE as 'RightCode'
						,dbo.sysconname(x.RIGHTCODE,20019,2) as 'RightNameTH' --แก้ไขวันที่ 27/02/2568
						,dbo.sysconname(x.RIGHTCODE,20019,1) as 'RightNameEN' --เพิ่มวันที่ 27/02/2568
						,'' as 'StoreCode'
						,'' as 'StoreNameTH' --แก้ไขวันที่ 27/02/2568
						,'' as 'StoreNameEN' --เพิ่มวันที่ 27/02/2568
						,'' as 'DoseType'
						,'' as 'DoseCode'
						,'' as 'DoseQTY'
						,'' as 'DoseUnit'
						,'' as 'DoseFreqCode'
						,'' as 'AuxLabel1'
						,'' as 'AuxLabel2'
						,'' as 'AuxLabel3'
						,'' as 'EntryByFacilityMethodCode'
						,'' as 'EntryByFacilityMethodNameTH' --แก้ไขวันที่ 27/02/2568
						,'' as 'EntryByFacilityMethodNameEN' --เพิ่มวันที่ 27/02/2568
						,'' as 'Checkup'
						,'' as 'DoseMemo'
						,0 as 'FlagDF' --เพิ่มวันที่ 17/02/2568
						,CAST(SUBSTRING(act.COM,91,3)as varchar) as 'ActivityCategoryCode' --เพิ่มวันที่ 27/02/2568
						,dbo.sysconname(CAST(SUBSTRING(act.COM,91,3)as varchar),10051,2) as 'ActivityCategoryNameTH' --เพิ่มวันที่ 27/02/2568
						,dbo.sysconname(CAST(SUBSTRING(act.COM,91,3)as varchar),10051,1) as 'ActivityCategoryNameEN' --เพิ่มวันที่ 27/02/2568
						from XRAYREQ x
						left join XRAYRESULT xr on x.REQUESTNO=xr.REQUESTNO and x.FACILITYRMSNO=xr.FACILITYRMSNO
						left join VNTREAT vnt on x.CHARGETOVN=vnt.VN and x.CHARGETOVISITDATE=vnt.VISITDATE and x.FACILITYRMSNO=vnt.FACILITYRMS and x.REQUESTNO=vnt.FACILITYREF and vnt.FACILITYSYSTEM = 8
						left join VNPRES vnp on vnt.VN=vnp.VN and vnt.VISITDATE=vnp.VISITDATE and vnt.SUFFIX=vnp.SUFFIX
						left join VNMST vnm on vnp.VN=vnm.VN and vnp.VISITDATE=vnm.VISITDATE
						left join SYSCONFIG act on xr.CHARGECODE=act.CODE and act.CTRLCODE = 20023
		)
		union all
		(
						select  
						CONVERT(varchar,vnt.VISITDATE,112)+CONVERT(varchar,vnt.VN)+CONVERT(varchar,vnt.MAKEDATETIME,112)+CONVERT(varchar,vnt.SUBSUFFIX) as 'OrderID'
						,vnm.HN as 'PatientID'
						,CONVERT(varchar,vnp.VISITDATE,112)+CONVERT(varchar,vnp.VN)+CONVERT(varchar,vnp.SUFFIX) as 'VisitID'
						,vnt.VISITDATE as 'VisitDate'
						,vnt.VN
						,vnt.SUFFIX as 'PrescriptionNo'
						,vnt.MAKEDATETIME as 'MakeDateTime'
						,case when o1.TREATMENTCODE is not null then 'Treatment' else 'Usage' end as 'ItemType'
						,case when o1.TREATMENTCODE is not null then o1.TREATMENTCODE else o2.STOCKCODE end as 'ItemCode'
						,case when o1.TREATMENTCODE is not null then dbo.sysconname(o1.TREATMENTCODE,20051,2) else dbo.StockName(o2.STOCKCODE,2) end as 'ItemNameTH' --แก้ไขวันที่ 27/02/2568
						,case when o1.TREATMENTCODE is not null then dbo.sysconname(o1.TREATMENTCODE,20051,1) else dbo.StockName(o2.STOCKCODE,1) end as 'ItemNameEN' --เพิ่มวันที่ 27/02/2568
						,case when o1.TREATMENTCODE is not null then o1.CHARGECODE else o2.CHARGECODE end as 'ActivityCode'
						,case when o1.TREATMENTCODE is not null then dbo.sysconname(o1.CHARGECODE,20023,2) else dbo.sysconname(o2.CHARGECODE,20023,2) end as 'ActivityNameTH' --แก้ไขวันที่ 27/02/2568
						,case when o1.TREATMENTCODE is not null then dbo.sysconname(o1.CHARGECODE,20023,1) else dbo.sysconname(o2.CHARGECODE,20023,1) end as 'ActivityNameEN' --เพิ่มวันที่ 27/02/2568
						,o2.UNITCODE as 'UnitCode'
						,'' as 'UnitNameTH' --แก้ไขวันที่ 27/02/2568
						,'' as 'UnitNameEN' --เพิ่มวันที่ 27/02/2568
						,o2.QTY as 'QTY'
						,COALESCE(o1.AMT , o2.amt) as 'UnitPrice'
						,COALESCE(o1.AMT , o2.amt) as 'ChargeAmt'
						,case when o1.TYPEOFCHARGE = 0 then 'Charge'
							  when o1.TYPEOFCHARGE = 1 then 'Free'
							  when o1.TYPEOFCHARGE = 2 then 'Refund'
							  when o1.TYPEOFCHARGE = 3 then 'Cxl'
							  when o1.TYPEOFCHARGE = 4 then 'Usage FOC'
							  when o1.TYPEOFCHARGE = 5 then 'Never Charge'
							  when o1.TYPEOFCHARGE = 6 then 'Adjust'
							  when o1.TYPEOFCHARGE = 7 then 'Return Usage FOC' end as 'ChargeType'
						,o1.IPDCHARGEMAKEDATETIME as 'ChargeDateTime'
						,dbo.sysconname(vnt.FACILITYRMS,20045,4) as 'EntryByFacility'
						,vnt.FACILITYREF as 'RefNo'
						,vnt.CXLBYUSERCODE as 'CancelByUserCode' --แก้ไขวันที่ 27/02/2568 
						,dbo.sysconname(vnt.CXLBYUSERCODE,10000,2) as 'CancelByUserNameTH' --เพิ่มวันที่ 27/02/2568
						,dbo.sysconname(vnt.CXLBYUSERCODE,10000,1) as 'CancelByUserNameEN' --เพิ่มวันที่ 27/02/2568
						,vnt.CXLDATETIME as 'CancelDateTime'
						,'' as 'TreatmentDateTimeFrom'
						,'' as 'TreatmentDateTimeTo'
						,'' as 'DFDoctor'
						,vnt.RIGHTCODE as 'RightCode'
						,dbo.sysconname(vnt.RIGHTCODE,20019,2) as 'RightNameTH' --แก้ไขวันที่ 27/02/2568 
						,dbo.sysconname(vnt.RIGHTCODE,20019,1) as 'RightNameEN' --เพิ่มวันที่ 27/02/2568
						,o2.STORE as 'StoreCode'
						,dbo.sysconname(o2.STORE,40010,2) as 'StoreNameTH' --แก้ไขวันที่ 27/02/2568 
						,dbo.sysconname(o2.STORE,40010,1) as 'StoreNameEN' --เพิ่มวันที่ 27/02/2568
						,'' as 'DoseType'
						,'' as 'DoseCode'
						,'' as 'DoseQTY'
						,'' as 'DoseUnit'
						,'' as 'DoseFreqCode'
						,'' as 'AuxLabel1'
						,'' as 'AuxLabel2'
						,'' as 'AuxLabel3'
						,'' as 'EntryByFacilityMethodCode'
						,'' as 'EntryByFacilityMethodNameTH' --แก้ไขวันที่ 27/02/2568 
						,'' as 'EntryByFacilityMethodNameEN' --เพิ่มวันที่ 27/02/2568
						,'' as 'Checkup'
						,'' as 'DoseMemo'
						,0 as 'FlagDF' --เพิ่มวันที่ 17/02/2568
						,CAST(SUBSTRING(act.COM,91,3)as varchar) as 'ActivityCategoryCode' --เพิ่มวันที่ 27/02/2568
						,dbo.sysconname(CAST(SUBSTRING(act.COM,91,3)as varchar),10051,2) as 'ActivityCategoryNameTH' --เพิ่มวันที่ 27/02/2568
						,dbo.sysconname(CAST(SUBSTRING(act.COM,91,3)as varchar),10051,1) as 'ActivityCategoryNameEN' --เพิ่มวันที่ 27/02/2568
			from  VNTREAT vnt 
			left join ORCHARGE o1 on vnt.FACILITYREF=o1.REQUESTNO and vnt.FACILITYRMS=o1.FACILITYRMSNO and vnt.MAKEDATETIME=o1.IPDCHARGEMAKEDATETIME and vnt.CHARGECODE=o1.CHARGECODE
			LEFT join ORUSAGE o2 on o1.FACILITYRMSNO = o2.FACILITYRMSNO and o1.REQUESTNO = o2.REQUESTNO and /*o1.MAKEDATETIME = o2.CHARGEDATETIME*/ vnt.CHARGEVOUCHERNO=o2.CHARGEVOUCHERNO and o1.CHARGECODE = o2.CHARGECODE
			left join VNPRES vnp on vnt.VN=vnp.VN and vnt.VISITDATE=vnp.VISITDATE and vnt.SUFFIX=vnp.SUFFIX
			left join VNMST vnm on vnp.VN=vnm.VN and vnp.VISITDATE=vnm.VISITDATE
			left join SYSCONFIG act on vnt.CHARGECODE=act.CODE and act.CTRLCODE = 20023
			where vnt.FACILITYSYSTEM = 4
		)
		union all
		( ---------------------------PT-----------------------------------------
				select  
						CONVERT(varchar,vnt.VISITDATE,112)+CONVERT(varchar,vnt.VN)+CONVERT(varchar,vnt.MAKEDATETIME,112)+CONVERT(varchar,vnt.SUBSUFFIX) as 'OrderID'
						,vnm.HN as 'PatientID'
						,CONVERT(varchar,vnp.VISITDATE,112)+CONVERT(varchar,vnp.VN)+CONVERT(varchar,vnp.SUFFIX) as 'VisitID'
						,vnt.VISITDATE as 'VisitDate'
						,vnt.VN
						,vnt.SUFFIX as 'PrescriptionNo'
						,vnt.MAKEDATETIME as 'MakeDateTime'
						,'PT' as 'ItemType'
						,pt.PTMODE  as 'ItemCode'
						,dbo.sysconname(pt.PTMODE,20104,2) as 'ItemNameTH' 
						,dbo.sysconname(pt.PTMODE,20104,1) as 'ItemNameEN' 
						,pt.CHARGECODE as 'ActivityCode'
						,dbo.sysconname(pt.CHARGECODE,20023,2) as 'ActivityNameTH' 
						,dbo.sysconname(pt.CHARGECODE,20023,1) as 'ActivityNameEN' 
						,'' as 'UnitCode'
						,'' as 'UnitNameTH' 
						,'' as 'UnitNameEN' 
						,'' as 'QTY'
						,'' as 'UnitPrice'
						,pt.AMT as 'ChargeAmt'
						,case when pt.TYPEOFCHARGE = 0 then 'Charge'
							  when pt.TYPEOFCHARGE = 1 then 'Free'
							  when pt.TYPEOFCHARGE = 2 then 'Refund'
							  when pt.TYPEOFCHARGE = 3 then 'Cxl'
							  when pt.TYPEOFCHARGE = 4 then 'Usage FOC'
							  when pt.TYPEOFCHARGE = 5 then 'Never Charge'
							  when pt.TYPEOFCHARGE = 6 then 'Adjust'
							  when pt.TYPEOFCHARGE = 7 then 'Return Usage FOC' end as 'ChargeType'
						,vnt.MAKEDATETIME as 'ChargeDateTime'
						,dbo.sysconname(vnt.FACILITYRMS,20045,4) as 'EntryByFacility'
						,vnt.FACILITYREF as 'RefNo'
						,vnt.CXLBYUSERCODE as 'CancelByUserCode' 
						,dbo.sysconname(vnt.CXLBYUSERCODE,10000,2) as 'CancelByUserNameTH' 
						,dbo.sysconname(vnt.CXLBYUSERCODE,10000,1) as 'CancelByUserNameEN' 
						,vnt.CXLDATETIME as 'CancelDateTime'
						,'' as 'TreatmentDateTimeFrom'
						,'' as 'TreatmentDateTimeTo'
						,'' as 'DFDoctor'
						,vnt.RIGHTCODE as 'RightCode'
						,dbo.sysconname(vnt.RIGHTCODE,20019,2) as 'RightNameTH' 
						,dbo.sysconname(vnt.RIGHTCODE,20019,1) as 'RightNameEN' 
						,'' as 'StoreCode'
						,'' as 'StoreNameTH' 
						,'' as 'StoreNameEN' 
						,'' as 'DoseType'
						,'' as 'DoseCode'
						,'' as 'DoseQTY'
						,'' as 'DoseUnit'
						,'' as 'DoseFreqCode'
						,'' as 'AuxLabel1'
						,'' as 'AuxLabel2'
						,'' as 'AuxLabel3'
						,'' as 'EntryByFacilityMethodCode'
						,'' as 'EntryByFacilityMethodNameTH' 
						,'' as 'EntryByFacilityMethodNameEN' 
						,'' as 'Checkup'
						,'' as 'DoseMemo'
						,0 as 'FlagDF' 
						,CAST(SUBSTRING(act.COM,91,3)as varchar) as 'ActivityCategoryCode' 
						,dbo.sysconname(CAST(SUBSTRING(act.COM,91,3)as varchar),10051,2) as 'ActivityCategoryNameTH' 
						,dbo.sysconname(CAST(SUBSTRING(act.COM,91,3)as varchar),10051,1) as 'ActivityCategoryNameEN' 
						from VNTREAT vnt
						left join PTPAYMENT pt on vnt.VN=pt.VN and vnt.VISITDATE=pt.VISITDATE and vnt.FACILITYREF=pt.REQUESTNO and vnt.CHARGECODE=pt.CHARGECODE
						left join VNPRES vnp on vnt.VN=vnp.VN and vnt.VISITDATE=vnp.VISITDATE and vnt.SUFFIX=vnp.SUFFIX
						left join VNMST vnm on vnp.VN=vnm.VN and vnp.VISITDATE=vnm.VISITDATE
						left join SYSCONFIG sc on vnt.TREATMENTCODE=sc.CODE and sc.CTRLCODE = 20051
						left join SYSCONFIG act on vnt.CHARGECODE=act.CODE and act.CTRLCODE = 20023
						where vnt.FACILITYSYSTEM = 6
		)  
		) datamst