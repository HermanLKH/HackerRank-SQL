SET NOCOUNT ON;

SELECT *
FROM CITY
WHERE CountryCode = 'USA'
AND   Population > 100000;

go
