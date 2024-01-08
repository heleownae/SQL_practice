-- 대여 횟수가 많은 자동차들의 월별 대여 횟수 구하기
SELECT MONTH(START_DATE) MONTH, CAR_ID, COUNT(CAR_ID) RECORDS
FROM CAR_RENTAL_COMPANY_RENTAL_HISTORY
WHERE CAR_ID IN (
    SELECT CAR_ID
    FROM CAR_RENTAL_COMPANY_RENTAL_HISTORY
    WHERE YEAR(START_DATE)=2022 AND MONTH(START_DATE) IN (8, 9, 10)
    GROUP BY CAR_ID
    HAVING COUNT(CAR_ID) >= 5
    )
    AND YEAR(START_DATE)=2022 AND MONTH(START_DATE) IN (8, 9, 10)
GROUP BY 1, 2
HAVING COUNT(CAR_ID) >= 1
ORDER BY 1 ASC, 2 DESC