Task1
_________________________________________________________________________________________________________
SELECT * FROM users 
WHERE id in (SELECT user_id FROM orders);


_________________________________________________________________________________________________________
Решение с использованием JOIN
¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
  SELECT DISTINCT(name)
	FROM users
    JOIN orders
		ON users.id = orders.user_id;

Task2
_________________________________________________________________________________________________________
SELECT 
	p.id, p.name, p.price, c.name 'catalog'
FROM products p
JOIN catalogs c
ON p.catalog_id = c.id 






Task3
_________________________________________________________________________________________________________	
CREATE DATABASE destinations;
USE destinations;

DROP TABLE IF EXISTS flights;
CREATE TABLE flights (
  id SERIAL PRIMARY KEY,
  departure VARCHAR(255) COMMENT 'Departure City',
  destination VARCHAR(255) COMMENT 'Destination City'
) COMMENT = 'Available flights';

DROP TABLE IF EXISTS cities;
CREATE TABLE cities (
  label VARCHAR(255) COMMENT 'English',
  name VARCHAR(255) COMMENT 'Russia'
) COMMENT = 'translator';

-- Заполняем таблицы
INSERT INTO flights VALUES
	('moscow', 'omsk'),
    ('novgorod', 'kazan'),
    ('irkutsk', 'moscow'),
    ('omsk', 'irkutsk'),
    ('moscow', 'kazan');
    
INSERT INTO cities VALUES
	('moscow', 'Москва'),
    ('novgorod', 'Новгород'),
    ('irkutsk', 'Иркутск'),
    ('omsk', 'Омск'),
    ('kazan', 'Казань');

SELECT c.name AS Отправление
	FROM
		cities as c
	JOIN
		flights as f
	ON  c.label = f.departure;
      
SELECT c.name AS Прибытие
	FROM
		cities as c
	JOIN
		flights as f
	ON c.label = f.destination;
    
SELECT (SELECT c.name
			FROM cities AS c
			WHERE c.label = f.departure) AS Отправление,
		(SELECT c.name
			FROM cities AS c
			WHERE c.label = f.destination) AS Прибытие
FROM flights AS f;