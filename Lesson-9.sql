"Транзакции, переменные, представления"
¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
Task1
_________________________________________________________________________________________________________
START TRANSACTION;
DELETE FROM sample.users AS su WHERE su.id = 1;
INSERT INTO sample.users SELECT * FROM shop.users su WHERE su.id = 1;
DELETE FROM shop.users AS su WHERE su.id = 1;
COMMIT;
¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
Task2
_________________________________________________________________________________________________________
CREATE OR REPLACE VIEW products_view AS
SELECT 
	c.name AS 'Каталог',
	p.name AS 'Название',
    p.description AS 'Описание',
    p.price AS 'Цена' 
FROM 
	products AS p 
		JOIN 
			catalogs AS c 
		ON 
			p.catalog_id = c.id;
            
SELECT * FROM products_view;

¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
Task3
очень странно, почему в задании написано размещены календарные записи за август 2018, но есть дата 16 года, так и должно быть?
тут 2 варианта, но прошу приложить правильный вариант , либо потом подсмотрю на уроке
_________________________________________________________________________________________________________
SET @august=8;
PREPARE prd FROM 'SELECT created_at, IF(created_at IS NULL  ,0,1) FROM users WHERE MONTH(created_at)=?';
EXECUTE prd USING @august;
¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
SELECT created_at, IF(created_at IS NULL  ,0,1) FROM users WHERE MONTH(created_at)=8; 



Task4
_________________________________________________________________________________________________________
CREATE VIEW del_old AS 
  SELECT orders.created_at as ord_cre
    FROM orders 
      ORDER BY created_at DESC LIMIT 5, 1;
DELETE FROM orders WHERE created_at <= (select ord_cre from del_old);


¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
“Администрирование MySQL”
Task1
_________________________________________________________________________________________________________
CREATE USER shop_read IDENTIFIED WITH sha256_password BY 'DASDK313>124.daas1';
CREATE USER shop IDENTIFIED WITH sha256_password BY 'DASDK313>124.daas2';
GRANT ALL ON shop.* TO 'shop';
GRANT SELECT ON shop.* TO 'shop_read';
¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯

Task2
_________________________________________________________________________________________________________
CREATE TABLE accounts(
    id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255),
    password VARCHAR(255)
    );

DROP VIEW IF EXISTS username;
CREATE VIEW username AS SELECT id, name FROM accounts;

CREATE USER user_read IDENTIFIED WITH sha256_password BY 'DASDK313>124.daas3';
GRANT SELECT ON username TO 'user_read';






"Хранимые процедуры и функции, триггеры"
¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
Task1
_________________________________________________________________________________________________________
CREATE DATABASE IF NOT EXISTS shop;
USE shop;

DELIMITER //

DROP FUNCTION IF EXISTS hello;
CREATE FUNCTION IF NOT EXISTS hello()
RETURNS TEXT DETERMINISTIC
BEGIN
    DECLARE hour TIME DEFAULT HOUR(CURTIME());
    IF hour >= 6 AND hour < 12 THEN RETURN 'Доброе утро';
    ELSEIF hour >= 12 AND hour < 18 THEN RETURN 'Добрый день';
    ELSEIF hour >= 18 AND hour <= 23 THEN RETURN 'Добрый вечер';
    ELSE RETURN 'Доброй ночи';
    END IF;
END//

SELECT hello()//

¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
Task2
_________________________________________________________________________________________________________
DROP TRIGGER IF EXISTS check_products_before;
DELIMITER //
CREATE TRIGGER check_products_before BEFORE INSERT ON products
FOR EACH ROW
    BEGIN
        IF (ISNULL(NEW.name) AND ISNULL(NEW.description)) THEN
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'INSERT cancelled';
        END IF;
    END//
DELIMITER ;

¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
Task3
_________________________________________________________________________________________________________
CREATE FUNCTION fibonacchi(IN num INT)
	RETURNS INT DETERMINISTIC
	BEGIN
		SET @i := 0;
		SET @s := 0;
		WHILE @i <= num DO
			SET @s = @s + @i;
			SET @i = @i + 1;
		END WHILE;
		RETURN @s;
	END//