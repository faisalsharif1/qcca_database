-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               10.3.25-MariaDB - mariadb.org binary distribution
-- Server OS:                    Win64
-- HeidiSQL Version:             11.0.0.5919
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


-- Dumping database structure for qec_cms
CREATE DATABASE IF NOT EXISTS `qec_cms` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `qec_cms`;

-- Dumping structure for table qec_cms.classes
CREATE TABLE IF NOT EXISTS `classes` (
  `classid` int(10) unsigned NOT NULL,
  `classname` varchar(100) CHARACTER SET utf8 DEFAULT NULL,
  PRIMARY KEY (`classid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table qec_cms.subjects
CREATE TABLE IF NOT EXISTS `subjects` (
  `id` int(11) NOT NULL,
  `subjectname` varchar(100) CHARACTER SET utf8 DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table qec_cms.survey
CREATE TABLE IF NOT EXISTS `survey` (
  `id` int(11) NOT NULL,
  `surveyname` varchar(100) CHARACTER SET utf8 DEFAULT NULL,
  `surveydate` date DEFAULT NULL,
  `surveymonth` varchar(50) DEFAULT NULL,
  `surveyyear` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table qec_cms.surveyquestions
CREATE TABLE IF NOT EXISTS `surveyquestions` (
  `id` int(11) NOT NULL,
  `surveyid` int(11) NOT NULL DEFAULT 0,
  `question` varchar(500) CHARACTER SET utf8 NOT NULL DEFAULT '',
  `totalweight` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table qec_cms.surveyquestions_answers
CREATE TABLE IF NOT EXISTS `surveyquestions_answers` (
  `id` int(11) NOT NULL,
  `surveyquestionid` int(11) NOT NULL,
  `surveyanswer` varchar(200) NOT NULL DEFAULT '',
  `surveyanswerweight` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.

-- Dumping structure for table qec_cms.survey_mappings
CREATE TABLE IF NOT EXISTS `survey_mappings` (
  `id` int(11) NOT NULL,
  `surveyid` int(11) NOT NULL,
  `classid` int(11) NOT NULL,
  `subjectid` int(11) NOT NULL,
  `teacherid` int(11) NOT NULL,
  `surveyorid` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table qec_cms.survey_mappings_result
CREATE TABLE IF NOT EXISTS `survey_mappings_result` (
  `id` int(11) NOT NULL,
  `surveymappingid` int(11) NOT NULL,
  `surveyquestion` varchar(500) CHARACTER SET utf8 NOT NULL DEFAULT '',
  `surveyquestionweightage` int(11) NOT NULL DEFAULT 0,
  `surveyquestion_selectedanswer` int(11) NOT NULL DEFAULT 0,
  `surveyansweredweightage` int(11) NOT NULL DEFAULT 0,
  `surveyorid` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table qec_cms.teachers
CREATE TABLE IF NOT EXISTS `teachers` (
  `teacherid` int(11) NOT NULL,
  `teachername` varchar(100) CHARACTER SET utf8 DEFAULT NULL,
  PRIMARY KEY (`teacherid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
