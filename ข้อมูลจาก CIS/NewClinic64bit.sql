select 'NewClinic'=CASE WHEN NewToHere=1 THEN 'N' ELSE 'O' END,* from HNOPD_PRESCRIP where year(visitdate) = '2025'



