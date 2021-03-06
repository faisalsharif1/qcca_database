USE [MushtarikaAkhurwalCoalV5]
GO
/****** Object:  Table [dbo].[__MigrationHistory]    Script Date: 11/6/2020 5:09:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[__MigrationHistory](
	[MigrationId] [nvarchar](150) NOT NULL,
	[ContextKey] [nvarchar](300) NOT NULL,
	[Model] [varbinary](max) NOT NULL,
	[ProductVersion] [nvarchar](32) NOT NULL,
 CONSTRAINT [PK_dbo.__MigrationHistory] PRIMARY KEY CLUSTERED 
(
	[MigrationId] ASC,
	[ContextKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AccountCodes]    Script Date: 11/6/2020 5:09:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AccountCodes](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CategoryId] [int] NOT NULL,
	[IsSync] [bit] NOT NULL,
 CONSTRAINT [PK_dbo.AccountCodes] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Accounts]    Script Date: 11/6/2020 5:09:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Accounts](
	[AccountId] [int] IDENTITY(1,1) NOT NULL,
	[AccountTitle] [nvarchar](max) NULL,
	[CategoryId] [int] NOT NULL,
	[AccountCode] [nvarchar](max) NULL,
	[ContactNo] [nvarchar](max) NULL,
	[CNICNumber] [nvarchar](max) NULL,
	[IsSync] [bit] NOT NULL,
 CONSTRAINT [PK_dbo.Accounts] PRIMARY KEY CLUSTERED 
(
	[AccountId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Areas]    Script Date: 11/6/2020 5:09:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Areas](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[AreaName] [nvarchar](max) NULL,
	[IsSync] [bit] NOT NULL,
 CONSTRAINT [PK_dbo.Areas] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BankAccounts]    Script Date: 11/6/2020 5:09:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BankAccounts](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[BankId] [int] NOT NULL,
	[AccountTitle] [nvarchar](max) NULL,
	[AccountNumber] [nvarchar](max) NULL,
	[AccountId] [int] NOT NULL,
	[IsSync] [bit] NOT NULL,
 CONSTRAINT [PK_dbo.BankAccounts] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Banks]    Script Date: 11/6/2020 5:09:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Banks](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[BankName] [nvarchar](max) NULL,
	[BankContact] [nvarchar](max) NULL,
	[IsSync] [bit] NOT NULL,
 CONSTRAINT [PK_dbo.Banks] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Categories]    Script Date: 11/6/2020 5:09:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Categories](
	[CategoryId] [int] IDENTITY(1,1) NOT NULL,
	[CategoryName] [nvarchar](max) NULL,
	[HeadId] [int] NOT NULL,
	[IsSync] [bit] NOT NULL,
 CONSTRAINT [PK_dbo.Categories] PRIMARY KEY CLUSTERED 
(
	[CategoryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Cheque_History]    Script Date: 11/6/2020 5:09:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Cheque_History](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ChequeId] [int] NOT NULL,
	[ChequeStatusId] [int] NOT NULL,
	[ActivityDateTime] [datetime] NOT NULL,
	[ActivityByUserId] [int] NOT NULL,
	[IsSync] [bit] NOT NULL,
 CONSTRAINT [PK_dbo.Cheque_History] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Cheque_Log]    Script Date: 11/6/2020 5:09:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Cheque_Log](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[PartyId] [int] NOT NULL,
	[BankId] [int] NOT NULL,
	[BankAccountId] [int] NOT NULL,
	[ChequeReceivingDate] [datetime] NOT NULL,
	[ChequeClearingDate] [datetime] NOT NULL,
	[ChequeAmount] [decimal](18, 3) NOT NULL,
	[UserId] [int] NOT NULL,
	[IsCleared] [bit] NOT NULL,
	[ChequeNumber] [nvarchar](max) NULL,
	[ClearedBy] [int] NOT NULL,
	[ImageId] [int] NOT NULL,
	[BankInvoiceId] [int] NOT NULL,
	[ChequeIsFromBankId] [int] NOT NULL,
	[ChequeStatusId] [int] NOT NULL,
	[InvoiceNumber] [bigint] NOT NULL,
	[StatementDateTime] [datetime] NULL,
	[BillNumber] [nvarchar](max) NULL,
	[Particulars] [nvarchar](max) NULL,
	[IsSync] [bit] NOT NULL,
 CONSTRAINT [PK_dbo.Cheque_Log] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ChequeStatuses]    Script Date: 11/6/2020 5:09:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ChequeStatuses](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Status] [nvarchar](max) NULL,
	[IsSync] [bit] NOT NULL,
 CONSTRAINT [PK_dbo.ChequeStatuses] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Companies]    Script Date: 11/6/2020 5:09:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Companies](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CustomerTypeId] [int] NOT NULL,
	[PartyName] [nvarchar](max) NULL,
	[ContactNumber] [nvarchar](max) NULL,
	[PerTonRate] [decimal](18, 3) NOT NULL,
	[AccountId] [int] NOT NULL,
	[Limit] [decimal](18, 3) NOT NULL,
	[IsBalanceCheckOn] [bit] NOT NULL,
	[CNICNumber] [nvarchar](max) NULL,
	[IsSync] [bit] NOT NULL,
 CONSTRAINT [PK_dbo.Companies] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Company_Kanta_Log]    Script Date: 11/6/2020 5:09:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Company_Kanta_Log](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[SerialId] [int] NOT NULL,
	[ItemType] [int] NOT NULL,
	[VehicleNumber] [nvarchar](max) NULL,
	[SecondWeightDateTime] [datetime] NOT NULL,
	[DriverName] [nvarchar](max) NULL,
	[DriverContactNumber] [nvarchar](max) NULL,
	[WeightInKilograms] [decimal](18, 3) NOT NULL,
	[WeightInTons] [decimal](18, 3) NOT NULL,
	[WeightInMounds40] [decimal](18, 3) NOT NULL,
	[WeightInMounds42] [decimal](18, 3) NOT NULL,
	[PricePerTon] [decimal](18, 3) NOT NULL,
	[TotalPrice] [decimal](18, 3) NOT NULL,
	[AdditionalPrice] [decimal](18, 3) NOT NULL,
	[FinalPrice] [decimal](18, 3) NOT NULL,
	[MineId] [int] NOT NULL,
	[AccountId] [int] NOT NULL,
	[UserId] [int] NOT NULL,
	[Kanta_General_Id] [int] NOT NULL,
	[InvoiceNumber] [bigint] NOT NULL,
	[TruckIsFor] [nvarchar](max) NULL,
	[CompanyChargesId] [int] NOT NULL,
	[IsSync] [bit] NOT NULL,
 CONSTRAINT [PK_dbo.Company_Kanta_Log] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Company_Mine]    Script Date: 11/6/2020 5:09:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Company_Mine](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ActivityDateTime] [datetime] NOT NULL,
	[PartyId] [int] NOT NULL,
	[MineId] [int] NOT NULL,
	[MateId] [int] NOT NULL,
	[MineStatusId] [int] NOT NULL,
	[Rate] [decimal](18, 3) NOT NULL,
	[Unit] [int] NOT NULL,
	[AgreementType] [nvarchar](max) NULL,
	[IsSync] [bit] NOT NULL,
 CONSTRAINT [PK_dbo.Company_Mine] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Company_Mine_DiggingDetails]    Script Date: 11/6/2020 5:09:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Company_Mine_DiggingDetails](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[EntryDatTime] [datetime] NOT NULL,
	[PartyId] [int] NOT NULL,
	[Mine] [int] NOT NULL,
	[Unit] [int] NOT NULL,
	[TotalUnits] [decimal](18, 3) NOT NULL,
	[UnitPrice] [decimal](18, 3) NOT NULL,
	[TotalPrice] [decimal](18, 3) NOT NULL,
	[InvoiceNumber] [bigint] NOT NULL,
	[IsSync] [bit] NOT NULL,
 CONSTRAINT [PK_dbo.Company_Mine_DiggingDetails] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Company_PerTonCharges]    Script Date: 11/6/2020 5:09:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Company_PerTonCharges](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[AgreementDate] [datetime] NOT NULL,
	[CompanyId] [int] NOT NULL,
	[MineId] [int] NOT NULL,
	[PerTonRate] [decimal](18, 3) NOT NULL,
	[TotalTons] [decimal](18, 3) NOT NULL,
	[TotalAmount] [decimal](18, 3) NOT NULL,
	[IsActive] [bit] NOT NULL,
	[IsSync] [bit] NOT NULL,
 CONSTRAINT [PK_dbo.Company_PerTonCharges] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Configurations]    Script Date: 11/6/2020 5:09:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Configurations](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[AccountToDebitInPurchase] [int] NOT NULL,
	[IsSync] [bit] NOT NULL,
 CONSTRAINT [PK_dbo.Configurations] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CustomerTypes]    Script Date: 11/6/2020 5:09:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CustomerTypes](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CustomerType] [nvarchar](max) NULL,
	[IsSync] [bit] NOT NULL,
 CONSTRAINT [PK_dbo.CustomerTypes] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DataToRemoves]    Script Date: 11/6/2020 5:09:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DataToRemoves](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[TableName] [nvarchar](max) NULL,
	[PrimaryKeyValue] [int] NOT NULL,
	[InvoiceNumber] [nvarchar](max) NULL,
	[IsProcessed] [bit] NOT NULL,
 CONSTRAINT [PK_dbo.DataToRemoves] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EmployeeAttendences]    Script Date: 11/6/2020 5:09:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EmployeeAttendences](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[EntryDateTime] [datetime] NULL,
	[CheckInDateTime] [datetime] NULL,
	[CheckOutDateTime] [datetime] NULL,
	[EmployeeId] [int] NOT NULL,
	[UserId] [int] NOT NULL,
	[IsOnLeave] [bit] NOT NULL,
	[IsPresent] [bit] NOT NULL,
	[TotalDutyHours] [int] NOT NULL,
	[IsSync] [bit] NOT NULL,
 CONSTRAINT [PK_dbo.EmployeeAttendences] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EmployeeLeaves]    Script Date: 11/6/2020 5:09:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EmployeeLeaves](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[EmployeeId] [int] NOT NULL,
	[ApprovedBy] [int] NOT NULL,
	[FromDate] [datetime] NOT NULL,
	[ToDate] [datetime] NOT NULL,
	[UserId] [int] NOT NULL,
	[IsSync] [int] NOT NULL,
 CONSTRAINT [PK_dbo.EmployeeLeaves] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Employees]    Script Date: 11/6/2020 5:09:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Employees](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[EmployeeType] [int] NOT NULL,
	[EmployeeName] [nvarchar](max) NULL,
	[EmployeeCNIC] [nvarchar](max) NULL,
	[MineId] [int] NOT NULL,
	[PartyId] [int] NOT NULL,
	[EmployeeJoiningDate] [datetime] NULL,
	[EmployeeLeavingDate] [datetime] NULL,
	[EmployeeSalary] [decimal](18, 3) NOT NULL,
	[EmployeePicture] [int] NOT NULL,
	[IsActive] [bit] NOT NULL,
	[WorksUnderEmployeeId] [int] NOT NULL,
	[FMD] [nvarchar](max) NULL,
	[FMD2] [nvarchar](max) NULL,
	[DailyWorkingHours] [int] NOT NULL,
	[IsSync] [bit] NOT NULL,
 CONSTRAINT [PK_dbo.Employees] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EmployeeTypes]    Script Date: 11/6/2020 5:09:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EmployeeTypes](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[EmployeeTypeDescription] [nvarchar](max) NULL,
	[IsSync] [bit] NOT NULL,
 CONSTRAINT [PK_dbo.EmployeeTypes] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FormInProjects]    Script Date: 11/6/2020 5:09:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FormInProjects](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[FormName] [nvarchar](max) NULL,
	[IdKey] [int] NOT NULL,
	[IsSync] [bit] NOT NULL,
 CONSTRAINT [PK_dbo.FormInProjects] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Heads]    Script Date: 11/6/2020 5:09:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Heads](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[HeadName] [nvarchar](max) NULL,
	[IsSync] [bit] NOT NULL,
 CONSTRAINT [PK_dbo.Heads] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Items]    Script Date: 11/6/2020 5:09:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Items](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ItemName] [nvarchar](max) NULL,
	[AccountId] [int] NOT NULL,
	[IsSync] [bit] NOT NULL,
 CONSTRAINT [PK_dbo.Items] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ItemTypes]    Script Date: 11/6/2020 5:09:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ItemTypes](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ItemType] [nvarchar](max) NULL,
	[IsSync] [bit] NOT NULL,
 CONSTRAINT [PK_dbo.ItemTypes] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Kanta_Charge]    Script Date: 11/6/2020 5:09:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Kanta_Charge](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CustomerTypeId] [int] NOT NULL,
	[VehicleTypeId] [int] NOT NULL,
	[ChargesDescription] [nvarchar](max) NULL,
	[Charges] [decimal](18, 3) NOT NULL,
	[IsSync] [bit] NOT NULL,
 CONSTRAINT [PK_dbo.Kanta_Charge] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Kanta_General]    Script Date: 11/6/2020 5:09:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Kanta_General](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[EntryDateTime] [datetime] NOT NULL,
	[VehicleNumber] [nvarchar](max) NULL,
	[WeightInKilograms] [decimal](18, 3) NOT NULL,
	[WeightInTons] [decimal](18, 3) NOT NULL,
	[WeightInMounds40Kg] [decimal](18, 3) NOT NULL,
	[WeightInMounds42Kg] [decimal](18, 3) NOT NULL,
	[UserId] [int] NOT NULL,
	[HasDetail] [bit] NOT NULL,
	[InvoiceNumber] [bigint] NOT NULL,
	[CustomerTypeId] [int] NOT NULL,
	[VehicleType] [int] NOT NULL,
	[TotalCharges] [decimal](18, 3) NOT NULL,
	[CompanyId] [int] NOT NULL,
	[IsEmpty] [bit] NOT NULL,
	[IsSync] [bit] NOT NULL,
 CONSTRAINT [PK_dbo.Kanta_General] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Kanta_Mine_AdditionalPackages]    Script Date: 11/6/2020 5:09:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Kanta_Mine_AdditionalPackages](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[MineCondition] [int] NOT NULL,
	[TypeCondition] [int] NOT NULL,
	[AccountIdCondition] [int] NOT NULL,
	[AccountIdCondition_CompanyId] [int] NOT NULL,
	[IsFixed] [bit] NOT NULL,
	[IsCredit] [bit] NOT NULL,
	[PerTonValue] [decimal](18, 3) NOT NULL,
	[FixedValue] [decimal](18, 3) NOT NULL,
	[Particulars] [nvarchar](max) NULL,
	[Type] [int] NOT NULL,
	[EntryInAccount] [int] NOT NULL,
	[EntryInAccount_CompanyId] [int] NOT NULL,
	[IsSync] [bit] NOT NULL,
 CONSTRAINT [PK_dbo.Kanta_Mine_AdditionalPackages] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Mine]    Script Date: 11/6/2020 5:09:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Mine](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[MineDescription] [nvarchar](max) NULL,
	[AreaId] [int] NOT NULL,
	[MineStatusId] [int] NOT NULL,
	[CurrentCompanyId] [int] NOT NULL,
	[AgreementValue] [decimal](18, 3) NOT NULL,
	[AgreementType] [nvarchar](max) NULL,
	[UnitId] [int] NOT NULL,
	[MineDegree] [nvarchar](max) NULL,
	[MateId] [int] NOT NULL,
	[MinesOwnedBy] [int] NOT NULL,
	[IsSync] [bit] NOT NULL,
 CONSTRAINT [PK_dbo.Mine] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Mines_PerTonCharges]    Script Date: 11/6/2020 5:09:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Mines_PerTonCharges](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[MineId] [int] NOT NULL,
	[PerTonRate] [decimal](18, 3) NOT NULL,
	[EntryDate] [datetime] NOT NULL,
	[IsActive] [bit] NOT NULL,
	[IsSync] [bit] NOT NULL,
 CONSTRAINT [PK_dbo.Mines_PerTonCharges] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MineStatuses]    Script Date: 11/6/2020 5:09:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MineStatuses](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[MineStatus] [nvarchar](max) NULL,
	[IsSync] [bit] NOT NULL,
 CONSTRAINT [PK_dbo.MineStatuses] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MobileNoes]    Script Date: 11/6/2020 5:09:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MobileNoes](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[MobileNo1] [nvarchar](max) NULL,
	[MobileNo2] [nvarchar](max) NULL,
	[MobileNoKanta1] [nvarchar](max) NULL,
	[MobileNoKanta2] [nvarchar](max) NULL,
	[IsSync] [bit] NOT NULL,
 CONSTRAINT [PK_dbo.MobileNoes] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Party_Kanta_Log_AdditionalChargesDetail]    Script Date: 11/6/2020 5:09:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Party_Kanta_Log_AdditionalChargesDetail](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Kanta_General_Id] [int] NOT NULL,
	[ChargesDescription] [nvarchar](max) NULL,
	[Charges] [decimal](18, 3) NOT NULL,
	[AccountId] [int] NOT NULL,
	[InvoiceNumber] [bigint] NOT NULL,
	[IsSync] [bit] NOT NULL,
 CONSTRAINT [PK_dbo.Party_Kanta_Log_AdditionalChargesDetail] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Projects]    Script Date: 11/6/2020 5:09:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Projects](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ProjectName] [nvarchar](max) NULL,
	[IsSync] [bit] NOT NULL,
 CONSTRAINT [PK_dbo.Projects] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PurchaseDetails]    Script Date: 11/6/2020 5:09:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PurchaseDetails](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[PurchaseId] [int] NOT NULL,
	[ItemId] [int] NOT NULL,
	[UnitId] [int] NOT NULL,
	[Quantity] [decimal](18, 3) NOT NULL,
	[Amount] [decimal](18, 3) NOT NULL,
	[IsSync] [bit] NOT NULL,
 CONSTRAINT [PK_dbo.PurchaseDetails] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Purchases]    Script Date: 11/6/2020 5:09:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Purchases](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[SupplierId] [int] NOT NULL,
	[PurchaseDate] [datetime] NOT NULL,
	[InvoiceNumber] [bigint] NOT NULL,
	[BillNumber] [nvarchar](max) NULL,
	[Amount] [decimal](18, 3) NOT NULL,
	[UserId] [int] NOT NULL,
	[Discount] [decimal](18, 3) NOT NULL,
	[IsSync] [bit] NOT NULL,
 CONSTRAINT [PK_dbo.Purchases] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Serials]    Script Date: 11/6/2020 5:09:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Serials](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[KantaId] [int] NOT NULL,
	[SerialNumber] [int] NOT NULL,
	[UserId] [int] NOT NULL,
	[IsSync] [bit] NOT NULL,
 CONSTRAINT [PK_dbo.Serials] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SerialTransactions]    Script Date: 11/6/2020 5:09:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SerialTransactions](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[SerialNumber] [int] NOT NULL,
	[UserId] [int] NOT NULL,
	[IsSync] [bit] NOT NULL,
 CONSTRAINT [PK_dbo.SerialTransactions] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[StockAssignmentDetails]    Script Date: 11/6/2020 5:09:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StockAssignmentDetails](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[InvoiceNumber] [bigint] NOT NULL,
	[ItemId] [int] NOT NULL,
	[UnitId] [int] NOT NULL,
	[Quantity] [decimal](18, 3) NOT NULL,
	[StockId] [int] NOT NULL,
	[Amount] [decimal](18, 3) NOT NULL,
	[IsSync] [bit] NOT NULL,
 CONSTRAINT [PK_dbo.StockAssignmentDetails] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[StockAssignments]    Script Date: 11/6/2020 5:09:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StockAssignments](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[AssignedDateTime] [datetime] NOT NULL,
	[InvoiceNumber] [bigint] NOT NULL,
	[ItemId] [int] NOT NULL,
	[UnitId] [int] NOT NULL,
	[Quantity] [decimal](18, 3) NOT NULL,
	[MineId] [int] NOT NULL,
	[CompanyId] [int] NOT NULL,
	[UserId] [int] NOT NULL,
	[TotalPrice] [decimal](18, 3) NOT NULL,
	[DebitInAccountId] [int] NOT NULL,
	[Deliverer] [nvarchar](max) NULL,
	[Receiver] [nvarchar](max) NULL,
	[Particulars] [nvarchar](max) NULL,
	[IsSync] [bit] NOT NULL,
 CONSTRAINT [PK_dbo.StockAssignments] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Stocks]    Script Date: 11/6/2020 5:09:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Stocks](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[InvoiceNumber] [bigint] NOT NULL,
	[ItemId] [int] NOT NULL,
	[UnitId] [int] NOT NULL,
	[Quantity] [decimal](18, 3) NOT NULL,
	[UnitPrice] [decimal](18, 3) NOT NULL,
	[TotalPrice] [decimal](18, 3) NOT NULL,
	[Consumed] [decimal](18, 3) NOT NULL,
	[PurchaseDetailId] [int] NOT NULL,
	[IsSync] [bit] NOT NULL,
 CONSTRAINT [PK_dbo.Stocks] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Transactions]    Script Date: 11/6/2020 5:09:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Transactions](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[SerialNo] [int] NOT NULL,
	[InvoiceNumber] [bigint] NOT NULL,
	[TransactionDate] [datetime] NOT NULL,
	[BillNumber] [nvarchar](max) NULL,
	[ChequeNumber] [nvarchar](max) NULL,
	[Particulars] [nvarchar](max) NULL,
	[AccountId] [int] NOT NULL,
	[Amount] [decimal](18, 3) NOT NULL,
	[UserId] [int] NOT NULL,
	[ProjectId] [int] NOT NULL,
	[MineId] [int] NOT NULL,
	[ImageId] [int] NOT NULL,
	[IsApproved] [bit] NOT NULL,
	[IsManualEntry] [bit] NOT NULL,
	[TotalTons] [decimal](18, 3) NOT NULL,
	[PerTonValue] [decimal](18, 3) NOT NULL,
	[PaymentType] [nvarchar](max) NULL,
	[PurchaseDetailId] [int] NOT NULL,
	[IncExpTag] [int] NOT NULL,
	[ProjectIdType] [int] NOT NULL,
	[IsProcessed] [bit] NOT NULL,
	[IsSync] [bit] NOT NULL,
 CONSTRAINT [PK_dbo.Transactions] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TransactionsHistories]    Script Date: 11/6/2020 5:09:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TransactionsHistories](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[SerialNo] [int] NOT NULL,
	[InvoiceNumber] [bigint] NOT NULL,
	[TransactionDate] [datetime] NOT NULL,
	[BillNumber] [nvarchar](max) NULL,
	[ChequeNumber] [nvarchar](max) NULL,
	[Particulars] [nvarchar](max) NULL,
	[AccountId] [int] NOT NULL,
	[Amount] [decimal](18, 3) NOT NULL,
	[UserId] [int] NOT NULL,
	[ProjectId] [int] NOT NULL,
	[MineId] [int] NOT NULL,
	[ImageId] [int] NOT NULL,
	[IsApproved] [bit] NOT NULL,
	[IsManualEntry] [bit] NOT NULL,
	[TotalTons] [decimal](18, 3) NOT NULL,
	[PerTonValue] [decimal](18, 3) NOT NULL,
	[PaymentType] [nvarchar](max) NULL,
	[PurchaseDetailId] [int] NOT NULL,
	[EditedByUserId] [int] NOT NULL,
	[TransactionTypeId] [int] NOT NULL,
	[IncExpTag] [int] NOT NULL,
	[ProjectIdType] [int] NOT NULL,
	[IsProcessed] [bit] NOT NULL,
	[IsSync] [bit] NOT NULL,
 CONSTRAINT [PK_dbo.TransactionsHistories] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TransactionTypes]    Script Date: 11/6/2020 5:09:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TransactionTypes](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[TransactionType] [nvarchar](max) NULL,
	[IsSync] [bit] NOT NULL,
 CONSTRAINT [PK_dbo.TransactionTypes] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Units]    Script Date: 11/6/2020 5:09:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Units](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UnitName] [nvarchar](max) NULL,
	[UnitType] [int] NOT NULL,
	[IsSync] [bit] NOT NULL,
 CONSTRAINT [PK_dbo.Units] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UnitTypes]    Script Date: 11/6/2020 5:09:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UnitTypes](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UnitType] [nvarchar](max) NULL,
	[IsSync] [bit] NOT NULL,
 CONSTRAINT [PK_dbo.UnitTypes] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UploadedImages]    Script Date: 11/6/2020 5:09:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UploadedImages](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ImageBase64] [nvarchar](max) NULL,
	[IsSync] [bit] NOT NULL,
 CONSTRAINT [PK_dbo.UploadedImages] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserPermissions]    Script Date: 11/6/2020 5:09:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserPermissions](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[FormName] [nvarchar](max) NULL,
	[IsAllowed] [bit] NOT NULL,
	[UserId] [int] NOT NULL,
	[IsSync] [bit] NOT NULL,
 CONSTRAINT [PK_dbo.UserPermissions] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 11/6/2020 5:09:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserName] [nvarchar](max) NULL,
	[Password] [nvarchar](max) NULL,
	[IsActive] [bit] NOT NULL,
	[IsAdmin] [bit] NOT NULL,
	[AccountId] [int] NOT NULL,
	[IsSync] [bit] NOT NULL,
 CONSTRAINT [PK_dbo.Users] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[VehicleTypes]    Script Date: 11/6/2020 5:09:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[VehicleTypes](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[VehicleType] [nvarchar](max) NULL,
	[IsSync] [bit] NOT NULL,
 CONSTRAINT [PK_dbo.VehicleTypes] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[AccountCodes] ADD  DEFAULT ((0)) FOR [IsSync]
GO
ALTER TABLE [dbo].[Accounts] ADD  DEFAULT ((0)) FOR [IsSync]
GO
ALTER TABLE [dbo].[Areas] ADD  DEFAULT ((0)) FOR [IsSync]
GO
ALTER TABLE [dbo].[BankAccounts] ADD  DEFAULT ((0)) FOR [IsSync]
GO
ALTER TABLE [dbo].[Banks] ADD  DEFAULT ((0)) FOR [IsSync]
GO
ALTER TABLE [dbo].[Categories] ADD  DEFAULT ((0)) FOR [HeadId]
GO
ALTER TABLE [dbo].[Categories] ADD  DEFAULT ((0)) FOR [IsSync]
GO
ALTER TABLE [dbo].[Cheque_History] ADD  DEFAULT ((0)) FOR [IsSync]
GO
ALTER TABLE [dbo].[Cheque_Log] ADD  DEFAULT ((0)) FOR [ChequeIsFromBankId]
GO
ALTER TABLE [dbo].[Cheque_Log] ADD  DEFAULT ((0)) FOR [ChequeStatusId]
GO
ALTER TABLE [dbo].[Cheque_Log] ADD  DEFAULT ((0)) FOR [InvoiceNumber]
GO
ALTER TABLE [dbo].[Cheque_Log] ADD  DEFAULT ((0)) FOR [IsSync]
GO
ALTER TABLE [dbo].[ChequeStatuses] ADD  DEFAULT ((0)) FOR [IsSync]
GO
ALTER TABLE [dbo].[Companies] ADD  DEFAULT ((0)) FOR [IsSync]
GO
ALTER TABLE [dbo].[Company_Kanta_Log] ADD  DEFAULT ((0)) FOR [IsSync]
GO
ALTER TABLE [dbo].[Company_Mine] ADD  DEFAULT ((0)) FOR [IsSync]
GO
ALTER TABLE [dbo].[Company_Mine_DiggingDetails] ADD  DEFAULT ((0)) FOR [IsSync]
GO
ALTER TABLE [dbo].[Company_PerTonCharges] ADD  DEFAULT ((0)) FOR [IsSync]
GO
ALTER TABLE [dbo].[Configurations] ADD  DEFAULT ((0)) FOR [IsSync]
GO
ALTER TABLE [dbo].[CustomerTypes] ADD  DEFAULT ((0)) FOR [IsSync]
GO
ALTER TABLE [dbo].[EmployeeAttendences] ADD  DEFAULT ((0)) FOR [IsOnLeave]
GO
ALTER TABLE [dbo].[EmployeeAttendences] ADD  DEFAULT ((0)) FOR [IsPresent]
GO
ALTER TABLE [dbo].[EmployeeAttendences] ADD  DEFAULT ((0)) FOR [TotalDutyHours]
GO
ALTER TABLE [dbo].[EmployeeAttendences] ADD  DEFAULT ((0)) FOR [IsSync]
GO
ALTER TABLE [dbo].[EmployeeLeaves] ADD  DEFAULT ((0)) FOR [IsSync]
GO
ALTER TABLE [dbo].[Employees] ADD  DEFAULT ((0)) FOR [DailyWorkingHours]
GO
ALTER TABLE [dbo].[Employees] ADD  DEFAULT ((0)) FOR [IsSync]
GO
ALTER TABLE [dbo].[EmployeeTypes] ADD  DEFAULT ((0)) FOR [IsSync]
GO
ALTER TABLE [dbo].[FormInProjects] ADD  DEFAULT ((0)) FOR [IdKey]
GO
ALTER TABLE [dbo].[FormInProjects] ADD  DEFAULT ((0)) FOR [IsSync]
GO
ALTER TABLE [dbo].[Heads] ADD  DEFAULT ((0)) FOR [IsSync]
GO
ALTER TABLE [dbo].[Items] ADD  DEFAULT ((0)) FOR [IsSync]
GO
ALTER TABLE [dbo].[ItemTypes] ADD  DEFAULT ((0)) FOR [IsSync]
GO
ALTER TABLE [dbo].[Kanta_Charge] ADD  DEFAULT ((0)) FOR [IsSync]
GO
ALTER TABLE [dbo].[Kanta_General] ADD  DEFAULT ((0)) FOR [IsSync]
GO
ALTER TABLE [dbo].[Kanta_Mine_AdditionalPackages] ADD  DEFAULT ((0)) FOR [IsSync]
GO
ALTER TABLE [dbo].[Mine] ADD  DEFAULT ((0)) FOR [MinesOwnedBy]
GO
ALTER TABLE [dbo].[Mine] ADD  DEFAULT ((0)) FOR [IsSync]
GO
ALTER TABLE [dbo].[Mines_PerTonCharges] ADD  DEFAULT ('1900-01-01T00:00:00.000') FOR [EntryDate]
GO
ALTER TABLE [dbo].[Mines_PerTonCharges] ADD  DEFAULT ((0)) FOR [IsActive]
GO
ALTER TABLE [dbo].[Mines_PerTonCharges] ADD  DEFAULT ((0)) FOR [IsSync]
GO
ALTER TABLE [dbo].[MineStatuses] ADD  DEFAULT ((0)) FOR [IsSync]
GO
ALTER TABLE [dbo].[MobileNoes] ADD  DEFAULT ((0)) FOR [IsSync]
GO
ALTER TABLE [dbo].[Party_Kanta_Log_AdditionalChargesDetail] ADD  DEFAULT ((0)) FOR [IsSync]
GO
ALTER TABLE [dbo].[Projects] ADD  DEFAULT ((0)) FOR [IsSync]
GO
ALTER TABLE [dbo].[PurchaseDetails] ADD  DEFAULT ((0)) FOR [IsSync]
GO
ALTER TABLE [dbo].[Purchases] ADD  DEFAULT ((0)) FOR [Discount]
GO
ALTER TABLE [dbo].[Purchases] ADD  DEFAULT ((0)) FOR [IsSync]
GO
ALTER TABLE [dbo].[Serials] ADD  DEFAULT ((0)) FOR [IsSync]
GO
ALTER TABLE [dbo].[SerialTransactions] ADD  DEFAULT ((0)) FOR [IsSync]
GO
ALTER TABLE [dbo].[StockAssignmentDetails] ADD  DEFAULT ((0)) FOR [Amount]
GO
ALTER TABLE [dbo].[StockAssignmentDetails] ADD  DEFAULT ((0)) FOR [IsSync]
GO
ALTER TABLE [dbo].[StockAssignments] ADD  DEFAULT ((0)) FOR [TotalPrice]
GO
ALTER TABLE [dbo].[StockAssignments] ADD  DEFAULT ((0)) FOR [DebitInAccountId]
GO
ALTER TABLE [dbo].[StockAssignments] ADD  DEFAULT ((0)) FOR [IsSync]
GO
ALTER TABLE [dbo].[Stocks] ADD  DEFAULT ((0)) FOR [UnitPrice]
GO
ALTER TABLE [dbo].[Stocks] ADD  DEFAULT ((0)) FOR [TotalPrice]
GO
ALTER TABLE [dbo].[Stocks] ADD  DEFAULT ((0)) FOR [Consumed]
GO
ALTER TABLE [dbo].[Stocks] ADD  DEFAULT ((0)) FOR [PurchaseDetailId]
GO
ALTER TABLE [dbo].[Stocks] ADD  DEFAULT ((0)) FOR [IsSync]
GO
ALTER TABLE [dbo].[Transactions] ADD  DEFAULT ((0)) FOR [PurchaseDetailId]
GO
ALTER TABLE [dbo].[Transactions] ADD  DEFAULT ((0)) FOR [IncExpTag]
GO
ALTER TABLE [dbo].[Transactions] ADD  DEFAULT ((0)) FOR [ProjectIdType]
GO
ALTER TABLE [dbo].[Transactions] ADD  DEFAULT ((0)) FOR [IsProcessed]
GO
ALTER TABLE [dbo].[Transactions] ADD  DEFAULT ((0)) FOR [IsSync]
GO
ALTER TABLE [dbo].[TransactionsHistories] ADD  DEFAULT ((0)) FOR [TransactionTypeId]
GO
ALTER TABLE [dbo].[TransactionsHistories] ADD  DEFAULT ((0)) FOR [IncExpTag]
GO
ALTER TABLE [dbo].[TransactionsHistories] ADD  DEFAULT ((0)) FOR [ProjectIdType]
GO
ALTER TABLE [dbo].[TransactionsHistories] ADD  DEFAULT ((0)) FOR [IsProcessed]
GO
ALTER TABLE [dbo].[TransactionsHistories] ADD  DEFAULT ((0)) FOR [IsSync]
GO
ALTER TABLE [dbo].[TransactionTypes] ADD  DEFAULT ((0)) FOR [IsSync]
GO
ALTER TABLE [dbo].[Units] ADD  DEFAULT ((0)) FOR [IsSync]
GO
ALTER TABLE [dbo].[UnitTypes] ADD  DEFAULT ((0)) FOR [IsSync]
GO
ALTER TABLE [dbo].[UploadedImages] ADD  DEFAULT ((0)) FOR [IsSync]
GO
ALTER TABLE [dbo].[UserPermissions] ADD  DEFAULT ((0)) FOR [IsSync]
GO
ALTER TABLE [dbo].[Users] ADD  DEFAULT ((0)) FOR [IsSync]
GO
ALTER TABLE [dbo].[VehicleTypes] ADD  DEFAULT ((0)) FOR [IsSync]
GO
/****** Object:  StoredProcedure [dbo].[CalculateTotalCoalTaken]    Script Date: 11/6/2020 5:09:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CalculateTotalCoalTaken] (@PartyId int,@StockId INT)
AS
BEGIN
	SELECT ISNULL(SUM(CKL.WeightInTons - KG.WeightInTons),0) 'TotalWeight'
			FROM Kanta_General KG JOIN Company_Kanta_Log CKL ON KG.Id = CKL.Kanta_General_Id
		WHERE KG.CompanyId = @PartyId AND CKL.CompanyChargesId = @StockId
END
GO
/****** Object:  StoredProcedure [dbo].[Company_Client_Bill]    Script Date: 11/6/2020 5:09:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Company_Client_Bill] (@FromDate DATE,@ToDate DATE,@Type INT,@Individual INT)
AS
BEGIN


SELECT C.PartyName ,  CAST(DATENAME(MONTH,kg.EntryDateTime) AS VARCHAR(20)) + ' ' + CAST(DATEPART(YEAR,KG.EntryDateTime) AS VARCHAR(20)) 'Month',
			DATEPART(MONTH,KG.EntryDateTime) 'MonthId' , DATEPART(YEAR,KG.EntryDateTime) 'YearId'
		, SUM(CKL.WeightInTons - KG.WeightInTons) 'Weight_Ton' , SUM(CKL.TotalPrice) 'TotalPrice' , COUNT(KG.Id) 'TotalTrips'
		FROM Kanta_General KG JOIN Company_Kanta_Log CKL ON KG.Id = CKL.Kanta_General_Id
			JOIN Companies C ON C.Id = kg.CompanyId
		WHERE kg.EntryDateTime >= @FromDate AND kg.EntryDateTime < DATEADD(DAY,1,@ToDate)
			AND KG.CustomerTypeId = CASE WHEN @Type = 0 THEN KG.CustomerTypeId ELSE @Type END
			AND KG.CompanyId = CASE WHEN @Individual = 0 THEN KG.CompanyId ELSE @Individual END
			AND KG.IsEmpty = 0 
	GROUP BY DATENAME(MONTH,kg.EntryDateTime) , DATEPART(YEAR,KG.EntryDateTime),
			DATEPART(MONTH,KG.EntryDateTime) , C.PartyName
	ORDER BY PartyName , YearId , MonthId
END
GO
/****** Object:  StoredProcedure [dbo].[CurrentStock]    Script Date: 11/6/2020 5:09:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[CurrentStock]
AS
BEGIN
	SELECT I.ItemName , U.UnitName , SUM(S.Quantity) 'TotalReceived' , SUM(S.Consumed) 'TotalAssigned' , SUM(S.Quantity-S.Consumed) 'TotalAvailable',
		SUM((S.Quantity - s.Consumed) * S.UnitPrice) 'TotalValue' 
		FROM Items i join Stocks S ON I.Id = S.ItemId JOIN Units U ON U.Id = S.UnitId
	GROUP BY I.ItemName , U.UnitName
END
GO
/****** Object:  StoredProcedure [dbo].[Employees_Get]    Script Date: 11/6/2020 5:09:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Employees_Get]
AS
SELECT ET.EmployeeTypeDescription , E.EmployeeName , E.EmployeeCNIC , E.EmployeeSalary , E.EmployeeJoiningDate , E.EmployeeLeavingDate ,
			E.IsActive , 
CASE WHEN PartyId = 0 THEN 'Not Applicable' ELSE (SELECT PartyName FROM Companies C WHERE C.Id = PartyId ) END 'Company',
CASE WHEN MineId = 0 THEN 'Not Applicable' ELSE (SELECT MineDescription FROM Mine C WHERE C.Id = MineId ) END 'Mine',
CASE WHEN WorksUnderEmployeeId = 0 THEN 'Not Applicable' ELSE (SELECT EmployeeName FROM Employees C WHERE C.Id = WorksUnderEmployeeId ) END 'Employee'

FROM EmployeeTypes ET JOIN Employees E ON ET.Id = E.EmployeeType
GO
/****** Object:  StoredProcedure [dbo].[Get_StockAssignments]    Script Date: 11/6/2020 5:09:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Get_StockAssignments] (@FromDate DATE,@ToDate DATE)
AS
BEGIN
	SELECT iD , AssignedDateTime , InvoiceNumber , ItemId , UnitId ,Quantity,
		 MineId , CompanyId , UserId , 
		 (SELECT UnitName FROM Units WHERE Units.Id = StockAssignments.UnitId) 'UnitName' ,
		 (SELECT ItemName FROM Items WHERE Items.Id = StockAssignments.ItemId) 'ItemName' 
		 FROM StockAssignments
		WHERE AssignedDateTime >= @FromDate AND AssignedDateTime < DATEADD(DAY,1,@ToDate)
END
GO
/****** Object:  StoredProcedure [dbo].[Get_StockAssignments_ByInvoice]    Script Date: 11/6/2020 5:09:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Get_StockAssignments_ByInvoice] (@InvoiceNumber BIGINT)
AS
BEGIN
	SELECT iD , AssignedDateTime , InvoiceNumber , ItemId , UnitId ,Quantity,
		 MineId , CompanyId , UserId , 
		 (SELECT UnitName FROM Units WHERE Units.Id = StockAssignments.UnitId) 'UnitName' ,
		 (SELECT ItemName FROM Items WHERE Items.Id = StockAssignments.ItemId) 'ItemName' 
		 FROM StockAssignments
		WHERE InvoiceNumber = @InvoiceNumber
END
GO
/****** Object:  StoredProcedure [dbo].[Income_Expense_Tag_Report]    Script Date: 11/6/2020 5:09:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Income_Expense_Tag_Report] (@FromDate DATE,@ToDate DATE)
AS
BEGIN
	SELECT CASE WHEN IncExpTag = 1 THEN 'Income' ELSE 'Expense' END 'Type',
		A.AccountTitle , Particulars , m.MineDescription 'Mine' ,ABS(tr.Amount) 'Amount'	FROM Transactions tr join Accounts A ON A.AccountId = TR.AccountId
		LEFT JOIN Mine M ON M.Id = tr.MineId
		WHERE TR.TransactionDate >= @FromDate AND Tr.TransactionDate < dateadd(day,1,@ToDate) AND tr.IncExpTag in (1,2)
END
GO
/****** Object:  StoredProcedure [dbo].[Income_Expense_Tag_Report_ForDisplay]    Script Date: 11/6/2020 5:09:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Income_Expense_Tag_Report_ForDisplay]
AS
BEGIN
DECLARE @StartDate DATE
	SET @StartDate = CAST(CAST(MONTH(GETDATE()) AS VARCHAR(20)) +'/1/' + CAST(YEAR(GETDATE()) AS VARCHAR(20)) AS DATE)
	DECLARE @LastDate DATE;
	SET @LastDate = EOMONTH(@StartDate)

	SELECT * FROM (
	SELECT CASE WHEN IncExpTag = 1 THEN 'Income' ELSE 'Expense' END 'Type'
		  ,ABS(tr.Amount) 'Amount' , 
		
		CASE WHEN ProjectIdType = 0 THEN 'Not Tagged' WHEN ProjectIdType = 1 THEN (SELECT ProjectName FROM Projects WHERE projects.Id = TR.ProjectId)
		WHEN ProjectIdType = 2 THEN (SELECT EmployeeName FROM Employees WHERE Employees.Id = TR.ProjectId)
		WHEN ProjectIdType = 3 THEN (SELECT AccountTitle from Accounts WHERE Accounts.AccountId = tr.ProjectId) END 'TaggedAccount',
		CASE WHEN ProjectIdType = 3 AND EXISTS (SELECT * FROM Companies WHERE Companies.AccountId = tr.ProjectId AND Companies.CustomerTypeId = 1) THEN 'Company'
			WHEN ProjectIdType = 3 AND EXISTS (SELECT * FROM Companies WHERE Companies.AccountId = tr.ProjectId AND Companies.CustomerTypeId = 2) THEN 'Customer'
			WHEN ProjectIdType = 3 AND EXISTS (SELECT * FROM Companies WHERE Companies.AccountId = tr.ProjectId AND Companies.CustomerTypeId = 3) THEN 'Fixed Tekadar'
			WHEN ProjectIdType = 3 AND EXISTS (SELECT * FROM Companies WHERE Companies.AccountId = tr.ProjectId AND Companies.CustomerTypeId = 4) THEN 'Mate'
			WHEN ProjectIdType = 3 AND NOT EXISTS (SELECT * FROM Companies WHERE Companies.AccountId = tr.ProjectId) THEN 'General Account'
		END 'AccountType'
			FROM Transactions tr join Accounts A ON A.AccountId = TR.AccountId
		LEFT JOIN Mine M ON M.Id = tr.MineId
		WHERE TR.TransactionDate >= @StartDate AND Tr.TransactionDate < dateadd(day,1,@LastDate) AND  tr.IncExpTag in (1)) AS S
		WHERE S.AccountType IN ('Customer','Company')
		ORDER BY AccountType
END
GO
/****** Object:  StoredProcedure [dbo].[Invoice_Repint]    Script Date: 11/6/2020 5:09:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Invoice_Repint] @InvoiceNumber BIGINT
AS
BEGIN
	SELECT P.PurchaseDate , p.Amount , P.BillNumber , I.ItemName , PDD.Quantity , PDD.Amount 'UnitPrice', U.UnitName , 
		A.AccountTitle 'SupplierName'
			FROM Purchases P JOIN PurchaseDetails PDD ON P.Id = PDD.PurchaseId
		JOIN Items I ON I.Id = PDD.ItemId JOIN Units U ON U.Id = PDD.UnitId JOIN
		Accounts A ON A.AccountId = P.SupplierId
	WHERE P.InvoiceNumber = @InvoiceNumber
END
GO
/****** Object:  StoredProcedure [dbo].[Kanta_GetAdditionalCharges]    Script Date: 11/6/2020 5:09:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Kanta_GetAdditionalCharges] (@InvoiceNumber VARCHAR(50))
AS
BEGIN
	SELECT ChargesDescription , Charges FROM Party_Kanta_Log_AdditionalChargesDetail
		WHERE InvoiceNumber = @InvoiceNumber
END
GO
/****** Object:  StoredProcedure [dbo].[Packages_Get]    Script Date: 11/6/2020 5:09:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Packages_Get]
AS
BEGIN
	SELECT 
		CASE WHEN AccountIdCondition_CompanyId = 0 THEN 
			'Any Company' ELSE (SELECT PartyName FROM Companies WHERE Id = AccountIdCondition_CompanyId) end 'AccountTitle'
			,Id , IsCredit , IsFixed , FixedValue , PerTonValue ,
		CASE WHEN MineCondition = 0 THEN 'Any Mine' ELSE (SELECT MineDescription FROM Mine WHERE Id = MineCondition) end 'MineDescription'

	FROM Kanta_Mine_AdditionalPackages KMA 
			
END
GO
/****** Object:  StoredProcedure [dbo].[RateList_ForDisplay]    Script Date: 11/6/2020 5:09:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[RateList_ForDisplay]
AS
BEGIN
	SELECT M.MineDescription , MP.PerTonRate
		FROM Mine M JOIN Mines_PerTonCharges MP ON M.Id = MP.MineId

END
GO
/****** Object:  StoredProcedure [dbo].[Report_Attendence]    Script Date: 11/6/2020 5:09:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[Report_Attendence] (@Date DATE)
AS
BEGIN
	SELECT E.EmployeeName , EA.TotalDutyHours , DATEDIFF(HOUR,EA.CheckOutDateTime , EA.CheckInDateTime) 'TotalHours' ,
	DATEDIFF(MINUTE,EA.CheckOutDateTime , CheckInDateTime) 'TotalMinutes'
		FROM Employees E LEFT JOIN EmployeeAttendences EA ON E.Id = EA.EmployeeId
	WHERE EA.EntryDateTime >= @Date AND EA.EntryDateTime < DATEADD(DAY,1,@Date)
END
GO
/****** Object:  StoredProcedure [dbo].[Report_AttendenceDetail]    Script Date: 11/6/2020 5:09:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[Report_AttendenceDetail] (@FromDate DATE , @ToDate DATE , @EmployeeId int)
AS
BEGIN

	DECLARE @TableDates TABLE (EntryDate DATE)

	IF @EmployeeId > 0
		BEGIN
	
			;WITH GetDates As  
			(  
				SELECT 1 as counter, @FromDate as EntryDate   
				UNION ALL  
				select counter + 1, DATEADD(day,counter,@FromDate)  
				from GetDates  
				where DATEADD(day, counter, @FromDate) <= @ToDate  
			) 
			INSERT INTO @TableDates (EntryDate) 
			SELECT EntryDate FROM GetDates;

			SELECT S1.EmployeeName , S1.EntryDate , Format(ATT.EntryDate,'dd-MM-yyyy') 'EntryDate' , ATT.CheckInDateTime , ATT.CheckOutDateTime , ATT.Hours 'TotalHours' FROM (
			SELECT S.Id ,EmployeeName , S.EntryDate   FROM (
			SELECT E.Id , EmployeeName , D.EntryDate
			FROM Employees E CROSS APPLY (
			SELECT * FROM @TableDates) AS D WHERE E.id = @EmployeeId) AS S ) AS S1

			OUTER APPLY (
				SELECT CAST(EntryDateTime AS DATE) 'EntryDate' , EA.CheckInDateTime , EA.CheckOutDateTime , 
										 DATEDIFF(HOUR,EA.CheckInDateTime , EA.CheckOutDateTime) 'Hours' 
											FROM EmployeeAttendences EA WHERE CAST(EA.EntryDateTime AS DATE) = S1.EntryDate
												AND EA.EmployeeId = S1.Id
			) AS ATT
			ORDER BY S1.EmployeeName , S1.EntryDate
		END
	ELSE
	BEGIN
		;WITH GetDates As  
		(  
			SELECT 1 as counter, @FromDate as EntryDate   
			UNION ALL  
			select counter + 1, DATEADD(day,counter,@FromDate)  
			from GetDates  
			where DATEADD(day, counter, @FromDate) <= @ToDate  
		) 
		INSERT INTO @TableDates (EntryDate) 
		SELECT EntryDate FROM GetDates;

		SELECT S1.EmployeeName , FORMAT(S1.EntryDate,'dd-MM-yyyy') 'EntryDate' , ATT.EntryDate , ATT.CheckInDateTime , ATT.CheckOutDateTime , ATT.Hours 'TotalHours' FROM (
		SELECT S.Id ,EmployeeName , S.EntryDate   FROM (
		SELECT E.Id , EmployeeName , D.EntryDate
		FROM Employees E CROSS APPLY (
		SELECT * FROM @TableDates) AS D ) AS S ) AS S1

		OUTER APPLY (
			SELECT CAST(EntryDateTime AS DATE) 'EntryDate' , EA.CheckInDateTime , EA.CheckOutDateTime , 
									 DATEDIFF(HOUR,EA.CheckInDateTime , EA.CheckOutDateTime) 'Hours' 
										FROM EmployeeAttendences EA WHERE CAST(EA.EntryDateTime AS DATE) = S1.EntryDate
											AND EA.EmployeeId = S1.Id
		) AS ATT
		ORDER BY S1.EmployeeName , S1.EntryDate
	END
END
GO
/****** Object:  StoredProcedure [dbo].[Report_Expenses_Detail]    Script Date: 11/6/2020 5:09:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Report_Expenses_Detail] (@FromDate DATE,@ToDate DATE)
AS
SELECT A.AccountTitle ,Amount , SerialNo , Particulars , TransactionDate FROM Heads H JOIN Categories C ON H.Id = C.HeadId JOIN 
	Accounts A ON c.CategoryId = a.CategoryId JOIN	Transactions T ON A.AccountId = T.AccountId
WHERE TransactionDate >= @FromDate AND TransactionDate < DATEADD(DAY,1,@ToDate)
	AND Amount > 0 AND H.Id = 2



GO
/****** Object:  StoredProcedure [dbo].[Report_ForDisplayLCD]    Script Date: 11/6/2020 5:09:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

	CREATE PROCEDURE [dbo].[Report_ForDisplayLCD] AS
	DECLARE @Date DATE
	SET @Date = GETDATE();
	DECLARE @StartDate DATE
	SET @StartDate = CAST(CAST(MONTH(GETDATE()) AS VARCHAR(20)) +'/1/' + CAST(YEAR(GETDATE()) AS VARCHAR(20)) AS DATE)
	DECLARE @LastDate DATE;
	SET @LastDate = EOMONTH(@Date)

	DECLARE @InVehicleToday INT
	DECLARE @InOutVehicleToday INT
	DECLARE @TotalTonToday MONEY

	DECLARE @EmptyVehicleMonthly INT
	DECLARE @InOutVehicleMonthly INT
	DECLARE @TotalTonMonthly MONEY

	SELECT @InVehicleToday =  COUNT(KG.Id)
	FROM Kanta_General KG 
	WHERE KG.EntryDateTime >= @Date and kg.HasDetail = 0 and kg.IsEmpty = 0

	SELECT @InOutVehicleToday = COUNT(KG.Id)
	FROM Kanta_General KG JOIN Company_Kanta_Log CKL ON KG.Id = CKL.Kanta_General_Id
	WHERE KG.EntryDateTime >= @Date

	SELECT @TotalTonToday = SUM(CKL.WeightInTons - KG.WeightInTons)
	FROM Kanta_General KG JOIN Company_Kanta_Log CKL ON KG.Id = CKL.Kanta_General_Id
	WHERE KG.EntryDateTime >= @Date


	SELECT @InOutVehicleMonthly = COUNT(KG.Id)
	FROM Kanta_General KG JOIN Company_Kanta_Log CKL ON KG.Id = CKL.Kanta_General_Id
	WHERE KG.EntryDateTime >= @StartDate AND KG.EntryDateTime < DATEADD(DAY,1,@LastDate)

	SELECT @TotalTonMonthly = SUM(CKL.WeightInTons - KG.WeightInTons)
	FROM Kanta_General KG JOIN Company_Kanta_Log CKL ON KG.Id = CKL.Kanta_General_Id
	WHERE KG.EntryDateTime >= @StartDate AND KG.EntryDateTime < DATEADD(DAY,1,@LastDate)


	SELECT @EmptyVehicleMonthly = COUNT(KG.Id)
	FROM Kanta_General KG 
	WHERE KG.EntryDateTime >= @StartDate AND KG.EntryDateTime < DATEADD(DAY,1,@LastDate) and kg.IsEmpty = 1


	DECLARE @QoumiMonthly MONEY
	DECLARE @CompanyMonthly MONEY
	DECLARE @QoumiMonthlyWeight MONEY
	DECLARE @CompanyMonthlyWeight MONEY

	SELECT @QoumiMonthly = COUNT(KG.Id)
	FROM Kanta_General KG JOIN Company_Kanta_Log CKL ON KG.Id = CKL.Kanta_General_Id
	WHERE KG.EntryDateTime >= @StartDate AND KG.EntryDateTime < DATEADD(DAY,1,@LastDate) AND KG.CompanyId IN (
	SELECT Companies.Id FROM Companies WHERE CustomerTypeId = 2)

	SELECT @CompanyMonthly = COUNT(KG.Id)
	FROM Kanta_General KG JOIN Company_Kanta_Log CKL ON KG.Id = CKL.Kanta_General_Id
	WHERE KG.EntryDateTime >= @StartDate AND KG.EntryDateTime < DATEADD(DAY,1,@LastDate) AND KG.CompanyId IN (
	SELECT Companies.Id FROM Companies WHERE CustomerTypeId = 1)

	SELECT @CompanyMonthlyWeight = SUM(CKL.WeightInTons - KG.WeightInTons)
	FROM Kanta_General KG JOIN Company_Kanta_Log CKL ON KG.Id = CKL.Kanta_General_Id
	WHERE KG.EntryDateTime >= @StartDate AND KG.EntryDateTime < DATEADD(DAY,1,@LastDate) AND KG.CompanyId IN (
	SELECT Companies.Id FROM Companies WHERE CustomerTypeId = 1)

	SELECT @QoumiMonthlyWeight = SUM(CKL.WeightInTons - KG.WeightInTons)
	FROM Kanta_General KG JOIN Company_Kanta_Log CKL ON KG.Id = CKL.Kanta_General_Id
	WHERE KG.EntryDateTime >= @StartDate AND KG.EntryDateTime < DATEADD(DAY,1,@LastDate) AND KG.CompanyId IN (
	SELECT Companies.Id FROM Companies WHERE CustomerTypeId = 2)


	DECLARE @TotalCompanyAmountToday MONEY
	DECLARE @TotalCustomerAmountToday MONEY
	DECLARE @TotalCompanyAmountMonthly MONEY
	DECLARE @TotalCustomerAmountMonthly MONEY
	
	SELECT @TotalCompanyAmountToday = SUM(ckl.TotalPrice)
	FROM Kanta_General KG JOIN Company_Kanta_Log CKL ON KG.Id = CKL.Kanta_General_Id
	WHERE KG.EntryDateTime >= @Date AND KG.CompanyId IN (
	SELECT Companies.Id FROM Companies WHERE CustomerTypeId = 1)

	
	SELECT @TotalCustomerAmountToday = SUM(ckl.TotalPrice)
	FROM Kanta_General KG JOIN Company_Kanta_Log CKL ON KG.Id = CKL.Kanta_General_Id
	WHERE KG.EntryDateTime >= @Date AND KG.CompanyId IN (
	SELECT Companies.Id FROM Companies WHERE CustomerTypeId = 2)

	SELECT @TotalCompanyAmountMonthly = SUM(ckl.TotalPrice)
	FROM Kanta_General KG JOIN Company_Kanta_Log CKL ON KG.Id = CKL.Kanta_General_Id
	WHERE KG.EntryDateTime >= @StartDate AND KG.EntryDateTime < DATEADD(DAY,1,@LastDate) AND KG.CompanyId IN (
	SELECT Companies.Id FROM Companies WHERE CustomerTypeId = 1)

	
	SELECT @TotalCustomerAmountMonthly = SUM(ckl.TotalPrice)
	FROM Kanta_General KG JOIN Company_Kanta_Log CKL ON KG.Id = CKL.Kanta_General_Id
	WHERE KG.EntryDateTime >= @StartDate AND KG.EntryDateTime < DATEADD(DAY,1,@LastDate) AND KG.CompanyId IN (
	SELECT Companies.Id FROM Companies WHERE CustomerTypeId = 2)


	SELECT @InVehicleToday 'TotalInToday', @InOutVehicleToday  'TotalOutToday', @TotalTonToday 'TotalTonsToday'
			, @EmptyVehicleMonthly 'EmptyMonthly', @InOutVehicleMonthly 'TotalOutMontly', @TotalTonMonthly 'TotalTonMonthly'
			, @QoumiMonthly 'TotalOutQoumiMonthly', @CompanyMonthly 'TotalOutCompanyMonthly',
					@QoumiMonthlyWeight 'QoumiMonthlyWeight', @CompanyMonthlyWeight 'CompanyMonthlyWeight' , 
					@TotalCustomerAmountToday 'CustomerAmountToday' , @TotalCustomerAmountMonthly 'CustomerAmountMonthly',
					@TotalCompanyAmountToday 'CompanyAmountToday' , @TotalCompanyAmountMonthly 'CompanyAmountMonthly'
GO
/****** Object:  StoredProcedure [dbo].[Report_MineWise_ForLcd]    Script Date: 11/6/2020 5:09:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Report_MineWise_ForLcd]  (@MineID INT)
AS
BEGIN

	DECLARE @StartDate DATE
	SET @StartDate = CAST(CAST(MONTH(GETDATE()) AS VARCHAR(20)) +'/1/' + CAST(YEAR(GETDATE()) AS VARCHAR(20)) AS DATE)
	DECLARE @LastDate DATE;
	SET @LastDate = EOMONTH(@StartDate)


	DECLARE @MineName NVARCHAR(200)
	DECLARE @MineRate MONEY
	DECLARE @TotalProduction MONEY
	DECLARE @TotalExpense MONEY
	DECLARE @TotalSold MONEY

	DECLARE @AllTotalProduction MONEY
	DECLARE @AllTotalExpense MONEY
	DECLARE @AllTotalSold MONEY

	SELECT @MineName = MineDescription From Mine WHERE Id = @MineID
	SELECT @MineRate = PerTonRate FROM Mines_PerTonCharges WHERE Mines_PerTonCharges.MineId = @MineID AND IsActive = 1
	SELECT @TotalProduction = (SELECT SUM(CKL.WeightInTons - KG.WeightInTons) FROM Kanta_General KG JOIN Company_Kanta_Log CKL ON KG.Id = CKL.Kanta_General_Id
					WHERE KG.IsEmpty = 0 AND KG.EntryDateTime >= @StartDate and kg.EntryDateTime < DATEADD(DAY,1,@LastDate) AND CKL.MineId = @MineID)
	SELECT @TotalExpense = (SELECT SUM(Amount) FROM Transactions WHERE MineId = @MineID AND IncExpTag = 2 AND TransactionDate >= @StartDate AND TransactionDate < DATEADD(DAY,1,@LastDate))


	SELECT @AllTotalProduction = (SELECT SUM(CKL.WeightInTons - KG.WeightInTons) FROM Kanta_General KG JOIN Company_Kanta_Log CKL ON KG.Id = CKL.Kanta_General_Id
					WHERE KG.IsEmpty = 0 AND kg.EntryDateTime < DATEADD(DAY,1,@LastDate) AND CKL.MineId = @MineID)
	SELECT @AllTotalExpense = (SELECT SUM(Amount) FROM Transactions WHERE MineId = @MineID AND IncExpTag = 2 AND TransactionDate < DATEADD(DAY,1,@LastDate))


	SELECT @TotalSold = (SELECT SUM(CKL.TotalPrice) FROM Kanta_General KG JOIN Company_Kanta_Log CKL ON KG.Id = CKL.Kanta_General_Id
					WHERE KG.IsEmpty = 0 AND KG.EntryDateTime >= @StartDate and kg.EntryDateTime < DATEADD(DAY,1,@LastDate) AND CKL.MineId = @MineID)


	SELECT @AllTotalSold = (SELECT SUM(CKL.TotalPrice) FROM Kanta_General KG JOIN Company_Kanta_Log CKL ON KG.Id = CKL.Kanta_General_Id
					WHERE KG.IsEmpty = 0 AND kg.EntryDateTime < DATEADD(DAY,1,@LastDate) AND CKL.MineId = @MineID)

	SELECT @MineName 'MineName' , IsNull(@MineRate,0) 'MineRate' , IsNull(@TotalProduction,0) 'TotalProduction'
			, IsNull(@TotalExpense,0) 'TotalExpense', IsNull(@AllTotalProduction,0) 'AllTotalProduction',
				IsNull(@AllTotalExpense,0) 'AllTotalExpense' , Isnull(@TotalSold,0) 'TotalSold' , IsNull(@AllTotalSold,0) 'AllTotalSold'
END
GO
/****** Object:  StoredProcedure [dbo].[Reports_AssignedMines]    Script Date: 11/6/2020 5:09:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Reports_AssignedMines] (@FromDate DATE,@ToDate DATE , @MineId INT , @CompanyId INT)
AS
BEGIN
	SET @MineId = CASE WHEN @MineId = 0 THEN NULL ELSE @MineId END
	SET @CompanyId = CASE WHEN @CompanyId = 0 THEN NULL ELSE @CompanyId END

	SELECT I.ItemName , U.UnitName , S.Quantity , S.AssignedDateTime,
		CASE WHEN S.MineId = 0 THEN 'No Mine Selected' ELSE (SELECT MineDescription FROM Mine WHERE Mine.Id = S.MineId) END 'Mine',
		CASE WHEN S.CompanyId = 0 THEN 'No Company Selected' ELSE (SELECT PartyName FROM Companies WHERE Companies.Id = S.CompanyId) END 'Company',
		S.TotalPrice , Deliverer , Receiver , 
		(SELECT AccountTitle FROM Accounts WHERE AccountId = (DebitInAccountId)) 'AccountAffected'
	FROM Items I JOIN StockAssignments S ON I.Id = S.ItemId
		join Units u on u.id = s.UnitId 
		WHERE S.AssignedDateTime >= @FromDate AND S.AssignedDateTime < DATEADD(DAY,1,@ToDate)
				AND S.MineId = ISNULL(@MineId , S.MineId) AND S.CompanyId = ISNULL(@CompanyId,S.CompanyId)

END
GO
/****** Object:  StoredProcedure [dbo].[Reports_AuditEntriesWise]    Script Date: 11/6/2020 5:09:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Reports_AuditEntriesWise] (@FromDate DATE,@ToDate DATE,@Type INT,@AccountTypeFilter INT)
AS
--declare @Type int -- 1 = DEBIT , 2 = CREDIT
--DECLARE @AccountTypeFilter INT -- 1 = company , 2 = customer , 3 = all

IF @Type = 1
BEGIN
	IF @AccountTypeFilter = 1
	BEGIN
		SELECT  A.AccountTitle , TR.Particulars , tr.SerialNo , tr.Amount , tr.BillNumber , tr.ChequeNumber , tr.TransactionDate FROM Accounts A JOIN Transactions TR ON A.AccountId = TR.AccountId
			WHERE TR.TransactionDate >= @FromDate AND TR.TransactionDate < DATEADD(DAY,1,@ToDate)
				AND	A.AccountId IN (SELECT AccountId FROM Companies WHERE CustomerTypeId = 1)
	END
	ELSE IF @AccountTypeFilter = 2
	BEGIN
		SELECT A.AccountTitle , TR.Particulars , tr.SerialNo , tr.Amount , tr.BillNumber , tr.ChequeNumber , tr.TransactionDate FROM Accounts A JOIN Transactions TR ON A.AccountId = TR.AccountId
			WHERE TR.TransactionDate >= @FromDate AND TR.TransactionDate < DATEADD(DAY,1,@ToDate)
				AND	A.AccountId IN (SELECT AccountId FROM Companies WHERE CustomerTypeId = 2)
				AND TR.Amount > 0		
	END
	ELSE IF @AccountTypeFilter = 3
	BEGIN
		SELECT A.AccountTitle , TR.Particulars , tr.SerialNo , tr.Amount , tr.BillNumber , tr.ChequeNumber , tr.TransactionDate FROM Accounts A JOIN Transactions TR ON A.AccountId = TR.AccountId
			WHERE TR.TransactionDate >= @FromDate AND TR.TransactionDate < DATEADD(DAY,1,@ToDate)				
				and a.AccountId NOT IN (SELECT AccountId FROM Companies)
				AND TR.Amount > 0 
	END
END
ELSE
BEGIN
	IF @AccountTypeFilter = 1
	BEGIN
		SELECT A.AccountTitle , TR.Particulars , tr.SerialNo , tr.Amount , tr.BillNumber , tr.ChequeNumber , tr.TransactionDate FROM Accounts A JOIN Transactions TR ON A.AccountId = TR.AccountId
			WHERE TR.TransactionDate >= @FromDate AND TR.TransactionDate < DATEADD(DAY,1,@ToDate)
				AND	A.AccountId IN (SELECT Accountid FROM Companies WHERE CustomerTypeId = 1)
				AND TR.Amount < 0
	END
	ELSE IF @AccountTypeFilter = 2
	BEGIN
		SELECT A.AccountTitle , TR.Particulars , tr.SerialNo , tr.Amount , tr.BillNumber , tr.ChequeNumber , tr.TransactionDate FROM Accounts A JOIN Transactions TR ON A.AccountId = TR.AccountId
			WHERE TR.TransactionDate >= @FromDate AND TR.TransactionDate < DATEADD(DAY,1,@ToDate)
				AND	A.AccountId IN (SELECT AccountId FROM Companies WHERE CustomerTypeId = 2)
				AND TR.Amount < 0		
	END
	ELSE IF @AccountTypeFilter = 3
	BEGIN
		SELECT A.AccountTitle , TR.Particulars , tr.SerialNo , tr.Amount , tr.BillNumber , tr.ChequeNumber , tr.TransactionDate FROM Accounts A JOIN Transactions TR ON A.AccountId = TR.AccountId
			WHERE TR.TransactionDate >= @FromDate AND TR.TransactionDate < DATEADD(DAY,1,@ToDate)				
			AND a.AccountId NOT IN (SELECT AccountId FROM Companies)
			AND TR.Amount < 0
	END	
END
GO
/****** Object:  StoredProcedure [dbo].[Reports_BankReceiving]    Script Date: 11/6/2020 5:09:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Reports_BankReceiving] (@Id INT)
AS
BEGIN
	SELECT CL.ChequeReceivingDate , c.PartyName , B.BankName , BA.AccountTitle + ' ' + BA.AccountNumber 'AccountTitle'
		, CL.ChequeNumber , CL.ChequeClearingDate , CL.ChequeAmount , U.UserName , 
		CASE WHEN cl.ImageId = 0 then NULL ELSE 
		(SELECT ImageBase64 FROM UploadedImages WHERE Id = CL.ImageId)
		END 'ChequePicture'
		FROM Companies C JOIN Cheque_Log CL ON C.Id = CL.PartyId
		JOIN Banks B ON B.Id = CL.BankId JOIN BankAccounts BA ON BA.Id = CL.BankAccountId
		JOIN Users U ON U.Id = CL.UserId
		
	WHERE CL.Id = @Id
END
GO
/****** Object:  StoredProcedure [dbo].[Reports_CategoryWiseAccounts]    Script Date: 11/6/2020 5:09:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Reports_CategoryWiseAccounts]
AS
BEGIN
	SELECT C.CategoryName , A.AccountCode , A.AccountTitle  FROM Categories C JOIN Accounts A ON C.CategoryId = A.CategoryId
END
GO
/****** Object:  StoredProcedure [dbo].[Reports_ChequePendingReport]    Script Date: 11/6/2020 5:09:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Reports_ChequePendingReport] (@FromDate DATE,@ToDate DATE,@PartyId INT , @Status INT)
AS
BEGIN
	SET @PartyId = CASE WHEN @PartyId = 0 THEN NULL ELSE @PartyId END
	SET @Status = CASE WHEN @Status = 0 THEN NULL ELSE @Status END

	SELECT c.PartyName , BankName , AccountTitle , ChequeReceivingDate, ChequeClearingDate , ChequeAmount , ChequeNumber , IsCleared , Cs.Status
		FROM Banks B JOIN BankAccounts BA ON B.Id = BA.BankId 
		JOIN Cheque_Log CL ON BA.Id = CL.BankAccountId
		JOIN Companies C ON C.Id = cl.PartyId
		JOIN ChequeStatuses CS ON CS.id = cl.ChequeStatusId
		where CL.ChequeReceivingDate >= @FromDate AND CL.ChequeReceivingDate < DATEADD(DAY,1,@ToDate)
				AND CL.PartyId = ISNULL(@PartyId,CL.PartyId) AND cl.ChequeStatusId = ISNULL(@Status,cl.ChequeStatusId)

END
GO
/****** Object:  StoredProcedure [dbo].[Reports_Client_OverAllPosition]    Script Date: 11/6/2020 5:09:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Reports_Client_OverAllPosition] (@CompanyId INT)
AS
BEGIN

DECLARE @Balance DECIMAL(18,3)
DECLARE @CompanyAccountId INT = (SELECT AccountId FROM Companies WHERE Id = @CompanyId)
SELECT @Balance = SUM(Amount) FROM Transactions WHERE AccountId = @CompanyAccountId AND IsApproved = 1

SELECT S1.PartyName , TotalTonsAgreement , PerTonAgreement , TotalAmountAgreement , S2.TotalTons 'TotalTonsTaken' , S2.TotalPrice 'TotalPrice' , @Balance 'Balance' FROM (
	SELECT cpt.Id , c.PartyName , CPT.TotalTons 'TotalTonsAgreement' , cpt.PerTonRate 'PerTonAgreement', CPT.TotalAmount 'TotalAmountAgreement' , cpt.IsActive 
			FROM Companies C JOIN Company_PerTonCharges CPT ON C.Id = CPT.CompanyId WHERE CPT.CompanyId = @CompanyId) AS S1 CROSS APPLY

(		
	SELECT SUM(CKL.WeightInTons -  KG.WeightInTons) 'TotalTons' , SUM(CKL.TotalPrice) 'TotalPrice' 
				FROM Companies C JOIN Kanta_General KG ON C.id = KG.CompanyId JOIN Company_Kanta_Log CKL ON KG.Id = CKL.Kanta_General_Id
		WHERE CKL.CompanyChargesId = s1.Id
	) S2

UNION ALL

SELECT C.PartyName , 0 , 0 , 0 ,SUM(CKL.WeightInTons -  KG.WeightInTons) 'TotalTons' , SUM(CKL.TotalPrice) 'TotalPrice'  , 0
				FROM Companies C JOIN Kanta_General KG ON C.id = KG.CompanyId JOIN Company_Kanta_Log CKL ON KG.Id = CKL.Kanta_General_Id
		WHERE kg.CompanyId = @CompanyId
GROUP BY C.PartyName

END
GO
/****** Object:  StoredProcedure [dbo].[Reports_Companies]    Script Date: 11/6/2020 5:09:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Reports_Companies] (@ID INT,@fromdate date,@todate date)
AS
BEGIN
	SET @ID = case when @id = 0 then null else @ID end

	SELECT C.Id , CT.CustomerType 'Type' , C.PartyName , ContactNumber , (SELECT SUM(Amount) FROM Transactions WHERE Transactions.AccountId = c.AccountId) 'Balance',
				CNICNumber , CASE WHEN PerTonRate <= 0 THEN (SELECT TOP 1 PerTonRate FROM Company_PerTonCharges WHERE CompanyId = C.Id AND IsActive = 1 ORDER BY Id DESC)
					ELSE PerTonRate END 'PerTonRate',
			ISNULL((SELECT SUM(ckl.WeightInTons-kg.WeightInTons) 'TotalTons' FROM Kanta_General KG JOIN Company_Kanta_Log ckl on kg.Id = ckl.Kanta_General_Id WHERE kg.EntryDateTime >= @fromdate and kg.EntryDateTime < dateadd(day,1,@Todate) and kg.CompanyId = c.Id),0) 'TotalTons',
			ISNULL((SELECT SUM(ckl.TotalPrice) FROM Kanta_General KG JOIN Company_Kanta_Log ckl on kg.Id = ckl.Kanta_General_Id WHERE kg.EntryDateTime >= @fromdate and kg.EntryDateTime < dateadd(day,1,@Todate) and kg.CompanyId = c.Id),0) 'TotalPrice',
			ISNULL((SELECT COUNT(*) FROM Kanta_General KG JOIN Company_Kanta_Log ckl on kg.Id = ckl.Kanta_General_Id WHERE kg.EntryDateTime >= @fromdate and kg.EntryDateTime < dateadd(day,1,@Todate) and kg.CompanyId = c.Id),0) 'TotalTrips'
		FROM CustomerTypes CT JOIN Companies C on ct.Id = C.CustomerTypeId
		WHERE CT.Id = ISNULL(@ID,CT.id)
END
GO
/****** Object:  StoredProcedure [dbo].[Reports_CompanyWiseTotalVehiclesOut]    Script Date: 11/6/2020 5:09:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Reports_CompanyWiseTotalVehiclesOut] (@FromDate DATE,@ToDate DATE,@CustomerTypeId INT)
AS
set @CustomerTypeId =  CASE WHEN @CustomerTypeId = 0 then null else @CustomerTypeId end
SELECT  CT.CustomerType , C.PartyName , COUNT(KG.Id) 'TotalVehiclesOut' , SUM(CKL.WeightInTons - KG.WeightInTons) 'TotalTons' , SUM(ckl.totalprice) 'totalprice'
	FROM CustomerTypes CT JOIN Companies C on ct.Id = c.CustomerTypeId JOIN
	Kanta_General KG ON C.Id = KG.CompanyId JOIN Company_Kanta_Log CKL ON KG.Id = CKL.Kanta_General_Id
WHERE KG.EntryDateTime >= @FromDate AND KG.EntryDateTime < DATEADD(DAY,1,@ToDate) AND CT.Id = ISNULL(@CustomerTypeId,CT.Id)
GROUP BY CT.CustomerType , C.PartyName 
GO
/****** Object:  StoredProcedure [dbo].[Reports_DailyFirstWeightSheetByInvoice]    Script Date: 11/6/2020 5:09:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Reports_DailyFirstWeightSheetByInvoice] (@InvoiceNumber BIGINT)
AS
BEGIN
	SELECT KG.Id , VehicleNumber  , EntryDateTime , WeightInKilograms 'FirstWeight'
		FROM Kanta_General KG 
	WHERE InvoiceNumber = @InvoiceNumber
END
GO
/****** Object:  StoredProcedure [dbo].[Reports_DailyLedger]    Script Date: 11/6/2020 5:09:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Reports_DailyLedger] (@FromDate DATE,@ToDate DATE,@PartyId INT,@EntryType INT,@ProjectIdType INT)
AS
BEGIN
	DECLARE @OpeningBalance DECIMAL(18,3)

	IF @EntryType = 0
	BEGIN
		SET @OpeningBalance = (SELECT SUM(Amount) FROM Transactions WHERE TransactionDate < @FromDate AND AccountId = @PartyId)
	END
	ELSE
	BEGIN
		SET @OpeningBalance = (SELECT SUM(Amount) FROM Transactions WHERE TransactionDate < @FromDate AND AccountId = @PartyId AND ProjectId = @EntryType AND ProjectIdType = @ProjectIdType)
	END
	
	SET @OpeningBalance = ISNULL(@OpeningBalance,0)
	SET @EntryType = CASE WHEN @EntryType = 0 THEN NULL ELSE @EntryType END
	SET @ProjectIdType = CASE WHEN @EntryType = 0 or @EntryType IS NULL THEN NULL ELSE @ProjectIdType END

	SELECT * ,@OpeningBalance + SUM(Amount) OVER (Order By RowNum) 'Balance' , @OpeningBalance 'OpeningBalance' FROM (
	SELECT ROW_NUMBER() OVER (Order By TransactionDate) 'RowNum' , A.AccountTitle , T.TransactionDate , T.BillNumber , T.ChequeNumber
			, T.Particulars , T.Amount , TotalTons , (SELECT MineDescription FROM Mine WHERE Mine.Id = T.MineId)	'MineName' , T.SerialNo
			,CASE WHEN T.Amount < 0 THEN ABS(Amount) ELSE 0 END 'CreditEntries',
			CASE WHEN T.Amount > 0 THEN ABS(Amount) ELSE 0 END 'DebitEntries',
			P.ProjectName
		FROM Accounts A JOIN Transactions T ON A.AccountId = T.AccountId LEFT JOIN Projects P ON T.ProjectId = P.Id
		WHERE TransactionDate >= @FromDate AND TransactionDate < DATEADD(DAY,1,@ToDate)
				AND T.AccountId = @PartyId AND T.IsApproved = 1 AND T.ProjectId = ISNULL(@EntryType,T.ProjectId)
				AND T.ProjectIdType = ISNULL(@ProjectIdType,T.ProjectIdType)
				) AS S
END
GO
/****** Object:  StoredProcedure [dbo].[Reports_DailyWeightSheet]    Script Date: 11/6/2020 5:09:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Reports_DailyWeightSheet] (@FromDate DATE,@ToDate DATE)
AS
BEGIN
	SELECT KG.Id , KG.VehicleNumber , C.PartyName , it.ItemType , EntryDateTime , SecondWeightDateTime
	 , KG.WeightInKilograms 'FirstWeight' , CKL.WeightInKilograms 'SecondWeight' , CKL.WeightInKilograms - KG.WeightInKilograms 'NetWeight',
	 AdditionalPrice
			FROM Companies C JOIN Kanta_General KG ON C.Id = KG.CompanyId JOIN
			Company_Kanta_Log CKL ON KG.Id = CKL.Kanta_General_Id JOIN ItemTypes it on it.id = CKL.ItemType
		WHERE EntryDateTime >= @FromDate AND EntryDateTime < DATEADD(DAY,1,@ToDate)

END
GO
/****** Object:  StoredProcedure [dbo].[Reports_DailyWeightSheetByCompanyCustomer]    Script Date: 11/6/2020 5:09:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Reports_DailyWeightSheetByCompanyCustomer] (@FromDate DATE,@ToDate DATE,@Type INT)
AS
BEGIN
	
	IF @Type = 1 -- Company
	BEGIN
		SELECT CKL.SerialId 'Id', KG.VehicleNumber , C.PartyName , it.ItemType , EntryDateTime , SecondWeightDateTime
		 , KG.WeightInKilograms 'FirstWeight' , CKL.WeightInKilograms 'SecondWeight' , CKL.WeightInKilograms - KG.WeightInKilograms 'NetWeight',
		 AdditionalPrice , CKL.WeightInTons - KG.WeightInTons 'TotalWeightInTon'
				FROM Companies C JOIN Kanta_General KG ON C.Id = KG.CompanyId JOIN
				Company_Kanta_Log CKL ON KG.Id = CKL.Kanta_General_Id JOIN ItemTypes it on it.id = CKL.ItemType
			WHERE EntryDateTime >= @FromDate AND EntryDateTime < DATEADD(DAY,1,@ToDate) AND C.CustomerTypeId = 1
	END
	ELSE IF @Type = 2
	BEGIN
		SELECT CKL.SerialId 'Id' , KG.VehicleNumber , C.PartyName , it.ItemType , EntryDateTime , SecondWeightDateTime
		 , KG.WeightInKilograms 'FirstWeight' , CKL.WeightInKilograms 'SecondWeight' , CKL.WeightInKilograms - KG.WeightInKilograms 'NetWeight',
		 AdditionalPrice , CKL.WeightInTons - KG.WeightInTons 'TotalWeightInTon'
				FROM Companies C JOIN Kanta_General KG ON C.Id = KG.CompanyId JOIN
				Company_Kanta_Log CKL ON KG.Id = CKL.Kanta_General_Id JOIN ItemTypes it on it.id = CKL.ItemType
			WHERE EntryDateTime >= @FromDate AND EntryDateTime < DATEADD(DAY,1,@ToDate) AND C.CustomerTypeId = 2		
	END
END
GO
/****** Object:  StoredProcedure [dbo].[Reports_DailyWeightSheetByInvoice]    Script Date: 11/6/2020 5:09:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Reports_DailyWeightSheetByInvoice] (@InvoiceNumber BIGINT)
AS
BEGIN
	SELECT KG.Id , KG.VehicleNumber , C.PartyName , it.ItemType , EntryDateTime , SecondWeightDateTime
	 , KG.WeightInKilograms 'FirstWeight' , CKL.WeightInKilograms 'SecondWeight' , CKL.WeightInKilograms - KG.WeightInKilograms 'NetWeight',
	 AdditionalPrice , CKL.SerialId
			FROM Companies C JOIN Kanta_General KG ON C.Id = KG.CompanyId JOIN
			Company_Kanta_Log CKL ON KG.Id = CKL.Kanta_General_Id JOIN ItemTypes it on it.id = CKL.ItemType
		WHERE KG.InvoiceNumber = @InvoiceNumber

END
GO
/****** Object:  StoredProcedure [dbo].[Reports_DailyWeightSheetByParty]    Script Date: 11/6/2020 5:09:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Reports_DailyWeightSheetByParty] (@FromDate DATE,@ToDate DATE,@PartyId INT)
AS
BEGIN
	
	DECLARE @AccountID INT
	SET @AccountID = (SELECT Accountid from Companies WHERE id = @PartyId)
	DECLARE @Balance DECIMAL(18,3)
	SET @Balance = (SELECT ISNULL(SUM(Amount),0) FROM Transactions WHERE Accountid = @AccountID)

	SELECT @Balance 'Balance',KG.Id , KG.VehicleNumber , C.PartyName , it.ItemType , EntryDateTime , SecondWeightDateTime
	 , KG.WeightInKilograms 'FirstWeight' , CKL.WeightInKilograms 'SecondWeight' , CKL.WeightInKilograms - KG.WeightInKilograms 'NetWeight',
	 AdditionalPrice , CKL.WeightInTons - KG.WeightInTons 'TotalWeightInTon'
			FROM Companies C JOIN Kanta_General KG ON C.Id = KG.CompanyId JOIN
			Company_Kanta_Log CKL ON KG.Id = CKL.Kanta_General_Id JOIN ItemTypes it on it.id = CKL.ItemType
		WHERE EntryDateTime >= @FromDate AND EntryDateTime < DATEADD(DAY,1,@ToDate) AND KG.CompanyId = @PartyId

END
GO
/****** Object:  StoredProcedure [dbo].[Reports_DailyWeightSheetByVehicleNumber]    Script Date: 11/6/2020 5:09:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Reports_DailyWeightSheetByVehicleNumber] (@fromdate date,@todate date , @VehicleNumber VARCHAR(50))
AS
BEGIN
	SELECT KG.Id , KG.VehicleNumber , C.PartyName , it.ItemType , EntryDateTime , SecondWeightDateTime
	 , KG.WeightInKilograms 'FirstWeight' , CKL.WeightInKilograms 'SecondWeight' , CKL.WeightInKilograms - KG.WeightInKilograms 'NetWeight',
	 AdditionalPrice
			FROM Companies C JOIN Kanta_General KG ON C.Id = KG.CompanyId JOIN
			Company_Kanta_Log CKL ON KG.Id = CKL.Kanta_General_Id JOIN ItemTypes it on it.id = CKL.ItemType
		WHERE KG.EntryDateTime>=@fromdate AND KG.EntryDateTime < DATEADD(DAY,1,@ToDate) and KG.VehicleNumber = @VehicleNumber

END
GO
/****** Object:  StoredProcedure [dbo].[Reports_Expenses]    Script Date: 11/6/2020 5:09:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Reports_Expenses] (@FromDate DATE,@ToDate DATE)
AS
SELECT A.AccountTitle ,SUM(Amount) 'Amount' FROM Heads H JOIN Categories C ON H.Id = C.HeadId JOIN 
	Accounts A ON c.CategoryId = a.CategoryId JOIN	Transactions T ON A.AccountId = T.AccountId
WHERE TransactionDate >= @FromDate AND TransactionDate < DATEADD(DAY,1,@ToDate)
	AND Amount > 0 AND H.Id = 2
GROUP BY A.AccountTitle


GO
/****** Object:  StoredProcedure [dbo].[Reports_Income_Companies]    Script Date: 11/6/2020 5:09:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Reports_Income_Companies] (@FromDate DATE,@ToDate DATE)
AS
SELECT A.AccountTitle ,ABS(SUM(Amount)) 'Amount' FROM Transactions T JOIN Accounts A ON A.AccountId = T.AccountId
WHERE TransactionDate >= @FromDate AND TransactionDate < DATEADD(DAY,1,@ToDate)
	AND Amount < 0 AND t.AccountID IN (
SELECT AccountId FROM Companies WHERE CustomerTypeId = 1)
GROUP BY A.AccountTitle
GO
/****** Object:  StoredProcedure [dbo].[Reports_Income_Customers]    Script Date: 11/6/2020 5:09:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Reports_Income_Customers] (@FromDate DATE,@ToDate DATE)
AS
SELECT A.AccountTitle ,ABS(SUM(Amount)) 'Amount' FROM Transactions T JOIN Accounts A ON A.AccountId = T.AccountId
WHERE TransactionDate >= @FromDate AND TransactionDate < DATEADD(DAY,1,@ToDate)
	AND Amount < 0 AND t.AccountID IN (
SELECT AccountId FROM Companies WHERE CustomerTypeId = 2)
GROUP BY A.AccountTitle
GO
/****** Object:  StoredProcedure [dbo].[Reports_Kanta_Data]    Script Date: 11/6/2020 5:09:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Reports_Kanta_Data]
AS
DECLARE @InVehicle INT
DECLARE @InOutVehicle INT
DECLARE @EmptyVehicle INT

DECLARE @Date DATE
SET @Date = GETDATE()

SELECT @InVehicle =  COUNT(KG.Id)
	FROM Kanta_General KG 
	WHERE KG.EntryDateTime >= @Date and kg.HasDetail = 0 and kg.IsEmpty = 0

SELECT @InOutVehicle = COUNT(KG.Id)
	FROM Kanta_General KG JOIN Company_Kanta_Log CKL ON KG.Id = CKL.Kanta_General_Id
	WHERE KG.EntryDateTime >= @Date

SELECT @EmptyVehicle = COUNT(KG.Id)
	FROM Kanta_General KG 
	WHERE KG.EntryDateTime >= @Date and kg.IsEmpty = 1

SELECT @InVehicle 'InVehicle' , @InOutVehicle  'Outvehicle' , @EmptyVehicle 'EmptyVehicle'
GO
/****** Object:  StoredProcedure [dbo].[Reports_MainFormData]    Script Date: 11/6/2020 5:09:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Reports_MainFormData] (@UserId int)
AS
BEGIN
	DECLARE @Date DATE
	SET @Date = GETDATE();

	DECLARE @TotalVehiclesOut INT
	SET @TotalVehiclesOut = (SELECT COUNT(KG.Id) FROM Kanta_General KG JOIN Company_Kanta_Log CKL ON KG.Id = CKL.Kanta_General_Id WHERE
								KG.EntryDateTime >= @Date AND kg.EntryDateTime < DATEADD(DAY,1,@Date))
	DECLARE @TotaTonsTaken DECIMAL(18,3)
	SET @TotaTonsTaken = (SELECT ISNULL(SUM(CKL.WeightInTons - kg.WeightInTons),0)  FROM Kanta_General KG JOIN Company_Kanta_Log CKL ON KG.Id = CKL.Kanta_General_Id WHERE
								KG.EntryDateTime >= @Date AND kg.EntryDateTime < DATEADD(DAY,1,@Date))

	DECLARE @TotalFeeCollected DECIMAL(18,3)
	SET @TotalFeeCollected = (SELECT ISNULL(SUM(CKL.AdditionalPrice),0)  FROM Kanta_General KG JOIN Company_Kanta_Log CKL ON KG.Id = CKL.Kanta_General_Id WHERE
								KG.EntryDateTime >= @Date AND kg.EntryDateTime < DATEADD(DAY,1,@Date))

	DECLARE @Balance DECIMAL(18,3)
	SET @Balance = (SELECT SUM(Amount) FROM Transactions WHERE AccountId = (SELECT Users.AccountId FROM Users WHERE Users.Id = @UserId))
	SET @Balance = ISNULL(@Balance,0)

	DECLARE @ChequesToBeClearedToday INT
	SET @ChequesToBeClearedToday = (SELECT COUNT(Id) FROM Cheque_Log WHERE ChequeClearingDate < DATEADD(DAY,1,@Date) AND IsCleared = 0 and ChequeStatusId in (1))

	SELECT @TotalVehiclesOut 'TotalVehiclesOut' , @TotaTonsTaken 'TotalTonsTaken' , @TotalFeeCollected 'TotalFeeCollected' , @Balance 'Balance' , @ChequesToBeClearedToday 'TotalCheques'

END
GO
/****** Object:  StoredProcedure [dbo].[Reports_MineDetailed_CoalOut]    Script Date: 11/6/2020 5:09:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Reports_MineDetailed_CoalOut] (@FromDate DATE,@ToDate DATE,@Mine INT)
AS
BEGIN
	SELECT CAST(KG.EntryDateTime AS DATE) 'EntryDate' , ckl.VehicleNumber , C.PartyName , ckl.WeightInTons - kg.WeightInTons 'TotalTons'  , 
	 ckl.TotalPrice	FROM Kanta_General KG JOIN Company_Kanta_Log CKL ON KG.id = CKL.Kanta_General_Id
		JOIN Companies C ON C.id = KG.CompanyId
		JOIN Mine M ON M.id = CKL.MineId
	WHERE KG.EntryDateTime >= @FromDate and kg.EntryDateTime < dateadd(day,1,@tOdATE) and ckl.MineId = @Mine
END
GO
/****** Object:  StoredProcedure [dbo].[Reports_MineDetailed_Expenses]    Script Date: 11/6/2020 5:09:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Reports_MineDetailed_Expenses] (@FromDate DATE,@ToDate DATE,@MineId INT)
AS
BEGIN
	SELECT A.AccountTitle , T.TransactionDate , T.Particulars , T.Amount , M.MineDescription  , T.SerialNo
	FROM Accounts A JOIN Transactions T ON A.accountid = T.AccountId
		JOIN Mine M ON M.id = t.MineId
	WHERE T.TransactionDate >= @FromDate AND T.TransactionDate < DATEADD(DAY,1,@ToDate) 
		and t.MineId = @MineId AND T.Amount > 0
END
GO
/****** Object:  StoredProcedure [dbo].[Reports_MineDetailed_StockOut]    Script Date: 11/6/2020 5:09:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Reports_MineDetailed_StockOut] (@FromDate DATE,@ToDate DATE,@Mine INT)
AS
BEGIN
	SELECT sa.AssignedDateTime,m.MineDescription , I.ItemName , sa.Quantity , sa.TotalPrice FROM Items I JOIN 
			StockAssignments SA ON I.id = SA.ItemId
		JOIN Mine M ON M.ID = SA.MineId
	WHERE SA.AssignedDateTime >= @FromDate and sa.AssignedDateTime < DATEADD(DAY,1,@Todate) AND SA.MineId = @Mine
END
GO
/****** Object:  StoredProcedure [dbo].[Reports_Mines]    Script Date: 11/6/2020 5:09:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Reports_Mines] (@StatusId INT,@MineOwnedBy INT)
AS
BEGIN
	set @StatusId = case when @statusid = 0 then null else @statusid end
	SET @MineOwnedBy = CASE WHEN @MineOwnedBy = 0 then null else @MineOwnedBy end

	SELECT AreaName , MineDescription , AgreementType 'AgreementType' , M.AgreementValue , 
		CASE WHEN M.MineStatusId = 0 THEN 'Not Applicable' ELSE (SELECT MineStatus FROM MineStatuses WHERE Minestatuses.Id = M.MineStatusId) END 'MineStatus',
		CASE WHEN M.CurrentCompanyId = 0 THEN 'Not Assigned To Company' ELSE (SELECT PartyName FROM Companies WHERE Companies.Id = M.CurrentCompanyId) END 'CompanyName',
		(SELECT SUM(TotalUnits) FROM Company_Mine_DiggingDetails WHERE Mine = M.Id) 'TotalDigged' ,
		CASE WHEN MinesOwnedBy = 0 THEN 'Not Marked' WHEN MinesOwnedBy = 1 THEN 'Company' WHEN MinesOwnedBy = 2 THEN 'Qomi' END 'MineOwnedBy'
			FROM Areas A JOIN Mine M ON A.Id = M.AreaId
	WHERE M.MineStatusId = isnull(@StatusId,M.MineStatusId)  AND M.MinesOwnedBy = ISNULL(@mineownedby,m.minesownedby)
END
GO
/****** Object:  StoredProcedure [dbo].[Reports_PurchasedReport]    Script Date: 11/6/2020 5:09:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Reports_PurchasedReport] (@FromDate DATE,@ToDate DATE,@SupplierID INT)
AS
BEGIN
	set @SupplierID = case when @SupplierID = 0 then null else @SupplierID end

	SELECT P.PurchaseDate , p.BillNumber , a.AccountTitle , i.ItemName , u.UnitName , pd.Quantity , pd.Amount
			,p.InvoiceNumber , p.Discount	FROM Purchases p join PurchaseDetails pd on p.Id = pd.PurchaseId
	join Items i on i.id = pd.ItemId join Units u on u.Id = pd.UnitId
	join accounts a on a.accountid = p.SupplierId
	WHERE P.PurchaseDate >= @FromDate and p.PurchaseDate < dateadd(day,1,@Todate) and 
		p.SupplierId = isnull(@Supplierid,p.supplierid)
END
GO
/****** Object:  StoredProcedure [dbo].[Reports_Summary]    Script Date: 11/6/2020 5:09:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Reports_Summary] (@FromDate DATE,@ToDate DATE)
AS
BEGIN

	SET @FromDate = CONVERT(VARCHAR(20),@FromDate,101)
	SET @ToDate = CONVERT(VARCHAR(20),@ToDate,101)

	SELECT CT.CustomerType , C.PartyName ,  DATENAME(MONTH,KG.EntryDateTime) 'Month', DATEPART(YEAR,KG.EntryDateTime) 'Year' , SUM(CKL.WeightInTons-KG.WeightInTons) 'TotalTons' 
			, SUM(CKL.WeightInKilograms - KG.WeightInKiloGrams) 'WeightInKg' , SUM(CKL.Totalprice) 'TotalPrice'
	FROM Kanta_General KG JOIN Company_Kanta_Log CKL ON KG.Id = CKL.Kanta_General_Id
		JOIN Companies C ON C.Id = kg.CompanyId JOIN CustomerTypes CT ON CT.id = c.CustomerTypeId
	WHERE KG.EntryDateTime >= @FromDate AND KG.EntryDateTime < DATEADD(DAY,1,@ToDate)
	GROUP BY DATENAME(MONTH,KG.EntryDateTime) , DATEPART(YEAR,KG.EntryDateTime) , DATEPART(MONTH,KG.EntryDateTime) , 
	C.PartyName , ct.CustomerType
	ORDER BY [Year] , DATEPART(MONTH,KG.EntryDateTime)
END
GO
/****** Object:  StoredProcedure [dbo].[Reports_Summary_ClientWise]    Script Date: 11/6/2020 5:09:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Reports_Summary_ClientWise] (@FromDate DATE,@ToDate DATE,@ClientId int)
AS
BEGIN

	SET @FromDate = CONVERT(VARCHAR(20),@FromDate,101)
	SET @ToDate = CONVERT(VARCHAR(20),@ToDate,101)
	SET @ClientId = CASE WHEN @ClientId = 0 THEN NULL ELSE @ClientId END

	SELECT CT.CustomerType , C.PartyName ,  DATENAME(MONTH,KG.EntryDateTime) 'Month', DATEPART(YEAR,KG.EntryDateTime) 'Year' , SUM(CKL.WeightInTons-KG.WeightInTons) 'TotalTons' 
			, SUM(CKL.WeightInKilograms - KG.WeightInKiloGrams) 'WeightInKg' , SUM(CKL.Totalprice) 'TotalPrice'
	FROM Kanta_General KG JOIN Company_Kanta_Log CKL ON KG.Id = CKL.Kanta_General_Id
		JOIN Companies C ON C.Id = kg.CompanyId JOIN CustomerTypes CT ON CT.id = c.CustomerTypeId
	WHERE KG.EntryDateTime >= @FromDate AND KG.EntryDateTime < DATEADD(DAY,1,@ToDate) AND kg.CompanyId = ISNULL(@ClientId,kg.CompanyId)
	GROUP BY DATENAME(MONTH,KG.EntryDateTime) , DATEPART(YEAR,KG.EntryDateTime) , DATEPART(MONTH,KG.EntryDateTime) , 
	C.PartyName , ct.CustomerType
	ORDER BY [Year] , DATEPART(MONTH,KG.EntryDateTime)
END
GO
/****** Object:  StoredProcedure [dbo].[Reports_Summary_CompanyCustomer]    Script Date: 11/6/2020 5:09:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Reports_Summary_CompanyCustomer] (@FromDate DATE,@ToDate DATE,@Type INT)
AS
BEGIN

	SET @FromDate = CONVERT(VARCHAR(20),@FromDate,101)
	SET @ToDate = CONVERT(VARCHAR(20),@ToDate,101)
	SET @Type = CASE WHEN @Type = 0 THEN NULL ELSE @Type END

	SELECT CT.CustomerType , C.PartyName ,  DATENAME(MONTH,KG.EntryDateTime) 'Month', DATEPART(YEAR,KG.EntryDateTime) 'Year' , SUM(CKL.WeightInTons-KG.WeightInTons) 'TotalTons' 
			, SUM(CKL.WeightInKilograms - KG.WeightInKiloGrams) 'WeightInKg' , SUM(CKL.TotalPrice) 'TotalPrice'
	FROM Kanta_General KG JOIN Company_Kanta_Log CKL ON KG.Id = CKL.Kanta_General_Id
		JOIN Companies C ON C.Id = kg.CompanyId JOIN CustomerTypes CT ON CT.id = c.CustomerTypeId
	WHERE KG.EntryDateTime >= @FromDate AND KG.EntryDateTime < DATEADD(DAY,1,@ToDate) AND C.CustomerTypeId = isnull(@tYPE,c.customertypeid)
	GROUP BY DATENAME(MONTH,KG.EntryDateTime) , DATEPART(YEAR,KG.EntryDateTime) , DATEPART(MONTH,KG.EntryDateTime) , 
	C.PartyName , ct.CustomerType
	ORDER BY [Year] , DATEPART(MONTH,KG.EntryDateTime)
END
GO
/****** Object:  StoredProcedure [dbo].[Reports_Summary_VehicleWise]    Script Date: 11/6/2020 5:09:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Reports_Summary_VehicleWise] (@FromDate DATE,@ToDate DATE,@VehicleNumber VARCHAR(20))
AS
BEGIN

	SET @FromDate = CONVERT(VARCHAR(20),@FromDate,101)
	SET @ToDate = CONVERT(VARCHAR(20),@ToDate,101)

	SELECT CT.CustomerType , C.PartyName ,  DATENAME(MONTH,KG.EntryDateTime) 'Month', DATEPART(YEAR,KG.EntryDateTime) 'Year' , SUM(CKL.WeightInTons-KG.WeightInTons) 'TotalTons' 
			, SUM(CKL.WeightInKilograms - KG.WeightInKiloGrams) 'WeightInKg' , SUM(CKL.Totalprice) 'TotalPrice'
	FROM Kanta_General KG JOIN Company_Kanta_Log CKL ON KG.Id = CKL.Kanta_General_Id
		JOIN Companies C ON C.Id = kg.CompanyId JOIN CustomerTypes CT ON CT.id = c.CustomerTypeId
	WHERE KG.EntryDateTime >= @FromDate AND KG.EntryDateTime < DATEADD(DAY,1,@ToDate) AND kg.VehicleNumber = @VehicleNumber
	GROUP BY DATENAME(MONTH,KG.EntryDateTime) , DATEPART(YEAR,KG.EntryDateTime) , DATEPART(MONTH,KG.EntryDateTime) , 
	C.PartyName , ct.CustomerType
	ORDER BY [Year] , DATEPART(MONTH,KG.EntryDateTime)
END
GO
/****** Object:  StoredProcedure [dbo].[Reports_TotalEntries]    Script Date: 11/6/2020 5:09:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Reports_TotalEntries] (@FromDate DATE,@ToDate DATE,@SerialNo INT,@IsManual BIT)
AS
BEGIN
	IF @SerialNo > 0
	BEGIN
		SELECT T.SerialNo,T.TransactionDate,A.AccountTitle , T.InvoiceNumber , T.BillNumber , t.ChequeNumber , t.Particulars , t.Amount , IsManualEntry
				FROM Accounts A JOIN Transactions T ON A.AccountId = T.AccountId
		WHERE T.SerialNo = @SerialNo AND t.IsManualEntry = @IsManual
	END
	ELSE
	BEGIN
		SELECT T.SerialNo,T.TransactionDate,A.AccountTitle , T.InvoiceNumber , T.BillNumber , t.ChequeNumber , t.Particulars , t.Amount , IsManualEntry
				FROM Accounts A JOIN Transactions T ON A.AccountId = T.AccountId
		WHERE T.TransactionDate >= @FromDate AND T.TransactionDate < DATEADD(DAY,1,@ToDate)	AND T.IsManualEntry = @IsManual
	END
END
GO
/****** Object:  StoredProcedure [dbo].[Reports_TrialBalance]    Script Date: 11/6/2020 5:09:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Reports_TrialBalance] (@FromDate DATE,@ToDate DATE,@GroupID INT,@primaryheadid int)
AS
BEGIN
	SET @GroupID = CASE WHEN @GroupID = 0 THEN NULL ELSE @GroupID END
	SET @primaryheadid = CASE WHEN @primaryheadid = 0 THEN NULL ELSE @primaryheadid END

	SELECT H.HeadName,C.CategoryName , A.AccountCode , A.AccountTitle , SUM(T.Amount) 'Balance' FROM Heads H JOIN
		Categories C ON H.Id = C.HeadId JOIN 
	Accounts A ON C.CategoryId = A.CategoryId JOIN Transactions T ON A.AccountId = T.AccountId
	WHERE T.TransactionDate >= @FromDate AND T.TransactionDate < DATEADD(DAY,1,@tOdATE) AND
	C.CategoryId = ISNULL(@GroupID,C.CategoryId) AND H.Id = ISNULL(@primaryheadid,h.id) AND T.IsApproved = 1
	GROUP BY C.CategoryName , A.AccountCode , A.AccountTitle , h.HeadName
END
GO
/****** Object:  StoredProcedure [dbo].[Reports_UserAudit]    Script Date: 11/6/2020 5:09:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Reports_UserAudit] (@UserID INT,@FromDate DATE,@ToDate DATE,@TransactionType INT)
AS

SET @TransactionType = CASE WHEN @TransactionType = 0 THEN NULL ELSE @TransactionType END

SELECT U1.UserName 'OriginalUserId' , U.UserName 'Edited_Deleted_By' , t.TransactionDate 'ActivityDate',
	A.AccountTitle , T.SerialNo, t.Amount , t.Particulars , tt.TransactionType	FROM Users U JOIN TransactionsHistories T ON U.ID = T.EditedByUserId
join Accounts A ON A.AccountId = T.AccountId
join Users U1 ON U1.Id = T.UserId
join TransactionTypes TT ON TT.Id = T.TransactionTypeId
WHERE T.TransactionDate >= @FromDate AND T.TransactionDate < DATEADD(DAY,1,@ToDate) AND T.EditedByUserID = @UserID
	AND T.TransactionTypeId = ISNULL(@TransactionType,T.TransactionTypeId)
GO
/****** Object:  StoredProcedure [dbo].[Transactions_Invoice_Repint]    Script Date: 11/6/2020 5:09:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Transactions_Invoice_Repint] @InvoiceNumber BIGINT 
AS
BEGIN
	SELECT a.AccountTitle , T.TransactionDate , T.BillNumber , T.Amount , T.Particulars , TotalTons  
			 , ChequeNumber , SerialNo , t.PaymentType , 
			IsNull((SELECT MineDescription FROM Mine WHERE Id = T.MineId),'') 'MineDescription',
			u.UserName
		FROM Accounts A JOIN Transactions T ON A.Accountid = T.AccountId 
		JOIN Users U ON U.Id = t.UserId
		WHERE T.InvoiceNumber= @InvoiceNumber
END
GO
