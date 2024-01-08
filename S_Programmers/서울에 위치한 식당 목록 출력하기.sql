-- 서울에 위치한 식당 목록 출력하기
SELECT a.rest_id, a.rest_name, a.food_type, a.favorites, a.address, 
       ROUND(AVG(b.review_score), 2) score
FROM rest_info a LEFT JOIN rest_review b ON a.rest_id=b.rest_id
WHERE a.address LIKE '서울%'
      AND b.review_score IS NOT NULL
GROUP BY a.rest_id
ORDER BY score DESC, a.favorites DESC