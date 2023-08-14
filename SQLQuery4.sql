use [NORTHWND]
--lay ten tu bang san pham
select [ProductName]
from [dbo].[Products];

--lay ten san pham, gia, so luong san pam
select [ProductName], [UnitPrice],[QuantityPerUnit]
from [dbo].[Products];

-- lay ten va quoc gia cua khach hang
select [ContactName],[Country]
from [dbo].[Customers]

-- lay ten va so dien thoai cua cac nha cung cap
select ContactName, CompanyName, Phone
from dbo.Suppliers

select *
from [dbo].[Order Details]

--	SELECT DISTINCT
select distinct Country
from dbo.Customers

select distinct [PostalCode]
from [dbo].[Suppliers]

select distinct [LastName],[TitleOfCourtesy]
from [dbo].[Employees]

select distinct [ShipVia]
from [dbo].[Orders]

-- alias
select [CompanyName] AS [ten cong ty], 
		[PostalCode] AS [ma buu dien], 
		[Phone] as [SDT]
from [dbo].[Customers]

select [FirstName] as [ho],
		[LastName] as [ten]
from [dbo].[Employees]

select top 10 [o].*
from [dbo].[Orders] as [o]

select top 5 [p].ProductName as [ten san pham], 
			[p].SupplierID as [ma cung cap], 
			[p].CategoryID as [ma the loai]
from  [dbo].[Products] as [p]

--	SELECT TOP FROM
select top 10 *
from [dbo].[Customers]

select top 5 [CompanyName]
from [dbo].[Customers]

select top 20 percent * 
from [dbo].[Employees]
 
select distinct top 5 [CustomerID]
from [dbo].[Orders]

select distinct top 3 [CategoryID]
from [dbo].[Products]

select min([p].[UnitPrice]) as [minprice]
from [dbo].[Products] as [p]

select max ([o].[OrderDate])
from [dbo].[Orders] as [o]

select min ([e].[BirthDate])
from [dbo].[Employees] as [e]

-- Count, sum, avg
select count ([c].[CustomerID]) as [NumberOfCustomers]
from [dbo].[Customers] as [c]

select sum ([o].[Freight]) as [totalFreight]
from [dbo].[Orders] as [o]

select avg ([od].[Quantity]) as [avgQuantity]
from [dbo].[Order Details] as [od]


select count (*) as [countSP], 
		sum([p].[UnitsInStock]) as [sumHTK], 
		avg([p].[UnitPrice]) as [avgPrice]
from [dbo].[Products] as [p]

select count ([o].[OrderID])
from [dbo].[Orders] as [o]

select avg ([od].[UnitPrice]) as [avgP] ,
		sum ([od].[Quantity]) as [SumQ]
from [dbo].[Order Details] as [od]

-- Order By
select * 
from [dbo].[Suppliers] as [su]
order by [su].CompanyName ASC

select [p].ProductName,[p].[UnitPrice]
from [dbo].[Products] as [p]
order by [p].[UnitPrice] DESC

select *
from [dbo].[Employees] as [e]
order by [LastName], [FirstName]

select top 1 od.ProductID, od.Quantity
from [dbo].[Order Details] as [od]
order by [od].Quantity DESC

select [o].OrderID, [o].OrderDate
from [dbo].[Orders] as [o]
order by [o].OrderDate DESC

select [p].ProductName,[p].UnitPrice,[p].UnitsInStock
from [dbo].[Products] as [p] 
order by [p].UnitsInStock DESC

--- +,-,*,/
select p.ProductID, p.ProductName, 
		(p.UnitsInStock - p.UnitsOnOrder) as stockRemaining
from [dbo].[Products] as p

select od.OrderID, od.ProductID, 
		(od.UnitPrice*od.Quantity) as ODvalue
from [dbo].[Order Details] as od

select  avg(o.Freight)/max(o.Freight)
from [dbo].[Orders] as o

select p.ProductName, p.UnitPrice,
	(p.UnitPrice - p.UnitPrice*10/100) as disPrice
from [dbo].[Products] as p

--- where 
select e.FirstName, e.LastName, e.City
from [dbo].[Employees] as e
where e.City = 'London'
order by e.LastName ASC

select count (o.OrderID) as [latelyShipped]
from [dbo].[Orders] as o
where o.RequiredDate < o.ShippedDate

select *
from [dbo].[Order Details] as od
where od.Discount > 0.1

select * 
from [dbo].[Orders] as o 
where o.ShipCountry = 'France'

select *
from [dbo].[Products] as p
where p.UnitsInStock >20
order by p.UnitsInStock DESC


-- Condition
--- and là tất cả các dk đều phải là TRUE
--- OR là có ít 1 dk được phân tách bằng hoặc có giá trị True
--- Not là đk có gt FALSE
select *
from [dbo].[Products] as p
where p.UnitsInStock <50 or p.UnitsInStock > 100
order by p.UnitsInStock 

select * 
from [dbo].[Orders] as o
where o.ShipCountry = 'Brazil' 
and o.RequiredDate < o.ShippedDate

select *
from [dbo].[Products] as p
where Not (p.UnitPrice >= 100 and p.CategoryID = 1)
order by p.UnitPrice 

select *
from [dbo].[Orders] as o
where o.Freight >= 50 and o.Freight <= 100

select p.ProductName, p.QuantityPerUnit,
p.UnitPrice,p.UnitsInStock, p.UnitsOnOrder
from [dbo].[Products] as p
where p.UnitsInStock > 20 and p.UnitsOnOrder < 20

select p.ProductName, p.QuantityPerUnit,
p.UnitPrice
from [dbo].[Products] as p
where p.UnitPrice between 10 and 20

select *
from [dbo].[Orders] as o
where o.OrderDate between '1996-07-01' and '1996-07-31'

select *
from [dbo].[Orders] as o
where o.ShipVia = 3 and
o.OrderDate between '1997/1/1' and '1997/12/31'

-- CÂU HỎI: TÌM RA TÊN, ĐỊA CHỈ, QUÊN QUÁN 
-- CỦA TOP 2 NHÂN VIÊN BẮT ĐẦU LÀM VIỆC TRONG NĂM 1993
select Top 2 e.FirstName, e.LastName, e.[Address], e.Country, e.HireDate
from [dbo].[Employees] as e
where e.HireDate > 1993/1/1

-- 1. Liệt kê danh sách nhân viên có Lastname từ A-M và BirthDate nhỏ hơn bằng 1959 ( Bảng Employees).
-- 2. Liệt kê danh sách Order có Discount [0.25 , 0.3] và tính trung bình các UnitPrice đó ( Bảng Order Details).

select *
from [dbo].[Employees] as e
where e.BirthDate <= '1959/12/31' and e.LastName between 'A' and 'M'
order by e.LastName

select avg (od.UnitPrice)
from [dbo].[Order Details] as od
where od.Discount between 0.25 and 0.3


--- LiKE
select *
from [dbo].[Customers] as c
where c.Country like 'a%'

select *	
from [dbo].[Orders] as o
where o.ShipCity like '%a%'

-- % đại diện cho 0 đến nhiều ký tự
select o.ShipCountry	
from [dbo].[Orders] as o
where o.ShipCountry like 'u%'

-- _ đại diện cho 1 ký tự
select o.ShipCountry	
from [dbo].[Orders] as o
where o.ShipCountry like 'u_'

select *
from [dbo].[Suppliers] as s
where s.CompanyName like '%b%'

-- 1. Liệt kê tên sản phẩm có ký tự 'C' ở đầu và ký tự 'e ở cuối' (Bảng Products).
select p.ProductName
from [dbo].[Products] as p
where p.ProductName like 'C%' and p.ProductName like '%e' 

-- 2. Liệt kệ danh sách các Suppliers có số điện thoại :có chứa số 4 và có đuôi 22 (Bảng Suppliers).
select s.SupplierID, s.CompanyName, s.Phone
from [dbo].[Suppliers] as s
where s.Phone like '%4%' and s.Phone like '%22'

-- h[oa]t -> hot, hat
-- h[^oa]t -> hit
-- c[a-c] -> ca, cb,cc

select *
from [dbo].[Customers] as c
where c.ContactName like 'a%'

select *
from [dbo].[Customers] as c
where c.ContactName like 'h_%'

select o.ShipCity
from [dbo].[Orders] as o
where o.ShipCity like 'l[u,o]%'

select o.ShipCity
from [dbo].[Orders] as o
where o.ShipCity like 'l[^u,o]%'

select o.ShipCity
from [dbo].[Orders] as o
where o.ShipCity like 'l[a-e]%'

select s.CompanyName
from [dbo].[Suppliers] as s
where s.CompanyName like 'a%[^b]'

-- 1. Liệt kệ danh sách tên sản phẩm có ký tự thứ 2 là 'a' và ký tự cuối cùng là 'e' (Bảng Products).
select p.ProductName
from [dbo].[Products] as p
where p.ProductName like '_a%' and  p.ProductName like '%e'

-- 2. Liệt kệ danh sách Homephone mà trong đó không có số ( 2,4,6 ) ( Bảng Employees).
select e.HomePhone
from [dbo].[Employees] as e
where e.HomePhone not like '%[2,4,6]%'

--- IN
select o.ShipCountry
from [dbo].[Orders] as o
where o.ShipCountry in ('Germany', 'UK', 'Brazil')

select o.ShipCountry
from [dbo].[Orders] as o
where o.ShipCountry not in ('Germany', 'UK', 'Brazil')

select p.CategoryID
from [dbo].[Products] as p
where p.CategoryID not in (2,3,4)

select *
from [dbo].[Employees] as e
where e.TitleOfCourtesy not in ('Mrs.', 'Ms.')

select *
from [dbo].[Customers] as c
where c.City in ('Berlin','London','Warszawa')

-- 1. Liệt kê danh sách orders ( Bảng Orders ) 
-- a. Chỉ gửi đến (Madrid , London , Cork).
-- b. Không gửi đến ( USA , UK , Mexico , Germany)

select *
from [dbo].[Orders] as o
where o.ShipCity in ('Madrid', 'London','Cork')

select *
from [dbo].[Orders] as o
where o.ShipCountry not in ('USA', 'UK','Mexico', 'Germany')
-- 2. Liệt kê danh sách Customers có ContactTitle không phải là ('Sales Representative','Owner') (Bảng Customers).
select *
from [dbo].[Customers] as c
where c.ContactTitle not in ('Sales Representative','Owner')

-- NULL
select count(*)
from [dbo].[Orders] as o
where o.ShippedDate is null

select *
from [dbo].[Customers] as c
where c.Region is not null

select *
from [dbo].[Customers] as c
where c.CompanyName is null

select count(*)
from [dbo].[Orders] as o
where o.ShippedDate is null and o.ShipRegion is not null

-- GROUP BY
select o.CustomerID, COUNT (o.OrderID) as totalodr
from [dbo].[Orders] as o
group by o.CustomerID

select p.SupplierID, avg (p.UnitPrice)
from [dbo].[Products] as p
group by p.SupplierID

select p.CategoryID, sum (p.UnitsInStock)
from [dbo].[Products] as p
group by p.CategoryID

select o.ShipCity, o.ShipCountry,
min (o.Freight), max(o.Freight)
from [dbo].[Orders] as o
group by o.ShipCity, o.ShipCountry
order by o.ShipCountry 

select count (distinct e.Country)
from [dbo].[Employees] as e

select e.Country, count (e.EmployeeID)
from [dbo].[Employees] as e
group by e.Country

select o.CustomerID, count (o.OrderID)
from [dbo].[Orders] as o
where YEAR(o.OrderDate) = 1997
group by o.CustomerID

select o.OrderID
from [dbo].[Orders] as o
where YEAR(o.OrderDate) = 1997 and MONTH (o.OrderDate) = 5

select o.OrderID
from [dbo].[Orders] as o
where o.OrderDate = '1996-9-4'

select o.CustomerID, count (o.OrderID) ,
month(o.OrderDate) as month
from [dbo].[Orders] as o
where year(o.OrderDate) = 1998
group by o.CustomerID, month(o.OrderDate)
order by month(o.OrderDate)

select *
from [dbo].[Orders] as o
where MONTH(o.ShippedDate) = 5
order by YEAR(o.ShippedDate)

select o.CustomerID, COUNT(o.OrderID)
from [dbo].[Orders] as o
group by o.CustomerID
having COUNT(o.OrderID) >20
order by COUNT(o.OrderID)

select p.SupplierID,sum(p.UnitsInStock),avg(p.UnitPrice)
from [dbo].[Products] as p
group by p.SupplierID
having sum(p.UnitsInStock) >30 and avg(p.UnitPrice) < 50

select month(o.ShippedDate), sum (o.Freight)
from [dbo].[Orders] as o
where YEAR(o.ShippedDate) = 1996
group by month(o.ShippedDate)
having month(o.ShippedDate) > 5
order by month(o.ShippedDate)

select c.CategoryID, c.CategoryName, p.ProductID, p.ProductName
from [dbo].[Products] as p, [dbo].[Categories] as c
where c.CategoryID = p.CategoryID

select e.EmployeeID, e.FirstName,e.LastName, count(o.OrderID)
from [dbo].[Employees] as e, [dbo].[Orders] as o
where e.EmployeeID = o.EmployeeID
group by e.EmployeeID, e.FirstName,e.LastName

select c.CustomerID, c.CompanyName, c.ContactName, count(o.OrderID)
from [dbo].[Customers] as c, [dbo].[Orders] as o
where c.CustomerID = o.CustomerID and c.Country = 'UK'
group by c.CustomerID, c.CompanyName, c.ContactName

select s.ShipperID, s.CompanyName, sum(o.Freight)
from [dbo].[Orders] as o, [dbo].[Shippers] as s
where s.ShipperID = o.ShipVia
group by s.ShipperID, s.CompanyName
order by sum(o.Freight) DESC

select Top 1 su.SupplierID, su.ContactName, count (p.ProductID)
from [dbo].[Suppliers] as su, [dbo].[Products] as p
where su.SupplierID = p.SupplierID
group by su.SupplierID, su.ContactName
order by count (distinct p.ProductID) DESC

select o.OrderID, SUM(od.Quantity*od.UnitPrice)
from [dbo].[Orders] as o, [dbo].[Order Details] as od
where o.OrderID = od.OrderID
group by o.OrderID

select o.OrderID, e.FirstName, e.LastName, sum(od.Quantity*od.UnitPrice)
from [dbo].[Orders] as o, [dbo].[Order Details] as od, [dbo].[Employees] as e
where o.OrderID = od.OrderID and e.EmployeeID = o.EmployeeID
group by o.OrderID, e.FirstName, e.LastName

select o.OrderID, c.CustomerID, s.CompanyName, o.ShipCountry, o.ShippedDate
from [dbo].[Orders] as o, [dbo].[Customers] as c, [dbo].[Shippers] as s
where o.CustomerID = c.CustomerID and s.ShipperID = o.ShipVia and YEAR(ShippedDate) = 1997 and o.ShipCountry = 'UK'

select c.CategoryID, c.CategoryName, p.ProductID, p.ProductName
from [dbo].[Products] as p, [dbo].[Categories] as c
where c.CategoryID = p.CategoryID and  c.CategoryName = 'Seafood'

select s.SupplierID, s.Country, p.ProductID, p.ProductName
from [dbo].[Products] as p, [dbo].[Suppliers] as s
where s.SupplierID = p.SupplierID
and s.Country = 'Germany'

select o.OrderID, c.ContactName, sh.CompanyName
from [dbo].[Orders] as o, [dbo].[Customers] as c, [dbo].[Shippers] as sh
where o.CustomerID = c.CustomerID 
and o.ShipVia = sh.ShipperID
and c.City = 'London'

select o.OrderID, c.ContactName, sh.CompanyName, o.RequiredDate,o.ShippedDate
from [dbo].[Orders] as o, [dbo].[Customers] as c, [dbo].[Shippers] as sh
where o.CustomerID = c.CustomerID 
and o.ShipVia = sh.ShipperID
and o.RequiredDate < o.ShippedDate

-- 22 rows
select od.OrderID
from [dbo].[Order Details] as od
where od.UnitPrice between 100 and 200	

-- 433 rows
select od.OrderID
from [dbo].[Order Details] as od
where od.Quantity in (10,20)

-- 7rows
select od.OrderID
from [dbo].[Order Details] as od
where od.UnitPrice between 100 and 200	
and od.Quantity in (10,20)

-- 488 rows
select od.OrderID
from [dbo].[Order Details] as od
where od.UnitPrice between 100 and 200	
or od.Quantity in (10,20)

-- 360
select distinct od.OrderID
from [dbo].[Order Details] as od
where od.UnitPrice between 100 and 200	
or od.Quantity in (10,20)

-- Union
select od.OrderID
from [dbo].[Order Details] as od
where od.UnitPrice between 100 and 200	
UNION
select od.OrderID
from [dbo].[Order Details] as od
where od.Quantity in (10,20)

-- union all
select od.OrderID
from [dbo].[Order Details] as od
where od.UnitPrice between 100 and 200	
UNION ALL
select od.OrderID
from [dbo].[Order Details] as od
where od.Quantity in (10,20)

select c.City, c.Country
from [dbo].[Customers] as c
where c.Country like 'u%'
UNION
select su.City, su.Country
from [dbo].[Suppliers] as su
where su.City = 'London'
UNION
select o.ShipCity, o.ShipCountry
from [dbo].[Orders] as o
where o.ShipCountry = 'USA'

select country
from Suppliers
UNION
select country
from Customers

-- JOIN
select ca.CategoryID, ca.CategoryName, count (p.ProductID)
from [dbo].[Products] as p
INNER JOIN [dbo].[Categories] as ca
on ca.CategoryID = p.CategoryID
group by ca.CategoryID, ca.CategoryName

select distinct p.ProductName, s.CompanyName
from [dbo].[Order Details] as od
INNER JOIN [dbo].[Products] as p
on od.ProductID = p.ProductID
INNER JOIN [dbo].[Suppliers] as s
on p.SupplierID = s.SupplierID

select o.OrderID, e.FirstName,e.LastName, c.CompanyName
from [dbo].[Orders] as o
left join [dbo].[Employees] as e
on o.EmployeeID = e.EmployeeID
left join [dbo].[Customers] as c
on o.CustomerID = c.CustomerID

---  toan bo bang ben phai
select c.CompanyName, e.FirstName, e.LastName
from [dbo].[Orders] as o
right join [dbo].[Customers] as c
on o.CustomerID = c.CustomerID
right join [dbo].[Employees] as e
on o.EmployeeID = e.EmployeeID

-- join toan bo 2 ban
select c.CompanyName, o.OrderID
from [dbo].[Orders] as o
inner join [dbo].[Order Details] as od
on od.OrderID = o.OrderID
inner join [dbo].[Customers] as c
on o.CustomerID = c.CustomerID

-- subquery
select p.ProductID, p.ProductName, p.UnitPrice
from [dbo].[Products] as p
where UnitPrice > (
	select avg(p.UnitPrice)
	from [dbo].[Products] as p)

select (
	select sum(od.Quantity*od.UnitPrice)
	from [dbo].[Order Details] as od
	where o.OrderID = od.OrderID)
from [dbo].[Orders] as o

select p.ProductID, p.ProductName, (
	select count(*)
	from [dbo].[Order Details] as od
	where od.ProductID = p.ProductID )
from [dbo].[Products] as p

select *
from [dbo].[Orders] as o
where o.OrderDate = (
	select max(o.OrderDate)
	from [dbo].[Orders] as o)

select *
from [dbo].[Products] as p
where p.ProductID not in (
	select distinct od.ProductID
	from [dbo].[Order Details]as od)

select o.OrderID, p.ProductName, od.Quantity
from [dbo].[Orders] as o
inner join [dbo].[Order Details] as od
on od.OrderID = o.OrderID
inner join [dbo].[Products] as p
on p.ProductID =  od.ProductID
where o.OrderID in (
	select o.OrderID
	from [dbo].[Orders] as o
	where o.ShippedDate is null)

select *
from [dbo].[Products] as p
where p.UnitsInStock > (
	select avg(p.UnitsInStock)
	from [dbo].[Products] as p)

select od.Quantity*od.UnitPrice as total, c.*
from [dbo].[Order Details] as od
join [dbo].[Orders] as o
on o.OrderID = od.OrderID
join [dbo].[Customers] as c
on c.CustomerID = o.CustomerID
where od.Quantity*od.UnitPrice in (
	select max(od.Quantity*od.UnitPrice)
	from [dbo].[Order Details] as od)

SELECT c.*
FROM [dbo].[Orders] o
JOIN [dbo].[Customers] c
ON c.CustomerID= o.CustomerID
WHERE o.OrderID IN (
			  SELECT [OrderID]
                          FROM  [dbo].[Order Details]
                          WHERE  [UnitPrice]*[Quantity]= (
                                                        select MAX([UnitPrice]*[Quantity]) AS "Giá đơn"
                                                         from [dbo].[Order Details] 
		                                                 )
					 ) ;

--- CTE and window funtion
-- xep hang gia tri sp va xep hang don hang theo tung san pham
with product_value as (
	select o.OrderID,c.CompanyName, ProductName,
		od.Quantity,od.UnitPrice,od.Quantity*od.UnitPrice as totalPrice
	from [dbo].[Orders] as o
	inner join [dbo].[Order Details] as od
	on o.OrderID = od.OrderID
	inner join [dbo].[Customers] as c
	on o.CustomerID = c.CustomerID
	inner join [dbo].[Products] as p
	on od.ProductID = p.ProductID
)


, productv as (
	select ProductName,
		sum (od.Quantity*od.UnitPrice) as totalPrice
	from [dbo].[Orders] as o
	inner join [dbo].[Order Details] as od
	on o.OrderID = od.OrderID
	inner join [dbo].[Customers] as c
	on o.CustomerID = c.CustomerID
	inner join [dbo].[Products] as p
	on od.ProductID = p.ProductID
	group by ProductName
)

select *
	,rank() over (order by totalPrice) as rank
from productv



