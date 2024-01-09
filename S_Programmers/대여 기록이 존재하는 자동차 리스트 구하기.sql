-- 대여 기록이 존재하는 자동차 리스트 구하기
SELECT a.car_id
FROM car_rental_company_car a LEFT JOIN car_rental_company_rental_history b ON a.car_id=b.car_id 
WHERE a.car_type='세단' AND b.start_date LIKE '%-10-%'
GROUP BY 1
ORDER BY 1 desc