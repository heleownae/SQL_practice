-- 오랜 기간 보호한 동물(2)
SELECT
    a.animal_id,
    a.name
FROM
    animal_outs a
inner join
    animal_ins b
on
    a.animal_id = b.animal_id
ORDER BY
    a.datetime - b.datetime desc limit 2