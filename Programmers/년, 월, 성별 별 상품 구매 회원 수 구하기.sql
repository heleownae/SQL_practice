-- 년, 월, 성별 별 상품 구매 회원 수 구하기
SELECT DATE_FORMAT(a.sales_date, '%Y') YEAR,
       DATE_FORMAT(a.sales_date, '%m') MONTH,  #1, 2, ..., 12 형식
       b.gender GENDER,
       COUNT(DISTINCT b.user_id) USERS
FROM online_sale a LEFT JOIN user_info b ON a.user_id=b.user_id
WHERE b.gender IS NOT NULL
GROUP BY 1, 2, 3
ORDER BY 1, 2, 3 ASC