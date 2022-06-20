/*Creating table in the database in order to copy the csv file*/

CREATE TABLE housings(  
    id SERIAL,
    saledate DATE,
    price INT,
    type VARCHAR(255),
    bedrooms INT,
    PRIMARY KEY (id)
);

/*changing the default date format of postgresql to date format in csv file*/
SET datestyle To ISO,DMY;

/*Copying the csv file into the database*/

COPY housings(saledate,price,type,bedrooms)
FROM 'C:\Users\Lenovo\Downloads\housing_sales.csv'
DELIMITER ','
CSV HEADER;

/*Find out all about sold housings with more than 2 bedrooms*/

SELECT *
FROM housings
WHERE bedrooms>2;

/*Counting the number of sales for each date and displaying dates with highest number of sales first.*/
SELECT saledate, COUNT(*)
FROM housings
GROUP BY 1
ORDER BY 2 DESC;

/*Which date corresponds to the highest number of sales?*/
SELECT saledate, COUNT(*)
FROM housings
GROUP BY 1
ORDER BY 2 DESC
LIMIT 1;

/*Displaying dates and corresponding amount of sales with dates having highest amount of sales first*/

SELECT saledate, SUM(price)
FROM housings
GROUP BY 1
ORDER BY 2 DESC
LIMIT 1;

/*Which date has the highest amount of sales in total*/
SELECT saledate, SUM(price)
FROM housings
GROUP BY 1
ORDER BY 2 DESC
LIMIT 1;

/*Which date has the highest amount of sales in one day*/
SELECT saledate, MAX(price)
FROM housings
GROUP BY 1
ORDER BY 2 DESC
LIMIT 1;

/*Finding out the date with the highest average price per sale?*/

SELECT saledate, AVG(price)
FROM housings
GROUP BY 1
ORDER BY 2 DESC
LIMIT 1;

/*Which year witnessed the lowest number of sales?*/
SELECT saledate, COUNT(*)
FROM housings
GROUP BY 1
ORDER BY 2
LIMIT 1;

/*Find the number of houses that were sold*/

SELECT COUNT(*) house_count
FROM (SELECT type
FROM housings
WHERE type = 'house') AS houses;

/*Find the number of unit that were sold*/

SELECT COUNT(*) unit_count
FROM (SELECT type
FROM housings
WHERE type = 'unit') AS houses;

/*For the most expensive housing, determine its type and number of bedrooms*/

SELECT type, bedrooms
FROM housings
Where price = (SELECT MAX(price)
FROM housings);

/*For the date with highest amount of sales, how many housings were sold*/
SELECT saledate, COUNT(*) housing_no
FROM housings
WHERE saledate = (SELECT saledate
FROM (SELECT saledate, SUM(price)
FROM housings
GROUP BY 1
ORDER BY 2 DESC
LIMIT 1) max_saledate)
GROUP BY 1;
