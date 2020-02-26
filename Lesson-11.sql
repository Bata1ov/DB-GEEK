"Оптимизация запросов"

Task1
_________________________________________________________________________________________________________
USE shop

CREATE TABLE logs (
	id INT PRIMARY KEY AUTO_INCREMENT,
	created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	table_name VARCHAR(255) NOT NULL,
	prim_key TINYINT NOT NULL,
	name VARCHAR(255)
	) ENGINE=ARCHIVE;

CREATE TRIGGER products_insert AFTER INSERT ON products FOR EACH ROW
	INSERT INTO logs (table_name, prim_key, name) VALUES ('products', NEW.id, NEW.name);

CREATE TRIGGER users_insert AFTER INSERT ON users FOR EACH ROW
	INSERT INTO logs (table_name, prim_key, name) VALUES ('users', NEW.id, NEW.name);

CREATE TRIGGER catalogs_insert AFTER INSERT ON catalogs FOR EACH ROW
	INSERT INTO logs (table_name, prim_key, name) VALUES ('catalogs', NEW.id, NEW.name);

DESC users;

Task2
_________________________________________________________________________________________________________
В архиве есть уже таблица user, но решил создавать новую с функцией delimiter и engine , хотелось бы узнать правильна или нет реализация

delimiter ||
drop table if exists users||
create table users (
  id SERIAL PRIMARY KEY,
  name varchar(255) default null COMMENT 'Имя покупателя',
  birthday_at date default null COMMENT 'Дата рождения покупателя',
  created_at datetime default current_timestamp,
  updated_at datetime default current_timestamp on update current_timestamp,
) ENGINE=Archive COMMENT='Покупатели'||


drop procedure if exists add_num_rows||

create procedure add_num_rows(num int)
begin
	declare i int default 0;
	while i < num DO
		insert into users1 values (default, concat('user ', i),'1999-05-02',default, default);
		set i = i+1;
	end while;
end||

call add_num_rows(10000)||
select * from users|| 
select count(*) from users||
delimiter ;


_________________________________________________________________________________________________________
							"NoSQL"
Task1
_________________________________________________________________________________________________________
Для мелких задач,именно для данной задачи, можно воспользоваться
HSET ips "192.168.2.1" 0 #Задать количество посещений 
HGETALL ips # И получить полный список ip c посещениями
но я делал с помощью команды SDIFF
127.0.0.1:6379> sadd 192.168.2.1 4   # Присвоили количество посещений
127.0.0.1:6379> sdiff 192.168.2.1
"4" # И уже по интересующему нам ip выводим количество посещений


Task2
_________________________________________________________________________________________________________
поиск e-mail по имени пользователя:
127.0.0.1:6379> hmset users alex alex@mail.ru ivan ivan@mail.ru
OK
127.0.0.1:6379> hget users alex
"alex@mail.ru"
поиск имени пользователя по e-mail
127.0.0.1:6379> hmset emails alex@mail.ru alex ivan@mail.ru ivan alexandr@mail.ru alexandr Nastya@mail.ru Nastya
OK
127.0.0.1:6379> hget emails alexandr@mail.ru
"alexandr"


Task3
_________________________________________________________________________________________________________
use shop
db.shop.insert({catalog: 'Процессоры', products:[
				{id: 1, name: 'Intel Core i3-8100', description: '', price: 7890}]})
db.shop.update({catalog: 'Процессоры'}, {$push: 
 				{ products: {id: 2, name:'Intel Core i5-7400', description: '',price: 12700 } }})
db.shop.insert({catalog: 'Материнские платы', products:[
 				{id: 3, name: 'Intel Core i3-8100', description: '', price: 7890}]} )
db.shop.update({catalog: 'Материнские платы'}, {$set: 
				{ products:[{id: 3, name: 'Gigabyte H310M S2H', description: '', price: 4790}]}} )
db.shop.find()