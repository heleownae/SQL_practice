#RAW
select *
from order_details;

#윈도우 함수
SELECT order_id,
    Category,
    Amount,
    RANK() OVER (PARTITION BY Category ORDER BY Amount DESC) "총 매출 순위",
    SUM(Amount) OVER (PARTITION BY Category ORDER BY order_id) "카테고리 별 누적 매출"
FROM order_details
order by 4;

rank()를 사용한 매출 순위, sum()을 활용한 누적 매출 구하기. 윈도우함수.

#윈도우 함수
SELECT order_id,
    Category,
    Amount,
    RANK() OVER (PARTITION BY Category ORDER BY Amount DESC) "총 매출 순위",
    SUM(Amount) OVER (PARTITION BY Category ORDER BY Amount DESC) "카테고리 별 누적 매출"
FROM order_details
order by 4;