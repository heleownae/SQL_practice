-- 오랜 기간 보호한 동물(1)
select
    a.name, a.datetime
from
    animal_ins a
left join
    animal_outs b
on
    a.animal_id=b.animal_id 
where
    b.animal_id is null
order by
    datetime asc limit 3