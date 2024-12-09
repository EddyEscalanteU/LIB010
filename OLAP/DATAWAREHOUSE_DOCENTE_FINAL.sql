

/*
CREATE DATABASE AdventureWorks2022_DW;
GO
*/
USE AdventureWorks2022_DW
GO

--------------------------------------------------------------------------------
----------------------------[HumanResources]------------------------------------
--------------------------------------------------------------------------------



--//F_EMPLEADO
IF OBJECT_ID ('F_EMPLEADO') IS NOT NULL DROP TABLE F_EMPLEADO;
GO
--
SELECT 
    BusinessEntityID AS ENTIDAD_NEGOCIO_ID,
    NationalIDNumber AS NUMERO_IDENTIFICACION_NACIONAL,
    LoginID AS LOGIN_ID,
    OrganizationNode AS NODO_ORGANIZACION,
    OrganizationLevel AS NIVEL_ORGANIZACION,
    JobTitle AS TITULO_TRABAJO,
    BirthDate AS FECHA_NACIMIENTO,
    MaritalStatus AS ESTADO_CIVIL,
    Gender AS GENERO,
    HireDate AS FECHA_CONTRATACION,
    SalariedFlag AS ES_ASALARIADO,
    VacationHours AS HORAS_VACACIONES,
    SickLeaveHours AS HORAS_AUSENCIA,
    CurrentFlag AS EMPLEADO_ACTUAL,
    ModifiedDate AS FECHA_MODIFICACION
INTO F_EMPLEADO
FROM AdventureWorks2022.[HumanResources].Employee;

--//D_CANDIDATO_TRABAJO
IF OBJECT_ID ('D_CANDIDATO_TRABAJO') IS NOT NULL DROP TABLE D_CANDIDATO_TRABAJO;
GO
--
SELECT 
    JobCandidateID AS CANDIDATO_ID,
    BusinessEntityID AS ENTIDAD_NEGOCIO_ID,
    CONVERT(NVARCHAR(MAX), Resume) AS TEXTO_CURRICULUM,
    ModifiedDate AS FECHA_MODIFICACION
INTO D_CANDIDATO_TRABAJO
FROM AdventureWorks2022.[HumanResources].JobCandidate;

--//D_HISTORIAL_PAGO_EMPLEADO
IF OBJECT_ID ('D_HISTORIAL_PAGO_EMPLEADO') IS NOT NULL DROP TABLE D_HISTORIAL_PAGO_EMPLEADO;
GO
--
SELECT 
    BusinessEntityID AS ENTIDAD_NEGOCIO_ID,
    RateChangeDate AS FECHA_CAMBIO_TARIFA,
    Rate AS TARIFA,
    PayFrequency AS FRECUENCIA_PAGO,
    ModifiedDate AS FECHA_MODIFICACION
INTO D_HISTORIAL_PAGO_EMPLEADO
FROM AdventureWorks2022.[HumanResources].EmployeePayHistory;

--//D_HISTORIAL_DEPARTAMENTO_EMPLEADO
IF OBJECT_ID ('D_HISTORIAL_DEPARTAMENTO_EMPLEADO') IS NOT NULL DROP TABLE D_HISTORIAL_DEPARTAMENTO_EMPLEADO;
GO
---
SELECT 
    EDH.BusinessEntityID AS ENTIDAD_NEGOCIO_ID,
    EDH.DepartmentID AS DEPARTAMENTO_ID,
    EDH.ShiftID AS TURNO_ID,
    EDH.StartDate AS FECHA_INICIO,
    EDH.EndDate AS FECHA_FIN,
    EDH.ModifiedDate AS FECHA_MODIFICACION,
    D.[Name] AS NOMBRE_DEPARTAMENTO,
    D.GroupName AS NOMBRE_GRUPO,
    S.[Name] AS NOMBRE_TURNO,
    S.StartTime AS HORA_INICIO_TURNO,
    S.EndTime AS HORA_FIN_TURNO
INTO D_HISTORIAL_DEPARTAMENTO_EMPLEADO
FROM AdventureWorks2022.[HumanResources].EmployeeDepartmentHistory EDH
    INNER JOIN AdventureWorks2022.[HumanResources].Department D 
        ON EDH.DepartmentID = D.DepartmentID
    INNER JOIN AdventureWorks2022.[HumanResources].[Shift] S 
        ON EDH.ShiftID = S.ShiftID;




		
--------------------------------------------------------------------------------
----------------------------[Person]--------------------------------------------
--------------------------------------------------------------------------------

--//D_ADDRESS_FULL
IF OBJECT_ID ('D_ADDRESS_FULL') IS NOT NULL DROP TABLE D_ADDRESS_FULL;
GO
--
SELECT 
    A.AddressID AS DIRECCION_ID,
    A.AddressLine1 AS LINEA_DIRECCION_1,
    A.AddressLine2 AS LINEA_DIRECCION_2,
    A.City AS CIUDAD,
    A.PostalCode AS CODIGO_POSTAL,
    SP.StateProvinceCode AS CODIGO_PROVINCIA_ESTADO,
    SP.IsOnlyStateProvinceFlag AS ES_UNICA_PROVINCIA,
    SP.[Name] AS NOMBRE_PROVINCIA_ESTADO,
    SP.TerritoryID AS TERRITORIO_ID,
    CR.[Name] AS NOMBRE_PAIS_REGION
INTO D_ADDRESS_FULL
FROM AdventureWorks2022.[Person].[Address] A
    INNER JOIN AdventureWorks2022.[Person].[StateProvince] SP ON A.StateProvinceID = SP.StateProvinceID
    INNER JOIN AdventureWorks2022.[Person].[CountryRegion] CR ON SP.CountryRegionCode = CR.CountryRegionCode;

--//D_ADDRESS_CUSTOM
IF OBJECT_ID ('D_ADDRESS_CUSTOM') IS NOT NULL DROP TABLE D_ADDRESS_CUSTOM;
GO
--
SELECT 
    BEA.BusinessEntityID AS ENTIDAD_NEGOCIO_ID,
    BEA.AddressID AS DIRECCION_ID,
    AT.Name AS NOMBRE_TIPO_DIRECCION
INTO D_ADDRESS_CUSTOM
FROM AdventureWorks2022.[Person].BusinessEntityAddress BEA
    INNER JOIN AdventureWorks2022.[Person].AddressType AT ON BEA.AddressTypeID = AT.AddressTypeID;

--//D_CONTACT_FULL
IF OBJECT_ID ('D_CONTACT_FULL') IS NOT NULL DROP TABLE D_CONTACT_FULL;
GO
--
SELECT 
    BEC.BusinessEntityID AS ENTIDAD_NEGOCIO_ID,
    BEC.PersonID AS PERSONA_ID,
    CT.Name AS NOMBRE_TIPO_CONTACTO
INTO D_CONTACT_FULL
FROM AdventureWorks2022.[Person].BusinessEntityContact BEC
    INNER JOIN AdventureWorks2022.[Person].[ContactType] CT ON BEC.ContactTypeID = CT.ContactTypeID;

--//D_PERSON_PHONE_FULL
IF OBJECT_ID ('D_PERSON_PHONE_FULL') IS NOT NULL DROP TABLE D_PERSON_PHONE_FULL;
GO
--
SELECT 
    PP.BusinessEntityID AS ENTIDAD_NEGOCIO_ID,
    PP.PhoneNumber AS NUMERO_TELEFONO,
    PNT.Name AS NOMBRE_TIPO_TELEFONO
INTO D_PERSON_PHONE_FULL
FROM AdventureWorks2022.[Person].[PersonPhone] PP
    INNER JOIN AdventureWorks2022.[Person].[PhoneNumberType] PNT 
    ON PP.PhoneNumberTypeID = PNT.PhoneNumberTypeID;

--//F_PERSON_FULL
IF OBJECT_ID ('F_PERSON_FULL') IS NOT NULL DROP TABLE F_PERSON_FULL;
GO
--
SELECT 
    P.BusinessEntityID AS ENTIDAD_NEGOCIO_ID,
    P.PersonType AS TIPO_PERSONA,
    P.NameStyle AS ESTILO_NOMBRE,
    P.Title AS TITULO,
    P.FirstName AS PRIMER_NOMBRE,
    P.MiddleName AS SEGUNDO_NOMBRE,
    P.LastName AS APELLIDO,
    P.Suffix AS SUFIJO,
    P.EmailPromotion AS PROMOCION_CORREO,
    PW.PasswordHash AS HASH_CONTRASENA,
    EA.EmailAddressID AS CORREO_ID,
    EA.EmailAddress AS DIRECCION_CORREO
INTO F_PERSON_FULL
FROM AdventureWorks2022.[Person].[Person] P
    INNER JOIN AdventureWorks2022.[Person].[Password] PW ON P.BusinessEntityID = PW.BusinessEntityID
    INNER JOIN AdventureWorks2022.[Person].[EmailAddress] EA ON P.BusinessEntityID = EA.BusinessEntityID;

	
--------------------------------------------------------------------------------
----------------------------[Purchasing]----------------------------------------
--------------------------------------------------------------------------------

--//D_PRODUCTO_PROVEEDOR
IF OBJECT_ID ('D_PRODUCTO_PROVEEDOR') IS NOT NULL DROP TABLE D_PRODUCTO_PROVEEDOR;
GO
--
SELECT 
    PV.ProductID AS PRODUCTO_ID,
    PV.BusinessEntityID AS PROVEEDOR_ID,
    PV.AverageLeadTime AS TIEMPO_PROMEDIO_ENTREGA,
    PV.StandardPrice AS PRECIO_ESTANDAR,
    PV.LastReceiptCost AS COSTO_ULTIMA_RECEPCION,
    PV.LastReceiptDate AS FECHA_ULTIMA_RECEPCION,
    PV.MinOrderQty AS CANTIDAD_MINIMA_PEDIDO,
    PV.MaxOrderQty AS CANTIDAD_MAXIMA_PEDIDO,
    PV.OnOrderQty AS CANTIDAD_EN_PEDIDO,
    PV.UnitMeasureCode AS CODIGO_UNIDAD_MEDIDA,
    PV.ModifiedDate AS FECHA_MODIFICACION
INTO D_PRODUCTO_PROVEEDOR
FROM AdventureWorks2022.Purchasing.ProductVendor PV;

--//D_DETALLE_ORDEN_COMPRA
IF OBJECT_ID ('D_DETALLE_ORDEN_COMPRA') IS NOT NULL DROP TABLE D_DETALLE_ORDEN_COMPRA;
GO
--
SELECT 
    POD.PurchaseOrderID AS ORDEN_COMPRA_ID,
    POD.PurchaseOrderDetailID AS DETALLE_ORDEN_ID,
    POD.DueDate AS FECHA_ENTREGA,
    POD.OrderQty AS CANTIDAD_PEDIDA,
    POD.ProductID AS PRODUCTO_ID,
    POD.UnitPrice AS PRECIO_UNITARIO,
    POD.LineTotal AS TOTAL_LINEA,
    POD.ReceivedQty AS CANTIDAD_RECIBIDA,
    POD.RejectedQty AS CANTIDAD_RECHAZADA,
    POD.StockedQty AS CANTIDAD_ALMACENADA,
    POD.ModifiedDate AS FECHA_MODIFICACION
INTO D_DETALLE_ORDEN_COMPRA
FROM AdventureWorks2022.Purchasing.PurchaseOrderDetail POD;

--//F_ORDEN_COMPRA
IF OBJECT_ID ('F_ORDEN_COMPRA') IS NOT NULL DROP TABLE F_ORDEN_COMPRA;
GO
--
-- UNIR POH + SH + V
SELECT 
    POH.PurchaseOrderID AS ORDEN_COMPRA_ID,
    POH.RevisionNumber AS NUMERO_REVISION,
    POH.Status AS ESTADO,
    POH.EmployeeID AS EMPLEADO_ID,
    POH.VendorID AS PROVEEDOR_ID,
    POH.ShipMethodID AS METODO_ENVIO_ID,
    POH.OrderDate AS FECHA_ORDEN,
    POH.ShipDate AS FECHA_ENVIO,
    POH.SubTotal AS SUBTOTAL,
    POH.TaxAmt AS MONTO_IMPUESTO,
    POH.Freight AS COSTO_ENVIO,
    POH.TotalDue AS TOTAL_A_PAGAR,
    POH.ModifiedDate AS FECHA_MODIFICACION,
    SH.Name AS NOMBRE_METODO_ENVIO,
    SH.ShipBase AS BASE_ENVIO,
    SH.ShipRate AS TARIFA_ENVIO,
    V.AccountNumber AS NUMERO_CUENTA,
    V.Name AS NOMBRE_PROVEEDOR,
    V.CreditRating AS CALIFICACION_CREDITO,
    V.PreferredVendorStatus AS ESTADO_PROVEEDOR_PREFERIDO,
    V.ActiveFlag AS PROVEEDOR_ACTIVO
INTO F_ORDEN_COMPRA
FROM AdventureWorks2022.Purchasing.PurchaseOrderHeader POH
INNER JOIN AdventureWorks2022.Purchasing.ShipMethod SH ON POH.ShipMethodID = SH.ShipMethodID
INNER JOIN AdventureWorks2022.Purchasing.Vendor V ON POH.VendorID = V.BusinessEntityID;



--------------------------------------------------------------------------------
----------------------------[Sales]----------------------------------------
--------------------------------------------------------------------------------

--//D_PAIS_REGION_MONEDA
IF OBJECT_ID ('D_PAIS_REGION_MONEDA') IS NOT NULL DROP TABLE D_PAIS_REGION_MONEDA;
GO
--
SELECT 
    CRC.CountryRegionCode AS CODIGO_PAIS_REGION,
    CRC.CurrencyCode AS CODIGO_MONEDA,
    CRC.ModifiedDate AS FECHA_MODIFICACION
INTO D_PAIS_REGION_MONEDA
FROM AdventureWorks2022.Sales.CountryRegionCurrency CRC;

--//D_TARJETA_CREDITO
IF OBJECT_ID ('D_TARJETA_CREDITO') IS NOT NULL DROP TABLE D_TARJETA_CREDITO;
GO
--
SELECT 
    CC.CreditCardID AS TARJETA_ID,
    CC.CardType AS TIPO_TARJETA,
    CC.CardNumber AS NUMERO_TARJETA,
    CC.ExpMonth AS MES_EXPIRACION,
    CC.ExpYear AS A�O_EXPIRACION,
    CC.ModifiedDate AS FECHA_MODIFICACION
INTO D_TARJETA_CREDITO
FROM AdventureWorks2022.Sales.CreditCard CC;

--//D_MONEDA
IF OBJECT_ID ('D_MONEDA') IS NOT NULL DROP TABLE D_MONEDA;
GO
--
SELECT 
    C.CurrencyCode AS CODIGO_MONEDA,
    C.Name AS NOMBRE_MONEDA,
    C.ModifiedDate AS FECHA_MODIFICACION
INTO D_MONEDA
FROM AdventureWorks2022.Sales.Currency C;

--//D_TIPO_CAMBIO
IF OBJECT_ID ('D_TIPO_CAMBIO') IS NOT NULL DROP TABLE D_TIPO_CAMBIO;
GO
--
SELECT 
    CR.CurrencyRateID AS TIPO_CAMBIO_ID,
    CR.CurrencyRateDate AS FECHA_TIPO_CAMBIO,
    CR.FromCurrencyCode AS CODIGO_MONEDA_ORIGEN,
    CR.ToCurrencyCode AS CODIGO_MONEDA_DESTINO,
    CR.AverageRate AS TASA_PROMEDIO,
    CR.EndOfDayRate AS TASA_FIN_DIA,
    CR.ModifiedDate AS FECHA_MODIFICACION
INTO D_TIPO_CAMBIO
FROM AdventureWorks2022.Sales.CurrencyRate CR;

--//D_CLIENTE
IF OBJECT_ID ('D_CLIENTE') IS NOT NULL DROP TABLE D_CLIENTE;
GO
--
SELECT 
    C.CustomerID AS CLIENTE_ID,
    C.PersonID AS PERSONA_ID,
    C.StoreID AS TIENDA_ID,
    C.TerritoryID AS TERRITORIO_ID,
    C.AccountNumber AS NUMERO_CUENTA,
    C.ModifiedDate AS FECHA_MODIFICACION
INTO D_CLIENTE
FROM AdventureWorks2022.Sales.Customer C;

--//D_PERSONA_TARJETA_CREDITO
IF OBJECT_ID ('D_PERSONA_TARJETA_CREDITO') IS NOT NULL DROP TABLE D_PERSONA_TARJETA_CREDITO;
GO
--
SELECT 
    PC.BusinessEntityID AS ENTIDAD_NEGOCIO_ID,
    PC.CreditCardID AS TARJETA_ID,
    PC.ModifiedDate AS FECHA_MODIFICACION
INTO D_PERSONA_TARJETA_CREDITO
FROM AdventureWorks2022.Sales.PersonCreditCard PC;

--//F_DETALLE_ORDEN_VENTA
IF OBJECT_ID ('F_DETALLE_ORDEN_VENTA') IS NOT NULL DROP TABLE F_DETALLE_ORDEN_VENTA;
GO
--
SELECT 
    SOD.SalesOrderID AS ORDEN_VENTA_ID,
    SOD.SalesOrderDetailID AS DETALLE_ORDEN_ID,
    SOD.CarrierTrackingNumber AS NUMERO_SEGUIMIENTO,
    SOD.OrderQty AS CANTIDAD_PEDIDA,
    SOD.ProductID AS PRODUCTO_ID,
    SOD.SpecialOfferID AS OFERTA_ID,
    SOD.UnitPrice AS PRECIO_UNITARIO,
    SOD.UnitPriceDiscount AS DESCUENTO_PRECIO_UNITARIO,
    SOD.LineTotal AS TOTAL_LINEA,
    SOD.ModifiedDate AS FECHA_MODIFICACION
INTO F_DETALLE_ORDEN_VENTA
FROM AdventureWorks2022.Sales.SalesOrderDetail SOD;

--//F_ORDEN_VENTA
IF OBJECT_ID ('F_ORDEN_VENTA') IS NOT NULL DROP TABLE F_ORDEN_VENTA;
GO
--
SELECT 
    SOH.SalesOrderID AS ORDEN_VENTA_ID,
    SOH.RevisionNumber AS NUMERO_REVISION,
    SOH.OrderDate AS FECHA_ORDEN,
    SOH.DueDate AS FECHA_ENTREGA,
    SOH.ShipDate AS FECHA_ENVIO,
    SOH.Status AS ESTADO,
    SOH.OnlineOrderFlag AS ORDEN_EN_LINEA,
    SOH.SalesOrderNumber AS NUMERO_ORDEN,
    SOH.PurchaseOrderNumber AS NUMERO_COMPRA,
    SOH.AccountNumber AS NUMERO_CUENTA,
    SOH.CustomerID AS CLIENTE_ID,
    SOH.SalesPersonID AS VENDEDOR_ID,
    SOH.TerritoryID AS TERRITORIO_ID,
    SOH.ShipMethodID AS METODO_ENVIO_ID,
    SOH.CreditCardID AS TARJETA_ID,
    SOH.SubTotal AS SUBTOTAL,
    SOH.TaxAmt AS MONTO_IMPUESTO,
    SOH.Freight AS COSTO_ENVIO,
    SOH.TotalDue AS TOTAL_A_PAGAR,
    SOH.Comment AS COMENTARIO,
    SOH.ModifiedDate AS FECHA_MODIFICACION
INTO F_ORDEN_VENTA
FROM AdventureWorks2022.Sales.SalesOrderHeader SOH;

--//D_VENDEDOR
IF OBJECT_ID ('D_VENDEDOR') IS NOT NULL DROP TABLE D_VENDEDOR;
GO
--
SELECT 
    SP.BusinessEntityID AS VENDEDOR_ID,
    SP.TerritoryID AS TERRITORIO_ID,
    SP.SalesQuota AS CUOTA_VENTAS,
    SP.Bonus AS BONO,
    SP.CommissionPct AS PORCENTAJE_COMISION,
    SP.SalesYTD AS VENTAS_ANUAL_ACUMULADO,
    SP.SalesLastYear AS VENTAS_ULTIMO_A�O,
    SP.ModifiedDate AS FECHA_MODIFICACION
INTO D_VENDEDOR
FROM AdventureWorks2022.Sales.SalesPerson SP;

--//D_TIENDAS
IF OBJECT_ID ('D_TIENDAS') IS NOT NULL DROP TABLE D_TIENDAS;
GO
--
SELECT 
    S.BusinessEntityID AS TIENDA_ID,
    S.Name AS NOMBRE_TIENDA,
    S.SalesPersonID AS VENDEDOR_ID,
    S.ModifiedDate AS FECHA_MODIFICACION
INTO D_TIENDAS
FROM AdventureWorks2022.Sales.Store S;





--------------------------------------------------------------------------------
----------------------------[Production]----------------------------------------
--------------------------------------------------------------------------------

--//D_LISTA_MATERIALES
IF OBJECT_ID ('D_LISTA_MATERIALES') IS NOT NULL DROP TABLE D_LISTA_MATERIALES;
GO
--
SELECT 
    BOM.BillOfMaterialsID AS LISTA_MATERIALES_ID,
    BOM.ProductAssemblyID AS ENSAMBLADO_PRODUCTO_ID,
    BOM.ComponentID AS COMPONENTE_ID,
    BOM.StartDate AS FECHA_INICIO,
    BOM.EndDate AS FECHA_FIN,
    BOM.BOMLevel AS NIVEL_LISTA,
    BOM.PerAssemblyQty AS CANTIDAD_POR_ENSAMBLADO,
    BOM.ModifiedDate AS FECHA_MODIFICACION
INTO D_LISTA_MATERIALES
FROM AdventureWorks2022.Production.BillOfMaterials BOM;

--//D_CULTURA
IF OBJECT_ID ('D_CULTURA') IS NOT NULL DROP TABLE D_CULTURA;
GO
--
SELECT 
    C.CultureID AS CULTURA_ID,
    C.Name AS NOMBRE_CULTURA,
    C.ModifiedDate AS FECHA_MODIFICACION
INTO D_CULTURA
FROM AdventureWorks2022.Production.Culture C;

--//D_DOCUMENTO
IF OBJECT_ID ('D_DOCUMENTO') IS NOT NULL DROP TABLE D_DOCUMENTO;
GO
--
SELECT 
    D.DocumentNode AS DOCUMENTO_ID,
    D.Title AS TITULO,
    D.FileName AS NOMBRE_ARCHIVO,
    D.FileExtension AS EXTENSION_ARCHIVO,
    D.Revision AS REVISION,
    D.ChangeNumber AS NUMERO_CAMBIO,
    D.DocumentSummary AS RESUMEN_DOCUMENTO,
    D.ModifiedDate AS FECHA_MODIFICACION
INTO D_DOCUMENTO
FROM AdventureWorks2022.Production.Document D;

--//D_ILUSTRACION
IF OBJECT_ID ('D_ILUSTRACION') IS NOT NULL DROP TABLE D_ILUSTRACION;
GO
--
SELECT 
    I.IllustrationID AS ILUSTRACION_ID,
    CONVERT(NVARCHAR(MAX), I.Diagram) AS DIAGRAMA,
    I.ModifiedDate AS FECHA_MODIFICACION
INTO D_ILUSTRACION
FROM AdventureWorks2022.Production.Illustration I;

--//D_UBICACION
IF OBJECT_ID ('D_UBICACION') IS NOT NULL DROP TABLE D_UBICACION;
GO
--
SELECT 
    L.LocationID AS UBICACION_ID,
    L.Name AS NOMBRE_UBICACION,
    L.CostRate AS TASA_COSTO,
    L.Availability AS DISPONIBILIDAD,
    L.ModifiedDate AS FECHA_MODIFICACION
INTO D_UBICACION
FROM AdventureWorks2022.Production.Location L;

--//D_PRODUCTO
IF OBJECT_ID ('D_PRODUCTO') IS NOT NULL DROP TABLE D_PRODUCTO;
GO
--
SELECT 
    P.ProductID AS PRODUCTO_ID,
    P.Name AS NOMBRE_PRODUCTO,
    P.ProductNumber AS NUMERO_PRODUCTO,
    P.MakeFlag AS BANDERA_FABRICACION,
    P.FinishedGoodsFlag AS BANDERA_PRODUCTO_TERMINADO,
    P.Color AS COLOR,
    P.StandardCost AS COSTO_ESTANDAR,
    P.ListPrice AS PRECIO_LISTA,
    P.Size AS TAMA�O,
    P.Weight AS PESO,
    P.ProductSubcategoryID AS CATEGORIA_ID,
    P.ProductModelID AS MODELO_ID,
    P.SellStartDate AS FECHA_INICIO_VENTA,
    P.SellEndDate AS FECHA_FIN_VENTA,
    P.DiscontinuedDate AS FECHA_DISCONTINUADA,
    P.ModifiedDate AS FECHA_MODIFICACION
INTO D_PRODUCTO
FROM AdventureWorks2022.Production.Product P;

--//D_CATEGORIA_PRODUCTO
IF OBJECT_ID ('D_CATEGORIA_PRODUCTO') IS NOT NULL DROP TABLE D_CATEGORIA_PRODUCTO;
GO
--
SELECT 
    PC.ProductCategoryID AS CATEGORIA_ID,
    PC.Name AS NOMBRE_CATEGORIA,
    PC.ModifiedDate AS FECHA_MODIFICACION
INTO D_CATEGORIA_PRODUCTO
FROM AdventureWorks2022.Production.ProductCategory PC;

--//D_HISTORIAL_COSTO_PRODUCTO
IF OBJECT_ID ('D_HISTORIAL_COSTO_PRODUCTO') IS NOT NULL DROP TABLE D_HISTORIAL_COSTO_PRODUCTO;
GO
--
SELECT 
    PCH.ProductID AS PRODUCTO_ID,
    PCH.StartDate AS FECHA_INICIO,
    PCH.EndDate AS FECHA_FIN,
    PCH.StandardCost AS COSTO_ESTANDAR,
    PCH.ModifiedDate AS FECHA_MODIFICACION
INTO D_HISTORIAL_COSTO_PRODUCTO
FROM AdventureWorks2022.Production.ProductCostHistory PCH;

--//D_DESCRIPCION_PRODUCTO
IF OBJECT_ID ('D_DESCRIPCION_PRODUCTO') IS NOT NULL DROP TABLE D_DESCRIPCION_PRODUCTO;
GO
--
SELECT 
    PD.ProductDescriptionID AS DESCRIPCION_ID,
    PD.Description AS DESCRIPCION,
    PD.ModifiedDate AS FECHA_MODIFICACION
INTO D_DESCRIPCION_PRODUCTO
FROM AdventureWorks2022.Production.ProductDescription PD;

--//D_INVENTARIO_PRODUCTO
IF OBJECT_ID ('D_INVENTARIO_PRODUCTO') IS NOT NULL DROP TABLE D_INVENTARIO_PRODUCTO;
GO
--
SELECT 
    PI.ProductID AS PRODUCTO_ID,
    PI.LocationID AS UBICACION_ID,
    PI.Quantity AS CANTIDAD,
    PI.Shelf AS ESTANTE,
    PI.Bin AS CAJA,
    PI.ModifiedDate AS FECHA_MODIFICACION
INTO D_INVENTARIO_PRODUCTO
FROM AdventureWorks2022.Production.ProductInventory PI;

--//F_HISTORIAL_TRANSACCION
IF OBJECT_ID ('F_HISTORIAL_TRANSACCION') IS NOT NULL DROP TABLE F_HISTORIAL_TRANSACCION;
GO
--
SELECT 
    TH.TransactionID AS TRANSACCION_ID,
    TH.ProductID AS PRODUCTO_ID,
    TH.ReferenceOrderID AS ORDEN_REFERENCIA_ID,
    TH.ReferenceOrderLineID AS LINEA_REFERENCIA_ID,
    TH.TransactionDate AS FECHA_TRANSACCION,
    TH.TransactionType AS TIPO_TRANSACCION,
    TH.Quantity AS CANTIDAD,
    TH.ActualCost AS COSTO_REAL,
    TH.ModifiedDate AS FECHA_MODIFICACION
INTO F_HISTORIAL_TRANSACCION
FROM AdventureWorks2022.Production.TransactionHistory TH;

--//D_RAZON_DESPERDICIO
IF OBJECT_ID ('D_RAZON_DESPERDICIO') IS NOT NULL DROP TABLE D_RAZON_DESPERDICIO;
GO
--
SELECT 
    SR.ScrapReasonID AS RAZON_DESPERDICIO_ID,
    SR.Name AS NOMBRE_RAZON,
    SR.ModifiedDate AS FECHA_MODIFICACION
INTO D_RAZON_DESPERDICIO
FROM AdventureWorks2022.Production.ScrapReason SR;

--//F_ORDEN_TRABAJO
IF OBJECT_ID ('F_ORDEN_TRABAJO') IS NOT NULL DROP TABLE F_ORDEN_TRABAJO;
GO
--
SELECT 
    WO.WorkOrderID AS ORDEN_TRABAJO_ID,
    WO.ProductID AS PRODUCTO_ID,
    WO.OrderQty AS CANTIDAD_ORDENADA,
    WO.StockedQty AS CANTIDAD_ALMACENADA,
    WO.ScrappedQty AS CANTIDAD_DESPERDICIADA,
    WO.StartDate AS FECHA_INICIO,
    WO.EndDate AS FECHA_FIN,
    WO.DueDate AS FECHA_ENTREGA,
    WO.ModifiedDate AS FECHA_MODIFICACION
INTO F_ORDEN_TRABAJO
FROM AdventureWorks2022.Production.WorkOrder WO;

