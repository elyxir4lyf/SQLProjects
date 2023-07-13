
-- 0 create the Database
CREATE DATABASE AdventureWorksDW
	DEFAULT CHARACTER SET utf8mb4
	DEFAULT COLLATE utf8mb4_unicode_ci;

USE AdventureWorksDW;

-- 1 create AdventureWorksDWBuildVersion table
CREATE TABLE AdventureWorksDWBuildVersion (
	DBVersion VARCHAR(50) NULL,
	VersionDate DATETIME(6) NULL
) ENGINE=InnoDB;

-- 2 create DatabaseLog table
CREATE TABLE DatabaseLog (
	DatabaseLogID INT AUTO_INCREMENT PRIMARY KEY,
	PostTime DATETIME NOT NULL,
	DatabaseUser VARCHAR(255) NOT NULL,
	Event VARCHAR(255) NOT NULL,
	SchemaName VARCHAR(255) NULL,
	ObjectName VARCHAR(255) NULL,
	TSQL LONGTEXT NOT NULL,
	XmlEvent LONGTEXT NOT NULL
) ENGINE=InnoDB;

-- 3 create DimAccount table
CREATE TABLE DimAccount (
	AccountKey INT AUTO_INCREMENT PRIMARY KEY,
	ParentAccountKey INT NULL,
	AccountCodeAlternateKey INT NULL,
	ParentAccountCodeAlternateKey INT NULL,
	AccountDescription VARCHAR(50) NULL,
	AccountType VARCHAR(50) NULL,
	Operator VARCHAR(50) NULL,
	CustomMembers VARCHAR(300) NULL,
	ValueType VARCHAR(50) NULL,
	CustomMemberOptions VARCHAR(200) NULL,
	CONSTRAINT FK_DimAccount_ParentAccountKey 
		FOREIGN KEY (ParentAccountKey) REFERENCES DimAccount (AccountKey)
) ENGINE=InnoDB;


INSERT INTO DimAccount (
	AccountKey,
    ParentAccountKey,
    AccountCodeAlternateKey,
    ParentAccountCodeAlternateKey,
    AccountDescription,
    AccountType,
    Operator,
    CustomMembers,
    ValueType,
    CustomMemberOptions
)
VALUES
	(1,NULL,1,NULL,'Balance Sheet',NULL,'~',NULL,Currency,NULL),
	(2,1,10,1,'Assets','Assets','+',NULL,Currency,NULL),
	(3,2,110,10,'Current Assets','Assets','+',NULL,Currency,NULL),
	(4,3,1110,110,'Cash','Assets','+',NULL,Currency,NULL),
	(5,3,1120,110,'Receivables','Assets','+',NULL,Currency,NULL),
	(6,5,1130,1120,'Trade','Receivables','Assets','+',NULL,Currency,NULL),
	(7,5,1140,1120,'Other','Receivables','Assets','+',NULL,Currency,NULL),
	(8,3,1150,110,'Allowance for Bad Debt','Assets','+',NULL,Currency,NULL),
	((9,3,1160,110,'Inventory','Assets','+',NULL,'Currency',NULL),
	(10,9,1162,1160,'Raw Materials','Assets','+',NULL,'Currency',NULL),
	(11,9,1164,1160,'Work in Process','Assets','+',NULL,'Currency',NULL),
	(12,9,1166,1160, 'Finished Goods','Assets','+',NULL,'Currency',NULL),
	(13,3,1170,110,'Deferred Taxes','Assets','+',NULL,'Currency',NULL),
	(14,3,1180,110,'Prepaid Expenses','Assets','+',NULL,'Currency',NULL),
	(15,3,1185,110,'Intercompany Receivables','Assets','+',NULL,Currency,NULL),
	(17,2,1200,10,'Property, Plant & Equipment','Assets','+',NULL,Currency,NULL),
	(18,17,1210,1200,'Land & Improvements,Assets','+',NULL,Currency,NULL),
	(1,9,17,1220,1200,'Buildings & Improvements','Assets','+',NULL,Currency,NULL),
	(20,17,1230,1200,'Machinery & Equipment','Assets','+',NULL,Currency,NULL),
	(21,17,1240,1200,Office Furniture & Equipment,Assets,’+’,NULL,Currency,NULL),
	(22,17,1250,1200,Leasehold Improvements,Assets,’+’,NULL,Currency,NULL),
	(23,17,1260,1200,Construction In Progress,Assets,’+’,NULL,Currency,NULL),
	(24,2,1300,10,Other Assets,Assets,’+’,NULL,Currency,NULL),
	(25,1,20,1,Liabilities and Owners Equity,Liabilities,-,NULL,Currency,NULL),
	(26,25,210,20,Liabilities,Liabilities,’+’,NULL,Currency,NULL),
	(27,26,2200,210,Current Liabilities,Liabilities,’+’,NULL,Currency,NULL),
	(28,27,2210,2200,Notes Payable,Liabilities,’+’,NULL,Currency,NULL),
	(2(9,27,2230,2200,Accounts Payable,Liabilities,’+’,NULL,Currency,NULL),
	(30,27,2300,2200,Accrued Expenses,Liabilities,’+’,NULL,Currency,NULL),
	(31,30,2310,2300,Salary & Other Comp,Liabilities,’+’,NULL,Currency,NULL),
	(32,30,2320,2300,Insurance,Liabilities,’+’,NULL,Currency,NULL),
	(33,30,2330,2300,Warranties,Liabilities,’+’,NULL,Currency,NULL),
	(34,27,2340,2200,Intercompany Payables,Liabilities,’+’,NULL,Currency,NULL),
	(35,27,2350,2200,Other Current Liabilities,Liabilities,’+’,NULL,Currency,NULL),
	(36,26,2400,210,Long Term Liabilities,Liabilities,’+’,NULL,Currency,NULL),
	(37,36,2410,2400,Long Term Obligations,Liabilities,’+’,NULL,Currency,NULL),
	(38,36,2420,2400,Pension Liability,Liabilities,’+’,NULL,Currency,NULL),
	(3(9,36,2430,2400,Other Retirement Benefits,Liabilities,’+’,NULL,Currency,NULL),
	(40,36,2440,2400,Other Long Term Liabilities,Liabilities,’+’,NULL,Currency,NULL),
	(41,25,300,20,Owners Equity,Liabilities,’+’,NULL,Currency,NULL),
	(42,41,3010,300,Partner Capital,Liabilities,’+’,NULL,Currency,NULL),
	(43,41,3020,300,Additional Paid In Capital,Liabilities,’+’,NULL,Currency,NULL),
	(44,41,3030,300,Retained Earnings,Liabilities,’+’,NULL,Currency,NULL),
	(45,44,3540,3030,Prior Year Retained Earnings,Liabilities,’+’,NULL,Currency,NULL),
	(46,44,3550,3030,Current Retained Earnings,Liabilities,’+’,NULL,Currency,NULL),
	(47,NULL,4,NULL,Net Income,Revenue,’+’,NULL,Currency,NULL),
	(48,47,40,4,Operating Profit,Revenue,’+’,NULL,Currency,NULL),
	(4(9,48,400,40,Gross Margin,Revenue,’+’,NULL,Currency,NULL),
	(50,4(9,4100,400,Net Sales,Revenue,’+’,NULL,Currency,NULL),
	(51,50,4110,4100,Gross Sales,Revenue,’+’,NULL,Currency,NULL),
	(52,51,4500,4110,Intercompany Sales,Revenue,’+’,NULL,Currency,NULL),
	(53,50,4130,4100,Returns and Adjustments,Expenditures,-,NULL,Currency,NULL),
	(54,50,4140,4100,Discounts,Expenditures,-,NULL,Currency,NULL),
	(55,4(9,5000,400,Total Cost of Sales,Expenditures,-,NULL,Currency,NULL),
	(56,55,5020,5000,Standard Cost of Sales,Expenditures,’+’,NULL,Currency,NULL),
	(57,55,5050,5000,Variances,Expenditures,’+’,NULL,Currency,NULL),
	(58,48,60,40,Operating Expenses,Expenditures,-,NULL,Currency,NULL),
	(5(9,58,600,60,Labor Expenses,Expenditures,’+’,NULL,Currency,NULL),
	(60,5(9,6000,600,Salaries,Expenditures,’+’,NULL,Currency,NULL),
	(61,5(9,6020,600,Payroll Taxes,Expenditures,’+’,NULL,Currency,NULL),
	(62,5(9,6040,600,Employee Benefits,Expenditures,’+’,NULL,Currency,NULL),
	(63,58,6100,60,Commissions,Expenditures,’+’,NULL,Currency,NULL),
	(64,58,620,60,Travel Expenses,Expenditures,’+’,NULL,Currency,NULL),
	(65,64,6200,620,Travel Transportation,Expenditures,’+’,NULL,Currency,NULL),
	(66,64,6210,620,Travel Lodging,Expenditures,’+’,NULL,Currency,NULL),
	(67,64,6220,620,Meals,Expenditures,’+’,NULL,Currency,NULL),
	(68,64,6230,620,Entertainment,Expenditures,’+’,NULL,Currency,NULL),
	(6(9,64,6240,620,Other Travel Related,Expenditures,’+’,NULL,Currency,NULL),
	(70,58,630,60,Marketing,Expenditures,’+’,NULL,Currency,NULL),
	(71,70,6300,630,Conferences,Expenditures,’+’,NULL,Currency,NULL),
	(72,70,6310,630,Marketing Collateral,Expenditures,’+’,NULL,Currency,NULL),
	(73,58,6400,60,Office Supplies,Expenditures,’+’,NULL,Currency,NULL),
	(74,58,6500,60,Professional Services,Expenditures,’+’,NULL,Currency,NULL),
	(75,58,660,60,Telephone and Utilities,Expenditures,’+’,NULL,Currency,NULL),
	(76,75,6610,660,Telephone,Expenditures,’+’,NULL,Currency,NULL),
	(77,75,6620,660,Utilities,Expenditures,’+’,NULL,Currency,NULL),
	(78,58,6700,60,Other Expenses,Expenditures,’+’,NULL,Currency,NULL),
	(79,58,680,60,Depreciation,Expenditures,’+’,NULL,Currency,NULL),
	(80,79,6810,680,Building Leasehold,Expenditures,’+’,NULL,Currency,NULL),
	(81,79,6820,680,Vehicles,Expenditures,’+’,NULL,Currency,NULL),
	(82,79,6830,680,Equipment,Expenditures,’+’,NULL,Currency,NULL),
	(83,79,6840,680,Furniture and Fixtures,Expenditures,’+’,NULL,Currency,NULL),
	(84,79,6850,680,Other Assets,Expenditures,’+’,NULL,Currency,NULL),
	(85,79,6860,680,Amortization of Goodwill,Expenditures,’+’,NULL,Currency,NULL),
	(87,58,6920,60,Rent,Expenditures,’+’,NULL,Currency,NULL),
	(88,47,80,4,Other Income and Expense,Revenue,’+’,NULL,Currency,NULL),
	(89,88,8000,80,Interest Income,Revenue,’+’,NULL,Currency,NULL),
	(90,88,8010,80,Interest Expense,Expenditures,-,NULL,Currency,NULL),
	(91,88,8020,80,Gain/Loss on Sales of Asset,Revenue,’+’,NULL,Currency,NULL),
	(92,88,8030,80,Other Income,Revenue,’+’,NULL,Currency,NULL),
	(93,88,8040,80,Curr Xchg Gain/(Loss),Revenue,’+’,NULL,Currency,NULL),
	(94,47,8500,4,Taxes,Expenditures,-,NULL,Currency,NULL),
	(95,NULL,9500,NULL,Statistical Accounts,Statistical,’~’,NULL,Units,NULL),
	(96,95,9510,9500,Headcount,Balances,’~’,NULL,Units,NULL),
	(97,95,9520,9500,Units,Flow,’~’,NULL,Units,NULL),
	(98,95,9530,9500,’Average Unit Price,Balances’,’~’,[Account].[Accounts].[Account Level 04].&[50]/[Account].[Accounts].[Account Level 02].&[(97],Currency,NULL),
	(99,95,9540,9500,Square Footage,Balances,’~’,NULL,Units,NULL),
	(100,27,2220,2200,Current Installments of Long-term Debt,Liabilities,’+’,NULL,Currency,NULL),
	(101,51,4200,4110,Trade Sales,Revenue,’+’,NULL,Currency,NULL),





-- 4 create DimCurrency table
CREATE TABLE DimCurrency (
	CurrencyKey INT AUTO_INCREMENT PRIMARY KEY,
	CurrencyAlternateKey CHAR(3) NOT NULL,
	CurrencyName VARCHAR(50) NOT NULL,
	UNIQUE INDEX AK_DimCurrency_CurrencyAlternateKey (CurrencyAlternateKey)
) ENGINE=InnoDB;

-- 5 create DimSalesTerritory table
CREATE TABLE DimSalesTerritory (
	SalesTerritoryKey INT AUTO_INCREMENT NOT NULL,
	SalesTerritoryAlternateKey INT NULL,
	SalesTerritoryRegion VARCHAR(50) NOT NULL,
	SalesTerritoryCountry VARCHAR(50) NOT NULL,
	SalesTerritoryGroup VARCHAR(50) NULL,
	SalesTerritoryImage LONGBLOB NULL,
	PRIMARY KEY (SalesTerritoryKey),
	UNIQUE KEY AK_DimSalesTerritory_SalesTerritoryAlternateKey (SalesTerritoryAlternateKey)
) ENGINE=InnoDB;

-- 6 create DimGeography table
CREATE TABLE DimGeography (
    GeographyKey INT AUTO_INCREMENT NOT NULL,
    City VARCHAR(30) NULL,
    StateProvinceCode CHAR(3) NULL,
    StateProvinceName VARCHAR(50) NULL,
    CountryRegionCode CHAR(2) NULL,
    EnglishCountryRegionName VARCHAR(50) NULL,
    SpanishCountryRegionName VARCHAR(50) NULL,
    FrenchCountryRegionName VARCHAR(50) NULL,
    PostalCode VARCHAR(15) NULL,
    SalesTerritoryKey INT NULL,
    IpAddressLocator CHAR(15) NULL,
    PRIMARY KEY (GeographyKey),
    CONSTRAINT FK_DimGeography_DimSalesTerritory
        FOREIGN KEY (SalesTerritoryKey) 
			REFERENCES DimSalesTerritory (SalesTerritoryKey)
) ENGINE=InnoDB;

-- 7 create DimCustomer table
CREATE TABLE DimCustomer (
	CustomerKey INT AUTO_INCREMENT PRIMARY KEY,
	GeographyKey INT NULL,
	CustomerAlternateKey VARCHAR(15) NOT NULL,
	Title VARCHAR(8) NULL,
	FirstName VARCHAR(50) NULL,
	MiddleName VARCHAR(50) NULL,
	LastName VARCHAR(50) NULL,
	NameStyle BIT NULL,
	BirthDate DATE NULL,
	MaritalStatus CHAR(1) CHARACTER SET UTF8MB4 NULL,
	Suffix VARCHAR(10) NULL,
	Gender VARCHAR(1) NULL,
	EmailAddress VARCHAR(50) NULL,
	YearlyIncome DECIMAL(19,4) NULL,
	TotalChildren TINYINT NULL,
	NumberChildrenAtHome TINYINT NULL,
	EnglishEducation VARCHAR(40) NULL,
	SpanishEducation VARCHAR(40) NULL,
	FrenchEducation VARCHAR(40) NULL,
	EnglishOccupation VARCHAR(100) NULL,
	SpanishOccupation VARCHAR(100) NULL,
	FrenchOccupation VARCHAR(100) NULL,
	HouseOwnerFlag CHAR(1) NULL,
	NumberCarsOwned TINYINT NULL,
	AddressLine1 VARCHAR(120) NULL,
	AddressLine2 VARCHAR(120) NULL,
	Phone VARCHAR(20) NULL,
	DateFirstPurchase DATE NULL,
	CommuteDistance VARCHAR(15) NULL,
	CONSTRAINT FK_DimCustomer_GeaographyKey 
		FOREIGN KEY (GeographyKey) REFERENCES DimGeography(GeographyKey)
) ENGINE=InnoDB;

-- 8 create DimDate table
CREATE TABLE DimDate (
    DateKey INT NOT NULL,
    FullDateAlternateKey DATE NOT NULL,
    DayNumberOfWeek TINYINT NOT NULL,
    EnglishDayNameOfWeek VARCHAR(10) NOT NULL,
    SpanishDayNameOfWeek VARCHAR(10) NOT NULL,
    FrenchDayNameOfWeek VARCHAR(10) NOT NULL,
    DayNumberOfMonth TINYINT NOT NULL,
    DayNumberOfYear SMALLINT NOT NULL,
    WeekNumberOfYear TINYINT NOT NULL,
    EnglishMonthName VARCHAR(10) NOT NULL,
    SpanishMonthName VARCHAR(10) NOT NULL,
    FrenchMonthName VARCHAR(10) NOT NULL,
    MonthNumberOfYear TINYINT NOT NULL,
    CalendarQuarter TINYINT NOT NULL,
    CalendarYear SMALLINT NOT NULL,
    CalendarSemester TINYINT NOT NULL,
    FiscalQuarter TINYINT NOT NULL,
    FiscalYear SMALLINT NOT NULL,
    FiscalSemester TINYINT NOT NULL,
    PRIMARY KEY (DateKey)
) ENGINE=InnoDB;

-- create unique index
CREATE UNIQUE INDEX AK_DimDate_FullDateAlternateKey ON DimDate (FullDateAlternateKey);

-- 9 create DimDepartmentGroup table
CREATE TABLE DimDepartmentGroup (
    DepartmentGroupKey INT AUTO_INCREMENT NOT NULL,
    ParentDepartmentGroupKey INT NULL,
    DepartmentGroupName VARCHAR(50) NULL,
    PRIMARY KEY (DepartmentGroupKey),
    CONSTRAINT FK_DimDepartmentGroup_DimDepartmentGroup
        FOREIGN KEY (ParentDepartmentGroupKey) REFERENCES DimDepartmentGroup (DepartmentGroupKey)
) ENGINE=InnoDB;

-- 10 create DimEmployee table
CREATE TABLE DimEmployee (
    EmployeeKey INT AUTO_INCREMENT NOT NULL,
    ParentEmployeeKey INT NULL,
    EmployeeNationalIDAlternateKey VARCHAR(15) NULL,
    ParentEmployeeNationalIDAlternateKey VARCHAR(15) NULL,
    SalesTerritoryKey INT NULL,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    MiddleName VARCHAR(50) NULL,
    NameStyle BIT NOT NULL,
    Title VARCHAR(50) NULL,
    HireDate DATE NULL,
    BirthDate DATE NULL,
    LoginID VARCHAR(256) NULL,
    EmailAddress VARCHAR(50) NULL,
    Phone VARCHAR(25) NULL,
    MaritalStatus CHAR(1) CHARACTER SET UTF8MB4 NULL,
    EmergencyContactName VARCHAR(50) NULL,
    EmergencyContactPhone VARCHAR(25) NULL,
    SalariedFlag BIT NULL,
    Gender CHAR(1) CHARACTER SET UTF8MB4 NULL,
    PayFrequency TINYINT NULL,
    BaseRate DECIMAL(10, 2) NULL,
    VacationHours SMALLINT NULL,
    SickLeaveHours SMALLINT NULL,
    CurrentFlag BIT NOT NULL,
    SalesPersonFlag BIT NOT NULL,
    DepartmentName VARCHAR(50) NULL,
    StartDate DATE NULL,
    EndDate DATE NULL,
    Status VARCHAR(50) NULL,
    EmployeePhoto LONGBLOB NULL,
    PRIMARY KEY (EmployeeKey),
    CONSTRAINT FK_DimEmployee_DimEmployee
        FOREIGN KEY (ParentEmployeeKey) REFERENCES DimEmployee (EmployeeKey),
    CONSTRAINT FK_DimEmployee_DimSalesTerritory
        FOREIGN KEY (SalesTerritoryKey) REFERENCES DimSalesTerritory (SalesTerritoryKey)
) ENGINE=InnoDB;

-- 11 create DimOrganization table
CREATE TABLE DimOrganization (
    OrganizationKey INT AUTO_INCREMENT NOT NULL,
    ParentOrganizationKey INT NULL,
    PercentageOfOwnership VARCHAR(16) NULL,
    OrganizationName VARCHAR(50) NULL,
    CurrencyKey INT NULL,
    PRIMARY KEY (OrganizationKey),
    CONSTRAINT FK_DimOrganization_DimCurrency
        FOREIGN KEY (CurrencyKey) REFERENCES DimCurrency (CurrencyKey),
    CONSTRAINT FK_DimOrganization_DimOrganization
        FOREIGN KEY (ParentOrganizationKey) REFERENCES DimOrganization (OrganizationKey)
) ENGINE=InnoDB;

-- 12 create DimProductCategory table
CREATE TABLE DimProductCategory (
	ProductCategoryKey INT AUTO_INCREMENT NOT NULL,
	ProductCategoryAlternateKey INT NULL,
	EnglishProductCategoryName VARCHAR(50) NOT NULL,
	SpanishProductCategoryName VARCHAR(50) NOT NULL,
	FrenchProductCategoryName VARCHAR(50) NOT NULL,
	PRIMARY KEY (ProductCategoryKey),
	UNIQUE KEY AK_DimProductCategory_ProductCategoryAlternateKey (ProductCategoryAlternateKey)
) ENGINE=InnoDB;

-- 13 create DimProductSubcategory table
CREATE TABLE DimProductSubcategory (
	ProductSubcategoryKey INT AUTO_INCREMENT NOT NULL,
	ProductSubcategoryAlternateKey INT NULL,
	EnglishProductSubcategoryName VARCHAR(50) NOT NULL,
	SpanishProductSubcategoryName VARCHAR(50) NOT NULL,
	FrenchProductSubcategoryName VARCHAR(50) NOT NULL,
	ProductCategoryKey INT NULL,
	PRIMARY KEY (ProductSubcategoryKey),
	UNIQUE KEY AK_DimProductSubcategory_ProductSubcategoryAlternateKey (ProductSubcategoryAlternateKey),
	CONSTRAINT FK_DimProductSubcategory_DimProductCategory 
		FOREIGN KEY (ProductCategoryKey) REFERENCES DimProductCategory (ProductCategoryKey)
) ENGINE=InnoDB;

-- 14 create DimProduct table
CREATE TABLE DimProduct (
	ProductKey INT AUTO_INCREMENT NOT NULL,
	ProductAlternateKey VARCHAR(25) NULL,
	ProductSubcategoryKey INT NULL,
	WeightUnitMeasureCode CHAR(3) NULL,
	SizeUnitMeasureCode CHAR(3) NULL,
	EnglishProductName VARCHAR(50) NOT NULL,
	SpanishProductName VARCHAR(50) NOT NULL,
	FrenchProductName VARCHAR(50) NOT NULL,
	StandardCost DECIMAL(19, 4) NULL,
	FinishedGoodsFlag BIT NOT NULL,
	Color VARCHAR(15) NOT NULL,
	SafetyStockLevel SMALLINT NULL,
	ReorderPoint SMALLINT NULL,
	ListPrice DECIMAL(19, 4) NULL,
	Size VARCHAR(50) NULL,
	SizeRange VARCHAR(50) NULL,
	Weight FLOAT NULL,
	DaysToManufacture INT NULL,
	ProductLine CHAR(2) NULL,
	DealerPrice DECIMAL(19, 4) NULL,
	Class CHAR(2) NULL,
	Style CHAR(2) NULL,
	ModelName VARCHAR(50) NULL,
	LargePhoto LONGBLOB NULL,
	EnglishDescription VARCHAR(400) NULL,
	FrenchDescription VARCHAR(400) NULL,
	ChineseDescription VARCHAR(400) NULL,
	ArabicDescription VARCHAR(400) NULL,
	HebrewDescription VARCHAR(400) NULL,
	ThaiDescription VARCHAR(400) NULL,
	GermanDescription VARCHAR(400) NULL,
	JapaneseDescription VARCHAR(400) NULL,
	TurkishDescription VARCHAR(400) NULL,
	StartDate DATETIME NULL,
	EndDate DATETIME NULL,
	Status CHAR(7) NULL,
	PRIMARY KEY (ProductKey),
	UNIQUE KEY AK_DimProduct_ProductAlternateKey_StartDate (ProductAlternateKey, StartDate),
	CONSTRAINT FK_DimProduct_DimProductSubcategory 
		FOREIGN KEY (ProductSubcategoryKey) 
			REFERENCES DimProductSubcategory (ProductSubcategoryKey)
) ENGINE=InnoDB;

-- 15 create Dimpromotion table
CREATE TABLE DimPromotion (
	PromotionKey INT AUTO_INCREMENT NOT NULL,
	PromotionAlternateKey INT NULL,
	EnglishPromotionName VARCHAR(255) NULL,
	SpanishPromotionName VARCHAR(255) NULL,
	FrenchPromotionName VARCHAR(255) NULL,
	DiscountPct FLOAT NULL,
	EnglishPromotionType VARCHAR(50) NULL,
	SpanishPromotionType VARCHAR(50) NULL,
	FrenchPromotionType VARCHAR(50) NULL,
	EnglishPromotionCategory VARCHAR(50) NULL,
	SpanishPromotionCategory VARCHAR(50) NULL,
	FrenchPromotionCategory VARCHAR(50) NULL,
	StartDate DATETIME NOT NULL,
	EndDate DATETIME NULL,
	MinQty INT NULL,
	MaxQty INT NULL,
	PRIMARY KEY (PromotionKey),
	UNIQUE KEY AK_DimPromotion_PromotionAlternateKey (PromotionAlternateKey)
) ENGINE=InnoDB;

-- 16 create DimReselller table
CREATE TABLE DimReseller (
	ResellerKey INT AUTO_INCREMENT NOT NULL,
	GeographyKey INT NULL,
	ResellerAlternateKey VARCHAR(15) NULL,
	Phone VARCHAR(25) NULL,
	BusinessType VARCHAR(20) NOT NULL,
	ResellerName VARCHAR(50) NOT NULL,
	NumberEmployees INT NULL,
	OrderFrequency CHAR(1) NULL,
	OrderMonth TINYINT NULL,
	FirstOrderYear INT NULL,
	LastOrderYear INT NULL,
	ProductLine VARCHAR(50) NULL,
	AddressLine1 VARCHAR(60) NULL,
	AddressLine2 VARCHAR(60) NULL,
	AnnualSales DECIMAL(19, 4) NULL,
	BankName VARCHAR(50) NULL,
	MinPaymentType TINYINT NULL,
	MinPaymentAmount DECIMAL(19, 4) NULL,
	AnnualRevenue DECIMAL(19, 4) NULL,
	YearOpened INT NULL,
	PRIMARY KEY (ResellerKey),
	UNIQUE KEY AK_DimReseller_ResellerAlternateKey (ResellerAlternateKey),
	CONSTRAINT FK_DimReseller_DimGeography 
		FOREIGN KEY (GeographyKey) REFERENCES DimGeography (GeographyKey)
) ENGINE=InnoDB;

-- 17 create DimScenario
CREATE TABLE DimScenario (
	ScenarioKey INT AUTO_INCREMENT NOT NULL,
	ScenarioName VARCHAR(50) NULL,
	PRIMARY KEY (ScenarioKey)
) ENGINE=InnoDB;

-- 18 create FactFinance table
CREATE TABLE FactFinance (
	FinanceKey INT AUTO_INCREMENT NOT NULL,
	DateKey INT NOT NULL,
	OrganizationKey INT NOT NULL,
	DepartmentGroupKey INT NOT NULL,
	ScenarioKey INT NOT NULL,
	AccountKey INT NOT NULL,
	Amount FLOAT NOT NULL,
	Date DATETIME NULL,
	PRIMARY KEY (FinanceKey),
	CONSTRAINT FK_FactFinance_DimAccount 
		FOREIGN KEY (AccountKey) REFERENCES DimAccount (AccountKey),
	CONSTRAINT FK_FactFinance_DimDate 
		FOREIGN KEY (DateKey) REFERENCES DimDate (DateKey),
	CONSTRAINT FK_FactFinance_DimDepartmentGroup 
		FOREIGN KEY (DepartmentGroupKey) 
			REFERENCES DimDepartmentGroup (DepartmentGroupKey),
	CONSTRAINT FK_FactFinance_DimOrganization 
		FOREIGN KEY (OrganizationKey) 
			REFERENCES DimOrganization (OrganizationKey),
	CONSTRAINT FK_FactFinance_DimScenario 
		FOREIGN KEY (ScenarioKey) REFERENCES DimScenario (ScenarioKey)
) ENGINE=InnoDB;

-- 19 create DimSalesReason
CREATE TABLE DimSalesReason (
	SalesReasonKey INT AUTO_INCREMENT NOT NULL,
	SalesReasonAlternateKey INT NOT NULL,
	SalesReasonName VARCHAR(50) NOT NULL,
	SalesReasonReasonType VARCHAR(50) NOT NULL,
	PRIMARY KEY (SalesReasonKey)
) ENGINE=InnoDB;

-- 20 create FactCallCenter table
CREATE TABLE FactCallCenter (
	FactCallCenterID INT AUTO_INCREMENT NOT NULL,
	DateKey INT NOT NULL,
	WageType VARCHAR(15) NOT NULL,
	Shift VARCHAR(20) NOT NULL,
	LevelOneOperators SMALLINT NOT NULL,
	LevelTwoOperators SMALLINT NOT NULL,
	TotalOperators SMALLINT NOT NULL,
	Calls INT NOT NULL,
	AutomaticResponses INT NOT NULL,
	Orders INT NOT NULL,
	IssuesRaised SMALLINT NOT NULL,
	AverageTimePerIssue SMALLINT NOT NULL,
	ServiceGrade FLOAT NOT NULL,
	Date DATETIME NULL,
	PRIMARY KEY (FactCallCenterID),
	UNIQUE KEY AK_FactCallCenter_DateKey_Shift (DateKey, Shift),
	CONSTRAINT FK_FactCallCenter_DimDate 
		FOREIGN KEY (DateKey) REFERENCES DimDate (DateKey)
) ENGINE=InnoDB;

-- 21 create FactAdditionalInternationalProductDescription table
CREATE TABLE FactAdditionalInternationalProductDescription(
    ProductKey INT NOT NULL,
    CultureName VARCHAR(50) NOT NULL,
    ProductDescription TEXT NOT NULL,
    PRIMARY KEY (ProductKey, CultureName)
) ENGINE=InnoDB;

-- 22 create FactCurrencyRate table
CREATE TABLE FactCurrencyRate(
    CurrencyKey INT NOT NULL,
    DateKey INT NOT NULL,
    AverageRate FLOAT NOT NULL,
    EndOfDayRate FLOAT NOT NULL,
    Date DATETIME NULL,
    PRIMARY KEY (CurrencyKey, DateKey),
    CONSTRAINT FK_FactCurrencyRate_DimCurrency 
		FOREIGN KEY (CurrencyKey) REFERENCES DimCurrency (CurrencyKey),
    CONSTRAINT FK_FactCurrencyRate_DimDate 
		FOREIGN KEY (DateKey) REFERENCES DimDate (DateKey)
) ENGINE=InnoDB;

-- 23 create FactProductInventory table
CREATE TABLE FactProductInventory (
    ProductKey INT NOT NULL,
    DateKey INT NOT NULL,
    MovementDate DATE NOT NULL,
    UnitCost DECIMAL(19,4) NOT NULL,
    UnitsIn INT NOT NULL,
    UnitsOut INT NOT NULL,
    UnitsBalance INT NOT NULL,
    PRIMARY KEY (ProductKey, DateKey),
    CONSTRAINT FK_FactProductInventory_DimDate 
		FOREIGN KEY (DateKey) REFERENCES DimDate (DateKey),
    CONSTRAINT FK_FactProductInventory_DimProduct 
		FOREIGN KEY (ProductKey) REFERENCES DimProduct (ProductKey)
) ENGINE=InnoDB;

-- 24 create FactSalesQuota table
CREATE TABLE FactSalesQuota (
    SalesQuotaKey INT AUTO_INCREMENT NOT NULL,
    EmployeeKey INT NOT NULL,
    DateKey INT NOT NULL,
    CalendarYear SMALLINT NOT NULL,
    CalendarQuarter TINYINT NOT NULL,
    SalesAmountQuota DECIMAL(19,4) NOT NULL,
    Date DATETIME NULL,
    PRIMARY KEY (SalesQuotaKey),
    CONSTRAINT FK_FactSalesQuota_DimDate 
		FOREIGN KEY (DateKey) REFERENCES DimDate (DateKey),
    CONSTRAINT FK_FactSalesQuota_DimEmployee 
		FOREIGN KEY (EmployeeKey) REFERENCES DimEmployee (EmployeeKey)
) ENGINE=InnoDB;

-- 25 create FactResellerSales table
CREATE TABLE FactResellerSales (
    ProductKey INT NOT NULL,
    OrderDateKey INT NOT NULL,
    DueDateKey INT NOT NULL,
    ShipDateKey INT NOT NULL,
    ResellerKey INT NOT NULL,
    EmployeeKey INT NOT NULL,
    PromotionKey INT NOT NULL,
    CurrencyKey INT NOT NULL,
    SalesTerritoryKey INT NOT NULL,
    SalesOrderNumber VARCHAR(20) NOT NULL,
    SalesOrderLineNumber TINYINT NOT NULL,
    RevisionNumber TINYINT NULL,
    OrderQuantity SMALLINT NULL,
    UnitPrice DECIMAL(19,4) NULL,
    ExtendedAmount DECIMAL(19,4) NULL,
    UnitPriceDiscountPct FLOAT NULL,
    DiscountAmount FLOAT NULL,
    ProductStandardCost DECIMAL(19,4) NULL,
    TotalProductCost DECIMAL(19,4) NULL,
    SalesAmount DECIMAL(19,4) NULL,
    TaxAmt DECIMAL(19,4) NULL,
    Freight DECIMAL(19,4) NULL,
    CarrierTrackingNumber VARCHAR(25) NULL,
    CustomerPONumber VARCHAR(25) NULL,
    OrderDate DATETIME NULL,
    DueDate DATETIME NULL,
    ShipDate DATETIME NULL,
    PRIMARY KEY (SalesOrderNumber, SalesOrderLineNumber),
    CONSTRAINT FK_FactResellerSales_DimCurrency 
		FOREIGN KEY (CurrencyKey) REFERENCES DimCurrency (CurrencyKey),
    CONSTRAINT FK_FactResellerSales_DimDate 
		FOREIGN KEY (OrderDateKey) REFERENCES DimDate (DateKey),
    CONSTRAINT FK_FactResellerSales_DimDate1 
		FOREIGN KEY (DueDateKey) REFERENCES DimDate (DateKey),
    CONSTRAINT FK_FactResellerSales_DimDate2 
		FOREIGN KEY (ShipDateKey) REFERENCES DimDate (DateKey),
    CONSTRAINT FK_FactResellerSales_DimEmployee 
		FOREIGN KEY (EmployeeKey) REFERENCES DimEmployee (EmployeeKey),
    CONSTRAINT FK_FactResellerSales_DimProduct 
		FOREIGN KEY (ProductKey) REFERENCES DimProduct (ProductKey),
    CONSTRAINT FK_FactResellerSales_DimPromotion 
		FOREIGN KEY (PromotionKey) REFERENCES DimPromotion (PromotionKey),
    CONSTRAINT FK_FactResellerSales_DimReseller 
		FOREIGN KEY (ResellerKey) REFERENCES DimReseller (ResellerKey),
    CONSTRAINT FK_FactResellerSales_DimSalesTerritory 
		FOREIGN KEY (SalesTerritoryKey) REFERENCES DimSalesTerritory (SalesTerritoryKey)
) ENGINE=InnoDB;

-- 26 create FactInternetSales table
CREATE TABLE FactInternetSales (
    ProductKey INT NOT NULL,
    OrderDateKey INT NOT NULL,
    DueDateKey INT NOT NULL,
    ShipDateKey INT NOT NULL,
    CustomerKey INT NOT NULL,
    PromotionKey INT NOT NULL,
    CurrencyKey INT NOT NULL,
    SalesTerritoryKey INT NOT NULL,
    SalesOrderNumber VARCHAR(20) NOT NULL,
    SalesOrderLineNumber TINYINT NOT NULL,
    RevisionNumber TINYINT NOT NULL,
    OrderQuantity SMALLINT NOT NULL,
    UnitPrice DECIMAL(19,4) NOT NULL,
    ExtendedAmount DECIMAL(19,4) NOT NULL,
    UnitPriceDiscountPct FLOAT NOT NULL,
    DiscountAmount FLOAT NOT NULL,
    ProductStandardCost DECIMAL(19,4) NOT NULL,
    TotalProductCost DECIMAL(19,4) NOT NULL,
    SalesAmount DECIMAL(19,4) NOT NULL,
    TaxAmt DECIMAL(19,4) NOT NULL,
    Freight DECIMAL(19,4) NOT NULL,
    CarrierTrackingNumber VARCHAR(25) NULL,
    CustomerPONumber VARCHAR(25) NULL,
    OrderDate DATETIME NULL,
    DueDate DATETIME NULL,
    ShipDate DATETIME NULL,
    PRIMARY KEY (SalesOrderNumber, SalesOrderLineNumber),
    CONSTRAINT FK_FactInternetSales_DimCurrency 
		FOREIGN KEY (CurrencyKey) REFERENCES DimCurrency (CurrencyKey),
    CONSTRAINT FK_FactInternetSales_DimCustomer 
		FOREIGN KEY (CustomerKey) REFERENCES DimCustomer (CustomerKey),
    CONSTRAINT FK_FactInternetSales_DimDate 
		FOREIGN KEY (OrderDateKey) REFERENCES DimDate (DateKey),
    CONSTRAINT FK_FactInternetSales_DimDate1 
		FOREIGN KEY (DueDateKey) REFERENCES DimDate (DateKey),
    CONSTRAINT FK_FactInternetSales_DimDate2 
		FOREIGN KEY (ShipDateKey) REFERENCES DimDate (DateKey),
    CONSTRAINT FK_FactInternetSales_DimProduct 
		FOREIGN KEY (ProductKey) REFERENCES DimProduct (ProductKey),
    CONSTRAINT FK_FactInternetSales_DimPromotion 
		FOREIGN KEY (PromotionKey) REFERENCES DimPromotion (PromotionKey),
    CONSTRAINT FK_FactInternetSales_DimSalesTerritory 
		FOREIGN KEY (SalesTerritoryKey) REFERENCES DimSalesTerritory (SalesTerritoryKey)
) ENGINE=InnoDB;

-- 27 create FactSurveyResponse table
CREATE TABLE FactSurveyResponse (
    SurveyResponseKey INT AUTO_INCREMENT NOT NULL,
    DateKey INT NOT NULL,
    CustomerKey INT NOT NULL,
    ProductCategoryKey INT NOT NULL,
    EnglishProductCategoryName VARCHAR(50) NOT NULL,
    ProductSubcategoryKey INT NOT NULL,
    EnglishProductSubcategoryName VARCHAR(50) NOT NULL,
    Date DATETIME NULL,
    PRIMARY KEY (SurveyResponseKey),
    CONSTRAINT FK_FactSurveyResponse_CustomerKey 
		FOREIGN KEY (CustomerKey) REFERENCES DimCustomer (CustomerKey),
    CONSTRAINT FK_FactSurveyResponse_DateKey 
		FOREIGN KEY (DateKey) REFERENCES DimDate (DateKey)
) ENGINE=InnoDB;

-- 28 create FactInternetSalesReason table
CREATE TABLE FactInternetSalesReason (
    SalesOrderNumber VARCHAR(20) NOT NULL,
    SalesOrderLineNumber TINYINT NOT NULL,
    SalesReasonKey INT NOT NULL,
    PRIMARY KEY (SalesOrderNumber, SalesOrderLineNumber, SalesReasonKey),
    CONSTRAINT FK_FactInternetSalesReason_DimSalesReason 
		FOREIGN KEY (SalesReasonKey) REFERENCES DimSalesReason (SalesReasonKey),
    CONSTRAINT FK_FactInternetSalesReason_FactInternetSales 
		FOREIGN KEY (SalesOrderNumber, SalesOrderLineNumber) 
			REFERENCES FactInternetSales (SalesOrderNumber, SalesOrderLineNumber)
) ENGINE=InnoDB;

-- 29 create NewFactCurrencyRate table
CREATE TABLE NewFactCurrencyRate (
    AverageRate FLOAT NULL,
    CurrencyID VARCHAR(3) NULL,
    CurrencyDate DATE NULL,
    EndOfDayRate FLOAT NULL,
    CurrencyKey INT NULL,
    DateKey INT NULL
) ENGINE=InnoDB;

-- 30 create ProspecticeBuyer table
CREATE TABLE ProspectiveBuyer (
    ProspectiveBuyerKey INT AUTO_INCREMENT NOT NULL,
    ProspectAlternateKey VARCHAR(15) NULL,
    FirstName VARCHAR(50) NULL,
    MiddleName VARCHAR(50) NULL,
    LastName VARCHAR(50) NULL,
    BirthDate DATETIME NULL,
    MaritalStatus CHAR(1) NULL,
    Gender VARCHAR(1) NULL,
    EmailAddress VARCHAR(50) NULL,
    YearlyIncome DECIMAL(19,4) NULL,
    TotalChildren TINYINT NULL,
    NumberChildrenAtHome TINYINT NULL,
    Education VARCHAR(40) NULL,
    Occupation VARCHAR(100) NULL,
    HouseOwnerFlag CHAR(1) NULL,
    NumberCarsOwned TINYINT NULL,
    AddressLine1 VARCHAR(120) NULL,
    AddressLine2 VARCHAR(120) NULL,
    City VARCHAR(30) NULL,
    StateProvinceCode VARCHAR(3) NULL,
    PostalCode VARCHAR(15) NULL,
    Phone VARCHAR(20) NULL,
    Salutation VARCHAR(8) NULL,
    Unknown INT NULL,
    PRIMARY KEY (ProspectiveBuyerKey)
) ENGINE=InnoDB;
