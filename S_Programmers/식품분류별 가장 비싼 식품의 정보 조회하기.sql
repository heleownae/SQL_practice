-- 식품분류별 가장 비싼 식품의 정보 조회하기
SELECT category, price, product_name
FROM food_product
WHERE price IN (SELECT max(price) FROM food_product GROUP BY category)
      AND category IN ('과자', '국', '김치', '식용유')
GROUP BY category
ORDER BY price DESC