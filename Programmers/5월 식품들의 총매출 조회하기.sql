-- 5월 식품들의 총매출 조회하기
SELECT a.product_id, a.product_name, sum(a.price*b.amount) total
FROM food_product a left join food_order b on a.product_id=b.product_id
WHERE b.produce_date LIKE '2022-05-%'
GROUP BY a.product_id
ORDER BY total desc, a.product_id asc