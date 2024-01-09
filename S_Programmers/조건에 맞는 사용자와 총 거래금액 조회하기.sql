-- 조건에 맞는 사용자와 총 거래금액 조회하기
SELECT b.user_id,
       b.nickname,
       sum(a.price) "TOTAL_SALES"
FROM used_goods_board a left join used_goods_user b on a.writer_id=b.user_id
WHERE a.status='DONE'
GROUP BY 1
HAVING sum(a.price)>=700000
ORDER BY 3