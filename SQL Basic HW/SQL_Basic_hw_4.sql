#rawdata 확인
select *
from list_of_orders a join order_details b on a.order_id=b.order_id
order by a.CustomerName;

#내 코드
select a.CustomerName "이름",
    count(distinct a.order_id) "총 주문횟수",
    sum(b.Amount) "총 구매액"
from list_of_orders a join order_details b on a.order_id=b.order_id 
group by 1
having count(distinct a.order_id) >=3;

-- 해설
두 테이블을 join 하여 고객(CustomerName) 별 이름, 총 주문횟수, 총 구매액을 구한다.
총 주문횟수는 distinct로 중복값을 제거하여 order_id 기준으로 구한다.
having 문을 이용해 총 주문횟수가 3번 이상인 사람만 필터링한다.

#오답
select a.CustomerName "이름",
    count(a.CustomerName) "총 주문횟수",
    sum(b.Amount) "총 구매액"
from list_of_orders a join order_details b on a.order_id=b.order_id 
group by 1
having count(a.CustomerName) >=3
order by 1;


#승주님 코드 (복잡쓰)
SELECT loo.CustomerName,
       cnt_loo.cnt_of_order,
       SUM(od.Amount) AS sum_of_amount
FROM list_of_orders loo 
    JOIN order_details od ON loo.order_id=od.order_id
    JOIN (
        SELECT CustomerName,
               COUNT(*) cnt_of_order
        FROM list_of_orders
        GROUP BY 1
    ) cnt_loo ON loo.CustomerName = cnt_loo.CustomerName
WHERE cnt_loo.cnt_of_order >= 3
GROUP BY 1
order by cnt_loo.CustomerName 