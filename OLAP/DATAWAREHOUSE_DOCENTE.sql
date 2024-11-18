
--------------------------------------------------------------------------------
----------------------------[HumanResources]------------------------------------
--------------------------------------------------------------------------------


--//F_Employee
IF OBJECT_ID ('F_Employee') IS NOT NULL DROP TABLE F_Employee;
GO
--
SELECT *
INTO F_Employee
FROM AdventureWorks2022.[HumanResources].Employee E

--//D_JobCandidate
IF OBJECT_ID ('D_JobCandidate') IS NOT NULL DROP TABLE D_JobCandidate;
GO
--
SELECT JC.JobCandidateID, JC.BusinessEntityID,
CONVERT(NVARCHAR(MAX), JC.Resume) AS ResumeText, JC.ModifiedDate
INTO D_JobCandidate
FROM AdventureWorks2022.[HumanResources].JobCandidate JC

--//D_EmployeePayHistory
IF OBJECT_ID ('D_EmployeePayHistory') IS NOT NULL DROP TABLE D_EmployeePayHistory;
GO
--
SELECT *
INTO D_EmployeePayHistory
FROM AdventureWorks2022.[HumanResources].EmployeePayHistory EPH

--//D_EmployeeDepartmentHistoryFull
IF OBJECT_ID ('D_EmployeeDepartmentHistoryFull') IS NOT NULL DROP TABLE D_EmployeeDepartmentHistoryFull;
GO
---
SELECT EDH.BusinessEntityID, EDH.DepartmentID, EDH.ShiftID, 
EDH.StartDate, EDH.EndDate, EDH.ModifiedDate, D.[Name] DeparmentName, D.GroupName, S.[Name] ShiftName,
S.StartTime, S.EndTime
INTO D_EmployeeDepartmentHistoryFull
FROM AdventureWorks2022.[HumanResources].EmployeeDepartmentHistory EDH
	INNER JOIN AdventureWorks2022.[HumanResources].Department D ON EDH.DepartmentID = D.DepartmentID --UNION CON "D"
	INNER JOIN AdventureWorks2022.[HumanResources].[Shift] S ON EDH.ShiftID = S.ShiftID --UNION CON "S"


	
	
--------------------------------------------------------------------------------
----------------------------[Person]--------------------------------------------
--------------------------------------------------------------------------------

--UNIR A + SP + CR

--//D_AddressFull
IF OBJECT_ID ('D_AddressFull') IS NOT NULL DROP TABLE D_AddressFull;
GO
-----SE CREA UNA TABLA CON ESE NOMBRE AUTOMATICAMENTE
SELECT A.AddressID, A.AddressLine1, A.AddressLine2, A.City, A.PostalCode,
SP.StateProvinceCode, SP.IsOnlyStateProvinceFlag, SP.[Name] StateProvinceName, SP.TerritoryID,
CR.[Name] CountryRegionName
INTO D_AddressFull
FROM AdventureWorks2022.[Person].[Address] A
INNER JOIN AdventureWorks2022.[Person].[StateProvince] SP ON A.StateProvinceID = SP.StateProvinceID -- A + SP
INNER JOIN AdventureWorks2022.[Person].[CountryRegion] CR ON SP.CountryRegionCode = CR.CountryRegionCode --SP + CR


--UNIR AT + BEA
--//D_AddressCustom
IF OBJECT_ID ('D_AddressCustom') IS NOT NULL DROP TABLE D_AddressCustom;
GO
---
SELECT BEA.BusinessEntityID, BEA.AddressID, AT.Name
INTO D_AddressCustom
FROM AdventureWorks2022.[Person].BusinessEntityAddress BEA
	INNER JOIN AdventureWorks2022.[Person].AddressType AT ON BEA.AddressTypeID = AT.AddressTypeID


--UNIR AT + BEA
IF OBJECT_ID ('D_ContactFull') IS NOT NULL DROP TABLE D_ContactFull;
GO

SELECT BEC.BusinessEntityID, BEC.PersonID, CT.Name
INTO D_ContactFull
FROM AdventureWorks2022.[Person].BusinessEntityContact BEC
	INNER JOIN AdventureWorks2022.[Person].[ContactType] CT ON BEC.ContactTypeID = CT.ContactTypeID




--UNIR PP + PNT
IF OBJECT_ID ('D_PersonPhoneFull') IS NOT NULL DROP TABLE D_PersonPhoneFull;
GO

SELECT PP.BusinessEntityID, PP.PhoneNumber, PNT.Name
INTO D_PersonPhoneFull
FROM AdventureWorks2022.[Person].[PersonPhone] PP
	INNER JOIN AdventureWorks2022.[Person].[PhoneNumberType] PNT 
	ON PP.PhoneNumberTypeID = PNT.PhoneNumberTypeID
	


--UNIR P + PW + EA
IF OBJECT_ID ('F_PersonFull') IS NOT NULL DROP TABLE F_PersonFull;
GO

SELECT P.BusinessEntityID, P.PersonType, P.NameStyle, P.Title, P.FirstName, P.MiddleName, P.LastName,
P.Suffix, P.EmailPromotion, PW.PasswordHash, 
EA.EmailAddressID, EA.EmailAddress
INTO F_PersonFull
FROM AdventureWorks2022.[Person].[Person] P
	INNER JOIN AdventureWorks2022.[Person].[Password] PW ON P.BusinessEntityID = PW.BusinessEntityID
	INNER JOIN AdventureWorks2022.[Person].[EmailAddress] EA ON P.BusinessEntityID = EA.BusinessEntityID


--------------------------------------------------------------------------------
----------------------------[Purchasing]----------------------------------------
--------------------------------------------------------------------------------

IF OBJECT_ID ('D_ProductVendor') IS NOT NULL DROP TABLE D_ProductVendor;
GO

SELECT *
INTO D_ProductVendor
FROM AdventureWorks2022.Purchasing.ProductVendor PV

----------------

IF OBJECT_ID ('D_PurchaseOrderDetail') IS NOT NULL DROP TABLE D_PurchaseOrderDetail;
GO

SELECT *
INTO D_PurchaseOrderDetail
FROM AdventureWorks2022.Purchasing.PurchaseOrderDetail POD


------------


IF OBJECT_ID ('F_PurchaseOrderHeader') IS NOT NULL DROP TABLE F_PurchaseOrderHeader;
GO

--UNIR POH + SH + V
SELECT POH.*, SH.Name ShipName, SH.ShipBase, SH.ShipRate, 
V.AccountNumber, V.Name VendorName, V.CreditRating, V.PreferredVendorStatus, V.ActiveFlag
INTO F_PurchaseOrderHeader
FROM AdventureWorks2022.Purchasing.PurchaseOrderHeader POH
INNER JOIN AdventureWorks2022.Purchasing.ShipMethod SH ON POH.ShipMethodID = SH.ShipMethodID
INNER JOIN AdventureWorks2022.Purchasing.Vendor V ON POH.VendorID = V.BusinessEntityID


