select o.CustomerName "고객명",
       count(distinct o.order_id) "총 주문수",
       sum(d.Amount) "총 금액",
       datediff(mm.max_date, mm.min_date) / count(distinct o.order_id) "주문 간 평균 일수",
       case when datediff(mm.max_date, mm.min_date) / count(distinct o.order_id) = 0 then sum(d.Amount) * count(distinct o.order_id) * 1
            else sum(d.Amount) * count(distinct o.order_id) * datediff(mm.max_date, mm.min_date) / count(distinct o.order_id) end CLV
from list_of_orders o
     join order_details d on o.order_id=d.order_id
     join (select CustomerName,
                  max(str_to_date(order_date, '%d-%m-%Y')) max_date,
                  min(str_to_date(order_date, '%d-%m-%Y')) min_date
           from list_of_orders 
           group by 1) mm on o.CustomerName=mm.CustomerName
group by 1

-- 해설
두 테이블을 조인하고, loo 테이블의 고객명, 최대날짜, 최소날짜를 구하여 한 번 더 self join한다.
고객명, 총 주문수, 총 금액, 주문 간 평균 일수, CLV를 구한다.
이때 주문 간 평균 일수는 최대날짜와 최소날짜의 차이를 주문 수로 나누는 방식.
CLV는 주문 간 평균 일수가 0일인 경우, 즉 최대날짜와 최소날짜가 동일한 경우 1로 대체하여 계산한다.

-- 튜터님 쿼리
WITH Customer_Order_Details AS (
    SELECT 
        lo.CustomerName, 
        STR_TO_DATE(lo.order_date, '%d-%m-%Y') AS order_date,
        od.Amount,
        ROW_NUMBER() OVER (PARTITION BY lo.CustomerName ORDER BY lo.order_date) AS rn
    FROM 
        list_of_orders AS lo
    JOIN 
        order_details AS od ON lo.order_id = od.order_id
),
Order_Intervals AS (
    SELECT 
        CustomerName, 
        DATEDIFF(order_date, LAG(order_date) OVER (PARTITION BY CustomerName ORDER BY order_date)) AS days_between_orders
    FROM 
        Customer_Order_Details
    WHERE 
        rn > 1
),
Customer_Stats AS (
    SELECT 
        cod.CustomerName, 
        SUM(cod.Amount) AS Total_Amount, 
        COUNT(DISTINCT cod.order_date) AS Total_Orders,
        AVG(oi.days_between_orders) AS Avg_Days_Between_Orders
    FROM 
        Customer_Order_Details AS cod
    LEFT JOIN 
        Order_Intervals AS oi ON cod.CustomerName = oi.CustomerName
    GROUP BY 
        cod.CustomerName
)

SELECT 
    cs.CustomerName,
    cs.Total_Amount,
    cs.Total_Orders,
    cs.Avg_Days_Between_Orders,
    cs.Total_Amount / cs.Total_Orders AS Avg_Order_Value,
    cs.Total_Orders / NULLIF(cs.Avg_Days_Between_Orders, 0) AS Purchase_Frequency,
    (cs.Total_Amount / cs.Total_Orders) * (cs.Total_Orders / NULLIF(cs.Avg_Days_Between_Orders, 0)) * 1 AS Estimated_CLV -- 1년 기준 CLV
FROM 
    Customer_Stats AS cs;