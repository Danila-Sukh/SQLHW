use home_work4;

-- Создайте представление, в которое попадет информация о пользователях (имя, фамилия, город и пол), которые не старше 20 лет.

CREATE OR REPLACE VIEW v_friends as
select firstname, lastname, hometown, gender from users, profiles
where users.id = profiles.user_id and id in (select user_id from profiles where birthday >= '2003-01-01');

select * from v_friends;

-- Найдите кол-во, отправленных сообщений каждым пользователем и выведите ранжированный список пользователь, указав указать имя 
-- и фамилию пользователя, количество отправленных сообщений и место в рейтинге (первое место у 
-- пользователя с максимальным количеством сообщений) . (используйте DENSE_RANK)

select firstname, lastname, counter, DENSE_RANK() over(order by counter desc) as my_rank
from 
(select u.firstname, lastname, count(m.from_user_id) as counter
from users u
left join messages as m 
on u.id = m.from_user_id
group by u.id) AS list
order by counter desc;

-- Выберите все сообщения, отсортируйте сообщения по возрастанию даты отправления (created_at) и найдите разницу дат 
-- отправления между соседними сообщениями, получившегося списка. (используйте LEAD или LAG)

select body, created_at,
TIMESTAMPDIFF(minute  , created_at ,lead(created_at, 1, 0) over w) as delta_date 
from messages m
window w as (order by created_at);




