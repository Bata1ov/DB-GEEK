"Операторы, фильтрация, сортировка и ограничение"
--------------------------------------------------------------------------------------------------------------

Task1
SELECT * FROM users;
UPDATE users SET created_at=NULL,updated_at=NULL;
SELECT * FROM users;
UPDATE users SET created_at=NOW() WHERE created_at IS NULL;
UPDATE users SET updated_at=NOW() WHERE updated_at IS NULL;
SELECT * FROM users;

---------------------------------------------------------------------------------------------------------------

Task2
SELECT * FROM users;
UPDATE users SET created_at_d = STR_TO_DATE(created_at, '%d.%m.%Y %H:%i');
UPDATE users SET updated_at_d = STR_TO_DATE(updated_at, '%d.%m.%Y %H:%i');
SELECT * FROM users;

---------------------------------------------------------------------------------------------------------------

Task3
create table storehouses_products (
	id SERIAL PRIMARY KEY,
    storehouse_id INT unsigned,
    product_id INT unsigned,
    `value` INT unsigned COMMENT 'Запас товарный позиции на складке',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Запасы на складе';

INSERT INTO
    storehouses_products (storehouse_id, product_id, value)
VALUES
    (1, 1, 2),
    (1, 3, 0),
    (1, 5, 10),
    (1, 4, 5),
    (1, 6, 0);
storehouses_products ORDER BY IF(value > 0, 0, 1), value;

---------------------------------------------------------------------------------------------------------------

Task4
SELECT name, birthday_at FROM users WHERE MONTHNAME(birthday_at) IN ('may', 'august');
---------------------------------------------------------------------------------------------------------------

Task5
SELECT* FROM catalogs WHERE id IN (5, 1, 2) ORDER BY FIELD(id, 3, 1, 2)


“Агрегация данных”

---------------------------------------------------------------------------------------------------------------

Task1
SELECT ROUND(AVG(TIMESTAMPDIFF(YEAR, birthday_at, NOW())), 0) AS AVG_Age FROM users;

---------------------------------------------------------------------------------------------------------------

Task2
SELECT
	DATE_FORMAT(DATE(CONCAT_WS('-', YEAR(NOW()), MONTH(birthday_at), DAY(birthday_at))), '%W') AS day,
	COUNT(*) AS total
FROM
	users
GROUP BY
	day
ORDER BY
	total DESC;

---------------------------------------------------------------------------------------------------------------

Task3
SELECT ROUND(exp(SUM(ln(value))), 0) AS factorial FROM integers;

