# Задание 1  
use myfirstdb;
drop table sales;
create table sales(
	ID int primary key auto_increment not null,
    brand varchar(20) not null,
    model varchar(20) unique not null,
    count int not null
);

insert into sales(brand, model, count)
values
('iPhone', 'XR', 28),
('Samsung', 's22', 584),
('Samsung', 'a52', 234),
('Xiaomi', '9', 84),
('Xiaomi', '10', 555);

select * from sales; 

# Задание 2
select brand, SUM(count) as sum
from sales
group by brand
having sum < 100;

select brand, SUM(count) as sum
from sales
group by brand
having sum between 100 and 300;

select brand, SUM(count) as sum
from sales
group by brand
having sum > 300;

# Задание 3
drop table orders;

create table orders(
id INT not null primary key auto_increment,
namee varchar(20) not null,
statuss varchar(10) not null,
phone_number INT not null
);

insert into orders(namee, statuss, phone_number)
values
('phone', 'processed', 111222555),
('radio', 'sent', 444222555),
('player', 'received', 555333666)
;

select namee,
CASE
	when statuss = 'processed' then "Заказ в процессе"
    when statuss = 'sent' then "Заказ отправлен"
    when statuss = 'received' then "Заказ получен"
end
from orders;

/* 	Задание 4
    0 - конкретное значение
    null - отсутствие значения
    https://cs8.pikabu.ru/post_img/big/2017/03/30/9/1490885824144875824.jpg
*/


