-- 우유와 요거트가 담긴 장바구니
select
    CART_ID
from
    CART_PRODUCTS
where
    NAME in ('Milk', 'Yogurt')
group by
    1
having
    COUNT(DISTINCT NAME) > 1
order by
    1