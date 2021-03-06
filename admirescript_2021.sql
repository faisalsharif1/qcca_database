USE [master]
GO
/****** Object:  Database [admire]    Script Date: 4/9/2021 3:34:35 PM ******/
CREATE DATABASE [admire]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'admire', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\admire.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'admire_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\admire_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [admire] SET COMPATIBILITY_LEVEL = 140
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
ALTER DATABASE [admire] SET RECOVERY FULL 
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
EXEC sys.sp_db_vardecimal_storage_format N'admire', N'ON'
GO
ALTER DATABASE [admire] SET QUERY_STORE = OFF
GO
USE [admire]
GO
/****** Object:  Table [dbo].[AccountDetails]    Script Date: 4/9/2021 3:34:35 PM ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Accounts]    Script Date: 4/9/2021 3:34:35 PM ******/
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
 CONSTRAINT [PK_Accounts] PRIMARY KEY CLUSTERED 
(
	[AccountID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Companies]    Script Date: 4/9/2021 3:34:35 PM ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ControlAccounts]    Script Date: 4/9/2021 3:34:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ControlAccounts](
	[ControlAccountID] [int] IDENTITY(1,1) NOT NULL,
	[ControlAccountName] [varchar](50) NULL,
	[HeadId] [int] NULL,
	[IsSync] [bit] NULL,
 CONSTRAINT [PK_ControlAccounts] PRIMARY KEY CLUSTERED 
(
	[ControlAccountID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Heads]    Script Date: 4/9/2021 3:34:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Heads](
	[AccountTypeId] [int] NOT NULL,
	[AccountType] [varchar](50) NULL,
	[IsSync] [bit] NULL,
 CONSTRAINT [PK_AccountTypes] PRIMARY KEY CLUSTERED 
(
	[AccountTypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MainStockHistory]    Script Date: 4/9/2021 3:34:35 PM ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ManufacturedItems]    Script Date: 4/9/2021 3:34:35 PM ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ManufacturedItems_AdditionalCost]    Script Date: 4/9/2021 3:34:35 PM ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ManufacturedItems_RawMaterialUsed]    Script Date: 4/9/2021 3:34:35 PM ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ManufacturedItemsComposition]    Script Date: 4/9/2021 3:34:35 PM ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProductCategories]    Script Date: 4/9/2021 3:34:35 PM ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Products]    Script Date: 4/9/2021 3:34:35 PM ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProductTypes]    Script Date: 4/9/2021 3:34:35 PM ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Purchases]    Script Date: 4/9/2021 3:34:35 PM ******/
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
	[StockPointId] [int] NULL,
	[IsProcessed] [bit] NULL,
	[IsOffline] [bit] NULL,
	[OfficeId] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PurchasesDetail]    Script Date: 4/9/2021 3:34:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PurchasesDetail](
	[StockID] [int] IDENTITY(1,1) NOT NULL,
	[PurchaseId] [int] NULL,
	[SerialNumber] [varchar](50) NULL,
	[CompanyId] [int] NULL,
	[ProductTypeId] [int] NULL,
	[ProductId] [int] NULL,
	[PurchasePrice] [decimal](18, 6) NULL,
	[ReceivedQuantity] [int] NULL,
	[TotalPurchasePrice] [decimal](18, 6) NULL,
	[EnteredByUserId] [int] NULL,
	[IsApproved] [bit] NULL,
 CONSTRAINT [PK_MainOfficeStock] PRIMARY KEY CLUSTERED 
(
	[StockID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PurchasesReturns]    Script Date: 4/9/2021 3:34:35 PM ******/
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
	[ReturnPrice] [money] NULL,
	[ReturnQuantity] [money] NULL,
	[ReturnTotalPrice] [money] NULL,
	[UserId] [int] NULL,
	[OfficeId] [int] NULL,
 CONSTRAINT [PK_PurchasesReturns] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Sales]    Script Date: 4/9/2021 3:34:35 PM ******/
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
	[CashReceived] [money] NULL,
	[Balance] [money] NULL,
	[TotalSalePrice] [money] NULL,
	[IsPercentDiscount] [bit] NULL,
	[DiscountValue] [money] NULL,
	[DiscountCalculated] [money] NULL,
	[UserID] [int] NULL,
	[IsApproved] [bit] NULL,
	[IsProcessed] [bit] NULL,
	[IsOffline] [bit] NULL,
	[OfficeId] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SalesDetail]    Script Date: 4/9/2021 3:34:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SalesDetail](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[SaleId] [int] NULL,
	[SerialNumber] [varchar](50) NULL,
	[ProductId] [int] NULL,
	[Quantity] [money] NULL,
	[SalePrice] [money] NULL,
	[IsReturned] [bit] NULL,
	[ReturnDateTime] [datetime] NULL,
	[UserID] [int] NULL,
	[IsApproved] [bit] NULL,
 CONSTRAINT [PK_Sales] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SalesDetailStock]    Script Date: 4/9/2021 3:34:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SalesDetailStock](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[StockId] [int] NULL,
	[SaleId] [int] NULL,
	[ProductId] [int] NULL,
	[PurchasePrice] [money] NULL,
	[Quantity] [money] NULL,
 CONSTRAINT [PK_SalesDetailStock] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SaleTypes]    Script Date: 4/9/2021 3:34:35 PM ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ShareHolderDetails]    Script Date: 4/9/2021 3:34:35 PM ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Stock]    Script Date: 4/9/2021 3:34:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Stock](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[StockPointId] [int] NULL,
	[InvoiceNumber] [uniqueidentifier] NULL,
	[SerialNumber] [varchar](50) NULL,
	[ProductId] [int] NULL,
	[Quantity] [money] NULL,
	[PurchasePrice] [money] NULL,
	[Consumed] [money] NULL,
	[IsReturned] [bit] NULL,
	[IsApproved] [bit] NULL,
 CONSTRAINT [PK_Stock_1] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[StockPoints]    Script Date: 4/9/2021 3:34:36 PM ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Transactions]    Script Date: 4/9/2021 3:34:36 PM ******/
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
	[TransactionAmount] [money] NULL,
	[AccountId] [int] NULL,
	[UserId] [int] NULL,
	[SaleId] [int] NULL,
	[PurchaseId] [int] NULL,
	[IsApproved] [bit] NULL,
	[Quantity] [money] NULL,
	[ProductTypeId] [int] NULL,
 CONSTRAINT [PK_Transacstions] PRIMARY KEY CLUSTERED 
(
	[TransactionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 4/9/2021 3:34:36 PM ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users_AllowedOffices]    Script Date: 4/9/2021 3:34:36 PM ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[VoucherTypes]    Script Date: 4/9/2021 3:34:36 PM ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
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
ALTER TABLE [dbo].[PurchasesDetail] ADD  CONSTRAINT [DF_Purchases_Detail_IsApprovedd]  DEFAULT ((0)) FOR [IsApproved]
GO
ALTER TABLE [dbo].[SalesDetail] ADD  CONSTRAINT [DF_Sales_IsReturned]  DEFAULT ((0)) FOR [IsReturned]
GO
ALTER TABLE [dbo].[SalesDetail] ADD  CONSTRAINT [DF_Sales_Detail_IsApproved]  DEFAULT ((0)) FOR [IsApproved]
GO
ALTER TABLE [dbo].[ShareHolderDetails] ADD  CONSTRAINT [DF_ShareHolderDetails_ShareHolderAccountCreated]  DEFAULT ((0)) FOR [ShareHolderAccountCreated]
GO
ALTER TABLE [dbo].[Stock] ADD  CONSTRAINT [DF_Stock_IsReturned]  DEFAULT ((0)) FOR [IsReturned]
GO
ALTER TABLE [dbo].[Stock] ADD  CONSTRAINT [DF_Stock_IsApproved]  DEFAULT ((0)) FOR [IsApproved]
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
