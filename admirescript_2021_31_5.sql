USE [master]
GO
/****** Object:  Database [admire]    Script Date: 5/31/2021 8:10:43 AM ******/
CREATE DATABASE [admire]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'pakchina_techknot', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\pakchina_admire.mdf' , SIZE = 136960KB , MAXSIZE = 3072000KB , FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'pakchina_techknot_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\pakchina_admire.ldf' , SIZE = 8192KB , MAXSIZE = 3072000KB , FILEGROWTH = 10%)
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [admire] SET COMPATIBILITY_LEVEL = 130
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [admire].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [admire] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [admire] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [admire] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [admire] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [admire] SET ARITHABORT OFF 
GO
ALTER DATABASE [admire] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [admire] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [admire] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [admire] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [admire] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [admire] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [admire] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [admire] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [admire] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [admire] SET  DISABLE_BROKER 
GO
ALTER DATABASE [admire] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [admire] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [admire] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [admire] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [admire] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [admire] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [admire] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [admire] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [admire] SET  MULTI_USER 
GO
ALTER DATABASE [admire] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [admire] SET DB_CHAINING OFF 
GO
ALTER DATABASE [admire] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [admire] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [admire] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [admire] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'admire', N'ON'
GO
ALTER DATABASE [admire] SET QUERY_STORE = OFF
GO
USE [admire]
GO
/****** Object:  User [pakchinau2]    Script Date: 5/31/2021 8:10:43 AM ******/
CREATE USER [pakchinau2] WITHOUT LOGIN WITH DEFAULT_SCHEMA=[pakchinau2]
GO
ALTER ROLE [db_ddladmin] ADD MEMBER [pakchinau2]
GO
ALTER ROLE [db_backupoperator] ADD MEMBER [pakchinau2]
GO
ALTER ROLE [db_datareader] ADD MEMBER [pakchinau2]
GO
ALTER ROLE [db_datawriter] ADD MEMBER [pakchinau2]
GO
/****** Object:  Schema [pakchinau2]    Script Date: 5/31/2021 8:10:43 AM ******/
CREATE SCHEMA [pakchinau2]
GO
/****** Object:  UserDefinedFunction [dbo].[GetBillNumber]    Script Date: 5/31/2021 8:10:43 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[GetBillNumber]
(
	@InvoiceNumber VARCHAR(100)
)
RETURNS VARCHAR(100)
AS
BEGIN
	DECLARE @BillNumber VARCHAR(100)
	SELECT @BillNumber = PurchaseInvoiceNo FROM Stock WHERE InvoiceNumber = @InvoiceNumber
	GROUP BY PurchaseInvoiceNo

	SET @BillNumber = CASE WHEN LEN(@BillNumber) > 0 THEN @BillNumber ELSE NULL END

	IF @BillNumber IS NULL 
	BEGIN
		SELECT @BillNumber = BillNumber FROM Sales WHERE InvoiceNumber = @InvoiceNumber	GROUP BY BillNumber
	END

	IF @BillNumber IS NULL
	BEGIN
		SELECT @BillNumber = InstallementBillNumber FROM Sales_Installements WHERE SaleInvoiceNumber = @InvoiceNumber GROUP BY InstallementBillNumber
	END

	RETURN @BillNumber
END
GO
/****** Object:  UserDefinedFunction [dbo].[GetDateWithTime]    Script Date: 5/31/2021 8:10:43 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[GetDateWithTime] 
(
	@Date DATE
)
RETURNS DATETIME
AS
BEGIN

RETURN  CAST(CAST(@Date AS DATE) AS VARCHAR) + ' ' + CONVERT(VARCHAR(20),DATEADD(HOUR,5,GETUTCDATE()),114)

END
GO
/****** Object:  UserDefinedFunction [dbo].[GetInvoiceTypeFromInvoiceNumber]    Script Date: 5/31/2021 8:10:43 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE Function [dbo].[GetInvoiceTypeFromInvoiceNumber] (@InvoiceNumber VARCHAR(50))
RETURNS VARCHAR(50)
AS
BEGIN
	DECLARE @Type VARCHAR(50)

	IF EXISTS (SELECT * FROM Stock WHERE InvoiceNumber = @InvoiceNumber AND BranchStock_ID  IS NULL)
	BEGIN
		SET @Type = 'PurchaseProduct'
	END
	ELSE
	BEGIN
		IF EXISTS (SELECT * FROM Stock_TransferredProducts WHERE InvoiceNumber = @InvoiceNumber)
		BEGIN
			SET @Type = 'TransferProduct'
		END
		ELSE
		BEGIN
			IF EXISTS (SELECT * FROM Sales WHERE InvoiceNumber = @InvoiceNumber)
			BEGIN
				SET @Type = 'SaleProduct'
			END
			ELSE
			BEGIN
				SET @Type = 'General'
			END
		END
	END

	RETURN  @Type

END
GO
/****** Object:  UserDefinedFunction [dbo].[GetProductsInInvoice]    Script Date: 5/31/2021 8:10:43 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[GetProductsInInvoice] (@InvoiceNumber VARCHAR(50)) 
RETURNS VARCHAR(1000)
AS
BEGIN
	DECLARE @ProductsList VARCHAR(1000)
	SET @ProductsList = ''
	SELECT @ProductsList += ProductName + ' , '  FROM Products P JOIN Sales S ON P.ProductID = S.Product_ID
			WHERE S.InvoiceNumber = @InvoiceNumber
		group by ProductName
	SET @ProductsList = SUBSTRING(@ProductsList,0,LEN(@ProductsList) - 1)
	RETURN @ProductsList
END
GO
/****** Object:  UserDefinedFunction [dbo].[GetProductsInvolvedInStockTransfer]    Script Date: 5/31/2021 8:10:43 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[GetProductsInvolvedInStockTransfer] (@StockID INT,@InvoiceNumber VARCHAR(50))
RETURNS VARCHAR(500)
AS
BEGIN
	DECLARE @ProductName VARCHAR(500)
	IF (SELECT OfficeID FROM Offices WHERE IsHeadOffice = 1) = (SELECT TOP 1 FromOffice_ID FROM Stock_TransferredProducts WHERE InvoiceNumber = @InvoiceNumber)
	BEGIN
		SELECT @ProductName = P.ProductName FROM Stock S JOIN Products P ON P.ProductID = S.Product_ID WHERE StockID = @StockID
	END
	ELSE
	BEGIN
		SELECT @ProductName = P.ProductName FROM BranchStock S JOIN Products P ON P.ProductID = S.Product_ID WHERE ID = @StockID
	END
	RETURN @ProductName
END
GO
/****** Object:  UserDefinedFunction [dbo].[GetPurchasedInvoiceBillNumber]    Script Date: 5/31/2021 8:10:43 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[GetPurchasedInvoiceBillNumber] (@InvoiceNumber VARCHAR(50))
RETURNS VARCHAR(50)
AS
BEGIN
	DECLARE @BIllNumber VARCHAR(50)
	SET @BIllNumber = (SELECT DISTINCT PurchaseInvoiceNo FROM STock WHERE InvoiceNumber = @InvoiceNumber)
	RETURN @BillNumber
END
GO
/****** Object:  UserDefinedFunction [dbo].[GetPurchasedInvoiceProductName]    Script Date: 5/31/2021 8:10:43 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE Function [dbo].[GetPurchasedInvoiceProductName] (@InvoiceNumber VARCHAR(50),@StockID INT)
RETURNS VARCHAR(500)
AS
BEGIN
	DECLARE @ProductsList VARCHAR(500) = ''
	SELECT @ProductsList += ProductName FROM Products P JOIN Stock S ON P.ProductID = S.Product_ID
		WHERE S.InvoiceNumber = @InvoiceNumber AND S.StockID = @StockID
	RETURN @ProductsList
END
GO
/****** Object:  UserDefinedFunction [dbo].[GetPurchasedInvoiceProductQuantity]    Script Date: 5/31/2021 8:10:43 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE Function [dbo].[GetPurchasedInvoiceProductQuantity] (@InvoiceNumber VARCHAR(50),@StockID INT)
RETURNS INT
AS
BEGIN
	DECLARE @Qty INT
	SET @Qty = (SELECT ReceivedQuantity FROM Stock WHERE InvoiceNumber = @InvoiceNumber AND StockID = @StockID AND BranchStock_ID IS NULL)
	RETURN @Qty
END
GO
/****** Object:  UserDefinedFunction [dbo].[GetSaleInvoiceBillNumber]    Script Date: 5/31/2021 8:10:43 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create FUNCTION [dbo].[GetSaleInvoiceBillNumber] (@InvoiceNumber VARCHAR(50))
RETURNS VARCHAR(50)
AS
BEGIN
	DECLARE @BIllNumber VARCHAR(50)
	SET @BIllNumber = (SELECT DISTINCT BillNumber FROM Sales WHERE InvoiceNumber = @InvoiceNumber)
	RETURN @BillNumber
END
GO
/****** Object:  UserDefinedFunction [dbo].[GetSalePrice]    Script Date: 5/31/2021 8:10:43 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[GetSalePrice] (@InvoiceNumber VARCHAR(50))
RETURNS MONEY
AS
BEGIN
	RETURN (SELECT SUM(SalePrice)FROM Sales WHERE InvoiceNumber = @InvoiceNumber)
END
GO
/****** Object:  UserDefinedFunction [dbo].[GetSoldInvoiceCustomerAddress]    Script Date: 5/31/2021 8:10:43 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE Function [dbo].[GetSoldInvoiceCustomerAddress] (@InvoiceNumber VARCHAR(50),@SaleID INT)
RETURNS VARCHAR(500)
AS
BEGIN
	DECLARE @SaleTypeID INT
	DECLARE @Address VARCHAR(500) = ''

	SET @SaleTypeID = (SELECT SaleType_ID FROM Sales WHERE InvoiceNumber = @InvoiceNumber AND SaleID = @SaleID)

	IF @SaleTypeID = 1
	BEGIN
		SELECT @Address += CustomerAddress FROM Customers C JOIN Sales S ON C.CustomerID = S.Customer_ID WHERE S.InvoiceNumber = @InvoiceNumber AND S.SaleID = @SaleID
	END
	ELSE
	BEGIN
		SELECT @Address += C.Address FROM Accounts C JOIN Sales S ON C.AccountID = S.CustomerAccount_ID WHERE S.InvoiceNumber = @InvoiceNumber AND S.SaleID = @SaleID
	END

	RETURN @Address
END
GO
/****** Object:  UserDefinedFunction [dbo].[GetSoldInvoiceCustomerCNIC]    Script Date: 5/31/2021 8:10:43 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE Function [dbo].[GetSoldInvoiceCustomerCNIC] (@InvoiceNumber VARCHAR(50),@SaleID INT)
RETURNS VARCHAR(500)
AS
BEGIN
	DECLARE @SaleTypeID INT
	DECLARE @CustomerCNIC VARCHAR(500) = ''

	SET @SaleTypeID = (SELECT SaleType_ID FROM Sales WHERE InvoiceNumber = @InvoiceNumber AND SaleID = @SaleID)

	IF @SaleTypeID = 1
	BEGIN
		SELECT @CustomerCNIC += CustomerCNICNumber FROM Customers C JOIN Sales S ON C.CustomerID = S.Customer_ID WHERE S.InvoiceNumber = @InvoiceNumber AND S.SaleID = @SaleID
	END
	ELSE
	BEGIN
		SELECT @CustomerCNIC += C.CNICNumber FROM Accounts C JOIN Sales S ON C.AccountID = S.CustomerAccount_ID WHERE S.InvoiceNumber = @InvoiceNumber AND S.SaleID = @SaleID
	END

	RETURN @CustomerCNIC
END
GO
/****** Object:  UserDefinedFunction [dbo].[GetSoldInvoiceCustomerMobileNumber]    Script Date: 5/31/2021 8:10:43 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE Function [dbo].[GetSoldInvoiceCustomerMobileNumber] (@InvoiceNumber VARCHAR(50),@SaleID INT)
RETURNS VARCHAR(500)
AS
BEGIN
	DECLARE @SaleTypeID INT
	DECLARE @MobileNumber VARCHAR(500) = ''

	SET @SaleTypeID = (SELECT SaleType_ID FROM Sales WHERE InvoiceNumber = @InvoiceNumber AND SaleID = @SaleID)

	IF @SaleTypeID = 1
	BEGIN
		SELECT @MobileNumber += CustomerMobileNumber FROM Customers C JOIN Sales S ON C.CustomerID = S.Customer_ID WHERE S.InvoiceNumber = @InvoiceNumber AND S.SaleID = @SaleID
	END
	ELSE
	BEGIN
		SELECT @MobileNumber += C.MobileNumber FROM Accounts C JOIN Sales S ON C.AccountID = S.CustomerAccount_ID WHERE S.InvoiceNumber = @InvoiceNumber AND S.SaleID = @SaleID
	END

	RETURN @MobileNumber
END

GO
/****** Object:  UserDefinedFunction [dbo].[GetSoldInvoiceCustomerName]    Script Date: 5/31/2021 8:10:43 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE Function [dbo].[GetSoldInvoiceCustomerName] (@InvoiceNumber VARCHAR(50),@SaleID INT)
RETURNS VARCHAR(500)
AS
BEGIN
	DECLARE @SaleTypeID INT
	DECLARE @CustomerName VARCHAR(500) = ''

	SET @SaleTypeID = (SELECT SaleType_ID FROM Sales WHERE InvoiceNumber = @InvoiceNumber AND SaleID = @SaleID)

	IF @SaleTypeID = 1
	BEGIN
		SELECT @CustomerName += CustomerName FROM Customers C JOIN Sales S ON C.CustomerID = S.Customer_ID WHERE S.InvoiceNumber = @InvoiceNumber AND S.SaleID = @SaleID
	END
	ELSE
	BEGIN
		SELECT @CustomerName += AccountTitle FROM Accounts C JOIN Sales S ON C.AccountID = S.CustomerAccount_ID WHERE S.InvoiceNumber = @InvoiceNumber AND S.SaleID = @SaleID
	END

	RETURN @CustomerName
END
GO
/****** Object:  UserDefinedFunction [dbo].[GetSoldInvoiceProductName]    Script Date: 5/31/2021 8:10:43 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE Function [dbo].[GetSoldInvoiceProductName] (@InvoiceNumber VARCHAR(50),@StockID INT)
RETURNS VARCHAR(500)
AS
BEGIN
	DECLARE @ProductsList VARCHAR(500) = ''
	SELECT @ProductsList +=  ProductName FROM Products P JOIN Sales S ON P.ProductID = S.Product_ID WHERE S.SaleID = @StockID
		AND S.InvoiceNumber = @InvoiceNumber
	RETURN @ProductsList
END
GO
/****** Object:  UserDefinedFunction [dbo].[GetTransferredInvoiceBillNumber]    Script Date: 5/31/2021 8:10:43 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[GetTransferredInvoiceBillNumber] (@InvoiceNumber VARCHAR(50))
RETURNS VARCHAR(50)
AS
BEGIN
	DECLARE @BIllNumber VARCHAR(50)
	SET @BIllNumber = (SELECT DISTINCT TransferNoteNumber FROM Stock_TransferredProducts WHERE InvoiceNumber = @InvoiceNumber)
	RETURN @BillNumber
END
GO
/****** Object:  UserDefinedFunction [dbo].[GetTransferredInvoiceProductName]    Script Date: 5/31/2021 8:10:43 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Function [dbo].[GetTransferredInvoiceProductName] (@InvoiceNumber VARCHAR(50),@StockID INT)
RETURNS VARCHAR(500)
AS
BEGIN
	DECLARE @ProductsList VARCHAR(500) = ''
	IF (SELECT DISTINCT FromOffice_ID FROM Stock_TransferredProducts WHERE InvoiceNumber = @InvoiceNumber) = (SELECT OfficeID FROM Offices WHERE IsHeadOffice = 1)
	BEGIN
		SELECT @ProductsList += ProductName FROM Products P JOIN BranchStock S ON P.ProductID = S.Product_ID WHERE InvoiceNumber = @InvoiceNumber
			AND S.Stock_ID = @StockID
	END
	ELSE
	BEGIN
		IF (SELECT DISTINCT ToOffice_ID FROM Stock_TransferredProducts WHERE InvoiceNumber = @InvoiceNumber) = (SELECT OfficeID FROM Offices WHERE IsHeadOffice = 1)
		BEGIN
			SELECT @ProductsList += ProductName FROM Products P JOIN Stock S ON P.ProductID = S.Product_ID WHERE InvoiceNumber = @InvoiceNumber
				AND S.BranchStock_ID = @StockID
		END
		ELSE
		BEGIN
			SELECT @ProductsList += ProductName FROM Products P JOIN BranchStock BS ON P.ProductID = BS.Product_ID WHERE InvoiceNumber = @InvoiceNumber AND
				BS.Stock_ID = @StockID
		END
	END

	RETURN @ProductsList
END
GO
/****** Object:  UserDefinedFunction [dbo].[GetTransferredInvoiceProductQuantity]    Script Date: 5/31/2021 8:10:43 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE Function [dbo].[GetTransferredInvoiceProductQuantity] (@InvoiceNumber VARCHAR(50),@StockID INT)
RETURNS INT
AS
BEGIN
	DECLARE @ProductQuantity INT

	IF (SELECT DISTINCT FromOffice_ID FROM Stock_TransferredProducts WHERE InvoiceNumber = @InvoiceNumber) = (SELECT OfficeID FROM Offices WHERE IsHeadOffice = 1)
	BEGIN
		SELECT @ProductQuantity = ReceivedQuantity FROM BranchStock S WHERE InvoiceNumber = @InvoiceNumber
			AND S.Stock_ID = @StockID
	END
	ELSE
	BEGIN
		IF (SELECT DISTINCT ToOffice_ID FROM Stock_TransferredProducts WHERE InvoiceNumber = @InvoiceNumber) = (SELECT OfficeID FROM Offices WHERE IsHeadOffice = 1)
		BEGIN
			SELECT @ProductQuantity = ReceivedQuantity FROM Stock S  WHERE InvoiceNumber = @InvoiceNumber
				AND S.BranchStock_ID = @StockID
		END
		ELSE
		BEGIN
			SELECT @ProductQuantity = ReceivedQuantity FROM BranchStock BS WHERE InvoiceNumber = @InvoiceNumber AND
				BS.Stock_ID = @StockID
		END
	END

	RETURN @ProductQuantity
END
GO
/****** Object:  UserDefinedFunction [dbo].[Sales_Installements_GetTotalAmountReceivedByInstallement]    Script Date: 5/31/2021 8:10:43 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[Sales_Installements_GetTotalAmountReceivedByInstallement] (@InstallementID INT)
RETURNS MONEY
AS
BEGIN
	DECLARE @PendingAmount MONEY 
	SET @PendingAmount = (SELECT SUM(Amount) FROM Sales_Installements_Details WHERE Sale_InstallementID  = @InstallementID)
	SET @PendingAmount = ISNULL(@PendingAmount,0)
	RETURN @PendingAmount
END
GO
/****** Object:  Table [dbo].[AccountDetails]    Script Date: 5/31/2021 8:10:43 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AccountDetails](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[AccountId] [int] NULL,
	[CNICNumber] [nvarchar](max) NULL,
	[MobileNumber] [nvarchar](max) NULL,
	[Address] [nvarchar](max) NULL,
	[IsSync] [bit] NULL,
 CONSTRAINT [PK_AccountDetails] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Accounts]    Script Date: 5/31/2021 8:10:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Accounts](
	[AccountID] [int] IDENTITY(1,1) NOT NULL,
	[AccountTitle] [varchar](50) NULL,
	[AccountCode] [varchar](50) NULL,
	[ControlAccountId] [int] NULL,
	[IsSync] [bit] NULL,
	[OfficeId] [int] NULL,
	[AccountTypeId] [int] NULL,
 CONSTRAINT [PK_Accounts] PRIMARY KEY CLUSTERED 
(
	[AccountID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AccountTypes]    Script Date: 5/31/2021 8:10:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AccountTypes](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Type] [varchar](50) NULL,
 CONSTRAINT [PK_AccountTypes_1] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Companies]    Script Date: 5/31/2021 8:10:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Companies](
	[CompanyID] [int] IDENTITY(1,1) NOT NULL,
	[CompanyName] [varchar](200) NULL,
	[CompanyDescription] [varchar](200) NULL,
	[CompanyContactPerson] [varchar](200) NULL,
	[CompanyContactNumber] [varchar](50) NULL,
	[IsSync] [bit] NULL,
 CONSTRAINT [PK_Companies] PRIMARY KEY CLUSTERED 
(
	[CompanyID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ControlAccounts]    Script Date: 5/31/2021 8:10:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ControlAccounts](
	[ControlAccountID] [int] IDENTITY(1,1) NOT NULL,
	[ControlAccountName] [varchar](50) NULL,
	[HeadId] [int] NULL,
	[IsSync] [bit] NULL,
	[OfficeId] [int] NULL,
 CONSTRAINT [PK_ControlAccounts] PRIMARY KEY CLUSTERED 
(
	[ControlAccountID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Heads]    Script Date: 5/31/2021 8:10:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Heads](
	[AccountTypeId] [int] IDENTITY(1,1) NOT NULL,
	[AccountType] [varchar](50) NULL,
	[IsSync] [bit] NULL,
 CONSTRAINT [PK_AccountTypes] PRIMARY KEY CLUSTERED 
(
	[AccountTypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MainStockHistory]    Script Date: 5/31/2021 8:10:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MainStockHistory](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[SnapshotDate] [date] NULL,
	[OfficeId] [int] NULL,
	[CompanyID] [int] NULL,
	[ProductTypeID] [int] NULL,
	[ProductID] [int] NULL,
	[TotalStock] [int] NULL,
	[TotalPurchasePrice] [money] NULL,
 CONSTRAINT [PK__MainStoc__3214EC27CCC6E43D] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ManufacturedItems]    Script Date: 5/31/2021 8:10:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ManufacturedItems](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[InvoiceNumber] [uniqueidentifier] NULL,
	[EntryDateTime] [money] NULL,
	[ItemId] [int] NULL,
	[ManufacturedItemsPrice] [money] NULL,
	[AdditionalExpenses] [money] NULL,
	[PurchasePrice] [money] NULL,
	[Quantity] [money] NULL,
	[TotalPrice] [nchar](10) NULL,
	[UserId] [int] NULL,
	[OfficeId] [int] NULL,
 CONSTRAINT [PK_ManufacturedItems] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ManufacturedItems_AdditionalCost]    Script Date: 5/31/2021 8:10:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ManufacturedItems_AdditionalCost](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ExpenseType] [nvarchar](max) NULL,
	[ExpenseAmount] [money] NULL,
	[InvoiceNumber] [uniqueidentifier] NULL,
	[OfficeId] [int] NULL,
 CONSTRAINT [PK_ManufacturedItems_AdditionalCost] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ManufacturedItems_RawMaterialUsed]    Script Date: 5/31/2021 8:10:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ManufacturedItems_RawMaterialUsed](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[InvoiceNumber] [uniqueidentifier] NULL,
	[RawMaterialItemId] [int] NULL,
	[RawMaterialItemQuantity] [money] NULL,
	[RawMaterialItemPurchasePrice] [money] NULL,
 CONSTRAINT [PK_Table_1] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ManufacturedItemsComposition]    Script Date: 5/31/2021 8:10:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ManufacturedItemsComposition](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ItemId] [int] NULL,
	[RawMaterialItemId] [int] NULL,
	[RawMaterialItemQuantity] [money] NULL,
 CONSTRAINT [PK_ManufacturedItemsComposition] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProductCategories]    Script Date: 5/31/2021 8:10:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductCategories](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CategoryName] [varchar](50) NULL,
 CONSTRAINT [PK_ProductCategories] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Products]    Script Date: 5/31/2021 8:10:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Products](
	[ProductID] [int] IDENTITY(1,1) NOT NULL,
	[ProductName] [varchar](50) NULL,
	[ProductModel] [varchar](50) NULL,
	[ProductSerialNo] [varchar](50) NULL,
	[ProductTypeId] [int] NULL,
	[ProductCategoryID] [int] NULL,
	[CompanyId] [int] NULL,
	[IsSync] [bit] NULL,
 CONSTRAINT [PK_Products] PRIMARY KEY CLUSTERED 
(
	[ProductID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProductTypes]    Script Date: 5/31/2021 8:10:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductTypes](
	[ProductTypeID] [int] IDENTITY(1,1) NOT NULL,
	[ProductTypeName] [varchar](50) NULL,
	[IsSync] [bit] NULL,
 CONSTRAINT [PK_ProductTypes] PRIMARY KEY CLUSTERED 
(
	[ProductTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Purchases]    Script Date: 5/31/2021 8:10:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Purchases](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[PurchaseDateTime] [datetime] NULL,
	[InvoiceNumber] [uniqueidentifier] NULL,
	[PurchaseInvoiceNo] [varchar](50) NULL,
	[SupplierId] [int] NULL,
	[TotalPurchasePrice] [decimal](18, 6) NULL,
	[EnteredByUser_ID] [int] NULL,
	[IsApproved] [bit] NULL,
	[OfficeId] [int] NULL,
	[IsProcessed] [bit] NULL,
	[IsOffline] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PurchasesDetails]    Script Date: 5/31/2021 8:10:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PurchasesDetails](
	[StockID] [int] IDENTITY(1,1) NOT NULL,
	[SerialNumber] [varchar](50) NULL,
	[CompanyId] [int] NULL,
	[ProductTypeId] [int] NULL,
	[ProductId] [int] NULL,
	[PurchasePrice] [decimal](18, 6) NULL,
	[ReceivedQuantity] [decimal](18, 6) NULL,
	[TotalPurchasePrice] [decimal](18, 6) NULL,
	[EnteredByUserId] [int] NULL,
	[IsApproved] [bit] NULL,
	[InvoiceNumber] [uniqueidentifier] NULL,
	[PurchaseId] [int] NULL,
	[ProductName] [varchar](50) NULL,
 CONSTRAINT [PK_MainOfficeStock] PRIMARY KEY CLUSTERED 
(
	[StockID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PurchasesReturns]    Script Date: 5/31/2021 8:10:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PurchasesReturns](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ReturnDateTime] [datetime] NULL,
	[InvoiceNumber] [uniqueidentifier] NULL,
	[SupplierId] [int] NULL,
	[ProductId] [int] NULL,
	[ReturnPrice] [decimal](18, 6) NULL,
	[ReturnQuantity] [decimal](18, 6) NULL,
	[ReturnTotalPrice] [decimal](18, 6) NULL,
	[UserId] [int] NULL,
	[OfficeId] [int] NULL,
 CONSTRAINT [PK_PurchasesReturns] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Sales]    Script Date: 5/31/2021 8:10:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Sales](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[SaleDateTime] [datetime] NULL,
	[InvoiceNumber] [uniqueidentifier] NULL,
	[BillNumber] [varchar](50) NULL,
	[SaleTypeId] [int] NULL,
	[CustomerAccountId] [int] NULL,
	[CashReceived] [decimal](18, 6) NULL,
	[Balance] [decimal](18, 6) NULL,
	[TotalSalePrice] [decimal](18, 6) NULL,
	[IsPercentDiscount] [bit] NULL,
	[DiscountValue] [decimal](18, 6) NULL,
	[DiscountCalculated] [decimal](18, 6) NULL,
	[UserID] [int] NULL,
	[IsApproved] [bit] NULL,
	[IsProcessed] [bit] NULL,
	[IsOffline] [bit] NULL,
	[OfficeId] [int] NULL,
 CONSTRAINT [PK__Sales__3214EC078D8EF2FC] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SalesDetail]    Script Date: 5/31/2021 8:10:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SalesDetail](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[SaleId] [int] NULL,
	[SerialNumber] [varchar](50) NULL,
	[ProductId] [int] NULL,
	[Quantity] [decimal](18, 6) NULL,
	[SalePrice] [decimal](18, 6) NULL,
	[IsReturned] [bit] NULL,
	[ReturnDateTime] [datetime] NULL,
	[UserID] [int] NULL,
	[IsApproved] [bit] NULL,
 CONSTRAINT [PK_Sales] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SalesDetailStock]    Script Date: 5/31/2021 8:10:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SalesDetailStock](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[StockId] [int] NULL,
	[SaleId] [int] NULL,
	[ProductId] [int] NULL,
	[PurchasePrice] [decimal](18, 6) NULL,
	[Quantity] [decimal](18, 6) NULL,
 CONSTRAINT [PK_SalesDetailStock] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SaleTypes]    Script Date: 5/31/2021 8:10:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SaleTypes](
	[SaleTypeID] [int] IDENTITY(1,1) NOT NULL,
	[SaleType] [varchar](50) NULL,
 CONSTRAINT [PK_SaleTypes] PRIMARY KEY CLUSTERED 
(
	[SaleTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ShareHolderDetails]    Script Date: 5/31/2021 8:10:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ShareHolderDetails](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ShareHolderName] [nvarchar](max) NULL,
	[ShareHolderCNIC] [nvarchar](max) NULL,
	[ShareHolderPhoneNumber] [nvarchar](max) NULL,
	[ShareHolderCellNumber] [nvarchar](max) NULL,
	[ShareHolderProfitPercentage] [money] NULL,
	[ShareHolderLossPercentage] [money] NULL,
	[ShareHolderAccountId] [int] NULL,
	[ShareHolderAccountCreated] [bit] NULL,
 CONSTRAINT [PK_ShareHolderDetails] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[StockPoints]    Script Date: 5/31/2021 8:10:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StockPoints](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[StockPoint] [varchar](100) NULL,
 CONSTRAINT [PK_StockPoints] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Stocks]    Script Date: 5/31/2021 8:10:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Stocks](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[StockPointId] [int] NULL,
	[InvoiceNumber] [uniqueidentifier] NULL,
	[SerialNumber] [varchar](50) NULL,
	[ProductId] [int] NULL,
	[Quantity] [decimal](18, 6) NULL,
	[PurchasePrice] [decimal](18, 6) NULL,
	[Consumed] [decimal](18, 6) NULL,
	[IsReturned] [bit] NULL,
	[IsApproved] [bit] NULL,
	[PurchaseDetailId] [int] NULL,
 CONSTRAINT [PK_Stock_1] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Transactions]    Script Date: 5/31/2021 8:10:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Transactions](
	[TransactionID] [int] IDENTITY(1,1) NOT NULL,
	[TransactionDateTime] [datetime] NULL,
	[VoucherType] [varchar](50) NULL,
	[VoucherNumber] [varchar](50) NULL,
	[ChequeNumber] [varchar](50) NULL,
	[InvoiceNumber] [uniqueidentifier] NULL,
	[Particulars] [varchar](400) NULL,
	[TransactionAmount] [decimal](18, 6) NULL,
	[AccountId] [int] NULL,
	[UserId] [int] NULL,
	[SaleId] [int] NULL,
	[PurchaseId] [int] NULL,
	[IsApproved] [bit] NULL,
	[Quantity] [decimal](18, 6) NULL,
	[ProductTypeId] [int] NULL,
 CONSTRAINT [PK_Transacstions] PRIMARY KEY CLUSTERED 
(
	[TransactionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 5/31/2021 8:10:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[UserID] [int] IDENTITY(1,1) NOT NULL,
	[UserName] [varchar](50) NULL,
	[Password] [varchar](50) NULL,
	[IsActive] [bit] NULL,
	[IsAdmin] [bit] NULL,
	[OfficeId] [int] NULL,
	[IsSync] [bit] NULL,
 CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users_AllowedOffices]    Script Date: 5/31/2021 8:10:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users_AllowedOffices](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [int] NULL,
	[OfficeId] [int] NULL,
	[IsCurrent] [bit] NULL,
 CONSTRAINT [PK_Users_AllowedOffices] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[VoucherTypes]    Script Date: 5/31/2021 8:10:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[VoucherTypes](
	[Id] [int] NOT NULL,
	[VoucherType] [varchar](50) NULL,
	[IsSync] [bit] NULL,
 CONSTRAINT [PK_VoucherTypes] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[AccountDetails] ON 
GO
INSERT [dbo].[AccountDetails] ([Id], [AccountId], [CNICNumber], [MobileNumber], [Address], [IsSync]) VALUES (1, NULL, N'22401-1837965-5', N'0333-9191092', N'darra', NULL)
GO
INSERT [dbo].[AccountDetails] ([Id], [AccountId], [CNICNumber], [MobileNumber], [Address], [IsSync]) VALUES (2, 8, N'222', N'hello', N'arra', NULL)
GO
INSERT [dbo].[AccountDetails] ([Id], [AccountId], [CNICNumber], [MobileNumber], [Address], [IsSync]) VALUES (3, 9, N'22402-2837965-5', N'0333-9191092', N'Darra Adam Khel', NULL)
GO
INSERT [dbo].[AccountDetails] ([Id], [AccountId], [CNICNumber], [MobileNumber], [Address], [IsSync]) VALUES (4, 10, N'adam', N'', N'arra', NULL)
GO
INSERT [dbo].[AccountDetails] ([Id], [AccountId], [CNICNumber], [MobileNumber], [Address], [IsSync]) VALUES (5, 11, N'123', N'', N'Darra adam khel', NULL)
GO
SET IDENTITY_INSERT [dbo].[AccountDetails] OFF
GO
SET IDENTITY_INSERT [dbo].[Accounts] ON 
GO
INSERT [dbo].[Accounts] ([AccountID], [AccountTitle], [AccountCode], [ControlAccountId], [IsSync], [OfficeId], [AccountTypeId]) VALUES (7, N'FAisal Sharif', N'', 0, 0, NULL, NULL)
GO
INSERT [dbo].[Accounts] ([AccountID], [AccountTitle], [AccountCode], [ControlAccountId], [IsSync], [OfficeId], [AccountTypeId]) VALUES (8, N'Faisal Sharif', N'', 0, 0, 1, 3)
GO
INSERT [dbo].[Accounts] ([AccountID], [AccountTitle], [AccountCode], [ControlAccountId], [IsSync], [OfficeId], [AccountTypeId]) VALUES (9, N'Faisal Sharif', N'', 11, 0, NULL, 1)
GO
INSERT [dbo].[Accounts] ([AccountID], [AccountTitle], [AccountCode], [ControlAccountId], [IsSync], [OfficeId], [AccountTypeId]) VALUES (10, N'Faisal Sharif', N'', 11, 0, 1, 2)
GO
INSERT [dbo].[Accounts] ([AccountID], [AccountTitle], [AccountCode], [ControlAccountId], [IsSync], [OfficeId], [AccountTypeId]) VALUES (11, N'Shah Fahad', N'', 11, 0, 1, 3)
GO
SET IDENTITY_INSERT [dbo].[Accounts] OFF
GO
SET IDENTITY_INSERT [dbo].[AccountTypes] ON 
GO
INSERT [dbo].[AccountTypes] ([Id], [Type]) VALUES (1, N'Normal')
GO
INSERT [dbo].[AccountTypes] ([Id], [Type]) VALUES (2, N'Suppliers')
GO
INSERT [dbo].[AccountTypes] ([Id], [Type]) VALUES (3, N'Customers')
GO
INSERT [dbo].[AccountTypes] ([Id], [Type]) VALUES (4, N'text type')
GO
INSERT [dbo].[AccountTypes] ([Id], [Type]) VALUES (5, N'text type')
GO
INSERT [dbo].[AccountTypes] ([Id], [Type]) VALUES (6, N'text type')
GO
INSERT [dbo].[AccountTypes] ([Id], [Type]) VALUES (7, N'text type')
GO
INSERT [dbo].[AccountTypes] ([Id], [Type]) VALUES (8, N'text type')
GO
INSERT [dbo].[AccountTypes] ([Id], [Type]) VALUES (9, N'text type')
GO
INSERT [dbo].[AccountTypes] ([Id], [Type]) VALUES (10, N'text type')
GO
INSERT [dbo].[AccountTypes] ([Id], [Type]) VALUES (11, N'text type')
GO
SET IDENTITY_INSERT [dbo].[AccountTypes] OFF
GO
SET IDENTITY_INSERT [dbo].[Companies] ON 
GO
INSERT [dbo].[Companies] ([CompanyID], [CompanyName], [CompanyDescription], [CompanyContactPerson], [CompanyContactNumber], [IsSync]) VALUES (1, N'PEL', N'ELECTRICAL GOODS MANUFACTURER', N'ZAFAR', N'091-5853351-57', NULL)
GO
INSERT [dbo].[Companies] ([CompanyID], [CompanyName], [CompanyDescription], [CompanyContactPerson], [CompanyContactNumber], [IsSync]) VALUES (2, N'DAWLANCE', N'ELECTRICAL GOODS MANUFACTURER', N'WALEED', N'0333-9632778', NULL)
GO
INSERT [dbo].[Companies] ([CompanyID], [CompanyName], [CompanyDescription], [CompanyContactPerson], [CompanyContactNumber], [IsSync]) VALUES (3, N'ORIENT', N'ELECTRICAL GOODS MANUFACTURER', N'FAEEQ', N'0333-9608687', NULL)
GO
INSERT [dbo].[Companies] ([CompanyID], [CompanyName], [CompanyDescription], [CompanyContactPerson], [CompanyContactNumber], [IsSync]) VALUES (4, N'CHANGHONG RUBA', N'ELECTRICAL GOODS MANUFACTURER', N'MUZAMMIL', N'0311-6339924', NULL)
GO
INSERT [dbo].[Companies] ([CompanyID], [CompanyName], [CompanyDescription], [CompanyContactPerson], [CompanyContactNumber], [IsSync]) VALUES (5, N'KENWOOD', N'ELECTRICAL GOODS MANUFACTURER', N'ZULFIQAR', N'03339191092', NULL)
GO
INSERT [dbo].[Companies] ([CompanyID], [CompanyName], [CompanyDescription], [CompanyContactPerson], [CompanyContactNumber], [IsSync]) VALUES (6, N'UNIVERSAL', N'', N'', N'', NULL)
GO
INSERT [dbo].[Companies] ([CompanyID], [CompanyName], [CompanyDescription], [CompanyContactPerson], [CompanyContactNumber], [IsSync]) VALUES (7, N'SAMSUNG [MOBILE]', N'MOBILE PROVIDER', N'', N'', NULL)
GO
INSERT [dbo].[Companies] ([CompanyID], [CompanyName], [CompanyDescription], [CompanyContactPerson], [CompanyContactNumber], [IsSync]) VALUES (8, N'NOKIA', N'', N'', N'', NULL)
GO
INSERT [dbo].[Companies] ([CompanyID], [CompanyName], [CompanyDescription], [CompanyContactPerson], [CompanyContactNumber], [IsSync]) VALUES (9, N'Q MOBILE', N'', N'', N'', NULL)
GO
INSERT [dbo].[Companies] ([CompanyID], [CompanyName], [CompanyDescription], [CompanyContactPerson], [CompanyContactNumber], [IsSync]) VALUES (10, N'HUAWEI', N'', N'', N'', NULL)
GO
INSERT [dbo].[Companies] ([CompanyID], [CompanyName], [CompanyDescription], [CompanyContactPerson], [CompanyContactNumber], [IsSync]) VALUES (11, N'JACKPOT', N'', N'KHALID SHAH (SAJJAD)', N'0345-8855798', NULL)
GO
INSERT [dbo].[Companies] ([CompanyID], [CompanyName], [CompanyDescription], [CompanyContactPerson], [CompanyContactNumber], [IsSync]) VALUES (12, N'SEPEHR ELECTRIC', N'', N'', N'', NULL)
GO
INSERT [dbo].[Companies] ([CompanyID], [CompanyName], [CompanyDescription], [CompanyContactPerson], [CompanyContactNumber], [IsSync]) VALUES (13, N'PEARL', N'', N'', N'', NULL)
GO
INSERT [dbo].[Companies] ([CompanyID], [CompanyName], [CompanyDescription], [CompanyContactPerson], [CompanyContactNumber], [IsSync]) VALUES (14, N'HOMAGE', N'', N'', N'', NULL)
GO
INSERT [dbo].[Companies] ([CompanyID], [CompanyName], [CompanyDescription], [CompanyContactPerson], [CompanyContactNumber], [IsSync]) VALUES (15, N'SONY', N'', N'', N'', NULL)
GO
INSERT [dbo].[Companies] ([CompanyID], [CompanyName], [CompanyDescription], [CompanyContactPerson], [CompanyContactNumber], [IsSync]) VALUES (16, N'QUICK POWER', N'', N'', N'', NULL)
GO
INSERT [dbo].[Companies] ([CompanyID], [CompanyName], [CompanyDescription], [CompanyContactPerson], [CompanyContactNumber], [IsSync]) VALUES (17, N'GEEPAS', N'', N'', N'', NULL)
GO
INSERT [dbo].[Companies] ([CompanyID], [CompanyName], [CompanyDescription], [CompanyContactPerson], [CompanyContactNumber], [IsSync]) VALUES (18, N'SUPER GENERAL', N'', N'', N'', NULL)
GO
INSERT [dbo].[Companies] ([CompanyID], [CompanyName], [CompanyDescription], [CompanyContactPerson], [CompanyContactNumber], [IsSync]) VALUES (19, N'BOSS', N'', N'', N'', NULL)
GO
INSERT [dbo].[Companies] ([CompanyID], [CompanyName], [CompanyDescription], [CompanyContactPerson], [CompanyContactNumber], [IsSync]) VALUES (20, N'SOLAR ASIA', N'', N'', N'', NULL)
GO
INSERT [dbo].[Companies] ([CompanyID], [CompanyName], [CompanyDescription], [CompanyContactPerson], [CompanyContactNumber], [IsSync]) VALUES (21, N'SAMSUNG [LED''S]', N'LED''S', N'', N'', NULL)
GO
INSERT [dbo].[Companies] ([CompanyID], [CompanyName], [CompanyDescription], [CompanyContactPerson], [CompanyContactNumber], [IsSync]) VALUES (22, N'CHANGHONG RUBA [LED''S]', N'LED''S PROVIDER', N'', N'', NULL)
GO
INSERT [dbo].[Companies] ([CompanyID], [CompanyName], [CompanyDescription], [CompanyContactPerson], [CompanyContactNumber], [IsSync]) VALUES (23, N'DMW', N'', N'', N'', NULL)
GO
INSERT [dbo].[Companies] ([CompanyID], [CompanyName], [CompanyDescription], [CompanyContactPerson], [CompanyContactNumber], [IsSync]) VALUES (24, N'UNITED [STABILIZER]', N'', N'', N'', NULL)
GO
INSERT [dbo].[Companies] ([CompanyID], [CompanyName], [CompanyDescription], [CompanyContactPerson], [CompanyContactNumber], [IsSync]) VALUES (25, N'TOYO [STABILIZER]', N'', N'', N'', NULL)
GO
INSERT [dbo].[Companies] ([CompanyID], [CompanyName], [CompanyDescription], [CompanyContactPerson], [CompanyContactNumber], [IsSync]) VALUES (26, N'SPEED [STABILIZER]', N'', N'', N'', NULL)
GO
INSERT [dbo].[Companies] ([CompanyID], [CompanyName], [CompanyDescription], [CompanyContactPerson], [CompanyContactNumber], [IsSync]) VALUES (27, N'ROLEX [STABILIZER]', N'', N'', N'', NULL)
GO
INSERT [dbo].[Companies] ([CompanyID], [CompanyName], [CompanyDescription], [CompanyContactPerson], [CompanyContactNumber], [IsSync]) VALUES (28, N'GENERAL [STABILIZER]', N'', N'', N'', NULL)
GO
INSERT [dbo].[Companies] ([CompanyID], [CompanyName], [CompanyDescription], [CompanyContactPerson], [CompanyContactNumber], [IsSync]) VALUES (29, N'YOUNIS FANS', N'', N'', N'', NULL)
GO
INSERT [dbo].[Companies] ([CompanyID], [CompanyName], [CompanyDescription], [CompanyContactPerson], [CompanyContactNumber], [IsSync]) VALUES (30, N'7-STAR [STABILIZER]', N'', N'', N'', NULL)
GO
INSERT [dbo].[Companies] ([CompanyID], [CompanyName], [CompanyDescription], [CompanyContactPerson], [CompanyContactNumber], [IsSync]) VALUES (31, N'CROWN', N'', N'', N'', NULL)
GO
INSERT [dbo].[Companies] ([CompanyID], [CompanyName], [CompanyDescription], [CompanyContactPerson], [CompanyContactNumber], [IsSync]) VALUES (32, N'BONUS', N'', N'', N'', NULL)
GO
INSERT [dbo].[Companies] ([CompanyID], [CompanyName], [CompanyDescription], [CompanyContactPerson], [CompanyContactNumber], [IsSync]) VALUES (33, N'CANON', N'', N'', N'', NULL)
GO
INSERT [dbo].[Companies] ([CompanyID], [CompanyName], [CompanyDescription], [CompanyContactPerson], [CompanyContactNumber], [IsSync]) VALUES (34, N'CLIMAX [STABILIZER]', N'', N'', N'', NULL)
GO
INSERT [dbo].[Companies] ([CompanyID], [CompanyName], [CompanyDescription], [CompanyContactPerson], [CompanyContactNumber], [IsSync]) VALUES (35, N'NAS GAS', N'', N'', N'', NULL)
GO
INSERT [dbo].[Companies] ([CompanyID], [CompanyName], [CompanyDescription], [CompanyContactPerson], [CompanyContactNumber], [IsSync]) VALUES (36, N'PAK', N'', N'', N'', NULL)
GO
INSERT [dbo].[Companies] ([CompanyID], [CompanyName], [CompanyDescription], [CompanyContactPerson], [CompanyContactNumber], [IsSync]) VALUES (37, N'SHARP', N'', N'', N'', NULL)
GO
INSERT [dbo].[Companies] ([CompanyID], [CompanyName], [CompanyDescription], [CompanyContactPerson], [CompanyContactNumber], [IsSync]) VALUES (38, N'SUPER CROWN', N'', N'', N'', NULL)
GO
INSERT [dbo].[Companies] ([CompanyID], [CompanyName], [CompanyDescription], [CompanyContactPerson], [CompanyContactNumber], [IsSync]) VALUES (39, N'UNIVERSAL [REFRIGERATOR]', N'', N'', N'', NULL)
GO
INSERT [dbo].[Companies] ([CompanyID], [CompanyName], [CompanyDescription], [CompanyContactPerson], [CompanyContactNumber], [IsSync]) VALUES (40, N'VENOUS', N'', N'', N'', NULL)
GO
INSERT [dbo].[Companies] ([CompanyID], [CompanyName], [CompanyDescription], [CompanyContactPerson], [CompanyContactNumber], [IsSync]) VALUES (41, N'HAIER', N'-', N'-', N'-', NULL)
GO
INSERT [dbo].[Companies] ([CompanyID], [CompanyName], [CompanyDescription], [CompanyContactPerson], [CompanyContactNumber], [IsSync]) VALUES (42, N'Khurshed ', N'-', N'-', N'-', NULL)
GO
INSERT [dbo].[Companies] ([CompanyID], [CompanyName], [CompanyDescription], [CompanyContactPerson], [CompanyContactNumber], [IsSync]) VALUES (43, N'INDUS', N'-', N'-', N'-', NULL)
GO
INSERT [dbo].[Companies] ([CompanyID], [CompanyName], [CompanyDescription], [CompanyContactPerson], [CompanyContactNumber], [IsSync]) VALUES (44, N'PANASONIC', N'', N'', N'-', NULL)
GO
INSERT [dbo].[Companies] ([CompanyID], [CompanyName], [CompanyDescription], [CompanyContactPerson], [CompanyContactNumber], [IsSync]) VALUES (45, N'DMB', N'', N'', N'', NULL)
GO
INSERT [dbo].[Companies] ([CompanyID], [CompanyName], [CompanyDescription], [CompanyContactPerson], [CompanyContactNumber], [IsSync]) VALUES (46, N'SUPER ASIA', N'-', N'MASHKOOR SAB', N'03215171180', NULL)
GO
INSERT [dbo].[Companies] ([CompanyID], [CompanyName], [CompanyDescription], [CompanyContactPerson], [CompanyContactNumber], [IsSync]) VALUES (47, N'QURASHE TRADERS (Company)', N'STPLAZAR', N'FARHAD KHAN', N'03339048005', NULL)
GO
INSERT [dbo].[Companies] ([CompanyID], [CompanyName], [CompanyDescription], [CompanyContactPerson], [CompanyContactNumber], [IsSync]) VALUES (48, N'SAAD W/M', N'', N'', N'', NULL)
GO
INSERT [dbo].[Companies] ([CompanyID], [CompanyName], [CompanyDescription], [CompanyContactPerson], [CompanyContactNumber], [IsSync]) VALUES (49, N'WAVES', N'', N'', N'', NULL)
GO
INSERT [dbo].[Companies] ([CompanyID], [CompanyName], [CompanyDescription], [CompanyContactPerson], [CompanyContactNumber], [IsSync]) VALUES (50, N'Gree', N'', N'', N'', NULL)
GO
INSERT [dbo].[Companies] ([CompanyID], [CompanyName], [CompanyDescription], [CompanyContactPerson], [CompanyContactNumber], [IsSync]) VALUES (51, N'TECHKNOT', N'', N'', N'', NULL)
GO
INSERT [dbo].[Companies] ([CompanyID], [CompanyName], [CompanyDescription], [CompanyContactPerson], [CompanyContactNumber], [IsSync]) VALUES (52, N'KHURSHID FAN', N'', N'', N'', NULL)
GO
INSERT [dbo].[Companies] ([CompanyID], [CompanyName], [CompanyDescription], [CompanyContactPerson], [CompanyContactNumber], [IsSync]) VALUES (53, N'BELVEN FANS', N'', N'', N'', NULL)
GO
INSERT [dbo].[Companies] ([CompanyID], [CompanyName], [CompanyDescription], [CompanyContactPerson], [CompanyContactNumber], [IsSync]) VALUES (54, N'HETER''s', N'', N'', N'', NULL)
GO
INSERT [dbo].[Companies] ([CompanyID], [CompanyName], [CompanyDescription], [CompanyContactPerson], [CompanyContactNumber], [IsSync]) VALUES (55, N'GFC ', N'', N'', N'', NULL)
GO
INSERT [dbo].[Companies] ([CompanyID], [CompanyName], [CompanyDescription], [CompanyContactPerson], [CompanyContactNumber], [IsSync]) VALUES (56, N'ATLAS W/M', N'', N'', N'', NULL)
GO
INSERT [dbo].[Companies] ([CompanyID], [CompanyName], [CompanyDescription], [CompanyContactPerson], [CompanyContactNumber], [IsSync]) VALUES (1052, N'ASIA', N'', N'', N'', NULL)
GO
INSERT [dbo].[Companies] ([CompanyID], [CompanyName], [CompanyDescription], [CompanyContactPerson], [CompanyContactNumber], [IsSync]) VALUES (1053, N'Azeem Asia', N'', N'', N'', NULL)
GO
INSERT [dbo].[Companies] ([CompanyID], [CompanyName], [CompanyDescription], [CompanyContactPerson], [CompanyContactNumber], [IsSync]) VALUES (1054, N'CARRY', N'', N'', N'', NULL)
GO
INSERT [dbo].[Companies] ([CompanyID], [CompanyName], [CompanyDescription], [CompanyContactPerson], [CompanyContactNumber], [IsSync]) VALUES (1055, N'S G FAN', N'', N'', N'', NULL)
GO
INSERT [dbo].[Companies] ([CompanyID], [CompanyName], [CompanyDescription], [CompanyContactPerson], [CompanyContactNumber], [IsSync]) VALUES (1056, N'HAMZA', N'', N'', N'', NULL)
GO
INSERT [dbo].[Companies] ([CompanyID], [CompanyName], [CompanyDescription], [CompanyContactPerson], [CompanyContactNumber], [IsSync]) VALUES (1057, N'NB ', N'', N'', N'', NULL)
GO
INSERT [dbo].[Companies] ([CompanyID], [CompanyName], [CompanyDescription], [CompanyContactPerson], [CompanyContactNumber], [IsSync]) VALUES (1058, N'SECO', N'', N'', N'', NULL)
GO
INSERT [dbo].[Companies] ([CompanyID], [CompanyName], [CompanyDescription], [CompanyContactPerson], [CompanyContactNumber], [IsSync]) VALUES (1059, N'MASTER', N'', N'', N'', NULL)
GO
INSERT [dbo].[Companies] ([CompanyID], [CompanyName], [CompanyDescription], [CompanyContactPerson], [CompanyContactNumber], [IsSync]) VALUES (1060, N'ZAM ZAM', N'', N'', N'', NULL)
GO
INSERT [dbo].[Companies] ([CompanyID], [CompanyName], [CompanyDescription], [CompanyContactPerson], [CompanyContactNumber], [IsSync]) VALUES (1061, N'SOBER', N'', N'', N'', NULL)
GO
INSERT [dbo].[Companies] ([CompanyID], [CompanyName], [CompanyDescription], [CompanyContactPerson], [CompanyContactNumber], [IsSync]) VALUES (1062, N'SG', N'', N'', N'', NULL)
GO
INSERT [dbo].[Companies] ([CompanyID], [CompanyName], [CompanyDescription], [CompanyContactPerson], [CompanyContactNumber], [IsSync]) VALUES (1063, N'NATIONAL', N'', N'', N'', NULL)
GO
INSERT [dbo].[Companies] ([CompanyID], [CompanyName], [CompanyDescription], [CompanyContactPerson], [CompanyContactNumber], [IsSync]) VALUES (1064, N'HILAL GAS', N'', N'', N'', NULL)
GO
INSERT [dbo].[Companies] ([CompanyID], [CompanyName], [CompanyDescription], [CompanyContactPerson], [CompanyContactNumber], [IsSync]) VALUES (1065, N'OCARINA', N'', N'', N'', NULL)
GO
INSERT [dbo].[Companies] ([CompanyID], [CompanyName], [CompanyDescription], [CompanyContactPerson], [CompanyContactNumber], [IsSync]) VALUES (1066, N'HITACHI FRAGILE', N'', N'', N'', NULL)
GO
INSERT [dbo].[Companies] ([CompanyID], [CompanyName], [CompanyDescription], [CompanyContactPerson], [CompanyContactNumber], [IsSync]) VALUES (1067, N'ELECTRIC HEATER', N'', N'', N'', NULL)
GO
INSERT [dbo].[Companies] ([CompanyID], [CompanyName], [CompanyDescription], [CompanyContactPerson], [CompanyContactNumber], [IsSync]) VALUES (1068, N'SUPER HAIER', N'', N'', N'', NULL)
GO
INSERT [dbo].[Companies] ([CompanyID], [CompanyName], [CompanyDescription], [CompanyContactPerson], [CompanyContactNumber], [IsSync]) VALUES (2064, N'SK', N'', N'', N'', NULL)
GO
INSERT [dbo].[Companies] ([CompanyID], [CompanyName], [CompanyDescription], [CompanyContactPerson], [CompanyContactNumber], [IsSync]) VALUES (2065, N'SEWING MACHINE', N'', N'', N'', NULL)
GO
INSERT [dbo].[Companies] ([CompanyID], [CompanyName], [CompanyDescription], [CompanyContactPerson], [CompanyContactNumber], [IsSync]) VALUES (2066, N'SUPER STAND', N'', N'', N'', NULL)
GO
INSERT [dbo].[Companies] ([CompanyID], [CompanyName], [CompanyDescription], [CompanyContactPerson], [CompanyContactNumber], [IsSync]) VALUES (3066, N'ECO STAR', N'', N'', N'', NULL)
GO
INSERT [dbo].[Companies] ([CompanyID], [CompanyName], [CompanyDescription], [CompanyContactPerson], [CompanyContactNumber], [IsSync]) VALUES (3067, N'ENVIRO', N'', N'', N'', NULL)
GO
INSERT [dbo].[Companies] ([CompanyID], [CompanyName], [CompanyDescription], [CompanyContactPerson], [CompanyContactNumber], [IsSync]) VALUES (3068, N'HORIZON', N'', N'', N'', NULL)
GO
INSERT [dbo].[Companies] ([CompanyID], [CompanyName], [CompanyDescription], [CompanyContactPerson], [CompanyContactNumber], [IsSync]) VALUES (3069, N'AL-SHEIKH', N'', N'', N'', NULL)
GO
INSERT [dbo].[Companies] ([CompanyID], [CompanyName], [CompanyDescription], [CompanyContactPerson], [CompanyContactNumber], [IsSync]) VALUES (3070, N'MITSUBISHI', N'', N'', N'', NULL)
GO
INSERT [dbo].[Companies] ([CompanyID], [CompanyName], [CompanyDescription], [CompanyContactPerson], [CompanyContactNumber], [IsSync]) VALUES (4070, N'AL-BURJ', N'', N'', N'', NULL)
GO
INSERT [dbo].[Companies] ([CompanyID], [CompanyName], [CompanyDescription], [CompanyContactPerson], [CompanyContactNumber], [IsSync]) VALUES (4071, N'ROOM COOLER', N'', N'', N'', NULL)
GO
INSERT [dbo].[Companies] ([CompanyID], [CompanyName], [CompanyDescription], [CompanyContactPerson], [CompanyContactNumber], [IsSync]) VALUES (4072, N'UPS', N'', N'', N'', NULL)
GO
INSERT [dbo].[Companies] ([CompanyID], [CompanyName], [CompanyDescription], [CompanyContactPerson], [CompanyContactNumber], [IsSync]) VALUES (4073, N'SONEX', N'', N'', N'', NULL)
GO
INSERT [dbo].[Companies] ([CompanyID], [CompanyName], [CompanyDescription], [CompanyContactPerson], [CompanyContactNumber], [IsSync]) VALUES (4074, N'BRIGHT STAR', N'', N'', N'', NULL)
GO
INSERT [dbo].[Companies] ([CompanyID], [CompanyName], [CompanyDescription], [CompanyContactPerson], [CompanyContactNumber], [IsSync]) VALUES (4075, N'CHAMPION FAN', N'', N'', N'', NULL)
GO
INSERT [dbo].[Companies] ([CompanyID], [CompanyName], [CompanyDescription], [CompanyContactPerson], [CompanyContactNumber], [IsSync]) VALUES (4076, N'CHIEF W/M', N'', N'ABBAS', N'0303 4668766', NULL)
GO
INSERT [dbo].[Companies] ([CompanyID], [CompanyName], [CompanyDescription], [CompanyContactPerson], [CompanyContactNumber], [IsSync]) VALUES (4077, N'OREENA', N'', N'', N'', NULL)
GO
INSERT [dbo].[Companies] ([CompanyID], [CompanyName], [CompanyDescription], [CompanyContactPerson], [CompanyContactNumber], [IsSync]) VALUES (4078, N'NEXT', N'', N'', N'', NULL)
GO
INSERT [dbo].[Companies] ([CompanyID], [CompanyName], [CompanyDescription], [CompanyContactPerson], [CompanyContactNumber], [IsSync]) VALUES (4079, N'TECHNO GAS', N'', N'', N'', NULL)
GO
INSERT [dbo].[Companies] ([CompanyID], [CompanyName], [CompanyDescription], [CompanyContactPerson], [CompanyContactNumber], [IsSync]) VALUES (4080, N'SUPER NATIONAL', N'', N'', N'', NULL)
GO
INSERT [dbo].[Companies] ([CompanyID], [CompanyName], [CompanyDescription], [CompanyContactPerson], [CompanyContactNumber], [IsSync]) VALUES (4081, N'PEACOCK', N'', N'', N'', NULL)
GO
INSERT [dbo].[Companies] ([CompanyID], [CompanyName], [CompanyDescription], [CompanyContactPerson], [CompanyContactNumber], [IsSync]) VALUES (4082, N'SOKANY', N'', N'', N'', NULL)
GO
INSERT [dbo].[Companies] ([CompanyID], [CompanyName], [CompanyDescription], [CompanyContactPerson], [CompanyContactNumber], [IsSync]) VALUES (4083, N'NEW PAK', N'', N'', N'', NULL)
GO
INSERT [dbo].[Companies] ([CompanyID], [CompanyName], [CompanyDescription], [CompanyContactPerson], [CompanyContactNumber], [IsSync]) VALUES (4084, N'PAK FALCON', N'', N'', N'', NULL)
GO
INSERT [dbo].[Companies] ([CompanyID], [CompanyName], [CompanyDescription], [CompanyContactPerson], [CompanyContactNumber], [IsSync]) VALUES (4085, N'ELECTRIC KETTLE', N'', N'', N'', NULL)
GO
INSERT [dbo].[Companies] ([CompanyID], [CompanyName], [CompanyDescription], [CompanyContactPerson], [CompanyContactNumber], [IsSync]) VALUES (4086, N'ZOLAR', N'', N'', N'', NULL)
GO
INSERT [dbo].[Companies] ([CompanyID], [CompanyName], [CompanyDescription], [CompanyContactPerson], [CompanyContactNumber], [IsSync]) VALUES (4087, N'AKBAR', N'', N'', N'', NULL)
GO
INSERT [dbo].[Companies] ([CompanyID], [CompanyName], [CompanyDescription], [CompanyContactPerson], [CompanyContactNumber], [IsSync]) VALUES (4088, N'SINGER', N'', N'', N'', NULL)
GO
INSERT [dbo].[Companies] ([CompanyID], [CompanyName], [CompanyDescription], [CompanyContactPerson], [CompanyContactNumber], [IsSync]) VALUES (4089, N'VIROLAN', N'', N'', N'', NULL)
GO
INSERT [dbo].[Companies] ([CompanyID], [CompanyName], [CompanyDescription], [CompanyContactPerson], [CompanyContactNumber], [IsSync]) VALUES (4090, N'APPLE FAN', N'', N'', N'', NULL)
GO
INSERT [dbo].[Companies] ([CompanyID], [CompanyName], [CompanyDescription], [CompanyContactPerson], [CompanyContactNumber], [IsSync]) VALUES (4091, N'KENSONIC', N'', N'', N'', NULL)
GO
INSERT [dbo].[Companies] ([CompanyID], [CompanyName], [CompanyDescription], [CompanyContactPerson], [CompanyContactNumber], [IsSync]) VALUES (4092, N'AXLE', N'', N'', N'', NULL)
GO
INSERT [dbo].[Companies] ([CompanyID], [CompanyName], [CompanyDescription], [CompanyContactPerson], [CompanyContactNumber], [IsSync]) VALUES (4093, N'ABODE', N'', N'', N'', NULL)
GO
INSERT [dbo].[Companies] ([CompanyID], [CompanyName], [CompanyDescription], [CompanyContactPerson], [CompanyContactNumber], [IsSync]) VALUES (4094, N'ROTI MAKER', N'', N'', N'', NULL)
GO
INSERT [dbo].[Companies] ([CompanyID], [CompanyName], [CompanyDescription], [CompanyContactPerson], [CompanyContactNumber], [IsSync]) VALUES (4095, N'CAMBRIDGE', N'', N'', N'', NULL)
GO
INSERT [dbo].[Companies] ([CompanyID], [CompanyName], [CompanyDescription], [CompanyContactPerson], [CompanyContactNumber], [IsSync]) VALUES (4096, N'REMLNGTON', N'', N'', N'', NULL)
GO
INSERT [dbo].[Companies] ([CompanyID], [CompanyName], [CompanyDescription], [CompanyContactPerson], [CompanyContactNumber], [IsSync]) VALUES (4097, N'BROWN', N'', N'', N'', NULL)
GO
INSERT [dbo].[Companies] ([CompanyID], [CompanyName], [CompanyDescription], [CompanyContactPerson], [CompanyContactNumber], [IsSync]) VALUES (4098, N'SAYONA', N'', N'', N'', NULL)
GO
INSERT [dbo].[Companies] ([CompanyID], [CompanyName], [CompanyDescription], [CompanyContactPerson], [CompanyContactNumber], [IsSync]) VALUES (4099, N'MONLINEX', N'', N'', N'', NULL)
GO
INSERT [dbo].[Companies] ([CompanyID], [CompanyName], [CompanyDescription], [CompanyContactPerson], [CompanyContactNumber], [IsSync]) VALUES (4100, N'INTEX', N'', N'', N'', NULL)
GO
INSERT [dbo].[Companies] ([CompanyID], [CompanyName], [CompanyDescription], [CompanyContactPerson], [CompanyContactNumber], [IsSync]) VALUES (4101, N'WELCOME', N'', N'', N'', NULL)
GO
INSERT [dbo].[Companies] ([CompanyID], [CompanyName], [CompanyDescription], [CompanyContactPerson], [CompanyContactNumber], [IsSync]) VALUES (4102, N'PUMA', N'', N'', N'', NULL)
GO
INSERT [dbo].[Companies] ([CompanyID], [CompanyName], [CompanyDescription], [CompanyContactPerson], [CompanyContactNumber], [IsSync]) VALUES (4103, N'RADO', N'', N'', N'', NULL)
GO
INSERT [dbo].[Companies] ([CompanyID], [CompanyName], [CompanyDescription], [CompanyContactPerson], [CompanyContactNumber], [IsSync]) VALUES (4104, N'ADMIRE', N'', N'', N'', NULL)
GO
INSERT [dbo].[Companies] ([CompanyID], [CompanyName], [CompanyDescription], [CompanyContactPerson], [CompanyContactNumber], [IsSync]) VALUES (4105, N'GALAXY', N'', N'', N'', NULL)
GO
INSERT [dbo].[Companies] ([CompanyID], [CompanyName], [CompanyDescription], [CompanyContactPerson], [CompanyContactNumber], [IsSync]) VALUES (4106, N'KENWOOD', N'ELECTRICAL GOODS MANUFACTURER', N'ZULFIQAR', N'03339191092', 0)
GO
SET IDENTITY_INSERT [dbo].[Companies] OFF
GO
SET IDENTITY_INSERT [dbo].[ControlAccounts] ON 
GO
INSERT [dbo].[ControlAccounts] ([ControlAccountID], [ControlAccountName], [HeadId], [IsSync], [OfficeId]) VALUES (11, N'My Control ACcount 3', 1, 0, NULL)
GO
INSERT [dbo].[ControlAccounts] ([ControlAccountID], [ControlAccountName], [HeadId], [IsSync], [OfficeId]) VALUES (12, N'Current Assets', 1, 0, NULL)
GO
SET IDENTITY_INSERT [dbo].[ControlAccounts] OFF
GO
SET IDENTITY_INSERT [dbo].[Heads] ON 
GO
INSERT [dbo].[Heads] ([AccountTypeId], [AccountType], [IsSync]) VALUES (1, N'Assets', 0)
GO
INSERT [dbo].[Heads] ([AccountTypeId], [AccountType], [IsSync]) VALUES (2, N'Revenue', 0)
GO
INSERT [dbo].[Heads] ([AccountTypeId], [AccountType], [IsSync]) VALUES (3, N'Liabalities', 0)
GO
INSERT [dbo].[Heads] ([AccountTypeId], [AccountType], [IsSync]) VALUES (4, N'Capital', 0)
GO
INSERT [dbo].[Heads] ([AccountTypeId], [AccountType], [IsSync]) VALUES (5, N'Expenses', 0)
GO
INSERT [dbo].[Heads] ([AccountTypeId], [AccountType], [IsSync]) VALUES (6, N'Test Head 1', NULL)
GO
INSERT [dbo].[Heads] ([AccountTypeId], [AccountType], [IsSync]) VALUES (7, N'my head', 0)
GO
SET IDENTITY_INSERT [dbo].[Heads] OFF
GO
SET IDENTITY_INSERT [dbo].[ProductCategories] ON 
GO
INSERT [dbo].[ProductCategories] ([Id], [CategoryName]) VALUES (1, N'Manufactured ')
GO
INSERT [dbo].[ProductCategories] ([Id], [CategoryName]) VALUES (2, N'RawMaterial')
GO
INSERT [dbo].[ProductCategories] ([Id], [CategoryName]) VALUES (3, N'Purchased')
GO
SET IDENTITY_INSERT [dbo].[ProductCategories] OFF
GO
SET IDENTITY_INSERT [dbo].[Products] ON 
GO
INSERT [dbo].[Products] ([ProductID], [ProductName], [ProductModel], [ProductSerialNo], [ProductTypeId], [ProductCategoryID], [CompanyId], [IsSync]) VALUES (12845, N'7210', N'', N'1234', 3039, 3, 1, NULL)
GO
INSERT [dbo].[Products] ([ProductID], [ProductName], [ProductModel], [ProductSerialNo], [ProductTypeId], [ProductCategoryID], [CompanyId], [IsSync]) VALUES (12846, N'1268', N'', N'2244', 3039, 3, 1, NULL)
GO
INSERT [dbo].[Products] ([ProductID], [ProductName], [ProductModel], [ProductSerialNo], [ProductTypeId], [ProductCategoryID], [CompanyId], [IsSync]) VALUES (12847, N'Item 3', N'Item 3', N'Item 3', 3039, 3, 1, 0)
GO
INSERT [dbo].[Products] ([ProductID], [ProductName], [ProductModel], [ProductSerialNo], [ProductTypeId], [ProductCategoryID], [CompanyId], [IsSync]) VALUES (12848, N'Freezers 1', N'Freezers 1', N'Freezers 1', 3040, 1, 1, 0)
GO
INSERT [dbo].[Products] ([ProductID], [ProductName], [ProductModel], [ProductSerialNo], [ProductTypeId], [ProductCategoryID], [CompanyId], [IsSync]) VALUES (12849, N'ABC', N'ABC', N'ABC', 3040, 1, 1, 0)
GO
INSERT [dbo].[Products] ([ProductID], [ProductName], [ProductModel], [ProductSerialNo], [ProductTypeId], [ProductCategoryID], [CompanyId], [IsSync]) VALUES (12850, N'PEL FLANA', N'PEL FLANA', N'PEL FLANA', 3039, 1, 1, 0)
GO
SET IDENTITY_INSERT [dbo].[Products] OFF
GO
SET IDENTITY_INSERT [dbo].[ProductTypes] ON 
GO
INSERT [dbo].[ProductTypes] ([ProductTypeID], [ProductTypeName], [IsSync]) VALUES (3039, N'Refrigerators 1', 0)
GO
INSERT [dbo].[ProductTypes] ([ProductTypeID], [ProductTypeName], [IsSync]) VALUES (3040, N'Freezers', 0)
GO
SET IDENTITY_INSERT [dbo].[ProductTypes] OFF
GO
SET IDENTITY_INSERT [dbo].[Purchases] ON 
GO
INSERT [dbo].[Purchases] ([Id], [PurchaseDateTime], [InvoiceNumber], [PurchaseInvoiceNo], [SupplierId], [TotalPurchasePrice], [EnteredByUser_ID], [IsApproved], [OfficeId], [IsProcessed], [IsOffline]) VALUES (41, CAST(N'2021-05-23T14:45:36.123' AS DateTime), N'00164055-76a8-40a1-81b5-7d3297b708ea', N'p-1001', 11, CAST(37400.000000 AS Decimal(18, 6)), 1, 1, 1, 0, 0)
GO
INSERT [dbo].[Purchases] ([Id], [PurchaseDateTime], [InvoiceNumber], [PurchaseInvoiceNo], [SupplierId], [TotalPurchasePrice], [EnteredByUser_ID], [IsApproved], [OfficeId], [IsProcessed], [IsOffline]) VALUES (42, CAST(N'2021-05-23T14:55:31.110' AS DateTime), N'9b1e556c-aad0-41f3-8852-76ad5b2840a1', N'p-1001', 11, CAST(28540.000000 AS Decimal(18, 6)), 1, 1, 1, 0, 0)
GO
INSERT [dbo].[Purchases] ([Id], [PurchaseDateTime], [InvoiceNumber], [PurchaseInvoiceNo], [SupplierId], [TotalPurchasePrice], [EnteredByUser_ID], [IsApproved], [OfficeId], [IsProcessed], [IsOffline]) VALUES (43, CAST(N'2021-05-27T22:02:35.860' AS DateTime), N'a73d7a5a-3eef-4aae-a2a8-98daf95b2f51', N'p-1001', 10, CAST(41000.000000 AS Decimal(18, 6)), 1, 1, 1, 0, 0)
GO
SET IDENTITY_INSERT [dbo].[Purchases] OFF
GO
SET IDENTITY_INSERT [dbo].[PurchasesDetails] ON 
GO
INSERT [dbo].[PurchasesDetails] ([StockID], [SerialNumber], [CompanyId], [ProductTypeId], [ProductId], [PurchasePrice], [ReceivedQuantity], [TotalPurchasePrice], [EnteredByUserId], [IsApproved], [InvoiceNumber], [PurchaseId], [ProductName]) VALUES (18689, N'0', 1, 3039, 12846, CAST(1000.000000 AS Decimal(18, 6)), CAST(10.000000 AS Decimal(18, 6)), CAST(10000.000000 AS Decimal(18, 6)), 1, 1, N'00164055-76a8-40a1-81b5-7d3297b708ea', 41, N'1268')
GO
INSERT [dbo].[PurchasesDetails] ([StockID], [SerialNumber], [CompanyId], [ProductTypeId], [ProductId], [PurchasePrice], [ReceivedQuantity], [TotalPurchasePrice], [EnteredByUserId], [IsApproved], [InvoiceNumber], [PurchaseId], [ProductName]) VALUES (18690, N'0', 1, 3039, 12845, CAST(1200.000000 AS Decimal(18, 6)), CAST(10.000000 AS Decimal(18, 6)), CAST(12000.000000 AS Decimal(18, 6)), 1, 1, N'00164055-76a8-40a1-81b5-7d3297b708ea', 41, N'7210')
GO
INSERT [dbo].[PurchasesDetails] ([StockID], [SerialNumber], [CompanyId], [ProductTypeId], [ProductId], [PurchasePrice], [ReceivedQuantity], [TotalPurchasePrice], [EnteredByUserId], [IsApproved], [InvoiceNumber], [PurchaseId], [ProductName]) VALUES (18691, N'0', 1, 3039, 12847, CAST(1540.000000 AS Decimal(18, 6)), CAST(10.000000 AS Decimal(18, 6)), CAST(15400.000000 AS Decimal(18, 6)), 1, 1, N'00164055-76a8-40a1-81b5-7d3297b708ea', 41, N'Item 3')
GO
INSERT [dbo].[PurchasesDetails] ([StockID], [SerialNumber], [CompanyId], [ProductTypeId], [ProductId], [PurchasePrice], [ReceivedQuantity], [TotalPurchasePrice], [EnteredByUserId], [IsApproved], [InvoiceNumber], [PurchaseId], [ProductName]) VALUES (18692, N'0', 1, 3039, 12846, CAST(1000.000000 AS Decimal(18, 6)), CAST(10.000000 AS Decimal(18, 6)), CAST(10000.000000 AS Decimal(18, 6)), 1, 1, N'9b1e556c-aad0-41f3-8852-76ad5b2840a1', 42, N'1268')
GO
INSERT [dbo].[PurchasesDetails] ([StockID], [SerialNumber], [CompanyId], [ProductTypeId], [ProductId], [PurchasePrice], [ReceivedQuantity], [TotalPurchasePrice], [EnteredByUserId], [IsApproved], [InvoiceNumber], [PurchaseId], [ProductName]) VALUES (18694, N'0', 1, 3039, 12847, CAST(1545.000000 AS Decimal(18, 6)), CAST(12.000000 AS Decimal(18, 6)), CAST(18540.000000 AS Decimal(18, 6)), 1, 1, N'9b1e556c-aad0-41f3-8852-76ad5b2840a1', 42, N'Item 3')
GO
INSERT [dbo].[PurchasesDetails] ([StockID], [SerialNumber], [CompanyId], [ProductTypeId], [ProductId], [PurchasePrice], [ReceivedQuantity], [TotalPurchasePrice], [EnteredByUserId], [IsApproved], [InvoiceNumber], [PurchaseId], [ProductName]) VALUES (18695, N'1', 1, 3039, 12846, CAST(1000.000000 AS Decimal(18, 6)), CAST(10.000000 AS Decimal(18, 6)), CAST(10000.000000 AS Decimal(18, 6)), 1, 1, N'a73d7a5a-3eef-4aae-a2a8-98daf95b2f51', 43, N'1268')
GO
INSERT [dbo].[PurchasesDetails] ([StockID], [SerialNumber], [CompanyId], [ProductTypeId], [ProductId], [PurchasePrice], [ReceivedQuantity], [TotalPurchasePrice], [EnteredByUserId], [IsApproved], [InvoiceNumber], [PurchaseId], [ProductName]) VALUES (18696, N'1', 1, 3039, 12845, CAST(1200.000000 AS Decimal(18, 6)), CAST(10.000000 AS Decimal(18, 6)), CAST(12000.000000 AS Decimal(18, 6)), 1, 1, N'a73d7a5a-3eef-4aae-a2a8-98daf95b2f51', 43, N'7210')
GO
INSERT [dbo].[PurchasesDetails] ([StockID], [SerialNumber], [CompanyId], [ProductTypeId], [ProductId], [PurchasePrice], [ReceivedQuantity], [TotalPurchasePrice], [EnteredByUserId], [IsApproved], [InvoiceNumber], [PurchaseId], [ProductName]) VALUES (18697, N'1', 1, 3039, 12847, CAST(1900.000000 AS Decimal(18, 6)), CAST(10.000000 AS Decimal(18, 6)), CAST(19000.000000 AS Decimal(18, 6)), 1, 1, N'a73d7a5a-3eef-4aae-a2a8-98daf95b2f51', 43, N'Item 3')
GO
SET IDENTITY_INSERT [dbo].[PurchasesDetails] OFF
GO
SET IDENTITY_INSERT [dbo].[SaleTypes] ON 
GO
INSERT [dbo].[SaleTypes] ([SaleTypeID], [SaleType]) VALUES (1, N'Cash')
GO
INSERT [dbo].[SaleTypes] ([SaleTypeID], [SaleType]) VALUES (2, N'Credit')
GO
SET IDENTITY_INSERT [dbo].[SaleTypes] OFF
GO
SET IDENTITY_INSERT [dbo].[StockPoints] ON 
GO
INSERT [dbo].[StockPoints] ([Id], [StockPoint]) VALUES (1, N'Manufacturing Point')
GO
INSERT [dbo].[StockPoints] ([Id], [StockPoint]) VALUES (2, N'Storage Godown 1')
GO
INSERT [dbo].[StockPoints] ([Id], [StockPoint]) VALUES (3, N'Storage Godown 2')
GO
SET IDENTITY_INSERT [dbo].[StockPoints] OFF
GO
SET IDENTITY_INSERT [dbo].[Stocks] ON 
GO
INSERT [dbo].[Stocks] ([Id], [StockPointId], [InvoiceNumber], [SerialNumber], [ProductId], [Quantity], [PurchasePrice], [Consumed], [IsReturned], [IsApproved], [PurchaseDetailId]) VALUES (7, 1, N'00164055-76a8-40a1-81b5-7d3297b708ea', N'0', 12846, CAST(10.000000 AS Decimal(18, 6)), CAST(1000.000000 AS Decimal(18, 6)), CAST(10.000000 AS Decimal(18, 6)), 0, 1, 18689)
GO
INSERT [dbo].[Stocks] ([Id], [StockPointId], [InvoiceNumber], [SerialNumber], [ProductId], [Quantity], [PurchasePrice], [Consumed], [IsReturned], [IsApproved], [PurchaseDetailId]) VALUES (8, 1, N'00164055-76a8-40a1-81b5-7d3297b708ea', N'0', 12845, CAST(10.000000 AS Decimal(18, 6)), CAST(1200.000000 AS Decimal(18, 6)), CAST(0.000000 AS Decimal(18, 6)), 0, 1, 18690)
GO
INSERT [dbo].[Stocks] ([Id], [StockPointId], [InvoiceNumber], [SerialNumber], [ProductId], [Quantity], [PurchasePrice], [Consumed], [IsReturned], [IsApproved], [PurchaseDetailId]) VALUES (9, 1, N'00164055-76a8-40a1-81b5-7d3297b708ea', N'0', 12847, CAST(10.000000 AS Decimal(18, 6)), CAST(1540.000000 AS Decimal(18, 6)), CAST(0.000000 AS Decimal(18, 6)), 0, 1, 18691)
GO
INSERT [dbo].[Stocks] ([Id], [StockPointId], [InvoiceNumber], [SerialNumber], [ProductId], [Quantity], [PurchasePrice], [Consumed], [IsReturned], [IsApproved], [PurchaseDetailId]) VALUES (10, 1, N'9b1e556c-aad0-41f3-8852-76ad5b2840a1', N'0', 12846, CAST(10.000000 AS Decimal(18, 6)), CAST(1000.000000 AS Decimal(18, 6)), CAST(0.000000 AS Decimal(18, 6)), 0, 1, 18692)
GO
INSERT [dbo].[Stocks] ([Id], [StockPointId], [InvoiceNumber], [SerialNumber], [ProductId], [Quantity], [PurchasePrice], [Consumed], [IsReturned], [IsApproved], [PurchaseDetailId]) VALUES (12, 1, N'9b1e556c-aad0-41f3-8852-76ad5b2840a1', N'0', 12847, CAST(12.000000 AS Decimal(18, 6)), CAST(1545.000000 AS Decimal(18, 6)), CAST(0.000000 AS Decimal(18, 6)), 0, 1, 18694)
GO
INSERT [dbo].[Stocks] ([Id], [StockPointId], [InvoiceNumber], [SerialNumber], [ProductId], [Quantity], [PurchasePrice], [Consumed], [IsReturned], [IsApproved], [PurchaseDetailId]) VALUES (13, 1, N'a73d7a5a-3eef-4aae-a2a8-98daf95b2f51', N'1', 12846, CAST(10.000000 AS Decimal(18, 6)), CAST(1000.000000 AS Decimal(18, 6)), CAST(0.000000 AS Decimal(18, 6)), 0, 1, 18695)
GO
INSERT [dbo].[Stocks] ([Id], [StockPointId], [InvoiceNumber], [SerialNumber], [ProductId], [Quantity], [PurchasePrice], [Consumed], [IsReturned], [IsApproved], [PurchaseDetailId]) VALUES (14, 1, N'a73d7a5a-3eef-4aae-a2a8-98daf95b2f51', N'1', 12845, CAST(10.000000 AS Decimal(18, 6)), CAST(1200.000000 AS Decimal(18, 6)), CAST(0.000000 AS Decimal(18, 6)), 0, 1, 18696)
GO
INSERT [dbo].[Stocks] ([Id], [StockPointId], [InvoiceNumber], [SerialNumber], [ProductId], [Quantity], [PurchasePrice], [Consumed], [IsReturned], [IsApproved], [PurchaseDetailId]) VALUES (15, 1, N'a73d7a5a-3eef-4aae-a2a8-98daf95b2f51', N'1', 12847, CAST(10.000000 AS Decimal(18, 6)), CAST(1900.000000 AS Decimal(18, 6)), CAST(0.000000 AS Decimal(18, 6)), 0, 1, 18697)
GO
SET IDENTITY_INSERT [dbo].[Stocks] OFF
GO
SET IDENTITY_INSERT [dbo].[Users] ON 
GO
INSERT [dbo].[Users] ([UserID], [UserName], [Password], [IsActive], [IsAdmin], [OfficeId], [IsSync]) VALUES (1, N'Administrator', N'Alzafar', 1, 1, 1, 0)
GO
INSERT [dbo].[Users] ([UserID], [UserName], [Password], [IsActive], [IsAdmin], [OfficeId], [IsSync]) VALUES (1008, N'Faisal', N'123', 0, 0, 1, 0)
GO
INSERT [dbo].[Users] ([UserID], [UserName], [Password], [IsActive], [IsAdmin], [OfficeId], [IsSync]) VALUES (1009, N'Faisal', N'123', 1, 0, 1, 0)
GO
SET IDENTITY_INSERT [dbo].[Users] OFF
GO
INSERT [dbo].[VoucherTypes] ([Id], [VoucherType], [IsSync]) VALUES (1, N'Journal', NULL)
GO
INSERT [dbo].[VoucherTypes] ([Id], [VoucherType], [IsSync]) VALUES (2, N'Cash Payment', NULL)
GO
INSERT [dbo].[VoucherTypes] ([Id], [VoucherType], [IsSync]) VALUES (3, N'Cash Receipt', NULL)
GO
INSERT [dbo].[VoucherTypes] ([Id], [VoucherType], [IsSync]) VALUES (4, N'Bank Payment', NULL)
GO
INSERT [dbo].[VoucherTypes] ([Id], [VoucherType], [IsSync]) VALUES (5, N'Bank Receipt', NULL)
GO
ALTER TABLE [dbo].[AccountDetails] ADD  CONSTRAINT [DF_AccountDetails_IsSync]  DEFAULT ((0)) FOR [IsSync]
GO
ALTER TABLE [dbo].[Accounts] ADD  CONSTRAINT [DF_Accounts_IsSync]  DEFAULT ((0)) FOR [IsSync]
GO
ALTER TABLE [dbo].[ControlAccounts] ADD  CONSTRAINT [DF_ControlAccounts_IsSync]  DEFAULT ((0)) FOR [IsSync]
GO
ALTER TABLE [dbo].[Heads] ADD  CONSTRAINT [DF_Heads_IsSync]  DEFAULT ((0)) FOR [IsSync]
GO
ALTER TABLE [dbo].[Purchases] ADD  CONSTRAINT [DF_Purchases_IsApproved]  DEFAULT ((0)) FOR [IsApproved]
GO
ALTER TABLE [dbo].[PurchasesDetails] ADD  CONSTRAINT [DF_Purchases_Detail_IsApprovedd]  DEFAULT ((0)) FOR [IsApproved]
GO
ALTER TABLE [dbo].[SalesDetail] ADD  CONSTRAINT [DF_Sales_IsReturned]  DEFAULT ((0)) FOR [IsReturned]
GO
ALTER TABLE [dbo].[SalesDetail] ADD  CONSTRAINT [DF_Sales_Detail_IsApproved]  DEFAULT ((0)) FOR [IsApproved]
GO
ALTER TABLE [dbo].[ShareHolderDetails] ADD  CONSTRAINT [DF_ShareHolderDetails_ShareHolderAccountCreated]  DEFAULT ((0)) FOR [ShareHolderAccountCreated]
GO
ALTER TABLE [dbo].[Stocks] ADD  CONSTRAINT [DF_Stock_IsReturned]  DEFAULT ((0)) FOR [IsReturned]
GO
ALTER TABLE [dbo].[Stocks] ADD  CONSTRAINT [DF_Stock_IsApproved]  DEFAULT ((0)) FOR [IsApproved]
GO
ALTER TABLE [dbo].[Transactions] ADD  CONSTRAINT [DF_Transacstions_Stock_ID]  DEFAULT ((0)) FOR [SaleId]
GO
ALTER TABLE [dbo].[Transactions] ADD  CONSTRAINT [DF_Transacstions_IsApproved]  DEFAULT ((0)) FOR [IsApproved]
GO
ALTER TABLE [dbo].[Users] ADD  CONSTRAINT [DF_Users_IsActive]  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[Users] ADD  CONSTRAINT [DF_Users_IsAdmin]  DEFAULT ((0)) FOR [IsAdmin]
GO
ALTER TABLE [dbo].[Users] ADD  CONSTRAINT [DF_Users_IsSync]  DEFAULT ((0)) FOR [IsSync]
GO
ALTER TABLE [dbo].[Users_AllowedOffices] ADD  CONSTRAINT [DF_Users_AllowedOffices_IsCurrent]  DEFAULT ((0)) FOR [IsCurrent]
GO
ALTER TABLE [dbo].[VoucherTypes] ADD  CONSTRAINT [DF_VoucherTypes_IsSync]  DEFAULT ((0)) FOR [IsSync]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'In case of manual entry offline sales will be uploaded without checking if there is stock available or not so this field will be processed by a cron job and entries will be processed in transaction and in stock after uploading.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sales', @level2type=N'COLUMN',@level2name=N'IsProcessed'
GO
USE [master]
GO
ALTER DATABASE [admire] SET  READ_WRITE 
GO
