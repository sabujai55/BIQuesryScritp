CREATE OR REPLACE FUNCTION public.his_func_string_to_date(date_text character varying)
 RETURNS character varying
 LANGUAGE plpgsql
AS $function$
DECLARE
  y_big bigint;
  m_int int;
  d_int int;
  max_day int;
  is_leap boolean;
BEGIN
  -- 1) เช็ครูปแบบคร่าว ๆ ก่อน
  IF date_text IS NULL OR date_text !~ '^\d{1,7}-\d{2}-\d{2}$' THEN
    RETURN NULL;
  END IF;

  -- 2) แยกส่วนประกอบ
  y_big := split_part(date_text, '-', 1)::bigint;
  m_int := split_part(date_text, '-', 2)::int;
  d_int := split_part(date_text, '-', 3)::int;

  -- 3) ช่วงปีที่ชนิด DATE รองรับ (4713 BC ถึง 5874897 AD)
  IF y_big < -4713 OR y_big > 5874897 THEN
    RETURN NULL;
  END IF;

  -- 4) ตรวจเดือน
  IF m_int < 1 OR m_int > 12 THEN
    RETURN NULL;
  END IF;

  -- 5) คำนวณ leap year
  is_leap := (y_big % 400 = 0) OR (y_big % 4 = 0 AND y_big % 100 <> 0);

  -- 6) วันสูงสุดของเดือน
  IF m_int IN (1,3,5,7,8,10,12) THEN
    max_day := 31;
  ELSIF m_int IN (4,6,9,11) THEN
    max_day := 30;
  ELSIF m_int = 2 THEN
    max_day := CASE WHEN is_leap THEN 29 ELSE 28 END;
  ELSE
    RETURN NULL;
  END IF;

  -- 7) ตรวจวัน
  IF d_int < 1 OR d_int > max_day THEN
    RETURN NULL;
  END IF;

  -- 8) แปลงเป็น date (safe เพราะตรวจครบแล้ว)
  RETURN make_date(y_big::int, m_int, d_int);

EXCEPTION WHEN others THEN
  -- กันกรณีไม่คาดคิด ให้คืน NULL
  RETURN NULL;
END;
$function$
;

