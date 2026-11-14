-- Question 1
-- 1a
Select PP.BusinessEntityID as EmployeeID, 
Count(HEDH.DepartmentID) as NoOfEmployees, 
Concat_WS(' ', PP.FirstName, PP.MiddleName, PP.LastName) as FullName,
HE.JobTitle, HRD.Name as DepartmentName, 
HEDH.StartDate as DepartmentStartDate
from Person_Person as PP
Join HumanResources_Employee as HE
On PP.BusinessEntityID = HE.BusinessEntityID
Join HumanResources_EmployeeDepartmentHistory as HEDH
On HE.BusinessEntityID  = HEDH.BusinessEntityID
Join HumanResources_Department as HRD
On HEDH.DepartmentID = HRD.DepartmentID
Group by PP.BusinessEntityID, Concat_WS(' ', PP.FirstName, PP.MiddleName, PP.LastName),
HE.JobTitle, HRD.Name, HEDH.StartDate;

-- 1b
Select PP.BusinessEntityID as EmployeeID, 
Count(HEDH.DepartmentID) as NoOfEmployees, 
Concat_WS(' ', PP.FirstName, PP.MiddleName, PP.LastName) as FullName,
HE.JobTitle, HRD.Name as DepartmentName, 
HEDH.StartDate as DepartmentStartDate
from Person_Person as PP
Join HumanResources_Employee as HE
On PP.BusinessEntityID = HE.BusinessEntityID
Join HumanResources_EmployeeDepartmentHistory as HEDH
On HE.BusinessEntityID  = HEDH.BusinessEntityID
Join HumanResources_Department as HRD
On HEDH.DepartmentID = HRD.DepartmentID
Where HEDH.EndDate is NULL
Group by PP.BusinessEntityID, Concat_WS(' ', PP.FirstName, PP.MiddleName, PP.LastName),
HE.JobTitle, HRD.Name, HEDH.StartDate;

-- 1c	
Select PP.BusinessEntityID as EmployeeID, 
Count(HEDH.DepartmentID) as NoOfEmployees, 
Concat_WS(' ', PP.FirstName, PP.MiddleName, PP.LastName) as FullName,
HE.JobTitle, HRD.Name as DepartmentName, 
HEDH.StartDate as DepartmentStartDate
from Person_Person as PP
Join HumanResources_Employee as HE
On PP.BusinessEntityID = HE.BusinessEntityID
Join HumanResources_EmployeeDepartmentHistory as HEDH
On HE.BusinessEntityID  = HEDH.BusinessEntityID
Join HumanResources_Department as HRD
On HEDH.DepartmentID = HRD.DepartmentID
Where HEDH.EndDate is NULL
Group by HRD.Name, HEDH.StartDate;

-- 1d
Select PP.BusinessEntityID as EmployeeID, 
Count(HEDH.DepartmentID) as NoOfEmployees, 
HRD.Name as DepartmentName
from Person_Person as PP
Join HumanResources_Employee as HE
On PP.BusinessEntityID = HE.BusinessEntityID
Join HumanResources_EmployeeDepartmentHistory as HEDH
On HE.BusinessEntityID  = HEDH.BusinessEntityID
Join HumanResources_Department as HRD
On HEDH.DepartmentID = HRD.DepartmentID
Where HEDH.EndDate is NULL
Group by PP.BusinessEntityID, HRD.Name
Order by NoOfEmployees desc;

-- Question 2
-- 2a
Select P.Name as ProductName, PC.Name as ProductCategory, PS.Name as ProductSubcategory,
Sum(SOD.OrderQty) as TotalQuantitySold
from Production_Product as P
Join Production_ProductSubcategory as PS
On P.ProductSubcategoryID = PS.ProductSubcategoryID
Join Production_ProductCategory as PC
On PS.ProductCategoryID = PC.ProductCategoryID
Join Sales_SalesOrderDetail as SOD
On P.ProductID = SOD.ProductID
Group by P.Name, PC.Name, PS.Name;


-- 2b
Select P.Name as ProductName, PC.Name as ProductCategory, PS.Name as ProductSubcategory,
Sum(SOD.OrderQty) as TotalQuantitySold, Round(Sum(SOD.LineTotal),2) as TotalSalesRevenue
from Sales_SalesOrderDetail as SOD 
Join Sales_SalesOrderHeader as SOH
On SOD.SalesOrderID = SOH.SalesOrderID
Join Production_Product as P
On P.ProductID = SOD.ProductID
Join Production_ProductSubcategory as PS
On P.ProductSubcategoryID = PS.ProductSubcategoryID
Join Production_ProductCategory as PC
On PS.ProductCategoryID = PC.ProductCategoryID
Group by P.Name, PC.Name, PS.Name;

-- 2c
Select P.Name as ProductName, PC.Name as ProductCategory, PS.Name as ProductSubcategory,
Round(Avg(SOD.LineTotal/SOD.OrderQty),2) as AvgSellingPricePerUnit
from Sales_SalesOrderDetail as SOD 
Join Sales_SalesOrderHeader as SOH
On SOD.SalesOrderID = SOH.SalesOrderID
Join Production_Product as P
On P.ProductID = SOD.ProductID
Join Production_ProductSubcategory as PS
On P.ProductSubcategoryID = PS.ProductSubcategoryID
Join Production_ProductCategory as PC
On PS.ProductCategoryID = PC.ProductCategoryID
Group by P.Name, PC.Name, PS.Name;

-- 2d
Select P.Name as ProductName, PC.Name as ProductCategory, PS.Name as ProductSubcategory,
Round(Sum(SOD.LineTotal),2) as TotalSalesRevenue
from Sales_SalesOrderDetail as SOD 
Join Sales_SalesOrderHeader as SOH
On SOD.SalesOrderID = SOH.SalesOrderID
Join Production_Product as P
On P.ProductID = SOD.ProductID
Join Production_ProductSubcategory as PS
On P.ProductSubcategoryID = PS.ProductSubcategoryID
Join Production_ProductCategory as PC
On PS.ProductCategoryID = PC.ProductCategoryID
Group by P.Name, PC.Name, PS.Name
Order by TotalSalesRevenue desc
Limit 10;

-- 2e
Select P.Name as ProductName, 
PC.Name as ProductCategory, 
PS.Name as ProductSubcategory,
Sum(SOD.OrderQty) as QuantitySold, 
Round(Avg(SOD.LineTotal/SOD.OrderQty),2) as AvgSellingPrice,
Round(Sum(SOD.LineTotal),2) as TotalRevenue
from Sales_SalesOrderDetail as SOD 
Join Sales_SalesOrderHeader as SOH
On SOD.SalesOrderID = SOH.SalesOrderID
Join Production_Product as P
On P.ProductID = SOD.ProductID
Join Production_ProductSubcategory as PS
On P.ProductSubcategoryID = PS.ProductSubcategoryID
Join Production_ProductCategory as PC
On PS.ProductCategoryID = PC.ProductCategoryID
Group by P.Name, PC.Name, PS.Name
Order by TotalRevenue desc;

-- Question 3

-- 3a
Select SC.CustomerID, 
Concat_WS(' ', PP.FirstName, PP.MiddleName, PP.LastName) as FullName
from Sales_SalesOrderDetail as SOD 
Join Sales_SalesOrderHeader as SOH
On SOD.SalesOrderID = SOH.SalesOrderID
Join Sales_Customer as SC
On SOH.CustomerID = SC.CustomerID
Join Person_Person as PP
On SC.PersonID = PP.BusinessEntityID;

-- 3c
Select SC.CustomerID, 
Concat_WS(' ', PP.FirstName, PP.MiddleName, PP.LastName) as FullName,
Sum(OrderQty) as TotalOrders, 
Round(Sum(LineTotal),2)as TotalSalesValue
from Sales_SalesOrderDetail as SOD 
Join Sales_SalesOrderHeader as SOH
On SOD.SalesOrderID = SOH.SalesOrderID
Join Sales_Customer as SC
On SOH.CustomerID = SC.CustomerID
Join Person_Person as PP
On SC.PersonID = PP.BusinessEntityID
Group by SC.CustomerID, 
Concat_WS(' ', PP.FirstName, PP.MiddleName, PP.LastName);

-- 3d
Select SC.CustomerID, 
Concat_WS(' ', PP.FirstName, PP.MiddleName, PP.LastName) as FullName,
Sum(OrderQty) as TotalOrders, 
Round(Sum(LineTotal),2)as TotalSalesValue,
Round(Avg(LineTotal),2) as AvgSalesValue
from Sales_SalesOrderDetail as SOD 
Join Sales_SalesOrderHeader as SOH
On SOD.SalesOrderID = SOH.SalesOrderID
Join Sales_Customer as SC
On SOH.CustomerID = SC.CustomerID
Join Person_Person as PP
On SC.PersonID = PP.BusinessEntityID
Group by SC.CustomerID, 
Concat_WS(' ', PP.FirstName, PP.MiddleName, PP.LastName)
Having Sum(OrderQty) > 10 and Avg(LineTotal) >1000;

-- 3e
Select SC.CustomerID, 
Concat_WS(' ', PP.FirstName, PP.MiddleName, PP.LastName) as FullName,
Sum(OrderQty) as TotalOrders, 
Round(Sum(LineTotal),2)as TotalSalesValue,
Round(Avg(LineTotal),2) as AvgSalesValue
from Sales_SalesOrderDetail as SOD 
Join Sales_SalesOrderHeader as SOH
On SOD.SalesOrderID = SOH.SalesOrderID
Join Sales_Customer as SC
On SOH.CustomerID = SC.CustomerID
Join Person_Person as PP
On SC.PersonID = PP.BusinessEntityID
Group by SC.CustomerID, 
Concat_WS(' ', PP.FirstName, PP.MiddleName, PP.LastName)
Having Sum(OrderQty) > 10 and Avg(LineTotal) >1000
Order by TotalSalesValue desc;

-- Question 4
-- 4a
Select Concat_WS(' ', PP.FirstName, PP.MiddleName, PP.LastName) as FullName, 
HE.JobTitle, 
SPQ.SalesQuota, 
SP.SalesYTD, 
SP.SalesLastYear
from person_person as PP
Join humanresources_employee as HE
On PP.BusinessEntityID = HE.BusinessEntityID
Join sales_salespersonquotahistory as SPQ
On HE.BusinessEntityID = SPQ.BusinessEntityID
Join sales_salesperson as SP
On SPQ.BusinessEntityID = SP.BusinessEntityID;

-- 4b
Select Concat_WS(' ', PP.FirstName, PP.MiddleName, PP.LastName) as FullName, 
HE.JobTitle, 
SP.SalesYTD-SPQ.SalesQuota as QuotaDifference
from person_person as PP
Join humanresources_employee as HE
On PP.BusinessEntityID = HE.BusinessEntityID
Join sales_salespersonquotahistory as SPQ
On HE.BusinessEntityID = SPQ.BusinessEntityID
Join sales_salesperson as SP
On SPQ.BusinessEntityID = SP.BusinessEntityID;

-- 4c
Select Concat_WS(' ', PP.FirstName, PP.MiddleName, PP.LastName) as FullName, 
HE.JobTitle, 
SPQ.SalesQuota, 
SP.SalesYTD,
(SP.SalesYTD/SPQ.SalesQuota *100) as PerformanceCategory
from person_person as PP
Join humanresources_employee as HE
On PP.BusinessEntityID = HE.BusinessEntityID
Join sales_salespersonquotahistory as SPQ
On HE.BusinessEntityID = SPQ.BusinessEntityID
Join sales_salesperson as SP
On SPQ.BusinessEntityID = SP.BusinessEntityID;

-- 4d
Select Concat_WS(' ', PP.FirstName, PP.MiddleName, PP.LastName) as FullName, 
HE.JobTitle, 
Case when SP.SalesYTD>= SPQ.SalesQuota 
Then 'Quota Met'
Else 'Quota Not Met'
End as 'QuotaStatus'
from person_person as PP
Join humanresources_employee as HE
On PP.BusinessEntityID = HE.BusinessEntityID
Join sales_salespersonquotahistory as SPQ
On HE.BusinessEntityID = SPQ.BusinessEntityID
Join sales_salesperson as SP
On SPQ.BusinessEntityID = SP.BusinessEntityID;

-- 4e
Select Concat_WS(' ', PP.FirstName, PP.MiddleName, PP.LastName) as FullName, 
HE.JobTitle, 
SPQ.SalesQuota, 
SP.SalesYTD, 
SP.SalesLastYear,
Round(SP.SalesYTD-SPQ.SalesQuota,2) as QuotaVariance,
Round((SP.SalesYTD/SPQ.SalesQuota *100),2) as QuotaAchievementPercentage,
Case when SP.SalesYTD>= SPQ.SalesQuota 
Then 'Quota Met'
Else 'Quota Not Met'
End as 'PerformanceCategory'
from person_person as PP
Join humanresources_employee as HE
On PP.BusinessEntityID = HE.BusinessEntityID
Join sales_salespersonquotahistory as SPQ
On HE.BusinessEntityID = SPQ.BusinessEntityID
Join sales_salesperson as SP
On SPQ.BusinessEntityID = SP.BusinessEntityID
Order by PerformanceCategory desc;

-- Question 5

-- 5a
Select CR.Name as Country, 
ST.Name as TerritoryName,
ST.Group as TerritoryGroup
from Sales_Salesorderheader as SOH
Join Sales_SalesTerritory as ST
On SOH.TerritoryID = ST.TerritoryID
Join Person_CountryRegion as CR 
On ST.CountryRegionCode = CR.CountryRegionCode;

-- 5b
Select CR.Name as Country, 
ST.Name as TerritoryName,
ST.Group as TerritoryGroup,
Round(Sum(SOH.TotalDue),2) as TotalRevenue,
Count(SOH.SalesOrderID) as NumberOfOrders,
Round(Avg(SOH.TotalDue),2) as AvgOrderValue
from Sales_Salesorderheader as SOH
Join Sales_SalesTerritory as ST
On SOH.TerritoryID = ST.TerritoryID
Join Person_CountryRegion as CR 
On ST.CountryRegionCode = CR.CountryRegionCode
Group by ST.Name, ST.Group;

-- 5c
Select CR.Name as Country, 
ST.Name as TerritoryName,
ST.Group as TerritoryGroup,
Round(SOH.TotalDue * 100/Sum(SOH.TotalDue),2) as RevenueContributionPercentage
from Sales_Salesorderheader as SOH
Join Sales_SalesTerritory as ST	
On SOH.TerritoryID = ST.TerritoryID
Join Person_CountryRegion as CR 
On ST.CountryRegionCode = CR.CountryRegionCode
Group by ST.Name, ST.Group, SOH.TotalDue;

-- 5d and e
Select CR.Name as Country, 
ST.Name as TerritoryName,
ST.Group as TerritoryGroup,
Count(SOH.SalesOrderID) as NumberOfOrders,
Round(Sum(SOH.TotalDue),2) as TotalRevenue,
Round(Avg(SOH.TotalDue),2) as AvgOrderValue,
Round(SOH.TotalDue * 100/Sum(SOH.TotalDue),2) as RevenueContributionPercentage
from Sales_Salesorderheader as SOH
Join Sales_SalesTerritory as ST
On SOH.TerritoryID = ST.TerritoryID
Join Person_CountryRegion as CR 
On ST.CountryRegionCode = CR.CountryRegionCode
Group by ST.Name, ST.Group, SOH.TotalDue
Order by TotalRevenue desc
Limit 5;

-- Question 6
-- 6a
Select PV.Name as VendorName, 
POH.PurchaseOrderID,
POH.OrderDate, 
POH.Status
from Purchasing_vendor as PV
Join Purchasing_PurchaseOrderHeader as POH
On PV.BusinessEntityID = POH.VendorID
Join Purchasing_PurchaseOrderDetail as POD
On POH.PurchaseOrderID = POD.PurchaseOrderID;

-- 6b
Select PV.Name as VendorName, 
Round(Sum(POD.LineTotal),2) as TotalExpenditure
from Purchasing_vendor as PV
Join Purchasing_PurchaseOrderHeader as POH
On PV.BusinessEntityID = POH.VendorID
Join Purchasing_PurchaseOrderDetail as POD
On POH.PurchaseOrderID = POD.PurchaseOrderID
Group by PV.Name;

-- 6c
Select PV.Name as VendorName,
Count(distinct POH.PurchaseOrderID) as NumberOfPurchaseOrders
from Purchasing_vendor as PV
Join Purchasing_PurchaseOrderHeader as POH
On PV.BusinessEntityID = POH.VendorID
Join Purchasing_PurchaseOrderDetail as POD
On POH.PurchaseOrderID = POD.PurchaseOrderID
Group by PV.Name;

-- 6d
Select PV.Name as VendorName,
Count(distinct POH.PurchaseOrderID) as NumberOfPurchaseOrders,
Round(Sum(POD.LineTotal),2) as TotalExpenditure
from Purchasing_vendor as PV
Join Purchasing_PurchaseOrderHeader as POH
On PV.BusinessEntityID = POH.VendorID
Join Purchasing_PurchaseOrderDetail as POD
On POH.PurchaseOrderID = POD.PurchaseOrderID
Group by PV.Name
Having Count(distinct POH.PurchaseOrderID)> 5 and
Round(Sum(POD.LineTotal),2) > 50000;

-- 6e
Select PV.Name as VendorName,
Count(distinct POH.PurchaseOrderID) as NumberOfPurchaseOrders,
Round(Sum(POD.LineTotal),2) as TotalExpenditure,
Round(Avg(POD.LineTotal),2) as AvgPurchaseOrderValue
from Purchasing_vendor as PV
Join Purchasing_PurchaseOrderHeader as POH
On PV.BusinessEntityID = POH.VendorID
Join Purchasing_PurchaseOrderDetail as POD
On POH.PurchaseOrderID = POD.PurchaseOrderID
Group by PV.Name
Having Count(distinct POH.PurchaseOrderID)> 5 and
Round(Sum(POD.LineTotal),2) > 50000
Order by TotalExpenditure desc;

-- Question 7

-- 7a
Select P.ProductID, 
P.Name as ProductName,
P.ProductNumber as ProductNumber,
P.ReOrderPoint,
P.StandardCost as StandardCost
from Production_Product as P
Join Production_ProductInventory as PI
On P.ProductID = PI.ProductID
Join Production_Location as PL
On PI.LocationID = PL.LocationID;

-- 7b
Select P.ProductID, 
P.Name as ProductName,
Sum(PI.Quantity) as TotalQuantity
from Production_Product as P
Join Production_ProductInventory as PI
On P.ProductID = PI.ProductID
Join Production_Location as PL
On PI.LocationID = PL.LocationID
Group by P.ProductID, P.Name;

-- 7c and d
Select P.ProductID, 
P.Name as ProductName,
P.ReorderPoint,
Sum(PI.Quantity) as TotalInventory,
Case when Sum(PI.Quantity) <= P.ReorderPoint
Then 'Reorder Required'
Else 'Stock sufficient'
End as StockStatus
from Production_Product as P
Join Production_ProductInventory as PI
On P.ProductID = PI.ProductID
Join Production_Location as PL
On PI.LocationID = PL.LocationID
Group by P.ProductID, P.Name,P.ReorderPoint;

-- 7e
Select P.ProductID, 
P.Name as ProductName,
P.StandardCost,
P.ReorderPoint,
Sum(PI.Quantity) as TotalInventory,
Case when Sum(PI.Quantity) <= P.ReorderPoint
Then 'Reorder Required'
Else 'Stock sufficient'
End as StockStatus
from Production_Product as P
Join Production_ProductInventory as PI
On P.ProductID = PI.ProductID
Join Production_Location as PL
On PI.LocationID = PL.LocationID
Group by P.ProductID, P.Name, P.StandardCost,
P.ReorderPoint
Having Sum(PI.Quantity) <= P.ReorderPoint
Order by TotalInventory asc;

-- Question 8
-- 8a
Select P.Name as ProductName,
PC.Name as ProductCategory,
PS.Name as ProductSubcategory
from Sales_SalesOrderDetail as SOD
Join Production_Product as P
On SOD.ProductID = P.ProductID
Join Production_ProductSubcategory as PS
On PS.ProductSubcategoryID = P.ProductSubcategoryID
Join Production_ProductCategory as PC
On PS.ProductCategoryID = PC.ProductCategoryID;

-- 8b
Select P.Name as ProductName,
PC.Name as ProductCategory,
PS.Name as ProductSubcategory,
Sum(SOD.OrderQty) as TotalQtySold
from Sales_SalesOrderDetail as SOD
Join Production_Product as P
On SOD.ProductID = P.ProductID
Join Production_ProductSubcategory as PS
On PS.ProductSubcategoryID = P.ProductSubcategoryID
Join Production_ProductCategory as PC
On PS.ProductCategoryID = PC.ProductCategoryID
Group by P.Name,
PC.Name,
PS.Name;

-- 8c
Select P.Name as ProductName,
Round(Sum(SOD.LineTotal),2) as TotalRevenue
from Sales_SalesOrderDetail as SOD
Join Production_Product as P
On SOD.ProductID = P.ProductID
Join Production_ProductSubcategory as PS
On PS.ProductSubcategoryID = P.ProductSubcategoryID
Join Production_ProductCategory as PC
On PS.ProductCategoryID = PC.ProductCategoryID
Group by P.Name;

-- 8d
Select
PC.Name as ProductCategory,
Round(Sum(SOD.LineTotal),2) as TotalRevenue,
Sum(SOD.OrderQty) as TotalQtySold
from Sales_SalesOrderDetail as SOD
Join Production_Product as P
On SOD.ProductID = P.ProductID
Join Production_ProductSubcategory as PS
On PS.ProductSubcategoryID = P.ProductSubcategoryID
Join Production_ProductCategory as PC
On PS.ProductCategoryID = PC.ProductCategoryID
Group by PC.Name;

-- 8e
Select P.Name as ProductName,
PC.Name as ProductCategory,
PS.Name as ProductSubcategory,
Sum(SOD.OrderQty) as TotalQtySold,
Round(Sum(SOD.LineTotal),2) as TotalRevenue
from Sales_SalesOrderDetail as SOD
Join Production_Product as P
On SOD.ProductID = P.ProductID
Join Production_ProductSubcategory as PS
On PS.ProductSubcategoryID = P.ProductSubcategoryID
Join Production_ProductCategory as PC
On PS.ProductCategoryID = PC.ProductCategoryID
Group by P.Name,
PC.Name,
PS.Name
Order by TotalRevenue desc;

-- Question 9
-- 9a
Select PC.Name as ProductCategory
from Production_ProductCategory as PC
Join Production_ProductSubcategory as PS
On PC.ProductCategoryID = PS.ProductCategoryID
Join Production_Product as P
On P.ProductSubcategoryID = PS.ProductSubcategoryID
Join Sales_SalesOrderDetail as SOD
On P.ProductID = SOD.ProductID;

-- 9b
Select PC.Name as ProductCategory, 
PS.Name as ProductSubcategory
from Production_ProductCategory as PC
Join Production_ProductSubcategory as PS
On PC.ProductCategoryID = PS.ProductCategoryID
Join Production_Product as P
On P.ProductSubcategoryID = PS.ProductSubcategoryID
Join Sales_SalesOrderDetail as SOD
On P.ProductID = SOD.ProductID;

-- 9c
Select PC.Name as ProductCategory, 
PS.Name as ProductSubcategory,
Count(Distinct P.ProductID) as NoOfProductSold,
Round(Sum(SOD.LineTotal),2) as TotalSalesRevenue
from Production_ProductCategory as PC
Join Production_ProductSubcategory as PS
On PC.ProductCategoryID = PS.ProductCategoryID
Join Production_Product as P
On P.ProductSubcategoryID = PS.ProductSubcategoryID
Join Sales_SalesOrderDetail as SOD
On P.ProductID = SOD.ProductID
Group by PC.Name, PS.Name
Order by TotalSalesRevenue desc;

-- Question 10

-- 10a
Select SOH.SalesOrderID,
SOH.OrderDate,
SR.Name as SalesReasonName,
Round(Sum(SOH.TotalDue),2) as  TotalOrderValue
from Sales_SalesOrderHeader as SOH
Join Sales_SalesOrderHeaderSalesReason as SOHSR
On SOH.SalesOrderID = SOHSR.SalesOrderID
Join Sales_SalesReason as SR
On SOHSR.SalesReasonID = SR.SalesReasonID
Group by SOH.SalesOrderID, SOH.OrderDate,
SR.Name;

-- 10b
Select SR.Name as SalesReasonName,
SOH.OrderDate,
Count(Distinct SOH.SalesOrderID) as NumberOfOrders
from Sales_SalesOrderHeader as SOH
Join Sales_SalesOrderHeaderSalesReason as SOHSR
On SOH.SalesOrderID = SOHSR.SalesOrderID
Join Sales_SalesReason as SR
On SOHSR.SalesReasonID = SR.SalesReasonID
Group by SOH.OrderDate,
SR.Name;

-- 10c
Select SOH.SalesOrderID,
SOH.OrderDate,
SR.Name as SalesReasonName,
Round(Sum(SOH.TotalDue),2) as  TotalRevenue
from Sales_SalesOrderHeader as SOH
Join Sales_SalesOrderHeaderSalesReason as SOHSR
On SOH.SalesOrderID = SOHSR.SalesOrderID
Join Sales_SalesReason as SR
On SOHSR.SalesReasonID = SR.SalesReasonID
Group by SOH.SalesOrderID, SOH.OrderDate,
SR.Name;

-- 10d 
Select SR.Name as SalesReasonName,
Count(Distinct SOH.SalesOrderID) as NumberOfOrders,
Round(Sum(SOH.TotalDue),2) as  TotalRevenue,
Round(Round(Sum(SOH.TotalDue),2)/Count(Distinct SOH.SalesOrderID),2)
as AvgOrderValue
from Sales_SalesOrderHeader as SOH
Join Sales_SalesOrderHeaderSalesReason as SOHSR
On SOH.SalesOrderID = SOHSR.SalesOrderID
Join Sales_SalesReason as SR
On SOHSR.SalesReasonID = SR.SalesReasonID
Group by SOH.SalesOrderID, SR.Name
Order by TotalRevenue desc;

-- Question 11

-- 11a
Select avg(ListPrice) as AvgListPrice
from Production_Product;

-- 11b
Select Name
from Production_Product
Where ListPrice > (Select avg(ListPrice) as AvgListPrice
from Production_Product)
Group by Name;

-- 11c
Select ProductID, Name as ProductName,
ProductNumber, ListPrice, StandardCost
from Production_Product
Where ListPrice > (Select avg(ListPrice) as AvgListPrice
from Production_Product)
Group by Name;

-- 11d
Select ProductID, Name as ProductName,
ProductNumber, ListPrice, StandardCost,
(Select avg(ListPrice) as AvgListPrice
from Production_Product) as OverallAvgListPrice,
Round(ListPrice-(Select avg(ListPrice) as AvgListPrice
from Production_Product),2) as PriceVariance
from Production_Product
Group by Name;

-- 11e
Select ProductID, Name as ProductName,
ProductNumber, ListPrice, StandardCost,
(Select avg(ListPrice) as AvgListPrice
from Production_Product) as OverallAvgListPrice,
Round(ListPrice-(Select avg(ListPrice) as AvgListPrice
from Production_Product),2) as PriceVariance
from Production_Product
Group by Name
Order by ListPrice desc;

-- Question 12
Select P.ProductID, P.Name as ProductName, 
P.ProductNumber as ProductNumber,
PS.Name as SubcategoryName,
P.ListPrice as ListPrice,
Round((Select Avg(P.ListPrice) 
from Production_Product as P),2) as AvgListPrice
from Production_Product as P
Join Production_ProductSubcategory as PS
On P.ProductSubcategoryID = PS.ProductSubcategoryID
Where P.ListPrice > (Select Avg(P.ListPrice) 
from Production_Product as P)
Group by P.ProductID, P.Name, PS.Name;

-- Question 13
-- 13a
Select C.CustomerID, 
Round(Sum(SOH.TotalDue),2) as TotalCustomerSpend
from Sales_Customer as C
Join Sales_SalesOrderHeader as SOH
On C.CustomerID = SOH.CustomerID
Join Sales_SalesOrderDetail as SOD
On SOH.SalesOrderID = SOD.SalesOrderID
Group by C.CustomerID;

-- 13b
Select C.CustomerID, 
Round(Sum(SOH.TotalDue),2) as TotalCustomerSpend,
Round(Avg(SOH.TotalDue),2) as AvgTotalSpending
from Sales_Customer as C
Join Sales_SalesOrderHeader as SOH
On C.CustomerID = SOH.CustomerID
Join Sales_SalesOrderDetail as SOD
On SOH.SalesOrderID = SOD.SalesOrderID
Group by C.CustomerID;

-- 13c
Select C.CustomerID, SOH.TotalDue
from Sales_Customer as C
Join Sales_SalesOrderHeader as SOH
On C.CustomerID = SOH.CustomerID
Join Sales_SalesOrderDetail as SOD
On SOH.SalesOrderID = SOD.SalesOrderID
Where SOH.TotalDue > (Select avg(SOH.TotalDue) as AvgCustomerSpending
from Sales_SalesOrderHeader as SOH)
Group by C.CustomerID, SOH.TotalDue;

-- 13d
Select C.CustomerID, 
sum(SOD.OrderQty) as TotalCustomerOrder,
Round(Sum(SOH.TotalDue),2) as TotalCustomerSpend,
Round(avg(SOH.TotalDue),2) as AvgCustomerSpending
from Sales_Customer as C
Join Sales_SalesOrderHeader as SOH
On C.CustomerID = SOH.CustomerID
Join Sales_SalesOrderDetail as SOD
On SOH.SalesOrderID = SOD.SalesOrderID
Where SOH.TotalDue > (Select avg(SOH.TotalDue) as AvgCustomerSpending
from Sales_SalesOrderHeader as SOH)
Group by C.CustomerID, SOH.TotalDue;

-- 13e
Select C.CustomerID, 
sum(SOD.OrderQty) as TotalCustomerOrder,
Round(Sum(SOH.TotalDue),2) as TotalCustomerSpend,
Round(avg(SOH.TotalDue),2) as AvgCustomerSpending
from Sales_Customer as C
Join Sales_SalesOrderHeader as SOH
On C.CustomerID = SOH.CustomerID
Join Sales_SalesOrderDetail as SOD
On SOH.SalesOrderID = SOD.SalesOrderID
Where SOH.TotalDue > (Select avg(SOH.TotalDue) as AvgCustomerSpending
from Sales_SalesOrderHeader as SOH)
Group by C.CustomerID, SOH.TotalDue
Order by TotalCustomerSpend desc;

-- Question 14
-- 14a
Select C.CustomerID,
avg(SOH.TotalDue) as AvgOrderValue
from Sales_SalesOrderHeader as SOH
Join Sales_Customer as C
On SOH.CustomerID = C.CustomerID
Join Person_Person as P
On P.BusinessEntityID = C.PersonID
Join Sales_Store as S
On C.StoreID = S.BusinessEntityID
Group by C.CustomerID
Having avg(SOH.TotalDue) > (Select avg(SOH.TotalDue) as AvgOrderValue
from Sales_SalesOrderHeader as SOH);

-- 14b
Select C.CustomerID,
Concat_WS(' ', P.FirstName, P.LastName) as CustomerName,
Count(Distinct SOH.SalesOrderID) as NoOfCompletedOrders,
round(avg(SOH.TotalDue), 2) as AvgOrderValue
from Sales_SalesOrderHeader as SOH
Join Sales_Customer as C
On SOH.CustomerID = C.CustomerID
Join Person_Person as P
On P.BusinessEntityID = C.PersonID
Join Sales_Store as S
On C.StoreID = S.BusinessEntityID
Group by C.CustomerID,
Concat_WS(' ', P.FirstName, P.LastName)
Having avg(SOH.TotalDue) > (Select avg(SOH.TotalDue) as AvgOrderValue
from Sales_SalesOrderHeader as SOH)
Order by AvgOrderValue desc;

-- Question 15
-- 15a
SELECT P.ProductID,
P.Name,
P.ProductNumber
FROM Production_Product AS P
WHERE NOT EXISTS (
    SELECT *
    FROM Sales_SalesOrderDetail AS SOD
    WHERE SOD.ProductID = p.ProductID);
    
    -- 15b
Select P.ProductID,
P.Name,
P.ProductNumber,
P.ListPrice,
P.StandardCost
from Production_Product as P
WHERE NOT EXISTS (
    SELECT *
    FROM Sales_SalesOrderDetail AS SOD
    WHERE SOD.ProductID = p.ProductID);
    
    -- 15c
SELECT
P.ProductID,
P.Name AS ProductName,
P.ProductNumber,
PC.Name AS Category,
PS.Name AS Subcategory,
P.ListPrice,
P.StandardCost
FROM Production_Product AS P
LEFT JOIN Production_ProductSubcategory AS PS
ON P.ProductSubcategoryID = PS.ProductSubcategoryID
LEFT JOIN Production_ProductCategory AS PC
ON PS.ProductCategoryID = PC.ProductCategoryID
WHERE NOT EXISTS (SELECT *
FROM Sales_SalesOrderDetail AS SOD
WHERE SOD.ProductID = P.ProductID);

-- 15d
SELECT P.ProductID,
P.Name AS ProductName,
P.ProductNumber,
PC.Name AS Category,
PS.Name AS Subcategory,
P.ListPrice,
P.StandardCost
FROM Production_Product AS P
LEFT JOIN Production_ProductSubcategory AS PS
ON P.ProductSubcategoryID = PS.ProductSubcategoryID
LEFT JOIN Production_ProductCategory AS PC
ON PS.ProductCategoryID = PC.ProductCategoryID
WHERE NOT EXISTS (SELECT *
FROM Sales_SalesOrderDetail AS SOD
WHERE SOD.ProductID = P.ProductID)
Order by P.ListPrice desc;
