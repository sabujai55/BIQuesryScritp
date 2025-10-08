select
'NewClinic'=(SELECT CASE WHEN CONVERT(VARCHAR(8),firstvisitdate,112)=CONVERT(VARCHAR(8),a.visitdate,112) 
									 OR firstvisitdate IS null 
								  THEN 'N' 
								  ELSE 'O'
							 END
					  FROM dbo.PATIENT_CLINIC
					  WHERE hn=b.hn and clinic=a.clinic)
FROM VNPRES a
LEFT JOIN VNMST b ON (a.vn=b.vn and a.visitdate=b.visitdate)	