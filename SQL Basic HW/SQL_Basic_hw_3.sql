#정답
SELECT b.CUSTOMERNAME, sum(a.AMOUNT)
FROM ORDER_DETAILS a join LIST_OF_ORDERS b on a.ORDER_ID=b.ORDER_ID
group by 1
order by 2 desc limit 5; 

#오답 - order id 로 정렬하면 왜 안 되는지 궁금하다
SELECT a.ORDER_ID, sum(a.AMOUNT)
FROM ORDER_DETAILS a join LIST_OF_ORDERS b on a.ORDER_ID=b.ORDER_ID
group by 1
order by 2 desc limit 5; 

#정답2 (오답 해결) - sql 표준 문법 상, group by 사용 시 select문에 집계함수 사용한 컬럼을 제외한 모든 컬럼을 다 기입해야 함
#mysql 설정 변경 - sql_mode에서 only_full_group_by 설정을 뺀다
SELECT a.ORDER_ID, b.CUSTOMERNAME, sum(a.AMOUNT)
FROM ORDER_DETAILS a join LIST_OF_ORDERS b on a.ORDER_ID=b.ORDER_ID
group by 1, 2
order by 3 desc limit 5;