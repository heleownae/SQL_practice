-- 조건에 맞는 사용자 정보 조회하기
SELECT b.user_id, 
       b.nickname,
       CONCAT(b.city, ' ', b.street_address1, ' ', b.street_address2) "전체주소",
       CONCAT(SUBSTR(b.tlno, 1, 3), '-', SUBSTR(b.tlno, 4, 4), '-', SUBSTR(b.tlno, 8, 4)) "전화번호" 
FROM used_goods_board a LEFT JOIN used_goods_user b ON a.writer_id=b.user_id
GROUP BY b.user_id
HAVING COUNT(b.user_id)>=3
ORDER BY b.user_id DESC