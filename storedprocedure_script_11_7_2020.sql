USE [MushtarikaAkhurwalCoalV5]
GO
/****** Object:  StoredProcedure [dbo].[CalculateTotalCoalTaken]    Script Date: 11/7/2020 1:21:56 PM ******/
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
/****** Object:  StoredProcedure [dbo].[Company_Client_Bill]    Script Date: 11/7/2020 1:21:56 PM ******/
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
/****** Object:  StoredProcedure [dbo].[CurrentStock]    Script Date: 11/7/2020 1:21:56 PM ******/
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
/****** Object:  StoredProcedure [dbo].[Employees_Get]    Script Date: 11/7/2020 1:21:56 PM ******/
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
/****** Object:  StoredProcedure [dbo].[Get_StockAssignments]    Script Date: 11/7/2020 1:21:56 PM ******/
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
/****** Object:  StoredProcedure [dbo].[Get_StockAssignments_ByInvoice]    Script Date: 11/7/2020 1:21:56 PM ******/
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
/****** Object:  StoredProcedure [dbo].[Income_Expense_Tag_Report]    Script Date: 11/7/2020 1:21:56 PM ******/
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
/****** Object:  StoredProcedure [dbo].[Income_Expense_Tag_Report_ForDisplay]    Script Date: 11/7/2020 1:21:56 PM ******/
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
/****** Object:  StoredProcedure [dbo].[Invoice_Repint]    Script Date: 11/7/2020 1:21:56 PM ******/
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
/****** Object:  StoredProcedure [dbo].[Kanta_GetAdditionalCharges]    Script Date: 11/7/2020 1:21:56 PM ******/
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
/****** Object:  StoredProcedure [dbo].[Packages_Get]    Script Date: 11/7/2020 1:21:56 PM ******/
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
/****** Object:  StoredProcedure [dbo].[RateList_ForDisplay]    Script Date: 11/7/2020 1:21:56 PM ******/
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
/****** Object:  StoredProcedure [dbo].[Report_Attendence]    Script Date: 11/7/2020 1:21:56 PM ******/
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
/****** Object:  StoredProcedure [dbo].[Report_AttendenceDetail]    Script Date: 11/7/2020 1:21:56 PM ******/
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
/****** Object:  StoredProcedure [dbo].[Report_Expenses_Detail]    Script Date: 11/7/2020 1:21:56 PM ******/
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
/****** Object:  StoredProcedure [dbo].[Report_ForDisplayLCD]    Script Date: 11/7/2020 1:21:56 PM ******/
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
/****** Object:  StoredProcedure [dbo].[Report_MineWise_ForLcd]    Script Date: 11/7/2020 1:21:56 PM ******/
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
/****** Object:  StoredProcedure [dbo].[Reports_AssignedMines]    Script Date: 11/7/2020 1:21:56 PM ******/
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
/****** Object:  StoredProcedure [dbo].[Reports_AuditEntriesWise]    Script Date: 11/7/2020 1:21:56 PM ******/
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
/****** Object:  StoredProcedure [dbo].[Reports_BankReceiving]    Script Date: 11/7/2020 1:21:56 PM ******/
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
/****** Object:  StoredProcedure [dbo].[Reports_CategoryWiseAccounts]    Script Date: 11/7/2020 1:21:56 PM ******/
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
/****** Object:  StoredProcedure [dbo].[Reports_ChequePendingReport]    Script Date: 11/7/2020 1:21:56 PM ******/
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
/****** Object:  StoredProcedure [dbo].[Reports_Client_OverAllPosition]    Script Date: 11/7/2020 1:21:56 PM ******/
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
/****** Object:  StoredProcedure [dbo].[Reports_Companies]    Script Date: 11/7/2020 1:21:56 PM ******/
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
/****** Object:  StoredProcedure [dbo].[Reports_CompanyWiseTotalVehiclesOut]    Script Date: 11/7/2020 1:21:56 PM ******/
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
/****** Object:  StoredProcedure [dbo].[Reports_DailyFirstWeightSheetByInvoice]    Script Date: 11/7/2020 1:21:56 PM ******/
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
/****** Object:  StoredProcedure [dbo].[Reports_DailyLedger]    Script Date: 11/7/2020 1:21:56 PM ******/
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
/****** Object:  StoredProcedure [dbo].[Reports_DailyWeightSheet]    Script Date: 11/7/2020 1:21:56 PM ******/
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
/****** Object:  StoredProcedure [dbo].[Reports_DailyWeightSheetByCompanyCustomer]    Script Date: 11/7/2020 1:21:56 PM ******/
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
/****** Object:  StoredProcedure [dbo].[Reports_DailyWeightSheetByInvoice]    Script Date: 11/7/2020 1:21:56 PM ******/
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
/****** Object:  StoredProcedure [dbo].[Reports_DailyWeightSheetByParty]    Script Date: 11/7/2020 1:21:56 PM ******/
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
/****** Object:  StoredProcedure [dbo].[Reports_DailyWeightSheetByVehicleNumber]    Script Date: 11/7/2020 1:21:56 PM ******/
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
/****** Object:  StoredProcedure [dbo].[Reports_Expenses]    Script Date: 11/7/2020 1:21:56 PM ******/
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
/****** Object:  StoredProcedure [dbo].[Reports_Income_Companies]    Script Date: 11/7/2020 1:21:56 PM ******/
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
/****** Object:  StoredProcedure [dbo].[Reports_Income_Customers]    Script Date: 11/7/2020 1:21:56 PM ******/
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
/****** Object:  StoredProcedure [dbo].[Reports_Kanta_Data]    Script Date: 11/7/2020 1:21:56 PM ******/
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
/****** Object:  StoredProcedure [dbo].[Reports_MainFormData]    Script Date: 11/7/2020 1:21:56 PM ******/
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
/****** Object:  StoredProcedure [dbo].[Reports_MineDetailed_CoalOut]    Script Date: 11/7/2020 1:21:56 PM ******/
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
/****** Object:  StoredProcedure [dbo].[Reports_MineDetailed_Expenses]    Script Date: 11/7/2020 1:21:56 PM ******/
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
/****** Object:  StoredProcedure [dbo].[Reports_MineDetailed_StockOut]    Script Date: 11/7/2020 1:21:56 PM ******/
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
/****** Object:  StoredProcedure [dbo].[Reports_Mines]    Script Date: 11/7/2020 1:21:56 PM ******/
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
/****** Object:  StoredProcedure [dbo].[Reports_PurchasedReport]    Script Date: 11/7/2020 1:21:56 PM ******/
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
/****** Object:  StoredProcedure [dbo].[Reports_Summary]    Script Date: 11/7/2020 1:21:56 PM ******/
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
/****** Object:  StoredProcedure [dbo].[Reports_Summary_ClientWise]    Script Date: 11/7/2020 1:21:56 PM ******/
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
/****** Object:  StoredProcedure [dbo].[Reports_Summary_CompanyCustomer]    Script Date: 11/7/2020 1:21:56 PM ******/
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
/****** Object:  StoredProcedure [dbo].[Reports_Summary_VehicleWise]    Script Date: 11/7/2020 1:21:56 PM ******/
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
/****** Object:  StoredProcedure [dbo].[Reports_TotalEntries]    Script Date: 11/7/2020 1:21:56 PM ******/
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
/****** Object:  StoredProcedure [dbo].[Reports_TrialBalance]    Script Date: 11/7/2020 1:21:56 PM ******/
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
/****** Object:  StoredProcedure [dbo].[Reports_UserAudit]    Script Date: 11/7/2020 1:21:56 PM ******/
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
/****** Object:  StoredProcedure [dbo].[Transactions_Invoice_Repint]    Script Date: 11/7/2020 1:21:56 PM ******/
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
