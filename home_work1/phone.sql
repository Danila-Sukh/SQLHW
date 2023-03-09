USE myfirstdb;
SELECT * FROM phone;
SELECT model, brand, cost 
FROM phone 
WHERE count > 2;
SELECT * 
FROM phone
WHERE brand = "Samsung"