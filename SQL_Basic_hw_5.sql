#where
select order_id, Category, Quantity
from order_details 
where Quantity > (
    select avg(Quantity)
    from order_details a
    where a.category=order_details.category
    group by category
    );

-- 해설
수량(Quantity)이 평균주문수량(avg(Quantity))을 초과한다는 조건을 where절에서 필터링
 
#self join
select a.order_id, a.Category, a.Quantity
from order_details a
join
    (
    select Category, avg(Quantity) avgq
    from order_details 
    group by 1
    ) b
on a.Category=b.Category
where a.Quantity > b.avgq;

-- 해설
테이블은 하나지만, from문에서 self join하고 where절에서 조건 필터링