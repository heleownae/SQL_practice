-- 저자 별 카테고리 별 매출액 집계하기
SELECT a.author_id, a.author_name, b.category, SUM(b.price * bs.sales) total_sales
FROM BOOK b JOIN AUTHOR a ON b.author_id=a.author_id JOIN book_sales bs ON b.book_id=bs.book_id
WHERE bs.sales_date LIKE '2022-01-%'
GROUP BY 1, 2, 3
ORDER BY 1 ASC, 3 DESC