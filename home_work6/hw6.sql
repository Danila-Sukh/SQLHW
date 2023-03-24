-- Задание 1.
DROP TABLE IF EXISTS users_old;
CREATE TABLE users_old LIKE users;

DROP PROCEDURE IF EXISTS prc_moveing_user;
DELIMITER //
CREATE PROCEDURE prc_moveing_user(user_id INT, OUT tran_result varchar(100))
BEGIN
	
	DECLARE moving_check BIT DEFAULT FALSE;

	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
	BEGIN
 		SET moving_check = TRUE;
	END;

	START TRANSACTION;
	    INSERT INTO users_old(id, firstname, lastname, email)
	    SELECT id, firstname, lastname, email FROM users
	    WHERE id = user_id;
	   
	    DELETE FROM users
	    WHERE id = user_id;
	   
	IF moving_check THEN
		SET tran_result = 'Ошибка. Что-то пошло не так.';
		ROLLBACK;
	ELSE
		SET tran_result = 'Успешное перемещение пользователя.';
		COMMIT;
	END IF;
END//
DELIMITER ;
CALL prc_moveing_user(3, @tran_result);
SELECT @tran_result;

-- Задание 2.
DROP FUNCTION IF EXISTS hello;

DELIMITER //
CREATE FUNCTION hello() 
RETURNS varchar(100) READS SQL DATA
BEGIN 
	DECLARE time_now time DEFAULT time(now());

	IF time_now > time('06:00:00') AND time_now < time('12:00:00') THEN 
		RETURN 'Доброе утро';
	END IF;
	IF time_now >= time('12:00:00') AND time_now < time('18:00:00') THEN 
		RETURN 'Доброе день';
	END IF;
	IF time_now >= time('18:00:00') THEN 
		RETURN 'Доброе вечер';
	END IF;
	IF time_now > time('00:00:00') AND time_now <= time('06:00:00') THEN 
		RETURN 'Доброе ночи';
	END IF;

RETURN 'Что-то пошло не так.';
END//
delimiter ;

SELECT hello();
