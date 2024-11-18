
--------------------------------------------------------------------------------
----------------------------[HumanResources]------------------------------------
--------------------------------------------------------------------------------

--16 OK
SELECT *
FROM [HumanResources].Department D

--290 OK
SELECT *
FROM [HumanResources].Employee E

--296 OK
SELECT *
FROM [HumanResources].EmployeeDepartmentHistory EDH

--316 OK
SELECT *
FROM [HumanResources].EmployeePayHistory EPH

--13
SELECT *
FROM [HumanResources].JobCandidate JC

--3 OK
SELECT *
FROM [HumanResources].[Shift] S


----MEJORA


--3 OK
SELECT *
FROM [HumanResources].[Shift] S

--16 OK
SELECT *
FROM [HumanResources].Department D

--296 OK
SELECT *
FROM [HumanResources].EmployeeDepartmentHistory EDH

--unir tablas "EDH_FULL"
SELECT EDH.BusinessEntityID, EDH.DepartmentID, EDH.ShiftID, 
EDH.StartDate, EDH.EndDate, EDH.ModifiedDate, D.[Name] DeparmentName, D.GroupName, S.[Name] ShiftName,
S.StartTime, S.EndTime
FROM [HumanResources].EmployeeDepartmentHistory EDH
	INNER JOIN [HumanResources].Department D ON EDH.DepartmentID = D.DepartmentID --UNION CON "D"
	INNER JOIN [HumanResources].[Shift] S ON EDH.ShiftID = S.ShiftID --UNION CON "S"


	
--------------------------------------------------------------------------------
----------------------------[Person]--------------------------------------------
--------------------------------------------------------------------------------

--19.614
SELECT *
FROM [Person].[Address] A

--6
SELECT *
FROM [Person].AddressType AT

--20.777
SELECT *
FROM [Person].BusinessEntity BE

--19.614
SELECT *
FROM [Person].BusinessEntityAddress BEA

--909
SELECT *
FROM [Person].BusinessEntityContact BEC

--20
SELECT * FROM [Person].[ContactType] CT

--238
SELECT * FROM [Person].[CountryRegion] CR

--19.972
SELECT * FROM [Person].[EmailAddress] EA

--19.972
SELECT * FROM [Person].[Password] PW

--19.972
SELECT * FROM [Person].[Person] P

--19.972
SELECT * FROM [Person].[PersonPhone] PP

--3
SELECT * FROM [Person].[PhoneNumberType] PNT

--181
SELECT * FROM [Person].[StateProvince] SP

	
--------------------------------------------------------------------------------
----------------------------[Sales]--------------------------------------------
--------------------------------------------------------------------------------
SELECT *
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME in (
'CountryRegionCurrency',
'CreditCard',
'Currency',
'CurrencyRate',
'Customer',
'PersonCreditCard',
'SalesOrderDetail',
'SalesOrderHeader',
'SalesOrderHeaderSalesReason',
'SalesPerson',
'SalesPersonQuotaHistory',
'SalesReason',
'SalesTaxRate',
'SalesTerritory',
'SalesTerritoryHistory',
'ShoppingCartItem',
'SpecialOffer',
'SpecialOfferProduct',
'Store'
)
--109
SELECT *
FROM AdventureWorks2022.Sales.SpecialOfferProduct


--109
SELECT *
FROM AdventureWorks2022.Sales.CountryRegionCurrency SRC

--19.118
SELECT *
FROM AdventureWorks2022.Sales.CreditCard CC

--105
SELECT *
FROM AdventureWorks2022.Sales.Currency C


--13.532
SELECT *
FROM AdventureWorks2022.Sales.CurrencyRate CR

--19.820
SELECT *
FROM AdventureWorks2022.Sales.Customer CU

--19.118
SELECT *
FROM AdventureWorks2022.Sales.PersonCreditCard PCC

--121.317
SELECT *
FROM AdventureWorks2022.Sales.SalesOrderDetail SOD


	
--------------------------------------------------------------------------------
----------------------------[Purchasing]----------------------------------------
--------------------------------------------------------------------------------

--460
SELECT *
FROM AdventureWorks2022.Purchasing.ProductVendor PV


--8845
SELECT *
FROM AdventureWorks2022.Purchasing.PurchaseOrderDetail POD


--4012
SELECT *
FROM AdventureWorks2022.Purchasing.PurchaseOrderHeader POH


--5
SELECT *
FROM AdventureWorks2022.Purchasing.ShipMethod SH

--104
SELECT *
FROM AdventureWorks2022.Purchasing.Vendor V
