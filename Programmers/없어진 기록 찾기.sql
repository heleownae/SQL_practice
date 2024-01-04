-- 없어진 기록 찾기
select
    a.animal_id, a.name
from
    animal_outs a join animal_ins b on a.animal_id=b.animal_id
where
    b.animal_id is null 
