
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


SELECT A.AddressID, A.AddressLine1, A.AddressLine2, A.City, A.PostalCode,
SP.StateProvinceCode, SP.IsOnlyStateProvinceFlag, SP.[Name] StateProvinceName, SP.TerritoryID,
CR.[Name] CountryRegionName
FROM [Person].[Address] A
INNER JOIN [Person].[StateProvince] SP ON A.StateProvinceID = SP.StateProvinceID -- A + SP
INNER JOIN [Person].[CountryRegion] CR ON SP.CountryRegionCode = CR.CountryRegionCode --SP + CR


--UNIR AT + BEA
SELECT *
FROM [Person].BusinessEntityAddress BEA
	INNER JOIN [Person].AddressType AT ON BEA.AddressTypeID = AT.AddressTypeID

--UNIR AT + BEA
SELECT *
FROM [Person].BusinessEntityContact BEC
	INNER JOIN [Person].[ContactType] CT ON BEC.ContactTypeID = CT.ContactTypeID

--UNIR PP + PNT
SELECT * 
FROM [Person].[PersonPhone] PP
	INNER JOIN [Person].[PhoneNumberType] PNT 
	ON PP.PhoneNumberTypeID = PNT.PhoneNumberTypeID
	
--UNIR P + PW + EA
SELECT * 
FROM [Person].[Person] P
	INNER JOIN [Person].[Password] PW ON P.BusinessEntityID = PW.BusinessEntityID
	INNER JOIN [Person].[Password] EA ON P.BusinessEntityID = EA.BusinessEntityID