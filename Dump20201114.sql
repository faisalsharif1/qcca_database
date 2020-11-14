-- MySQL dump 10.13  Distrib 8.0.21, for Win64 (x86_64)
--
-- Host: localhost    Database: mushtarikaakhurwalcoalv5
-- ------------------------------------------------------
-- Server version	8.0.18

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `accountcodes`
--

DROP TABLE IF EXISTS `accountcodes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `accountcodes` (
  `Id` int(11) NOT NULL,
  `CategoryId` int(11) NOT NULL,
  `IsSync` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `accounts`
--

DROP TABLE IF EXISTS `accounts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `accounts` (
  `AccountId` int(11) NOT NULL,
  `AccountTitle` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `CategoryId` int(11) NOT NULL,
  `AccountCode` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `ContactNo` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `CNICNumber` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `IsSync` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`AccountId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `areas`
--

DROP TABLE IF EXISTS `areas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `areas` (
  `Id` int(11) NOT NULL,
  `AreaName` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `IsSync` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `bankaccounts`
--

DROP TABLE IF EXISTS `bankaccounts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bankaccounts` (
  `Id` int(11) NOT NULL,
  `BankId` int(11) NOT NULL,
  `AccountTitle` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `AccountNumber` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `AccountId` int(11) NOT NULL,
  `IsSync` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `banks`
--

DROP TABLE IF EXISTS `banks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `banks` (
  `Id` int(11) NOT NULL,
  `BankName` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `BankContact` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `IsSync` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categories` (
  `CategoryId` int(11) NOT NULL,
  `CategoryName` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `HeadId` int(11) NOT NULL DEFAULT '0',
  `IsSync` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`CategoryId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cheque_history`
--

DROP TABLE IF EXISTS `cheque_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cheque_history` (
  `Id` int(11) NOT NULL,
  `ChequeId` int(11) NOT NULL,
  `ChequeStatusId` int(11) NOT NULL,
  `ActivityDateTime` datetime(6) NOT NULL,
  `ActivityByUserId` int(11) NOT NULL,
  `IsSync` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cheque_log`
--

DROP TABLE IF EXISTS `cheque_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cheque_log` (
  `Id` int(11) NOT NULL,
  `PartyId` int(11) NOT NULL,
  `BankId` int(11) NOT NULL,
  `BankAccountId` int(11) NOT NULL,
  `ChequeReceivingDate` datetime(6) NOT NULL,
  `ChequeClearingDate` datetime(6) NOT NULL,
  `ChequeAmount` decimal(18,3) NOT NULL,
  `UserId` int(11) NOT NULL,
  `IsCleared` tinyint(1) NOT NULL,
  `ChequeNumber` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `ClearedBy` int(11) NOT NULL,
  `ImageId` int(11) NOT NULL,
  `BankInvoiceId` int(11) NOT NULL,
  `ChequeIsFromBankId` int(11) NOT NULL DEFAULT '0',
  `ChequeStatusId` int(11) NOT NULL DEFAULT '0',
  `InvoiceNumber` bigint(20) NOT NULL DEFAULT '0',
  `StatementDateTime` datetime(6) DEFAULT NULL,
  `BillNumber` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `Particulars` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `IsSync` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `chequestatuses`
--

DROP TABLE IF EXISTS `chequestatuses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `chequestatuses` (
  `Id` int(11) NOT NULL,
  `Status` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `IsSync` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `companies`
--

DROP TABLE IF EXISTS `companies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `companies` (
  `Id` int(11) NOT NULL,
  `CustomerTypeId` int(11) NOT NULL,
  `PartyName` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `ContactNumber` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `PerTonRate` decimal(18,3) NOT NULL,
  `AccountId` int(11) NOT NULL,
  `Limit` decimal(18,3) NOT NULL,
  `IsBalanceCheckOn` tinyint(1) NOT NULL,
  `CNICNumber` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `IsSync` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `company_kanta_log`
--

DROP TABLE IF EXISTS `company_kanta_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `company_kanta_log` (
  `Id` int(11) NOT NULL,
  `SerialId` int(11) NOT NULL,
  `ItemType` int(11) NOT NULL,
  `VehicleNumber` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `SecondWeightDateTime` datetime(6) NOT NULL,
  `DriverName` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `DriverContactNumber` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `WeightInKilograms` decimal(18,3) NOT NULL,
  `WeightInTons` decimal(18,3) NOT NULL,
  `WeightInMounds40` decimal(18,3) NOT NULL,
  `WeightInMounds42` decimal(18,3) NOT NULL,
  `PricePerTon` decimal(18,3) NOT NULL,
  `TotalPrice` decimal(18,3) NOT NULL,
  `AdditionalPrice` decimal(18,3) NOT NULL,
  `FinalPrice` decimal(18,3) NOT NULL,
  `MineId` int(11) NOT NULL,
  `AccountId` int(11) NOT NULL,
  `UserId` int(11) NOT NULL,
  `Kanta_General_Id` int(11) NOT NULL,
  `InvoiceNumber` bigint(20) NOT NULL,
  `TruckIsFor` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `CompanyChargesId` int(11) NOT NULL,
  `IsSync` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`Id`),
  UNIQUE KEY `idx_company_kanta_log_Kanta_General_Id` (`Kanta_General_Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `company_mine`
--

DROP TABLE IF EXISTS `company_mine`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `company_mine` (
  `Id` int(11) NOT NULL,
  `ActivityDateTime` datetime(6) NOT NULL,
  `PartyId` int(11) NOT NULL,
  `MineId` int(11) NOT NULL,
  `MateId` int(11) NOT NULL,
  `MineStatusId` int(11) NOT NULL,
  `Rate` decimal(18,3) NOT NULL,
  `Unit` int(11) NOT NULL,
  `AgreementType` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `IsSync` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `company_mine_diggingdetails`
--

DROP TABLE IF EXISTS `company_mine_diggingdetails`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `company_mine_diggingdetails` (
  `Id` int(11) NOT NULL,
  `EntryDatTime` datetime(6) NOT NULL,
  `PartyId` int(11) NOT NULL,
  `Mine` int(11) NOT NULL,
  `Unit` int(11) NOT NULL,
  `TotalUnits` decimal(18,3) NOT NULL,
  `UnitPrice` decimal(18,3) NOT NULL,
  `TotalPrice` decimal(18,3) NOT NULL,
  `InvoiceNumber` bigint(20) NOT NULL,
  `IsSync` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `company_pertoncharges`
--

DROP TABLE IF EXISTS `company_pertoncharges`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `company_pertoncharges` (
  `Id` int(11) NOT NULL,
  `AgreementDate` datetime(6) NOT NULL,
  `CompanyId` int(11) NOT NULL,
  `MineId` int(11) NOT NULL,
  `PerTonRate` decimal(18,3) NOT NULL,
  `TotalTons` decimal(18,3) NOT NULL,
  `TotalAmount` decimal(18,3) NOT NULL,
  `IsActive` tinyint(1) NOT NULL,
  `IsSync` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `configurations`
--

DROP TABLE IF EXISTS `configurations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `configurations` (
  `Id` int(11) NOT NULL,
  `AccountToDebitInPurchase` int(11) NOT NULL,
  `IsSync` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `customertypes`
--

DROP TABLE IF EXISTS `customertypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customertypes` (
  `Id` int(11) NOT NULL,
  `CustomerType` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `IsSync` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `employeeattendences`
--

DROP TABLE IF EXISTS `employeeattendences`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `employeeattendences` (
  `Id` int(11) NOT NULL,
  `EntryDateTime` datetime(6) DEFAULT NULL,
  `CheckInDateTime` datetime(6) DEFAULT NULL,
  `CheckOutDateTime` datetime(6) DEFAULT NULL,
  `EmployeeId` int(11) NOT NULL,
  `UserId` int(11) NOT NULL,
  `IsOnLeave` tinyint(1) NOT NULL DEFAULT '0',
  `IsPresent` tinyint(1) NOT NULL DEFAULT '0',
  `TotalDutyHours` int(11) NOT NULL DEFAULT '0',
  `IsSync` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `employees`
--

DROP TABLE IF EXISTS `employees`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `employees` (
  `Id` int(11) NOT NULL,
  `EmployeeType` int(11) NOT NULL,
  `EmployeeName` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `EmployeeCNIC` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `MineId` int(11) NOT NULL,
  `PartyId` int(11) NOT NULL,
  `EmployeeJoiningDate` datetime(6) DEFAULT NULL,
  `EmployeeLeavingDate` datetime(6) DEFAULT NULL,
  `EmployeeSalary` decimal(18,3) NOT NULL,
  `EmployeePicture` int(11) NOT NULL,
  `IsActive` tinyint(1) NOT NULL,
  `WorksUnderEmployeeId` int(11) NOT NULL,
  `FMD` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `FMD2` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `DailyWorkingHours` int(11) NOT NULL DEFAULT '0',
  `IsSync` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `employeetypes`
--

DROP TABLE IF EXISTS `employeetypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `employeetypes` (
  `Id` int(11) NOT NULL,
  `EmployeeTypeDescription` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `IsSync` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `forminprojects`
--

DROP TABLE IF EXISTS `forminprojects`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `forminprojects` (
  `Id` int(11) NOT NULL,
  `FormName` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `IdKey` int(11) NOT NULL DEFAULT '0',
  `IsSync` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `heads`
--

DROP TABLE IF EXISTS `heads`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `heads` (
  `Id` int(11) NOT NULL,
  `HeadName` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `IsSync` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `items`
--

DROP TABLE IF EXISTS `items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `items` (
  `Id` int(11) NOT NULL,
  `ItemName` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `AccountId` int(11) NOT NULL,
  `IsSync` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `itemtypes`
--

DROP TABLE IF EXISTS `itemtypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `itemtypes` (
  `Id` int(11) NOT NULL,
  `ItemType` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `IsSync` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `kanta_charge`
--

DROP TABLE IF EXISTS `kanta_charge`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `kanta_charge` (
  `Id` int(11) NOT NULL,
  `CustomerTypeId` int(11) NOT NULL,
  `VehicleTypeId` int(11) NOT NULL,
  `ChargesDescription` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `Charges` decimal(18,3) NOT NULL,
  `IsSync` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `kanta_general`
--

DROP TABLE IF EXISTS `kanta_general`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `kanta_general` (
  `Id` int(11) NOT NULL,
  `EntryDateTime` datetime(6) NOT NULL,
  `VehicleNumber` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `WeightInKilograms` decimal(18,3) NOT NULL,
  `WeightInTons` decimal(18,3) NOT NULL,
  `WeightInMounds40Kg` decimal(18,3) NOT NULL,
  `WeightInMounds42Kg` decimal(18,3) NOT NULL,
  `UserId` int(11) NOT NULL,
  `HasDetail` tinyint(1) NOT NULL,
  `InvoiceNumber` bigint(20) NOT NULL,
  `CustomerTypeId` int(11) NOT NULL,
  `VehicleType` int(11) NOT NULL,
  `TotalCharges` decimal(18,3) NOT NULL,
  `CompanyId` int(11) NOT NULL,
  `IsEmpty` tinyint(1) NOT NULL,
  `IsSync` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`Id`),
  KEY `idx_kanta_general_EntryDateTime` (`EntryDateTime`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `kanta_mine_additionalpackages`
--

DROP TABLE IF EXISTS `kanta_mine_additionalpackages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `kanta_mine_additionalpackages` (
  `Id` int(11) NOT NULL,
  `MineCondition` int(11) NOT NULL,
  `TypeCondition` int(11) NOT NULL,
  `AccountIdCondition` int(11) NOT NULL,
  `AccountIdCondition_CompanyId` int(11) NOT NULL,
  `IsFixed` tinyint(1) NOT NULL,
  `IsCredit` tinyint(1) NOT NULL,
  `PerTonValue` decimal(18,3) NOT NULL,
  `FixedValue` decimal(18,3) NOT NULL,
  `Particulars` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `Type` int(11) NOT NULL,
  `EntryInAccount` int(11) NOT NULL,
  `EntryInAccount_CompanyId` int(11) NOT NULL,
  `IsSync` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mine`
--

DROP TABLE IF EXISTS `mine`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mine` (
  `Id` int(11) NOT NULL,
  `MineDescription` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `AreaId` int(11) NOT NULL,
  `MineStatusId` int(11) NOT NULL,
  `CurrentCompanyId` int(11) NOT NULL,
  `AgreementValue` decimal(18,3) NOT NULL,
  `AgreementType` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `UnitId` int(11) NOT NULL,
  `MineDegree` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `MateId` int(11) NOT NULL,
  `MinesOwnedBy` int(11) NOT NULL DEFAULT '0',
  `IsSync` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mines_pertoncharges`
--

DROP TABLE IF EXISTS `mines_pertoncharges`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mines_pertoncharges` (
  `Id` int(11) NOT NULL,
  `MineId` int(11) NOT NULL,
  `PerTonRate` decimal(18,3) NOT NULL,
  `EntryDate` datetime(6) NOT NULL DEFAULT '1900-01-01 00:00:00.000000',
  `IsActive` tinyint(1) NOT NULL DEFAULT '0',
  `IsSync` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `minestatuses`
--

DROP TABLE IF EXISTS `minestatuses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `minestatuses` (
  `Id` int(11) NOT NULL,
  `MineStatus` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `IsSync` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mobilenoes`
--

DROP TABLE IF EXISTS `mobilenoes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mobilenoes` (
  `Id` int(11) NOT NULL,
  `MobileNo1` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `MobileNo2` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `MobileNoKanta1` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `MobileNoKanta2` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `IsSync` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `online_approvals`
--

DROP TABLE IF EXISTS `online_approvals`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `online_approvals` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `InvoiceNumber` varchar(45) DEFAULT NULL,
  `IsDownloaded` tinyint(4) DEFAULT NULL,
  `ApprovedBy` int(11) DEFAULT NULL,
  PRIMARY KEY (`Id`),
  UNIQUE KEY `Id_UNIQUE` (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `online_transactions`
--

DROP TABLE IF EXISTS `online_transactions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `online_transactions` (
  `InvoiceNumber` bigint(20) NOT NULL,
  `TransactionDate` datetime(6) NOT NULL,
  `BillNumber` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `ChequeNumber` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `Particulars` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `AccountId` int(11) NOT NULL,
  `Amount` decimal(18,3) NOT NULL,
  `UserId` int(11) NOT NULL,
  `ProjectId` int(11) NOT NULL,
  `MineId` int(11) NOT NULL,
  `IsApproved` tinyint(1) NOT NULL,
  `PaymentType` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `IncExpTag` int(11) NOT NULL DEFAULT '0',
  `ProjectIdType` int(11) NOT NULL DEFAULT '0',
  `IsProcessed` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `party_kanta_log_additionalchargesdetail`
--

DROP TABLE IF EXISTS `party_kanta_log_additionalchargesdetail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `party_kanta_log_additionalchargesdetail` (
  `Id` int(11) NOT NULL,
  `Kanta_General_Id` int(11) NOT NULL,
  `ChargesDescription` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `Charges` decimal(18,3) NOT NULL,
  `AccountId` int(11) NOT NULL,
  `InvoiceNumber` bigint(20) NOT NULL,
  `IsSync` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `projects`
--

DROP TABLE IF EXISTS `projects`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `projects` (
  `Id` int(11) NOT NULL,
  `ProjectName` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `IsSync` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `purchasedetails`
--

DROP TABLE IF EXISTS `purchasedetails`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `purchasedetails` (
  `Id` int(11) NOT NULL,
  `PurchaseId` int(11) NOT NULL,
  `ItemId` int(11) NOT NULL,
  `UnitId` int(11) NOT NULL,
  `Quantity` decimal(18,3) NOT NULL,
  `Amount` decimal(18,3) NOT NULL,
  `IsSync` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `purchases`
--

DROP TABLE IF EXISTS `purchases`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `purchases` (
  `Id` int(11) NOT NULL,
  `SupplierId` int(11) NOT NULL,
  `PurchaseDate` datetime(6) NOT NULL,
  `InvoiceNumber` bigint(20) NOT NULL,
  `BillNumber` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `Amount` decimal(18,3) NOT NULL,
  `UserId` int(11) NOT NULL,
  `Discount` decimal(18,3) NOT NULL DEFAULT '0.000',
  `IsSync` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `serials`
--

DROP TABLE IF EXISTS `serials`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `serials` (
  `Id` int(11) NOT NULL,
  `KantaId` int(11) NOT NULL,
  `SerialNumber` int(11) NOT NULL,
  `UserId` int(11) NOT NULL,
  `IsSync` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `serialtransactions`
--

DROP TABLE IF EXISTS `serialtransactions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `serialtransactions` (
  `Id` int(11) NOT NULL,
  `SerialNumber` int(11) NOT NULL,
  `UserId` int(11) NOT NULL,
  `IsSync` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `stockassignmentdetails`
--

DROP TABLE IF EXISTS `stockassignmentdetails`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `stockassignmentdetails` (
  `Id` int(11) NOT NULL,
  `InvoiceNumber` bigint(20) NOT NULL,
  `ItemId` int(11) NOT NULL,
  `UnitId` int(11) NOT NULL,
  `Quantity` decimal(18,3) NOT NULL,
  `StockId` int(11) NOT NULL,
  `Amount` decimal(18,3) NOT NULL DEFAULT '0.000',
  `IsSync` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `stockassignments`
--

DROP TABLE IF EXISTS `stockassignments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `stockassignments` (
  `Id` int(11) NOT NULL,
  `AssignedDateTime` datetime(6) NOT NULL,
  `InvoiceNumber` bigint(20) NOT NULL,
  `ItemId` int(11) NOT NULL,
  `UnitId` int(11) NOT NULL,
  `Quantity` decimal(18,3) NOT NULL,
  `MineId` int(11) NOT NULL,
  `CompanyId` int(11) NOT NULL,
  `UserId` int(11) NOT NULL,
  `TotalPrice` decimal(18,3) NOT NULL DEFAULT '0.000',
  `DebitInAccountId` int(11) NOT NULL DEFAULT '0',
  `Deliverer` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `Receiver` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `Particulars` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `IsSync` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `stocks`
--

DROP TABLE IF EXISTS `stocks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `stocks` (
  `Id` int(11) NOT NULL,
  `InvoiceNumber` bigint(20) NOT NULL,
  `ItemId` int(11) NOT NULL,
  `UnitId` int(11) NOT NULL,
  `Quantity` decimal(18,3) NOT NULL,
  `UnitPrice` decimal(18,3) NOT NULL DEFAULT '0.000',
  `TotalPrice` decimal(18,3) NOT NULL DEFAULT '0.000',
  `Consumed` decimal(18,3) NOT NULL DEFAULT '0.000',
  `PurchaseDetailId` int(11) NOT NULL DEFAULT '0',
  `IsSync` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sysdiagrams`
--

DROP TABLE IF EXISTS `sysdiagrams`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sysdiagrams` (
  `name` varchar(160) NOT NULL,
  `principal_id` int(11) NOT NULL,
  `diagram_id` int(11) NOT NULL,
  `version` int(11) DEFAULT NULL,
  `definition` longblob,
  PRIMARY KEY (`diagram_id`),
  UNIQUE KEY `UK_principal_name` (`principal_id`,`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `transactions`
--

DROP TABLE IF EXISTS `transactions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `transactions` (
  `Id` int(11) NOT NULL,
  `SerialNo` int(11) NOT NULL,
  `InvoiceNumber` bigint(20) NOT NULL,
  `TransactionDate` datetime(6) NOT NULL,
  `BillNumber` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `ChequeNumber` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `Particulars` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `AccountId` int(11) NOT NULL,
  `Amount` decimal(18,3) NOT NULL,
  `UserId` int(11) NOT NULL,
  `ProjectId` int(11) NOT NULL,
  `MineId` int(11) NOT NULL,
  `ImageId` int(11) NOT NULL,
  `IsApproved` tinyint(1) NOT NULL,
  `IsManualEntry` tinyint(1) NOT NULL,
  `TotalTons` decimal(18,3) NOT NULL,
  `PerTonValue` decimal(18,3) NOT NULL,
  `PaymentType` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `PurchaseDetailId` int(11) NOT NULL DEFAULT '0',
  `IncExpTag` int(11) NOT NULL DEFAULT '0',
  `ProjectIdType` int(11) NOT NULL DEFAULT '0',
  `IsProcessed` tinyint(1) NOT NULL DEFAULT '0',
  `IsSync` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `transactionshistories`
--

DROP TABLE IF EXISTS `transactionshistories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `transactionshistories` (
  `Id` int(11) NOT NULL,
  `SerialNo` int(11) NOT NULL,
  `InvoiceNumber` bigint(20) NOT NULL,
  `TransactionDate` datetime(6) NOT NULL,
  `BillNumber` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `ChequeNumber` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `Particulars` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `AccountId` int(11) NOT NULL,
  `Amount` decimal(18,3) NOT NULL,
  `UserId` int(11) NOT NULL,
  `ProjectId` int(11) NOT NULL,
  `MineId` int(11) NOT NULL,
  `ImageId` int(11) NOT NULL,
  `IsApproved` tinyint(1) NOT NULL,
  `IsManualEntry` tinyint(1) NOT NULL,
  `TotalTons` decimal(18,3) NOT NULL,
  `PerTonValue` decimal(18,3) NOT NULL,
  `PaymentType` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `PurchaseDetailId` int(11) NOT NULL,
  `EditedByUserId` int(11) NOT NULL,
  `TransactionTypeId` int(11) NOT NULL DEFAULT '0',
  `IncExpTag` int(11) NOT NULL DEFAULT '0',
  `ProjectIdType` int(11) NOT NULL DEFAULT '0',
  `IsProcessed` tinyint(1) NOT NULL DEFAULT '0',
  `IsSync` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `transactiontypes`
--

DROP TABLE IF EXISTS `transactiontypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `transactiontypes` (
  `Id` int(11) NOT NULL,
  `TransactionType` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `IsSync` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `units`
--

DROP TABLE IF EXISTS `units`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `units` (
  `Id` int(11) NOT NULL,
  `UnitName` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `UnitType` int(11) NOT NULL,
  `IsSync` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `unittypes`
--

DROP TABLE IF EXISTS `unittypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `unittypes` (
  `Id` int(11) NOT NULL,
  `UnitType` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `IsSync` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `uploadedimages`
--

DROP TABLE IF EXISTS `uploadedimages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `uploadedimages` (
  `Id` int(11) NOT NULL,
  `ImageBase64` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `IsSync` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `userpermissions`
--

DROP TABLE IF EXISTS `userpermissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `userpermissions` (
  `Id` int(11) NOT NULL,
  `FormName` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `IsAllowed` tinyint(1) NOT NULL,
  `UserId` int(11) NOT NULL,
  `IsSync` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `Id` int(11) NOT NULL,
  `UserName` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `Password` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `IsActive` tinyint(1) NOT NULL,
  `IsAdmin` tinyint(1) NOT NULL,
  `AccountId` int(11) NOT NULL,
  `IsSync` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `vehicletypes`
--

DROP TABLE IF EXISTS `vehicletypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `vehicletypes` (
  `Id` int(11) NOT NULL,
  `VehicleType` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `IsSync` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping routines for database 'mushtarikaakhurwalcoalv5'
--
/*!50003 DROP FUNCTION IF EXISTS `companyvehicleoutthismonth` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `companyvehicleoutthismonth`(_companyid int) RETURNS int(11)
    DETERMINISTIC
BEGIN
declare datefirst date;
declare datecurrent date;

set datefirst = concat(cast(year(curdate()) as char) , '-' , cast(month(curdate()) as char) , '-1');
set datecurrent = curdate();
 
return(
select count(kg.id)	from  kanta_general kg join company_kanta_log ckl on kg.id = ckl.Kanta_General_Id
where kg.companyid = _companyid and cast(kg.EntryDateTime as date) >= datefirst  and kg.entrydatetime < date_add(datecurrent,interval 1 day));
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `companyvehicleoutthismonthweight` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `companyvehicleoutthismonthweight`(_companyid int) RETURNS int(11)
    DETERMINISTIC
BEGIN
declare datefirst date;
declare datecurrent date;

set datefirst = concat(cast(year(curdate()) as char) , '-' , cast(month(curdate()) as char) , '-1');
set datecurrent = curdate();
 
return(
select IfNull(sum(ckl.weightintons-kg.weightintons),0)	from  kanta_general kg join company_kanta_log ckl on kg.id = ckl.Kanta_General_Id
where kg.companyid = _companyid and cast(kg.EntryDateTime as date) >= datefirst  and kg.entrydatetime < date_add(datecurrent,interval 1 day));
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `companyvehicleouttoday` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `companyvehicleouttoday`(_companyid int) RETURNS int(11)
    DETERMINISTIC
BEGIN
return(
select count(kg.id)	from  kanta_general kg join company_kanta_log ckl on kg.id = ckl.Kanta_General_Id
where  kg.companyid = _companyid and cast(kg.EntryDateTime as date) >= curdate() and kg.entrydatetime < date_add(curdate(),interval 1 day));
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `companyvehicleoutweight` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `companyvehicleoutweight`(_companyid int) RETURNS int(11)
    DETERMINISTIC
BEGIN
return(
select ifnull(sum(ckl.weightintons - kg.weightintons),0)	from  kanta_general kg join company_kanta_log ckl on kg.id = ckl.Kanta_General_Id
where kg.companyid = _companyid and cast(kg.EntryDateTime as date) >= curdate() and kg.entrydatetime < date_add(curdate(),interval 1 day));

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `getoldbalance` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `getoldbalance`(_accountid int,_datefrom date) RETURNS decimal(10,0)
    DETERMINISTIC
BEGIN

RETURN (select ifnull(sum(amount),0) from transactions where cast(transactiondate as date) < _datefrom and accountid = _accountid);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `new_function` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `new_function`(p_tablename varchar(1000)) RETURNS varchar(1000) CHARSET utf8mb4
    READS SQL DATA
    DETERMINISTIC
BEGIN

RETURN (select GROUP_CONCAT(column_name) from information_schema.columns tc where tc.table_schema = 'mushtarikaakhurwalcoalv5' and tc.TABLE_Name = p_tablename );
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `new_function_modified` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `new_function_modified`(p_tablename varchar(1000)) RETURNS longtext CHARSET utf8mb4
    READS SQL DATA
    DETERMINISTIC
BEGIN

RETURN (select GROUP_CONCAT(concat(column_name , ' ' ,tc.data_type , ' ' , 'PATH ','''$.',column_name,'''' )) from
	information_schema.columns tc where tc.table_schema = 'mushtarikaakhurwalcoalv5' and tc.TABLE_Name = p_tablename);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `new_function_modified_2` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `new_function_modified_2`(p_tablename varchar(1000)) RETURNS longtext CHARSET utf8mb4
    READS SQL DATA
    DETERMINISTIC
BEGIN

RETURN (select GROUP_CONCAT(concat(column_name ,' = ' , TABLE_NAME,'Client.',column_name )) from
	information_schema.columns tc where tc.table_schema = 'mushtarikaakhurwalcoalv5' and tc.TABLE_Name = p_tablename
    and tc.column_key != 'PRI');
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `accountcodes_Process` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `accountcodes_Process`(p_accountcodes JSON)
BEGIN INSERT INTO accountcodes ( Id,CategoryId,IsSync )SELECT * FROM JSON_TABLE(p_accountcodes, '$[*]' COLUMNS (Id int PATH '$.Id',CategoryId int PATH '$.CategoryId',IsSync tinyint PATH '$.IsSync')) AS accountcodesClient ON DUPLICATE KEY UPDATE CategoryId = accountcodesClient.CategoryId,IsSync = accountcodesClient.IsSync; END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `accounts_Process` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `accounts_Process`(p_accounts JSON)
BEGIN INSERT INTO accounts ( AccountId,AccountTitle,CategoryId,AccountCode,ContactNo,CNICNumber,IsSync )
	SELECT * FROM JSON_TABLE(p_accounts, '$[*]' COLUMNS 
		(AccountId int PATH '$.AccountId',AccountTitle longtext PATH '$.AccountTitle',
        CategoryId int PATH '$.CategoryId',
        AccountCode longtext PATH '$.AccountCode',
        ContactNo longtext PATH '$.ContactNo',
        CNICNumber longtext PATH '$.CNICNumber',IsSync tinyint PATH '$.IsSync')) AS accountsClient 
        ON DUPLICATE KEY UPDATE AccountTitle = accountsClient.AccountTitle,
        CategoryId = accountsClient.CategoryId,AccountCode = accountsClient.AccountCode,
        ContactNo = accountsClient.ContactNo,CNICNumber = accountsClient.CNICNumber,IsSync = accountsClient.IsSync; END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `approve_entry` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `approve_entry`(_InvoiceNumber bigint,_UserId int)
BEGIN
	INSERT INTO online_approvals (InvoiceNumber , IsDownloaded , ApprovedBy)
		VALUES (_InvoiceNumber , 0 , _UserId);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `areas_Process` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `areas_Process`(p_areas JSON)
BEGIN INSERT INTO areas ( Id,AreaName,IsSync )SELECT * FROM JSON_TABLE(p_areas, '$[*]' COLUMNS (Id int PATH '$.Id',AreaName longtext PATH '$.AreaName',IsSync tinyint PATH '$.IsSync')) AS areasClient ON DUPLICATE KEY UPDATE AreaName = areasClient.AreaName,IsSync = areasClient.IsSync; END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `bankaccounts_Process` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `bankaccounts_Process`(p_bankaccounts JSON)
BEGIN INSERT INTO bankaccounts ( Id,BankId,AccountTitle,AccountNumber,AccountId,IsSync )SELECT * FROM JSON_TABLE(p_bankaccounts, '$[*]' COLUMNS (Id int PATH '$.Id',BankId int PATH '$.BankId',AccountTitle longtext PATH '$.AccountTitle',AccountNumber longtext PATH '$.AccountNumber',AccountId int PATH '$.AccountId',IsSync tinyint PATH '$.IsSync')) AS bankaccountsClient ON DUPLICATE KEY UPDATE BankId = bankaccountsClient.BankId,AccountTitle = bankaccountsClient.AccountTitle,AccountNumber = bankaccountsClient.AccountNumber,AccountId = bankaccountsClient.AccountId,IsSync = bankaccountsClient.IsSync; END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `banks_Process` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `banks_Process`(p_banks JSON)
BEGIN INSERT INTO banks ( Id,BankName,BankContact,IsSync )SELECT * FROM JSON_TABLE(p_banks, '$[*]' COLUMNS (Id int PATH '$.Id',BankName longtext PATH '$.BankName',BankContact longtext PATH '$.BankContact',IsSync tinyint PATH '$.IsSync')) AS banksClient ON DUPLICATE KEY UPDATE BankName = banksClient.BankName,BankContact = banksClient.BankContact,IsSync = banksClient.IsSync; END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `categories_Process` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `categories_Process`(p_categories JSON)
BEGIN INSERT INTO categories ( CategoryId,CategoryName,HeadId,IsSync )SELECT * FROM JSON_TABLE(p_categories, '$[*]' COLUMNS (CategoryId int PATH '$.CategoryId',CategoryName longtext PATH '$.CategoryName',HeadId int PATH '$.HeadId',IsSync tinyint PATH '$.IsSync')) AS categoriesClient ON DUPLICATE KEY UPDATE CategoryName = categoriesClient.CategoryName,HeadId = categoriesClient.HeadId,IsSync = categoriesClient.IsSync; END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `chequestatuses_Process` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `chequestatuses_Process`(p_chequestatuses JSON)
BEGIN INSERT INTO chequestatuses ( Id,Status,IsSync )SELECT * FROM JSON_TABLE(p_chequestatuses, '$[*]' COLUMNS (Id int PATH '$.Id',Status longtext PATH '$.Status',IsSync tinyint PATH '$.IsSync')) AS chequestatusesClient ON DUPLICATE KEY UPDATE Status = chequestatusesClient.Status,IsSync = chequestatusesClient.IsSync; END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `cheque_history_Process` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `cheque_history_Process`(p_cheque_history JSON)
BEGIN INSERT INTO cheque_history ( Id,ChequeId,ChequeStatusId,ActivityDateTime,ActivityByUserId,IsSync )SELECT * FROM JSON_TABLE(p_cheque_history, '$[*]' COLUMNS (Id int PATH '$.Id',ChequeId int PATH '$.ChequeId',ChequeStatusId int PATH '$.ChequeStatusId',ActivityDateTime datetime PATH '$.ActivityDateTime',ActivityByUserId int PATH '$.ActivityByUserId',IsSync tinyint PATH '$.IsSync')) AS cheque_historyClient ON DUPLICATE KEY UPDATE ChequeId = cheque_historyClient.ChequeId,ChequeStatusId = cheque_historyClient.ChequeStatusId,ActivityDateTime = cheque_historyClient.ActivityDateTime,ActivityByUserId = cheque_historyClient.ActivityByUserId,IsSync = cheque_historyClient.IsSync; END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `cheque_log_Process` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `cheque_log_Process`(p_cheque_log JSON)
BEGIN 
INSERT INTO cheque_log ( Id,PartyId,BankId,BankAccountId,ChequeReceivingDate,ChequeClearingDate,ChequeAmount,UserId,IsCleared,
	ChequeNumber,ClearedBy,ImageId,BankInvoiceId,ChequeIsFromBankId,ChequeStatusId,InvoiceNumber,
    StatementDateTime,BillNumber,Particulars,IsSync )
		SELECT Id,PartyId,BankId,BankAccountId,ChequeReceivingDate,ChequeClearingDate,ChequeAmount,UserId,IsCleared,
			ChequeNumber,ClearedBy,ImageId,BankInvoiceId,ChequeIsFromBankId,ChequeStatusId,InvoiceNumber,
            case when StatementDateTime = 'null' or statementdatetime = '' then null else statementdatetime end ,BillNumber,Particulars,IsSync FROM JSON_TABLE(p_cheque_log, '$[*]' COLUMNS (Id int PATH '$.Id',
            PartyId int PATH '$.PartyId',BankId int PATH '$.BankId',BankAccountId int PATH '$.BankAccountId',
            ChequeReceivingDate datetime PATH '$.ChequeReceivingDate',ChequeClearingDate datetime PATH '$.ChequeClearingDate',
            ChequeAmount decimal PATH '$.ChequeAmount',UserId int PATH '$.UserId',IsCleared tinyint PATH '$.IsCleared',
            ChequeNumber longtext PATH '$.ChequeNumber',ClearedBy int PATH '$.ClearedBy',ImageId int PATH '$.ImageId',
            BankInvoiceId int PATH '$.BankInvoiceId',ChequeIsFromBankId int PATH '$.ChequeIsFromBankId',
            ChequeStatusId int PATH '$.ChequeStatusId',InvoiceNumber bigint PATH '$.InvoiceNumber',
            StatementDateTime longtext PATH '$.StatementDateTime',BillNumber longtext PATH '$.BillNumber',
            Particulars longtext PATH '$.Particulars',IsSync tinyint PATH '$.IsSync')) AS cheque_logClient
            ON DUPLICATE KEY UPDATE PartyId = cheque_logClient.PartyId,BankId = cheque_logClient.BankId,
            BankAccountId = cheque_logClient.BankAccountId,ChequeReceivingDate = cheque_logClient.ChequeReceivingDate,
            ChequeClearingDate = cheque_logClient.ChequeClearingDate,ChequeAmount = cheque_logClient.ChequeAmount,UserId = cheque_logClient.UserId,
            IsCleared = cheque_logClient.IsCleared,ChequeNumber = cheque_logClient.ChequeNumber,ClearedBy = cheque_logClient.ClearedBy,
            ImageId = cheque_logClient.ImageId,BankInvoiceId = cheque_logClient.BankInvoiceId,ChequeIsFromBankId = cheque_logClient.ChequeIsFromBankId,
            ChequeStatusId = cheque_logClient.ChequeStatusId,InvoiceNumber = cheque_logClient.InvoiceNumber,
            StatementDateTime = cheque_logClient.StatementDateTime,BillNumber = cheque_logClient.BillNumber,
            Particulars = cheque_logClient.Particulars,IsSync = cheque_logClient.IsSync;
 END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `companies_Process` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `companies_Process`(p_companies JSON)
BEGIN INSERT INTO companies ( Id,CustomerTypeId,PartyName,ContactNumber,PerTonRate,AccountId,`Limit`,IsBalanceCheckOn,CNICNumber,IsSync )SELECT * FROM JSON_TABLE(p_companies, '$[*]' COLUMNS (Id int PATH '$.Id',CustomerTypeId int PATH '$.CustomerTypeId',PartyName longtext PATH '$.PartyName',ContactNumber longtext PATH '$.ContactNumber',PerTonRate decimal PATH '$.PerTonRate',AccountId int PATH '$.AccountId',`Limit` decimal PATH '$.Limit',IsBalanceCheckOn tinyint PATH '$.IsBalanceCheckOn',CNICNumber longtext PATH '$.CNICNumber',IsSync tinyint PATH '$.IsSync')) AS companiesClient ON DUPLICATE KEY UPDATE CustomerTypeId = companiesClient.CustomerTypeId,PartyName = companiesClient.PartyName,ContactNumber = companiesClient.ContactNumber,PerTonRate = companiesClient.PerTonRate,AccountId = companiesClient.AccountId,`Limit` = companiesClient.Limit,IsBalanceCheckOn = companiesClient.IsBalanceCheckOn,CNICNumber = companiesClient.CNICNumber,IsSync = companiesClient.IsSync; END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `company_kanta_log_Process` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `company_kanta_log_Process`(p_company_kanta_log JSON)
BEGIN INSERT INTO company_kanta_log ( Id,SerialId,ItemType,VehicleNumber,SecondWeightDateTime,DriverName,DriverContactNumber
	,WeightInKilograms,WeightInTons,WeightInMounds40,WeightInMounds42,PricePerTon,TotalPrice,AdditionalPrice,
		FinalPrice,MineId,AccountId,UserId,Kanta_General_Id,InvoiceNumber,TruckIsFor,CompanyChargesId,IsSync )
        SELECT * FROM JSON_TABLE(p_company_kanta_log, '$[*]' COLUMNS (Id int PATH '$.Id',SerialId int PATH '$.SerialId',
        ItemType int PATH '$.ItemType',VehicleNumber longtext PATH '$.VehicleNumber',SecondWeightDateTime datetime PATH '$.SecondWeightDateTime',
        DriverName longtext PATH '$.DriverName',DriverContactNumber longtext PATH '$.DriverContactNumber',
        WeightInKilograms decimal PATH '$.WeightInKilograms',WeightInTons decimal PATH '$.WeightInTons',
        WeightInMounds40 decimal PATH '$.WeightInMounds40',WeightInMounds42 decimal PATH '$.WeightInMounds42',
        PricePerTon decimal PATH '$.PricePerTon',TotalPrice decimal PATH '$.TotalPrice',
        AdditionalPrice decimal PATH '$.AdditionalPrice',FinalPrice decimal PATH '$.FinalPrice',MineId int PATH '$.MineId',
        AccountId int PATH '$.AccountId',UserId int PATH '$.UserId',Kanta_General_Id int PATH '$.Kanta_General_Id',
        InvoiceNumber bigint PATH '$.InvoiceNumber',TruckIsFor longtext PATH '$.TruckIsFor',
        CompanyChargesId int PATH '$.CompanyChargesId',IsSync tinyint PATH '$.IsSync')) AS company_kanta_logClient
        ON DUPLICATE KEY UPDATE SerialId = company_kanta_logClient.SerialId,ItemType = company_kanta_logClient.ItemType,
        VehicleNumber = company_kanta_logClient.VehicleNumber,SecondWeightDateTime = company_kanta_logClient.SecondWeightDateTime,
        DriverName = company_kanta_logClient.DriverName,DriverContactNumber = company_kanta_logClient.DriverContactNumber,
        WeightInKilograms = company_kanta_logClient.WeightInKilograms,WeightInTons = company_kanta_logClient.WeightInTons,
        WeightInMounds40 = company_kanta_logClient.WeightInMounds40,WeightInMounds42 = company_kanta_logClient.WeightInMounds42,
        PricePerTon = company_kanta_logClient.PricePerTon,TotalPrice = company_kanta_logClient.TotalPrice,
        AdditionalPrice = company_kanta_logClient.AdditionalPrice,FinalPrice = company_kanta_logClient.FinalPrice,
        MineId = company_kanta_logClient.MineId,AccountId = company_kanta_logClient.AccountId,UserId = company_kanta_logClient.UserId,
        Kanta_General_Id = company_kanta_logClient.Kanta_General_Id,InvoiceNumber = company_kanta_logClient.InvoiceNumber,
        TruckIsFor = company_kanta_logClient.TruckIsFor,CompanyChargesId = company_kanta_logClient.CompanyChargesId,IsSync = company_kanta_logClient.IsSync; END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `company_mine_diggingdetails_Process` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `company_mine_diggingdetails_Process`(p_company_mine_diggingdetails JSON)
BEGIN INSERT INTO company_mine_diggingdetails ( Id,EntryDatTime,PartyId,Mine,Unit,TotalUnits,UnitPrice,TotalPrice,InvoiceNumber,IsSync )SELECT * FROM JSON_TABLE(p_company_mine_diggingdetails, '$[*]' COLUMNS (Id int PATH '$.Id',EntryDatTime datetime PATH '$.EntryDatTime',PartyId int PATH '$.PartyId',Mine int PATH '$.Mine',Unit int PATH '$.Unit',TotalUnits decimal PATH '$.TotalUnits',UnitPrice decimal PATH '$.UnitPrice',TotalPrice decimal PATH '$.TotalPrice',InvoiceNumber bigint PATH '$.InvoiceNumber',IsSync tinyint PATH '$.IsSync')) AS company_mine_diggingdetailsClient ON DUPLICATE KEY UPDATE EntryDatTime = company_mine_diggingdetailsClient.EntryDatTime,PartyId = company_mine_diggingdetailsClient.PartyId,Mine = company_mine_diggingdetailsClient.Mine,Unit = company_mine_diggingdetailsClient.Unit,TotalUnits = company_mine_diggingdetailsClient.TotalUnits,UnitPrice = company_mine_diggingdetailsClient.UnitPrice,TotalPrice = company_mine_diggingdetailsClient.TotalPrice,InvoiceNumber = company_mine_diggingdetailsClient.InvoiceNumber,IsSync = company_mine_diggingdetailsClient.IsSync; END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `company_mine_Process` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `company_mine_Process`(p_company_mine JSON)
BEGIN INSERT INTO company_mine ( Id,ActivityDateTime,PartyId,MineId,MateId,MineStatusId,Rate,Unit,AgreementType,IsSync )SELECT * FROM JSON_TABLE(p_company_mine, '$[*]' COLUMNS (Id int PATH '$.Id',ActivityDateTime datetime PATH '$.ActivityDateTime',PartyId int PATH '$.PartyId',MineId int PATH '$.MineId',MateId int PATH '$.MateId',MineStatusId int PATH '$.MineStatusId',Rate decimal PATH '$.Rate',Unit int PATH '$.Unit',AgreementType longtext PATH '$.AgreementType',IsSync tinyint PATH '$.IsSync')) AS company_mineClient ON DUPLICATE KEY UPDATE ActivityDateTime = company_mineClient.ActivityDateTime,PartyId = company_mineClient.PartyId,MineId = company_mineClient.MineId,MateId = company_mineClient.MateId,MineStatusId = company_mineClient.MineStatusId,Rate = company_mineClient.Rate,Unit = company_mineClient.Unit,AgreementType = company_mineClient.AgreementType,IsSync = company_mineClient.IsSync; END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `company_pertoncharges_Process` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `company_pertoncharges_Process`(p_company_pertoncharges JSON)
BEGIN INSERT INTO company_pertoncharges ( Id,AgreementDate,CompanyId,MineId,PerTonRate,TotalTons,TotalAmount,IsActive,IsSync )SELECT * FROM JSON_TABLE(p_company_pertoncharges, '$[*]' COLUMNS (Id int PATH '$.Id',AgreementDate datetime PATH '$.AgreementDate',CompanyId int PATH '$.CompanyId',MineId int PATH '$.MineId',PerTonRate decimal PATH '$.PerTonRate',TotalTons decimal PATH '$.TotalTons',TotalAmount decimal PATH '$.TotalAmount',IsActive tinyint PATH '$.IsActive',IsSync tinyint PATH '$.IsSync')) AS company_pertonchargesClient ON DUPLICATE KEY UPDATE AgreementDate = company_pertonchargesClient.AgreementDate,CompanyId = company_pertonchargesClient.CompanyId,MineId = company_pertonchargesClient.MineId,PerTonRate = company_pertonchargesClient.PerTonRate,TotalTons = company_pertonchargesClient.TotalTons,TotalAmount = company_pertonchargesClient.TotalAmount,IsActive = company_pertonchargesClient.IsActive,IsSync = company_pertonchargesClient.IsSync; END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `configurations_Process` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `configurations_Process`(p_configurations JSON)
BEGIN INSERT INTO configurations ( Id,AccountToDebitInPurchase,IsSync )SELECT * FROM JSON_TABLE(p_configurations, '$[*]' COLUMNS (Id int PATH '$.Id',AccountToDebitInPurchase int PATH '$.AccountToDebitInPurchase',IsSync tinyint PATH '$.IsSync')) AS configurationsClient ON DUPLICATE KEY UPDATE AccountToDebitInPurchase = configurationsClient.AccountToDebitInPurchase,IsSync = configurationsClient.IsSync; END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `customertypes_Process` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `customertypes_Process`(p_customertypes JSON)
BEGIN INSERT INTO customertypes ( Id,CustomerType,IsSync )SELECT * FROM JSON_TABLE(p_customertypes, '$[*]' COLUMNS (Id int PATH '$.Id',CustomerType longtext PATH '$.CustomerType',IsSync tinyint PATH '$.IsSync')) AS customertypesClient ON DUPLICATE KEY UPDATE CustomerType = customertypesClient.CustomerType,IsSync = customertypesClient.IsSync; END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `datadelete_process` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `datadelete_process`(_TableName VARCHAR(500),_PrimaryKeyValue INT,_InvoiceNumber VARCHAR(100))
BEGIN
IF _TableName = 'Transactions' THEN
    	DELETE FROM `Transactions` WHERE Id = _PrimaryKeyValue;
    ELSEIF _TableName = 'Party_Kanta_Log_AdditionalChargesDetails' THEN
    	DELETE FROM Party_Kanta_Log_AdditionalChargesDetails WHERE 
        	Id = _PrimaryKeyValue;
     ELSEIF _TableName = "Kanta_Charges" THEN
     	DELETE FROM Kanta_Charges WHERE Id = _PrimaryKeyValue;
     ELSEIF _TableName = "Cheque_Logs" THEN
     	DELETE FROM Cheque_Logs WHERE Id = _PrimaryKeyValue;
     ELSEIF _TableName = "Company_Kanta_Log" THEN
     	DELETE FROM Company_Kanta_Log WHERE Id = _PrimaryKeyValue;
     ELSEIF _TableName = "StockAssignment" THEN
     	DELETE FROM StockAssignments WHERE Id = _PrimaryKeyValue;   
     ELSEIF _TableName = "StockAssignment" THEN
     	DELETE FROM PurchaseDetails WHERE PurchaseId = _PrimaryKeyValue;
     ELSEIF _TableName = "StockAssignmentDetails" THEN
     	DELETE FROM StockAssignmentDetails WHERE Id = _PrimaryKeyValue;
     ELSEIF _TableName = "Purchases" THEN
     	DELETE FROM Purchases WHERE Id - _PrimaryKeyValue;
     ELSEIF _TableName = "Party_Kanta_Log_AdditionalChargesDetail" THEN
     	DELETE FROM Party_Kanta_Log_AdditionalChargesDetail WHERE Id = _PrimaryKeyValue;
     ELSEIF _TableName = "Kanta_General" THEN
    	DELETE FROM Kanta_General WHERE Id = _PrimaryKeyValue ;
     ELSEIF _TableName = "StockData" THEN
     	DELETE FROM StockData WHERE Id = _PrimaryKeyValue;
	END if;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `employeeattendences_Process` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `employeeattendences_Process`(p_employeeattendences JSON)
BEGIN INSERT INTO employeeattendences ( Id,EntryDateTime,CheckInDateTime,CheckOutDateTime,EmployeeId,UserId,IsOnLeave,IsPresent,TotalDutyHours,IsSync )SELECT * FROM JSON_TABLE(p_employeeattendences, '$[*]' COLUMNS (Id int PATH '$.Id',EntryDateTime datetime PATH '$.EntryDateTime',CheckInDateTime datetime PATH '$.CheckInDateTime',CheckOutDateTime datetime PATH '$.CheckOutDateTime',EmployeeId int PATH '$.EmployeeId',UserId int PATH '$.UserId',IsOnLeave tinyint PATH '$.IsOnLeave',IsPresent tinyint PATH '$.IsPresent',TotalDutyHours int PATH '$.TotalDutyHours',IsSync tinyint PATH '$.IsSync')) AS employeeattendencesClient ON DUPLICATE KEY UPDATE EntryDateTime = employeeattendencesClient.EntryDateTime,CheckInDateTime = employeeattendencesClient.CheckInDateTime,CheckOutDateTime = employeeattendencesClient.CheckOutDateTime,EmployeeId = employeeattendencesClient.EmployeeId,UserId = employeeattendencesClient.UserId,IsOnLeave = employeeattendencesClient.IsOnLeave,IsPresent = employeeattendencesClient.IsPresent,TotalDutyHours = employeeattendencesClient.TotalDutyHours,IsSync = employeeattendencesClient.IsSync; END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `employees_Process` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `employees_Process`(p_employees JSON)
BEGIN INSERT INTO employees ( Id,EmployeeType,EmployeeName,EmployeeCNIC,MineId,PartyId,EmployeeJoiningDate,EmployeeLeavingDate,EmployeeSalary,EmployeePicture,IsActive,WorksUnderEmployeeId,FMD,FMD2,DailyWorkingHours,IsSync )SELECT * FROM JSON_TABLE(p_employees, '$[*]' COLUMNS (Id int PATH '$.Id',EmployeeType int PATH '$.EmployeeType',EmployeeName longtext PATH '$.EmployeeName',EmployeeCNIC longtext PATH '$.EmployeeCNIC',MineId int PATH '$.MineId',PartyId int PATH '$.PartyId',EmployeeJoiningDate datetime PATH '$.EmployeeJoiningDate',EmployeeLeavingDate datetime PATH '$.EmployeeLeavingDate',EmployeeSalary decimal PATH '$.EmployeeSalary',EmployeePicture int PATH '$.EmployeePicture',IsActive tinyint PATH '$.IsActive',WorksUnderEmployeeId int PATH '$.WorksUnderEmployeeId',FMD longtext PATH '$.FMD',FMD2 longtext PATH '$.FMD2',DailyWorkingHours int PATH '$.DailyWorkingHours',IsSync tinyint PATH '$.IsSync')) AS employeesClient ON DUPLICATE KEY UPDATE EmployeeType = employeesClient.EmployeeType,EmployeeName = employeesClient.EmployeeName,EmployeeCNIC = employeesClient.EmployeeCNIC,MineId = employeesClient.MineId,PartyId = employeesClient.PartyId,EmployeeJoiningDate = employeesClient.EmployeeJoiningDate,EmployeeLeavingDate = employeesClient.EmployeeLeavingDate,EmployeeSalary = employeesClient.EmployeeSalary,EmployeePicture = employeesClient.EmployeePicture,IsActive = employeesClient.IsActive,WorksUnderEmployeeId = employeesClient.WorksUnderEmployeeId,FMD = employeesClient.FMD,FMD2 = employeesClient.FMD2,DailyWorkingHours = employeesClient.DailyWorkingHours,IsSync = employeesClient.IsSync; END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `employeetypes_Process` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `employeetypes_Process`(p_employeetypes JSON)
BEGIN INSERT INTO employeetypes ( Id,EmployeeTypeDescription,IsSync )SELECT * FROM JSON_TABLE(p_employeetypes, '$[*]' COLUMNS (Id int PATH '$.Id',EmployeeTypeDescription longtext PATH '$.EmployeeTypeDescription',IsSync tinyint PATH '$.IsSync')) AS employeetypesClient ON DUPLICATE KEY UPDATE EmployeeTypeDescription = employeetypesClient.EmployeeTypeDescription,IsSync = employeetypesClient.IsSync; END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `EntriesPage_Data` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `EntriesPage_Data`(FromDate DATE,ToDate date)
BEGIN
SELECT DISTINCT T.InvoiceNumber , T.SerialNo , DATE_FORMAT(T.TransactionDate , '%d/%m/%Y') AS
                TransactionDate
                 FROM Accounts A JOIN Transactions T ON A.AccountId = T.AccountId
            WHERE  cast(T.TransactionDate as date) BETWEEN FromDate AND ToDate ORDER BY InvoiceNumber;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `forminprojects_Process` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `forminprojects_Process`(p_forminprojects JSON)
BEGIN INSERT INTO forminprojects ( Id,FormName,IdKey,IsSync )SELECT * FROM JSON_TABLE(p_forminprojects, '$[*]' COLUMNS (Id int PATH '$.Id',FormName longtext PATH '$.FormName',IdKey int PATH '$.IdKey',IsSync tinyint PATH '$.IsSync')) AS forminprojectsClient ON DUPLICATE KEY UPDATE FormName = forminprojectsClient.FormName,IdKey = forminprojectsClient.IdKey,IsSync = forminprojectsClient.IsSync; END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `heads_Process` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `heads_Process`(p_heads JSON)
BEGIN INSERT INTO heads ( Id,HeadName,IsSync )SELECT * FROM JSON_TABLE(p_heads, '$[*]' COLUMNS (Id int PATH '$.Id',HeadName longtext PATH '$.HeadName',IsSync tinyint PATH '$.IsSync')) AS headsClient ON DUPLICATE KEY UPDATE HeadName = headsClient.HeadName,IsSync = headsClient.IsSync; END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `items_Process` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `items_Process`(p_items JSON)
BEGIN INSERT INTO items ( Id,ItemName,AccountId,IsSync )SELECT * FROM JSON_TABLE(p_items, '$[*]' COLUMNS (Id int PATH '$.Id',ItemName longtext PATH '$.ItemName',AccountId int PATH '$.AccountId',IsSync tinyint PATH '$.IsSync')) AS itemsClient ON DUPLICATE KEY UPDATE ItemName = itemsClient.ItemName,AccountId = itemsClient.AccountId,IsSync = itemsClient.IsSync; END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `itemtypes_Process` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `itemtypes_Process`(p_itemtypes JSON)
BEGIN INSERT INTO itemtypes ( Id,ItemType,IsSync )SELECT * FROM JSON_TABLE(p_itemtypes, '$[*]' COLUMNS (Id int PATH '$.Id',ItemType longtext PATH '$.ItemType',IsSync tinyint PATH '$.IsSync')) AS itemtypesClient ON DUPLICATE KEY UPDATE ItemType = itemtypesClient.ItemType,IsSync = itemtypesClient.IsSync; END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `kanta_charge_Process` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `kanta_charge_Process`(p_kanta_charge JSON)
BEGIN INSERT INTO kanta_charge ( Id,CustomerTypeId,VehicleTypeId,ChargesDescription,Charges,IsSync )SELECT * FROM JSON_TABLE(p_kanta_charge, '$[*]' COLUMNS (Id int PATH '$.Id',CustomerTypeId int PATH '$.CustomerTypeId',VehicleTypeId int PATH '$.VehicleTypeId',ChargesDescription longtext PATH '$.ChargesDescription',Charges decimal PATH '$.Charges',IsSync tinyint PATH '$.IsSync')) AS kanta_chargeClient ON DUPLICATE KEY UPDATE CustomerTypeId = kanta_chargeClient.CustomerTypeId,VehicleTypeId = kanta_chargeClient.VehicleTypeId,ChargesDescription = kanta_chargeClient.ChargesDescription,Charges = kanta_chargeClient.Charges,IsSync = kanta_chargeClient.IsSync; END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `kanta_general_Process` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `kanta_general_Process`(p_kanta_general JSON)
BEGIN INSERT INTO kanta_general ( Id,EntryDateTime,VehicleNumber,WeightInKilograms,WeightInTons,WeightInMounds40Kg,WeightInMounds42Kg,UserId,HasDetail,InvoiceNumber,CustomerTypeId,VehicleType,TotalCharges,CompanyId,IsEmpty,IsSync )SELECT * FROM JSON_TABLE(p_kanta_general, '$[*]' COLUMNS (Id int PATH '$.Id',EntryDateTime datetime PATH '$.EntryDateTime',VehicleNumber longtext PATH '$.VehicleNumber',WeightInKilograms decimal PATH '$.WeightInKilograms',WeightInTons decimal PATH '$.WeightInTons',WeightInMounds40Kg decimal PATH '$.WeightInMounds40Kg',WeightInMounds42Kg decimal PATH '$.WeightInMounds42Kg',UserId int PATH '$.UserId',HasDetail tinyint PATH '$.HasDetail',InvoiceNumber bigint PATH '$.InvoiceNumber',CustomerTypeId int PATH '$.CustomerTypeId',VehicleType int PATH '$.VehicleType',TotalCharges decimal PATH '$.TotalCharges',CompanyId int PATH '$.CompanyId',IsEmpty tinyint PATH '$.IsEmpty',IsSync tinyint PATH '$.IsSync')) AS kanta_generalClient ON DUPLICATE KEY UPDATE EntryDateTime = kanta_generalClient.EntryDateTime,VehicleNumber = kanta_generalClient.VehicleNumber,WeightInKilograms = kanta_generalClient.WeightInKilograms,WeightInTons = kanta_generalClient.WeightInTons,WeightInMounds40Kg = kanta_generalClient.WeightInMounds40Kg,WeightInMounds42Kg = kanta_generalClient.WeightInMounds42Kg,UserId = kanta_generalClient.UserId,HasDetail = kanta_generalClient.HasDetail,InvoiceNumber = kanta_generalClient.InvoiceNumber,CustomerTypeId = kanta_generalClient.CustomerTypeId,VehicleType = kanta_generalClient.VehicleType,TotalCharges = kanta_generalClient.TotalCharges,CompanyId = kanta_generalClient.CompanyId,IsEmpty = kanta_generalClient.IsEmpty,IsSync = kanta_generalClient.IsSync; END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `kanta_mine_additionalpackages_Process` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `kanta_mine_additionalpackages_Process`(p_kanta_mine_additionalpackages JSON)
BEGIN INSERT INTO kanta_mine_additionalpackages ( Id,MineCondition,TypeCondition,AccountIdCondition,AccountIdCondition_CompanyId,IsFixed,IsCredit,PerTonValue,FixedValue,Particulars,Type,EntryInAccount,EntryInAccount_CompanyId,IsSync )SELECT * FROM JSON_TABLE(p_kanta_mine_additionalpackages, '$[*]' COLUMNS (Id int PATH '$.Id',MineCondition int PATH '$.MineCondition',TypeCondition int PATH '$.TypeCondition',AccountIdCondition int PATH '$.AccountIdCondition',AccountIdCondition_CompanyId int PATH '$.AccountIdCondition_CompanyId',IsFixed tinyint PATH '$.IsFixed',IsCredit tinyint PATH '$.IsCredit',PerTonValue decimal PATH '$.PerTonValue',FixedValue decimal PATH '$.FixedValue',Particulars longtext PATH '$.Particulars',Type int PATH '$.Type',EntryInAccount int PATH '$.EntryInAccount',EntryInAccount_CompanyId int PATH '$.EntryInAccount_CompanyId',IsSync tinyint PATH '$.IsSync')) AS kanta_mine_additionalpackagesClient ON DUPLICATE KEY UPDATE MineCondition = kanta_mine_additionalpackagesClient.MineCondition,TypeCondition = kanta_mine_additionalpackagesClient.TypeCondition,AccountIdCondition = kanta_mine_additionalpackagesClient.AccountIdCondition,AccountIdCondition_CompanyId = kanta_mine_additionalpackagesClient.AccountIdCondition_CompanyId,IsFixed = kanta_mine_additionalpackagesClient.IsFixed,IsCredit = kanta_mine_additionalpackagesClient.IsCredit,PerTonValue = kanta_mine_additionalpackagesClient.PerTonValue,FixedValue = kanta_mine_additionalpackagesClient.FixedValue,Particulars = kanta_mine_additionalpackagesClient.Particulars,Type = kanta_mine_additionalpackagesClient.Type,EntryInAccount = kanta_mine_additionalpackagesClient.EntryInAccount,EntryInAccount_CompanyId = kanta_mine_additionalpackagesClient.EntryInAccount_CompanyId,IsSync = kanta_mine_additionalpackagesClient.IsSync; END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `minestatuses_Process` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `minestatuses_Process`(p_minestatuses JSON)
BEGIN INSERT INTO minestatuses ( Id,MineStatus,IsSync )SELECT * FROM JSON_TABLE(p_minestatuses, '$[*]' COLUMNS (Id int PATH '$.Id',MineStatus longtext PATH '$.MineStatus',IsSync tinyint PATH '$.IsSync')) AS minestatusesClient ON DUPLICATE KEY UPDATE MineStatus = minestatusesClient.MineStatus,IsSync = minestatusesClient.IsSync; END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `mines_pertoncharges_Process` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `mines_pertoncharges_Process`(p_mines_pertoncharges JSON)
BEGIN INSERT INTO mines_pertoncharges ( Id,MineId,PerTonRate,EntryDate,IsActive,IsSync )SELECT * FROM JSON_TABLE(p_mines_pertoncharges, '$[*]' COLUMNS (Id int PATH '$.Id',MineId int PATH '$.MineId',PerTonRate decimal PATH '$.PerTonRate',EntryDate datetime PATH '$.EntryDate',IsActive tinyint PATH '$.IsActive',IsSync tinyint PATH '$.IsSync')) AS mines_pertonchargesClient ON DUPLICATE KEY UPDATE MineId = mines_pertonchargesClient.MineId,PerTonRate = mines_pertonchargesClient.PerTonRate,EntryDate = mines_pertonchargesClient.EntryDate,IsActive = mines_pertonchargesClient.IsActive,IsSync = mines_pertonchargesClient.IsSync; END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `mine_Process` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `mine_Process`(p_mine JSON)
BEGIN INSERT INTO mine ( Id,MineDescription,AreaId,MineStatusId,CurrentCompanyId,AgreementValue,AgreementType,UnitId,MineDegree,MateId,MinesOwnedBy,IsSync )SELECT * FROM JSON_TABLE(p_mine, '$[*]' COLUMNS (Id int PATH '$.Id',MineDescription longtext PATH '$.MineDescription',AreaId int PATH '$.AreaId',MineStatusId int PATH '$.MineStatusId',CurrentCompanyId int PATH '$.CurrentCompanyId',AgreementValue decimal PATH '$.AgreementValue',AgreementType longtext PATH '$.AgreementType',UnitId int PATH '$.UnitId',MineDegree longtext PATH '$.MineDegree',MateId int PATH '$.MateId',MinesOwnedBy int PATH '$.MinesOwnedBy',IsSync tinyint PATH '$.IsSync')) AS mineClient ON DUPLICATE KEY UPDATE MineDescription = mineClient.MineDescription,AreaId = mineClient.AreaId,MineStatusId = mineClient.MineStatusId,CurrentCompanyId = mineClient.CurrentCompanyId,AgreementValue = mineClient.AgreementValue,AgreementType = mineClient.AgreementType,UnitId = mineClient.UnitId,MineDegree = mineClient.MineDegree,MateId = mineClient.MateId,MinesOwnedBy = mineClient.MinesOwnedBy,IsSync = mineClient.IsSync; END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `mobilenoes_Process` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `mobilenoes_Process`(p_mobilenoes JSON)
BEGIN INSERT INTO mobilenoes ( Id,MobileNo1,MobileNo2,MobileNoKanta1,MobileNoKanta2,IsSync )SELECT * FROM JSON_TABLE(p_mobilenoes, '$[*]' COLUMNS (Id int PATH '$.Id',MobileNo1 longtext PATH '$.MobileNo1',MobileNo2 longtext PATH '$.MobileNo2',MobileNoKanta1 longtext PATH '$.MobileNoKanta1',MobileNoKanta2 longtext PATH '$.MobileNoKanta2',IsSync tinyint PATH '$.IsSync')) AS mobilenoesClient ON DUPLICATE KEY UPDATE MobileNo1 = mobilenoesClient.MobileNo1,MobileNo2 = mobilenoesClient.MobileNo2,MobileNoKanta1 = mobilenoesClient.MobileNoKanta1,MobileNoKanta2 = mobilenoesClient.MobileNoKanta2,IsSync = mobilenoesClient.IsSync; END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `online_getapprovedentries` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `online_getapprovedentries`()
BEGIN
	SELECT * FROM online_approvals where isdownloaded = 0;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `online_getemployeeattendences` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `online_getemployeeattendences`(_FromDate DATE,_ToDate DATE)
BEGIN
SELECT ET.EmployeeTypedescription 'Type' , 
		E.EmployeeName ,  DATE_FORMAT(EA.EntryDateTime,'%d-%m-%Y') 'EntryDate' , DATE_FORMAT(EA.CheckInDateTime,'%r') 'CheckIn' , 
			DATE_FORMAT(EA.CheckOutDateTime,'%r') 'CheckOut' FROM Employees E JOIN EmployeeAttendences EA ON E.id = ea.EmployeeId
		join EmployeeTypes ET ON ET.Id = E.EmployeeType WHERE EntryDateTime BETWEEN _FromDate AND _ToDate
        ;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `online_markapproval` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `online_markapproval`(_InvoiceNumber BIGINT)
BEGIN
	UPDATE online_approvals SET IsDownloaded = 1 WHERE InvoiceNumber = _InvoiceNumber;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `online_transactionentry` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `online_transactionentry`(p_transactions JSON)
BEGIN
INSERT INTO online_transactions ( InvoiceNumber,TransactionDate,BillNumber,ChequeNumber,Particulars,AccountId,Amount,UserId,ProjectId,MineId,IsApproved,PaymentType,IncExpTag,ProjectIdType,IsProcessed )
	SELECT * FROM JSON_TABLE(p_transactions, '$[*]' COLUMNS (
		InvoiceNumber bigint PATH '$.InvoiceNumber',TransactionDate datetime PATH '$.TransactionDate',
        BillNumber longtext PATH '$.BillNumber',ChequeNumber longtext PATH '$.ChequeNumber',
        Particulars longtext PATH '$.Particulars',AccountId int PATH '$.AccountId',
        Amount decimal PATH '$.Amount',UserId int PATH '$.UserId',
        ProjectId int PATH '$.ProjectId',MineId int PATH '$.MineId',IsApproved tinyint PATH '$.IsApproved',
        PaymentType longtext PATH '$.PaymentType',
        IncExpTag int PATH '$.IncExpTag',
        ProjectIdType int PATH '$.ProjectIdType',IsProcessed tinyint PATH '$.IsProcessed'
        )) AS transactionsClient ;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `party_kanta_log_additionalchargesdetail_Process` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `party_kanta_log_additionalchargesdetail_Process`(p_party_kanta_log_additionalchargesdetail JSON)
BEGIN INSERT INTO party_kanta_log_additionalchargesdetail ( Id,Kanta_General_Id,ChargesDescription,Charges,AccountId,InvoiceNumber,IsSync )SELECT * FROM JSON_TABLE(p_party_kanta_log_additionalchargesdetail, '$[*]' COLUMNS (Id int PATH '$.Id',Kanta_General_Id int PATH '$.Kanta_General_Id',ChargesDescription longtext PATH '$.ChargesDescription',Charges decimal PATH '$.Charges',AccountId int PATH '$.AccountId',InvoiceNumber bigint PATH '$.InvoiceNumber',IsSync tinyint PATH '$.IsSync')) AS party_kanta_log_additionalchargesdetailClient ON DUPLICATE KEY UPDATE Kanta_General_Id = party_kanta_log_additionalchargesdetailClient.Kanta_General_Id,ChargesDescription = party_kanta_log_additionalchargesdetailClient.ChargesDescription,Charges = party_kanta_log_additionalchargesdetailClient.Charges,AccountId = party_kanta_log_additionalchargesdetailClient.AccountId,InvoiceNumber = party_kanta_log_additionalchargesdetailClient.InvoiceNumber,IsSync = party_kanta_log_additionalchargesdetailClient.IsSync; END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `projects_Process` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `projects_Process`(p_projects JSON)
BEGIN INSERT INTO projects ( Id,ProjectName,IsSync )SELECT * FROM JSON_TABLE(p_projects, '$[*]' COLUMNS (Id int PATH '$.Id',ProjectName longtext PATH '$.ProjectName',IsSync tinyint PATH '$.IsSync')) AS projectsClient ON DUPLICATE KEY UPDATE ProjectName = projectsClient.ProjectName,IsSync = projectsClient.IsSync; END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `purchasedetails_Process` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `purchasedetails_Process`(p_purchasedetails JSON)
BEGIN INSERT INTO purchasedetails ( Id,PurchaseId,ItemId,UnitId,Quantity,Amount,IsSync )SELECT * FROM JSON_TABLE(p_purchasedetails, '$[*]' COLUMNS (Id int PATH '$.Id',PurchaseId int PATH '$.PurchaseId',ItemId int PATH '$.ItemId',UnitId int PATH '$.UnitId',Quantity decimal PATH '$.Quantity',Amount decimal PATH '$.Amount',IsSync tinyint PATH '$.IsSync')) AS purchasedetailsClient ON DUPLICATE KEY UPDATE PurchaseId = purchasedetailsClient.PurchaseId,ItemId = purchasedetailsClient.ItemId,UnitId = purchasedetailsClient.UnitId,Quantity = purchasedetailsClient.Quantity,Amount = purchasedetailsClient.Amount,IsSync = purchasedetailsClient.IsSync; END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `purchases_Process` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `purchases_Process`(p_purchases JSON)
BEGIN INSERT INTO purchases ( Id,SupplierId,PurchaseDate,InvoiceNumber,BillNumber,Amount,UserId,Discount,IsSync )SELECT * FROM JSON_TABLE(p_purchases, '$[*]' COLUMNS (Id int PATH '$.Id',SupplierId int PATH '$.SupplierId',PurchaseDate datetime PATH '$.PurchaseDate',InvoiceNumber bigint PATH '$.InvoiceNumber',BillNumber longtext PATH '$.BillNumber',Amount decimal PATH '$.Amount',UserId int PATH '$.UserId',Discount decimal PATH '$.Discount',IsSync tinyint PATH '$.IsSync')) AS purchasesClient ON DUPLICATE KEY UPDATE SupplierId = purchasesClient.SupplierId,PurchaseDate = purchasesClient.PurchaseDate,InvoiceNumber = purchasesClient.InvoiceNumber,BillNumber = purchasesClient.BillNumber,Amount = purchasesClient.Amount,UserId = purchasesClient.UserId,Discount = purchasesClient.Discount,IsSync = purchasesClient.IsSync; END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `serials_Process` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `serials_Process`(p_serials JSON)
BEGIN INSERT INTO serials ( Id,KantaId,SerialNumber,UserId,IsSync )SELECT * FROM JSON_TABLE(p_serials, '$[*]' COLUMNS (Id int PATH '$.Id',KantaId int PATH '$.KantaId',SerialNumber int PATH '$.SerialNumber',UserId int PATH '$.UserId',IsSync tinyint PATH '$.IsSync')) AS serialsClient ON DUPLICATE KEY UPDATE KantaId = serialsClient.KantaId,SerialNumber = serialsClient.SerialNumber,UserId = serialsClient.UserId,IsSync = serialsClient.IsSync; END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `serialtransactions_Process` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `serialtransactions_Process`(p_serialtransactions JSON)
BEGIN INSERT INTO serialtransactions ( Id,SerialNumber,UserId,IsSync )SELECT * FROM JSON_TABLE(p_serialtransactions, '$[*]' COLUMNS (Id int PATH '$.Id',SerialNumber int PATH '$.SerialNumber',UserId int PATH '$.UserId',IsSync tinyint PATH '$.IsSync')) AS serialtransactionsClient ON DUPLICATE KEY UPDATE SerialNumber = serialtransactionsClient.SerialNumber,UserId = serialtransactionsClient.UserId,IsSync = serialtransactionsClient.IsSync; END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `stockassignmentdetails_Process` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `stockassignmentdetails_Process`(p_stockassignmentdetails JSON)
BEGIN INSERT INTO stockassignmentdetails ( Id,InvoiceNumber,ItemId,UnitId,Quantity,StockId,Amount,IsSync )SELECT * FROM JSON_TABLE(p_stockassignmentdetails, '$[*]' COLUMNS (Id int PATH '$.Id',InvoiceNumber bigint PATH '$.InvoiceNumber',ItemId int PATH '$.ItemId',UnitId int PATH '$.UnitId',Quantity decimal PATH '$.Quantity',StockId int PATH '$.StockId',Amount decimal PATH '$.Amount',IsSync tinyint PATH '$.IsSync')) AS stockassignmentdetailsClient ON DUPLICATE KEY UPDATE InvoiceNumber = stockassignmentdetailsClient.InvoiceNumber,ItemId = stockassignmentdetailsClient.ItemId,UnitId = stockassignmentdetailsClient.UnitId,Quantity = stockassignmentdetailsClient.Quantity,StockId = stockassignmentdetailsClient.StockId,Amount = stockassignmentdetailsClient.Amount,IsSync = stockassignmentdetailsClient.IsSync; END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `stockassignments_Process` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `stockassignments_Process`(p_stockassignments JSON)
BEGIN INSERT INTO stockassignments ( Id,AssignedDateTime,InvoiceNumber,ItemId,UnitId,Quantity,MineId,CompanyId,UserId,TotalPrice,DebitInAccountId,Deliverer,Receiver,Particulars,IsSync )SELECT * FROM JSON_TABLE(p_stockassignments, '$[*]' COLUMNS (Id int PATH '$.Id',AssignedDateTime datetime PATH '$.AssignedDateTime',InvoiceNumber bigint PATH '$.InvoiceNumber',ItemId int PATH '$.ItemId',UnitId int PATH '$.UnitId',Quantity decimal PATH '$.Quantity',MineId int PATH '$.MineId',CompanyId int PATH '$.CompanyId',UserId int PATH '$.UserId',TotalPrice decimal PATH '$.TotalPrice',DebitInAccountId int PATH '$.DebitInAccountId',Deliverer longtext PATH '$.Deliverer',Receiver longtext PATH '$.Receiver',Particulars longtext PATH '$.Particulars',IsSync tinyint PATH '$.IsSync')) AS stockassignmentsClient ON DUPLICATE KEY UPDATE AssignedDateTime = stockassignmentsClient.AssignedDateTime,InvoiceNumber = stockassignmentsClient.InvoiceNumber,ItemId = stockassignmentsClient.ItemId,UnitId = stockassignmentsClient.UnitId,Quantity = stockassignmentsClient.Quantity,MineId = stockassignmentsClient.MineId,CompanyId = stockassignmentsClient.CompanyId,UserId = stockassignmentsClient.UserId,TotalPrice = stockassignmentsClient.TotalPrice,DebitInAccountId = stockassignmentsClient.DebitInAccountId,Deliverer = stockassignmentsClient.Deliverer,Receiver = stockassignmentsClient.Receiver,Particulars = stockassignmentsClient.Particulars,IsSync = stockassignmentsClient.IsSync; END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `stocks_Process` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `stocks_Process`(p_stocks JSON)
BEGIN INSERT INTO stocks ( Id,InvoiceNumber,ItemId,UnitId,Quantity,UnitPrice,TotalPrice,Consumed,PurchaseDetailId,IsSync )SELECT * FROM JSON_TABLE(p_stocks, '$[*]' COLUMNS (Id int PATH '$.Id',InvoiceNumber bigint PATH '$.InvoiceNumber',ItemId int PATH '$.ItemId',UnitId int PATH '$.UnitId',Quantity decimal PATH '$.Quantity',UnitPrice decimal PATH '$.UnitPrice',TotalPrice decimal PATH '$.TotalPrice',Consumed decimal PATH '$.Consumed',PurchaseDetailId int PATH '$.PurchaseDetailId',IsSync tinyint PATH '$.IsSync')) AS stocksClient ON DUPLICATE KEY UPDATE InvoiceNumber = stocksClient.InvoiceNumber,ItemId = stocksClient.ItemId,UnitId = stocksClient.UnitId,Quantity = stocksClient.Quantity,UnitPrice = stocksClient.UnitPrice,TotalPrice = stocksClient.TotalPrice,Consumed = stocksClient.Consumed,PurchaseDetailId = stocksClient.PurchaseDetailId,IsSync = stocksClient.IsSync; END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `transactionshistories_Process` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `transactionshistories_Process`(p_transactionshistories JSON)
BEGIN INSERT INTO transactionshistories ( Id,SerialNo,InvoiceNumber,TransactionDate,BillNumber,ChequeNumber,Particulars,AccountId,Amount,UserId,ProjectId,MineId,ImageId,IsApproved,IsManualEntry,TotalTons,PerTonValue,PaymentType,PurchaseDetailId,EditedByUserId,TransactionTypeId,IncExpTag,ProjectIdType,IsProcessed,IsSync )SELECT * FROM JSON_TABLE(p_transactionshistories, '$[*]' COLUMNS (Id int PATH '$.Id',SerialNo int PATH '$.SerialNo',InvoiceNumber bigint PATH '$.InvoiceNumber',TransactionDate datetime PATH '$.TransactionDate',BillNumber longtext PATH '$.BillNumber',ChequeNumber longtext PATH '$.ChequeNumber',Particulars longtext PATH '$.Particulars',AccountId int PATH '$.AccountId',Amount decimal PATH '$.Amount',UserId int PATH '$.UserId',ProjectId int PATH '$.ProjectId',MineId int PATH '$.MineId',ImageId int PATH '$.ImageId',IsApproved tinyint PATH '$.IsApproved',IsManualEntry tinyint PATH '$.IsManualEntry',TotalTons decimal PATH '$.TotalTons',PerTonValue decimal PATH '$.PerTonValue',PaymentType longtext PATH '$.PaymentType',PurchaseDetailId int PATH '$.PurchaseDetailId',EditedByUserId int PATH '$.EditedByUserId',TransactionTypeId int PATH '$.TransactionTypeId',IncExpTag int PATH '$.IncExpTag',ProjectIdType int PATH '$.ProjectIdType',IsProcessed tinyint PATH '$.IsProcessed',IsSync tinyint PATH '$.IsSync')) AS transactionshistoriesClient ON DUPLICATE KEY UPDATE SerialNo = transactionshistoriesClient.SerialNo,InvoiceNumber = transactionshistoriesClient.InvoiceNumber,TransactionDate = transactionshistoriesClient.TransactionDate,BillNumber = transactionshistoriesClient.BillNumber,ChequeNumber = transactionshistoriesClient.ChequeNumber,Particulars = transactionshistoriesClient.Particulars,AccountId = transactionshistoriesClient.AccountId,Amount = transactionshistoriesClient.Amount,UserId = transactionshistoriesClient.UserId,ProjectId = transactionshistoriesClient.ProjectId,MineId = transactionshistoriesClient.MineId,ImageId = transactionshistoriesClient.ImageId,IsApproved = transactionshistoriesClient.IsApproved,IsManualEntry = transactionshistoriesClient.IsManualEntry,TotalTons = transactionshistoriesClient.TotalTons,PerTonValue = transactionshistoriesClient.PerTonValue,PaymentType = transactionshistoriesClient.PaymentType,PurchaseDetailId = transactionshistoriesClient.PurchaseDetailId,EditedByUserId = transactionshistoriesClient.EditedByUserId,TransactionTypeId = transactionshistoriesClient.TransactionTypeId,IncExpTag = transactionshistoriesClient.IncExpTag,ProjectIdType = transactionshistoriesClient.ProjectIdType,IsProcessed = transactionshistoriesClient.IsProcessed,IsSync = transactionshistoriesClient.IsSync; END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `transactions_Process` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `transactions_Process`(p_transactions JSON)
BEGIN INSERT INTO transactions ( Id,SerialNo,InvoiceNumber,TransactionDate,BillNumber,ChequeNumber,Particulars,AccountId,Amount,UserId,ProjectId,MineId,ImageId,IsApproved,IsManualEntry,TotalTons,PerTonValue,PaymentType,PurchaseDetailId,IncExpTag,ProjectIdType,IsProcessed,IsSync )
	SELECT * FROM JSON_TABLE(p_transactions, '$[*]' COLUMNS (Id int PATH '$.Id',SerialNo int PATH '$.SerialNo',
		InvoiceNumber bigint PATH '$.InvoiceNumber',TransactionDate datetime PATH '$.TransactionDate',
        BillNumber longtext PATH '$.BillNumber',ChequeNumber longtext PATH '$.ChequeNumber',
        Particulars longtext PATH '$.Particulars',AccountId int PATH '$.AccountId',
        Amount decimal PATH '$.Amount',UserId int PATH '$.UserId',
        ProjectId int PATH '$.ProjectId',MineId int PATH '$.MineId',
        ImageId int PATH '$.ImageId',IsApproved tinyint PATH '$.IsApproved',
        IsManualEntry tinyint PATH '$.IsManualEntry',TotalTons decimal PATH '$.TotalTons',
        PerTonValue decimal PATH '$.PerTonValue',PaymentType longtext PATH '$.PaymentType',
        PurchaseDetailId int PATH '$.PurchaseDetailId',IncExpTag int PATH '$.IncExpTag',
        ProjectIdType int PATH '$.ProjectIdType',IsProcessed tinyint PATH '$.IsProcessed',
        IsSync tinyint PATH '$.IsSync')) AS transactionsClient 
        ON DUPLICATE KEY UPDATE SerialNo = transactionsClient.SerialNo,InvoiceNumber = transactionsClient.InvoiceNumber,
        TransactionDate = transactionsClient.TransactionDate,BillNumber = transactionsClient.BillNumber,
        ChequeNumber = transactionsClient.ChequeNumber,Particulars = transactionsClient.Particulars,
        AccountId = transactionsClient.AccountId,Amount = transactionsClient.Amount,
        UserId = transactionsClient.UserId,ProjectId = transactionsClient.ProjectId,
        MineId = transactionsClient.MineId,ImageId = transactionsClient.ImageId,
        IsApproved = transactionsClient.IsApproved,IsManualEntry = transactionsClient.IsManualEntry,
        TotalTons = transactionsClient.TotalTons,PerTonValue = transactionsClient.PerTonValue,
        PaymentType = transactionsClient.PaymentType,PurchaseDetailId = transactionsClient.PurchaseDetailId,
        IncExpTag = transactionsClient.IncExpTag,ProjectIdType = transactionsClient.ProjectIdType,
        IsProcessed = transactionsClient.IsProcessed,IsSync = transactionsClient.IsSync			; END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `transactiontypes_Process` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `transactiontypes_Process`(p_transactiontypes JSON)
BEGIN INSERT INTO transactiontypes ( Id,TransactionType,IsSync )SELECT * FROM JSON_TABLE(p_transactiontypes, '$[*]' COLUMNS (Id int PATH '$.Id',TransactionType longtext PATH '$.TransactionType',IsSync tinyint PATH '$.IsSync')) AS transactiontypesClient ON DUPLICATE KEY UPDATE TransactionType = transactiontypesClient.TransactionType,IsSync = transactiontypesClient.IsSync; END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `units_Process` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `units_Process`(p_units JSON)
BEGIN INSERT INTO units ( Id,UnitName,UnitType,IsSync )SELECT * FROM JSON_TABLE(p_units, '$[*]' COLUMNS (Id int PATH '$.Id',UnitName longtext PATH '$.UnitName',UnitType int PATH '$.UnitType',IsSync tinyint PATH '$.IsSync')) AS unitsClient ON DUPLICATE KEY UPDATE UnitName = unitsClient.UnitName,UnitType = unitsClient.UnitType,IsSync = unitsClient.IsSync; END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `unittypes_Process` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `unittypes_Process`(p_unittypes JSON)
BEGIN INSERT INTO unittypes ( Id,UnitType,IsSync )SELECT * FROM JSON_TABLE(p_unittypes, '$[*]' COLUMNS (Id int PATH '$.Id',UnitType longtext PATH '$.UnitType',IsSync tinyint PATH '$.IsSync')) AS unittypesClient ON DUPLICATE KEY UPDATE UnitType = unittypesClient.UnitType,IsSync = unittypesClient.IsSync; END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `uploadedimages_Process` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `uploadedimages_Process`(p_uploadedimages JSON)
BEGIN INSERT INTO uploadedimages ( Id,ImageBase64,IsSync )SELECT * FROM JSON_TABLE(p_uploadedimages, '$[*]' COLUMNS (Id int PATH '$.Id',ImageBase64 longtext PATH '$.ImageBase64',IsSync tinyint PATH '$.IsSync')) AS uploadedimagesClient ON DUPLICATE KEY UPDATE ImageBase64 = uploadedimagesClient.ImageBase64,IsSync = uploadedimagesClient.IsSync; END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `userpermissions_Process` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `userpermissions_Process`(p_userpermissions JSON)
BEGIN INSERT INTO userpermissions ( Id,FormName,IsAllowed,UserId,IsSync )SELECT * FROM JSON_TABLE(p_userpermissions, '$[*]' COLUMNS (Id int PATH '$.Id',FormName longtext PATH '$.FormName',IsAllowed tinyint PATH '$.IsAllowed',UserId int PATH '$.UserId',IsSync tinyint PATH '$.IsSync')) AS userpermissionsClient ON DUPLICATE KEY UPDATE FormName = userpermissionsClient.FormName,IsAllowed = userpermissionsClient.IsAllowed,UserId = userpermissionsClient.UserId,IsSync = userpermissionsClient.IsSync; END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `users_Process` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `users_Process`(p_users JSON)
BEGIN INSERT INTO users ( Id,UserName,Password,IsActive,IsAdmin,AccountId,IsSync )SELECT * FROM JSON_TABLE(p_users, '$[*]' COLUMNS (Id int PATH '$.Id',UserName longtext PATH '$.UserName',Password longtext PATH '$.Password',IsActive tinyint PATH '$.IsActive',IsAdmin tinyint PATH '$.IsAdmin',AccountId int PATH '$.AccountId',IsSync tinyint PATH '$.IsSync')) AS usersClient ON DUPLICATE KEY UPDATE UserName = usersClient.UserName,Password = usersClient.Password,IsActive = usersClient.IsActive,IsAdmin = usersClient.IsAdmin,AccountId = usersClient.AccountId,IsSync = usersClient.IsSync; END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `vehicletypes_Process` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `vehicletypes_Process`(p_vehicletypes JSON)
BEGIN INSERT INTO vehicletypes ( Id,VehicleType,IsSync )SELECT * FROM JSON_TABLE(p_vehicletypes, '$[*]' COLUMNS (Id int PATH '$.Id',VehicleType longtext PATH '$.VehicleType',IsSync tinyint PATH '$.IsSync')) AS vehicletypesClient ON DUPLICATE KEY UPDATE VehicleType = vehicletypesClient.VehicleType,IsSync = vehicletypesClient.IsSync; END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-11-14 11:43:39
