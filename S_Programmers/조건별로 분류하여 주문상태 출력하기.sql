-- 조건별로 분류하여 주문상태 출력하기
SELECT order_id, product_id, date_format(out_date, '%Y-%m-%d'),
       CASE WHEN out_date is null THEN "출고미정" 
            WHEN out_date <= '2022-05-01' THEN "출고완료"
            ELSE "출고대기" END "출고여부"
FROM food_order
ORDER BY order_id asc