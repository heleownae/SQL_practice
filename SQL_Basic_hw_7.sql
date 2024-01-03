-- 제출한 답
select o.State, o.order_id, sum(d.Amount) "총 금액", sum(d.Profit) "총 이익",
       RANK() OVER(PARTITION BY o.State ORDER BY SUM(d.Amount) DESC) "매출 순위",
       if(sum(d.Amount)>=0.5*avg(st.Target), 'O', 'X') "매출 목표 50% 달성 여부"
from list_of_orders o
     join order_details d on o.order_id=d.order_id
     join sales_target st on d.Category=st.Category
group by 1, 2;

-- 해설
세 테이블을 join하고, sum을 이용하여 총 금액과 총 이익을, rank()를 이용하여 매출 순위를 도출한다.
만약 매출이 평균 목표매출(avg(St.Target))의 50% 이상이면 'O'를, 아니면 'X'를 기재하여 달성 여부를 표현한다.
group by를 이용하여 주별, 주문id별 그룹화한다.

-- 튜터님 쿼리  >> 서브쿼리로 빼야 하는 이유를 모르겠음 ㅠㅠ 
WITH Average_Targets AS (
    SELECT 
        Category, 
        AVG(Target) AS Avg_Target
    FROM 
        sales_target
    GROUP BY 
        Category
)
SELECT 
    lo.order_id, 
    lo.State, 
    SUM(od.Amount) AS Total_Amount, 
    SUM(od.Profit) AS Total_Profit,
    RANK() OVER (PARTITION BY lo.State ORDER BY SUM(od.Amount) DESC) AS State_Rank,
    CASE 
        WHEN SUM(od.Amount) >= at.Avg_Target / 2 THEN 'Met 50% Target'
        ELSE 'Below 50% Target'
    END AS Target_Comparison
FROM 
    list_of_orders AS lo
JOIN 
    order_details AS od ON lo.order_id = od.order_id
JOIN 
    Average_Targets AS at ON od.Category = at.Category
GROUP BY 
    lo.order_id, lo.State, at.Avg_Target;