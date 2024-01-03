#try1
SELECT min(str_to_date(order_date, '%Y-%m-%d')) "가장 이른 주문 날짜"
FROM LIST_OF_ORDERS
WHERE str_to_date(order_date, '%Y-%m-%d') is not null

#try2
SELECT min(str_to_date(order_date, '%d-%m-%Y')) "가장 이른 주문 날짜"
FROM LIST_OF_ORDERS
WHERE str_to_date(order_date, '%Y-%m-%d') is not null

#차이점
Y-m-d / d-m-Y