 CREATE TABLE zepto(
category VARCHAR(150),
name VARCHAR(150),
mrp NUMERIC(8,2),
discountedpercent NUMERIC(5,2),
availableQuantity INTEGER,
discountedSellingPrice NUMERIC(8,2),
weightInGms INTEGER,
outOfStock BOOLEAN,
quantity INTEGER
);
select * from zepto
where '*' is null;
select count(*) from zepto;
select * from zepto;
select distinct name from zepto;

select outofstock, count(outOfStock) as available_quantity  from zepto
group by outofstock;

-- data cleaning --
-- product with price =0
select * from zepto 
where mrp = 0 OR discountedSellingPrice = 0;

delete from zepto 
where mrp = 0;

-- convert paisa into INR OR RUPEES
UPDATE zepto
 SET mrp = mrp/100.0,
 discountedSellingPrice = discountedSellingPrice/100.0;


                    -- business Inside Question --

-- Q1.find out the top 10 best-Value product based on the discounted percentage

 select Distinct name,discountedpercent,mrp from zepto
 order by discountedpercent DESC
 LIMIT 20;


 -- Q2. What Are The product with High mrp but out of stock


 select Distinct name,mrp from zepto
 where outofstock  = True  and mrp > 200
 order by mrp DESC;


 -- Q3 calculate the Estimate Revenue From Each Category

 select category, sum(discountedSellingPrice * availableQuantity) AS total_revenue
 from zepto
 group by category
 order by total_revenue;

 -- Q4  find all the product where mrp is greater than 500 and discount is less than 10%

  select * from zepto
  where mrp > 500 and discountedpercent < 10
  order by discountedpercent DESC;

-- Q5 Identify top 5 category offer the highest average discount percentage

select category,ROUND(avg(discountedpercent),2) 
from zepto 
Group by category
order by avg(discountedpercent) DESC
limit 5;


--Q6 Find out the price per gram for product above 100g ans short by best values

select DISTINCT name,weightInGms,discountedSellingPrice,
ROUND(discountedSellingPrice/weightInGms,2) As price_per_gram
from zepto
where weightInGms >= 100
order by  price_per_gram;

-- Q7 Group the product into categories like low,medium,bulk "1000 low", "5000 medium" ,"5000>bulk"

select DISTINCT name,weightInGms,
CASE WHEN weightInGms < 1000 THEN 'LOW'
     WHEN weightInGms < 5000 THEN 'medium'
	 ELSE 'bulk'
   END AS weight_category
from zepto;   


-- 	Q8 what is the total inventory weight per category

select category, sum(weightInGms * availableQuantity) AS total_weight
from zepto
GROUP BY category
order by total_weight;

 

