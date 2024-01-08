-- 자동차 대여 기록에서 대여중 / 대여 가능 여부 구분하기
SELECT car_id,
       MAX(IF('2022-10-16' BETWEEN start_date AND end_date, "대여중", "대여 가능")) AVAILABILITY
FROM car_rental_company_rental_history
GROUP BY 1
ORDER BY 1 DESC