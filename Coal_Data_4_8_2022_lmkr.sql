USE [master]
GO
/****** Object:  Database [CoalSelling]    Script Date: 4/8/2022 12:33:20 PM ******/
CREATE DATABASE [CoalSelling]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'CoalSelling', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\CoalSelling.mdf' , SIZE = 3264KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'CoalSelling_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\CoalSelling_log.ldf' , SIZE = 1600KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [CoalSelling] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [CoalSelling].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [CoalSelling] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [CoalSelling] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [CoalSelling] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [CoalSelling] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [CoalSelling] SET ARITHABORT OFF 
GO
ALTER DATABASE [CoalSelling] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [CoalSelling] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [CoalSelling] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [CoalSelling] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [CoalSelling] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [CoalSelling] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [CoalSelling] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [CoalSelling] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [CoalSelling] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [CoalSelling] SET  DISABLE_BROKER 
GO
ALTER DATABASE [CoalSelling] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [CoalSelling] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [CoalSelling] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [CoalSelling] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [CoalSelling] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [CoalSelling] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [CoalSelling] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [CoalSelling] SET RECOVERY FULL 
GO
ALTER DATABASE [CoalSelling] SET  MULTI_USER 
GO
ALTER DATABASE [CoalSelling] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [CoalSelling] SET DB_CHAINING OFF 
GO
ALTER DATABASE [CoalSelling] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [CoalSelling] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [CoalSelling] SET DELAYED_DURABILITY = DISABLED 
GO
USE [CoalSelling]
GO
/****** Object:  UserDefinedTableType [dbo].[ItemsList]    Script Date: 4/8/2022 12:33:20 PM ******/
CREATE TYPE [dbo].[ItemsList] AS TABLE(
	[Id] [int] NULL,
	[ItemId] [int] NULL,
	[UnitId] [int] NULL,
	[Quantity] [money] NULL,
	[UnitPrice] [money] NULL,
	[TotalPrice] [money] NULL
)
GO
/****** Object:  UserDefinedFunction [dbo].[GenerateInvoiceNo]    Script Date: 4/8/2022 12:33:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[GenerateInvoiceNo] (@Id INT)
RETURNS BIGINT
AS
BEGIN
	DECLARE @Number BIGINT
	SET @Number = CONCAT(YEAR(GETDATE()),MONTH(GETDATE()),DAY(GETDATE()),
			DATEPART(HOUR,GETDATE()),DATEPART(MINUTE,GETDATE()),DATEPART(SECOND,GETDATE()),DATEPART(MILLISECOND,GETDATE()),
			@Id)
	RETURN @Number
END

GO
/****** Object:  Table [dbo].[Accounts]    Script Date: 4/8/2022 12:33:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Accounts](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[AccountName] [nvarchar](max) NULL,
	[MobileNo] [nvarchar](max) NULL,
	[Address] [nvarchar](max) NULL,
	[AccountTypeId] [int] NULL,
 CONSTRAINT [PK_Customers] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AccountTypes]    Script Date: 4/8/2022 12:33:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AccountTypes](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[AccountType] [nvarchar](50) NULL,
 CONSTRAINT [PK_AccountTypes] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CoalData]    Script Date: 4/8/2022 12:33:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CoalData](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[EntryDateTime] [datetime] NULL,
	[VehicleNumber] [nvarchar](max) NULL,
	[TotalTons] [money] NULL,
	[PerTonRate] [money] NULL,
	[TotalValue] [money] NULL,
	[Particulars] [nvarchar](max) NULL,
	[DriverName] [nvarchar](max) NULL,
	[DriverContactNo] [nvarchar](max) NULL,
	[CustomerId] [int] NULL,
	[MineId] [int] NULL,
	[UserId] [int] NULL,
	[InvoiceNumber] [bigint] NULL,
 CONSTRAINT [PK_CoalData] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Employees]    Script Date: 4/8/2022 12:33:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Employees](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[EntryDate] [date] NULL,
	[EmployeeName] [nvarchar](max) NULL,
	[EmployeeFatherName] [nvarchar](max) NULL,
	[EmployeeAddress] [nvarchar](max) NULL,
	[EmployeeMobileNo] [nvarchar](max) NULL,
	[EmployeePicture] [nvarchar](max) NULL,
	[EmployeeSalary] [money] NULL,
 CONSTRAINT [PK_Table_1] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ItemIssuance]    Script Date: 4/8/2022 12:33:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ItemIssuance](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IssuanceDateTime] [datetime] NULL,
	[ItemId] [int] NULL,
	[UnitId] [int] NULL,
	[Quantity] [money] NULL,
	[AveragePrice] [money] NULL,
	[MineId] [int] NULL,
	[ProjectId] [int] NULL,
	[UserId] [int] NULL,
	[InvoiceNumber] [bigint] NULL,
	[Particulars] [nvarchar](max) NULL,
 CONSTRAINT [PK_ItemIssiance] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Items]    Script Date: 4/8/2022 12:33:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Items](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ItemName] [nvarchar](max) NULL,
 CONSTRAINT [PK_Items] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Mines]    Script Date: 4/8/2022 12:33:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Mines](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[MineName] [nvarchar](max) NULL,
 CONSTRAINT [PK_Mines] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PlainTransaction]    Script Date: 4/8/2022 12:33:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PlainTransaction](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[EntryDateTime] [datetime] NULL,
	[FromAccountId] [int] NULL,
	[ToAccountId] [int] NULL,
	[Particulars] [nvarchar](max) NULL,
	[BillNumber] [nvarchar](50) NULL,
	[Amount] [money] NULL,
	[MineId] [int] NULL,
	[ProjectId] [int] NULL,
	[InvoiceNumber] [bigint] NULL,
	[BillPicture] [nvarchar](max) NULL,
 CONSTRAINT [PK_PlainTransaction] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Projects]    Script Date: 4/8/2022 12:33:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Projects](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ProjectName] [nvarchar](200) NULL,
 CONSTRAINT [PK_Projects] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Purchases]    Script Date: 4/8/2022 12:33:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Purchases](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[EntryDateTime] [datetime] NULL,
	[SupplierId] [int] NULL,
	[BillNumber] [nvarchar](50) NULL,
	[Particulars] [nvarchar](max) NULL,
	[InvoiceNumber] [bigint] NULL,
	[TotalAmount] [money] NULL,
	[UserId] [int] NULL,
	[BillPicture] [varchar](500) NULL,
 CONSTRAINT [PK_Purchases] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Stock]    Script Date: 4/8/2022 12:33:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Stock](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ItemId] [int] NULL,
	[UnitId] [int] NULL,
	[Quantity] [money] NULL,
	[UnitPrice] [money] NULL,
	[TotalPrice] [money] NULL,
	[UserId] [int] NULL,
	[InvoiceNumber] [bigint] NULL,
	[ConsumedDirectly] [bit] NULL,
 CONSTRAINT [PK_Stock] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Transactions]    Script Date: 4/8/2022 12:33:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Transactions](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[EntryDateTime] [datetime] NULL,
	[AccountId] [int] NULL,
	[Particulars] [nvarchar](max) NULL,
	[BillNumber] [nvarchar](50) NULL,
	[Amount] [money] NULL,
	[TotalTons] [money] NULL,
	[PerTonRate] [money] NULL,
	[InvoiceNumber] [bigint] NULL,
	[UserId] [int] NULL,
	[MineId] [int] NULL,
	[ProjectId] [int] NULL,
	[BillPicture] [nvarchar](max) NULL,
 CONSTRAINT [PK_Transactions] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Units]    Script Date: 4/8/2022 12:33:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Units](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UnitName] [nvarchar](50) NULL,
 CONSTRAINT [PK_Units] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 4/8/2022 12:33:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserName] [nvarchar](max) NULL,
	[Password] [nvarchar](max) NULL,
	[IsActive] [bit] NULL,
 CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[VoucherNumbers]    Script Date: 4/8/2022 12:33:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[VoucherNumbers](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[VoucherNumber] [bigint] NOT NULL,
 CONSTRAINT [PK_VoucherNumbers] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Accounts] ON 
GO
INSERT [dbo].[Accounts] ([Id], [AccountName], [MobileNo], [Address], [AccountTypeId]) VALUES (1003, N'Faisal Sharif Torkhel', N'03339191092', N'D', 1)
GO
INSERT [dbo].[Accounts] ([Id], [AccountName], [MobileNo], [Address], [AccountTypeId]) VALUES (1004, N'Food Expenses', NULL, NULL, 3)
GO
INSERT [dbo].[Accounts] ([Id], [AccountName], [MobileNo], [Address], [AccountTypeId]) VALUES (1005, N'Salary Expense', NULL, NULL, 3)
GO
INSERT [dbo].[Accounts] ([Id], [AccountName], [MobileNo], [Address], [AccountTypeId]) VALUES (1006, N'Bank Alfalah 21343434343', NULL, NULL, 1006)
GO
INSERT [dbo].[Accounts] ([Id], [AccountName], [MobileNo], [Address], [AccountTypeId]) VALUES (1007, N'JS Bank 34343434343', NULL, NULL, 1006)
GO
SET IDENTITY_INSERT [dbo].[Accounts] OFF
GO
SET IDENTITY_INSERT [dbo].[AccountTypes] ON 
GO
INSERT [dbo].[AccountTypes] ([Id], [AccountType]) VALUES (1, N'Customers')
GO
INSERT [dbo].[AccountTypes] ([Id], [AccountType]) VALUES (2, N'General')
GO
INSERT [dbo].[AccountTypes] ([Id], [AccountType]) VALUES (3, N'Expenses')
GO
INSERT [dbo].[AccountTypes] ([Id], [AccountType]) VALUES (4, N'Stock')
GO
INSERT [dbo].[AccountTypes] ([Id], [AccountType]) VALUES (5, N'Suppliers')
GO
INSERT [dbo].[AccountTypes] ([Id], [AccountType]) VALUES (1006, N'Banks')
GO
INSERT [dbo].[AccountTypes] ([Id], [AccountType]) VALUES (2007, N'test')
GO
SET IDENTITY_INSERT [dbo].[AccountTypes] OFF
GO
SET IDENTITY_INSERT [dbo].[CoalData] ON 
GO
INSERT [dbo].[CoalData] ([Id], [EntryDateTime], [VehicleNumber], [TotalTons], [PerTonRate], [TotalValue], [Particulars], [DriverName], [DriverContactNo], [CustomerId], [MineId], [UserId], [InvoiceNumber]) VALUES (4, CAST(N'2022-03-12T00:00:00.000' AS DateTime), N'ANJ774', 20.0000, 22300.0000, 12000.0000, N'FDAHFAKJSHDFLJKADSFHASH', N'drIVER', N'033333', 1003, 1002, 0, 202231217541300)
GO
INSERT [dbo].[CoalData] ([Id], [EntryDateTime], [VehicleNumber], [TotalTons], [PerTonRate], [TotalValue], [Particulars], [DriverName], [DriverContactNo], [CustomerId], [MineId], [UserId], [InvoiceNumber]) VALUES (5, CAST(N'2022-03-20T00:00:00.000' AS DateTime), N'ANJ774', 26.0000, 28000.0000, 728000.0000, N'Snd', N'Faisal', N'Sharif', 1003, 1002, 0, 20223201234256670)
GO
INSERT [dbo].[CoalData] ([Id], [EntryDateTime], [VehicleNumber], [TotalTons], [PerTonRate], [TotalValue], [Particulars], [DriverName], [DriverContactNo], [CustomerId], [MineId], [UserId], [InvoiceNumber]) VALUES (6, CAST(N'2022-03-20T00:00:00.000' AS DateTime), N'ANJ774', 10.0000, 15000.0000, 150000.0000, N'test', NULL, NULL, 1003, 1002, 0, 20223201411109100)
GO
INSERT [dbo].[CoalData] ([Id], [EntryDateTime], [VehicleNumber], [TotalTons], [PerTonRate], [TotalValue], [Particulars], [DriverName], [DriverContactNo], [CustomerId], [MineId], [UserId], [InvoiceNumber]) VALUES (7, CAST(N'2022-03-20T00:00:00.000' AS DateTime), N'anj774', 10.0000, 18000.0000, 18000.0000, N'test', NULL, NULL, 1003, 1003, 0, 20223201413506900)
GO
INSERT [dbo].[CoalData] ([Id], [EntryDateTime], [VehicleNumber], [TotalTons], [PerTonRate], [TotalValue], [Particulars], [DriverName], [DriverContactNo], [CustomerId], [MineId], [UserId], [InvoiceNumber]) VALUES (8, CAST(N'2022-03-20T00:00:00.000' AS DateTime), N'abcd', 10.0000, 15000.0000, 15000.0000, N'test', NULL, NULL, 1003, 1002, 0, 20223201414529670)
GO
SET IDENTITY_INSERT [dbo].[CoalData] OFF
GO
SET IDENTITY_INSERT [dbo].[ItemIssuance] ON 
GO
INSERT [dbo].[ItemIssuance] ([Id], [IssuanceDateTime], [ItemId], [UnitId], [Quantity], [AveragePrice], [MineId], [ProjectId], [UserId], [InvoiceNumber], [Particulars]) VALUES (1, CAST(N'2022-03-31T00:00:00.000' AS DateTime), 5, 1, 5.0000, 100.0000, 0, 0, NULL, 2022331111545160, N'Purchased From Supplier')
GO
INSERT [dbo].[ItemIssuance] ([Id], [IssuanceDateTime], [ItemId], [UnitId], [Quantity], [AveragePrice], [MineId], [ProjectId], [UserId], [InvoiceNumber], [Particulars]) VALUES (2, CAST(N'2022-04-01T00:00:00.000' AS DateTime), 5, 2, 120.0000, 150.0000, 1003, 0, 1, 2022411022114631, N'Purchased From Supplier')
GO
SET IDENTITY_INSERT [dbo].[ItemIssuance] OFF
GO
SET IDENTITY_INSERT [dbo].[Items] ON 
GO
INSERT [dbo].[Items] ([Id], [ItemName]) VALUES (5, N'Petrol')
GO
INSERT [dbo].[Items] ([Id], [ItemName]) VALUES (6, N'Diesel')
GO
INSERT [dbo].[Items] ([Id], [ItemName]) VALUES (7, N'Woods')
GO
SET IDENTITY_INSERT [dbo].[Items] OFF
GO
SET IDENTITY_INSERT [dbo].[Mines] ON 
GO
INSERT [dbo].[Mines] ([Id], [MineName]) VALUES (1002, N'Mine 1')
GO
INSERT [dbo].[Mines] ([Id], [MineName]) VALUES (1003, N'MIne 2')
GO
SET IDENTITY_INSERT [dbo].[Mines] OFF
GO
SET IDENTITY_INSERT [dbo].[PlainTransaction] ON 
GO
INSERT [dbo].[PlainTransaction] ([Id], [EntryDateTime], [FromAccountId], [ToAccountId], [Particulars], [BillNumber], [Amount], [MineId], [ProjectId], [InvoiceNumber], [BillPicture]) VALUES (1016, CAST(N'2022-03-12T00:00:00.000' AS DateTime), 1007, 0, N'میرا بلنس اس تاریخ کو یہ تھا', N'001', 1000000.0000, 0, 0, 20223121752182730, NULL)
GO
INSERT [dbo].[PlainTransaction] ([Id], [EntryDateTime], [FromAccountId], [ToAccountId], [Particulars], [BillNumber], [Amount], [MineId], [ProjectId], [InvoiceNumber], [BillPicture]) VALUES (1017, CAST(N'2022-03-12T00:00:00.000' AS DateTime), 1007, 1003, N'paid to faisal as software cost', N'002', 15000.0000, 0, 0, 2022312175334000, NULL)
GO
INSERT [dbo].[PlainTransaction] ([Id], [EntryDateTime], [FromAccountId], [ToAccountId], [Particulars], [BillNumber], [Amount], [MineId], [ProjectId], [InvoiceNumber], [BillPicture]) VALUES (1018, CAST(N'2022-03-12T00:00:00.000' AS DateTime), 1006, 1004, N'tea expense for faisal visit ', N'B', 150.0000, 0, 0, 20223121756178330, NULL)
GO
INSERT [dbo].[PlainTransaction] ([Id], [EntryDateTime], [FromAccountId], [ToAccountId], [Particulars], [BillNumber], [Amount], [MineId], [ProjectId], [InvoiceNumber], [BillPicture]) VALUES (1019, CAST(N'2022-03-01T00:00:00.000' AS DateTime), 1003, 1004, N'paid to faisal', NULL, 12000.0000, 1002, 1002, 2022331947574500, NULL)
GO
SET IDENTITY_INSERT [dbo].[PlainTransaction] OFF
GO
SET IDENTITY_INSERT [dbo].[Projects] ON 
GO
INSERT [dbo].[Projects] ([Id], [ProjectName]) VALUES (1002, N'Road To Mine 1')
GO
SET IDENTITY_INSERT [dbo].[Projects] OFF
GO
SET IDENTITY_INSERT [dbo].[Purchases] ON 
GO
INSERT [dbo].[Purchases] ([Id], [EntryDateTime], [SupplierId], [BillNumber], [Particulars], [InvoiceNumber], [TotalAmount], [UserId], [BillPicture]) VALUES (8, CAST(N'2022-03-17T00:00:00.000' AS DateTime), 1003, N'B-1001', N'Purchased From Supplier', 20223171358381100, 15000.0000, 0, NULL)
GO
INSERT [dbo].[Purchases] ([Id], [EntryDateTime], [SupplierId], [BillNumber], [Particulars], [InvoiceNumber], [TotalAmount], [UserId], [BillPicture]) VALUES (9, CAST(N'2022-03-20T00:00:00.000' AS DateTime), 1003, N'B=1001', N'Particulars', 2022320188159931, 1000.0000, 1, NULL)
GO
INSERT [dbo].[Purchases] ([Id], [EntryDateTime], [SupplierId], [BillNumber], [Particulars], [InvoiceNumber], [TotalAmount], [UserId], [BillPicture]) VALUES (10, CAST(N'2022-03-29T00:00:00.000' AS DateTime), 1003, N'b-1001', N'purchase by faisal', 20223291258436431, 736000.0000, 1, NULL)
GO
INSERT [dbo].[Purchases] ([Id], [EntryDateTime], [SupplierId], [BillNumber], [Particulars], [InvoiceNumber], [TotalAmount], [UserId], [BillPicture]) VALUES (1010, CAST(N'2022-04-06T00:00:00.000' AS DateTime), 1003, N'B-1001', N'Purchased From Supplier', 202246147562271, 15000.0000, 1, NULL)
GO
INSERT [dbo].[Purchases] ([Id], [EntryDateTime], [SupplierId], [BillNumber], [Particulars], [InvoiceNumber], [TotalAmount], [UserId], [BillPicture]) VALUES (1011, CAST(N'2022-04-06T00:00:00.000' AS DateTime), 1003, N'B-1001', N'particulars must be correct', 2022461419234971, 16000.0000, 1, N'488fad0452764cc8988270595f053e6c.jpg')
GO
INSERT [dbo].[Purchases] ([Id], [EntryDateTime], [SupplierId], [BillNumber], [Particulars], [InvoiceNumber], [TotalAmount], [UserId], [BillPicture]) VALUES (1012, CAST(N'2022-04-08T00:00:00.000' AS DateTime), 1003, N'B-1001', N'fdaf', 202248115458501, 100.0000, 1, N'493bde120d1f4e96ab317658b61141e2.jpeg')
GO
SET IDENTITY_INSERT [dbo].[Purchases] OFF
GO
SET IDENTITY_INSERT [dbo].[Stock] ON 
GO
INSERT [dbo].[Stock] ([Id], [ItemId], [UnitId], [Quantity], [UnitPrice], [TotalPrice], [UserId], [InvoiceNumber], [ConsumedDirectly]) VALUES (17, 5, 2, 100.0000, 150.0000, 15000.0000, 0, 20223171358381100, 0)
GO
INSERT [dbo].[Stock] ([Id], [ItemId], [UnitId], [Quantity], [UnitPrice], [TotalPrice], [UserId], [InvoiceNumber], [ConsumedDirectly]) VALUES (18, 5, 1, 10.0000, 100.0000, 1000.0000, 1, 2022320188159931, 0)
GO
INSERT [dbo].[Stock] ([Id], [ItemId], [UnitId], [Quantity], [UnitPrice], [TotalPrice], [UserId], [InvoiceNumber], [ConsumedDirectly]) VALUES (19, 5, 2, 100.0000, 150.0000, 15000.0000, 1, 20223291258436431, 0)
GO
INSERT [dbo].[Stock] ([Id], [ItemId], [UnitId], [Quantity], [UnitPrice], [TotalPrice], [UserId], [InvoiceNumber], [ConsumedDirectly]) VALUES (20, 6, 2, 150.0000, 140.0000, 21000.0000, 1, 20223291258436431, 0)
GO
INSERT [dbo].[Stock] ([Id], [ItemId], [UnitId], [Quantity], [UnitPrice], [TotalPrice], [UserId], [InvoiceNumber], [ConsumedDirectly]) VALUES (21, 7, 1, 1000.0000, 700.0000, 700000.0000, 1, 20223291258436431, 0)
GO
INSERT [dbo].[Stock] ([Id], [ItemId], [UnitId], [Quantity], [UnitPrice], [TotalPrice], [UserId], [InvoiceNumber], [ConsumedDirectly]) VALUES (1019, 5, 1, -5.0000, 100.0000, -500.0000, NULL, 2022331111545160, 0)
GO
INSERT [dbo].[Stock] ([Id], [ItemId], [UnitId], [Quantity], [UnitPrice], [TotalPrice], [UserId], [InvoiceNumber], [ConsumedDirectly]) VALUES (1020, 5, 2, -120.0000, 150.0000, -18000.0000, 1, 2022411022114631, 0)
GO
INSERT [dbo].[Stock] ([Id], [ItemId], [UnitId], [Quantity], [UnitPrice], [TotalPrice], [UserId], [InvoiceNumber], [ConsumedDirectly]) VALUES (1021, 5, 2, 100.0000, 150.0000, 15000.0000, 1, 202246147562271, 0)
GO
INSERT [dbo].[Stock] ([Id], [ItemId], [UnitId], [Quantity], [UnitPrice], [TotalPrice], [UserId], [InvoiceNumber], [ConsumedDirectly]) VALUES (1022, 5, 2, 100.0000, 160.0000, 16000.0000, 1, 2022461419234971, 0)
GO
INSERT [dbo].[Stock] ([Id], [ItemId], [UnitId], [Quantity], [UnitPrice], [TotalPrice], [UserId], [InvoiceNumber], [ConsumedDirectly]) VALUES (1023, 5, 1, 10.0000, 10.0000, 100.0000, 1, 202248115458501, 0)
GO
SET IDENTITY_INSERT [dbo].[Stock] OFF
GO
SET IDENTITY_INSERT [dbo].[Transactions] ON 
GO
INSERT [dbo].[Transactions] ([Id], [EntryDateTime], [AccountId], [Particulars], [BillNumber], [Amount], [TotalTons], [PerTonRate], [InvoiceNumber], [UserId], [MineId], [ProjectId], [BillPicture]) VALUES (1039, CAST(N'2022-03-12T00:00:00.000' AS DateTime), 1007, N'میرا بلنس اس تاریخ کو یہ تھا', N'001', -1000000.0000, 0.0000, 0.0000, 20223121752182730, 0, 0, 0, NULL)
GO
INSERT [dbo].[Transactions] ([Id], [EntryDateTime], [AccountId], [Particulars], [BillNumber], [Amount], [TotalTons], [PerTonRate], [InvoiceNumber], [UserId], [MineId], [ProjectId], [BillPicture]) VALUES (1040, CAST(N'2022-03-12T00:00:00.000' AS DateTime), 1007, N'paid to faisal as software cost', N'002', -15000.0000, 0.0000, 0.0000, 2022312175334000, 0, 0, 0, NULL)
GO
INSERT [dbo].[Transactions] ([Id], [EntryDateTime], [AccountId], [Particulars], [BillNumber], [Amount], [TotalTons], [PerTonRate], [InvoiceNumber], [UserId], [MineId], [ProjectId], [BillPicture]) VALUES (1041, CAST(N'2022-03-12T00:00:00.000' AS DateTime), 1003, N'paid to faisal as software cost', N'002', 15000.0000, 0.0000, 0.0000, 2022312175334000, 0, 0, 0, NULL)
GO
INSERT [dbo].[Transactions] ([Id], [EntryDateTime], [AccountId], [Particulars], [BillNumber], [Amount], [TotalTons], [PerTonRate], [InvoiceNumber], [UserId], [MineId], [ProjectId], [BillPicture]) VALUES (1042, CAST(N'2022-03-12T00:00:00.000' AS DateTime), 1003, N'FDAHFAKJSHDFLJKADSFHASH', N'', 12000.0000, 20.0000, 22300.0000, 202231217541300, 0, 1002, 0, N'')
GO
INSERT [dbo].[Transactions] ([Id], [EntryDateTime], [AccountId], [Particulars], [BillNumber], [Amount], [TotalTons], [PerTonRate], [InvoiceNumber], [UserId], [MineId], [ProjectId], [BillPicture]) VALUES (1043, CAST(N'2022-03-12T00:00:00.000' AS DateTime), 1006, N'tea expense for faisal visit ', N'B', -150.0000, 0.0000, 0.0000, 20223121756178330, 0, 0, 0, NULL)
GO
INSERT [dbo].[Transactions] ([Id], [EntryDateTime], [AccountId], [Particulars], [BillNumber], [Amount], [TotalTons], [PerTonRate], [InvoiceNumber], [UserId], [MineId], [ProjectId], [BillPicture]) VALUES (1044, CAST(N'2022-03-12T00:00:00.000' AS DateTime), 1004, N'tea expense for faisal visit ', N'B', 150.0000, 0.0000, 0.0000, 20223121756178330, 0, 0, 0, NULL)
GO
INSERT [dbo].[Transactions] ([Id], [EntryDateTime], [AccountId], [Particulars], [BillNumber], [Amount], [TotalTons], [PerTonRate], [InvoiceNumber], [UserId], [MineId], [ProjectId], [BillPicture]) VALUES (2039, CAST(N'2022-03-16T00:00:00.000' AS DateTime), 1003, N'I have these particulars', N'b-1001', -1500.0000, 0.0000, 0.0000, 2022316195012930, 0, 0, 0, N'')
GO
INSERT [dbo].[Transactions] ([Id], [EntryDateTime], [AccountId], [Particulars], [BillNumber], [Amount], [TotalTons], [PerTonRate], [InvoiceNumber], [UserId], [MineId], [ProjectId], [BillPicture]) VALUES (2040, CAST(N'2022-03-17T00:00:00.000' AS DateTime), 1003, N'Purchased From Supplier', N'B-1001', -15000.0000, 0.0000, 0.0000, 20223171358381100, 0, 0, 0, N'')
GO
INSERT [dbo].[Transactions] ([Id], [EntryDateTime], [AccountId], [Particulars], [BillNumber], [Amount], [TotalTons], [PerTonRate], [InvoiceNumber], [UserId], [MineId], [ProjectId], [BillPicture]) VALUES (2041, CAST(N'2022-03-20T00:00:00.000' AS DateTime), 1003, N'Snd', N'', 728000.0000, 26.0000, 28000.0000, 20223201234256670, 0, 1002, 0, N'')
GO
INSERT [dbo].[Transactions] ([Id], [EntryDateTime], [AccountId], [Particulars], [BillNumber], [Amount], [TotalTons], [PerTonRate], [InvoiceNumber], [UserId], [MineId], [ProjectId], [BillPicture]) VALUES (2042, CAST(N'2022-03-20T00:00:00.000' AS DateTime), 1003, N'test', N'', 150000.0000, 10.0000, 15000.0000, 20223201411109100, 0, 1002, 0, N'')
GO
INSERT [dbo].[Transactions] ([Id], [EntryDateTime], [AccountId], [Particulars], [BillNumber], [Amount], [TotalTons], [PerTonRate], [InvoiceNumber], [UserId], [MineId], [ProjectId], [BillPicture]) VALUES (2043, CAST(N'2022-03-20T00:00:00.000' AS DateTime), 1003, N'test', N'', 18000.0000, 10.0000, 18000.0000, 20223201413506900, 0, 1003, 0, N'')
GO
INSERT [dbo].[Transactions] ([Id], [EntryDateTime], [AccountId], [Particulars], [BillNumber], [Amount], [TotalTons], [PerTonRate], [InvoiceNumber], [UserId], [MineId], [ProjectId], [BillPicture]) VALUES (2044, CAST(N'2022-03-20T00:00:00.000' AS DateTime), 1003, N'test', N'', 15000.0000, 10.0000, 15000.0000, 20223201414529670, 0, 1002, 0, N'')
GO
INSERT [dbo].[Transactions] ([Id], [EntryDateTime], [AccountId], [Particulars], [BillNumber], [Amount], [TotalTons], [PerTonRate], [InvoiceNumber], [UserId], [MineId], [ProjectId], [BillPicture]) VALUES (2045, CAST(N'2022-03-20T00:00:00.000' AS DateTime), 1003, N'Particulars', N'B=1001', -1000.0000, 0.0000, 0.0000, 2022320188159931, 1, 0, 0, N'')
GO
INSERT [dbo].[Transactions] ([Id], [EntryDateTime], [AccountId], [Particulars], [BillNumber], [Amount], [TotalTons], [PerTonRate], [InvoiceNumber], [UserId], [MineId], [ProjectId], [BillPicture]) VALUES (2046, CAST(N'2022-03-29T00:00:00.000' AS DateTime), 1003, N'purchase by faisal', N'b-1001', -736000.0000, 0.0000, 0.0000, 20223291258436431, 1, 0, 0, N'')
GO
INSERT [dbo].[Transactions] ([Id], [EntryDateTime], [AccountId], [Particulars], [BillNumber], [Amount], [TotalTons], [PerTonRate], [InvoiceNumber], [UserId], [MineId], [ProjectId], [BillPicture]) VALUES (3046, CAST(N'2022-03-01T00:00:00.000' AS DateTime), 1003, N'paid to faisal', NULL, -12000.0000, 0.0000, 0.0000, 2022331947574500, 0, 1002, 1002, NULL)
GO
INSERT [dbo].[Transactions] ([Id], [EntryDateTime], [AccountId], [Particulars], [BillNumber], [Amount], [TotalTons], [PerTonRate], [InvoiceNumber], [UserId], [MineId], [ProjectId], [BillPicture]) VALUES (3047, CAST(N'2022-03-01T00:00:00.000' AS DateTime), 1004, N'paid to faisal', NULL, 12000.0000, 0.0000, 0.0000, 2022331947574500, 0, 1002, 1002, NULL)
GO
INSERT [dbo].[Transactions] ([Id], [EntryDateTime], [AccountId], [Particulars], [BillNumber], [Amount], [TotalTons], [PerTonRate], [InvoiceNumber], [UserId], [MineId], [ProjectId], [BillPicture]) VALUES (3051, CAST(N'2022-04-06T00:00:00.000' AS DateTime), 1003, N'Purchased From Supplier', N'B-1001', -15000.0000, 0.0000, 0.0000, 202246147562271, 1, 0, 0, N'')
GO
INSERT [dbo].[Transactions] ([Id], [EntryDateTime], [AccountId], [Particulars], [BillNumber], [Amount], [TotalTons], [PerTonRate], [InvoiceNumber], [UserId], [MineId], [ProjectId], [BillPicture]) VALUES (3052, CAST(N'2022-04-06T00:00:00.000' AS DateTime), 1003, N'particulars must be correct', N'B-1001', -16000.0000, 0.0000, 0.0000, 2022461419234971, 1, 0, 0, N'488fad0452764cc8988270595f053e6c.jpg')
GO
INSERT [dbo].[Transactions] ([Id], [EntryDateTime], [AccountId], [Particulars], [BillNumber], [Amount], [TotalTons], [PerTonRate], [InvoiceNumber], [UserId], [MineId], [ProjectId], [BillPicture]) VALUES (3053, CAST(N'2022-04-08T00:00:00.000' AS DateTime), 1003, N'fdaf', N'B-1001', -100.0000, 0.0000, 0.0000, 202248115458501, 1, 0, 0, N'493bde120d1f4e96ab317658b61141e2.jpeg')
GO
SET IDENTITY_INSERT [dbo].[Transactions] OFF
GO
SET IDENTITY_INSERT [dbo].[Units] ON 
GO
INSERT [dbo].[Units] ([Id], [UnitName]) VALUES (1, N'Quantity')
GO
INSERT [dbo].[Units] ([Id], [UnitName]) VALUES (2, N'Litres')
GO
INSERT [dbo].[Units] ([Id], [UnitName]) VALUES (3, N'Kilograms')
GO
INSERT [dbo].[Units] ([Id], [UnitName]) VALUES (4, N'Tons')
GO
INSERT [dbo].[Units] ([Id], [UnitName]) VALUES (5, N'Mounds')
GO
INSERT [dbo].[Units] ([Id], [UnitName]) VALUES (6, N'Foot')
GO
INSERT [dbo].[Units] ([Id], [UnitName]) VALUES (7, N'Yard')
GO
INSERT [dbo].[Units] ([Id], [UnitName]) VALUES (8, N'Meters')
GO
SET IDENTITY_INSERT [dbo].[Units] OFF
GO
SET IDENTITY_INSERT [dbo].[Users] ON 
GO
INSERT [dbo].[Users] ([Id], [UserName], [Password], [IsActive]) VALUES (1, N'admin', N'123@abc', 1)
GO
INSERT [dbo].[Users] ([Id], [UserName], [Password], [IsActive]) VALUES (2, N'faisal', N'123', 1)
GO
INSERT [dbo].[Users] ([Id], [UserName], [Password], [IsActive]) VALUES (1002, N'faisal', N'gladiater', 1)
GO
SET IDENTITY_INSERT [dbo].[Users] OFF
GO
ALTER TABLE [dbo].[Stock] ADD  CONSTRAINT [DF_Stock_ConsumedDirectly]  DEFAULT ((0)) FOR [ConsumedDirectly]
GO
/****** Object:  StoredProcedure [dbo].[Accounts_Delete]    Script Date: 4/8/2022 12:33:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Accounts_Delete] (@Id INT,@Message VARCHAR(100) = 'Success' OUTPUT)
AS
BEGIN
	IF EXISTS (sELECT * FROM Transactions where AccountId = @Id)
	begin
		set @Message = 'Cannot Delete Account , Account Already Used in Invoices'
		RETURN
	end

	IF EXISTS (sELECT * FROM Purchases where SupplierId = @Id)
	begin
		set @Message = 'Cannot Delete Account , Account Already Used in Purchases'
		RETURN
	end

	delete from Accounts where id = @Id
END

GO
/****** Object:  StoredProcedure [dbo].[Accounts_Get]    Script Date: 4/8/2022 12:33:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Accounts_Get]
AS
BEGIN
	SELECT * FROM Accounts
END

GO
/****** Object:  StoredProcedure [dbo].[ACcounts_GEtById]    Script Date: 4/8/2022 12:33:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ACcounts_GEtById](@Id INT)
AS
BEGIN
	SELECT * FROM Accounts WHERE Id = @Id
END

GO
/****** Object:  StoredProcedure [dbo].[Accounts_Insert]    Script Date: 4/8/2022 12:33:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Accounts_Insert] (@AccountName NVARCHAR(MAX),@MobileNO NVARCHAR(MAX),@Address NVARCHar(MAX),@AccountTypeId INT)
AS
BEGIN
	INSERT INTO Accounts (AccountName , MobileNo , Address , AccountTypeId) VALUES 
			(@AccountName , @MobileNO , @Address , @AccountTypeId )
END

GO
/****** Object:  StoredProcedure [dbo].[Accounts_Update]    Script Date: 4/8/2022 12:33:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Accounts_Update] (@Id INT,@AccountName NVARCHAR(MAX),@MobileNO NVARCHAR(MAX),@Address NVARCHar(MAX),@AccountTypeId INT)
AS
BEGIN
	UPDATE Accounts SET AccountName = @AccountName , MobileNo = @MobileNO , Address = @Address , AccountTypeId = @AccountTypeId
		WHERE Id = @Id
END

GO
/****** Object:  StoredProcedure [dbo].[AccountTypes_Delete]    Script Date: 4/8/2022 12:33:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[AccountTypes_Delete](@Id INT,@Message VARCHAR(100) = 'Success' OUTPUT)
AS
BEGIN
	IF EXISTS ( SELECT * FROM Accounts WHERE AccountTypeId = @Id)
	BEGIN
		SET @Message = 'Cannot delete Account Type , Already have account associated'
		RETURN
	END
	DELETE FROM AccountTypes WHERE Id = @Id
END

GO
/****** Object:  StoredProcedure [dbo].[AccountTypes_Get]    Script Date: 4/8/2022 12:33:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[AccountTypes_Get]
AS
BEGIN
	SELECT * FROM AccountTypes
END

GO
/****** Object:  StoredProcedure [dbo].[AccountTypes_GetById]    Script Date: 4/8/2022 12:33:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[AccountTypes_GetById](@Id INT)
AS
BEGIN
	SELECT * FROM AccountTypes WHERE Id = @Id
END

GO
/****** Object:  StoredProcedure [dbo].[AccountTypes_Save]    Script Date: 4/8/2022 12:33:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[AccountTypes_Save](@AccountType NVARCHAR(MAX))
AS
BEGIN
	INSERT INTO AccountTypes (AccountType) values (@AccountType)
END

GO
/****** Object:  StoredProcedure [dbo].[AccountTypes_Update]    Script Date: 4/8/2022 12:33:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[AccountTypes_Update](@Id INT , @AccountType NVARCHAR(MAX))
AS
BEGIN
	UPdate AccountTypes SET ACcountType = @AccountType WHERE Id = @Id
END

GO
/****** Object:  StoredProcedure [dbo].[Authenticate]    Script Date: 4/8/2022 12:33:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Authenticate] (@UserName NVARCHAR(MAX),@Password NVARCHAR(MAX))
AS
BEGIN
	SELECT * FROM Users WHERE UserName = @UserName AND [Password] = @Password AND IsActive = 1
END

GO
/****** Object:  StoredProcedure [dbo].[CoalData_Delete]    Script Date: 4/8/2022 12:33:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CoalData_Delete] (@InvoiceNumber BIGINT,@Message VARCHAR(500) = 'Success' OUTPUT)
AS
BEGIN
	BEGIN TRY
	BEGIN TRANSACTION
		DELETE FROM CoalData WHERE InvoiceNumber = @InvoiceNumber
		DELETE FROM Transactions WHERE InvoiceNumber = @InvoiceNumber
	COMMIT TRANSACTION
	END TRY
	BEGIN CATCH
		SET @Message = ERROR_MESSAGE()
		ROLLBACK TRANSACTION
	END CATCH
END

GO
/****** Object:  StoredProcedure [dbo].[CoalData_Get]    Script Date: 4/8/2022 12:33:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CoalData_Get]
AS
BEGIN
	SELECT CD.* , A.AccountName , IsNull(M.MineName,'') 'MineName' FROM CoalData CD JOIN Accounts A ON A.ID = CD.CustomerId
			LEFT JOIN Mines M ON M.Id = CD.MineId
END

GO
/****** Object:  StoredProcedure [dbo].[CoalData_GetByDateTime]    Script Date: 4/8/2022 12:33:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[CoalData_GetByDateTime] (@FromDate DATE,@ToDate DATE)
AS
BEGIN
	SELECT CD.* , A.AccountName , IsNull(M.MineName,'') 'MineName' FROM CoalData CD JOIN Accounts A ON A.ID = CD.CustomerId
			LEFT JOIN Mines M ON M.Id = CD.MineId
		WHERE CD.EntryDateTime >= @FromDate AND CD.EntryDateTime < DATEADD(DAY,1,@ToDate)
END

GO
/****** Object:  StoredProcedure [dbo].[CoalData_GetById]    Script Date: 4/8/2022 12:33:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CoalData_GetById] (@InvoiceNumber BIGINT)
AS
BEGIN
	SELECT CD.* , A.AccountName , M.MineName FROM CoalData CD JOIN Accounts A ON A.ID = CD.CustomerId
			LEFT JOIN Mines M ON M.Id = CD.MineId WHERE CD.InvoiceNumber = @InvoiceNumber
END

GO
/****** Object:  StoredProcedure [dbo].[CoalData_Insert]    Script Date: 4/8/2022 12:33:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CoalData_Insert]
(
	@EntryDateTime DATETIME,
	@VehicleNumber NVARCHAR(MAX),
	@TotalTons MONEY,
	@PerTonRAte MONEY,
	@TotalValue MONEY,
	@Particulars NVARCHAR(MAX),
	@DriverName NVARCHAR(MAX),
	@DriverContactNo NVARCHAR(MAX),
	@CustomerId INT,
	@MineId INT,
	@UserId INT,
	@Message VARCHAR(500) OUTPUT
)
AS
BEGIN
	BEGIN TRY
		BEGIN TRANSACTION
			
			DECLARE @InvoiceNumber BIGINT
			SET @InvoiceNumber = dbo.GenerateInvoiceNo(@UserId)

			INSERT INTO CoalData (EntryDateTime , VehicleNumber , TotalTons , PerTonRate , 
				TotalValue , Particulars , DriverName , DriverContactNo , CustomerId , MineId ,UserId , InvoiceNumber) VALUES
						(@EntryDateTime , @VehicleNumber , @TotalTons , @PerTonRAte , @TotalValue , 
							@Particulars , @DriverName , @DriverContactNo , @CustomerId , @MineId , @UserId , @InvoiceNumber)
			
			INSERT INTO [dbo].[Transactions] ([EntryDateTime],[AccountId],[Particulars],[BillNumber],[Amount],[TotalTons],[PerTonRate]
			,[InvoiceNumber],[UserId],[MineId],[ProjectId],BillPicture) VALUES (@EntryDateTime , @CustomerId , @Particulars , '' , @TotalValue , @TotalTons , @PerTonRate,
					@InvoiceNumber , @UserId , @MineId , 0 , '')
		
		COMMIT TRANSACTION
	END TRY
	BEGIN CATCH
		IF @@TRANCOUNT > 0
		BEGIN
			ROLLBACK TRANSACTION
		END
		SET @Message = ERROR_MESSAGE()
	END CATCH
END

GO
/****** Object:  StoredProcedure [dbo].[CoalData_Update]    Script Date: 4/8/2022 12:33:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CoalData_Update]
(
	@InvoiceNumber BIGINT,
	@EntryDateTime DATETIME,
	@VehicleNumber NVARCHAR(MAX),
	@TotalTons MONEY,
	@PerTonRAte MONEY,
	@TotalValue MONEY,
	@Particulars NVARCHAR(MAX),
	@DriverName NVARCHAR(MAX),
	@DriverContactNo NVARCHAR(MAX),
	@CustomerId INT,
	@MineId INT,
	@UserId INT,
	@Message VARCHAR(500) OUTPUT
)
AS
BEGIN
	BEGIN TRY
		BEGIN TRANSACTION
			

			UPDATE CoalData SET EntryDateTime = @EntryDateTime , VehicleNumber = @VehicleNumber , TotalTons = @TotalTons , PerTonRate = @PerTonRAte,
				TotalValue = @TotalValue , Particulars = @Particulars , DriverContactNo = @DriverContactNo , DriverName = @DriverName, CustomerId = @CustomerId
				, MineId = @MineId , UserId = @UserId WHERE InvoiceNumber = @InvoiceNumber
			
			UPDATE Transactions SET EntryDateTime = @EntryDateTime , AccountId = @CustomerId , Particulars = @Particulars , BillNumber = '' , Amount =  @TotalValue
					, TotalTons = @TotalTons , PerTonRate = @PerTonRate , MineId = @MineId , ProjectId = 0 WHERE InvoiceNumber = @InvoiceNumber AND Amount > 0
		
		COMMIT TRANSACTION
	END TRY
	BEGIN CATCH
		IF @@TRANCOUNT > 0
		BEGIN
			ROLLBACK TRANSACTION
		END
		SET @Message = ERROR_MESSAGE()
	END CATCH
END

GO
/****** Object:  StoredProcedure [dbo].[Finance_Delete]    Script Date: 4/8/2022 12:33:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Finance_Delete] (@InvoiceNumber BIGINT,@Message VARCHAR(500) OUTPUT)
AS
BEGIN
BEGIN TRY
	BEGIN TRANSACTION
		DELETE FROM Transactions WHERE InvoiceNumber = @InvoiceNumber
		DELETE FROM PlainTransaction WHERE InvoiceNumber = @InvoiceNumber
		SET @Message = 'Success'
	COMMIT TRANSACTION
END TRY
BEGIN CATCH
	SET @Message = ERROR_MESSAGE()
	ROLLBACK TRANSACTION
END CATCH
END

GO
/****** Object:  StoredProcedure [dbo].[Finance_Get]    Script Date: 4/8/2022 12:33:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Finance_Get] (@FromDate DATE,@ToDate DATE)
AS
BEGIN
	SELECT Tr.Id , IsNull((a1.AccountName),'No From Account') 'FromAccount',
					IsNull((a2.AccountName),'No To Account') 'ToAccount'	
						, tr.EntryDateTime , tr.BillNumber , tr.Particulars
		, tr.Amount , p.ProjectName , m.MineName , tr.InvoiceNumber	FROM PlainTransaction tr
		left join Mines m on m.Id = tr.MineId
		left join Projects p on p.Id = tr.ProjectId
		LEFT JOIN Accounts a1 on a1.Id = tr.FromAccountId
		left join Accounts a2 on a2.Id = tr.ToAccountId
		WHERE EntryDateTime >= @FromDate AND EntryDateTime < DATEADD(DAY,1,@ToDate)
		
END

GO
/****** Object:  StoredProcedure [dbo].[Finance_GetByInvoice]    Script Date: 4/8/2022 12:33:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Finance_GetByInvoice] (@InvoiceNumber BIGINT)
AS
BEGIN
	SELECT * FROM PlainTransaction WHERE InvoiceNumber  = @InvoiceNumber
END

GO
/****** Object:  StoredProcedure [dbo].[Finance_GetVoucherNumber]    Script Date: 4/8/2022 12:33:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Finance_GetVoucherNumber]
AS
BEGIN
	DECLARE @VoucherNumber BIGINT

	IF EXISTS (SELECT TOP 1 * FROM VoucherNumbers)
	BEGIN
		SELECT @VoucherNumber =  Max(VoucherNumber) + 1 FROM VoucherNumbers;
	END
	ELSE
	BEGIN
		SET @VoucherNumber = 1;
	END


	SELECT @VoucherNumber 'VoucherNumber'
END
GO
/****** Object:  StoredProcedure [dbo].[Finance_SaveEntry]    Script Date: 4/8/2022 12:33:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Finance_SaveEntry] 
(
@EntryDateTime DATETIME, @FromAccountId INT , @ToAccountId INT ,@Particulars NVARCHAR(MAX),@BillNumber NVARCHAR(50),@Amount MONEY
,@TotalTons money,@PerTonRate MONEY,@UserId INT,@MineId INT,@ProjectId INT,@BillPicture NVARCHAR(MAX),@Message VARCHAR(500)  = 'Success' OUTPUT)
AS
BEGIN
BEGIN TRY
	DECLARE @InvoiceNumber BIGINT
	SET @InvoiceNumber = dbo.GenerateInvoiceNo(@UserId)

	BEGIN TRANSACTION

		INSERT INTO [dbo].[PlainTransaction]    ([EntryDateTime],[FromAccountId],[ToAccountId],[Particulars],[BillNumber],[Amount],[MineId],[ProjectId],[InvoiceNumber],BillPicture)
			VALUES (@EntryDateTime , @FromAccountId , @ToAccountId , @Particulars , @BillNumber , @Amount , @MineId , @ProjectId , @InvoiceNumber , @BillPicture)

		IF @FromAccountId > 0
		BEGIN
			INSERT INTO [dbo].[Transactions] ([EntryDateTime],[AccountId],[Particulars],[BillNumber],[Amount],[TotalTons],[PerTonRate]
			,[InvoiceNumber],[UserId],[MineId],[ProjectId],BillPicture) VALUES (@EntryDateTime , @FromAccountId , @Particulars , @BillNumber , -@Amount , @TotalTons , @PerTonRate,
					@InvoiceNumber , @UserId , @MineId , @ProjectId , @BillPicture)
		END

		IF @ToAccountId > 0
		BEGIN
			INSERT INTO [dbo].[Transactions] ([EntryDateTime],[AccountId],[Particulars],[BillNumber],[Amount],[TotalTons],[PerTonRate]
			,[InvoiceNumber],[UserId],[MineId],[ProjectId] , BillPicture) VALUES (@EntryDateTime , @ToAccountId , @Particulars , @BillNumber , @Amount  , @TotalTons , @PerTonRate,
					@InvoiceNumber , @UserId , @MineId , @ProjectId , @BillPicture)		
		END
	COMMIT TRANSACTION
END TRY
BEGIN CATCH	
	SET @Message = ERROR_MESSAGE()
END CATCH
END

GO
/****** Object:  StoredProcedure [dbo].[Finance_UpdateEntry]    Script Date: 4/8/2022 12:33:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Finance_UpdateEntry] 
(
	@InvoiceNumber BIGINT , @EntryDateTime DATETIME, @FromAccountId INT , @ToAccountId INT ,@Particulars NVARCHAR(MAX),@BillNumber NVARCHAR(50),@Amount MONEY
,@TotalTons money,@PerTonRate MONEY,@UserId INT,@MineId INT,@ProjectId INT,@Message VARCHAR(500)  = 'Success' OUTPUT)
AS
BEGIN
BEGIN TRY

	BEGIN TRANSACTION

	UPDATE PlainTransaction SET EntryDateTime = @EntryDateTime , FromAccountId = @FromAccountId , ToAccountId = @ToAccountId , Particulars = @Particulars
			, BillNumber = @BillNumber , Amount = @Amount ,  MineId = @MineId , ProjectId = @ProjectId WHERE InvoiceNumber = @InvoiceNumber
	
	IF EXISTS (sELECT * FROM Transactions WHERE InvoiceNumber = @InvoiceNumber AND Amount < 0 )
	BEGIN
		IF @FromAccountId = 0 
		BEGIN
			DELETE FROM Transactions WHERE InvoiceNumber = @InvoiceNumber AND Amount < 0
		END
		ELSE	
		BEGIN
			UPDATE Transactions SET EntryDateTime = @EntryDateTime , AccountId = @FromAccountId , Particulars = @Particulars , BillNumber = @BillNumber , Amount = -@Amount
					, TotalTons = @TotalTons , PerTonRate = @PerTonRate , MineId = @MineId , ProjectId = @ProjectId WHERE InvoiceNumber = @InvoiceNumber AND Amount < 0
		END
	END
	ELSE
	BEGIN
		INSERT INTO [dbo].[Transactions] ([EntryDateTime],[AccountId],[Particulars],[BillNumber],[Amount],[TotalTons],[PerTonRate]
			,[InvoiceNumber],[UserId],[MineId],[ProjectId]) VALUES (@EntryDateTime , @FromAccountId , @Particulars , @BillNumber , -@Amount , @TotalTons , @PerTonRate,
					@InvoiceNumber , @UserId , @MineId , @ProjectId)
	END

	IF EXISTS (sELECT * FROM Transactions WHERE InvoiceNumber = @InvoiceNumber AND Amount > 0 )
	BEGIN
		IF @ToAccountId = 0 
		BEGIN
			DELETE FROM Transactions WHERE InvoiceNumber = @InvoiceNumber AND Amount > 0
		END
		ELSE
		BEGIN
			UPDATE Transactions SET EntryDateTime = @EntryDateTime , AccountId = @ToAccountId , Particulars = @Particulars , BillNumber = @BillNumber , Amount = @Amount
					, TotalTons = @TotalTons , PerTonRate = @PerTonRate , MineId = @MineId , ProjectId = @ProjectId WHERE InvoiceNumber = @InvoiceNumber AND Amount > 0
		END
	END
	ELSE
	BEGIN
		INSERT INTO [dbo].[Transactions] ([EntryDateTime],[AccountId],[Particulars],[BillNumber],[Amount],[TotalTons],[PerTonRate]
			,[InvoiceNumber],[UserId],[MineId],[ProjectId]) VALUES (@EntryDateTime , @ToAccountId , @Particulars , @BillNumber , @Amount , @TotalTons , @PerTonRate,
					@InvoiceNumber , @UserId , @MineId , @ProjectId)
	END

	COMMIT TRANSACTION

END TRY
BEGIN CATCH	
	SET @Message = ERROR_MESSAGE()
END CATCH
END

GO
/****** Object:  StoredProcedure [dbo].[Issuance_Delete]    Script Date: 4/8/2022 12:33:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Issuance_Delete] (@InvoiceNumber BIGINT,@Message VARCHAR(500) OUTPUT)
AS
BEGIN
BEGIN TRY
	BEGIN TRANSACTION
		DELETE FROM ItemIssuance WHERE InvoiceNumber = @InvoiceNumber
		DELETE FROM Stock WHERE InvoiceNumber = @InvoiceNumber
		SET @Message = 'Success'
	COMMIT TRANSACTION
END TRY
BEGIN CATCH
	SET @Message = ERROR_MESSAGE()
	ROLLBACK TRANSACTION
END CATCH
END

GO
/****** Object:  StoredProcedure [dbo].[Issuance_Get]    Script Date: 4/8/2022 12:33:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Issuance_Get](@FromDate DATE,@ToDate DATE)
AS
BEGIN
	SELECT Itu.* , ItemName , UnitName , m.MineName , p.ProjectName FROM Items I JOIN ItemIssuance Itu ON I.Id = itu.ItemId JOIN Units U ON U.Id = itu.UnitId
		left join Mines m on m.Id = itu.MineId left join Projects p on p.Id = itu.ProjectId
		where IssuanceDateTime >= @FromDate AND IssuanceDateTime < DATEADD(DAY,1,@ToDate)
END

GO
/****** Object:  StoredProcedure [dbo].[Issuance_GetById]    Script Date: 4/8/2022 12:33:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Issuance_GetById] (@Id bigint)
AS
BEGIN
	SELECT Itu.Id , itu.IssuanceDateTime , itu.ItemId , 
			itu.UnitId , itu.Quantity , itu.AveragePrice , itu.MineId , 
					itu.ProjectId , itu.UserId , 0 'InvoiceNumber' , itu.Particulars  FROM Items I JOIN ItemIssuance Itu ON I.Id = itu.ItemId JOIN Units U ON U.Id = itu.UnitId
		where Itu.InvoiceNumber = @Id
END

GO
/****** Object:  StoredProcedure [dbo].[Issuance_Insert]    Script Date: 4/8/2022 12:33:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Issuance_Insert] (@IssuanceDate DATE,@ItemId int,@UnitId INT,@Quantity MONEY,@Particulars NVARCHAR(MAX),@MineId INT,@ProjectId INT,@UserId INT,@Message VARCHAR(500) = 'Success' OUTPUT)
AS
BEGIN
	BEGIN TRY
	DECLARE @Average MONEY
	DECLARE @InvoiceNumber BIGINT
	SET @Average = (SELECT AVG(UnitPrice) FROM Stock WHERE ItemId = @ItemId and UnitId = @UnitId AND Quantity > 0)
	SET @InvoiceNumber = dbo.GenerateInvoiceNo(@UserId)

	BEGIN TRANSACTION
		INSERT INTO ItemIssuance (IssuanceDateTime , ItemId , UnitId , Quantity , MineId , AveragePrice , ProjectId , UserId , InvoiceNumber,Particulars) VALUES
				(@IssuanceDate , @ItemId , @UnitId , @Quantity , @MineId , @Average , @ProjectId , @UserId , @InvoiceNumber,@Particulars)
		INSERT INTO Stock (ItemId , UnitId , Quantity , UnitPrice , TotalPrice , UserId , InvoiceNumber , ConsumedDirectly) VALUES
			(@ItemId , @UnitId , -@Quantity , @Average , -(@Average * @Quantity) , @UserId , @InvoiceNumber , 0)
	COMMIT TRANSACTION
	END TRY
	BEGIN CATCH
		ROLLBACK TRANSACTION
		SET @Message = ERROR_MESSAGE()
	END CATCH
	
END

GO
/****** Object:  StoredProcedure [dbo].[Issuance_Update]    Script Date: 4/8/2022 12:33:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Issuance_Update] (@Id INT,@IssuanceDate DATE,@ItemId int,@UnitId INT,@Particulars NVARCHAR(MAX),@Quantity MONEY,@MineId INT,@ProjectId INT,@UserId INT,@Message VARCHAR(500) = 'Success' OUTPUT)
AS
BEGIN
	BEGIN TRY
	DECLARE @Average MONEY
	SET @Average = (SELECT AVG(UnitPrice) FROM Stock WHERE ItemId = @ItemId and UnitId = @UnitId)
	DECLARE @InvoiceNumber BIGINT
	SET @InvoiceNumber = (SELECT InvoiceNumber FROM Purchases WHERE Id = @Id)

	BEGIN TRANSACTION
		UPDATE ItemIssuance SET IssuanceDateTime = @IssuanceDate , ItemId = @ItemId , UnitId = @UnitId , Quantity = @Quantity , AveragePrice = @Average , 
					MineId = @MineId , ProjectId = @ProjectId , UserId = @UserId , Particulars = @Particulars WHERE Id = @Id

		UPDATE [dbo].[Stock]   SET [ItemId] = @ItemId ,[UnitId] = @UnitId  ,[Quantity] = @Quantity ,[UnitPrice] = @Average ,[TotalPrice] = @Quantity * @Average
			  ,[UserId] = @UserId ,[ConsumedDirectly] = 0
		 WHERE InvoiceNumber = @InvoiceNumber
	COMMIT TRANSACTION
	END TRY
	BEGIN CATCH
		ROLLBACK TRANSACTION
		SET @Message = ERROR_MESSAGE()
	END CATCH
END

GO
/****** Object:  StoredProcedure [dbo].[IssuanceReport]    Script Date: 4/8/2022 12:33:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[IssuanceReport] (@FromDate DATE,@ToDate DATE,@ItemId INT,@MineId INT,@ProjectId INT)
AS
SELECT I.IssuanceDateTime , IT.ItemName , u.UnitName , Quantity , AveragePrice , m.MineName , p.ProjectName , i.Particulars , i.InvoiceNumber
		FROM ItemIssuance I JOIN Items IT ON IT.Id = I.ItemId JOIN Units U ON U.Id = I.UnitId
	LEFT JOIN Projects P ON P.Id = I.ProjectId left JOIN Mines M ON M.Id = I.MineId 
		WHERE I.IssuanceDateTime >= @FromDate AND I.IssuanceDateTime < DATEADD(DAY,1,@ToDate)
			AND I.ItemId = CASE WHEN @ItemId = 0 THEN I.ItemId ELSE @ItemId END
			AND I.MineId = CASE WHEN @MineId = 0 THEN I.MineId ELSE @MineId END
			AND I.ProjectId = CASE WHEN @ProjectID = 0 THEN I.ProjectId ELSE @ProjectId END
GO
/****** Object:  StoredProcedure [dbo].[Items_Delete]    Script Date: 4/8/2022 12:33:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Items_Delete] (@Id INT,@Message VARCHAR(100) = 'Success' OUTPUT)
AS
BEGIN
	IF EXISTS (SELECT * FROM  Stock WHERE ItemId = @Id)
	BEGIN
		SET @Message = 'Cannot Delete Item , Stock Exists '
		RETURN
	END
	DELETE FROM Items WHERE id = @Id
END

GO
/****** Object:  StoredProcedure [dbo].[Items_Get]    Script Date: 4/8/2022 12:33:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Items_Get]
AS
BEGIN
	SELECT * FROM Items
END

GO
/****** Object:  StoredProcedure [dbo].[Items_GetById]    Script Date: 4/8/2022 12:33:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Items_GetById](@Id INT)
AS
BEGIN
	SELECT * FROM Items WHERE Id = @Id
END

GO
/****** Object:  StoredProcedure [dbo].[Items_Insert]    Script Date: 4/8/2022 12:33:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Items_Insert] (@ItemName NVARCHAR(MAX))
AS
BEGIN
	INSERT INTO Items (ItemName) VALUES (@ItemName)
END

GO
/****** Object:  StoredProcedure [dbo].[Items_Update]    Script Date: 4/8/2022 12:33:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Items_Update] (@Id INT,@ItemName NVARCHAR(MAX))
AS
BEGIN
	UPDATE Items SET ItemName = @ItemName where id = @Id
END

GO
/****** Object:  StoredProcedure [dbo].[Mines_Delete]    Script Date: 4/8/2022 12:33:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Mines_Delete] (@Id INT,@Message VARCHAR(100) = 'Success' OUTPUT)
AS
BEGIN
	IF EXISTS (SELECT top 1 * FROM  Transactions WHERE MineId = @Id) OR Exists (Select top 1 * from ItemIssuance WHERE MineId = @Id)
	BEGIN
		SET @Message = 'Cannot Delete Mine , Reference exists '
		RETURN
	END
	DELETE FROM Mines WHERE id = @Id
END

GO
/****** Object:  StoredProcedure [dbo].[Mines_Get]    Script Date: 4/8/2022 12:33:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Mines_Get]
AS
BEGIN
	SELECT * FROM Mines
END

GO
/****** Object:  StoredProcedure [dbo].[Mines_GetById]    Script Date: 4/8/2022 12:33:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Mines_GetById](@Id INT)
AS
BEGIN
	SELECT * FROM Mines WHERE Id = @Id
END

GO
/****** Object:  StoredProcedure [dbo].[Mines_Insert]    Script Date: 4/8/2022 12:33:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Mines_Insert] (@MineName NVARCHAR(MAX))
AS
BEGIN
	INSERT INTO Mines(MineName) VALUES (@MineName)
END

GO
/****** Object:  StoredProcedure [dbo].[Mines_Update]    Script Date: 4/8/2022 12:33:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Mines_Update] (@Id INT,@MineName NVARCHAR(MAX))
AS
BEGIN
	UPDATE Mines SET MineName = @MineName where id = @Id
END

GO
/****** Object:  StoredProcedure [dbo].[Projects_Delete]    Script Date: 4/8/2022 12:33:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Projects_Delete] (@Id INT,@Message VARCHAR(100) = 'Success' OUTPUT)
AS
BEGIN
	IF EXISTS (SELECT top 1 * FROM  Transactions WHERE ProjectId = @Id) OR Exists (Select top 1 * from ItemIssuance WHERE ProjectId = @Id)
	BEGIN
		SET @Message = 'Cannot Delete Project , Reference exists '
		RETURN
	END
	DELETE FROM Projects WHERE id = @Id
END

GO
/****** Object:  StoredProcedure [dbo].[Projects_Get]    Script Date: 4/8/2022 12:33:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Projects_Get]
AS
BEGIN
	SELECT * FROM Projects
END

GO
/****** Object:  StoredProcedure [dbo].[Projects_GetById]    Script Date: 4/8/2022 12:33:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Projects_GetById](@Id INT)
AS
BEGIN
	SELECT * FROM Projects WHERE Id = @Id
END

GO
/****** Object:  StoredProcedure [dbo].[Projects_Insert]    Script Date: 4/8/2022 12:33:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Projects_Insert] (@ProjectName NVARCHAR(MAX))
AS
BEGIN
	INSERT INTO Projects(ProjectName) VALUES (@ProjectName)
END

GO
/****** Object:  StoredProcedure [dbo].[Projects_Update]    Script Date: 4/8/2022 12:33:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Projects_Update] (@Id INT,@ProjectName NVARCHAR(MAX))
AS
BEGIN
	UPDATE Projects SET ProjectName = @ProjectName where id = @Id
END

GO
/****** Object:  StoredProcedure [dbo].[Purchases_Delete]    Script Date: 4/8/2022 12:33:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Purchases_Delete] (
	@InvoiceNumber BIGINT,
	@Message VARCHAR(500) = 'Success' OUTPUT
)
AS
BEGIN
	BEGIN TRY
		BEGIN TRANSACTION
			
			DELETE FROM Purchases WHERE InvoiceNumber = @InvoiceNumber 
			DELETE FROM Stock WHERE InvoiceNumber = @InvoiceNumber
			DELETE FROM Transactions WHERE InvoiceNumber = @InvoiceNumber

		COMMIT TRANSACTION
	END TRY
	BEGIN CATCH
		SET @Message = ERROR_MESSAGE()
		ROLLBACK TRANSACTION
	END CATCH
END

GO
/****** Object:  StoredProcedure [dbo].[Purchases_Get]    Script Date: 4/8/2022 12:33:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Purchases_Get](@FromDate DATE,@ToDate DATE)
AS
BEGIN
	SELECT a.AccountName , P.* FROM Accounts a JOIN Purchases P ON a.Id = P.SupplierId
		WHERE p.EntryDateTime >= @FromDate AND P.EntryDateTime < DATEADD(DAY,1,@ToDate)
END

GO
/****** Object:  StoredProcedure [dbo].[Purchases_GetById]    Script Date: 4/8/2022 12:33:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Purchases_GetById] (@InvoiceNumber BIGINT)
AS
BEGIN
	SELECT * FROM Purchases WHERE InvoiceNumber = @InvoiceNumber
	SELECT s.* , i.ItemName, u.UnitName FROM Stock s join Items i on i.id = s.ItemId join Units u on u.Id=  s.UnitId WHERE InvoiceNumber = @InvoiceNumber
END

GO
/****** Object:  StoredProcedure [dbo].[Purchases_Insert]    Script Date: 4/8/2022 12:33:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Purchases_Insert] (
	@EntryDate DATETIME,
	@SupplierID INT,
	@BillNumber VARCHAR(500),
	@Particulars NVARCHAR(500),
	@UserId INT,
	@BillPicture VARCHAR(500),
	@ItemsList dbo.ItemsList READONLY,
	@Message VARCHAR(500) = 'Success' OUTPUT
)
AS
BEGIN
	BEGIN TRY
		BEGIN TRANSACTION
			
			DECLARE @InvoiceNumber BIGINT
			DECLARE @TotalAmount MONEY
			
			SET @InvoiceNumber = dbo.GenerateInvoiceNo(@UserId)
			SET @TotalAmount = (SELECT SUM(TotalPrice) FROM @ItemsList)

			INSERT INTO Purchases (EntryDateTime , SupplierId , BillNumber , Particulars , InvoiceNumber , TotalAmount , UserId , BillPicture)
				VALUES (@EntryDate , @SupplierID , @BillNumber, @Particulars , @InvoiceNumber,  @TotalAmount , @UserId , @BillPicture)
			INSERT INTO Stock (ItemId , UnitId , Quantity , UnitPrice , TotalPrice , UserId , InvoiceNumber , ConsumedDirectly)
				SELECT ItemId , UnitId , Quantity , UnitPrice , Quantity * UnitPrice , @UserId , @InvoiceNumber , 0 FROM @ItemsList

			INSERT INTO [dbo].[Transactions] ([EntryDateTime],[AccountId],[Particulars],[BillNumber],[Amount],[TotalTons],[PerTonRate]
			,[InvoiceNumber],[UserId],[MineId],[ProjectId],BillPicture) VALUES (@EntryDate , @SupplierID , @Particulars , @BillNumber , -@TotalAmount , 0 , 0,
					@InvoiceNumber , @UserId , 0 , 0 , @BillPicture)

		COMMIT TRANSACTION
	END TRY
	BEGIN CATCH
		SET @Message = ERROR_MESSAGE()
		ROLLBACK TRANSACTION
	END CATCH
END

GO
/****** Object:  StoredProcedure [dbo].[Purchases_Update]    Script Date: 4/8/2022 12:33:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Purchases_Update] (
	@InvoiceNumber BIGINT,
	@EntryDate DATETIME,
	@SupplierID INT,
	@BillNumber VARCHAR(500),
	@Particulars VARCHAR(500),
	@UserId INT,
	@BillPicture VARCHAR(500),
	@ItemsList dbo.ItemsList READONLY,
	@Message VARCHAR(500) = 'Success' OUTPUT
)
AS
BEGIN
	BEGIN TRY
		BEGIN TRANSACTION
			
			DECLARE @TotalAmount MONEY			
			SET @TotalAmount = (SELECT SUM(TotalPrice) FROM @ItemsList)

			UPDATE Stock SET ItemId = I.ItemId , UnitId = I.UnitId , Quantity = I.Quantity , 
				UnitPrice = I.UnitPrice , TotalPrice = I.UnitPrice * I.Quantity , UserId = @UserId 
				  FROM Stock S JOIN @ItemsList I ON S.id = I.Id WHERE S.InvoiceNumber = @InvoiceNumber
			
			UPDATE Purchases SET EntryDateTime = @EntryDate , SupplierId = @SupplierID , BillNumber = @BillNumber , TotalAmount = @TotalAmount,
				BillPicture = @BillPicture , Particulars = @Particulars 
				WHERE InvoiceNumber = @InvoiceNumber

			INSERT INTO Stock (ItemId , UnitId , Quantity , UnitPrice , TotalPrice , UserId , InvoiceNumber , ConsumedDirectly)
				SELECT ItemId , UnitId , Quantity , UnitPrice , Quantity * UnitPrice , @UserId , @InvoiceNumber , 0 FROM @ItemsList WHERE Id <= 0

			UPDATE Transactions SET EntryDateTime = @EntryDate , AccountId = @SupplierID , Particulars = @Particulars , BillNumber = '' , Amount =  -@TotalAmount
					, TotalTons = 0 , PerTonRate = 0 , MineId = 0 , ProjectId = 0 , BillPicture = @BillPicture  WHERE InvoiceNumber = @InvoiceNumber AND Amount < 0

		COMMIT TRANSACTION
	END TRY
	BEGIN CATCH
		SET @Message = ERROR_MESSAGE()
		ROLLBACK TRANSACTION
	END CATCH
END

GO
/****** Object:  StoredProcedure [dbo].[Reports_AccountBalances]    Script Date: 4/8/2022 12:33:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Reports_AccountBalances]
AS
BEGIN
	SELECT ATT.AccountType , a.AccountName , 
		SUM(CASE WHEN T.Amount < 0 THEN T.Amount ELSE 0 END) 'TotalCredits',
		SUM(CASE WHEN T.Amount > 0 THEN T.Amount ELSE 0 END) 'TotalDebits',
		SUM(T.Amount) 'Balance'
		FROM AccountTypes ATT JOIN Accounts A  on att.Id = a.AccountTypeId JOIN Transactions T ON A.Id= T.AccountId
	GROUP BY ATT.AccountType , a.AccountName
END
GO
/****** Object:  StoredProcedure [dbo].[Reports_CoalData]    Script Date: 4/8/2022 12:33:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Reports_CoalData] (@FromDate DATE,@ToDate DATE,@CustomerId INT,@MineId INT)
AS
BEGIN
	SELECT EntryDateTime , a.AccountName , VehicleNumber , TotalTons , PerTonRate , TotalValue , Particulars, DriverName , DriverContactNo , InvoiceNumber
				, m.MineName 
			FROM CoalData c JOIN Accounts A ON C.CustomerId = a.Id left join Mines M ON 
			C.MineId = M.Id
	WHERE EntryDateTime >= @FromDate and EntryDateTime < DATEADD(day,1,@ToDate) and c.CustomerId = case when @CustomerId = 0 then c.CustomerId else @CustomerId end
		and c.MineId = case when @MineId = 0 then c.MineId else @MineId end
END
GO
/****** Object:  StoredProcedure [dbo].[Reports_DashBoardData]    Script Date: 4/8/2022 12:33:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Reports_DashBoardData]
AS
WITH Today AS
(SELECT IsNull(SUM(TotalTons),0) 'TotalTonsToday'
		, IsNUll(SUM(TotalValue),0) 'TotalValueToday' FROM CoalData WHERE EntryDateTime >= CAST(GETDATE() AS DATE)
			AND EntryDateTime < DATEADD(DAY,1,CAST(GETDATE() AS date))),
ThisMonth AS
(SELECT IsNull(SUM(TotalTons),0) 'TotalTonsThisMonth'
		, IsNull(SUM(TotalValue),0) 'TotalValueThisMonth' FROM CoalData WHERE EntryDateTime >= CAST(CAST(MONTH(getdate()) as varchar(20)) + '/1/' + CAST(YEAR(getdate()) as varchar(20)) AS DATE)
			AND EntryDateTime < DATEADD(DAY,1,CAST(EOMONTH(GETDATE(),0) as date))),
TodayCount AS (SELECT COUNT(*) 'TotalVehiclesToday' FROM CoalData WHERE EntryDateTime >= CAST(GETDATE() AS DATE)
			AND EntryDateTime < DATEADD(DAY,1,CAST(GETDATE() AS date))),
ThisMonthCount AS
(SELECT COUNT(*) 'TotalVehiclesThisMonth' FROM CoalData WHERE EntryDateTime >= CAST(CAST(MONTH(getdate()) as varchar(20)) + '/1/' + CAST(YEAR(getdate()) as varchar(20)) AS DATE)
			AND EntryDateTime < DATEADD(DAY,1,CAST(EOMONTH(GETDATE(),0) as date)))
SELECT Today.TotalTonsToday , Today.TotalValueToday , ThisMonth.TotalTonsThisMonth , ThisMonth.TotalValueThisMonth
	,TodayCount.TotalVehiclesToday , ThisMonthCount.TotalVehiclesThisMonth
From Today , ThisMonth , TodayCount , ThisMonthCount
GO
/****** Object:  StoredProcedure [dbo].[Reports_Generalledger]    Script Date: 4/8/2022 12:33:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Reports_Generalledger] (@FromDate DATE,@ToDate DATE,@AccountId INT,@OpeningBalance MONEY OUTPUT)
AS
BEGIN
	SET @OpeningBalance = (SELECT SUM(Amount) FROM Transactions WHERE AccountId = @AccountId AND EntryDateTime < @FromDate);
	SET @OpeningBalance = ISNULL(@OpeningBalance,0)

	select S.AccountName , EntryDateTime , BillNumber , Particulars , Debit , Credit , @OpeningBalance + SUM(Amount) OVER (Order by EntryDateTime) 'Balance' FROM (
	SELECT A.AccountName , T.EntryDateTime , T.BillNumber , T.Particulars , CASE WHEN T.Amount > 0 THEN T.Amount ELSE 0 END 'Debit'
	 , CASE WHEN T.Amount < 0 THEN T.Amount ELSE 0 END 'Credit' , T.Amount	FROM Accounts A JOIN Transactions T ON A.Id = T.AccountId
		WHERE T.EntryDateTime >= @FromDate AND T.EntryDateTime < DATEADD(DAY,1,@ToDAte) AND T.AccountId = @AccountId)
		 AS S ORDER BY EntryDateTime
END
GO
/****** Object:  StoredProcedure [dbo].[Reports_PurchaseReport]    Script Date: 4/8/2022 12:33:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Reports_PurchaseReport] (@FRomDate DATE,@ToDate DATE,@SupplierID INT)
AS
BEGIN
SELECT P.EntryDateTime , A.AccountName , BillNumber , Particulars , TotalAmount , i.ItemName , 
			u.UnitName , Quantity , UnitPrice , TotalPrice , S.InvoiceNumber
		FROM Purchases P JOIN Stock S ON P.InvoiceNumber = S.InvoiceNumber
	JOIN Accounts A ON A.Id = P.SupplierId JOIN Items i on i.Id = s.ItemId
	JOIN Units u ON u.Id = S.UnitId
	WHERE EntryDateTime >= @FromDate AND EntryDateTime < DATEADD(DAY,1,@ToDate)
			AND P.SupplierId = CASE WHEN @SupplierId = 0 THEN P.SupplierId ELSE @SupplierID END
END
GO
/****** Object:  StoredProcedure [dbo].[Reports_StockReport]    Script Date: 4/8/2022 12:33:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Reports_StockReport]
AS
SELECT u.UnitName , i.ItemName , SUM(Quantity) 'Stock' , sum(TotalPrice) 'Price'
		FROM Stock S JOIN Units u on u.Id = s.UnitId join Items i on i.Id = s.ItemId
	GROUP BY u.UnitName , i.ItemName
GO
/****** Object:  StoredProcedure [dbo].[Stock_Total]    Script Date: 4/8/2022 12:33:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Stock_Total] (@ItemId int,@UnitId INT)
AS
BEGIN
	SELECT ISNULL(SUM(Quantity),0) 'Quantity' FROM Stock WHERE ItemId = @ItemId and UnitId = @UnitId
END

GO
/****** Object:  StoredProcedure [dbo].[Units_Get]    Script Date: 4/8/2022 12:33:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Units_Get]
AS
BEGIN
	SELECT * FROM UNits
END

GO
/****** Object:  StoredProcedure [dbo].[Users_Delete]    Script Date: 4/8/2022 12:33:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Users_Delete] (@Id INT,@Message VARCHAR(100) = 'Success' OUTPUT)
AS
BEGIN
	IF EXISTS (SELECT top 1 * FROM  Transactions WHERE UserId = @Id) OR 
				Exists (Select top 1 * from ItemIssuance WHERE UserId = @Id) or 
				Exists (Select top 1 * from Purchases WHERE UserId = @Id) or 
				Exists (Select top 1 * from CoalData WHERE UserId = @Id)
	BEGIN
		SET @Message = 'Cannot Delete User , Reference exists '
		RETURN
	END
	DELETE FROM Users WHERE id = @Id
END

GO
/****** Object:  StoredProcedure [dbo].[Users_Get]    Script Date: 4/8/2022 12:33:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Users_Get]
AS
BEGIN
	SELECT * FROM Users
END

GO
/****** Object:  StoredProcedure [dbo].[Users_GetById]    Script Date: 4/8/2022 12:33:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Users_GetById](@Id INT)
AS
BEGIN
	SELECT * FROM Users WHERE Id = @Id
END

GO
/****** Object:  StoredProcedure [dbo].[Users_Insert]    Script Date: 4/8/2022 12:33:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Users_Insert] (@UserName NVARCHAR(MAX) , @Password NVARCHAR(MAX) , @IsActive BIT)
AS
BEGIN
	INSERT INTO Users(UserName , Password , IsActive) VALUES (@UserName , @Password , @IsActive)
END

GO
/****** Object:  StoredProcedure [dbo].[Users_Update]    Script Date: 4/8/2022 12:33:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Users_Update] (@Id INT,@UserName NVARCHAR(MAX) , @Password NVARCHAR(MAX) , @IsActive BIT)
AS
BEGIN
	UPDATE Users SET UserName = @UserName , Password = @Password , IsActive = @IsActive WHERE 
		Id = @Id
END

GO
USE [master]
GO
ALTER DATABASE [CoalSelling] SET  READ_WRITE 
GO
