-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jul 14, 2025 at 04:07 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `sakhteman994_susan`
--
CREATE DATABASE IF NOT EXISTS `sakhteman994_susan` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
USE `sakhteman994_susan`;

-- --------------------------------------------------------

--
-- Table structure for table `accounts`
--

DROP TABLE IF EXISTS `accounts`;
CREATE TABLE `accounts` (
  `id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `account_number` varchar(255) DEFAULT NULL,
  `sheba_number` varchar(255) DEFAULT NULL,
  `cart_number` varchar(20) DEFAULT NULL,
  `owners` varchar(255) NOT NULL,
  `is_active` tinyint(4) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `accounts`
--

INSERT INTO `accounts` (`id`, `title`, `account_number`, `sheba_number`, `cart_number`, `owners`, `is_active`) VALUES
(1, 'تست', '11223344556678789', 'IR3423565455000002344', '5022291037552266', 'خودم', 0),
(2, 'بانک پاسارگاد', '12154512', '656223', '956323232', 'خانم قنبری - آقای حاج سردار', 1);

-- --------------------------------------------------------

--
-- Table structure for table `base_banks`
--

DROP TABLE IF EXISTS `base_banks`;
CREATE TABLE `base_banks` (
  `id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `create_at` datetime NOT NULL DEFAULT current_timestamp() COMMENT 'زمان ایجاد'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='لیست بانک ها';

-- --------------------------------------------------------

--
-- Table structure for table `bld_accounts`
--

DROP TABLE IF EXISTS `bld_accounts`;
CREATE TABLE `bld_accounts` (
  `id` int(11) NOT NULL,
  `bank_id` int(11) NOT NULL COMMENT 'شناسه بانک',
  `account_number` varchar(255) DEFAULT NULL COMMENT 'شماره حساب',
  `sheba_number` varchar(255) DEFAULT NULL COMMENT 'شماره شبا',
  `cart_number` varchar(255) DEFAULT NULL COMMENT 'شماره کارت',
  `owners` varchar(255) NOT NULL COMMENT 'صاحب حساب',
  `is_active` tinyint(4) NOT NULL COMMENT 'وضعیت',
  `create_at` datetime NOT NULL DEFAULT current_timestamp() COMMENT 'زمان ایجاد'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='حسابهای بانکی';

-- --------------------------------------------------------

--
-- Table structure for table `bld_categories`
--

DROP TABLE IF EXISTS `bld_categories`;
CREATE TABLE `bld_categories` (
  `id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL COMMENT 'عنوان',
  `category_type` int(11) NOT NULL COMMENT 'نوع (درآمد/هزینه/هردو)',
  `create_at` datetime NOT NULL DEFAULT current_timestamp() COMMENT 'زمان ایجاد'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='سرفصل های مالی';

--
-- Dumping data for table `bld_categories`
--

INSERT INTO `bld_categories` (`id`, `title`, `category_type`, `create_at`) VALUES
(1, 'شارژ ماهیانه', 1, '2025-06-20 15:12:56'),
(2, 'قبض آب', 3, '2025-06-20 23:49:37'),
(3, 'قبض برق', 3, '2025-06-20 23:49:51'),
(4, 'قبض گاز', 3, '2025-06-20 23:50:02'),
(5, 'حقوق سرایدار', 2, '2025-06-20 23:50:11'),
(6, 'فضای سبز', 3, '2025-06-20 23:50:21'),
(7, 'آسانسور', 3, '2025-06-20 23:50:30');

-- --------------------------------------------------------

--
-- Table structure for table `bld_transactions`
--

DROP TABLE IF EXISTS `bld_transactions`;
CREATE TABLE `bld_transactions` (
  `id` bigint(20) NOT NULL,
  `category_id` int(11) NOT NULL COMMENT 'شناسه سرفصل',
  `unit_id` int(11) DEFAULT NULL COMMENT 'شناسه واحد',
  `amount` decimal(18,0) NOT NULL COMMENT 'مبلغ',
  `type` int(11) NOT NULL COMMENT 'نوع (دریافتی/پرداختی)',
  `action_date` datetime NOT NULL COMMENT 'زمان تراکنش',
  `is_cash` tinyint(4) NOT NULL DEFAULT 0 COMMENT 'پرداخت نقد؟',
  `account_id` int(11) DEFAULT NULL COMMENT 'شناسه حساب بانکی',
  `for_owner` tinyint(4) NOT NULL DEFAULT 0 COMMENT 'سهم مالک؟',
  `description` varchar(5000) DEFAULT NULL COMMENT 'توضیحات',
  `create_at` datetime NOT NULL DEFAULT current_timestamp() COMMENT 'زمان ایجاد'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='تراکنش ها';

-- --------------------------------------------------------

--
-- Table structure for table `bld_units`
--

DROP TABLE IF EXISTS `bld_units`;
CREATE TABLE `bld_units` (
  `id` int(11) NOT NULL,
  `unit_number` int(11) NOT NULL COMMENT 'شماره واحد',
  `floor` varchar(255) NOT NULL COMMENT 'طبقه',
  `meterage` float DEFAULT NULL COMMENT 'متراژ',
  `has_parking` tinyint(4) NOT NULL DEFAULT 0 COMMENT 'دارای پارکینگ؟',
  `has_warehouse` tinyint(4) NOT NULL DEFAULT 0 COMMENT 'دارای انباری؟',
  `create_at` datetime NOT NULL DEFAULT current_timestamp() COMMENT 'زمان ایجاد'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='واحدها';

-- --------------------------------------------------------

--
-- Table structure for table `bld_unit_cars`
--

DROP TABLE IF EXISTS `bld_unit_cars`;
CREATE TABLE `bld_unit_cars` (
  `id` bigint(20) NOT NULL,
  `unit_id` int(11) NOT NULL COMMENT 'شناسه واحد',
  `owner_id` bigint(20) DEFAULT NULL COMMENT 'شناسه مالک واحد',
  `tenant_id` bigint(20) DEFAULT NULL COMMENT 'شناسه مستاجر',
  `title` varchar(255) NOT NULL COMMENT 'عنوان خودرو',
  `plate` varchar(255) DEFAULT NULL COMMENT 'شماره پلاک',
  `is_active` tinyint(4) NOT NULL DEFAULT 1 COMMENT 'فعال است؟',
  `create_at` datetime NOT NULL DEFAULT current_timestamp() COMMENT 'زمان ایجاد'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='خودروها';

-- --------------------------------------------------------

--
-- Table structure for table `bld_unit_owners`
--

DROP TABLE IF EXISTS `bld_unit_owners`;
CREATE TABLE `bld_unit_owners` (
  `id` bigint(20) NOT NULL,
  `unit_id` int(11) NOT NULL COMMENT 'شناسه واحد',
  `full_name` varchar(255) NOT NULL COMMENT 'نام و نام خانوادگی',
  `mobile` varchar(255) DEFAULT NULL COMMENT 'شماره موبایل',
  `is_reesident` tinyint(4) NOT NULL DEFAULT 0 COMMENT 'ساکن است؟',
  `from_date` date NOT NULL COMMENT 'از تاریخ',
  `to_date` date DEFAULT NULL COMMENT 'تا تاریخ',
  `address` varchar(255) DEFAULT NULL COMMENT 'آدرس',
  `create_at` datetime NOT NULL DEFAULT current_timestamp() COMMENT 'زمان ایجاد'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='مالکین';

-- --------------------------------------------------------

--
-- Table structure for table `bld_unit_tenants`
--

DROP TABLE IF EXISTS `bld_unit_tenants`;
CREATE TABLE `bld_unit_tenants` (
  `id` bigint(20) NOT NULL,
  `unit_id` int(11) NOT NULL,
  `full_name` varchar(255) NOT NULL COMMENT 'نام و نام خانوادگی',
  `mobile` varchar(255) DEFAULT NULL COMMENT 'شماره موبایل',
  `from_date` date NOT NULL COMMENT 'از تاریخ',
  `to_date` date DEFAULT NULL COMMENT 'تا تاریخ',
  `create_at` datetime NOT NULL DEFAULT current_timestamp() COMMENT 'زمان ایجاد'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='مستاجرین';

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
CREATE TABLE `categories` (
  `id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `categoryType` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`id`, `title`, `categoryType`) VALUES
(1, 'شارژ ماهیانه', 1),
(2, 'قبض آب', 3),
(3, 'قبض برق', 3),
(4, 'قبض گاز', 3),
(5, 'حقوق سرایدار', 2),
(8, 'فضای سبز', 3),
(9, 'آسانسور', 3);

-- --------------------------------------------------------

--
-- Table structure for table `transactions`
--

DROP TABLE IF EXISTS `transactions`;
CREATE TABLE `transactions` (
  `id` bigint(20) NOT NULL,
  `unit_id` int(11) DEFAULT NULL,
  `category_id` int(11) NOT NULL,
  `amount` decimal(10,0) NOT NULL,
  `type` int(11) NOT NULL,
  `trans_date` datetime NOT NULL,
  `is_cash` tinyint(4) NOT NULL DEFAULT 0,
  `account_id` int(11) DEFAULT NULL,
  `for_resident` int(11) NOT NULL,
  `description` varchar(5000) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `transactions`
--

INSERT INTO `transactions` (`id`, `unit_id`, `category_id`, `amount`, `type`, `trans_date`, `is_cash`, `account_id`, `for_resident`, `description`) VALUES
(1, 1, 1, 7840000, 1, '2025-06-17 14:31:00', 0, NULL, 1, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `units`
--

DROP TABLE IF EXISTS `units`;
CREATE TABLE `units` (
  `id` int(11) NOT NULL,
  `unit_number` int(11) NOT NULL,
  `floor` varchar(255) NOT NULL,
  `meterage` float NOT NULL,
  `has_parking` tinyint(4) NOT NULL,
  `has_warehouse` tinyint(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `units`
--

INSERT INTO `units` (`id`, `unit_number`, `floor`, `meterage`, `has_parking`, `has_warehouse`) VALUES
(1, 1, 'همکف', 49, 1, 1),
(2, 2, 'همکف', 110, 0, 1),
(3, 3, 'همکف', 95, 1, 0),
(4, 4, 'همکف', 95, 1, 0),
(5, 5, 'همکف', 110, 0, 1),
(6, 6, 'همکف', 81, 1, 1),
(7, 7, 'دوم', 81, 1, 1),
(8, 8, 'دوم', 110, 0, 1),
(9, 9, 'دوم', 95, 1, 0),
(10, 10, 'دوم', 95, 1, 0),
(11, 11, 'دوم', 110, 0, 1),
(12, 12, 'دوم', 81, 1, 1),
(13, 13, 'سوم', 81, 1, 1),
(14, 14, 'سوم', 110, 0, 1),
(15, 15, 'سوم', 95, 1, 0),
(16, 16, 'سوم', 95, 1, 0),
(17, 17, 'سوم', 110, 0, 1),
(18, 18, 'سوم', 81, 1, 1),
(19, 19, 'چهارم', 81, 1, 1),
(20, 20, 'چهارم', 110, 0, 1),
(21, 21, 'چهارم', 95, 1, 0),
(22, 22, 'چهارم', 95, 1, 0),
(23, 23, 'چهارم', 110, 0, 1),
(24, 24, 'چهارم', 81, 1, 1),
(25, 25, 'پنجم', 81, 1, 1),
(26, 26, 'پنجم', 110, 0, 1),
(27, 27, 'پنجم', 95, 1, 0),
(28, 28, 'پنجم', 95, 1, 0),
(29, 29, 'پنجم', 110, 0, 1),
(30, 30, 'پنجم', 81, 1, 1),
(31, 31, 'پارکینگ', 20, 0, 1);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `accounts`
--
ALTER TABLE `accounts`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `base_banks`
--
ALTER TABLE `base_banks`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `bld_accounts`
--
ALTER TABLE `bld_accounts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_base_banks_TO_bld_accounts` (`bank_id`);

--
-- Indexes for table `bld_categories`
--
ALTER TABLE `bld_categories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `bld_transactions`
--
ALTER TABLE `bld_transactions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_bld_units_TO_bld_transactions` (`unit_id`),
  ADD KEY `FK_bld_categories_TO_bld_transactions` (`category_id`),
  ADD KEY `FK_bld_accounts_TO_bld_transactions` (`account_id`);

--
-- Indexes for table `bld_units`
--
ALTER TABLE `bld_units`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UQ_unit_number` (`unit_number`);

--
-- Indexes for table `bld_unit_cars`
--
ALTER TABLE `bld_unit_cars`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_bld_units_TO_bld_unit_cars` (`unit_id`),
  ADD KEY `FK_bld_unit_owners_TO_bld_unit_cars` (`owner_id`),
  ADD KEY `FK_bld_unit_tenants_TO_bld_unit_cars` (`tenant_id`);

--
-- Indexes for table `bld_unit_owners`
--
ALTER TABLE `bld_unit_owners`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_bld_units_TO_bld_unit_owners` (`unit_id`);

--
-- Indexes for table `bld_unit_tenants`
--
ALTER TABLE `bld_unit_tenants`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_bld_units_TO_bld_unit_tenants` (`unit_id`);

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `transactions`
--
ALTER TABLE `transactions`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `units`
--
ALTER TABLE `units`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `accounts`
--
ALTER TABLE `accounts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `base_banks`
--
ALTER TABLE `base_banks`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `bld_accounts`
--
ALTER TABLE `bld_accounts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `bld_categories`
--
ALTER TABLE `bld_categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `bld_transactions`
--
ALTER TABLE `bld_transactions`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `bld_units`
--
ALTER TABLE `bld_units`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `bld_unit_cars`
--
ALTER TABLE `bld_unit_cars`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `bld_unit_owners`
--
ALTER TABLE `bld_unit_owners`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `bld_unit_tenants`
--
ALTER TABLE `bld_unit_tenants`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `transactions`
--
ALTER TABLE `transactions`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `units`
--
ALTER TABLE `units`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `bld_accounts`
--
ALTER TABLE `bld_accounts`
  ADD CONSTRAINT `FK_base_banks_TO_bld_accounts` FOREIGN KEY (`bank_id`) REFERENCES `base_banks` (`id`);

--
-- Constraints for table `bld_transactions`
--
ALTER TABLE `bld_transactions`
  ADD CONSTRAINT `FK_bld_accounts_TO_bld_transactions` FOREIGN KEY (`account_id`) REFERENCES `bld_accounts` (`id`),
  ADD CONSTRAINT `FK_bld_categories_TO_bld_transactions` FOREIGN KEY (`category_id`) REFERENCES `bld_categories` (`id`),
  ADD CONSTRAINT `FK_bld_units_TO_bld_transactions` FOREIGN KEY (`unit_id`) REFERENCES `bld_units` (`id`);

--
-- Constraints for table `bld_unit_cars`
--
ALTER TABLE `bld_unit_cars`
  ADD CONSTRAINT `FK_bld_unit_owners_TO_bld_unit_cars` FOREIGN KEY (`owner_id`) REFERENCES `bld_unit_owners` (`id`),
  ADD CONSTRAINT `FK_bld_unit_tenants_TO_bld_unit_cars` FOREIGN KEY (`tenant_id`) REFERENCES `bld_unit_tenants` (`id`),
  ADD CONSTRAINT `FK_bld_units_TO_bld_unit_cars` FOREIGN KEY (`unit_id`) REFERENCES `bld_units` (`id`);

--
-- Constraints for table `bld_unit_owners`
--
ALTER TABLE `bld_unit_owners`
  ADD CONSTRAINT `FK_bld_units_TO_bld_unit_owners` FOREIGN KEY (`unit_id`) REFERENCES `bld_units` (`id`);

--
-- Constraints for table `bld_unit_tenants`
--
ALTER TABLE `bld_unit_tenants`
  ADD CONSTRAINT `FK_bld_units_TO_bld_unit_tenants` FOREIGN KEY (`unit_id`) REFERENCES `bld_units` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
