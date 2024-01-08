-- 카테고리 별 도서 판매량 집계하기
SELECT a.category,
       sum(b.sales) "TOTAL_SALES"
FROM book a left join book_sales b on a.book_id=b.book_id
WHERE b.sales_date LIKE '%2022-01-%'
GROUP BY 1
ORDER BY 1 asc