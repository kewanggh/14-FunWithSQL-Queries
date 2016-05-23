-- 1. Return all category names with their descriptions from the Categories table.
SELECT CategoryName, Description FROM categories;
-- 2.  Return the contact name, customer id, and company name of all Customers in London
		select contactname, customerid, companyname from customers where City='London';
-- 3. Return all available columns in the Suppliers tables for the marketing managers and sales representatives that have a FAX number
		select fax from suppliers where (contacttitle = 'Marketing Manager' OR contacttitle = 'Sales Representative') AND fax  is not null;
-- 4. Return a list of customer id's from the Orders table with required dates between Jan 1, 1997 and Jan 1, 1998 and with freight under 100 units.
		select customerid,orderdate,freight from Orders where orderdate BETWEEN CAST('1997-01-01' AS DATE) AND CAST('1998-01-01' AS DATE) AND freight <100;
-- 5. Return a list of company names and contact names of all the Owners from the Customer table from Mexico, Sweden and Germany.
		select companyname, contactname from Customers where country = 'Mexico' or country = 'Sweden' or country='Germany';
-- 6. Return a count of the number of discontinued products in the Products table.
		select count(productname) from products where discontinued=1;
-- 7. Return a list of category names and descriptions of all categories beginning with 'Co' from the Categories table.
		select categoryname, description from categories where categoryname LIKE 'Co%';
-- 8. Return all the company names, city, country and postal code from the Suppliers table with the word 'rue' in their address. The list should ordered alphabetically by company name.
		select companyname, city, address, country, postalcode from suppliers where address LIKE '%rue%' order by companyname;
-- 9. Return the product id and the total quantities ordered for each product id in the Order Details table.
		select ProductID, sum(Quantity) as TotalQty from [order details] group by ProductID		
-- 10. Return the customer name and customer address of all customers with orders that shipped using Speedy Express.
		select customers.contactname, customers.address from customers left outer join orders on customers.customerid = orders.customerid where shipvia = 1;
-- 11. Return a list of Suppliers containing company name, contact name, contact title and region description.
		select suppliers.companyname, suppliers.contactname, suppliers.contacttitle, region.regiondescription from suppliers left join region on suppliers.supplierid = region.regionid;
-- 12. Return all product names from the Products table that are condiments.
		select products.productname from products inner join categories on products.categoryid = categories.categoryid where categoryname = 'Condiments';
-- 13. Return a list of customer names who have no orders in the Orders table.
		SELECT customers.contactname, orders.orderid from customers left join orders on customers.customerid = orders.customerid where orders.orderid is null
-- 14. Add a shipper named 'Amazon' to the Shippers table using SQL.
		set identity_insert shippers on;
		INSERT INTO shippers (shipperid,CompanyName,phone)
		VALUES (4,'Amazon',null);
-- 15. Change the company name from 'Amazon' to 'Amazon Prime Shipping' in the Shippers table using SQL.
		update shippers set companyname='Amazon Prime Shipping' where CompanyName = 'Amazon';
-- 16. Return a complete list of company names from the Shippers table. Include freight totals rounded to the nearest whole number for each shipper from the Orders table for those shippers with orders.
		select shippers.companyname, round(sum(orders.freight),0) 
		from shippers inner join orders 
		on shippers.shipperid = orders.shipvia
		group by shippers.companyname
-- 17. Return all employee first and last names from the Employees table by combining the 2 columns aliased as 'DisplayName'. The combined format should be 'LastName, FirstName'.
		select concat(lastname, ', ',firstname) as DisplayName from employees
-- 18. Add yourself to the Customers table with an order for 'Grandma's Boysenberry Spread'.
		insert into customers (customerid, companyname, contactname, contacttitle, address, city, Region, PostalCode,country, phone, fax)
		values('KWKWK', 'abc', 'kewang', 'owner', '123 peace', 'san diego', 'bc', '92101', 'usa', '858-888-8888', '030-0076545')

		insert into orders(customerid, employeeid, orderdate, requireddate, shippeddate, freight, shipname, shipaddress, shipcity, shipregion, shippostalcode, shipcountry)
		values((SELECT customerid FROM customers WHERE contactname='kewang'), null, CAST('1997-01-01' AS DATE), CAST('1997-01-01' AS DATE), CAST('1997-01-01' AS DATE), null, null,null, null, null, null, null)

		insert into [order details](orderid, productid)
values((select max(orderid) from orders), (select productid from products where productname='Grandma''s Boysenberry Spread'))
-- 19. Remove yourself and your order from the database.
		DELETE FROM [order details] where orderid = (select max(orderid) from orders)
		DELETE FROM ORDERS Where customerid = (select customerid from customers where contactname='kewang')
		DELETE FROM customers where customerid='KWKWK'
-- 20. Return a list of products from the Products table along with the total units in stock for each product. Give the computed column a name using the alias, 'TotalUnits'. Include only products with TotalUnits greater than 100.
		 select productname, unitsinstock as TotalUnits from products where UnitsInStock > 100