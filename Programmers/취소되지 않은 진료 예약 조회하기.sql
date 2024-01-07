-- 취소되지 않은 진료 예약 조회하기
SELECT a.apnt_no, p.pt_name, p.pt_no, a.mcdp_cd, d.dr_name, a.apnt_ymd
FROM appointment a JOIN patient p ON a.pt_no=p.pt_no JOIN doctor d ON a.mddr_id=d.dr_id
WHERE a.apnt_ymd LIKE '2022-04-13%'
      AND a.apnt_cncl_yn='N'
      AND a.mcdp_cd='CS'
ORDER BY a.apnt_ymd ASC