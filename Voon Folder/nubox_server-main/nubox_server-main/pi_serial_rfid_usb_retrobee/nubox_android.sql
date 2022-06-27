-- phpMyAdmin SQL Dump
-- version 4.6.6deb5
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Jun 05, 2021 at 06:26 AM
-- Server version: 10.3.27-MariaDB-0+deb10u1
-- PHP Version: 7.3.27-1~deb10u1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `nubox_android`
--

-- --------------------------------------------------------

--
-- Table structure for table `db_ads_video`
--

CREATE TABLE `db_ads_video` (
  `id` int(11) NOT NULL,
  `video_url` varchar(255) NOT NULL,
  `type` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `db_ads_video`
--

INSERT INTO `db_ads_video` (`id`, `video_url`, `type`) VALUES
(287, 'http://192.168.0.2/videos/sleep.mp4', 'full'),
(288, 'http://192.168.0.2/videos/top_banner.mp4', 'banner');

-- --------------------------------------------------------

--
-- Table structure for table `db_motor_capacity`
--

CREATE TABLE `db_motor_capacity` (
  `motor_number` int(11) NOT NULL,
  `maximum_capacity` int(11) DEFAULT NULL,
  `time_created` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `db_motor_diagnose`
--

CREATE TABLE `db_motor_diagnose` (
  `id` int(11) NOT NULL,
  `motor_number` int(11) NOT NULL,
  `motor_jammed` tinyint(4) NOT NULL,
  `quarter_jammed` tinyint(4) NOT NULL,
  `event_time` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `db_payment_selection`
--

CREATE TABLE `db_payment_selection` (
  `id` int(11) NOT NULL,
  `machine_id` varchar(255) DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `password` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `db_payment_template`
--

CREATE TABLE `db_payment_template` (
  `payment_id` int(11) NOT NULL,
  `payment_method` varchar(30) NOT NULL,
  `time_created` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `db_payment_template`
--

INSERT INTO `db_payment_template` (`payment_id`, `payment_method`, `time_created`) VALUES
(1, 'cash_and_coin', '2020-11-19 02:09:58'),
(2, 'credit_card', '2020-11-19 02:09:58'),
(3, 'ewallet', '2020-11-19 02:11:38'),
(4, 'others', '2020-11-19 02:11:59'),
(9, 'encrypted_payment', '2020-11-19 02:11:59');

-- --------------------------------------------------------

--
-- Table structure for table `db_product`
--

CREATE TABLE `db_product` (
  `id` int(11) NOT NULL,
  `product_name` varchar(100) DEFAULT NULL,
  `price` float DEFAULT NULL,
  `second_pwp_price` float DEFAULT 0,
  `third_pwp_price` float DEFAULT 0,
  `product_image_url` varchar(500) DEFAULT NULL,
  `motor_number` int(11) DEFAULT NULL,
  `motor_label` varchar(10) DEFAULT NULL,
  `tray_number` int(11) DEFAULT NULL,
  `slot_number` int(11) DEFAULT NULL,
  `inventory` int(11) NOT NULL,
  `max_capacity` int(11) NOT NULL,
  `drop_sensor_enable` tinyint(1) NOT NULL,
  `quarter_turn_enable` tinyint(1) NOT NULL,
  `continue_order` tinyint(4) NOT NULL,
  `created_date` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `db_product`
--

INSERT INTO `db_product` (`id`, `product_name`, `price`, `second_pwp_price`, `third_pwp_price`, `product_image_url`, `motor_number`, `motor_label`, `tray_number`, `slot_number`, `inventory`, `max_capacity`, `drop_sensor_enable`, `quarter_turn_enable`, `continue_order`, `created_date`) VALUES
(12234, '-', 0, 0, 0, '', 1, 'A1', 1, 1, 0, 6, 1, 1, 0, '2021-06-05 05:48:40'),
(12235, '-', 0, 0, 0, '', 2, 'A2', 1, 2, 0, 6, 1, 1, 0, '2021-06-05 05:48:40'),
(12236, '-', 0, 0, 0, '', 3, 'A3', 1, 3, 0, 6, 1, 1, 0, '2021-06-05 05:48:40'),
(12237, '-', 0, 0, 0, '', 4, 'A4', 1, 4, 0, 6, 1, 1, 0, '2021-06-05 05:48:40'),
(12238, '-', 0, 0, 0, '', 5, 'A5', 1, 5, 0, 6, 1, 1, 0, '2021-06-05 05:48:40'),
(12239, '-', 0, 0, 0, '', 6, 'A6', 1, 6, 0, 6, 1, 1, 0, '2021-06-05 05:48:40'),
(12240, '-', 0, 0, 0, '', 7, 'A7', 1, 7, 0, 6, 1, 1, 0, '2021-06-05 05:48:40'),
(12241, '-', 0, 0, 0, '', 8, 'A8', 1, 8, 0, 6, 1, 1, 0, '2021-06-05 05:48:40'),
(12242, '-', 0, 0, 0, '', 9, 'A9', 1, 9, 0, 6, 1, 1, 0, '2021-06-05 05:48:40'),
(12243, '-', 0, 0, 0, '', 10, 'A10', 1, 10, 0, 6, 1, 1, 0, '2021-06-05 05:48:40'),
(12244, 'Julie Peanut Butter Cookie', 0.2, 0.2, 0.2, 'http://192.168.0.2/images/B1-Julie Peanut Butter Cookie.peg', 11, 'B1', 2, 1, 0, 6, 1, 1, 0, '2021-06-05 05:48:40'),
(12245, 'Lexus Chocolate', 0.2, 0.2, 0.2, 'http://192.168.0.2/images/B2-Lexus Chocolate.peg', 12, 'B2', 2, 2, 0, 6, 1, 1, 0, '2021-06-05 05:48:40'),
(12246, 'Lot 100 Frutube Gummy - Assorted ', 0.2, 0.2, 0.2, 'http://192.168.0.2/images/B3-Lot 100 Frutube Gummy - Assorted .peg', 13, 'B3', 2, 3, 0, 6, 1, 1, 0, '2021-06-05 05:48:40'),
(12247, 'Apollo Layer Cake Chocolate', 0.2, 0.2, 0.2, 'http://192.168.0.2/images/B4-Apollo Layer Cake Chocolate.jpg', 14, 'B4', 2, 4, 0, 6, 1, 1, 0, '2021-06-05 05:48:40'),
(12248, 'Apollo Layer Cake Pandan', 0.2, 0.2, 0.2, 'http://192.168.0.2/images/B5-Apollo Layer Cake Pandan.peg', 15, 'B5', 2, 5, 0, 6, 1, 1, 0, '2021-06-05 05:48:40'),
(12249, 'Kit Kat 4 Fingers', 0.2, 0.2, 0.2, 'http://192.168.0.2/images/B6-Kit Kat 4 Fingers.jpg', 16, 'B6', 2, 6, 0, 6, 1, 1, 0, '2021-06-05 05:48:40'),
(12250, 'Nabati Cheese', 0.2, 0, 0, 'http://192.168.0.2/images/B7-Nabati Cheese.jpg', 17, 'B7', 2, 7, 0, 6, 1, 1, 0, '2021-06-05 05:48:40'),
(12251, 'Nabati Cheese', 2.5, 0, 0, 'http://192.168.0.2/images/B8-Nabati Cheese.jpg', 18, 'B8', 2, 8, 0, 6, 1, 1, 0, '2021-06-05 05:48:40'),
(12252, 'Cream-O Vanilla', 2.5, 0, 0, 'http://192.168.0.2/images/B9-Cream-O Vanilla.jpg', 19, 'B9', 2, 9, 0, 6, 1, 1, 0, '2021-06-05 05:48:40'),
(12253, 'Cream-O Vanilla', 2.5, 0, 0, 'http://192.168.0.2/images/B10-Cream-O Vanilla.jpg', 20, 'B10', 2, 10, 0, 6, 1, 1, 0, '2021-06-05 05:48:40'),
(12254, 'Chipsmore Original', 2.5, 0, 0, 'http://192.168.0.2/images/C1-Chipsmore Original.jpg', 21, 'C1', 3, 1, 0, 6, 1, 1, 0, '2021-06-05 05:48:40'),
(12255, 'Chipsmore Original', 2.5, 0, 0, 'http://192.168.0.2/images/C2-Chipsmore Original.jpg', 22, 'C2', 3, 2, 0, 6, 1, 1, 0, '2021-06-05 05:48:40'),
(12256, 'Tiger Biscuit', 2.5, 0, 0, 'http://192.168.0.2/images/C3-Tiger Biscuit.jpg', 23, 'C3', 3, 3, 0, 6, 1, 1, 0, '2021-06-05 05:48:40'),
(12257, 'Tiger Biscuit', 2.5, 0, 0, 'http://192.168.0.2/images/C4-Tiger Biscuit.jpg', 24, 'C4', 3, 4, 0, 6, 1, 1, 0, '2021-06-05 05:48:40'),
(12258, 'Yeos Chrysanthemum Box', 2.5, 0, 0, 'http://192.168.0.2/images/C5-Yeos Chrysanthemum Box.jpg', 25, 'C5', 3, 5, 0, 6, 1, 1, 0, '2021-06-05 05:48:40'),
(12259, 'Yeos Chrysanthemum Box', 2.5, 0, 0, 'http://192.168.0.2/images/C6-Yeos Chrysanthemum Box.jpg', 26, 'C6', 3, 6, 0, 6, 1, 1, 0, '2021-06-05 05:48:40'),
(12260, 'Yeos Chrysanthemum Box', 2.5, 0, 0, 'http://192.168.0.2/images/C7-Yeos Chrysanthemum Box.jpg', 27, 'C7', 3, 7, 0, 6, 1, 1, 0, '2021-06-05 05:48:40'),
(12261, 'HomeSoy Box ', 2.5, 0, 0, 'http://192.168.0.2/images/C8-HomeSoy Box .peg', 28, 'C8', 3, 8, 0, 6, 1, 1, 0, '2021-06-05 05:48:40'),
(12262, 'HomeSoy Box ', 2.5, 0, 0, 'http://192.168.0.2/images/C9-HomeSoy Box .peg', 29, 'C9', 3, 9, 0, 6, 1, 1, 0, '2021-06-05 05:48:40'),
(12263, 'HomeSoy Box ', 2.5, 0, 0, 'http://192.168.0.2/images/C10-HomeSoy Box .peg', 30, 'C10', 3, 10, 0, 6, 1, 1, 0, '2021-06-05 05:48:40'),
(12264, 'Coca-Cola Can', 2.5, 0, 0, 'http://192.168.0.2/images/D1-Coca-Cola Can.jpg', 31, 'D1', 4, 1, 0, 6, 1, 1, 0, '2021-06-05 05:48:40'),
(12265, 'Coca-Cola Can', 2.5, 0, 0, 'http://192.168.0.2/images/D2-Coca-Cola Can.jpg', 32, 'D2', 4, 2, 0, 6, 1, 1, 0, '2021-06-05 05:48:40'),
(12266, 'Coca-Cola Can', 2.5, 0, 0, 'http://192.168.0.2/images/D3-Coca-Cola Can.jpg', 33, 'D3', 4, 3, 0, 6, 1, 1, 0, '2021-06-05 05:48:40'),
(12267, '100 Plus Can', 2.5, 0, 0, 'http://192.168.0.2/images/D4-100 Plus Can.jpg', 34, 'D4', 4, 4, 0, 6, 1, 1, 0, '2021-06-05 05:48:40'),
(12268, '100 Plus Can', 2.5, 0, 0, 'http://192.168.0.2/images/D5-100 Plus Can.jpg', 35, 'D5', 4, 5, 0, 6, 1, 1, 0, '2021-06-05 05:48:40'),
(12269, '100 Plus Can', 2.5, 0, 0, 'http://192.168.0.2/images/D6-100 Plus Can.jpg', 36, 'D6', 4, 6, 0, 6, 1, 1, 0, '2021-06-05 05:48:40'),
(12270, 'Red Bull Original Can', 2.5, 0, 0, 'http://192.168.0.2/images/D7-Red Bull Original Can.jpg', 37, 'D7', 4, 7, 0, 6, 1, 1, 0, '2021-06-05 05:48:40'),
(12271, 'Red Bull Original Can', 2.5, 0, 0, 'http://192.168.0.2/images/D8-Red Bull Original Can.jpg', 38, 'D8', 4, 8, 0, 6, 1, 1, 0, '2021-06-05 05:48:40'),
(12272, 'Mineral Water Bottle', 2.5, 0, 0, 'http://192.168.0.2/images/D9-Mineral Water Bottle.jpg', 39, 'D9', 4, 9, 0, 6, 1, 1, 0, '2021-06-05 05:48:40'),
(12273, 'Mineral Water Bottle', 2.5, 0, 0, 'http://192.168.0.2/images/D10-Mineral Water Bottle.jpg', 40, 'D10', 4, 10, 0, 6, 1, 1, 0, '2021-06-05 05:48:40'),
(12274, 'Dutch Lady Original Box', 2.5, 0, 0, 'http://192.168.0.2/images/E1-Dutch Lady Original Box.png', 41, 'E1', 5, 1, 0, 6, 1, 1, 0, '2021-06-05 05:48:40'),
(12275, 'Dutch Lady Original Box', 2.5, 0, 0, 'http://192.168.0.2/images/E2-Dutch Lady Original Box.png', 42, 'E2', 5, 2, 0, 6, 1, 1, 0, '2021-06-05 05:48:40'),
(12276, 'Dutch Lady Chocolate Box', 2.5, 0, 0, 'http://192.168.0.2/images/E3-Dutch Lady Chocolate Box.png', 43, 'E3', 5, 3, 0, 6, 1, 1, 0, '2021-06-05 05:48:40'),
(12277, 'Yeos Cincau ', 2.5, 0, 0, 'http://192.168.0.2/images/E4-Yeos Cincau .peg', 44, 'E4', 5, 4, 0, 6, 1, 1, 0, '2021-06-05 05:48:40'),
(12278, 'Sprite Can', 2.5, 0, 0, 'http://192.168.0.2/images/E5-Sprite Can.jpg', 45, 'E5', 5, 5, 0, 6, 1, 1, 0, '2021-06-05 05:48:40'),
(12279, 'Sprite Can ', 2.5, 0, 0, 'http://192.168.0.2/images/E6-Sprite Can .jpg', 46, 'E6', 5, 6, 0, 6, 1, 1, 0, '2021-06-05 05:48:40'),
(12280, 'Nescafe Original', 2.5, 0, 0, 'http://192.168.0.2/images/E7-Nescafe Original.jpg', 47, 'E7', 5, 7, 0, 6, 1, 1, 0, '2021-06-05 05:48:40'),
(12281, 'Nescafe Original ', 2.5, 0, 0, 'http://192.168.0.2/images/E8-Nescafe Original .jpg', 48, 'E8', 5, 8, 0, 6, 1, 1, 0, '2021-06-05 05:48:40'),
(12282, 'Nescafe Mocha', 2.5, 0, 0, 'http://192.168.0.2/images/E9-Nescafe Mocha.jpg', 49, 'E9', 5, 9, 0, 6, 1, 1, 0, '2021-06-05 05:48:40'),
(12283, 'Nescafe Latte', 2.5, 0, 0, 'http://192.168.0.2/images/E10-Nescafe Latte.jpg', 50, 'E10', 5, 10, 0, 6, 1, 1, 0, '2021-06-05 05:48:40'),
(12284, 'Milo Can', 2.5, 0, 0, 'http://192.168.0.2/images/F1-Milo Can.jpg', 51, 'F1', 6, 1, 0, 6, 1, 1, 0, '2021-06-05 05:48:40'),
(12285, 'Milo Can', 2.5, 0, 0, 'http://192.168.0.2/images/F2-Milo Can.jpg', 52, 'F2', 6, 2, 0, 6, 1, 1, 0, '2021-06-05 05:48:40'),
(12286, 'Milo Can', 2.5, 0, 0, 'http://192.168.0.2/images/F3-Milo Can.jpg', 53, 'F3', 6, 3, 0, 6, 1, 1, 0, '2021-06-05 05:48:40'),
(12287, 'Tropicana Twister Orange ', 2.5, 0, 0, 'http://192.168.0.2/images/F4-Tropicana Twister Orange .jpg', 54, 'F4', 6, 4, 0, 6, 1, 1, 0, '2021-06-05 05:48:40'),
(12288, 'Tropicana Twister Orange', 2.5, 0, 0, 'http://192.168.0.2/images/F5-Tropicana Twister Orange.jpg', 55, 'F5', 6, 5, 0, 6, 1, 1, 0, '2021-06-05 05:48:40'),
(12289, 'Fruit 10 Aloe Vera With Apple Juice', 2.5, 0, 0, 'http://192.168.0.2/images/F6-Fruit 10 Aloe Vera With Apple Juice.jpg', 56, 'F6', 6, 6, 0, 6, 1, 1, 0, '2021-06-05 05:48:40'),
(12290, 'Fruit 10 Aloe Vera With Lychee Juice', 2.5, 0, 0, 'http://192.168.0.2/images/F7-Fruit 10 Aloe Vera With Lychee Juice.jpg', 57, 'F7', 6, 7, 0, 6, 1, 1, 0, '2021-06-05 05:48:40'),
(12291, 'Green Home Green Tea', 2.5, 0, 0, 'http://192.168.0.2/images/F8-Green Home Green Tea.jpg', 58, 'F8', 6, 8, 0, 6, 1, 1, 0, '2021-06-05 05:48:40'),
(12292, 'Green Home Green Tea', 2.5, 0, 0, 'http://192.168.0.2/images/F9-Green Home Green Tea.jpg', 59, 'F9', 6, 9, 0, 6, 1, 1, 0, '2021-06-05 05:48:40'),
(12293, 'Jasmine Honey Tea', 2.5, 0, 0, 'http://192.168.0.2/images/F10-Jasmine Honey Tea.jpg', 60, 'F10', 6, 10, 0, 6, 1, 1, 0, '2021-06-05 05:48:40');

-- --------------------------------------------------------

--
-- Table structure for table `db_promotion_image`
--

CREATE TABLE `db_promotion_image` (
  `id` int(11) NOT NULL,
  `image_url` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `db_rfid_card`
--

CREATE TABLE `db_rfid_card` (
  `id` int(11) NOT NULL,
  `rfid_code` varchar(100) NOT NULL,
  `discount_rate_percent` int(11) NOT NULL,
  `status` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `db_rfid_card`
--

INSERT INTO `db_rfid_card` (`id`, `rfid_code`, `discount_rate_percent`, `status`) VALUES
(1, '0006115436', 20, 'active'),
(2, '0007382956', 20, 'active'),
(3, '0007440894', 20, 'active'),
(4, '0007392109', 20, 'active'),
(5, '0006577041', 20, 'active'),
(6, '0007406701', 20, 'active'),
(7, '0007292351', 20, 'active'),
(8, '0007420843', 20, 'active'),
(9, '0007454797', 20, 'active'),
(10, '0007471833', 20, 'active'),
(11, '0007304823', 20, 'active'),
(12, '0007446963', 20, 'active'),
(13, '0007400789', 20, 'active'),
(14, '0007221513', 20, 'active'),
(15, '0007451996', 20, 'active'),
(16, '0007291943', 20, 'active'),
(17, '0007425067', 20, 'active'),
(18, '0007308815', 20, 'active'),
(19, '0007472298', 20, 'active'),
(20, '0007364629', 20, 'active');

-- --------------------------------------------------------

--
-- Table structure for table `db_row_and_column`
--

CREATE TABLE `db_row_and_column` (
  `id` int(11) NOT NULL,
  `tray_number` int(4) NOT NULL,
  `slot_number` int(4) NOT NULL,
  `time_created` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `db_row_and_column`
--

INSERT INTO `db_row_and_column` (`id`, `tray_number`, `slot_number`, `time_created`) VALUES
(1775, 1, 10, '2021-06-05 05:48:19'),
(1776, 2, 10, '2021-06-05 05:48:19'),
(1777, 3, 10, '2021-06-05 05:48:19'),
(1778, 4, 10, '2021-06-05 05:48:19'),
(1779, 5, 10, '2021-06-05 05:48:19'),
(1780, 6, 10, '2021-06-05 05:48:19');

-- --------------------------------------------------------

--
-- Table structure for table `db_row_in_machine`
--

CREATE TABLE `db_row_in_machine` (
  `id` int(11) NOT NULL,
  `tray_number` int(11) NOT NULL,
  `in_machine` int(11) NOT NULL,
  `date_modified` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `db_row_in_machine`
--

INSERT INTO `db_row_in_machine` (`id`, `tray_number`, `in_machine`, `date_modified`) VALUES
(55, 1, 1, '2021-05-16 11:03:05'),
(56, 2, 1, '2021-05-16 11:03:05'),
(57, 3, 1, '2021-05-16 11:03:05'),
(58, 4, 1, '2021-05-16 11:03:05'),
(59, 5, 1, '2021-05-16 11:03:05'),
(60, 6, 1, '2021-05-16 11:03:05');

-- --------------------------------------------------------

--
-- Table structure for table `db_row_step`
--

CREATE TABLE `db_row_step` (
  `id` int(11) NOT NULL,
  `tray_number` int(11) NOT NULL,
  `step_distance` int(11) NOT NULL,
  `date_modified` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `db_row_step`
--

INSERT INTO `db_row_step` (`id`, `tray_number`, `step_distance`, `date_modified`) VALUES
(25, 1, 2130, '2021-05-16 17:06:04'),
(26, 2, 1800, '2021-05-16 17:06:04'),
(27, 3, 1480, '2021-05-16 17:06:04'),
(28, 4, 1180, '2021-05-16 17:06:04'),
(29, 5, 880, '2021-05-16 17:06:04'),
(30, 6, 560, '2021-05-16 17:06:04');

-- --------------------------------------------------------

--
-- Table structure for table `db_sales_record`
--

CREATE TABLE `db_sales_record` (
  `id` int(11) NOT NULL,
  `transaction_serial` varchar(100) NOT NULL,
  `slot_number` varchar(50) NOT NULL,
  `price` float NOT NULL,
  `quantity` int(11) NOT NULL,
  `product_name` varchar(100) NOT NULL,
  `drop_sensor_status` tinyint(4) NOT NULL,
  `payment_method` int(11) NOT NULL,
  `self_defined_payment_method` int(11) NOT NULL,
  `order_number` varchar(100) DEFAULT NULL,
  `machine_id` varchar(100) NOT NULL,
  `product_url` varchar(50) NOT NULL,
  `report_status` varchar(50) NOT NULL,
  `date_time` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `db_sales_record`
--

INSERT INTO `db_sales_record` (`id`, `transaction_serial`, `slot_number`, `price`, `quantity`, `product_name`, `drop_sensor_status`, `payment_method`, `self_defined_payment_method`, `order_number`, `machine_id`, `product_url`, `report_status`, `date_time`) VALUES
(1, '', 'A4', 0.1, 1, 'Tomato Twisties', 0, 1, -1, 'NVMMAA100001.20201120150439', 'NVMMAA100001', 'http://192.168.0.2/images/4-Tomato Twisties.jpg', 'offline', '2020-11-29 20:33:47'),
(2, '', 'B4', 0.1, 1, 'Chicken Twisties', 1, 1, -1, 'NVMMAA100001.20201120150527', 'NVMMAA100001', 'http://192.168.0.2/images/9-Chicken Twisties.jpg', 'offline', '2020-11-29 20:34:34'),
(3, 'NVMMAA100001.20201202152159', 'B2', 0.1, 1, 'Chicken Twisties', 0, 3, 6, 'NVMMAA100001.20201120145919', 'NVMMAA100001', 'http://192.168.0.2/images/7-Chicken Twisties.jpg', 'online', '2020-11-29 20:28:27'),
(4, 'NVMMAA100001.20201202173532', 'B4', 0.1, 1, 'Chicken Twisties', 0, 3, 6, 'NVMMAA100001.20201202173557', 'NVMMAA100001', 'http://192.168.0.2/images/9-Chicken Twisties.jpg', 'online', '2020-11-29 21:22:27'),
(5, '', 'C2', 0.1, 1, '', 0, 1, -1, 'NVMMAA100001.20201120145028', 'NVMMAA100001', '', 'online', '2020-11-30 05:36:25'),
(6, 'NVMMAA100001.20201202184344', 'C6', 0.1, 1, '', 0, 3, 4, 'NVMMAA100001.20201202184305', 'NVMMAA100001', '', 'online', '2020-12-02 18:44:17'),
(7, 'NVMMAA100001.20201202184845', 'A1', 0.1, 1, 'Chicken Twisties', 0, 3, 4, 'NVMMAA100001.20201202184807', 'NVMMAA100001', 'http://192.168.0.2/images/1-Chicken Twisties.jpg', 'online', '2020-12-02 18:49:18'),
(8, 'NVMMAA100001.20201202184913', 'A2', 0.1, 1, 'BBQ Twisties', 0, 3, 5, 'NVMMAA100001.20201202184840', 'NVMMAA100001', 'http://192.168.0.2/images/2-BBQ Twisties.jpg', 'online', '2020-12-02 18:49:52'),
(9, 'NVMMAA100001.20201202184942', 'A3', 0.1, 1, 'Cheese Twisties', 0, 3, 6, 'NVMMAA100001.20201202184910', 'NVMMAA100001', 'http://192.168.0.2/images/3-Cheese Twisties.jpg', 'online', '2020-12-02 18:50:21'),
(10, 'NVMMAA100001.20201202185034', 'A4', 0.1, 1, 'Tomato Twisties', 0, 3, 6, 'NVMMAA100001.20201202185000', 'NVMMAA100001', 'http://192.168.0.2/images/4-Tomato Twisties.jpg', 'online', '2020-12-02 18:51:11'),
(11, 'NVMMAA100001.20201202185119', 'B4', 0.1, 1, 'Chicken Twisties', 0, 3, 7, 'NVMMAA100001.20201202185044', 'NVMMAA100001', 'http://192.168.0.2/images/9-Chicken Twisties.jpg', 'online', '2020-12-02 18:51:56'),
(12, '', 'E6', 0.1, 1, '', 0, 1, -1, 'NVMMAA100001.20201120145311', 'NVMMAA100001', '', 'online', '2020-12-02 18:22:16'),
(13, '', 'E4', 0.1, 1, '', 1, 1, -1, 'NVMMAA100001.20201120145341', 'NVMMAA100001', '', 'online', '2020-12-02 18:22:46'),
(14, 'NVMMAA100001.20201202192346', 'B3', 0.1, 1, 'Chicken Twisties', 0, 3, 4, 'NVMMAA100001.20201120145156', 'NVMMAA100001', 'http://192.168.0.2/images/8-Chicken Twisties.jpg', 'online', '2020-12-02 18:20:59'),
(15, '', 'A5', 0.1, 1, 'Rice Crackers', 0, 1, -1, 'NVMMAA100001.20201120145816', 'NVMMAA100001', 'http://192.168.0.2/images/5-Rice Crackers.jpg', 'online', '2020-12-02 18:27:23'),
(16, '', 'B2', 0.1, 1, 'Chicken Twisties', 1, 1, -1, 'NVMMAA100001.20201120144925', 'NVMMAA100001', 'http://192.168.0.2/images/7-Chicken Twisties.jpg', 'offline', '2020-12-02 18:18:32'),
(17, '', 'B2', 0.1, 1, 'Chicken Twisties', 1, 1, -1, 'NVMMAA100001.20201120144940', 'NVMMAA100001', 'http://192.168.0.2/images/7-Chicken Twisties.jpg', 'offline', '2020-12-02 18:18:46'),
(18, '', 'B2', 0.1, 1, 'Chicken Twisties', 0, 1, -1, 'NVMMAA100001.20201121042737', 'NVMMAA100001', 'http://192.168.0.2/images/7-Chicken Twisties.jpg', 'online', '2020-12-03 07:56:44'),
(19, 'NVMMAA100001.20201203094302', 'B1', 0.1, 1, 'Chiken Twisties', 0, 3, 4, 'NVMMAA100001.20201121042933', 'NVMMAA100001', 'http://192.168.0.2/images/6-Chiken Twisties.jpg', 'online', '2020-12-03 07:58:40'),
(20, '', 'B5', 0.1, 1, 'Chicken Twisties', 1, 1, -1, 'NVMMAA100001.20201121043024', 'NVMMAA100001', 'http://192.168.0.2/images/10-Chicken Twisties.jpg', 'online', '2020-12-03 07:59:31'),
(21, '', 'B5', 0.1, 1, 'Chicken Twisties', 0, 1, -1, 'NVMMAA100001.20201121043220', 'NVMMAA100001', 'http://192.168.0.2/images/10-Chicken Twisties.jpg', 'online', '2020-12-03 08:01:27'),
(22, '', 'F10', 0.1, 1, '', 0, 1, -1, 'NVMMAA100001.20201121043632', 'NVMMAA100001', '', 'online', '2020-12-03 08:05:39'),
(23, '', 'C1', 0.1, 1, '', 0, 1, -1, 'NVMMAA100001.20201121055223', 'NVMMAA100001', '', 'online', '2020-12-03 09:21:30'),
(24, '', 'C5', 0.1, 1, '', 0, 1, -1, 'NVMMAA100001.20201121055447', 'NVMMAA100001', '', 'online', '2020-12-03 09:23:53'),
(25, '', 'C3', 0.1, 1, '', 0, 1, -1, 'NVMMAA100001.20201121055511', 'NVMMAA100001', '', 'online', '2020-12-03 09:24:17'),
(26, '', 'B3', 0.1, 1, 'Chicken Twisties', 0, 1, -1, 'NVMMAA100001.20201203115254', 'NVMMAA100001', 'http://192.168.0.2/images/8-Chicken Twisties.jpg', 'online', '2020-12-03 10:08:11'),
(27, '', 'A2', 0.1, 1, 'BBQ Twisties', 0, 1, -1, 'NVMMAA100001.20201203124714', 'NVMMAA100001', 'http://192.168.0.2/images/2-BBQ Twisties.jpg', 'online', '2020-12-03 11:02:31'),
(28, '', 'A3', 0.1, 1, 'Cheese Twisties', 0, 1, -1, 'NVMMAA100001.20201203185124', 'NVMMAA100001', 'http://192.168.0.2/images/3-Cheese Twisties.jpg', 'online', '2020-12-03 16:22:53'),
(29, 'NVMMAA100001.20201203185234', 'D4', 0.1, 1, '', 1, 3, 4, 'NVMMAA100001.20201203185249', 'NVMMAA100001', '', 'online', '2020-12-03 16:24:18'),
(30, 'NVMMAA100001.20201203185257', 'B2', 0.1, 1, 'Chicken Twisties', 0, 3, 4, 'NVMMAA100001.20201203185316', 'NVMMAA100001', 'http://192.168.0.2/images/7-Chicken Twisties.jpg', 'online', '2020-12-03 16:24:44'),
(31, '', 'A1', 0.1, 1, 'Chicken Twisties', 0, 1, -1, 'NVMMAA100001.20201204103457', 'NVMMAA100001', 'http://192.168.0.2/images/1-Chicken Twisties.jpg', 'online', '2020-12-04 08:06:26'),
(32, '', 'A4', 0.1, 1, 'Tomato Twisties', 0, 1, -1, 'NVMMAA100001.20201204103512', 'NVMMAA100001', 'http://192.168.0.2/images/4-Tomato Twisties.jpg', 'online', '2020-12-04 08:06:41'),
(33, '', 'A4', 0.1, 1, 'Tomato Twisties', 0, 1, -1, 'NVMMAA100001.20201204103527', 'NVMMAA100001', 'http://192.168.0.2/images/4-Tomato Twisties.jpg', 'online', '2020-12-04 08:06:55'),
(34, 'NVMMAA100001.20201204104208', 'B4', 0.1, 1, 'Chicken Twisties', 0, 3, 5, 'NVMMAA100001.20201204104239', 'NVMMAA100001', 'http://192.168.0.2/images/9-Chicken Twisties.jpg', 'online', '2020-12-04 07:21:29'),
(35, 'NVMMAA100001.20201204104250', 'B4', 0.1, 1, 'Chicken Twisties', 0, 3, 4, 'NVMMAA100001.20201204104311', 'NVMMAA100001', 'http://192.168.0.2/images/9-Chicken Twisties.jpg', 'online', '2020-12-04 07:22:01'),
(36, 'NVMMAA100001.20201204104306', 'B5', 0.1, 1, 'Chicken Twisties', 0, 3, 6, 'NVMMAA100001.20201204104450', 'NVMMAA100001', 'http://192.168.0.2/images/10-Chicken Twisties.jpg', 'online', '2020-12-04 07:23:40'),
(37, 'NVMMAA100001.20201204104453', 'B5', 0.1, 1, 'Chicken Twisties', 0, 3, 7, 'NVMMAA100001.20201204104554', 'NVMMAA100001', 'http://192.168.0.2/images/10-Chicken Twisties.jpg', 'online', '2020-12-04 07:24:44'),
(38, '', 'B1', 0.1, 1, 'Chiken Twisties', 0, 1, -1, 'NVMMAA100001.20201120144927', 'NVMMAA100001', 'http://192.168.0.2/images/6-Chiken Twisties.jpg', 'offline', '2020-12-05 10:18:33'),
(39, '', 'B1', 0.1, 1, 'Chiken Twisties', 0, 1, -1, 'NVMMAA100001.20201120144943', 'NVMMAA100001', 'http://192.168.0.2/images/6-Chiken Twisties.jpg', 'offline', '2020-12-05 10:18:48'),
(40, '', 'B1', 0.1, 1, 'Chiken Twisties', 0, 1, -1, 'NVMMAA100001.20201120145002', 'NVMMAA100001', 'http://192.168.0.2/images/6-Chiken Twisties.jpg', 'online', '2020-12-05 10:19:07'),
(41, '', 'D6', 0.1, 1, '', 1, 1, -1, 'NVMMAA100001.20201205141657', 'NVMMAA100001', '', 'online', '2020-12-05 10:20:44'),
(42, 'NVMMAA100001.20201205141708', 'A5', 0.1, 1, 'Rice Crackers', 0, 3, 4, 'NVMMAA100001.20201205141728', 'NVMMAA100001', 'http://192.168.0.2/images/5-Rice Crackers.jpg', 'online', '2020-12-05 10:21:16'),
(43, '', 'A1', 0.1, 1, 'Chicken Twisties', 0, 1, -1, 'NVMMAA100001.20201205144719', 'NVMMAA100001', 'http://192.168.0.2/images/1-Chicken Twisties.jpg', 'online', '2020-12-05 10:51:07'),
(44, '', 'A1', 0.1, 1, 'Chicken Twisties', 0, 1, -1, 'NVMMAA100001.20201205144734', 'NVMMAA100001', 'http://192.168.0.2/images/1-Chicken Twisties.jpg', 'online', '2020-12-05 10:51:21'),
(45, '', 'A3', 0.1, 1, 'Cheese Twisties', 0, 1, -1, 'NVMMAA100001.20201207103135', 'NVMMAA100001', 'http://192.168.0.2/images/3-Cheese Twisties.jpg', 'online', '2020-12-07 05:54:54'),
(46, '', 'C6', 0.1, 1, '', 1, 1, -1, 'NVMMAA100001.20201207103547', 'NVMMAA100001', '', 'online', '2020-12-07 05:59:07'),
(47, '', 'A2', 0.1, 1, 'BBQ Twisties', 0, 1, -1, 'NVMMAA100001.20201207104551', 'NVMMAA100001', 'http://192.168.0.2/images/2-BBQ Twisties.jpg', 'online', '2020-12-07 06:09:10'),
(48, '', 'B5', 0.1, 1, 'Chicken Twisties', 1, 1, -1, 'NVMMAA100001.20201207150246', 'NVMMAA100001', 'http://192.168.0.2/images/10-Chicken Twisties.jpg', 'offline', '2020-12-07 10:26:05'),
(49, '', 'A3', 0.1, 1, 'Cheese Twisties', 0, 1, -1, 'NVMMAA100001.20201207150404', 'NVMMAA100001', 'http://192.168.0.2/images/3-Cheese Twisties.jpg', 'offline', '2020-12-07 10:27:23'),
(50, '', 'B4', 0.1, 1, 'Chicken Twisties', 0, 1, -1, 'NVMMAA100001.20201120145115', 'NVMMAA100001', 'http://192.168.0.2/images/9-Chicken Twisties.jpg', 'offline', '2020-12-07 11:08:58'),
(51, '', 'B2', 0.1, 1, '', 1, 1, -1, 'NVMMAA100001.20201209110137', 'NVMMAA100001', 'http://192.168.0.2/images/7-.jpg', 'offline', '2020-12-09 05:38:27'),
(52, '', 'B3', 0.1, 1, '', 1, 1, -1, 'NVMMAA100001.20201209110312', 'NVMMAA100001', 'http://192.168.0.2/images/8-.jpg', 'offline', '2020-12-09 05:40:02'),
(53, '', 'A3', 0.1, 1, '', 1, 2, 0, 'NVMMAA100001.20201215140354', 'NVMMAA100001', 'http://192.168.0.2/images/3-.jpg', 'online', '2020-12-15 05:02:53'),
(54, '', 'B4', 0.1, 1, '', 1, 2, 0, 'NVMMAA100001.20201215140501', 'NVMMAA100001', 'http://192.168.0.2/images/9-.jpg', 'online', '2020-12-15 05:04:00'),
(55, '', 'A1', 0.1, 1, '', 1, 2, 0, 'NVMMAA100001.20201215140536', 'NVMMAA100001', 'http://192.168.0.2/images/1-.jpg', 'online', '2020-12-15 05:04:34'),
(56, '', 'A1', 0.1, 1, '', 0, 2, 0, 'NVMMAA100001.20201215140755', 'NVMMAA100001', 'http://192.168.0.2/images/1-.jpg', 'online', '2020-12-15 05:06:54'),
(57, '', 'D2', 0.1, 1, '', 0, 2, 0, 'NVMMAA100001.20201215140916', 'NVMMAA100001', 'http://192.168.0.2/images/27-.jpg', 'online', '2020-12-15 05:08:15'),
(58, 'NVMMAA100001.20201215141109', 'D3', 0.1, 1, '', 0, 3, 4, 'NVMMAA100001.20201215141118', 'NVMMAA100001', 'http://192.168.0.2/images/28-.jpg', 'online', '2020-12-15 05:10:17'),
(59, '', 'A2', 0.1, 1, '', 0, 2, 0, 'NVMMAA100001.20201215141209', 'NVMMAA100001', 'http://192.168.0.2/images/2-.jpg', 'online', '2020-12-15 05:11:08'),
(60, '', 'A3', 0.1, 1, '', 0, 1, -1, 'NVMMAA100001.20201120144940', 'NVMMAA100001', 'http://192.168.0.2/images/3-.jpg', 'offline', '2020-12-15 05:18:47'),
(61, '', 'A1', 0.1, 1, '', 0, 1, -1, 'NVMMAA100001.20201224145459', 'NVMMAA100001', 'http://192.168.0.2/images/1-.jpg', 'online', '2020-12-24 01:30:05'),
(62, '', 'B10', 0.1, 1, '', 0, 1, -1, 'NVMMAA100001.20201224145520', 'NVMMAA100001', 'http://192.168.0.2/images/15-.jpg', 'online', '2020-12-24 01:30:26'),
(63, '', 'B6', 0.1, 1, '', 1, 1, -1, 'NVMMAA100001.20201224145550', 'NVMMAA100001', 'http://192.168.0.2/images/11-.jpg', 'online', '2020-12-24 01:30:56'),
(64, 'NVMMAA100001.20201224154344', 'A2', 0.1, 1, '', 0, 3, 7, 'NVMMAA100001.20201224154422', 'NVMMAA100001', 'http://192.168.0.2/images/2-.jpg', 'online', '2020-12-24 01:29:54'),
(65, 'NVMMAA100001.20201224154515', 'B2', 0.1, 1, '', 0, 3, 4, 'NVMMAA100001.20201224154532', 'NVMMAA100001', 'http://192.168.0.2/images/7-.jpg', 'online', '2020-12-24 01:31:04'),
(66, 'NVMMAA100001.20201224154704', 'A4', 0.1, 1, '', 0, 3, 6, 'NVMMAA100001.20201224154747', 'NVMMAA100001', 'http://192.168.0.2/images/4-.jpg', 'online', '2020-12-24 01:33:19'),
(67, 'NVMMAA100001.20201224154821', 'D5', 0.1, 1, '', 1, 3, 6, 'NVMMAA100001.20201224154848', 'NVMMAA100001', 'http://192.168.0.2/images/30-.jpg', 'online', '2020-12-24 01:34:19'),
(68, '', 'A3', 0.1, 1, 'Robot', 0, 1, -1, 'NVMMAA100001.20210112111036', 'NVMMAA100001', '', 'offline', '2021-01-11 17:18:51'),
(69, '', 'A3', 0.1, 1, 'Robot', 0, 1, -1, 'NVMMAA100001.20210112111104', 'NVMMAA100001', '', 'online', '2021-01-11 17:19:19'),
(70, '', 'A3', 0.1, 1, 'Robot', 0, 1, -1, 'NVMMAA100001.20210112111233', 'NVMMAA100001', '', 'online', '2021-01-11 17:20:49'),
(71, '', 'B3', 0.1, 1, '', 0, 1, -1, 'NVMMAA100001.20210112130748', 'NVMMAA100001', '', 'online', '2021-01-11 17:19:03'),
(72, '', 'B3', 0.1, 1, '', 0, 2, 0, 'NVMMAA100001.20210112130836', 'NVMMAA100001', '', 'online', '2021-01-11 17:19:50'),
(73, '', 'A5', 0.2, 1, 'Hello World', 0, 1, -1, 'NVMMAA100001.20210112131703', 'NVMMAA100001', 'http://192.168.0.2/images/A5-Hello World.jpg', 'online', '2021-01-11 17:28:17'),
(74, '', 'D1', 0.1, 1, '', 0, 1, -1, 'NVMMAA100001.20210112131721', 'NVMMAA100001', '', 'online', '2021-01-11 17:28:35'),
(75, '', 'D1', 0.1, 1, '', 0, 1, -1, 'NVMMAA100001.20210112131758', 'NVMMAA100001', '', 'online', '2021-01-11 17:29:12'),
(76, '', 'D10', 0.1, 1, 'Wire', 0, 1, -1, 'NVMMAA100001.20210112131849', 'NVMMAA100001', 'http://192.168.0.2/images/D10-Wire.jpg', 'online', '2021-01-11 17:30:04'),
(77, '', 'D10', 0.1, 1, 'Wire', 0, 1, -1, 'NVMMAA100001.20210112131924', 'NVMMAA100001', 'http://192.168.0.2/images/D10-Wire.jpg', 'online', '2021-01-11 17:30:38'),
(78, '', 'D2', 0.1, 1, '', 0, 1, -1, 'NVMMAA100001.20210112131957', 'NVMMAA100001', '', 'online', '2021-01-11 17:31:12'),
(79, '', 'C3', 0.1, 1, '', 0, 1, -1, 'NVMMAA100001.20210112132025', 'NVMMAA100001', '', 'online', '2021-01-11 17:31:39'),
(80, '', 'D3', 0.1, 1, '', 0, 1, -1, 'NVMMAA100001.20210112132047', 'NVMMAA100001', '', 'online', '2021-01-11 17:32:01'),
(81, '', 'D5', 0.1, 1, '', 0, 1, -1, 'NVMMAA100001.20210112132121', 'NVMMAA100001', '', 'online', '2021-01-11 17:32:35'),
(82, '', 'D5', 0.1, 1, '', 0, 1, -1, 'NVMMAA100001.20210112132149', 'NVMMAA100001', '', 'online', '2021-01-11 17:33:04'),
(83, '', 'D5', 0.1, 1, '', 0, 1, -1, 'NVMMAA100001.20210112132216', 'NVMMAA100001', '', 'online', '2021-01-11 17:33:30'),
(84, '', 'D2', 0.1, 1, '', 0, 1, -1, 'NVMMAA100001.20210112132238', 'NVMMAA100001', '', 'online', '2021-01-11 17:33:53'),
(85, '', 'D7', 0.1, 1, '', 0, 1, -1, 'NVMMAA100001.20210112132316', 'NVMMAA100001', '', 'online', '2021-01-11 17:34:30'),
(86, '', 'B6', 0.1, 1, '', 0, 1, -1, 'NVMMAA100001.20210112132342', 'NVMMAA100001', '', 'online', '2021-01-11 17:34:56'),
(87, '', 'E7', 0.1, 1, '', 0, 1, -1, 'NVMMAA100001.20210112132418', 'NVMMAA100001', '', 'online', '2021-01-11 17:35:32'),
(88, '', 'B4', 0.1, 1, '', 0, 1, -1, 'NVMMAA100001.20210112133919', 'NVMMAA100001', '', 'online', '2021-01-11 17:50:33'),
(89, '', 'B4', 0.1, 1, '', 0, 1, -1, 'NVMMAA100001.20210112133936', 'NVMMAA100001', '', 'online', '2021-01-11 17:50:50'),
(90, '', 'A1', 1.6, 1, '100 Plus @', 1, 1, -1, 'NVMMAA100001.20210112134416', 'NVMMAA100001', 'http://192.168.0.2/images/A1-100 Plus @.jpg', 'online', '2021-01-11 17:55:30'),
(91, '', 'B3', 0.1, 1, '', 1, 1, -1, 'NVMMAA100001.20210112134500', 'NVMMAA100001', '', 'online', '2021-01-11 17:56:14'),
(92, '', 'B3', 0.1, 1, '', 1, 1, -1, 'NVMMAA100001.20210112134536', 'NVMMAA100001', '', 'online', '2021-01-11 17:56:51'),
(93, '', 'B3', 0.1, 1, '', 1, 1, -1, 'NVMMAA100001.20210112134603', 'NVMMAA100001', '', 'online', '2021-01-11 17:57:17'),
(94, '', 'B3', 0.1, 1, '', 1, 1, -1, 'NVMMAA100001.20210112134616', 'NVMMAA100001', '', 'online', '2021-01-11 17:57:30'),
(95, '', 'B3', 0.1, 1, '', 1, 1, -1, 'NVMMAA100001.20210112134639', 'NVMMAA100001', '', 'online', '2021-01-11 17:57:53'),
(96, '', 'B3', 0.1, 1, '', 1, 1, -1, 'NVMMAA100001.20210112134652', 'NVMMAA100001', '', 'online', '2021-01-11 17:58:06'),
(97, '', 'B3', 0.1, 1, '', 1, 1, -1, 'NVMMAA100001.20210112134728', 'NVMMAA100001', '', 'online', '2021-01-11 17:58:43'),
(98, '', 'C7', 0.1, 1, '', 0, 1, -1, 'NVMMAA100001.20210112134751', 'NVMMAA100001', '', 'online', '2021-01-11 17:59:05'),
(99, '', 'C7', 0.1, 1, '', 0, 1, -1, 'NVMMAA100001.20210112134837', 'NVMMAA100001', '', 'online', '2021-01-11 17:59:51'),
(100, '', 'C7', 0.1, 1, '', 0, 1, -1, 'NVMMAA100001.20210112134859', 'NVMMAA100001', '', 'online', '2021-01-11 18:00:13'),
(101, '', 'B3', 0.1, 1, '', 1, 1, -1, 'NVMMAA100001.20210112134911', 'NVMMAA100001', '', 'online', '2021-01-11 18:00:25'),
(102, '', 'C7', 0.1, 1, '', 0, 1, -1, 'NVMMAA100001.20210112134926', 'NVMMAA100001', '', 'online', '2021-01-11 18:00:40'),
(103, '', 'C7', 0.1, 1, '', 0, 1, -1, 'NVMMAA100001.20210112134956', 'NVMMAA100001', '', 'online', '2021-01-11 18:01:11'),
(104, '', 'C7', 0.1, 1, '', 0, 1, -1, 'NVMMAA100001.20210112135012', 'NVMMAA100001', '', 'online', '2021-01-11 18:01:26'),
(105, '', 'B3', 0.1, 1, '', 1, 1, -1, 'NVMMAA100001.20210112135021', 'NVMMAA100001', '', 'online', '2021-01-11 18:01:35'),
(106, '', 'B3', 0.1, 1, '', 1, 1, -1, 'NVMMAA100001.20210112135406', 'NVMMAA100001', '', 'online', '2021-01-11 18:05:20'),
(107, '', 'C7', 0.1, 1, '', 0, 1, -1, 'NVMMAA100001.20210112135416', 'NVMMAA100001', '', 'online', '2021-01-11 18:05:30'),
(108, '', 'A2', 0.1, 1, 'Socket', 1, 1, -1, 'NVMMAA100001.20210112135630', 'NVMMAA100001', 'http://192.168.0.2/images/A2-Socket.jpg', 'online', '2021-01-11 17:18:51'),
(109, '', 'A2', 0.1, 1, 'Socket', 1, 1, -1, 'NVMMAA100001.20210112135643', 'NVMMAA100001', 'http://192.168.0.2/images/A2-Socket.jpg', 'online', '2021-01-11 17:19:04'),
(110, '', 'A2', 0.1, 1, 'Socket', 1, 1, -1, 'NVMMAA100001.20210112135654', 'NVMMAA100001', 'http://192.168.0.2/images/A2-Socket.jpg', 'online', '2021-01-11 17:19:15'),
(111, '', 'A2', 0.1, 1, 'Socket', 1, 1, -1, 'NVMMAA100001.20210112135705', 'NVMMAA100001', 'http://192.168.0.2/images/A2-Socket.jpg', 'online', '2021-01-11 17:19:26'),
(112, '', 'C4', 0.1, 1, '', 1, 1, -1, 'NVMMAA100001.20210112135730', 'NVMMAA100001', '', 'online', '2021-01-11 17:19:51'),
(113, '', 'A2', 0.1, 1, 'Socket', 1, 1, -1, 'NVMMAA100001.20210112135746', 'NVMMAA100001', 'http://192.168.0.2/images/A2-Socket.jpg', 'online', '2021-01-11 17:20:07'),
(114, '', 'B2', 0.1, 1, '', 1, 1, -1, 'NVMMAA100001.20210112135755', 'NVMMAA100001', '', 'online', '2021-01-11 17:20:16'),
(115, '', 'B2', 0.1, 1, '', 0, 1, -1, 'NVMMAA100001.20210112135807', 'NVMMAA100001', '', 'online', '2021-01-11 17:20:28'),
(116, '', 'C7', 0.1, 1, '', 0, 1, -1, 'NVMMAA100001.20210112135823', 'NVMMAA100001', '', 'online', '2021-01-11 17:20:44'),
(117, '', 'C7', 0.1, 1, '', 0, 1, -1, 'NVMMAA100001.20210112135926', 'NVMMAA100001', '', 'online', '2021-01-11 17:21:47'),
(118, '', 'B3', 0.1, 1, '', 0, 1, -1, 'NVMMAA100001.20210112135959', 'NVMMAA100001', '', 'online', '2021-01-11 17:22:20'),
(119, '', 'B3', 0.1, 1, '', 0, 1, -1, 'NVMMAA100001.20210112140011', 'NVMMAA100001', '', 'online', '2021-01-11 17:22:32'),
(120, '', 'C3', 0.1, 1, '', 1, 1, -1, 'NVMMAA100001.20210112140024', 'NVMMAA100001', '', 'online', '2021-01-11 17:22:45'),
(121, '', 'C7', 0.1, 1, '', 0, 1, -1, 'NVMMAA100001.20210112140047', 'NVMMAA100001', '', 'online', '2021-01-11 17:23:08'),
(122, '', 'A3', 0.1, 1, 'Robot', 0, 1, -1, 'NVMMAA100001.20210112140112', 'NVMMAA100001', 'http://192.168.0.2/images/A3-Robot.jpg', 'online', '2021-01-11 17:23:33'),
(123, '', 'A4', 0.3, 1, 'Testing', 0, 1, -1, 'NVMMAA100001.20210112140149', 'NVMMAA100001', 'http://192.168.0.2/images/A4-Testing.jpg', 'online', '2021-01-11 17:24:10'),
(124, '', 'A3', 0.1, 1, 'Robot', 0, 1, -1, 'NVMMAA100001.20210112140203', 'NVMMAA100001', 'http://192.168.0.2/images/A3-Robot.jpg', 'online', '2021-01-11 17:24:24'),
(125, '', 'A2', 0.1, 1, 'Socket', 1, 1, -1, 'NVMMAA100001.20210112140316', 'NVMMAA100001', 'http://192.168.0.2/images/A2-Socket.jpg', 'online', '2021-01-11 17:25:37'),
(126, '', 'A3', 0.1, 1, 'Robot', 1, 1, -1, 'NVMMAA100001.20210112140327', 'NVMMAA100001', 'http://192.168.0.2/images/A3-Robot.jpg', 'online', '2021-01-11 17:25:48'),
(127, '', 'A4', 0.3, 1, 'Testing', 1, 1, -1, 'NVMMAA100001.20210112140337', 'NVMMAA100001', 'http://192.168.0.2/images/A4-Testing.jpg', 'online', '2021-01-11 17:25:58'),
(128, '', 'A5', 0.2, 1, 'Hello World', 1, 1, -1, 'NVMMAA100001.20210112140353', 'NVMMAA100001', 'http://192.168.0.2/images/A5-Hello World.jpg', 'online', '2021-01-11 17:26:14'),
(129, '', 'B3', 0.1, 1, '', 0, 1, -1, 'NVMMAA100001.20210112140406', 'NVMMAA100001', '', 'online', '2021-01-11 17:26:27'),
(130, '', 'C7', 0.1, 1, '', 0, 1, -1, 'NVMMAA100001.20210112140420', 'NVMMAA100001', '', 'online', '2021-01-11 17:26:41'),
(131, '', 'C7', 0.1, 1, '', 0, 1, -1, 'NVMMAA100001.20210112140504', 'NVMMAA100001', '', 'online', '2021-01-11 17:27:24'),
(132, '', 'C6', 0.1, 1, '', 1, 1, -1, 'NVMMAA100001.20210112140516', 'NVMMAA100001', '', 'online', '2021-01-11 17:27:37'),
(133, '', 'F10', 0.1, 1, '', 1, 1, -1, 'NVMMAA100001.20210112140552', 'NVMMAA100001', '', 'online', '2021-01-11 17:28:13'),
(134, '', 'A3', 0.1, 1, 'Robot', 1, 1, -1, 'NVMMAA100001.20210112141308', 'NVMMAA100001', 'http://192.168.0.2/images/A3-Robot.jpg', 'online', '2021-01-11 17:35:29'),
(135, 'NVMMAA100001.20210112150333', 'A2', 0.1, 1, 'Maggi ayam', 0, 3, 4, 'NVMMAA100001.20210112150403', 'NVMMAA100001', 'http://192.168.0.2/images/A2-Maggi ayam.jpg', 'online', '2021-01-11 18:26:24'),
(136, 'NVMMAA100001.20210112155159', 'B1', 0.2, 1, 'Kitkat', 1, 3, 6, 'NVMMAA100001.20210112155241', 'NVMMAA100001', 'http://192.168.0.2/images/B1-Kitkat.jpg', 'online', '2021-01-11 19:15:02'),
(137, 'NVMMAA100001.20210112165430', 'A3', 0.1, 1, 'Maggi ayam', 0, 3, 6, 'NVMMAA100001.20210112165503', 'NVMMAA100001', 'http://192.168.0.2/images/A3-Maggi ayam.jpg', 'online', '2021-01-11 19:38:29'),
(138, 'NVMMAA100001.20210112165607', 'B8', 0.1, 1, 'Halls cherry', 0, 3, 6, 'NVMMAA100001.20210112165649', 'NVMMAA100001', 'http://192.168.0.2/images/B8-Halls cherry.jpg', 'online', '2021-01-11 19:40:16'),
(139, 'NVMMAA100001.20210112165749', 'B10', 0.1, 1, 'Halls Black', 0, 3, 6, 'NVMMAA100001.20210112165832', 'NVMMAA100001', 'http://192.168.0.2/images/B10-Halls Black.jpg', 'online', '2021-01-11 19:41:58'),
(140, 'NVMMAA100001.20210112170253', 'B2', 0.1, 1, 'Kitkat', 0, 3, 6, 'NVMMAA100001.20210112170331', 'NVMMAA100001', 'http://192.168.0.2/images/B2-Kitkat.jpg', 'online', '2021-01-11 19:46:57'),
(141, 'NVMMAA100001.20210112170532', 'F10', 0.1, 1, 'Milo', 0, 3, 6, 'NVMMAA100001.20210112170609', 'NVMMAA100001', 'http://192.168.0.2/images/F10-Milo.jpg', 'online', '2021-01-11 19:49:36'),
(142, 'NVMMAA100001.20210112170605', 'F10', 0.1, 1, 'Milo', 1, 3, 6, 'NVMMAA100001.20210112170640', 'NVMMAA100001', 'http://192.168.0.2/images/F10-Milo.jpg', 'online', '2021-01-11 19:50:06'),
(143, 'NVMMAA100001.20210112170727', 'F1', 0.1, 1, 'Soya Bean', 0, 3, 6, 'NVMMAA100001.20210112170803', 'NVMMAA100001', 'http://192.168.0.2/images/F1-Soya Bean.jpg', 'online', '2021-01-11 19:51:29'),
(144, 'NVMMAA100001.20210112170812', 'F2', 0.1, 1, 'Soya Bean', 0, 3, 6, 'NVMMAA100001.20210112170851', 'NVMMAA100001', 'http://192.168.0.2/images/F2-Soya Bean.jpg', 'online', '2021-01-11 19:52:17'),
(145, 'NVMMAA100001.20210112171230', 'F4', 0.1, 1, 'Soya  Bean', 0, 3, 5, 'NVMMAA100001.20210112171322', 'NVMMAA100001', 'http://192.168.0.2/images/F4-Soya  Bean.jpg', 'online', '2021-01-11 19:56:49'),
(146, 'NVMMAA100001.20210112174236', 'F3', 0.1, 1, 'Soya Bean', 0, 3, 6, 'NVMMAA100001.20210112174315', 'NVMMAA100001', 'http://192.168.0.2/images/F3-Soya Bean.jpg', 'online', '2021-01-11 20:26:41'),
(147, '', 'A1', 0.5, 1, 'Chicken Twisties', 1, 2, 0, 'NVMMAA100001.20210115183657', 'NVMMAA100001', 'http://192.168.0.2/images/A1-Chicken Twisties.jpg', 'online', '2021-01-13 16:26:15'),
(148, '', 'D1', 0.1, 1, '', 0, 1, -1, 'NVMMAA100001.20210115190614', 'NVMMAA100001', '', 'online', '2021-01-13 16:29:22'),
(149, '', 'D2', 0.1, 1, '', 0, 1, -1, 'NVMMAA100001.20210115190640', 'NVMMAA100001', '', 'online', '2021-01-13 16:29:48'),
(150, '', 'D3', 0.1, 1, '', 0, 1, -1, 'NVMMAA100001.20210115190750', 'NVMMAA100001', '', 'online', '2021-01-13 16:30:58'),
(151, '', 'D4', 0.1, 1, '', 0, 1, -1, 'NVMMAA100001.20210115190808', 'NVMMAA100001', '', 'online', '2021-01-13 16:31:16'),
(152, '', 'D4', 0.1, 1, '', 0, 1, -1, 'NVMMAA100001.20210115190917', 'NVMMAA100001', '', 'online', '2021-01-13 16:32:25'),
(153, '', 'D3', 0.1, 1, '', 0, 1, -1, 'NVMMAA100001.20210115190949', 'NVMMAA100001', '', 'online', '2021-01-13 16:32:57'),
(154, '', 'D5', 0.1, 1, '', 1, 1, -1, 'NVMMAA100001.20210115191002', 'NVMMAA100001', '', 'online', '2021-01-13 16:33:10'),
(155, '', 'D5', 0.1, 1, '', 0, 1, -1, 'NVMMAA100001.20210115191046', 'NVMMAA100001', '', 'online', '2021-01-13 16:33:54'),
(156, '', 'B1', 0.1, 1, '', 1, 1, -1, 'NVMMAA100001.20210115191108', 'NVMMAA100001', '', 'online', '2021-01-13 16:34:16'),
(157, '', 'A1', 0.1, 1, '', 1, 1, -1, 'NVMMAA100001.20210115191118', 'NVMMAA100001', '', 'online', '2021-01-13 16:34:26'),
(158, '', 'A1', 0.1, 1, '', 0, 1, -1, 'NVMMAA100001.20210115191139', 'NVMMAA100001', '', 'online', '2021-01-13 16:34:47'),
(159, '', 'E7', 0.1, 1, '', 0, 1, -1, 'NVMMAA100001.20210115191807', 'NVMMAA100001', '', 'online', '2021-01-13 16:41:15'),
(160, 'NVMMAA100001.20210115192152', 'C3', 0.1, 1, '', 0, 3, 4, 'NVMMAA100001.20210115192225', 'NVMMAA100001', '', 'online', '2021-01-13 16:45:33'),
(161, '', 'D1', 0.1, 1, '', 0, 1, -1, 'NVMMAA100001.20201120144916', 'NVMMAA100001', '', 'offline', '2021-01-13 16:18:22'),
(162, '', 'D1', 0.1, 1, '', 0, 1, -1, 'NVMMAA100001.20210118153319', 'NVMMAA100001', '', 'online', '2021-01-13 16:23:39'),
(163, '', 'D1', 0.1, 1, '', 1, 1, -1, 'NVMMAA100001.20210118153350', 'NVMMAA100001', '', 'online', '2021-01-13 16:24:09'),
(164, '', 'D2', 0.1, 1, '', 0, 1, -1, 'NVMMAA100001.20210118153411', 'NVMMAA100001', '', 'online', '2021-01-13 16:24:30'),
(165, '', 'D1', 0.1, 1, '', 0, 1, -1, 'NVMMAA100001.20210118153559', 'NVMMAA100001', '', 'online', '2021-01-13 16:26:18'),
(166, '', 'D2', 0.1, 1, '', 0, 1, -1, 'NVMMAA100001.20210118153630', 'NVMMAA100001', '', 'online', '2021-01-13 16:26:50'),
(167, '', 'D3', 0.1, 1, '', 0, 1, -1, 'NVMMAA100001.20210118153644', 'NVMMAA100001', '', 'online', '2021-01-13 16:27:03'),
(168, '', 'D4', 0.1, 1, '', 0, 1, -1, 'NVMMAA100001.20210118153653', 'NVMMAA100001', '', 'online', '2021-01-13 16:27:13'),
(169, '', 'D5', 0.1, 1, '', 0, 1, -1, 'NVMMAA100001.20210118153703', 'NVMMAA100001', '', 'online', '2021-01-13 16:27:22'),
(170, '', 'D6', 0.1, 1, '', 0, 1, -1, 'NVMMAA100001.20210118153717', 'NVMMAA100001', '', 'online', '2021-01-13 16:27:37'),
(171, '', 'D7', 0.1, 1, '', 0, 1, -1, 'NVMMAA100001.20210118153730', 'NVMMAA100001', '', 'online', '2021-01-13 16:27:49'),
(172, '', 'D7', 0.1, 1, '', 0, 1, -1, 'NVMMAA100001.20210118153746', 'NVMMAA100001', '', 'online', '2021-01-13 16:28:05'),
(173, '', 'D10', 0.1, 1, '', 0, 1, -1, 'NVMMAA100001.20210118153912', 'NVMMAA100001', '', 'online', '2021-01-13 16:29:32'),
(174, '', 'D10', 0.1, 1, '', 0, 1, -1, 'NVMMAA100001.20210118153939', 'NVMMAA100001', '', 'online', '2021-01-13 16:29:59'),
(175, '', 'E10', 0.1, 1, '', 0, 1, -1, 'NVMMAA100001.20210118154104', 'NVMMAA100001', '', 'online', '2021-01-13 16:31:23'),
(176, '', 'E10', 0.1, 1, '', 0, 1, -1, 'NVMMAA100001.20210118154548', 'NVMMAA100001', '', 'online', '2021-01-13 16:36:07'),
(177, '', 'E10', 0.1, 1, '', 0, 1, -1, 'NVMMAA100001.20201120144936', 'NVMMAA100001', '', 'offline', '2021-01-13 16:18:43'),
(178, '', 'D1', 0.1, 1, '', 0, 1, -1, 'NVMMAA100001.20210118172324', 'NVMMAA100001', '', 'online', '2021-01-13 16:19:58'),
(179, '', 'D2', 0.1, 1, '', 0, 1, -1, 'NVMMAA100001.20210118172434', 'NVMMAA100001', '', 'online', '2021-01-13 16:21:07'),
(180, '', 'D3', 0.1, 1, '', 0, 1, -1, 'NVMMAA100001.20210118173502', 'NVMMAA100001', '', 'online', '2021-01-13 16:18:19'),
(181, '', 'D4', 0.1, 1, '', 0, 1, -1, 'NVMMAA100001.20210118173522', 'NVMMAA100001', '', 'online', '2021-01-13 16:18:40'),
(182, '', 'D5', 0.1, 1, '', 0, 1, -1, 'NVMMAA100001.20210118173540', 'NVMMAA100001', '', 'online', '2021-01-13 16:18:58'),
(183, '', 'D6', 0.1, 1, '', 0, 1, -1, 'NVMMAA100001.20210118173555', 'NVMMAA100001', '', 'online', '2021-01-13 16:19:12'),
(184, '', 'D5', 0.1, 1, '', 1, 1, -1, 'NVMMAA100001.20210118174936', 'NVMMAA100001', '', 'online', '2021-01-13 16:32:53'),
(185, '', 'D5', 0.1, 1, '', 1, 1, -1, 'NVMMAA100001.20210118174958', 'NVMMAA100001', '', 'online', '2021-01-13 16:33:15'),
(186, 'NVMMAA100001.20210127124436', 'B6', 0.1, 1, '', 1, 3, 6, 'NVMMAA100001.20210126174450', 'NVMMAA100001', '', 'online', '2021-01-13 17:41:07'),
(187, 'NVMMAA100001.20210127124856', 'D2', 0.1, 1, '', 1, 3, 6, 'NVMMAA100001.20210126174925', 'NVMMAA100001', '', 'online', '2021-01-13 17:45:43'),
(188, '', 'C1', 0.1, 1, '', 1, 1, -1, 'NVMMAA100001.20210205084526', 'NVMMAA100001', '', 'offline', '2021-02-05 05:26:18'),
(189, '', 'C1', 0.1, 1, '', 1, 1, -1, 'NVMMAA100001.20210205084551', 'NVMMAA100001', '', 'online', '2021-02-05 05:26:43'),
(190, '', 'C2', 0.1, 1, '', 1, 1, -1, 'NVMMAA100001.20210205084618', 'NVMMAA100001', '', 'online', '2021-02-05 05:27:10'),
(191, '', 'B1', 0.1, 1, '', 1, 1, -1, 'NVMMAA100001.20210205084618', 'NVMMAA100001', '', 'online', '2021-02-05 05:27:14'),
(192, '', 'E1', 0.1, 1, '', 1, 1, -1, 'NVMMAA100001.20210205084717', 'NVMMAA100001', '', 'online', '2021-02-05 05:28:09'),
(193, '', 'E4', 0.1, 1, '', 1, 1, -1, 'NVMMAA100001.20210205084717', 'NVMMAA100001', '', 'online', '2021-02-05 05:28:13'),
(194, '', 'E3', 0.1, 1, '', 1, 1, -1, 'NVMMAA100001.20210205084810', 'NVMMAA100001', '', 'online', '2021-02-05 05:29:02'),
(195, '', 'E6', 0.1, 1, '', 1, 1, -1, 'NVMMAA100001.20210205084810', 'NVMMAA100001', '', 'online', '2021-02-05 05:29:06'),
(196, '', 'F1', 0.1, 1, '', 1, 1, -1, 'NVMMAA100001.20210205084856', 'NVMMAA100001', '', 'online', '2021-02-05 05:29:49'),
(197, '', 'F2', 0.1, 1, '', 1, 1, -1, 'NVMMAA100001.20210205084856', 'NVMMAA100001', '', 'online', '2021-02-05 05:29:52'),
(198, '', 'C10', 0.1, 1, '', 1, 1, -1, 'NVMMAA100001.20210205084954', 'NVMMAA100001', '', 'online', '2021-02-05 05:30:46'),
(199, '', 'C9', 0.1, 1, '', 1, 1, -1, 'NVMMAA100001.20210205084954', 'NVMMAA100001', '', 'online', '2021-02-05 05:30:50'),
(200, '', 'C1', 0.1, 1, '', 0, 1, -1, 'NVMMAA100001.20210205091212', 'NVMMAA100001', '', 'online', '2021-02-05 05:53:06'),
(201, '', 'A2', 0.1, 1, '', 1, 1, -1, 'NVMMAA100001.20210205091504', 'NVMMAA100001', '', 'online', '2021-02-05 05:55:56'),
(202, '', 'B6', 0.1, 1, '', 1, 1, -1, 'NVMMAA100001.20210205091504', 'NVMMAA100001', '', 'online', '2021-02-05 05:56:00'),
(203, '', 'A1', 0.5, 1, 'USB Type C', 1, 1, -1, 'NVMMAA100001.20210205091552', 'NVMMAA100001', 'http://192.168.0.2/images/A1-USB Type C.jpg', 'online', '2021-02-05 05:56:44'),
(204, '', 'A2', 0.1, 1, '', 1, 1, -1, 'NVMMAA100001.20210205091552', 'NVMMAA100001', '', 'online', '2021-02-05 05:56:48'),
(205, '', 'A1', 0.5, 1, 'USB Type C', 1, 1, -1, 'NVMMAA100001.20210205091628', 'NVMMAA100001', 'http://192.168.0.2/images/A1-USB Type C.jpg', 'online', '2021-02-05 05:57:21'),
(206, '', 'D2', 0.1, 1, '', 1, 1, -1, 'NVMMAA100001.20210205091628', 'NVMMAA100001', '', 'online', '2021-02-05 05:57:25'),
(207, '', 'A1', 0.5, 1, 'USB Type C', 1, 1, -1, 'NVMMAA100001.20210205092159', 'NVMMAA100001', 'http://192.168.0.2/images/A1-USB Type C.jpg', 'online', '2021-02-05 06:02:52'),
(208, '', 'A2', 0.1, 1, '', 1, 1, -1, 'NVMMAA100001.20210205092159', 'NVMMAA100001', '', 'online', '2021-02-05 06:02:56'),
(209, '', 'A1', 0.5, 1, 'USB Type C', 1, 1, -1, 'NVMMAA100001.20210205092441', 'NVMMAA100001', 'http://192.168.0.2/images/A1-USB Type C.jpg', 'online', '2021-02-05 06:05:34'),
(210, '', 'A3', 0.1, 1, '', 1, 1, -1, 'NVMMAA100001.20210205092441', 'NVMMAA100001', '', 'online', '2021-02-05 06:05:38'),
(211, '', 'A1', 0.5, 1, 'USB Type C', 1, 1, -1, 'NVMMAA100001.20210205092530', 'NVMMAA100001', 'http://192.168.0.2/images/A1-USB Type C.jpg', 'online', '2021-02-05 06:06:22'),
(212, '', 'A1', 0.5, 1, 'USB Type C', 1, 1, -1, 'NVMMAA100001.20210205092750', 'NVMMAA100001', 'http://192.168.0.2/images/A1-USB Type C.jpg', 'online', '2021-02-05 06:08:43'),
(213, '', 'A5', 0.1, 1, '', 1, 1, -1, 'NVMMAA100001.20210205092750', 'NVMMAA100001', '', 'online', '2021-02-05 06:08:46'),
(214, '', 'A1', 0.5, 1, 'USB Type C', 1, 1, -1, 'NVMMAA100001.20210205093454', 'NVMMAA100001', 'http://192.168.0.2/images/A1-USB Type C.jpg', 'online', '2021-02-05 06:15:47'),
(215, '', 'A2', 0.1, 1, '', 1, 1, -1, 'NVMMAA100001.20210205093454', 'NVMMAA100001', '', 'online', '2021-02-05 06:15:50'),
(216, '', 'A1', 0.5, 1, 'USB Type C', 1, 1, -1, 'NVMMAA100001.20210205093635', 'NVMMAA100001', 'http://192.168.0.2/images/A1-USB Type C.jpg', 'online', '2021-02-05 06:17:27'),
(217, '', 'A2', 0.1, 1, '', 1, 1, -1, 'NVMMAA100001.20210205093635', 'NVMMAA100001', '', 'online', '2021-02-05 06:17:31'),
(218, '', 'A2', 0.1, 1, '', 1, 1, -1, 'NVMMAA100001.20210205093635', 'NVMMAA100001', '', 'online', '2021-02-05 06:17:35'),
(219, 'NVMMAA100001.20210205095712', 'B2', 0.1, 1, '', 1, 3, 6, 'NVMMAA100001.20210205095723', 'NVMMAA100001', '', 'online', '2021-02-05 06:38:15'),
(220, 'NVMMAA100001.20210205095712', 'C2', 0.1, 1, '', 1, 3, 6, 'NVMMAA100001.20210205095723', 'NVMMAA100001', '', 'online', '2021-02-05 06:38:20'),
(221, '', 'B1', 0.1, 1, '', 1, 1, -1, 'NVMMAA100001.20210205100653', 'NVMMAA100001', '', 'online', '2021-02-05 06:47:45'),
(222, '', 'C3', 0.1, 1, '', 1, 1, -1, 'NVMMAA100001.20210205100812', 'NVMMAA100001', '', 'online', '2021-02-05 06:49:05'),
(223, '', 'C3', 0.1, 1, '', 1, 1, -1, 'NVMMAA100001.20210205101000', 'NVMMAA100001', '', 'online', '2021-02-05 06:50:52'),
(224, '', 'C3', 0.1, 1, '', 1, 1, -1, 'NVMMAA100001.20210205101023', 'NVMMAA100001', '', 'online', '2021-02-05 06:51:15'),
(225, '', 'B2', 0.1, 1, '', 1, 1, -1, 'NVMMAA100001.20210205101111', 'NVMMAA100001', '', 'online', '2021-02-05 06:52:04'),
(226, '', 'B4', 0.1, 1, '', 1, 1, -1, 'NVMMAA100001.20210205101441', 'NVMMAA100001', '', 'online', '2021-02-05 06:55:33'),
(227, '', 'A1', 0.5, 1, 'USB Type C', 1, 1, -1, 'NVMMAA100001.20210205101810', 'NVMMAA100001', 'http://192.168.0.2/images/A1-USB Type C.jpg', 'online', '2021-02-05 06:59:03'),
(228, '', 'A1', 0.5, 1, 'USB Type C', 1, 1, -1, 'NVMMAA100001.20210205101830', 'NVMMAA100001', 'http://192.168.0.2/images/A1-USB Type C.jpg', 'online', '2021-02-05 06:59:22'),
(229, '', 'A1', 0.5, 1, 'USB Type C', 1, 1, -1, 'NVMMAA100001.20210205102433', 'NVMMAA100001', 'http://192.168.0.2/images/A1-USB Type C.jpg', 'online', '2021-02-05 07:05:25'),
(230, '', 'A1', 0.5, 1, 'USB Type C', 1, 1, -1, 'NVMMAA100001.20210205102433', 'NVMMAA100001', 'http://192.168.0.2/images/A1-USB Type C.jpg', 'online', '2021-02-05 07:05:29'),
(231, '', 'A1', 0.5, 1, 'USB Type C', 1, 1, -1, 'NVMMAA100001.20210205102433', 'NVMMAA100001', 'http://192.168.0.2/images/A1-USB Type C.jpg', 'online', '2021-02-05 07:05:33'),
(232, '', 'B6', 0.1, 1, '', 1, 1, -1, 'NVMMAA100001.20210205110205', 'NVMMAA100001', '', 'online', '2021-02-05 07:42:57'),
(233, '', 'B6', 0.1, 1, '', 1, 1, -1, 'NVMMAA100001.20210205110217', 'NVMMAA100001', '', 'online', '2021-02-05 07:43:09'),
(234, '', 'A3', 0.1, 1, 'Android', 1, 1, -1, 'NVMMAA100001.20210205111442', 'NVMMAA100001', 'http://192.168.0.2/images/A3-Android.jpg', 'online', '2021-02-05 07:55:35'),
(235, '', 'A1', 0.2, 1, 'USB Type C C', 1, 1, -1, 'NVMMAA100001.20210205111442', 'NVMMAA100001', 'http://192.168.0.2/images/A1-USB Type C C.jpg', 'online', '2021-02-05 07:55:39'),
(236, '', 'A2', 0.1, 1, 'IPhone 12', 1, 1, -1, 'NVMMAA100001.20210205111442', 'NVMMAA100001', 'http://192.168.0.2/images/A2-IPhone 12.jpg', 'online', '2021-02-05 07:55:42'),
(237, '', 'C3', 0.1, 1, '', 1, 1, -1, 'NVMMAA100001.20210206161713', 'NVMMAA100001', '', 'offline', '2021-02-05 08:18:11'),
(238, '', 'D3', 0.1, 1, '', 1, 1, -1, 'NVMMAA100001.20210206161815', 'NVMMAA100001', '', 'online', '2021-02-05 08:19:13'),
(239, '', 'B6', 0.1, 1, '', 1, 1, -1, 'NVMMAA100001.20210206183945', 'NVMMAA100001', '', 'online', '2021-02-05 09:19:25'),
(240, '', 'B6', 0.1, 1, '', 1, 1, -1, 'NVMMAA100001.20210207185935', 'NVMMAA100001', '', 'online', '2021-02-05 11:24:53'),
(241, '', 'B10', 0.1, 1, '', 1, 1, -1, 'NVMMAA100001.20210207190242', 'NVMMAA100001', '', 'online', '2021-02-05 11:28:01'),
(242, '', 'B9', 0.2, 1, '', 1, 1, -1, 'NVMMAA100001.20210207190242', 'NVMMAA100001', '', 'online', '2021-02-05 11:28:04'),
(243, '', 'B1', 0.1, 1, 'amar', 1, 1, -1, 'NVMMAA100001.20210207194732', 'NVMMAA100001', 'http://192.168.0.2/images/B1-amar.jpg', 'online', '2021-02-05 11:22:33'),
(244, '', 'B10', 0.1, 1, '', 1, 1, -1, 'NVMMAA100001.20210207194758', 'NVMMAA100001', '', 'online', '2021-02-05 11:22:58'),
(245, '', 'B10', 2.5, 1, '', 1, 1, -1, 'NVMMAA100001.20210207211803', 'NVMMAA100001', '', 'online', '2021-02-05 12:01:25'),
(246, '', 'B10', 0.2, 1, '', 1, 1, -1, 'NVMMAA100001.20210207214032', 'NVMMAA100001', '', 'online', '2021-02-05 12:23:51'),
(247, '', 'B10', 2.5, 1, 'Cream-O Vanilla', 1, 1, -1, 'NVMMAA100001.20210207234817', 'NVMMAA100001', 'http://192.168.0.2/images/B10-Cream-O Vanilla.jpg', 'online', '2021-02-05 13:48:01'),
(248, '', 'B7', 0.1, 1, 'Nabati Cheese', 1, 1, -1, 'NVMMAA100001.20210207235154', 'NVMMAA100001', 'http://192.168.0.2/images/B7-Nabati Cheese.jpg', 'online', '2021-02-05 13:51:38'),
(249, '', 'D2', 0.1, 1, 'Coca-Cola Can', 1, 1, -1, 'NVMMAA100001.20210207235221', 'NVMMAA100001', 'http://192.168.0.2/images/D2-Coca-Cola Can.jpg', 'online', '2021-02-05 13:52:05'),
(250, '', 'B9', 0.1, 1, 'Cream-O Vanilla', 1, 1, -1, 'NVMMAA100001.20210207235331', 'NVMMAA100001', 'http://192.168.0.2/images/B9-Cream-O Vanilla.jpg', 'online', '2021-02-05 13:53:15'),
(251, '', 'C3', 0.1, 1, 'Tiger Biscuit', 1, 1, -1, 'NVMMAA100001.20210207235414', 'NVMMAA100001', 'http://192.168.0.2/images/C3-Tiger Biscuit.jpg', 'online', '2021-02-05 13:53:57'),
(252, '', 'C4', 0.1, 1, 'Tiger Biscuit', 1, 1, -1, 'NVMMAA100001.20210207235423', 'NVMMAA100001', 'http://192.168.0.2/images/C4-Tiger Biscuit.jpg', 'online', '2021-02-05 13:54:06'),
(253, 'NVMMAA100001.20210208000630', 'B7', 0.1, 1, 'Nabati Cheese', 1, 3, 6, 'NVMMAA100001.20210208000653', 'NVMMAA100001', 'http://192.168.0.2/images/B7-Nabati Cheese.jpg', 'online', '2021-02-05 14:06:37'),
(254, 'NVMMAA100001.20210208000946', 'B7', 0.1, 1, 'Nabati Cheese', 1, 3, 6, 'NVMMAA100001.20210208001002', 'NVMMAA100001', 'http://192.168.0.2/images/B7-Nabati Cheese.jpg', 'online', '2021-02-05 14:09:46'),
(255, 'NVMMAA100001.20210208000946', 'B7', 0.2, 1, 'Nabati Cheese', 1, 3, 6, 'NVMMAA100001.20210208001002', 'NVMMAA100001', 'http://192.168.0.2/images/B7-Nabati Cheese.jpg', 'online', '2021-02-05 14:09:50'),
(256, '', 'B9', 0.1, 1, 'Cream-O Vanilla', 1, 1, -1, 'NVMMAA100001.20210208102949', 'NVMMAA100001', 'http://192.168.0.2/images/B9-Cream-O Vanilla.jpg', 'online', '2021-02-05 23:19:27'),
(257, '', 'B9', 0.1, 1, 'Cream-O Vanilla', 1, 1, -1, 'NVMMAA100001.20210208102957', 'NVMMAA100001', 'http://192.168.0.2/images/B9-Cream-O Vanilla.jpg', 'online', '2021-02-05 23:19:34'),
(258, '', 'B9', 0.1, 1, 'Cream-O Vanilla', 1, 1, -1, 'NVMMAA100001.20210208103010', 'NVMMAA100001', 'http://192.168.0.2/images/B9-Cream-O Vanilla.jpg', 'online', '2021-02-05 23:19:48'),
(259, '', 'B9', 0.1, 1, 'Cream-O Vanilla', 1, 1, -1, 'NVMMAA100001.20210208103019', 'NVMMAA100001', 'http://192.168.0.2/images/B9-Cream-O Vanilla.jpg', 'online', '2021-02-05 23:19:57'),
(260, '', 'B9', 0.1, 1, 'Cream-O Vanilla', 1, 1, -1, 'NVMMAA100001.20210208103026', 'NVMMAA100001', 'http://192.168.0.2/images/B9-Cream-O Vanilla.jpg', 'online', '2021-02-05 23:20:04'),
(261, '', 'B2', 0.1, 1, 'Lexus Chocolate', 1, 1, -1, 'NVMMAA100001.20210208103144', 'NVMMAA100001', 'http://192.168.0.2/images/B2-Lexus Chocolate.peg', 'online', '2021-02-05 23:21:22'),
(262, '', 'B2', 0.1, 1, 'Lexus Chocolate', 1, 1, -1, 'NVMMAA100001.20210208103154', 'NVMMAA100001', 'http://192.168.0.2/images/B2-Lexus Chocolate.peg', 'online', '2021-02-05 23:21:32'),
(263, '', 'B2', 0.1, 1, 'Lexus Chocolate', 1, 1, -1, 'NVMMAA100001.20210208103213', 'NVMMAA100001', 'http://192.168.0.2/images/B2-Lexus Chocolate.peg', 'online', '2021-02-05 23:21:51'),
(264, '', 'B2', 0.1, 1, 'Lexus Chocolate', 1, 1, -1, 'NVMMAA100001.20210208103222', 'NVMMAA100001', 'http://192.168.0.2/images/B2-Lexus Chocolate.peg', 'online', '2021-02-05 23:22:00'),
(265, '', 'C6', 0.1, 1, 'Yeos Chrys Box', 1, 1, -1, 'NVMMAA100001.20210208122214', 'NVMMAA100001', 'http://192.168.0.2/images/C6-Yeo\'s Chrys Box.jpg', 'online', '2021-02-06 00:21:59'),
(266, '', 'C6', 0.2, 1, 'Yeos Chrys Box', 1, 1, -1, 'NVMMAA100001.20210208122214', 'NVMMAA100001', 'http://192.168.0.2/images/C6-Yeo\'s Chrys Box.jpg', 'online', '2021-02-06 00:22:02'),
(267, '', 'C6', 0.1, 1, 'Yeos Chrys Box', 1, 1, -1, 'NVMMAA100001.20210208122214', 'NVMMAA100001', 'http://192.168.0.2/images/C6-Yeo\'s Chrys Box.jpg', 'online', '2021-02-06 00:22:05'),
(268, '', 'C6', 0.1, 1, 'Yeos Chrys Box', 1, 1, -1, 'NVMMAA100001.20210208122237', 'NVMMAA100001', 'http://192.168.0.2/images/C6-Yeo\'s Chrys Box.jpg', 'online', '2021-02-06 00:22:21'),
(269, '', 'C6', 0.2, 1, 'Yeos Chrys Box', 1, 1, -1, 'NVMMAA100001.20210208122237', 'NVMMAA100001', 'http://192.168.0.2/images/C6-Yeo\'s Chrys Box.jpg', 'online', '2021-02-06 00:22:25'),
(270, '', 'C6', 0.1, 1, 'Yeos Chrys Box', 1, 1, -1, 'NVMMAA100001.20210208122237', 'NVMMAA100001', 'http://192.168.0.2/images/C6-Yeo\'s Chrys Box.jpg', 'online', '2021-02-06 00:22:28'),
(271, '', 'C6', 0.1, 1, 'Yeos Chrys Box', 1, 1, -1, 'NVMMAA100001.20210208122322', 'NVMMAA100001', 'http://192.168.0.2/images/C6-Yeo\'s Chrys Box.jpg', 'online', '2021-02-06 00:23:07'),
(272, '', 'C8', 2.5, 1, 'HomeSoy Box ', 1, 1, -1, 'NVMMAA100001.20210208122434', 'NVMMAA100001', 'http://192.168.0.2/images/C8-HomeSoy Box .peg', 'online', '2021-02-06 00:24:19'),
(273, '', 'B2', 0.2, 1, 'Lexus Chocolate', 1, 1, -1, 'NVMMAA100001.20210208153826', 'NVMMAA100001', 'http://192.168.0.2/images/B2-Lexus Chocolate.peg', 'online', '2021-02-06 03:38:10'),
(274, '', 'B2', 0.2, 1, 'Lexus Chocolate', 1, 1, -1, 'NVMMAA100001.20210208153920', 'NVMMAA100001', 'http://192.168.0.2/images/B2-Lexus Chocolate.peg', 'online', '2021-02-06 03:39:05'),
(275, '', 'C3', 0.2, 1, 'Tiger Biscuit', 1, 1, -1, 'NVMMAA100001.20210208153920', 'NVMMAA100001', 'http://192.168.0.2/images/C3-Tiger Biscuit.jpg', 'online', '2021-02-06 03:39:08'),
(276, '', 'B2', 0.2, 1, 'Lexus Chocolate', 1, 1, -1, 'NVMMAA100001.20210208154234', 'NVMMAA100001', 'http://192.168.0.2/images/B2-Lexus Chocolate.peg', 'online', '2021-02-06 03:42:19'),
(277, '', 'B2', 0.2, 1, 'Lexus Chocolate', 1, 1, -1, 'NVMMAA100001.20210208154304', 'NVMMAA100001', 'http://192.168.0.2/images/B2-Lexus Chocolate.peg', 'online', '2021-02-06 03:42:49'),
(278, '', 'D2', 0.2, 1, 'Coca-Cola Can', 1, 1, -1, 'NVMMAA100001.20210208154304', 'NVMMAA100001', 'http://192.168.0.2/images/D2-Coca-Cola Can.jpg', 'online', '2021-02-06 03:42:52'),
(279, '', 'E4', 0.1, 1, 'Yeos Cincau ', 1, 1, -1, 'NVMMAA100001.20210208154304', 'NVMMAA100001', 'http://192.168.0.2/images/E4-Yeo\'s Cincau .peg', 'online', '2021-02-06 03:42:54'),
(280, '', 'B2', 0.2, 1, 'Lexus Chocolate', 1, 1, -1, 'NVMMAA100001.20210208161708', 'NVMMAA100001', 'http://192.168.0.2/images/B2-Lexus Chocolate.peg', 'online', '2021-02-06 04:16:54'),
(281, '', 'C3', 0.2, 1, 'Tiger Biscuit', 1, 1, -1, 'NVMMAA100001.20210208161708', 'NVMMAA100001', 'http://192.168.0.2/images/C3-Tiger Biscuit.jpg', 'online', '2021-02-06 04:16:57'),
(282, '', 'C4', 0.1, 1, 'Tiger Biscuit', 1, 1, -1, 'NVMMAA100001.20210208161708', 'NVMMAA100001', 'http://192.168.0.2/images/C4-Tiger Biscuit.jpg', 'online', '2021-02-06 04:17:00'),
(283, '', 'B2', 0.2, 1, 'Lexus Chocolate', 1, 1, -1, 'NVMMAA100001.20210208162103', 'NVMMAA100001', 'http://192.168.0.2/images/B2-Lexus Chocolate.peg', 'online', '2021-02-06 04:20:48'),
(284, '', 'C3', 0.2, 1, 'Tiger Biscuit', 1, 1, -1, 'NVMMAA100001.20210208162103', 'NVMMAA100001', 'http://192.168.0.2/images/C3-Tiger Biscuit.jpg', 'online', '2021-02-06 04:20:51'),
(285, '', 'B2', 0.2, 1, 'Lexus Chocolate', 1, 1, -1, 'NVMMAA100001.20210208162400', 'NVMMAA100001', 'http://192.168.0.2/images/B2-Lexus Chocolate.peg', 'online', '2021-02-06 04:23:45'),
(286, '', 'B2', 0.2, 1, 'Lexus Chocolate', 1, 1, -1, 'NVMMAA100001.20210208162427', 'NVMMAA100001', 'http://192.168.0.2/images/B2-Lexus Chocolate.peg', 'online', '2021-02-06 04:24:11'),
(287, '', 'B2', 0.2, 1, 'Lexus Chocolate', 1, 1, -1, 'NVMMAA100001.20210208162553', 'NVMMAA100001', 'http://192.168.0.2/images/B2-Lexus Chocolate.peg', 'online', '2021-02-06 04:25:38'),
(288, '', 'B10', 0.2, 1, 'Cream-O Vanilla', 1, 1, -1, 'NVMMAA100001.20210208164755', 'NVMMAA100001', 'http://192.168.0.2/images/B10-Cream-O Vanilla.jpg', 'online', '2021-02-06 04:47:46'),
(289, '', 'D4', 0.1, 1, '100 Plus Can', 1, 1, -1, 'NVMMAA100001.20210208164755', 'NVMMAA100001', 'http://192.168.0.2/images/D4-100 Plus Can.jpg', 'online', '2021-02-06 04:47:49'),
(290, '', 'F1', 0.1, 1, 'Milo Can', 1, 1, -1, 'NVMMAA100001.20210208165242', 'NVMMAA100001', 'http://192.168.0.2/images/F1-Milo Can.jpg', 'online', '2021-02-06 04:52:36'),
(291, '', 'B9', 0.2, 1, 'Cream-O Vanilla', 1, 1, -1, 'NVMMAA100001.20210208174540', 'NVMMAA100001', 'http://192.168.0.2/images/B9-Cream-O Vanilla.jpg', 'online', '2021-02-06 05:45:34'),
(292, '', 'B8', 0.2, 1, 'Nabati Cheese', 1, 1, -1, 'NVMMAA100001.20210208174611', 'NVMMAA100001', 'http://192.168.0.2/images/B8-Nabati Cheese.jpg', 'online', '2021-02-06 05:46:02'),
(293, '', 'B10', 0.1, 1, 'Cream-O Vanilla', 1, 1, -1, 'NVMMAA100001.20210208174611', 'NVMMAA100001', 'http://192.168.0.2/images/B10-Cream-O Vanilla.jpg', 'online', '2021-02-06 05:46:06'),
(294, '', 'B2', 0.2, 1, 'Lexus Chocolate', 1, 1, -1, 'NVMMAA100001.20210209095640', 'NVMMAA100001', 'http://192.168.0.2/images/B2-Lexus Chocolate.peg', 'online', '2021-02-06 21:56:26'),
(295, '', 'B2', 0.2, 1, 'Lexus Chocolate', 1, 1, -1, 'NVMMAA100001.20210209095640', 'NVMMAA100001', 'http://192.168.0.2/images/B2-Lexus Chocolate.peg', 'online', '2021-02-06 21:56:29'),
(296, '', 'B2', 0.1, 1, 'Lexus Chocolate', 1, 1, -1, 'NVMMAA100001.20210209095640', 'NVMMAA100001', 'http://192.168.0.2/images/B2-Lexus Chocolate.peg', 'online', '2021-02-06 21:56:33'),
(297, 'NVMMAA100001.20210209110135', 'B2', 0.2, 1, 'Lexus Chocolate', 1, 3, 6, 'NVMMAA100001.20210209110145', 'NVMMAA100001', 'http://192.168.0.2/images/B2-Lexus Chocolate.peg', 'online', '2021-02-06 22:26:51'),
(298, 'NVMMAA100001.20210209111822', 'A4', 2.5, 1, 'Twisties (BBQ)', 1, 3, 6, 'NVMMAA100001.20210209111837', 'NVMMAA100001', 'http://192.168.0.2/images/A4-Twisties (BBQ).jpg', 'online', '2021-02-06 22:43:43'),
(299, '', 'B2', 0.2, 1, 'Lexus Chocolate', 1, 1, -1, 'NVMMAA100001.20210209113452', 'NVMMAA100001', 'http://192.168.0.2/images/B2-Lexus Chocolate.peg', 'online', '2021-02-06 22:19:50'),
(300, '', 'B2', 0.1, 1, 'Lexus Chocolate', 1, 1, -1, 'NVMMAA100001.20210209113452', 'NVMMAA100001', 'http://192.168.0.2/images/B2-Lexus Chocolate.peg', 'online', '2021-02-06 22:19:53'),
(301, '', 'B2', 0.1, 1, 'Lexus Chocolate', 1, 1, -1, 'NVMMAA100001.20210209113452', 'NVMMAA100001', 'http://192.168.0.2/images/B2-Lexus Chocolate.peg', 'online', '2021-02-06 22:19:57'),
(302, '', 'C3', 0.1, 1, 'Tiger Biscuit', 1, 1, -1, 'NVMMAA100001.20210209113527', 'NVMMAA100001', 'http://192.168.0.2/images/C3-Tiger Biscuit.jpg', 'online', '2021-02-06 22:20:25'),
(303, '', 'C3', 0.1, 1, 'Tiger Biscuit', 1, 1, -1, 'NVMMAA100001.20210210151702', 'NVMMAA100001', 'http://192.168.0.2/images/C3-Tiger Biscuit.jpg', 'online', '2021-02-08 02:02:00'),
(304, 'NVMMAA100001.20210211101715', 'C3', 0.1, 1, 'Tiger Biscuit', 1, 3, 6, 'NVMMAA100001.20210211101732', 'NVMMAA100001', 'http://192.168.0.2/images/C3-Tiger Biscuit.jpg', 'online', '2021-02-08 20:26:52'),
(305, 'NVMMAA100001.20210211101715', 'C3', 0.1, 1, 'Tiger Biscuit', 1, 3, 6, 'NVMMAA100001.20210211101732', 'NVMMAA100001', 'http://192.168.0.2/images/C3-Tiger Biscuit.jpg', 'online', '2021-02-08 20:26:55'),
(306, 'NVMMAA100001.20210211105912', 'A1', 0.3, 1, 'Maggi  Curry', 1, 3, 6, 'NVMMAA100001.20210211105944', 'NVMMAA100001', 'http://192.168.0.2/images/A1-Maggi  Curry.jpg', 'online', '2021-02-08 21:09:03'),
(307, 'NVMMAA100001.20210211105912', 'C4', 0.1, 1, 'Tiger Biscuit', 1, 3, 6, 'NVMMAA100001.20210211105944', 'NVMMAA100001', 'http://192.168.0.2/images/C4-Tiger Biscuit.jpg', 'online', '2021-02-08 21:09:10'),
(308, 'NVMMAA100001.20210211125519', 'A1', 0.3, 1, 'Maggi  Curry', 1, 3, 6, 'NVMMAA100001.20210211125531', 'NVMMAA100001', 'http://192.168.0.2/images/A1-Maggi  Curry.jpg', 'online', '2021-02-08 22:02:05'),
(309, 'NVMMAA100001.20210211125519', 'C3', 0.1, 1, 'Tiger Biscuit', 1, 3, 6, 'NVMMAA100001.20210211125531', 'NVMMAA100001', 'http://192.168.0.2/images/C3-Tiger Biscuit.jpg', 'online', '2021-02-08 22:02:12'),
(310, '', 'C3', 0.1, 1, 'Tiger Biscuit', 1, 1, -1, 'NVMMAA100001.20210216102324', 'NVMMAA100001', 'http://192.168.0.2/images/C3-Tiger Biscuit.jpg', 'online', '2021-02-13 19:30:02'),
(311, '', 'C3', 0.1, 1, 'Tiger Biscuit', 1, 1, -1, 'NVMMAA100001.20210216103042', 'NVMMAA100001', 'http://192.168.0.2/images/C3-Tiger Biscuit.jpg', 'online', '2021-02-13 19:19:37'),
(312, '', 'B2', 0.2, 1, 'Lexus Chocolate', 1, 1, -1, 'NVMMAA100001.20210216103059', 'NVMMAA100001', 'http://192.168.0.2/images/B2-Lexus Chocolate.peg', 'online', '2021-02-13 19:19:54'),
(313, '', 'C3', 0.1, 1, 'Tiger Biscuit', 1, 1, -1, 'NVMMAA100001.20210216103116', 'NVMMAA100001', 'http://192.168.0.2/images/C3-Tiger Biscuit.jpg', 'online', '2021-02-13 19:20:10'),
(314, '', 'A1', 0.3, 1, 'Maggi  Curry', 1, 1, -1, 'NVMMAA100001.20210216103419', 'NVMMAA100001', 'http://192.168.0.2/images/A1-Maggi  Curry.jpg', 'online', '2021-02-13 19:23:14'),
(315, '', 'A2', 0.2, 1, 'Maggi Ayam', 1, 1, -1, 'NVMMAA100001.20210216103419', 'NVMMAA100001', 'http://192.168.0.2/images/A2-Maggi Ayam.peg', 'online', '2021-02-13 19:23:17'),
(316, '', 'A1', 0.3, 1, 'Maggi  Curry', 1, 1, -1, 'NVMMAA100001.20210216104211', 'NVMMAA100001', 'http://192.168.0.2/images/A1-Maggi  Curry.jpg', 'online', '2021-02-13 19:31:06'),
(317, '', 'C3', 0.2, 1, 'Tiger Biscuit', 1, 1, -1, 'NVMMAA100001.20210216104211', 'NVMMAA100001', 'http://192.168.0.2/images/C3-Tiger Biscuit.jpg', 'online', '2021-02-13 19:31:10'),
(318, '', 'C4', 0.1, 1, 'Tiger Biscuit', 1, 1, -1, 'NVMMAA100001.20210216104211', 'NVMMAA100001', 'http://192.168.0.2/images/C4-Tiger Biscuit.jpg', 'online', '2021-02-13 19:31:13'),
(319, '', 'C3', 0.1, 1, 'Tiger Biscuit', 1, 1, -1, 'NVMMAA100001.20210216104232', 'NVMMAA100001', 'http://192.168.0.2/images/C3-Tiger Biscuit.jpg', 'online', '2021-02-13 19:31:27');
INSERT INTO `db_sales_record` (`id`, `transaction_serial`, `slot_number`, `price`, `quantity`, `product_name`, `drop_sensor_status`, `payment_method`, `self_defined_payment_method`, `order_number`, `machine_id`, `product_url`, `report_status`, `date_time`) VALUES
(320, '', 'C4', 0.1, 1, 'Tiger Biscuit', 1, 1, -1, 'NVMMAA100001.20210216104232', 'NVMMAA100001', 'http://192.168.0.2/images/C4-Tiger Biscuit.jpg', 'online', '2021-02-13 19:31:37'),
(321, '', 'B2', 0.2, 1, 'Lexus Chocolate', 1, 1, -1, 'NVMMAA100001.20210216104251', 'NVMMAA100001', 'http://192.168.0.2/images/B2-Lexus Chocolate.peg', 'online', '2021-02-13 19:31:46'),
(322, '', 'B2', 0.2, 1, 'Lexus Chocolate', 1, 1, -1, 'NVMMAA100001.20210216104343', 'NVMMAA100001', 'http://192.168.0.2/images/B2-Lexus Chocolate.peg', 'online', '2021-02-13 19:32:44'),
(323, '', 'A1', 0.3, 1, 'Maggi  Curry', 1, 1, -1, 'NVMMAA100001.20210216104419', 'NVMMAA100001', 'http://192.168.0.2/images/A1-Maggi  Curry.jpg', 'online', '2021-02-13 19:33:14'),
(324, '', 'A2', 0.2, 1, 'Maggi Ayam', 1, 1, -1, 'NVMMAA100001.20210216104419', 'NVMMAA100001', 'http://192.168.0.2/images/A2-Maggi Ayam.peg', 'online', '2021-02-13 19:33:20'),
(325, '', 'A2', 0.1, 1, 'Maggi Ayam', 1, 1, -1, 'NVMMAA100001.20210216104419', 'NVMMAA100001', 'http://192.168.0.2/images/A2-Maggi Ayam.peg', 'online', '2021-02-13 19:33:24'),
(326, '', 'C3', 0.1, 1, 'Tiger Biscuit', 1, 1, -1, 'NVMMAA100001.20210216104450', 'NVMMAA100001', 'http://192.168.0.2/images/C3-Tiger Biscuit.jpg', 'online', '2021-02-13 19:33:45'),
(327, '', 'A1', 0.3, 1, 'Maggi  Curry', 1, 1, -1, 'NVMMAA100001.20210216105144', 'NVMMAA100001', 'http://192.168.0.2/images/A1-Maggi  Curry.jpg', 'online', '2021-02-13 19:40:40'),
(328, '', 'B2', 0.2, 1, 'Lexus Chocolate', 1, 1, -1, 'NVMMAA100001.20210216114623', 'NVMMAA100001', 'http://192.168.0.2/images/B2-Lexus Chocolate.peg', 'online', '2021-02-13 20:35:18'),
(329, '', 'A1', 0.3, 1, 'Maggi  Curry', 1, 1, -1, 'NVMMAA100001.20210216114631', 'NVMMAA100001', 'http://192.168.0.2/images/A1-Maggi  Curry.jpg', 'online', '2021-02-13 20:35:26'),
(330, '', 'B2', 0.2, 1, 'Lexus Chocolate', 1, 1, -1, 'NVMMAA100001.20210216115948', 'NVMMAA100001', 'http://192.168.0.2/images/B2-Lexus Chocolate.peg', 'online', '2021-02-13 20:48:43'),
(331, '', 'C3', 0.1, 1, 'Tiger Biscuit', 1, 1, -1, 'NVMMAA100001.20210216120011', 'NVMMAA100001', 'http://192.168.0.2/images/C3-Tiger Biscuit.jpg', 'online', '2021-02-13 20:49:07'),
(332, '', 'D6', 0.2, 1, '100 Plus Can', 1, 1, -1, 'NVMMAA100001.20210216120011', 'NVMMAA100001', 'http://192.168.0.2/images/D6-100 Plus Can.jpg', 'online', '2021-02-13 20:49:10'),
(333, '', 'D2', 0.1, 1, 'Coca-Cola Can', 1, 1, -1, 'NVMMAA100001.20210216120011', 'NVMMAA100001', 'http://192.168.0.2/images/D2-Coca-Cola Can.jpg', 'online', '2021-02-13 20:49:13'),
(334, '', 'A1', 0.3, 1, 'Maggi  Curry', 1, 1, -1, 'NVMMAA100001.20210216134307', 'NVMMAA100001', 'http://192.168.0.2/images/A1-Maggi  Curry.jpg', 'online', '2021-02-13 22:32:03'),
(335, '', 'B2', 0.2, 1, 'Lexus Chocolate', 1, 1, -1, 'NVMMAA100001.20210216134307', 'NVMMAA100001', 'http://192.168.0.2/images/B2-Lexus Chocolate.peg', 'online', '2021-02-13 22:32:07'),
(336, '', 'C3', 0.1, 1, 'Tiger Biscuit', 1, 1, -1, 'NVMMAA100001.20210216134307', 'NVMMAA100001', 'http://192.168.0.2/images/C3-Tiger Biscuit.jpg', 'online', '2021-02-13 22:32:10'),
(337, 'NVMMAA100001.20210216135420', 'E9', 2.5, 1, 'Nescafe Mocha', 1, 3, 6, 'NVMMAA100001.20210216135435', 'NVMMAA100001', 'http://192.168.0.2/images/E9-Nescafe Mocha.jpg', 'online', '2021-02-13 22:43:30'),
(338, 'NVMMAA100001.20210216135505', 'E6', 2.5, 1, 'Sprite Can ', 1, 3, 6, 'NVMMAA100001.20210216135514', 'NVMMAA100001', 'http://192.168.0.2/images/E6-Sprite Can .jpg', 'online', '2021-02-13 22:44:08'),
(339, '', 'C3', 0.1, 1, 'Tiger Biscuit', 1, 1, -1, 'NVMMAA100001.20210217113149', 'NVMMAA100001', 'http://192.168.0.2/images/C3-Tiger Biscuit.jpg', 'online', '2021-02-14 19:19:35'),
(340, '', 'B2', 0.2, 1, 'Lexus Chocolate', 1, 1, -1, 'NVMMAA100001.20210217114153', 'NVMMAA100001', 'http://192.168.0.2/images/B2-Lexus Chocolate.peg', 'online', '2021-02-14 19:22:33'),
(341, 'NVMMAA100001.20210217134613', 'A1', 0.3, 1, 'Maggi  Curry', 1, 3, 6, 'NVMMAA100001.20210217134622', 'NVMMAA100001', 'http://192.168.0.2/images/A1-Maggi  Curry.jpg', 'online', '2021-02-14 21:27:01'),
(342, 'NVMMAA100001.20210217134613', 'B2', 0.2, 1, 'Lexus Chocolate', 1, 3, 6, 'NVMMAA100001.20210217134622', 'NVMMAA100001', 'http://192.168.0.2/images/B2-Lexus Chocolate.peg', 'online', '2021-02-14 21:27:05'),
(343, 'NVMMAA100001.20210217134613', 'C3', 0.1, 1, 'Tiger Biscuit', 1, 3, 6, 'NVMMAA100001.20210217134622', 'NVMMAA100001', 'http://192.168.0.2/images/C3-Tiger Biscuit.jpg', 'online', '2021-02-14 21:27:09'),
(344, '', 'A2', 0.2, 1, 'Maggi Ayam', 1, 1, -1, 'NVMMAA100001.20210217143811', 'NVMMAA100001', 'http://192.168.0.2/images/A2-Maggi Ayam.peg', 'online', '2021-02-14 22:18:52'),
(345, 'NVMMAA100001.20210217145722', 'A4', 2.5, 1, 'Twisties (BBQ)', 1, 3, 6, 'NVMMAA100001.20210217145747', 'NVMMAA100001', 'http://192.168.0.2/images/A4-Twisties (BBQ).jpg', 'online', '2021-02-14 22:38:27'),
(346, 'NVMMAA100001.20210217145722', 'D2', 0.2, 1, 'Coca-Cola Can', 1, 3, 6, 'NVMMAA100001.20210217145747', 'NVMMAA100001', 'http://192.168.0.2/images/D2-Coca-Cola Can.jpg', 'online', '2021-02-14 22:38:30'),
(347, 'NVMMAA100001.20210223104720', 'A1', 0.3, 1, 'Maggi  Curry', 1, 3, 6, 'NVMMAA100001.20210223104744', 'NVMMAA100001', 'http://192.168.0.2/images/A1-Maggi  Curry.jpg', 'online', '2021-02-20 17:24:48'),
(348, 'NVMMAA100001.20210224084321', 'A2', 0.2, 1, 'Maggi Ayam', 1, 3, 6, 'NVMMAA100001.20210224084346', 'NVMMAA100001', 'http://192.168.0.2/images/A2-Maggi Ayam.peg', 'online', '2021-02-21 15:20:51'),
(349, '', 'A3', 0.3, 1, 'Maggi Ayam', 1, 1, -1, 'NVMMAA100001.20210224131447', 'NVMMAA100001', 'http://192.168.0.2/images/A3-Maggi Ayam.peg', 'online', '2021-02-24 13:14:35'),
(350, '', 'B2', 0.2, 1, 'Lexus Chocolate', 1, 1, -1, 'NVMMAA100001.20210224161538', 'NVMMAA100001', 'http://192.168.0.2/images/B2-Lexus Chocolate.peg', 'online', '2021-02-24 16:15:25'),
(351, '', 'B2', 0.2, 1, 'Lexus Chocolate', 1, 1, -1, 'NVMMAA100001.20210302123449', 'NVMMAA100001', 'http://192.168.0.2/images/B2-Lexus Chocolate.peg', 'online', '2021-02-26 08:20:22'),
(352, '', 'A1', 0.2, 1, 'Maggi  Curry', 1, 1, -1, 'NVMMAA100001.20210302123449', 'NVMMAA100001', 'http://192.168.0.2/images/A1-Maggi  Curry.jpg', 'online', '2021-02-26 08:20:25'),
(353, '', 'C3', 0.1, 1, 'Tiger Biscuit', 1, 1, -1, 'NVMMAA100001.20210302123449', 'NVMMAA100001', 'http://192.168.0.2/images/C3-Tiger Biscuit.jpg', 'online', '2021-02-26 08:20:28'),
(354, '', 'C3', 0.1, 1, 'Tiger Biscuit', 1, 1, -1, 'NVMMAA100001.20210302123529', 'NVMMAA100001', 'http://192.168.0.2/images/C3-Tiger Biscuit.jpg', 'online', '2021-02-26 08:21:01'),
(355, '', 'C3', 0.1, 1, 'Tiger Biscuit', 1, 1, -1, 'NVMMAA100001.20210302123548', 'NVMMAA100001', 'http://192.168.0.2/images/C3-Tiger Biscuit.jpg', 'online', '2021-02-26 08:21:19'),
(356, 'NVMMAA100001.20210308102643', 'C3', 0.1, 1, 'Tiger Biscuit', 1, 3, 6, 'NVMMAA100001.20210308102728', 'NVMMAA100001', 'http://192.168.0.2/images/C3-Tiger Biscuit.jpg', 'online', '2021-03-04 05:28:38'),
(357, '', 'B2', 0.2, 1, 'Lexus Chocolate', 1, 1, -1, 'NVMMAA100001.20210312173126', 'NVMMAA100001', 'http://192.168.0.2/images/B2-Lexus Chocolate.peg', 'online', '2021-03-08 10:19:33'),
(358, '', 'D4', 0.2, 1, '100 Plus Can', 1, 1, -1, 'NVMMAA100001.20210312173126', 'NVMMAA100001', 'http://192.168.0.2/images/D4-100 Plus Can.jpg', 'online', '2021-03-08 10:19:37'),
(359, '', 'C3', 0.1, 1, 'Tiger Biscuit', 1, 1, -1, 'NVMMAA100001.20210312173327', 'NVMMAA100001', 'http://192.168.0.2/images/C3-Tiger Biscuit.jpg', 'online', '2021-03-08 10:21:35'),
(360, '', 'A5', 0.2, 1, 'Twisties (Cheese)', 1, 1, -1, 'NVMMAA100001.20210312173327', 'NVMMAA100001', 'http://192.168.0.2/images/A5-Twisties (Cheese).jpg', 'online', '2021-03-08 10:21:38'),
(361, '', 'C3', 0.1, 1, 'Tiger Biscuit', 1, 1, -1, 'NVMMAA100001.20210315144258', 'NVMMAA100001', 'http://192.168.0.2/images/C3-Tiger Biscuit.jpg', 'online', '2021-03-15 13:55:19'),
(362, 'NVMMAA100001.20210316101055', 'A2', 0.2, 1, 'Maggi Ayam', 1, 3, 6, 'NVMMAA100001.20210316101127', 'NVMMAA100001', 'http://192.168.0.2/images/A2-Maggi Ayam.peg', 'online', '2021-03-16 09:08:18'),
(363, 'NVMMAA100001.20210316101347', 'A3', 0.3, 1, 'Maggi Ayam', 1, 3, 6, 'NVMMAA100001.20210316101418', 'NVMMAA100001', 'http://192.168.0.2/images/A3-Maggi Ayam.peg', 'online', '2021-03-16 09:11:08'),
(364, 'NVMMAA100001.20210316102026', 'B2', 0.2, 1, 'Lexus Chocolate', 1, 3, 6, 'NVMMAA100001.20210316102056', 'NVMMAA100001', 'http://192.168.0.2/images/B2-Lexus Chocolate.peg', 'online', '2021-03-16 09:17:47'),
(365, 'NVMMAA100001.20210316103938', 'D3', 2.5, 1, 'Coca-Cola Can', 1, 3, 6, 'NVMMAA100001.20210316104020', 'NVMMAA100001', 'http://192.168.0.2/images/D3-Coca-Cola Can.jpg', 'online', '2021-03-16 09:37:11'),
(366, '', 'D2', 0.1, 1, 'Coca-Cola Can', 1, 1, -1, 'NVMMAA100001.20210318175746', 'NVMMAA100001', 'http://192.168.0.2/images/D2-Coca-Cola Can.jpg', 'online', '2021-03-18 15:36:36'),
(367, '', 'C3', 0.1, 1, 'Tiger Biscuit', 1, 1, -1, 'NVMMAA100001.20210318180246', 'NVMMAA100001', 'http://192.168.0.2/images/C3-Tiger Biscuit.jpg', 'online', '2021-03-18 15:20:11'),
(368, '', 'E10', 0.2, 1, 'Nescafe Latte', 1, 1, -1, 'NVMMAA100001.20210318180246', 'NVMMAA100001', 'http://192.168.0.2/images/E10-Nescafe Latte.jpg', 'online', '2021-03-18 15:20:14'),
(369, '', 'C3', 0.1, 1, 'Tiger Biscuit', 1, 1, -1, 'NVMMAA100001.20210319092925', 'NVMMAA100001', 'http://192.168.0.2/images/C3-Tiger Biscuit.jpg', 'online', '2021-03-19 06:46:50'),
(370, '', 'C3', 0.1, 1, 'Tiger Biscuit', 1, 1, -1, 'NVMMAA100001.20210403162051', 'NVMMAA100001', 'http://192.168.0.2/images/C3-Tiger Biscuit.jpg', 'online', '2021-04-03 16:20:54'),
(371, '', 'C3', 0.1, 1, 'Tiger Biscuit', 1, 1, -1, 'NVMMAA100001.20210403171939', 'NVMMAA100001', 'http://192.168.0.2/images/C3-Tiger Biscuit.jpg', 'online', '2021-04-03 17:19:42'),
(372, 'NVMMAA100001.20210403172111', 'C3', 0.1, 1, 'Tiger Biscuit', 1, 3, 6, 'NVMMAA100001.20210403172120', 'NVMMAA100001', 'http://192.168.0.2/images/C3-Tiger Biscuit.jpg', 'online', '2021-04-03 17:21:25'),
(373, '', 'C3', 0.1, 1, 'Tiger Biscuit', 1, 1, -1, 'NVMMAA100001.20210403172208', 'NVMMAA100001', 'http://192.168.0.2/images/C3-Tiger Biscuit.jpg', 'online', '2021-04-03 17:22:12'),
(374, '', 'C3', 0.1, 1, 'Tiger Biscuit', 1, 1, -1, 'NVMMAA100001.20210403172302', 'NVMMAA100001', 'http://192.168.0.2/images/C3-Tiger Biscuit.jpg', 'online', '2021-04-03 17:23:05'),
(375, 'NVMMAA100001.20210403172428', 'C3', 0.1, 1, 'Tiger Biscuit', 1, 3, 6, 'NVMMAA100001.20210403172436', 'NVMMAA100001', 'http://192.168.0.2/images/C3-Tiger Biscuit.jpg', 'online', '2021-04-03 17:24:38'),
(376, '', 'C3', 0.1, 1, 'Tiger Biscuit', 1, 1, -1, 'NVMMAA100001.20210403172922', 'NVMMAA100001', 'http://192.168.0.2/images/C3-Tiger Biscuit.jpg', 'online', '2021-04-03 17:29:24'),
(377, '', 'C3', 0.1, 1, 'Tiger Biscuit', 1, 1, -1, 'NVMMAA100001.20210403173551', 'NVMMAA100001', 'http://192.168.0.2/images/C3-Tiger Biscuit.jpg', 'online', '2021-04-03 17:35:53'),
(378, '', 'C4', 0.1, 1, 'Tiger Biscuit', 1, 1, -1, 'NVMMAA100001.20210403174004', 'NVMMAA100001', 'http://192.168.0.2/images/C4-Tiger Biscuit.jpg', 'online', '2021-04-03 17:40:07'),
(379, 'NVMMAA100001.20210403174037', 'C4', 0.1, 1, 'Tiger Biscuit', 1, 3, 6, 'NVMMAA100001.20210403174046', 'NVMMAA100001', 'http://192.168.0.2/images/C4-Tiger Biscuit.jpg', 'online', '2021-04-03 17:40:49'),
(380, '', 'B9', 0.1, 1, 'Cream-O Vanilla', 1, 1, -1, 'NVMMAA100001.20210403174135', 'NVMMAA100001', 'http://192.168.0.2/images/B9-Cream-O Vanilla.jpg', 'online', '2021-04-03 17:41:38'),
(381, 'NVMMAA100001.20210403183327', 'C3', 0.1, 1, 'Tiger Biscuit', 1, 3, 6, 'NVMMAA100001.20210403183333', 'NVMMAA100001', 'http://192.168.0.2/images/C3-Tiger Biscuit.jpg', 'online', '2021-04-03 18:33:45'),
(382, 'NVMMAA100001.20210403221429', 'A3', 0.1, 1, 'Maggi Ayam', 1, 3, 6, 'NVMMAA100001.20210403221441', 'NVMMAA100001', 'http://192.168.0.2/images/A3-Maggi Ayam.peg', 'online', '2021-04-03 22:14:42'),
(383, 'NVMMAA100001.20210403221459', 'C3', 0.1, 1, 'Tiger Biscuit', 1, 3, 6, 'NVMMAA100001.20210403221506', 'NVMMAA100001', 'http://192.168.0.2/images/C3-Tiger Biscuit.jpg', 'online', '2021-04-03 22:15:08'),
(384, 'NVMMAA100001.20210403222025', 'C3', 0.1, 1, 'Tiger Biscuit', 1, 3, 6, 'NVMMAA100001.20210403222031', 'NVMMAA100001', 'http://192.168.0.2/images/C3-Tiger Biscuit.jpg', 'online', '2021-04-03 22:20:33'),
(385, '', 'D3', 0.1, 1, 'Coca-Cola Can', 1, 1, -1, 'NVMMAA100001.20210403224309', 'NVMMAA100001', 'http://192.168.0.2/images/D3-Coca-Cola Can.jpg', 'online', '2021-04-03 22:43:11'),
(386, '', 'B2', 0.2, 1, 'Lexus Chocolate', 1, 1, -1, 'NVMMAA100001.20210406195305', 'NVMMAA100001', 'http://192.168.0.2/images/B2-Lexus Chocolate.peg', 'online', '2021-04-06 19:53:12'),
(387, '', 'A1', 0, 1, '100plus Active 500ml', 1, 1, -1, 'FMNVMMAA100001.20210503112103', 'FMNVMMAA100001', '', 'online', '2021-05-03 04:21:06'),
(388, '', 'A1', 0.1, 1, '100plus Active 500ml', 1, 1, -1, 'FMNVMMAA100001.20210503115031', 'FMNVMMAA100001', '', 'online', '2021-05-03 04:50:31'),
(389, '', 'A2', 0, 1, '100plus Lime 500ml', 1, 1, -1, 'FMNVMMAA100001.20210503115031', 'FMNVMMAA100001', '', 'online', '2021-05-03 04:50:33'),
(390, '', 'A1', 0.1, 1, '100plus Active 500ml', 1, 1, -1, 'FMNVMMAA100001.20210503134248', 'FMNVMMAA100001', '', 'online', '2021-05-03 06:42:49'),
(391, '', 'A4', 0, 1, '100plus Regular 500ml', 1, 1, -1, 'FMNVMMAA100001.20210503134248', 'FMNVMMAA100001', '', 'online', '2021-05-03 06:42:51'),
(392, '', 'A1', 0.1, 1, '100plus Active 500ml', 1, 1, -1, 'FMNVMMAA100001.20210503135923', 'FMNVMMAA100001', '', 'online', '2021-05-03 06:59:25'),
(393, '', 'A1', 0, 1, '100plus Active 500ml', 1, 1, -1, 'FMNVMMAA100001.20210503135923', 'FMNVMMAA100001', '', 'online', '2021-05-03 06:59:28'),
(394, '', 'A1', 0, 1, '100plus Active 500ml', 1, 1, -1, 'FMNVMMAA100001.20210503143143', 'FMNVMMAA100001', '', 'online', '2021-05-03 07:31:47'),
(395, '', 'A1', 0.1, 1, '100plus Active 500ml', 1, 1, -1, 'FMNVMMAA100001.20210503155212', 'FMNVMMAA100001', '', 'online', '2021-05-03 08:52:13'),
(396, '', 'A1', 0, 1, '100plus Active 500ml', 1, 1, -1, 'FMNVMMAA100001.20210503155212', 'FMNVMMAA100001', '', 'online', '2021-05-03 08:52:15'),
(397, '', 'A1', 0, 1, '100plus Active 500ml', 1, 1, -1, 'FMNVMMAA100001.20210503155212', 'FMNVMMAA100001', '', 'online', '2021-05-03 08:52:17'),
(398, '', 'A1', 0.1, 1, '100plus Active 500ml', 1, 1, -1, 'FMNVMMAA100001.20210503191652', 'FMNVMMAA100001', '', 'online', '2021-05-03 12:16:53'),
(399, '', 'A1', 0.1, 1, '100plus Active 500ml', 1, 1, -1, 'FMNVMMAA100001.20210503192916', 'FMNVMMAA100001', '', 'online', '2021-05-03 12:29:16'),
(400, '', 'A1', 0.1, 1, '100plus Active 500ml', 1, 1, -1, 'FMNVMMAA100001.20210503214113', 'FMNVMMAA100001', '', 'online', '2021-05-03 14:41:19'),
(401, '', 'A1', 0.1, 1, '100plus Active 500ml', 1, 1, -1, 'FMNVMMAA100001.20210503214239', 'FMNVMMAA100001', '', 'online', '2021-05-03 14:42:40'),
(402, '', 'A2', 0.1, 1, '100plus Lime 500ml', 1, 1, -1, 'FMNVMMAA100001.20210503214239', 'FMNVMMAA100001', '', 'online', '2021-05-03 14:42:44'),
(403, '', 'A3', 0.1, 1, '100plus Regular 1.5l', 1, 1, -1, 'FMNVMMAA100001.20210503214239', 'FMNVMMAA100001', '', 'online', '2021-05-03 14:42:47'),
(404, '', 'A1', 0.1, 1, '100plus Active 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504075636', 'FMNVMMAA100001', '', 'online', '2021-05-04 00:56:37'),
(405, '', 'A1', 0.1, 1, '100plus Active 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504075636', 'FMNVMMAA100001', '', 'online', '2021-05-04 00:56:40'),
(406, '', 'A5', 1, 1, 'Authentic Tea House Ayataka Green Tea 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504075659', 'FMNVMMAA100001', '', 'online', '2021-05-04 00:57:07'),
(407, '', 'A2', 0.1, 1, '100plus Lime 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504085108', 'FMNVMMAA100001', '', 'online', '2021-05-04 01:51:10'),
(408, '', 'A4', 0.1, 1, '100plus Regular 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504085108', 'FMNVMMAA100001', '', 'online', '2021-05-04 01:51:13'),
(409, '', 'A2', 0.1, 1, '100plus Lime 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504085859', 'FMNVMMAA100001', '', 'online', '2021-05-04 01:59:09'),
(410, '', 'A1', 0.1, 1, '100plus Active 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504091716', 'FMNVMMAA100001', '', 'online', '2021-05-04 02:17:20'),
(411, '', 'A3', 0.1, 1, '100plus Regular 1.5l', 1, 1, -1, 'FMNVMMAA100001.20210504091716', 'FMNVMMAA100001', '', 'online', '2021-05-04 02:17:25'),
(412, '', 'A4', 0.1, 1, '100plus Regular 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504091716', 'FMNVMMAA100001', '', 'online', '2021-05-04 02:17:28'),
(413, '', 'A1', 0.1, 1, '100plus Active 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504091740', 'FMNVMMAA100001', '', 'online', '2021-05-04 02:17:42'),
(414, '', 'A2', 0.1, 1, '100plus Lime 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504091740', 'FMNVMMAA100001', '', 'online', '2021-05-04 02:17:45'),
(415, '', 'A3', 0.1, 1, '100plus Regular 1.5l', 1, 1, -1, 'FMNVMMAA100001.20210504091740', 'FMNVMMAA100001', '', 'online', '2021-05-04 02:17:48'),
(416, '', 'A1', 0.1, 1, '100plus Active 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504092053', 'FMNVMMAA100001', '', 'online', '2021-05-04 02:20:54'),
(417, '', 'A3', 0.1, 1, '100plus Regular 1.5l', 1, 1, -1, 'FMNVMMAA100001.20210504092053', 'FMNVMMAA100001', '', 'online', '2021-05-04 02:20:57'),
(418, '', 'A4', 0.1, 1, '100plus Regular 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504092053', 'FMNVMMAA100001', '', 'online', '2021-05-04 02:21:01'),
(419, '', 'A1', 0.1, 1, '100plus Active 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504094125', 'FMNVMMAA100001', '', 'online', '2021-05-04 02:41:27'),
(420, '', 'A2', 0.1, 1, '100plus Lime 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504094125', 'FMNVMMAA100001', '', 'online', '2021-05-04 02:41:30'),
(421, '', 'A3', 0.1, 1, '100plus Regular 1.5l', 1, 1, -1, 'FMNVMMAA100001.20210504094125', 'FMNVMMAA100001', '', 'online', '2021-05-04 02:41:33'),
(422, '', 'A1', 0.1, 1, '100plus Active 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504100730', 'FMNVMMAA100001', '', 'online', '2021-05-04 03:07:32'),
(423, '', 'A3', 0.1, 1, '100plus Regular 1.5l', 1, 1, -1, 'FMNVMMAA100001.20210504100730', 'FMNVMMAA100001', '', 'online', '2021-05-04 03:07:35'),
(424, '', 'A1', 0.1, 1, '100plus Active 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504102109', 'FMNVMMAA100001', '', 'online', '2021-05-04 03:21:11'),
(425, '', 'A3', 0.1, 1, '100plus Regular 1.5l', 1, 1, -1, 'FMNVMMAA100001.20210504102109', 'FMNVMMAA100001', '', 'online', '2021-05-04 03:21:14'),
(426, '', 'A1', 0.1, 1, '100plus Active 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504102255', 'FMNVMMAA100001', '', 'online', '2021-05-04 03:22:57'),
(427, '', 'A2', 0.1, 1, '100plus Lime 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504102255', 'FMNVMMAA100001', '', 'online', '2021-05-04 03:23:01'),
(428, '', 'A3', 0.1, 1, '100plus Regular 1.5l', 1, 1, -1, 'FMNVMMAA100001.20210504102255', 'FMNVMMAA100001', '', 'online', '2021-05-04 03:23:04'),
(429, '', 'A5', 0.1, 1, 'Authentic Tea House Ayataka Green Tea 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504102323', 'FMNVMMAA100001', '', 'online', '2021-05-04 03:23:25'),
(430, '', 'A4', 0.1, 1, '100plus Regular 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504102323', 'FMNVMMAA100001', '', 'online', '2021-05-04 03:23:28'),
(431, '', 'A3', 0.1, 1, '100plus Regular 1.5l', 1, 1, -1, 'FMNVMMAA100001.20210504102323', 'FMNVMMAA100001', '', 'online', '2021-05-04 03:23:33'),
(432, '', 'A5', 0.1, 1, 'Authentic Tea House Ayataka Green Tea 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504102419', 'FMNVMMAA100001', '', 'online', '2021-05-04 03:24:20'),
(433, '', 'A4', 0.1, 1, '100plus Regular 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504102419', 'FMNVMMAA100001', '', 'online', '2021-05-04 03:24:23'),
(434, '', 'A3', 0.1, 1, '100plus Regular 1.5l', 1, 1, -1, 'FMNVMMAA100001.20210504102419', 'FMNVMMAA100001', '', 'online', '2021-05-04 03:24:28'),
(435, '', 'A3', 0.1, 1, '100plus Regular 1.5l', 1, 1, -1, 'FMNVMMAA100001.20210504102445', 'FMNVMMAA100001', '', 'online', '2021-05-04 03:24:47'),
(436, '', 'A3', 0.1, 1, '100plus Regular 1.5l', 1, 1, -1, 'FMNVMMAA100001.20210504102445', 'FMNVMMAA100001', '', 'online', '2021-05-04 03:24:50'),
(437, '', 'A3', 0.1, 1, '100plus Regular 1.5l', 1, 1, -1, 'FMNVMMAA100001.20210504102445', 'FMNVMMAA100001', '', 'online', '2021-05-04 03:24:53'),
(438, '', 'A3', 0.1, 1, '100plus Regular 1.5l', 1, 1, -1, 'FMNVMMAA100001.20210504102507', 'FMNVMMAA100001', '', 'online', '2021-05-04 03:25:09'),
(439, '', 'A3', 0.1, 1, '100plus Regular 1.5l', 1, 1, -1, 'FMNVMMAA100001.20210504102507', 'FMNVMMAA100001', '', 'online', '2021-05-04 03:25:12'),
(440, '', 'A3', 0.1, 1, '100plus Regular 1.5l', 1, 1, -1, 'FMNVMMAA100001.20210504102507', 'FMNVMMAA100001', '', 'online', '2021-05-04 03:25:15'),
(441, '', 'A5', 0.1, 1, 'Authentic Tea House Ayataka Green Tea 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504102528', 'FMNVMMAA100001', '', 'online', '2021-05-04 03:25:29'),
(442, '', 'A4', 0.1, 1, '100plus Regular 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504102528', 'FMNVMMAA100001', '', 'online', '2021-05-04 03:25:33'),
(443, '', 'A3', 0.1, 1, '100plus Regular 1.5l', 1, 1, -1, 'FMNVMMAA100001.20210504102528', 'FMNVMMAA100001', '', 'online', '2021-05-04 03:25:36'),
(444, '', 'A1', 0.1, 1, '100plus Active 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504102551', 'FMNVMMAA100001', '', 'online', '2021-05-04 03:25:53'),
(445, '', 'A2', 0.1, 1, '100plus Lime 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504102551', 'FMNVMMAA100001', '', 'online', '2021-05-04 03:25:56'),
(446, '', 'A3', 0.1, 1, '100plus Regular 1.5l', 1, 1, -1, 'FMNVMMAA100001.20210504102551', 'FMNVMMAA100001', '', 'online', '2021-05-04 03:25:59'),
(447, '', 'A1', 0.1, 1, '100plus Active 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504102714', 'FMNVMMAA100001', '', 'online', '2021-05-04 03:27:18'),
(448, '', 'A2', 0.1, 1, '100plus Lime 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504102714', 'FMNVMMAA100001', '', 'online', '2021-05-04 03:27:21'),
(449, '', 'A3', 0.1, 1, '100plus Regular 1.5l', 1, 1, -1, 'FMNVMMAA100001.20210504102714', 'FMNVMMAA100001', '', 'online', '2021-05-04 03:27:24'),
(450, '', 'A1', 0.1, 1, '100plus Active 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504102807', 'FMNVMMAA100001', '', 'online', '2021-05-04 03:28:08'),
(451, '', 'A2', 0.1, 1, '100plus Lime 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504102807', 'FMNVMMAA100001', '', 'online', '2021-05-04 03:28:11'),
(452, '', 'A3', 0.1, 1, '100plus Regular 1.5l', 1, 1, -1, 'FMNVMMAA100001.20210504102807', 'FMNVMMAA100001', '', 'online', '2021-05-04 03:28:15'),
(453, '', 'A1', 0.1, 1, '100plus Active 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504102835', 'FMNVMMAA100001', '', 'online', '2021-05-04 03:28:37'),
(454, '', 'A2', 0.1, 1, '100plus Lime 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504102835', 'FMNVMMAA100001', '', 'online', '2021-05-04 03:28:40'),
(455, '', 'A5', 1, 1, 'Authentic Tea House Ayataka Green Tea 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504102835', 'FMNVMMAA100001', '', 'online', '2021-05-04 03:28:43'),
(456, '', 'A1', 0.1, 1, '100plus Active 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504103052', 'FMNVMMAA100001', '', 'online', '2021-05-04 03:30:54'),
(457, '', 'A3', 0.1, 1, '100plus Regular 1.5l', 1, 1, -1, 'FMNVMMAA100001.20210504103052', 'FMNVMMAA100001', '', 'online', '2021-05-04 03:30:57'),
(458, '', 'A4', 0.1, 1, '100plus Regular 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504103052', 'FMNVMMAA100001', '', 'online', '2021-05-04 03:31:00'),
(459, '', 'A2', 0.1, 1, '100plus Lime 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504103113', 'FMNVMMAA100001', '', 'online', '2021-05-04 03:31:15'),
(460, '', 'A3', 0.1, 1, '100plus Regular 1.5l', 1, 1, -1, 'FMNVMMAA100001.20210504103113', 'FMNVMMAA100001', '', 'online', '2021-05-04 03:31:18'),
(461, '', 'A3', 0.1, 1, '100plus Regular 1.5l', 1, 1, -1, 'FMNVMMAA100001.20210504103113', 'FMNVMMAA100001', '', 'online', '2021-05-04 03:31:21'),
(462, '', 'A1', 0.1, 1, '100plus Active 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504103238', 'FMNVMMAA100001', '', 'online', '2021-05-04 03:32:40'),
(463, '', 'A2', 0.1, 1, '100plus Lime 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504103238', 'FMNVMMAA100001', '', 'online', '2021-05-04 03:32:43'),
(464, '', 'A1', 0.1, 1, '100plus Active 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504103238', 'FMNVMMAA100001', '', 'online', '2021-05-04 03:32:46'),
(465, '', 'A1', 0.1, 1, '100plus Active 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504103313', 'FMNVMMAA100001', '', 'online', '2021-05-04 03:33:14'),
(466, '', 'A2', 0.1, 1, '100plus Lime 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504103313', 'FMNVMMAA100001', '', 'online', '2021-05-04 03:33:17'),
(467, '', 'A4', 0.1, 1, '100plus Regular 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504103313', 'FMNVMMAA100001', '', 'online', '2021-05-04 03:33:21'),
(468, '', 'A1', 0.1, 1, '100plus Active 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504103340', 'FMNVMMAA100001', '', 'online', '2021-05-04 03:33:41'),
(469, '', 'A4', 0.1, 1, '100plus Regular 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504103340', 'FMNVMMAA100001', '', 'online', '2021-05-04 03:33:45'),
(470, '', 'A5', 1, 1, 'Authentic Tea House Ayataka Green Tea 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504103340', 'FMNVMMAA100001', '', 'online', '2021-05-04 03:33:48'),
(471, '', 'A1', 0.1, 1, '100plus Active 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504103359', 'FMNVMMAA100001', '', 'online', '2021-05-04 03:34:01'),
(472, '', 'A3', 0.1, 1, '100plus Regular 1.5l', 1, 1, -1, 'FMNVMMAA100001.20210504103359', 'FMNVMMAA100001', '', 'online', '2021-05-04 03:34:04'),
(473, '', 'A3', 0.1, 1, '100plus Regular 1.5l', 1, 1, -1, 'FMNVMMAA100001.20210504103359', 'FMNVMMAA100001', '', 'online', '2021-05-04 03:34:07'),
(474, '', 'A1', 0.1, 1, '100plus Active 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504103418', 'FMNVMMAA100001', '', 'online', '2021-05-04 03:34:20'),
(475, '', 'A2', 0.1, 1, '100plus Lime 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504103418', 'FMNVMMAA100001', '', 'online', '2021-05-04 03:34:23'),
(476, '', 'A2', 0.1, 1, '100plus Lime 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504103418', 'FMNVMMAA100001', '', 'online', '2021-05-04 03:34:26'),
(477, '', 'A4', 0.1, 1, '100plus Regular 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504103445', 'FMNVMMAA100001', '', 'online', '2021-05-04 03:34:47'),
(478, '', 'A4', 0.1, 1, '100plus Regular 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504103445', 'FMNVMMAA100001', '', 'online', '2021-05-04 03:34:50'),
(479, '', 'A4', 0.1, 1, '100plus Regular 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504103445', 'FMNVMMAA100001', '', 'online', '2021-05-04 03:34:53'),
(480, '', 'A2', 0.1, 1, '100plus Lime 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504103541', 'FMNVMMAA100001', '', 'online', '2021-05-04 03:35:43'),
(481, '', 'A3', 0.1, 1, '100plus Regular 1.5l', 1, 1, -1, 'FMNVMMAA100001.20210504103541', 'FMNVMMAA100001', '', 'online', '2021-05-04 03:35:46'),
(482, '', 'A3', 0.1, 1, '100plus Regular 1.5l', 1, 1, -1, 'FMNVMMAA100001.20210504103541', 'FMNVMMAA100001', '', 'online', '2021-05-04 03:35:49'),
(483, '', 'A2', 0.1, 1, '100plus Lime 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504103559', 'FMNVMMAA100001', '', 'online', '2021-05-04 03:36:01'),
(484, '', 'A4', 0.1, 1, '100plus Regular 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504103559', 'FMNVMMAA100001', '', 'online', '2021-05-04 03:36:04'),
(485, '', 'A4', 0.1, 1, '100plus Regular 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504103559', 'FMNVMMAA100001', '', 'online', '2021-05-04 03:36:07'),
(486, '', 'A2', 0.1, 1, '100plus Lime 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504104546', 'FMNVMMAA100001', '', 'online', '2021-05-04 03:45:47'),
(487, '', 'A4', 0.1, 1, '100plus Regular 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504104546', 'FMNVMMAA100001', '', 'online', '2021-05-04 03:45:51'),
(488, '', 'A3', 0.1, 1, '100plus Regular 1.5l', 1, 1, -1, 'FMNVMMAA100001.20210504104546', 'FMNVMMAA100001', '', 'online', '2021-05-04 03:45:54'),
(489, '', 'A1', 0.1, 1, '100plus Active 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504105453', 'FMNVMMAA100001', '', 'online', '2021-05-04 03:54:53'),
(490, '', 'A3', 0.1, 1, '100plus Regular 1.5l', 1, 1, -1, 'FMNVMMAA100001.20210504105453', 'FMNVMMAA100001', '', 'online', '2021-05-04 03:54:55'),
(491, '', 'A4', 0.1, 1, '100plus Regular 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504105453', 'FMNVMMAA100001', '', 'online', '2021-05-04 03:54:57'),
(492, '', 'A1', 0.1, 1, '100plus Active 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504105911', 'FMNVMMAA100001', '', 'online', '2021-05-04 03:59:12'),
(493, '', 'A1', 0.1, 1, '100plus Active 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504105911', 'FMNVMMAA100001', '', 'online', '2021-05-04 03:59:15'),
(494, '', 'A1', 0.1, 1, '100plus Active 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504105924', 'FMNVMMAA100001', '', 'online', '2021-05-04 03:59:26'),
(495, '', 'A1', 0.1, 1, '100plus Active 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504105924', 'FMNVMMAA100001', '', 'online', '2021-05-04 03:59:29'),
(496, '', 'A3', 0.1, 1, '100plus Regular 1.5l', 1, 1, -1, 'FMNVMMAA100001.20210504105924', 'FMNVMMAA100001', '', 'online', '2021-05-04 03:59:32'),
(497, '', 'A1', 0.1, 1, '100plus Active 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504105949', 'FMNVMMAA100001', '', 'online', '2021-05-04 03:59:51'),
(498, '', 'A1', 0.1, 1, '100plus Active 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504105949', 'FMNVMMAA100001', '', 'online', '2021-05-04 03:59:54'),
(499, '', 'A2', 0.1, 1, '100plus Lime 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504105949', 'FMNVMMAA100001', '', 'online', '2021-05-04 03:59:57'),
(500, '', 'A1', 0.1, 1, '100plus Active 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504110137', 'FMNVMMAA100001', '', 'online', '2021-05-04 04:01:38'),
(501, '', 'A2', 0.1, 1, '100plus Lime 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504110137', 'FMNVMMAA100001', '', 'online', '2021-05-04 04:01:42'),
(502, '', 'A3', 0.1, 1, '100plus Regular 1.5l', 1, 1, -1, 'FMNVMMAA100001.20210504110137', 'FMNVMMAA100001', '', 'online', '2021-05-04 04:01:45'),
(503, '', 'A2', 0.1, 1, '100plus Lime 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504110156', 'FMNVMMAA100001', '', 'online', '2021-05-04 04:01:58'),
(504, '', 'A4', 0.1, 1, '100plus Regular 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504110156', 'FMNVMMAA100001', '', 'online', '2021-05-04 04:02:01'),
(505, '', 'A4', 0.1, 1, '100plus Regular 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504110156', 'FMNVMMAA100001', '', 'online', '2021-05-04 04:02:04'),
(506, '', 'A1', 0.1, 1, '100plus Active 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504110444', 'FMNVMMAA100001', '', 'online', '2021-05-04 04:04:46'),
(507, '', 'A3', 0.1, 1, '100plus Regular 1.5l', 1, 1, -1, 'FMNVMMAA100001.20210504110444', 'FMNVMMAA100001', '', 'online', '2021-05-04 04:04:49'),
(508, '', 'A4', 0.1, 1, '100plus Regular 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504110444', 'FMNVMMAA100001', '', 'online', '2021-05-04 04:04:52'),
(509, '', 'A3', 0.1, 1, '100plus Regular 1.5l', 1, 1, -1, 'FMNVMMAA100001.20210504110501', 'FMNVMMAA100001', '', 'online', '2021-05-04 04:05:03'),
(510, '', 'A2', 0.1, 1, '100plus Lime 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504110501', 'FMNVMMAA100001', '', 'online', '2021-05-04 04:05:06'),
(511, '', 'A3', 0.1, 1, '100plus Regular 1.5l', 1, 1, -1, 'FMNVMMAA100001.20210504110501', 'FMNVMMAA100001', '', 'online', '2021-05-04 04:05:09'),
(512, '', 'A1', 0.1, 1, '100plus Active 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504111020', 'FMNVMMAA100001', '', 'online', '2021-05-04 04:10:22'),
(513, '', 'A3', 0.1, 1, '100plus Regular 1.5l', 1, 1, -1, 'FMNVMMAA100001.20210504111020', 'FMNVMMAA100001', '', 'online', '2021-05-04 04:10:25'),
(514, '', 'A4', 0.1, 1, '100plus Regular 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504111020', 'FMNVMMAA100001', '', 'online', '2021-05-04 04:10:28'),
(515, '', 'A2', 0.1, 1, '100plus Lime 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504111038', 'FMNVMMAA100001', '', 'online', '2021-05-04 04:10:40'),
(516, '', 'A5', 0.1, 1, 'Authentic Tea House Ayataka Green Tea 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504111038', 'FMNVMMAA100001', '', 'online', '2021-05-04 04:10:43'),
(517, '', 'A3', 0.1, 1, '100plus Regular 1.5l', 1, 1, -1, 'FMNVMMAA100001.20210504111038', 'FMNVMMAA100001', '', 'online', '2021-05-04 04:10:46'),
(518, '', 'A2', 0.1, 1, '100plus Lime 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504111057', 'FMNVMMAA100001', '', 'online', '2021-05-04 04:10:58'),
(519, '', 'A3', 0.1, 1, '100plus Regular 1.5l', 1, 1, -1, 'FMNVMMAA100001.20210504111057', 'FMNVMMAA100001', '', 'online', '2021-05-04 04:11:02'),
(520, '', 'A4', 0.1, 1, '100plus Regular 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504111057', 'FMNVMMAA100001', '', 'online', '2021-05-04 04:11:05'),
(521, '', 'A1', 0.1, 1, '100plus Active 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504111117', 'FMNVMMAA100001', '', 'online', '2021-05-04 04:11:18'),
(522, '', 'A3', 0.1, 1, '100plus Regular 1.5l', 1, 1, -1, 'FMNVMMAA100001.20210504111117', 'FMNVMMAA100001', '', 'online', '2021-05-04 04:11:22'),
(523, '', 'A2', 0.1, 1, '100plus Lime 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504111117', 'FMNVMMAA100001', '', 'online', '2021-05-04 04:11:26'),
(524, '', 'A4', 0.1, 1, '100plus Regular 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504111138', 'FMNVMMAA100001', '', 'online', '2021-05-04 04:11:40'),
(525, '', 'A4', 0.1, 1, '100plus Regular 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504111138', 'FMNVMMAA100001', '', 'online', '2021-05-04 04:11:43'),
(526, '', 'A4', 0.1, 1, '100plus Regular 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504111138', 'FMNVMMAA100001', '', 'online', '2021-05-04 04:11:46'),
(527, '', 'A3', 0.1, 1, '100plus Regular 1.5l', 1, 1, -1, 'FMNVMMAA100001.20210504111156', 'FMNVMMAA100001', '', 'online', '2021-05-04 04:11:58'),
(528, '', 'A3', 0.1, 1, '100plus Regular 1.5l', 1, 1, -1, 'FMNVMMAA100001.20210504111156', 'FMNVMMAA100001', '', 'online', '2021-05-04 04:12:00'),
(529, '', 'A3', 0.1, 1, '100plus Regular 1.5l', 1, 1, -1, 'FMNVMMAA100001.20210504111156', 'FMNVMMAA100001', '', 'online', '2021-05-04 04:12:04'),
(530, '', 'A3', 0.1, 1, '100plus Regular 1.5l', 1, 1, -1, 'FMNVMMAA100001.20210504111213', 'FMNVMMAA100001', '', 'online', '2021-05-04 04:12:15'),
(531, '', 'A3', 0.1, 1, '100plus Regular 1.5l', 1, 1, -1, 'FMNVMMAA100001.20210504111213', 'FMNVMMAA100001', '', 'online', '2021-05-04 04:12:18'),
(532, '', 'A3', 0.1, 1, '100plus Regular 1.5l', 1, 1, -1, 'FMNVMMAA100001.20210504111213', 'FMNVMMAA100001', '', 'online', '2021-05-04 04:12:21'),
(533, '', 'A2', 0.1, 1, '100plus Lime 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504111231', 'FMNVMMAA100001', '', 'online', '2021-05-04 04:12:33'),
(534, '', 'A2', 0.1, 1, '100plus Lime 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504111231', 'FMNVMMAA100001', '', 'online', '2021-05-04 04:12:36'),
(535, '', 'A2', 0.1, 1, '100plus Lime 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504111231', 'FMNVMMAA100001', '', 'online', '2021-05-04 04:12:39'),
(536, '', 'A1', 0.1, 1, '100plus Active 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504111250', 'FMNVMMAA100001', '', 'online', '2021-05-04 04:12:52'),
(537, '', 'A2', 0.1, 1, '100plus Lime 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504111250', 'FMNVMMAA100001', '', 'online', '2021-05-04 04:12:55'),
(538, '', 'A1', 0.1, 1, '100plus Active 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504111250', 'FMNVMMAA100001', '', 'online', '2021-05-04 04:12:58'),
(539, '', 'A2', 0.1, 1, '100plus Lime 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504111308', 'FMNVMMAA100001', '', 'online', '2021-05-04 04:13:10'),
(540, '', 'A3', 0.1, 1, '100plus Regular 1.5l', 1, 1, -1, 'FMNVMMAA100001.20210504111308', 'FMNVMMAA100001', '', 'online', '2021-05-04 04:13:13'),
(541, '', 'A2', 0.1, 1, '100plus Lime 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504111308', 'FMNVMMAA100001', '', 'online', '2021-05-04 04:13:16'),
(542, '', 'A2', 0.1, 1, '100plus Lime 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504112356', 'FMNVMMAA100001', '', 'online', '2021-05-04 04:23:58'),
(543, '', 'A3', 0.1, 1, '100plus Regular 1.5l', 1, 1, -1, 'FMNVMMAA100001.20210504112356', 'FMNVMMAA100001', '', 'online', '2021-05-04 04:24:01'),
(544, '', 'A3', 0.1, 1, '100plus Regular 1.5l', 1, 1, -1, 'FMNVMMAA100001.20210504112734', 'FMNVMMAA100001', '', 'online', '2021-05-04 04:27:36'),
(545, '', 'A4', 0.1, 1, '100plus Regular 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504112734', 'FMNVMMAA100001', '', 'online', '2021-05-04 04:27:39'),
(546, '', 'A5', 1, 1, 'Authentic Tea House Ayataka Green Tea 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504112734', 'FMNVMMAA100001', '', 'online', '2021-05-04 04:27:42'),
(547, '', 'A1', 0.1, 1, '100plus Active 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504112754', 'FMNVMMAA100001', '', 'online', '2021-05-04 04:27:55'),
(548, '', 'A2', 0.1, 1, '100plus Lime 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504112754', 'FMNVMMAA100001', '', 'online', '2021-05-04 04:28:00'),
(549, '', 'A1', 0.1, 1, '100plus Active 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504114645', 'FMNVMMAA100001', '', 'online', '2021-05-04 04:46:46'),
(550, '', 'A2', 0.1, 1, '100plus Lime 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504114645', 'FMNVMMAA100001', '', 'online', '2021-05-04 04:46:50'),
(551, '', 'A2', 0.1, 1, '100plus Lime 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504114645', 'FMNVMMAA100001', '', 'online', '2021-05-04 04:46:53'),
(552, '', 'A1', 0.1, 1, '100plus Active 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504114705', 'FMNVMMAA100001', '', 'online', '2021-05-04 04:47:07'),
(553, '', 'A2', 0.1, 1, '100plus Lime 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504114705', 'FMNVMMAA100001', '', 'online', '2021-05-04 04:47:10'),
(554, '', 'A2', 0.1, 1, '100plus Lime 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504114705', 'FMNVMMAA100001', '', 'online', '2021-05-04 04:47:13'),
(555, '', 'A3', 0.1, 1, '100plus Regular 1.5l', 1, 1, -1, 'FMNVMMAA100001.20210504114722', 'FMNVMMAA100001', '', 'online', '2021-05-04 04:47:24'),
(556, '', 'A2', 0.1, 1, '100plus Lime 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504114722', 'FMNVMMAA100001', '', 'online', '2021-05-04 04:47:27'),
(557, '', 'A4', 0.1, 1, '100plus Regular 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504114722', 'FMNVMMAA100001', '', 'online', '2021-05-04 04:47:30'),
(558, '', 'E1', 2.5, 1, '100plus Regular 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504121431', 'FMNVMMAA100001', '', 'online', '2021-05-04 05:14:31'),
(559, '', 'A2', 0.1, 1, '100plus Lime 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504121431', 'FMNVMMAA100001', '', 'online', '2021-05-04 05:14:33'),
(560, '', 'A3', 0.1, 1, '100plus Regular 1.5l', 1, 1, -1, 'FMNVMMAA100001.20210504121431', 'FMNVMMAA100001', '', 'online', '2021-05-04 05:14:35'),
(561, '', 'A1', 0.1, 1, '100plus Active 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504121516', 'FMNVMMAA100001', '', 'online', '2021-05-04 05:15:16'),
(562, '', 'A2', 0.1, 1, '100plus Lime 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504121516', 'FMNVMMAA100001', '', 'online', '2021-05-04 05:15:18'),
(563, '', 'A3', 0.1, 1, '100plus Regular 1.5l', 1, 1, -1, 'FMNVMMAA100001.20210504121516', 'FMNVMMAA100001', '', 'online', '2021-05-04 05:15:20'),
(564, '', 'A1', 0.1, 1, '100plus Active 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504121535', 'FMNVMMAA100001', '', 'online', '2021-05-04 05:15:35'),
(565, '', 'A2', 0.1, 1, '100plus Lime 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504121535', 'FMNVMMAA100001', '', 'online', '2021-05-04 05:15:37'),
(566, '', 'A1', 0.1, 1, '100plus Active 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504125603', 'FMNVMMAA100001', '', 'online', '2021-05-04 05:56:04'),
(567, '', 'A1', 0.1, 1, '100plus Active 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504125603', 'FMNVMMAA100001', '', 'online', '2021-05-04 05:56:07'),
(568, '', 'A2', 0.1, 1, '100plus Lime 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504125603', 'FMNVMMAA100001', '', 'online', '2021-05-04 05:56:09'),
(569, '', 'A2', 0.1, 1, '100plus Lime 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504125620', 'FMNVMMAA100001', '', 'online', '2021-05-04 05:56:22'),
(570, '', 'A2', 0.1, 1, '100plus Lime 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504125620', 'FMNVMMAA100001', '', 'online', '2021-05-04 05:56:25'),
(571, '', 'A3', 0.1, 1, '100plus Regular 1.5l', 1, 1, -1, 'FMNVMMAA100001.20210504125620', 'FMNVMMAA100001', '', 'online', '2021-05-04 05:56:27'),
(572, '', 'A3', 0.1, 1, '100plus Regular 1.5l', 1, 1, -1, 'FMNVMMAA100001.20210504125638', 'FMNVMMAA100001', '', 'online', '2021-05-04 05:56:40'),
(573, '', 'A1', 0.1, 1, '100plus Active 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504125638', 'FMNVMMAA100001', '', 'online', '2021-05-04 05:56:43'),
(574, '', 'A4', 0.1, 1, '100plus Regular 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504125638', 'FMNVMMAA100001', '', 'online', '2021-05-04 05:56:47'),
(575, '', 'A1', 0.1, 1, '100plus Active 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504130302', 'FMNVMMAA100001', '', 'online', '2021-05-04 06:03:04'),
(576, '', 'A2', 0.1, 1, '100plus Lime 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504130302', 'FMNVMMAA100001', '', 'online', '2021-05-04 06:03:07'),
(577, '', 'A3', 0.1, 1, '100plus Regular 1.5l', 1, 1, -1, 'FMNVMMAA100001.20210504130444', 'FMNVMMAA100001', '', 'online', '2021-05-04 06:04:52'),
(578, '', 'A4', 0.1, 1, '100plus Regular 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504130503', 'FMNVMMAA100001', '', 'online', '2021-05-04 06:05:05'),
(579, '', 'A5', 0.1, 1, 'Authentic Tea House Ayataka Green Tea 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504130503', 'FMNVMMAA100001', '', 'online', '2021-05-04 06:05:08'),
(580, '', 'A1', 0.1, 1, '100plus Active 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504130503', 'FMNVMMAA100001', '', 'online', '2021-05-04 06:05:11'),
(581, '', 'A1', 0.1, 1, '100plus Active 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504130539', 'FMNVMMAA100001', '', 'online', '2021-05-04 06:05:41'),
(582, '', 'A2', 0.1, 1, '100plus Lime 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504130539', 'FMNVMMAA100001', '', 'online', '2021-05-04 06:05:44'),
(583, '', 'A3', 0.1, 1, '100plus Regular 1.5l', 1, 1, -1, 'FMNVMMAA100001.20210504130539', 'FMNVMMAA100001', '', 'online', '2021-05-04 06:05:48'),
(584, '', 'A3', 0.1, 1, '100plus Regular 1.5l', 1, 1, -1, 'FMNVMMAA100001.20210504130600', 'FMNVMMAA100001', '', 'online', '2021-05-04 06:06:01'),
(585, '', 'A4', 0.1, 1, '100plus Regular 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504130600', 'FMNVMMAA100001', '', 'online', '2021-05-04 06:06:05'),
(586, '', 'A5', 1, 1, 'Authentic Tea House Ayataka Green Tea 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504130600', 'FMNVMMAA100001', '', 'online', '2021-05-04 06:06:08'),
(587, '', 'A1', 0.1, 1, '100plus Active 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504130708', 'FMNVMMAA100001', '', 'online', '2021-05-04 06:07:16'),
(588, '', 'A2', 0.1, 1, '100plus Lime 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504130727', 'FMNVMMAA100001', '', 'online', '2021-05-04 06:07:29'),
(589, '', 'A3', 0.1, 1, '100plus Regular 1.5l', 1, 1, -1, 'FMNVMMAA100001.20210504130727', 'FMNVMMAA100001', '', 'online', '2021-05-04 06:07:32'),
(590, '', 'A4', 0.1, 1, '100plus Regular 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504130727', 'FMNVMMAA100001', '', 'online', '2021-05-04 06:07:35'),
(591, '', 'A3', 0.1, 1, '100plus Regular 1.5l', 1, 1, -1, 'FMNVMMAA100001.20210504130751', 'FMNVMMAA100001', '', 'online', '2021-05-04 06:07:52'),
(592, '', 'A4', 0.1, 1, '100plus Regular 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504130751', 'FMNVMMAA100001', '', 'online', '2021-05-04 06:07:56'),
(593, '', 'A5', 1, 1, 'Authentic Tea House Ayataka Green Tea 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504130751', 'FMNVMMAA100001', '', 'online', '2021-05-04 06:07:59'),
(594, '', 'A1', 0.1, 1, '100plus Active 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504130817', 'FMNVMMAA100001', '', 'online', '2021-05-04 06:08:19'),
(595, '', 'A2', 0.1, 1, '100plus Lime 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504130817', 'FMNVMMAA100001', '', 'online', '2021-05-04 06:08:22'),
(596, '', 'A3', 0.1, 1, '100plus Regular 1.5l', 1, 1, -1, 'FMNVMMAA100001.20210504130817', 'FMNVMMAA100001', '', 'online', '2021-05-04 06:08:25'),
(597, '', 'A3', 0.1, 1, '100plus Regular 1.5l', 1, 1, -1, 'FMNVMMAA100001.20210504130836', 'FMNVMMAA100001', '', 'online', '2021-05-04 06:08:37'),
(598, '', 'A4', 0.1, 1, '100plus Regular 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504130836', 'FMNVMMAA100001', '', 'online', '2021-05-04 06:08:41'),
(599, '', 'A5', 1, 1, 'Authentic Tea House Ayataka Green Tea 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504130836', 'FMNVMMAA100001', '', 'online', '2021-05-04 06:08:44'),
(600, '', 'A1', 0.1, 1, '100plus Active 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504130949', 'FMNVMMAA100001', '', 'online', '2021-05-04 06:09:50'),
(601, '', 'A2', 0.1, 1, '100plus Lime 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504130949', 'FMNVMMAA100001', '', 'online', '2021-05-04 06:09:55'),
(602, '', 'A3', 0.1, 1, '100plus Regular 1.5l', 1, 1, -1, 'FMNVMMAA100001.20210504130949', 'FMNVMMAA100001', '', 'online', '2021-05-04 06:09:58'),
(603, '', 'A2', 0.1, 1, '100plus Lime 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504131042', 'FMNVMMAA100001', '', 'online', '2021-05-04 06:10:44'),
(604, '', 'A3', 0.1, 1, '100plus Regular 1.5l', 1, 1, -1, 'FMNVMMAA100001.20210504131042', 'FMNVMMAA100001', '', 'online', '2021-05-04 06:10:47'),
(605, '', 'A1', 0.1, 1, '100plus Active 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504131042', 'FMNVMMAA100001', '', 'online', '2021-05-04 06:10:52'),
(606, '', 'A1', 0.1, 1, '100plus Active 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504131124', 'FMNVMMAA100001', '', 'online', '2021-05-04 06:11:26'),
(607, '', 'A2', 0.1, 1, '100plus Lime 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504131124', 'FMNVMMAA100001', '', 'online', '2021-05-04 06:11:29'),
(608, '', 'A3', 0.1, 1, '100plus Regular 1.5l', 1, 1, -1, 'FMNVMMAA100001.20210504131124', 'FMNVMMAA100001', '', 'online', '2021-05-04 06:11:32'),
(609, '', 'A2', 0.1, 1, '100plus Lime 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504131252', 'FMNVMMAA100001', '', 'online', '2021-05-04 06:12:54'),
(610, '', 'A1', 0.1, 1, '100plus Active 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504131252', 'FMNVMMAA100001', '', 'online', '2021-05-04 06:12:57'),
(611, '', 'A3', 0.1, 1, '100plus Regular 1.5l', 1, 1, -1, 'FMNVMMAA100001.20210504131252', 'FMNVMMAA100001', '', 'online', '2021-05-04 06:13:00'),
(612, '', 'A1', 0.1, 1, '100plus Active 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504131319', 'FMNVMMAA100001', '', 'online', '2021-05-04 06:13:20'),
(613, '', 'A2', 0.1, 1, '100plus Lime 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504131319', 'FMNVMMAA100001', '', 'online', '2021-05-04 06:13:23'),
(614, '', 'A3', 0.1, 1, '100plus Regular 1.5l', 1, 1, -1, 'FMNVMMAA100001.20210504131319', 'FMNVMMAA100001', '', 'online', '2021-05-04 06:13:27'),
(615, '', 'A1', 0.1, 1, '100plus Active 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504131337', 'FMNVMMAA100001', '', 'online', '2021-05-04 06:13:39'),
(616, '', 'A2', 0.1, 1, '100plus Lime 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504131337', 'FMNVMMAA100001', '', 'online', '2021-05-04 06:13:42'),
(617, '', 'A3', 0.1, 1, '100plus Regular 1.5l', 1, 1, -1, 'FMNVMMAA100001.20210504131337', 'FMNVMMAA100001', '', 'online', '2021-05-04 06:13:45'),
(618, '', 'A1', 0.1, 1, '100plus Active 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504131444', 'FMNVMMAA100001', '', 'online', '2021-05-04 06:14:49'),
(619, '', 'A2', 0.1, 1, '100plus Lime 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504131444', 'FMNVMMAA100001', '', 'online', '2021-05-04 06:14:52'),
(620, '', 'A3', 0.1, 1, '100plus Regular 1.5l', 1, 1, -1, 'FMNVMMAA100001.20210504131504', 'FMNVMMAA100001', '', 'online', '2021-05-04 06:15:06'),
(621, '', 'A4', 0.1, 1, '100plus Regular 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504131504', 'FMNVMMAA100001', '', 'online', '2021-05-04 06:15:10'),
(622, '', 'A5', 1, 1, 'Authentic Tea House Ayataka Green Tea 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504131504', 'FMNVMMAA100001', '', 'online', '2021-05-04 06:15:13'),
(623, '', 'A1', 0.1, 1, '100plus Active 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504131525', 'FMNVMMAA100001', '', 'online', '2021-05-04 06:15:26'),
(624, '', 'A2', 0.1, 1, '100plus Lime 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504131525', 'FMNVMMAA100001', '', 'online', '2021-05-04 06:15:30'),
(625, '', 'A3', 0.1, 1, '100plus Regular 1.5l', 1, 1, -1, 'FMNVMMAA100001.20210504131525', 'FMNVMMAA100001', '', 'online', '2021-05-04 06:15:33'),
(626, '', 'A1', 0.1, 1, '100plus Active 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504131543', 'FMNVMMAA100001', '', 'online', '2021-05-04 06:15:44'),
(627, '', 'A2', 0.1, 1, '100plus Lime 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504131543', 'FMNVMMAA100001', '', 'online', '2021-05-04 06:15:47'),
(628, '', 'A5', 1, 1, 'Authentic Tea House Ayataka Green Tea 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504131543', 'FMNVMMAA100001', '', 'online', '2021-05-04 06:15:51'),
(629, '', 'A1', 0.1, 1, '100plus Active 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504131605', 'FMNVMMAA100001', '', 'online', '2021-05-04 06:16:06'),
(630, '', 'A2', 0.1, 1, '100plus Lime 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504131605', 'FMNVMMAA100001', '', 'online', '2021-05-04 06:16:09'),
(631, '', 'A3', 0.1, 1, '100plus Regular 1.5l', 1, 1, -1, 'FMNVMMAA100001.20210504131605', 'FMNVMMAA100001', '', 'online', '2021-05-04 06:16:13'),
(632, '', 'A3', 0.1, 1, '100plus Regular 1.5l', 1, 1, -1, 'FMNVMMAA100001.20210504131622', 'FMNVMMAA100001', '', 'online', '2021-05-04 06:16:23'),
(633, '', 'A4', 0.1, 1, '100plus Regular 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504131622', 'FMNVMMAA100001', '', 'online', '2021-05-04 06:16:27'),
(634, '', 'A5', 1, 1, 'Authentic Tea House Ayataka Green Tea 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504131622', 'FMNVMMAA100001', '', 'online', '2021-05-04 06:16:30'),
(635, '', 'A1', 0.1, 1, '100plus Active 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504131847', 'FMNVMMAA100001', '', 'online', '2021-05-04 06:18:48'),
(636, '', 'A2', 0.1, 1, '100plus Lime 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504131847', 'FMNVMMAA100001', '', 'online', '2021-05-04 06:18:52'),
(637, '', 'A3', 0.1, 1, '100plus Regular 1.5l', 1, 1, -1, 'FMNVMMAA100001.20210504131847', 'FMNVMMAA100001', '', 'online', '2021-05-04 06:18:55'),
(638, '', 'A1', 0.1, 1, '100plus Active 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504131915', 'FMNVMMAA100001', '', 'online', '2021-05-04 06:19:17'),
(639, '', 'A2', 0.1, 1, '100plus Lime 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504131915', 'FMNVMMAA100001', '', 'online', '2021-05-04 06:19:20'),
(640, '', 'A3', 0.1, 1, '100plus Regular 1.5l', 1, 1, -1, 'FMNVMMAA100001.20210504131915', 'FMNVMMAA100001', '', 'online', '2021-05-04 06:19:23');
INSERT INTO `db_sales_record` (`id`, `transaction_serial`, `slot_number`, `price`, `quantity`, `product_name`, `drop_sensor_status`, `payment_method`, `self_defined_payment_method`, `order_number`, `machine_id`, `product_url`, `report_status`, `date_time`) VALUES
(641, '', 'A1', 0.1, 1, '100plus Active 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504131935', 'FMNVMMAA100001', '', 'online', '2021-05-04 06:19:37'),
(642, '', 'A2', 0.1, 1, '100plus Lime 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504131935', 'FMNVMMAA100001', '', 'online', '2021-05-04 06:19:40'),
(643, '', 'A3', 0.1, 1, '100plus Regular 1.5l', 1, 1, -1, 'FMNVMMAA100001.20210504131935', 'FMNVMMAA100001', '', 'online', '2021-05-04 06:19:43'),
(644, '', 'A3', 0.1, 1, '100plus Regular 1.5l', 1, 1, -1, 'FMNVMMAA100001.20210504131955', 'FMNVMMAA100001', '', 'online', '2021-05-04 06:19:57'),
(645, '', 'A4', 0.1, 1, '100plus Regular 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504131955', 'FMNVMMAA100001', '', 'online', '2021-05-04 06:20:00'),
(646, '', 'A5', 1, 1, 'Authentic Tea House Ayataka Green Tea 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504131955', 'FMNVMMAA100001', '', 'online', '2021-05-04 06:20:04'),
(647, '', 'A1', 0.1, 1, '100plus Active 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504132019', 'FMNVMMAA100001', '', 'online', '2021-05-04 06:20:21'),
(648, '', 'A2', 0.1, 1, '100plus Lime 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504132019', 'FMNVMMAA100001', '', 'online', '2021-05-04 06:20:24'),
(649, '', 'A3', 0.1, 1, '100plus Regular 1.5l', 1, 1, -1, 'FMNVMMAA100001.20210504132019', 'FMNVMMAA100001', '', 'online', '2021-05-04 06:20:27'),
(650, '', 'A1', 0.1, 1, '100plus Active 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504132050', 'FMNVMMAA100001', '', 'online', '2021-05-04 06:20:51'),
(651, '', 'A2', 0.1, 1, '100plus Lime 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504132050', 'FMNVMMAA100001', '', 'online', '2021-05-04 06:20:55'),
(652, '', 'A3', 0.1, 1, '100plus Regular 1.5l', 1, 1, -1, 'FMNVMMAA100001.20210504132050', 'FMNVMMAA100001', '', 'online', '2021-05-04 06:20:58'),
(653, '', 'A1', 0.1, 1, '100plus Active 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504132113', 'FMNVMMAA100001', '', 'online', '2021-05-04 06:21:14'),
(654, '', 'A2', 0.1, 1, '100plus Lime 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504132113', 'FMNVMMAA100001', '', 'online', '2021-05-04 06:21:18'),
(655, '', 'A3', 0.1, 1, '100plus Regular 1.5l', 1, 1, -1, 'FMNVMMAA100001.20210504132113', 'FMNVMMAA100001', '', 'online', '2021-05-04 06:21:21'),
(656, '', 'A1', 0.1, 1, '100plus Active 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504132252', 'FMNVMMAA100001', '', 'online', '2021-05-04 06:22:54'),
(657, '', 'A2', 0.1, 1, '100plus Lime 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504132252', 'FMNVMMAA100001', '', 'online', '2021-05-04 06:22:57'),
(658, '', 'A5', 1, 1, 'Authentic Tea House Ayataka Green Tea 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504132252', 'FMNVMMAA100001', '', 'online', '2021-05-04 06:23:00'),
(659, '', 'A1', 0.1, 1, '100plus Active 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504132313', 'FMNVMMAA100001', '', 'online', '2021-05-04 06:23:14'),
(660, '', 'A2', 0.1, 1, '100plus Lime 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504132313', 'FMNVMMAA100001', '', 'online', '2021-05-04 06:23:18'),
(661, '', 'A3', 0.1, 1, '100plus Regular 1.5l', 1, 1, -1, 'FMNVMMAA100001.20210504132313', 'FMNVMMAA100001', '', 'online', '2021-05-04 06:23:21'),
(662, '', 'A1', 0.1, 1, '100plus Active 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504132332', 'FMNVMMAA100001', '', 'online', '2021-05-04 06:23:33'),
(663, '', 'A2', 0.1, 1, '100plus Lime 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504132332', 'FMNVMMAA100001', '', 'online', '2021-05-04 06:23:37'),
(664, '', 'A3', 0.1, 1, '100plus Regular 1.5l', 1, 1, -1, 'FMNVMMAA100001.20210504132332', 'FMNVMMAA100001', '', 'online', '2021-05-04 06:23:40'),
(665, '', 'A1', 0.1, 1, '100plus Active 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504132413', 'FMNVMMAA100001', '', 'online', '2021-05-04 06:24:15'),
(666, '', 'A2', 0.1, 1, '100plus Lime 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504132413', 'FMNVMMAA100001', '', 'online', '2021-05-04 06:24:20'),
(667, '', 'A3', 0.1, 1, '100plus Regular 1.5l', 1, 1, -1, 'FMNVMMAA100001.20210504132413', 'FMNVMMAA100001', '', 'online', '2021-05-04 06:24:23'),
(668, '', 'A2', 0.1, 1, '100plus Lime 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504132437', 'FMNVMMAA100001', '', 'online', '2021-05-04 06:24:38'),
(669, '', 'A2', 0.1, 1, '100plus Lime 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504132437', 'FMNVMMAA100001', '', 'online', '2021-05-04 06:24:42'),
(670, '', 'A2', 0.1, 1, '100plus Lime 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504132437', 'FMNVMMAA100001', '', 'online', '2021-05-04 06:24:45'),
(671, '', 'A2', 0.1, 1, '100plus Lime 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504132513', 'FMNVMMAA100001', '', 'online', '2021-05-04 06:25:14'),
(672, '', 'A2', 0.1, 1, '100plus Lime 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504132513', 'FMNVMMAA100001', '', 'online', '2021-05-04 06:25:18'),
(673, '', 'A2', 0.1, 1, '100plus Lime 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504132513', 'FMNVMMAA100001', '', 'online', '2021-05-04 06:25:21'),
(674, '', 'A2', 0.1, 1, '100plus Lime 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504132530', 'FMNVMMAA100001', '', 'online', '2021-05-04 06:25:31'),
(675, '', 'A2', 0.1, 1, '100plus Lime 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504132530', 'FMNVMMAA100001', '', 'online', '2021-05-04 06:25:35'),
(676, '', 'A2', 0.1, 1, '100plus Lime 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504132530', 'FMNVMMAA100001', '', 'online', '2021-05-04 06:25:38'),
(677, '', 'A2', 0.1, 1, '100plus Lime 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504132551', 'FMNVMMAA100001', '', 'online', '2021-05-04 06:25:52'),
(678, '', 'A2', 0.1, 1, '100plus Lime 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504132551', 'FMNVMMAA100001', '', 'online', '2021-05-04 06:25:55'),
(679, '', 'A2', 0.1, 1, '100plus Lime 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504132551', 'FMNVMMAA100001', '', 'online', '2021-05-04 06:25:59'),
(680, '', 'A2', 0.1, 1, '100plus Lime 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504132612', 'FMNVMMAA100001', '', 'online', '2021-05-04 06:26:14'),
(681, '', 'A2', 0.1, 1, '100plus Lime 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504132612', 'FMNVMMAA100001', '', 'online', '2021-05-04 06:26:17'),
(682, '', 'A2', 0.1, 1, '100plus Lime 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504132612', 'FMNVMMAA100001', '', 'online', '2021-05-04 06:26:20'),
(683, '', 'A2', 0.1, 1, '100plus Lime 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504132715', 'FMNVMMAA100001', '', 'online', '2021-05-04 06:27:15'),
(684, '', 'A2', 0.1, 1, '100plus Lime 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504132715', 'FMNVMMAA100001', '', 'online', '2021-05-04 06:27:17'),
(685, '', 'A2', 0.1, 1, '100plus Lime 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504132715', 'FMNVMMAA100001', '', 'online', '2021-05-04 06:27:19'),
(686, '', 'A2', 0.1, 1, '100plus Lime 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504132849', 'FMNVMMAA100001', '', 'online', '2021-05-04 06:28:51'),
(687, '', 'A2', 0.1, 1, '100plus Lime 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504132849', 'FMNVMMAA100001', '', 'online', '2021-05-04 06:28:54'),
(688, '', 'A2', 0.1, 1, '100plus Lime 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504132849', 'FMNVMMAA100001', '', 'online', '2021-05-04 06:28:57'),
(689, '', 'A2', 0.1, 1, '100plus Lime 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504132916', 'FMNVMMAA100001', '', 'online', '2021-05-04 06:29:18'),
(690, '', 'A2', 0.1, 1, '100plus Lime 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504132916', 'FMNVMMAA100001', '', 'online', '2021-05-04 06:29:21'),
(691, '', 'A2', 0.1, 1, '100plus Lime 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504132916', 'FMNVMMAA100001', '', 'online', '2021-05-04 06:29:24'),
(692, '', 'A1', 0.1, 1, '100plus Active 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504132935', 'FMNVMMAA100001', '', 'online', '2021-05-04 06:29:36'),
(693, '', 'A2', 0.1, 1, '100plus Lime 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504132935', 'FMNVMMAA100001', '', 'online', '2021-05-04 06:29:40'),
(694, '', 'A3', 0.1, 1, '100plus Regular 1.5l', 1, 1, -1, 'FMNVMMAA100001.20210504132935', 'FMNVMMAA100001', '', 'online', '2021-05-04 06:29:43'),
(695, '', 'A1', 0.1, 1, '100plus Active 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504132953', 'FMNVMMAA100001', '', 'online', '2021-05-04 06:29:55'),
(696, '', 'A2', 0.1, 1, '100plus Lime 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504132953', 'FMNVMMAA100001', '', 'online', '2021-05-04 06:29:58'),
(697, '', 'A3', 0.1, 1, '100plus Regular 1.5l', 1, 1, -1, 'FMNVMMAA100001.20210504132953', 'FMNVMMAA100001', '', 'online', '2021-05-04 06:30:01'),
(698, '', 'A1', 0.1, 1, '100plus Active 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504133011', 'FMNVMMAA100001', '', 'online', '2021-05-04 06:30:14'),
(699, '', 'A2', 0.1, 1, '100plus Lime 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504133011', 'FMNVMMAA100001', '', 'online', '2021-05-04 06:30:18'),
(700, '', 'A3', 0.1, 1, '100plus Regular 1.5l', 1, 1, -1, 'FMNVMMAA100001.20210504133011', 'FMNVMMAA100001', '', 'online', '2021-05-04 06:30:21'),
(701, '', 'A1', 0.1, 1, '100plus Active 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504133312', 'FMNVMMAA100001', '', 'online', '2021-05-04 06:33:14'),
(702, '', 'A2', 0.1, 1, '100plus Lime 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504133312', 'FMNVMMAA100001', '', 'online', '2021-05-04 06:33:17'),
(703, '', 'A3', 0.1, 1, '100plus Regular 1.5l', 1, 1, -1, 'FMNVMMAA100001.20210504133312', 'FMNVMMAA100001', '', 'online', '2021-05-04 06:33:20'),
(704, '', 'A4', 0.1, 1, '100plus Regular 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504133340', 'FMNVMMAA100001', '', 'online', '2021-05-04 06:33:42'),
(705, '', 'A5', 0.1, 1, 'Authentic Tea House Ayataka Green Tea 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504133340', 'FMNVMMAA100001', '', 'online', '2021-05-04 06:33:45'),
(706, '', 'A1', 0.1, 1, '100plus Active 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504133430', 'FMNVMMAA100001', '', 'online', '2021-05-04 06:34:38'),
(707, '', 'A1', 0.1, 1, '100plus Active 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504133512', 'FMNVMMAA100001', '', 'online', '2021-05-04 06:35:14'),
(708, '', 'A2', 0.1, 1, '100plus Lime 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504133512', 'FMNVMMAA100001', '', 'online', '2021-05-04 06:35:17'),
(709, '', 'A3', 0.1, 1, '100plus Regular 1.5l', 1, 1, -1, 'FMNVMMAA100001.20210504133512', 'FMNVMMAA100001', '', 'online', '2021-05-04 06:35:20'),
(710, '', 'A1', 0.1, 1, '100plus Active 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504133539', 'FMNVMMAA100001', '', 'online', '2021-05-04 06:35:41'),
(711, '', 'A4', 0.1, 1, '100plus Regular 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504133539', 'FMNVMMAA100001', '', 'online', '2021-05-04 06:35:44'),
(712, '', 'A5', 1, 1, 'Authentic Tea House Ayataka Green Tea 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504133539', 'FMNVMMAA100001', '', 'online', '2021-05-04 06:35:48'),
(713, '', 'A1', 0.1, 1, '100plus Active 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504133610', 'FMNVMMAA100001', '', 'online', '2021-05-04 06:36:12'),
(714, '', 'A2', 0.1, 1, '100plus Lime 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504133610', 'FMNVMMAA100001', '', 'online', '2021-05-04 06:36:15'),
(715, '', 'A3', 0.1, 1, '100plus Regular 1.5l', 1, 1, -1, 'FMNVMMAA100001.20210504133610', 'FMNVMMAA100001', '', 'online', '2021-05-04 06:36:19'),
(716, '', 'A1', 0.1, 1, '100plus Active 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504133633', 'FMNVMMAA100001', '', 'online', '2021-05-04 06:36:35'),
(717, '', 'A2', 0.1, 1, '100plus Lime 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504133633', 'FMNVMMAA100001', '', 'online', '2021-05-04 06:36:38'),
(718, '', 'A4', 0.1, 1, '100plus Regular 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504133633', 'FMNVMMAA100001', '', 'online', '2021-05-04 06:36:42'),
(719, '', 'A2', 0.1, 1, '100plus Lime 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504133659', 'FMNVMMAA100001', '', 'online', '2021-05-04 06:37:00'),
(720, '', 'A3', 0.1, 1, '100plus Regular 1.5l', 1, 1, -1, 'FMNVMMAA100001.20210504133659', 'FMNVMMAA100001', '', 'online', '2021-05-04 06:37:03'),
(721, '', 'A5', 1, 1, 'Authentic Tea House Ayataka Green Tea 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504133659', 'FMNVMMAA100001', '', 'online', '2021-05-04 06:37:06'),
(722, '', 'A4', 0.1, 1, '100plus Regular 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504133717', 'FMNVMMAA100001', '', 'online', '2021-05-04 06:37:19'),
(723, '', 'A4', 0.1, 1, '100plus Regular 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504133717', 'FMNVMMAA100001', '', 'online', '2021-05-04 06:37:22'),
(724, '', 'A4', 0.1, 1, '100plus Regular 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504133717', 'FMNVMMAA100001', '', 'online', '2021-05-04 06:37:26'),
(725, '', 'A5', 0.1, 1, 'Authentic Tea House Ayataka Green Tea 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504133754', 'FMNVMMAA100001', '', 'online', '2021-05-04 06:37:56'),
(726, '', 'A1', 0.1, 1, '100plus Active 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504133754', 'FMNVMMAA100001', '', 'online', '2021-05-04 06:37:59'),
(727, '', 'A1', 0.1, 1, '100plus Active 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504133826', 'FMNVMMAA100001', '', 'online', '2021-05-04 06:38:27'),
(728, '', 'A2', 0.1, 1, '100plus Lime 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504133826', 'FMNVMMAA100001', '', 'online', '2021-05-04 06:38:30'),
(729, '', 'A3', 0.1, 1, '100plus Regular 1.5l', 1, 1, -1, 'FMNVMMAA100001.20210504133826', 'FMNVMMAA100001', '', 'online', '2021-05-04 06:38:34'),
(730, '', 'A1', 0.1, 1, '100plus Active 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504133846', 'FMNVMMAA100001', '', 'online', '2021-05-04 06:38:47'),
(731, '', 'A2', 0.1, 1, '100plus Lime 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504133846', 'FMNVMMAA100001', '', 'online', '2021-05-04 06:38:51'),
(732, '', 'A3', 0.1, 1, '100plus Regular 1.5l', 1, 1, -1, 'FMNVMMAA100001.20210504133846', 'FMNVMMAA100001', '', 'online', '2021-05-04 06:38:54'),
(733, '', 'A5', 0.1, 1, 'Authentic Tea House Ayataka Green Tea 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504133919', 'FMNVMMAA100001', '', 'online', '2021-05-04 06:39:21'),
(734, '', 'A1', 0.1, 1, '100plus Active 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504134128', 'FMNVMMAA100001', '', 'online', '2021-05-04 06:41:29'),
(735, '', 'A1', 0.1, 1, '100plus Active 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504134128', 'FMNVMMAA100001', '', 'online', '2021-05-04 06:41:32'),
(736, '', 'A1', 0.1, 1, '100plus Active 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504134128', 'FMNVMMAA100001', '', 'online', '2021-05-04 06:41:36'),
(737, '', 'A1', 0.1, 1, '100plus Active 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504134155', 'FMNVMMAA100001', '', 'online', '2021-05-04 06:41:57'),
(738, '', 'A1', 0.1, 1, '100plus Active 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504134155', 'FMNVMMAA100001', '', 'online', '2021-05-04 06:42:00'),
(739, '', 'A1', 0.1, 1, '100plus Active 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504134155', 'FMNVMMAA100001', '', 'online', '2021-05-04 06:42:03'),
(740, '', 'A1', 0.1, 1, '100plus Active 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504134214', 'FMNVMMAA100001', '', 'online', '2021-05-04 06:42:16'),
(741, '', 'A1', 0.1, 1, '100plus Active 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504134214', 'FMNVMMAA100001', '', 'online', '2021-05-04 06:42:19'),
(742, '', 'A1', 0.1, 1, '100plus Active 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504134214', 'FMNVMMAA100001', '', 'online', '2021-05-04 06:42:21'),
(743, '', 'A1', 0.1, 1, '100plus Active 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504140008', 'FMNVMMAA100001', '', 'online', '2021-05-04 07:00:09'),
(744, '', 'A2', 0.1, 1, '100plus Lime 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504140008', 'FMNVMMAA100001', '', 'online', '2021-05-04 07:00:12'),
(745, '', 'A3', 0.1, 1, '100plus Regular 1.5l', 1, 1, -1, 'FMNVMMAA100001.20210504140008', 'FMNVMMAA100001', '', 'online', '2021-05-04 07:00:15'),
(746, '', 'A1', 0.1, 1, '100plus Active 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504140024', 'FMNVMMAA100001', '', 'online', '2021-05-04 07:00:26'),
(747, '', 'A2', 0.1, 1, '100plus Lime 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504140024', 'FMNVMMAA100001', '', 'online', '2021-05-04 07:00:29'),
(748, '', 'A3', 0.1, 1, '100plus Regular 1.5l', 1, 1, -1, 'FMNVMMAA100001.20210504140024', 'FMNVMMAA100001', '', 'online', '2021-05-04 07:00:32'),
(749, '', 'A1', 0.1, 1, '100plus Active 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504140051', 'FMNVMMAA100001', '', 'online', '2021-05-04 07:00:52'),
(750, '', 'A2', 0.1, 1, '100plus Lime 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504140051', 'FMNVMMAA100001', '', 'online', '2021-05-04 07:00:55'),
(751, '', 'A3', 0.1, 1, '100plus Regular 1.5l', 1, 1, -1, 'FMNVMMAA100001.20210504140051', 'FMNVMMAA100001', '', 'online', '2021-05-04 07:00:59'),
(752, '', 'A4', 0.1, 1, '100plus Regular 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504140119', 'FMNVMMAA100001', '', 'online', '2021-05-04 07:01:21'),
(753, '', 'A5', 0.1, 1, 'Authentic Tea House Ayataka Green Tea 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504140119', 'FMNVMMAA100001', '', 'online', '2021-05-04 07:01:24'),
(754, '', 'A1', 0.1, 1, '100plus Active 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504140119', 'FMNVMMAA100001', '', 'online', '2021-05-04 07:01:28'),
(755, '', 'A1', 0.1, 1, '100plus Active 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504140718', 'FMNVMMAA100001', '', 'online', '2021-05-04 07:07:19'),
(756, '', 'A2', 0.1, 1, '100plus Lime 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504140718', 'FMNVMMAA100001', '', 'online', '2021-05-04 07:07:23'),
(757, '', 'A1', 0.1, 1, '100plus Active 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504140718', 'FMNVMMAA100001', '', 'online', '2021-05-04 07:07:26'),
(758, '', 'A1', 0.1, 1, '100plus Active 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504140747', 'FMNVMMAA100001', '', 'online', '2021-05-04 07:07:49'),
(759, '', 'A1', 0.1, 1, '100plus Active 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504140747', 'FMNVMMAA100001', '', 'online', '2021-05-04 07:07:52'),
(760, '', 'A1', 0.1, 1, '100plus Active 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504140747', 'FMNVMMAA100001', '', 'online', '2021-05-04 07:07:55'),
(761, '', 'A1', 0.1, 1, '100plus Active 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504140806', 'FMNVMMAA100001', '', 'online', '2021-05-04 07:08:08'),
(762, '', 'A1', 0.1, 1, '100plus Active 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504140806', 'FMNVMMAA100001', '', 'online', '2021-05-04 07:08:11'),
(763, '', 'A2', 0.1, 1, '100plus Lime 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504140806', 'FMNVMMAA100001', '', 'online', '2021-05-04 07:08:14'),
(764, '', 'A2', 0.1, 1, '100plus Lime 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504140825', 'FMNVMMAA100001', '', 'online', '2021-05-04 07:08:27'),
(765, '', 'A2', 0.1, 1, '100plus Lime 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504140825', 'FMNVMMAA100001', '', 'online', '2021-05-04 07:08:30'),
(766, '', 'A1', 0.1, 1, '100plus Active 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504140825', 'FMNVMMAA100001', '', 'online', '2021-05-04 07:08:33'),
(767, '', 'A2', 0.1, 1, '100plus Lime 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504140846', 'FMNVMMAA100001', '', 'online', '2021-05-04 07:08:47'),
(768, '', 'A2', 0.1, 1, '100plus Lime 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504140846', 'FMNVMMAA100001', '', 'online', '2021-05-04 07:08:50'),
(769, '', 'A3', 0.1, 1, '100plus Regular 1.5l', 1, 1, -1, 'FMNVMMAA100001.20210504140846', 'FMNVMMAA100001', '', 'online', '2021-05-04 07:08:54'),
(770, '', 'A3', 0.1, 1, '100plus Regular 1.5l', 1, 1, -1, 'FMNVMMAA100001.20210504140902', 'FMNVMMAA100001', '', 'online', '2021-05-04 07:09:03'),
(771, '', 'A3', 0.1, 1, '100plus Regular 1.5l', 1, 1, -1, 'FMNVMMAA100001.20210504140902', 'FMNVMMAA100001', '', 'online', '2021-05-04 07:09:06'),
(772, '', 'A3', 0.1, 1, '100plus Regular 1.5l', 1, 1, -1, 'FMNVMMAA100001.20210504140902', 'FMNVMMAA100001', '', 'online', '2021-05-04 07:09:10'),
(773, '', 'A4', 0.1, 1, '100plus Regular 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504140919', 'FMNVMMAA100001', '', 'online', '2021-05-04 07:09:20'),
(774, '', 'A4', 0.1, 1, '100plus Regular 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504140919', 'FMNVMMAA100001', '', 'online', '2021-05-04 07:09:24'),
(775, '', 'A4', 0.1, 1, '100plus Regular 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504140919', 'FMNVMMAA100001', '', 'online', '2021-05-04 07:09:27'),
(776, '', 'A4', 0.1, 1, '100plus Regular 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504140938', 'FMNVMMAA100001', '', 'online', '2021-05-04 07:09:40'),
(777, '', 'A5', 0.1, 1, 'Authentic Tea House Ayataka Green Tea 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504140938', 'FMNVMMAA100001', '', 'online', '2021-05-04 07:09:43'),
(778, '', 'A5', 1, 1, 'Authentic Tea House Ayataka Green Tea 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504140938', 'FMNVMMAA100001', '', 'online', '2021-05-04 07:09:46'),
(779, '', 'A1', 0.1, 1, '100plus Active 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504142232', 'FMNVMMAA100001', '', 'online', '2021-05-04 07:22:33'),
(780, '', 'A1', 0.1, 1, '100plus Active 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504142232', 'FMNVMMAA100001', '', 'online', '2021-05-04 07:22:36'),
(781, '', 'A1', 0.1, 1, '100plus Active 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504142232', 'FMNVMMAA100001', '', 'online', '2021-05-04 07:22:39'),
(782, '', 'A1', 0.1, 1, '100plus Active 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504142257', 'FMNVMMAA100001', '', 'online', '2021-05-04 07:22:58'),
(783, '', 'A1', 0.1, 1, '100plus Active 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504142257', 'FMNVMMAA100001', '', 'online', '2021-05-04 07:23:02'),
(784, '', 'A1', 0.1, 1, '100plus Active 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504142257', 'FMNVMMAA100001', '', 'online', '2021-05-04 07:23:05'),
(785, '', 'A3', 0.1, 1, '100plus Regular 1.5l', 1, 1, -1, 'FMNVMMAA100001.20210504142320', 'FMNVMMAA100001', '', 'online', '2021-05-04 07:23:21'),
(786, '', 'A3', 0.1, 1, '100plus Regular 1.5l', 1, 1, -1, 'FMNVMMAA100001.20210504142320', 'FMNVMMAA100001', '', 'online', '2021-05-04 07:23:25'),
(787, '', 'A3', 0.1, 1, '100plus Regular 1.5l', 1, 1, -1, 'FMNVMMAA100001.20210504142320', 'FMNVMMAA100001', '', 'online', '2021-05-04 07:23:28'),
(788, '', 'A1', 0.1, 1, '100plus Active 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504142654', 'FMNVMMAA100001', '', 'online', '2021-05-04 07:26:56'),
(789, '', 'A2', 0.1, 1, '100plus Lime 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504142654', 'FMNVMMAA100001', '', 'online', '2021-05-04 07:26:59'),
(790, '', 'A3', 0.1, 1, '100plus Regular 1.5l', 1, 1, -1, 'FMNVMMAA100001.20210504142654', 'FMNVMMAA100001', '', 'online', '2021-05-04 07:27:02'),
(791, '', 'A4', 0.1, 1, '100plus Regular 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504142712', 'FMNVMMAA100001', '', 'online', '2021-05-04 07:27:14'),
(792, '', 'A5', 0.1, 1, 'Authentic Tea House Ayataka Green Tea 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504142712', 'FMNVMMAA100001', '', 'online', '2021-05-04 07:27:16'),
(793, '', 'A5', 0.1, 1, 'Authentic Tea House Ayataka Green Tea 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504142730', 'FMNVMMAA100001', '', 'online', '2021-05-04 07:27:30'),
(794, '', 'A5', 0.1, 1, 'Authentic Tea House Ayataka Green Tea 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504142730', 'FMNVMMAA100001', '', 'online', '2021-05-04 07:27:32'),
(795, '', 'A5', 0.1, 1, 'Authentic Tea House Ayataka Green Tea 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504142801', 'FMNVMMAA100001', '', 'online', '2021-05-04 07:28:02'),
(796, '', 'A5', 0.1, 1, 'Authentic Tea House Ayataka Green Tea 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504142801', 'FMNVMMAA100001', '', 'online', '2021-05-04 07:28:05'),
(797, '', 'A5', 1, 1, 'Authentic Tea House Ayataka Green Tea 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504142801', 'FMNVMMAA100001', '', 'online', '2021-05-04 07:28:09'),
(798, '', 'A5', 0.1, 1, 'Authentic Tea House Ayataka Green Tea 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504142819', 'FMNVMMAA100001', '', 'online', '2021-05-04 07:28:21'),
(799, '', 'A5', 0.1, 1, 'Authentic Tea House Ayataka Green Tea 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504142819', 'FMNVMMAA100001', '', 'online', '2021-05-04 07:28:24'),
(800, '', 'A5', 1, 1, 'Authentic Tea House Ayataka Green Tea 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504142819', 'FMNVMMAA100001', '', 'online', '2021-05-04 07:28:27'),
(801, '', 'A4', 0.1, 1, '100plus Regular 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504143133', 'FMNVMMAA100001', '', 'online', '2021-05-04 07:31:35'),
(802, '', 'A4', 0.1, 1, '100plus Regular 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504143133', 'FMNVMMAA100001', '', 'online', '2021-05-04 07:31:38'),
(803, '', 'A4', 0.1, 1, '100plus Regular 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504143133', 'FMNVMMAA100001', '', 'online', '2021-05-04 07:31:42'),
(804, '', 'A5', 0.1, 1, 'Authentic Tea House Ayataka Green Tea 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504143155', 'FMNVMMAA100001', '', 'online', '2021-05-04 07:31:57'),
(805, '', 'A5', 0.1, 1, 'Authentic Tea House Ayataka Green Tea 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504143155', 'FMNVMMAA100001', '', 'online', '2021-05-04 07:32:01'),
(806, '', 'A5', 1, 1, 'Authentic Tea House Ayataka Green Tea 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504143155', 'FMNVMMAA100001', '', 'online', '2021-05-04 07:32:04'),
(807, '', 'A5', 0.1, 1, 'Authentic Tea House Ayataka Green Tea 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504143228', 'FMNVMMAA100001', '', 'offline', '2021-05-04 07:32:30'),
(808, '', 'A5', 0.1, 1, 'Authentic Tea House Ayataka Green Tea 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504143228', 'FMNVMMAA100001', '', 'online', '2021-05-04 07:32:33'),
(809, '', 'A5', 1, 1, 'Authentic Tea House Ayataka Green Tea 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504143228', 'FMNVMMAA100001', '', 'online', '2021-05-04 07:32:35'),
(810, '', 'A5', 0.1, 1, 'Authentic Tea House Ayataka Green Tea 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504143257', 'FMNVMMAA100001', '', 'online', '2021-05-04 07:32:58'),
(811, '', 'A5', 0.1, 1, 'Authentic Tea House Ayataka Green Tea 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504143257', 'FMNVMMAA100001', '', 'online', '2021-05-04 07:33:00'),
(812, '', 'A5', 1, 1, 'Authentic Tea House Ayataka Green Tea 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504143257', 'FMNVMMAA100001', '', 'online', '2021-05-04 07:33:02'),
(813, '', 'A5', 0.1, 1, 'Authentic Tea House Ayataka Green Tea 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504143424', 'FMNVMMAA100001', '', 'online', '2021-05-04 07:34:25'),
(814, '', 'A5', 0.1, 1, 'Authentic Tea House Ayataka Green Tea 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504143424', 'FMNVMMAA100001', '', 'online', '2021-05-04 07:34:29'),
(815, '', 'A5', 1, 1, 'Authentic Tea House Ayataka Green Tea 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504143424', 'FMNVMMAA100001', '', 'online', '2021-05-04 07:34:32'),
(816, '', 'A5', 0.1, 1, 'Authentic Tea House Ayataka Green Tea 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504143700', 'FMNVMMAA100001', '', 'online', '2021-05-04 07:37:02'),
(817, '', 'A5', 0.1, 1, 'Authentic Tea House Ayataka Green Tea 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504143700', 'FMNVMMAA100001', '', 'online', '2021-05-04 07:37:05'),
(818, '', 'A5', 1, 1, 'Authentic Tea House Ayataka Green Tea 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504143700', 'FMNVMMAA100001', '', 'online', '2021-05-04 07:37:08'),
(819, '', 'A5', 0.1, 1, 'Authentic Tea House Ayataka Green Tea 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504143846', 'FMNVMMAA100001', '', 'online', '2021-05-04 07:38:48'),
(820, '', 'A5', 0.1, 1, 'Authentic Tea House Ayataka Green Tea 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504143846', 'FMNVMMAA100001', '', 'online', '2021-05-04 07:38:51'),
(821, '', 'A4', 0.1, 1, '100plus Regular 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504143846', 'FMNVMMAA100001', '', 'online', '2021-05-04 07:38:54'),
(822, '', 'A5', 0.1, 1, 'Authentic Tea House Ayataka Green Tea 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504143934', 'FMNVMMAA100001', '', 'online', '2021-05-04 07:39:36'),
(823, '', 'A5', 0.1, 1, 'Authentic Tea House Ayataka Green Tea 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504143934', 'FMNVMMAA100001', '', 'online', '2021-05-04 07:39:39'),
(824, '', 'A5', 1, 1, 'Authentic Tea House Ayataka Green Tea 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504143934', 'FMNVMMAA100001', '', 'online', '2021-05-04 07:39:42'),
(825, '', 'A5', 0.1, 1, 'Authentic Tea House Ayataka Green Tea 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504144244', 'FMNVMMAA100001', '', 'online', '2021-05-04 07:42:46'),
(826, '', 'A5', 0.1, 1, 'Authentic Tea House Ayataka Green Tea 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504144244', 'FMNVMMAA100001', '', 'online', '2021-05-04 07:42:49'),
(827, '', 'A5', 1, 1, 'Authentic Tea House Ayataka Green Tea 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504144244', 'FMNVMMAA100001', '', 'online', '2021-05-04 07:42:52'),
(828, '', 'A5', 0.1, 1, 'Authentic Tea House Ayataka Green Tea 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504150254', 'FMNVMMAA100001', '', 'online', '2021-05-04 08:02:56'),
(829, '', 'A5', 0.1, 1, 'Authentic Tea House Ayataka Green Tea 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504150254', 'FMNVMMAA100001', '', 'online', '2021-05-04 08:02:59'),
(830, '', 'A5', 1, 1, 'Authentic Tea House Ayataka Green Tea 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504150254', 'FMNVMMAA100001', '', 'online', '2021-05-04 08:03:03'),
(831, '', 'A1', 0.1, 1, '100plus Active 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504150326', 'FMNVMMAA100001', '', 'online', '2021-05-04 08:03:28'),
(832, '', 'A2', 0.1, 1, '100plus Lime 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504150326', 'FMNVMMAA100001', '', 'online', '2021-05-04 08:03:31'),
(833, '', 'A3', 0.1, 1, '100plus Regular 1.5l', 1, 1, -1, 'FMNVMMAA100001.20210504150326', 'FMNVMMAA100001', '', 'online', '2021-05-04 08:03:34'),
(834, '', 'A4', 0.1, 1, '100plus Regular 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504150349', 'FMNVMMAA100001', '', 'online', '2021-05-04 08:03:51'),
(835, '', 'A5', 0.1, 1, 'Authentic Tea House Ayataka Green Tea 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504150349', 'FMNVMMAA100001', '', 'online', '2021-05-04 08:03:54'),
(836, '', 'A1', 0.1, 1, '100plus Active 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504151212', 'FMNVMMAA100001', '', 'online', '2021-05-04 08:12:14'),
(837, '', 'A2', 0.1, 1, '100plus Lime 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504151212', 'FMNVMMAA100001', '', 'online', '2021-05-04 08:12:17'),
(838, '', 'A3', 0.1, 1, '100plus Regular 1.5l', 1, 1, -1, 'FMNVMMAA100001.20210504151212', 'FMNVMMAA100001', '', 'online', '2021-05-04 08:12:20'),
(839, '', 'A4', 0.1, 1, '100plus Regular 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504151230', 'FMNVMMAA100001', '', 'online', '2021-05-04 08:12:32'),
(840, '', 'A5', 0.1, 1, 'Authentic Tea House Ayataka Green Tea 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504151230', 'FMNVMMAA100001', '', 'online', '2021-05-04 08:12:35'),
(841, '', 'A1', 0.1, 1, '100plus Active 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504152209', 'FMNVMMAA100001', '', 'online', '2021-05-04 08:22:11'),
(842, '', 'A2', 0.1, 1, '100plus Lime 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504152209', 'FMNVMMAA100001', '', 'online', '2021-05-04 08:22:14'),
(843, '', 'A3', 0.1, 1, '100plus Regular 1.5l', 1, 1, -1, 'FMNVMMAA100001.20210504152209', 'FMNVMMAA100001', '', 'online', '2021-05-04 08:22:18'),
(844, '', 'A1', 0.1, 1, '100plus Active 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504152229', 'FMNVMMAA100001', '', 'online', '2021-05-04 08:22:31'),
(845, '', 'A2', 0.1, 1, '100plus Lime 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504152229', 'FMNVMMAA100001', '', 'online', '2021-05-04 08:22:34'),
(846, '', 'A3', 0.1, 1, '100plus Regular 1.5l', 1, 1, -1, 'FMNVMMAA100001.20210504152229', 'FMNVMMAA100001', '', 'online', '2021-05-04 08:22:37'),
(847, '', 'A1', 0.1, 1, '100plus Active 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504152250', 'FMNVMMAA100001', '', 'online', '2021-05-04 08:22:52'),
(848, '', 'A2', 0.1, 1, '100plus Lime 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504152250', 'FMNVMMAA100001', '', 'online', '2021-05-04 08:22:55'),
(849, '', 'A3', 0.1, 1, '100plus Regular 1.5l', 1, 1, -1, 'FMNVMMAA100001.20210504152250', 'FMNVMMAA100001', '', 'online', '2021-05-04 08:22:59'),
(850, '', 'A1', 0.1, 1, '100plus Active 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504152306', 'FMNVMMAA100001', '', 'online', '2021-05-04 08:23:08'),
(851, '', 'A2', 0.1, 1, '100plus Lime 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504152306', 'FMNVMMAA100001', '', 'online', '2021-05-04 08:23:11'),
(852, '', 'A3', 0.1, 1, '100plus Regular 1.5l', 1, 1, -1, 'FMNVMMAA100001.20210504152306', 'FMNVMMAA100001', '', 'online', '2021-05-04 08:23:14'),
(853, '', 'A1', 0.1, 1, '100plus Active 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504152324', 'FMNVMMAA100001', '', 'online', '2021-05-04 08:23:25'),
(854, '', 'A2', 0.1, 1, '100plus Lime 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504152324', 'FMNVMMAA100001', '', 'online', '2021-05-04 08:23:28'),
(855, '', 'A3', 0.1, 1, '100plus Regular 1.5l', 1, 1, -1, 'FMNVMMAA100001.20210504152324', 'FMNVMMAA100001', '', 'online', '2021-05-04 08:23:32'),
(856, '', 'A1', 0.1, 1, '100plus Active 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504152341', 'FMNVMMAA100001', '', 'online', '2021-05-04 08:23:42'),
(857, '', 'A2', 0.1, 1, '100plus Lime 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504152341', 'FMNVMMAA100001', '', 'online', '2021-05-04 08:23:46'),
(858, '', 'A3', 0.1, 1, '100plus Regular 1.5l', 1, 1, -1, 'FMNVMMAA100001.20210504152341', 'FMNVMMAA100001', '', 'online', '2021-05-04 08:23:49'),
(859, '', 'A1', 0.1, 1, '100plus Active 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504152406', 'FMNVMMAA100001', '', 'online', '2021-05-04 08:24:07'),
(860, '', 'A3', 0.1, 1, '100plus Regular 1.5l', 1, 1, -1, 'FMNVMMAA100001.20210504152406', 'FMNVMMAA100001', '', 'online', '2021-05-04 08:24:11'),
(861, '', 'A2', 0.1, 1, '100plus Lime 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504152406', 'FMNVMMAA100001', '', 'online', '2021-05-04 08:24:14'),
(862, '', 'A1', 0.1, 1, '100plus Active 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504152426', 'FMNVMMAA100001', '', 'online', '2021-05-04 08:24:28'),
(863, '', 'A2', 0.1, 1, '100plus Lime 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504152426', 'FMNVMMAA100001', '', 'online', '2021-05-04 08:24:31'),
(864, '', 'A3', 0.1, 1, '100plus Regular 1.5l', 1, 1, -1, 'FMNVMMAA100001.20210504152426', 'FMNVMMAA100001', '', 'online', '2021-05-04 08:24:34'),
(865, '', 'A1', 0.1, 1, '100plus Active 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504152444', 'FMNVMMAA100001', '', 'online', '2021-05-04 08:24:45'),
(866, '', 'A2', 0.1, 1, '100plus Lime 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504152444', 'FMNVMMAA100001', '', 'online', '2021-05-04 08:24:48'),
(867, '', 'A3', 0.1, 1, '100plus Regular 1.5l', 1, 1, -1, 'FMNVMMAA100001.20210504152444', 'FMNVMMAA100001', '', 'online', '2021-05-04 08:24:52'),
(868, '', 'A1', 0.1, 1, '100plus Active 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504152502', 'FMNVMMAA100001', '', 'online', '2021-05-04 08:25:03'),
(869, '', 'A2', 0.1, 1, '100plus Lime 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504152502', 'FMNVMMAA100001', '', 'online', '2021-05-04 08:25:06'),
(870, '', 'A3', 0.1, 1, '100plus Regular 1.5l', 1, 1, -1, 'FMNVMMAA100001.20210504152502', 'FMNVMMAA100001', '', 'online', '2021-05-04 08:25:10'),
(871, '', 'A1', 0.1, 1, '100plus Active 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504152518', 'FMNVMMAA100001', '', 'online', '2021-05-04 08:25:20'),
(872, '', 'A2', 0.1, 1, '100plus Lime 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504152518', 'FMNVMMAA100001', '', 'online', '2021-05-04 08:25:23'),
(873, '', 'A3', 0.1, 1, '100plus Regular 1.5l', 1, 1, -1, 'FMNVMMAA100001.20210504152518', 'FMNVMMAA100001', '', 'online', '2021-05-04 08:25:26'),
(874, '', 'A1', 0.1, 1, '100plus Active 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504152540', 'FMNVMMAA100001', '', 'online', '2021-05-04 08:25:41'),
(875, '', 'A2', 0.1, 1, '100plus Lime 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504152540', 'FMNVMMAA100001', '', 'online', '2021-05-04 08:25:44'),
(876, '', 'A3', 0.1, 1, '100plus Regular 1.5l', 1, 1, -1, 'FMNVMMAA100001.20210504152540', 'FMNVMMAA100001', '', 'online', '2021-05-04 08:25:48'),
(877, '', 'A1', 0.1, 1, '100plus Active 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504152601', 'FMNVMMAA100001', '', 'online', '2021-05-04 08:26:03'),
(878, '', 'A2', 0.1, 1, '100plus Lime 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504152601', 'FMNVMMAA100001', '', 'online', '2021-05-04 08:26:06'),
(879, '', 'A3', 0.1, 1, '100plus Regular 1.5l', 1, 1, -1, 'FMNVMMAA100001.20210504152601', 'FMNVMMAA100001', '', 'online', '2021-05-04 08:26:09'),
(880, '', 'A1', 0.1, 1, '100plus Active 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504152618', 'FMNVMMAA100001', '', 'online', '2021-05-04 08:26:19'),
(881, '', 'A2', 0.1, 1, '100plus Lime 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504152618', 'FMNVMMAA100001', '', 'online', '2021-05-04 08:26:23'),
(882, '', 'A3', 0.1, 1, '100plus Regular 1.5l', 1, 1, -1, 'FMNVMMAA100001.20210504152618', 'FMNVMMAA100001', '', 'online', '2021-05-04 08:26:26'),
(883, '', 'A1', 0.1, 1, '100plus Active 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504152633', 'FMNVMMAA100001', '', 'online', '2021-05-04 08:26:35'),
(884, '', 'A2', 0.1, 1, '100plus Lime 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504152633', 'FMNVMMAA100001', '', 'online', '2021-05-04 08:26:38'),
(885, '', 'A3', 0.1, 1, '100plus Regular 1.5l', 1, 1, -1, 'FMNVMMAA100001.20210504152633', 'FMNVMMAA100001', '', 'online', '2021-05-04 08:26:41'),
(886, '', 'A1', 0.1, 1, '100plus Active 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504152650', 'FMNVMMAA100001', '', 'online', '2021-05-04 08:26:51'),
(887, '', 'A2', 0.1, 1, '100plus Lime 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504152650', 'FMNVMMAA100001', '', 'online', '2021-05-04 08:26:54'),
(888, '', 'A3', 0.1, 1, '100plus Regular 1.5l', 1, 1, -1, 'FMNVMMAA100001.20210504152650', 'FMNVMMAA100001', '', 'online', '2021-05-04 08:26:58'),
(889, '', 'A3', 0.1, 1, '100plus Regular 1.5l', 1, 1, -1, 'FMNVMMAA100001.20210504152708', 'FMNVMMAA100001', '', 'online', '2021-05-04 08:27:10'),
(890, '', 'A5', 0.1, 1, 'Authentic Tea House Ayataka Green Tea 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504152708', 'FMNVMMAA100001', '', 'online', '2021-05-04 08:27:13'),
(891, '', 'A5', 1, 1, 'Authentic Tea House Ayataka Green Tea 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504152708', 'FMNVMMAA100001', '', 'online', '2021-05-04 08:27:16'),
(892, '', 'A5', 0.1, 1, 'Authentic Tea House Ayataka Green Tea 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504152729', 'FMNVMMAA100001', '', 'online', '2021-05-04 08:27:31'),
(893, '', 'A5', 0.1, 1, 'Authentic Tea House Ayataka Green Tea 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504152729', 'FMNVMMAA100001', '', 'online', '2021-05-04 08:27:34'),
(894, '', 'A5', 1, 1, 'Authentic Tea House Ayataka Green Tea 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504152729', 'FMNVMMAA100001', '', 'online', '2021-05-04 08:27:37'),
(895, '', 'A5', 0.1, 1, 'Authentic Tea House Ayataka Green Tea 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504152753', 'FMNVMMAA100001', '', 'online', '2021-05-04 08:27:55'),
(896, '', 'A5', 0.1, 1, 'Authentic Tea House Ayataka Green Tea 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504152753', 'FMNVMMAA100001', '', 'online', '2021-05-04 08:27:58'),
(897, '', 'A4', 0.1, 1, '100plus Regular 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504152753', 'FMNVMMAA100001', '', 'online', '2021-05-04 08:28:01'),
(898, '', 'A5', 0.1, 1, 'Authentic Tea House Ayataka Green Tea 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504152809', 'FMNVMMAA100001', '', 'online', '2021-05-04 08:28:11'),
(899, '', 'A5', 0.1, 1, 'Authentic Tea House Ayataka Green Tea 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504152809', 'FMNVMMAA100001', '', 'online', '2021-05-04 08:28:14'),
(900, '', 'A5', 1, 1, 'Authentic Tea House Ayataka Green Tea 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504152809', 'FMNVMMAA100001', '', 'online', '2021-05-04 08:28:18'),
(901, '', 'A5', 0.1, 1, 'Authentic Tea House Ayataka Green Tea 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504152828', 'FMNVMMAA100001', '', 'online', '2021-05-04 08:28:29'),
(902, '', 'A5', 0.1, 1, 'Authentic Tea House Ayataka Green Tea 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504152828', 'FMNVMMAA100001', '', 'online', '2021-05-04 08:28:33'),
(903, '', 'A5', 1, 1, 'Authentic Tea House Ayataka Green Tea 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504152828', 'FMNVMMAA100001', '', 'online', '2021-05-04 08:28:36'),
(904, '', 'A5', 0.1, 1, 'Authentic Tea House Ayataka Green Tea 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504152844', 'FMNVMMAA100001', '', 'online', '2021-05-04 08:28:46'),
(905, '', 'A5', 0.1, 1, 'Authentic Tea House Ayataka Green Tea 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504152844', 'FMNVMMAA100001', '', 'online', '2021-05-04 08:28:49'),
(906, '', 'A5', 1, 1, 'Authentic Tea House Ayataka Green Tea 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504152844', 'FMNVMMAA100001', '', 'online', '2021-05-04 08:28:52'),
(907, '', 'A5', 0.1, 1, 'Authentic Tea House Ayataka Green Tea 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504152902', 'FMNVMMAA100001', '', 'online', '2021-05-04 08:29:04'),
(908, '', 'A4', 0.1, 1, '100plus Regular 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504152902', 'FMNVMMAA100001', '', 'online', '2021-05-04 08:29:07'),
(909, '', 'A5', 1, 1, 'Authentic Tea House Ayataka Green Tea 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504152902', 'FMNVMMAA100001', '', 'online', '2021-05-04 08:29:10'),
(910, '', 'A4', 0.1, 1, '100plus Regular 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504152920', 'FMNVMMAA100001', '', 'online', '2021-05-04 08:29:22'),
(911, '', 'A5', 0.1, 1, 'Authentic Tea House Ayataka Green Tea 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504152920', 'FMNVMMAA100001', '', 'online', '2021-05-04 08:29:25'),
(912, '', 'A5', 1, 1, 'Authentic Tea House Ayataka Green Tea 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504152920', 'FMNVMMAA100001', '', 'online', '2021-05-04 08:29:28'),
(913, '', 'E4', 0.1, 1, 'Authentic Tea House Ayataka Green Tea 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504153043', 'FMNVMMAA100001', '', 'online', '2021-05-04 08:30:50'),
(914, '', 'F5', 0.1, 1, 'Coca-Cola 1.5l', 1, 1, -1, 'FMNVMMAA100001.20210504154627', 'FMNVMMAA100001', '', 'online', '2021-05-04 08:46:34'),
(915, '', 'A1', 0.1, 1, '100plus Active 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504160418', 'FMNVMMAA100001', '', 'online', '2021-05-04 09:04:20'),
(916, '', 'A2', 0.1, 1, '100plus Lime 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504160418', 'FMNVMMAA100001', '', 'online', '2021-05-04 09:04:23'),
(917, '', 'A3', 0.1, 1, '100plus Regular 1.5l', 1, 1, -1, 'FMNVMMAA100001.20210504160418', 'FMNVMMAA100001', '', 'online', '2021-05-04 09:04:26'),
(918, '', 'A1', 0.1, 1, '100plus Active 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504160439', 'FMNVMMAA100001', '', 'online', '2021-05-04 09:04:41'),
(919, '', 'A2', 0.1, 1, '100plus Lime 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504160439', 'FMNVMMAA100001', '', 'online', '2021-05-04 09:04:44'),
(920, '', 'A3', 0.1, 1, '100plus Regular 1.5l', 1, 1, -1, 'FMNVMMAA100001.20210504160439', 'FMNVMMAA100001', '', 'online', '2021-05-04 09:04:47'),
(921, '', 'A1', 0.1, 1, '100plus Active 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504160522', 'FMNVMMAA100001', '', 'online', '2021-05-04 09:05:23'),
(922, '', 'A2', 0.1, 1, '100plus Lime 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504160522', 'FMNVMMAA100001', '', 'online', '2021-05-04 09:05:26'),
(923, '', 'A3', 0.1, 1, '100plus Regular 1.5l', 1, 1, -1, 'FMNVMMAA100001.20210504160522', 'FMNVMMAA100001', '', 'online', '2021-05-04 09:05:30'),
(924, '', 'A1', 0.1, 1, '100plus Active 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504160556', 'FMNVMMAA100001', '', 'online', '2021-05-04 09:05:57'),
(925, '', 'A1', 0.1, 1, '100plus Active 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504160556', 'FMNVMMAA100001', '', 'online', '2021-05-04 09:06:01'),
(926, '', 'A1', 0.1, 1, '100plus Active 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504160556', 'FMNVMMAA100001', '', 'online', '2021-05-04 09:06:04'),
(927, '', 'A4', 0.1, 1, '100plus Regular 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504160706', 'FMNVMMAA100001', '', 'online', '2021-05-04 09:07:08'),
(928, '', 'A4', 0.1, 1, '100plus Regular 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504160706', 'FMNVMMAA100001', '', 'online', '2021-05-04 09:07:11'),
(929, '', 'A4', 0.1, 1, '100plus Regular 500ml', 1, 1, -1, 'FMNVMMAA100001.20210504160706', 'FMNVMMAA100001', '', 'online', '2021-05-04 09:07:14'),
(930, '', 'A2', 0.1, 1, '100plus Lime 500ml', 1, 1, -1, 'FMNVMMAA100001.20210506172059', 'FMNVMMAA100001', '', 'online', '2021-05-06 10:21:00'),
(931, '', 'A2', 0.1, 1, '100plus Lime 500ml', 1, 1, -1, 'FMNVMMAA100001.20210506172059', 'FMNVMMAA100001', '', 'online', '2021-05-06 10:21:02'),
(932, '', 'A1', 0.1, 1, '100plus Active 500ml', 1, 1, -1, 'FMNVMMAA100001.20210506173104', 'FMNVMMAA100001', '', 'online', '2021-05-06 10:31:06'),
(933, '', 'A2', 0.1, 1, '100plus Lime 500ml', 1, 1, -1, 'FMNVMMAA100001.20210506173215', 'FMNVMMAA100001', '', 'online', '2021-05-06 10:32:17'),
(934, '', 'B1', 0.1, 1, 'Coca-Cola 1.5l', 1, 1, -1, 'FMNVMMAA100001.20210506185344', 'FMNVMMAA100001', '', 'online', '2021-05-06 11:53:45'),
(935, '', 'A1', 0.1, 1, '100plus Active 500ml', 1, 1, -1, 'FMNVMMAA100001.20210506185430', 'FMNVMMAA100001', '', 'online', '2021-05-06 11:54:32'),
(936, '', 'A2', 0.1, 1, '100plus Lime 500ml', 1, 1, -1, 'FMNVMMAA100001.20210506185430', 'FMNVMMAA100001', '', 'online', '2021-05-06 11:54:35'),
(937, '', 'A1', 0.1, 1, '100plus Active 500ml', 1, 1, -1, 'FMNVMMAA100001.20210507080609', 'FMNVMMAA100001', '', 'online', '2021-05-07 01:06:11'),
(938, '', 'A2', 0.1, 1, '100plus Lime 500ml', 1, 1, -1, 'FMNVMMAA100001.20210507080609', 'FMNVMMAA100001', '', 'online', '2021-05-07 01:06:14'),
(939, '', 'A5', 0.1, 1, 'Big Bite Sandwich', 1, 1, -1, 'FMNVMMAA100001.20210511230542', 'FMNVMMAA100001', 'http://192.168.0.2/images/A5-Big Bite Sandwich.jpg', 'online', '2021-05-11 23:05:53'),
(940, '', 'A5', 0.1, 1, 'Big Bite Sandwich', 1, 1, -1, 'FMNVMMAA100001.20210511230659', 'FMNVMMAA100001', 'http://192.168.0.2/images/A5-Big Bite Sandwich.jpg', 'online', '2021-05-11 23:07:07'),
(941, '', 'A5', 0.1, 1, 'Big Bite Sandwich', 1, 1, -1, 'FMNVMMAA100001.20210511230936', 'FMNVMMAA100001', 'http://192.168.0.2/images/A5-Big Bite Sandwich.jpg', 'online', '2021-05-11 23:09:44'),
(942, '', 'A5', 0.1, 1, 'Big Bite Sandwich', 1, 1, -1, 'FMNVMMAA100001.20210511231049', 'FMNVMMAA100001', 'http://192.168.0.2/images/A5-Big Bite Sandwich.jpg', 'online', '2021-05-11 23:10:57'),
(943, '', 'A5', 0.1, 1, 'Big Bite Sandwich', 1, 1, -1, 'FMNVMMAA100001.20210511232000', 'FMNVMMAA100001', 'http://192.168.0.2/images/A5-Big Bite Sandwich.jpg', 'online', '2021-05-11 23:20:08'),
(944, '', 'A5', 0.1, 1, 'Big Bite Sandwich', 1, 1, -1, 'FMNVMMAA100001.20210511232027', 'FMNVMMAA100001', 'http://192.168.0.2/images/A5-Big Bite Sandwich.jpg', 'online', '2021-05-11 23:20:36'),
(945, '', 'A5', 0.1, 1, 'Big Bite Sandwich', 1, 1, -1, 'FMNVMMAA100001.20210511232135', 'FMNVMMAA100001', 'http://192.168.0.2/images/A5-Big Bite Sandwich.jpg', 'online', '2021-05-11 23:21:43'),
(946, '', 'B3', 0.1, 1, 'Cheese Pudding', 1, 1, -1, 'FMNVMMAA100001.20210512140813', 'FMNVMMAA100001', 'http://192.168.0.2/images/B3-Cheese Pudding.jpg', 'online', '2021-05-12 14:08:16'),
(947, '', 'B3', 0.1, 1, 'Cheese Pudding', 1, 1, -1, 'FMNVMMAA100001.20210512140813', 'FMNVMMAA100001', 'http://192.168.0.2/images/B3-Cheese Pudding.jpg', 'online', '2021-05-12 14:08:19'),
(948, '', 'B3', 0.1, 1, 'Cheese Pudding', 1, 1, -1, 'FMNVMMAA100001.20210512140813', 'FMNVMMAA100001', 'http://192.168.0.2/images/B3-Cheese Pudding.jpg', 'online', '2021-05-12 14:08:23'),
(949, '', 'C1', 0.1, 1, 'Tuna Mayo Onigiri', 1, 1, -1, 'FMNVMMAA100001.20210512141318', 'FMNVMMAA100001', 'http://192.168.0.2/images/C1-Tuna Mayo Onigiri.jpg', 'online', '2021-05-12 14:13:20'),
(950, '', 'C1', 0.1, 1, 'Tuna Mayo Onigiri', 1, 1, -1, 'FMNVMMAA100001.20210512141318', 'FMNVMMAA100001', 'http://192.168.0.2/images/C1-Tuna Mayo Onigiri.jpg', 'online', '2021-05-12 14:13:23'),
(951, '', 'C1', 0.1, 1, 'Tuna Mayo Onigiri', 1, 1, -1, 'FMNVMMAA100001.20210512141318', 'FMNVMMAA100001', 'http://192.168.0.2/images/C1-Tuna Mayo Onigiri.jpg', 'online', '2021-05-12 14:13:27'),
(952, '', 'C4', 0.1, 1, 'Tiramisu Sando', 1, 1, -1, 'FMNVMMAA100001.20210512141459', 'FMNVMMAA100001', 'http://192.168.0.2/images/C4-Tiramisu Sando.jpg', 'online', '2021-05-12 14:15:01'),
(953, '', 'C4', 0.1, 1, 'Tiramisu Sando', 1, 1, -1, 'FMNVMMAA100001.20210512141459', 'FMNVMMAA100001', 'http://192.168.0.2/images/C4-Tiramisu Sando.jpg', 'online', '2021-05-12 14:15:05'),
(954, '', 'C4', 0.1, 1, 'Tiramisu Sando', 1, 1, -1, 'FMNVMMAA100001.20210512141459', 'FMNVMMAA100001', 'http://192.168.0.2/images/C4-Tiramisu Sando.jpg', 'online', '2021-05-12 14:15:08'),
(955, '', 'C4', 0.1, 1, 'Tiramisu Sando', 1, 1, -1, 'FMNVMMAA100001.20210512141519', 'FMNVMMAA100001', 'http://192.168.0.2/images/C4-Tiramisu Sando.jpg', 'online', '2021-05-12 14:15:22'),
(956, '', 'C4', 0.1, 1, 'Tiramisu Sando', 1, 1, -1, 'FMNVMMAA100001.20210512141519', 'FMNVMMAA100001', 'http://192.168.0.2/images/C4-Tiramisu Sando.jpg', 'online', '2021-05-12 14:15:25'),
(957, '', 'C4', 0.1, 1, 'Tiramisu Sando', 1, 1, -1, 'FMNVMMAA100001.20210512141519', 'FMNVMMAA100001', 'http://192.168.0.2/images/C4-Tiramisu Sando.jpg', 'online', '2021-05-12 14:15:28'),
(958, '', 'E5', 0.1, 1, 'Matcha Roll Slice', 1, 1, -1, 'FMNVMMAA100001.20210512151313', 'FMNVMMAA100001', 'http://192.168.0.2/images/E5-Matcha Roll Slice.jpg', 'online', '2021-05-12 15:13:16'),
(959, '', 'E5', 0.1, 1, 'Matcha Roll Slice', 1, 1, -1, 'FMNVMMAA100001.20210512151313', 'FMNVMMAA100001', 'http://192.168.0.2/images/E5-Matcha Roll Slice.jpg', 'online', '2021-05-12 15:13:19'),
(960, '', 'E5', 0.1, 1, 'Matcha Roll Slice', 1, 1, -1, 'FMNVMMAA100001.20210512151313', 'FMNVMMAA100001', 'http://192.168.0.2/images/E5-Matcha Roll Slice.jpg', 'online', '2021-05-12 15:13:22'),
(961, '', 'C1', 0.1, 1, 'Tuna Mayo Onigiri', 1, 1, -1, 'NVMMAA100001.20210517164731', 'NVMMAA100001', 'http://192.168.0.2/images/C1-Tuna Mayo Onigiri.jpg', 'offline', '2021-05-16 17:22:20'),
(962, '', 'A5', 0.1, 1, 'Big Bite Sandwich', 1, 1, -1, 'NVMMAA100001.20210517165512', 'NVMMAA100001', 'http://192.168.0.2/images/A5-Big Bite Sandwich.jpg', 'offline', '2021-05-16 17:29:55'),
(963, '', 'B3', 0.1, 1, 'Cheese Pudding', 1, 1, -1, 'NVMMAA100001.20210517165642', 'NVMMAA100001', 'http://192.168.0.2/images/B3-Cheese Pudding.jpg', 'offline', '2021-05-16 17:31:21'),
(964, '', 'C4', 0.1, 1, 'Tiramisu Sando', 1, 1, -1, 'NVMMAA100001.20210517182511', 'NVMMAA100001', 'http://192.168.0.2/images/C4-Tiramisu Sando.jpg', 'offline', '2021-05-16 19:00:07'),
(965, '', 'A5', 0.1, 1, 'Big Bite Sandwich', 1, 1, -1, 'NVMMAA100001.20210520110456', 'NVMMAA100001', 'http://192.168.0.2/images/A5-Big Bite Sandwich.jpg', 'online', '2021-05-20 04:05:08');
INSERT INTO `db_sales_record` (`id`, `transaction_serial`, `slot_number`, `price`, `quantity`, `product_name`, `drop_sensor_status`, `payment_method`, `self_defined_payment_method`, `order_number`, `machine_id`, `product_url`, `report_status`, `date_time`) VALUES
(966, '', 'A5', 0.1, 1, 'Big Bite Sandwich', 1, 1, -1, 'NVMMAA100001.20210520135811', 'NVMMAA100001', 'http://192.168.0.2/images/A5-Big Bite Sandwich.jpg', 'online', '2021-05-20 06:58:19'),
(967, '', 'A5', 0, 1, 'Big Bite Sandwich', 1, 1, -1, 'NVMMAA100001.20210524213319', 'NVMMAA100001', 'http://192.168.0.2/images/A5-Big Bite Sandwich.jpg', 'online', '2021-05-24 14:33:56'),
(968, '', 'A5', 0.1, 1, 'Big Bite Sandwich', 1, 1, -1, 'NVMMAA100001.20210526172457', 'NVMMAA100001', 'http://192.168.0.2/images/A5-Big Bite Sandwich.jpg', 'online', '2021-05-26 17:25:05'),
(969, '', 'A5', 0.1, 1, 'Big Bite Sandwich', 1, 1, -1, 'NVMMAA100001.20210526172556', 'NVMMAA100001', 'http://192.168.0.2/images/A5-Big Bite Sandwich.jpg', 'online', '2021-05-26 17:25:58'),
(970, '', 'A5', 0.1, 1, 'Big Bite Sandwich', 1, 1, -1, 'NVMMAA100001.20210526172556', 'NVMMAA100001', 'http://192.168.0.2/images/A5-Big Bite Sandwich.jpg', 'online', '2021-05-26 17:26:02'),
(971, '', 'A5', 0.1, 1, 'Big Bite Sandwich', 1, 1, -1, 'NVMMAA100001.20210526172556', 'NVMMAA100001', 'http://192.168.0.2/images/A5-Big Bite Sandwich.jpg', 'online', '2021-05-26 17:26:06'),
(972, '', 'A5', 0.1, 1, 'Big Bite Sandwich', 1, 1, -1, 'NVMMAA100001.20210526192943', 'NVMMAA100001', 'http://192.168.0.2/images/A5-Big Bite Sandwich.jpg', 'online', '2021-05-26 19:29:48'),
(973, '', 'A5', 0.1, 1, 'Big Bite Sandwich', 1, 1, -1, 'NVMMAA100001.20210526192943', 'NVMMAA100001', 'http://192.168.0.2/images/A5-Big Bite Sandwich.jpg', 'online', '2021-05-26 19:29:52'),
(974, '', 'B7', 0, 1, 'Nabati Cheese', 1, 1, -1, 'NVMMAA100003.20210529190538', 'NVMMAA100003', 'http://192.168.0.2/images/B7-Nabati Cheese.jpg', 'online', '2021-05-27 16:43:00'),
(975, '', 'B8', 0, 1, 'Nabati Cheese', 1, 1, -1, 'NVMMAA100003.20210529190538', 'NVMMAA100003', 'http://192.168.0.2/images/B8-Nabati Cheese.jpg', 'online', '2021-05-27 16:43:06'),
(976, '', 'B2', 0.2, 1, 'Lexus Chocolate', 1, 1, -1, 'NVMMAA100003.20210530122232', 'NVMMAA100003', 'http://192.168.0.2/images/B2-Lexus Chocolate.peg', 'online', '2021-05-30 12:22:51'),
(977, '', 'B2', 0.2, 1, 'Lexus Chocolate', 1, 1, -1, 'NVMMAA100003.20210530122317', 'NVMMAA100003', 'http://192.168.0.2/images/B2-Lexus Chocolate.peg', 'online', '2021-05-30 12:23:36'),
(978, '', 'C4', 2.5, 1, 'Tiger Biscuit', 1, 1, -1, 'NVMMAA100003.20210602084331', 'NVMMAA100003', 'http://192.168.0.2/images/C4-Tiger Biscuit.jpg', 'offline', '2021-06-02 08:43:53'),
(979, '', 'D3', 0, 1, 'Coca-Cola Can', 1, 1, -1, 'NVMMAA100003.20210602084331', 'NVMMAA100003', 'http://192.168.0.2/images/D3-Coca-Cola Can.jpg', 'offline', '2021-06-02 08:43:58'),
(980, '', 'D3', 0, 1, 'Coca-Cola Can', 1, 1, -1, 'NVMMAA100003.20210602084331', 'NVMMAA100003', 'http://192.168.0.2/images/D3-Coca-Cola Can.jpg', 'offline', '2021-06-02 08:44:03'),
(981, '', 'D1', 2.5, 1, 'Coca-Cola Can', 1, 1, -1, 'NVMMAA100003.20210605154604', 'NVMMAA100003', 'http://192.168.0.2/images/D1-Coca-Cola Can.jpg', 'offline', '2021-06-05 04:17:21'),
(982, '', 'D2', 0, 1, 'Coca-Cola Can', 1, 1, -1, 'NVMMAA100003.20210605154604', 'NVMMAA100003', 'http://192.168.0.2/images/D2-Coca-Cola Can.jpg', 'offline', '2021-06-05 04:17:24'),
(983, '', 'D3', 0, 1, 'Coca-Cola Can', 1, 1, -1, 'NVMMAA100003.20210605154604', 'NVMMAA100003', 'http://192.168.0.2/images/D3-Coca-Cola Can.jpg', 'offline', '2021-06-05 04:17:28'),
(984, '', 'D4', 2.5, 1, '100 Plus Can', 1, 1, -1, 'NVMMAA100003.20210605154648', 'NVMMAA100003', 'http://192.168.0.2/images/D4-100 Plus Can.jpg', 'offline', '2021-06-05 04:18:05'),
(985, '', 'D5', 0, 1, '100 Plus Can', 1, 1, -1, 'NVMMAA100003.20210605154648', 'NVMMAA100003', 'http://192.168.0.2/images/D5-100 Plus Can.jpg', 'offline', '2021-06-05 04:18:09'),
(986, '', 'D6', 0, 1, '100 Plus Can', 1, 1, -1, 'NVMMAA100003.20210605154648', 'NVMMAA100003', 'http://192.168.0.2/images/D6-100 Plus Can.jpg', 'offline', '2021-06-05 04:18:12'),
(987, '', 'E5', 2.5, 1, 'Sprite Can', 1, 1, -1, 'NVMMAA100003.20210605155046', 'NVMMAA100003', 'http://192.168.0.2/images/E5-Sprite Can.jpg', 'offline', '2021-06-05 04:22:03'),
(988, '', 'E6', 0, 1, 'Sprite Can ', 1, 1, -1, 'NVMMAA100003.20210605155046', 'NVMMAA100003', 'http://192.168.0.2/images/E6-Sprite Can .jpg', 'offline', '2021-06-05 04:22:07'),
(989, '', 'E7', 0, 1, 'Nescafe Original', 1, 1, -1, 'NVMMAA100003.20210605155046', 'NVMMAA100003', 'http://192.168.0.2/images/E7-Nescafe Original.jpg', 'offline', '2021-06-05 04:22:10'),
(990, '', 'E8', 2.5, 1, 'Nescafe Original ', 1, 1, -1, 'NVMMAA100003.20210605155104', 'NVMMAA100003', 'http://192.168.0.2/images/E8-Nescafe Original .jpg', 'offline', '2021-06-05 04:22:21'),
(991, '', 'E9', 0, 1, 'Nescafe Mocha', 1, 1, -1, 'NVMMAA100003.20210605155104', 'NVMMAA100003', 'http://192.168.0.2/images/E9-Nescafe Mocha.jpg', 'offline', '2021-06-05 04:22:25'),
(992, '', 'F1', 2.5, 1, 'Milo Can', 1, 1, -1, 'NVMMAA100003.20210605155132', 'NVMMAA100003', 'http://192.168.0.2/images/F1-Milo Can.jpg', 'offline', '2021-06-05 04:22:50'),
(993, '', 'F2', 0, 1, 'Milo Can', 1, 1, -1, 'NVMMAA100003.20210605155132', 'NVMMAA100003', 'http://192.168.0.2/images/F2-Milo Can.jpg', 'offline', '2021-06-05 04:22:53'),
(994, '', 'F3', 0, 1, 'Milo Can', 1, 1, -1, 'NVMMAA100003.20210605155132', 'NVMMAA100003', 'http://192.168.0.2/images/F3-Milo Can.jpg', 'offline', '2021-06-05 04:22:57'),
(995, '', 'A4', 0, 1, 'Twisties (BBQ)', 1, 1, -1, 'NVMMAA100003.20210605171330', 'NVMMAA100003', 'http://192.168.0.2/images/A4-Twisties (BBQ).jpg', 'offline', '2021-06-05 05:00:15'),
(996, '', 'A7', 0, 1, 'Twisties (Cheese)', 1, 1, -1, 'NVMMAA100003.20210605171502', 'NVMMAA100003', 'http://192.168.0.2/images/A7-Twisties (Cheese).jpg', 'offline', '2021-06-05 05:01:44'),
(997, '', 'A8', 0, 1, 'Twisties (Cheese)', 1, 1, -1, 'NVMMAA100003.20210605171502', 'NVMMAA100003', 'http://192.168.0.2/images/A8-Twisties (Cheese).jpg', 'offline', '2021-06-05 05:01:51');

-- --------------------------------------------------------

--
-- Table structure for table `db_select_payment`
--

CREATE TABLE `db_select_payment` (
  `auto_id` int(11) NOT NULL,
  `id` varchar(255) NOT NULL,
  `type` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `image` varchar(255) NOT NULL,
  `status` varchar(255) NOT NULL,
  `date_modified` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `db_select_payment`
--

INSERT INTO `db_select_payment` (`auto_id`, `id`, `type`, `name`, `image`, `status`, `date_modified`) VALUES
(54, '0', 'cash_and_coin', 'Cash and Coin', 'cash_and_coin.jpg', '1', '2021-01-12 08:13:50'),
(55, '1', 'credit_card', 'Credit Card', 'credit_card.jpg', '0', '2021-01-12 08:13:50'),
(56, '2', 'ewallet', 'Maybank QR Pay', 'maybank_qr_pay.jpg', '0', '2021-01-12 08:13:50'),
(57, '3', 'ewallet', 'Grab Pay', 'grab_pay.jpg', '0', '2021-01-12 08:13:50'),
(58, '4', 'ewallet', 'Boost Pay', 'boost_pay.jpg', '0', '2021-01-12 08:13:50'),
(59, '5', 'ewallet', 'TNG Pay', 'tng_pay.jpg', '0', '2021-01-12 08:13:50'),
(60, '6', 'discount_card', 'Discount Card', 'discount_voucher.jpg', '1', '2021-05-30 00:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `db_sensor_data`
--

CREATE TABLE `db_sensor_data` (
  `id` int(11) NOT NULL,
  `temperature` float DEFAULT NULL,
  `door_sensor` tinyint(4) DEFAULT NULL,
  `event_time` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `db_setting`
--

CREATE TABLE `db_setting` (
  `id` int(11) NOT NULL,
  `machine_id` varchar(100) NOT NULL,
  `is_setting_changed` tinyint(1) DEFAULT NULL,
  `is_pwp_enabled` tinyint(4) NOT NULL,
  `mode` varchar(20) DEFAULT NULL,
  `main_lifter_enable` tinyint(4) NOT NULL,
  `sub_lifter_enable` tinyint(4) NOT NULL,
  `credit` float NOT NULL DEFAULT 0,
  `refunding_status` tinyint(4) NOT NULL DEFAULT 0,
  `password` varchar(100) NOT NULL,
  `admin_pw` varchar(30) NOT NULL,
  `api_key` varchar(255) NOT NULL,
  `gkash_username` varchar(255) NOT NULL,
  `gkash_pw` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `db_setting`
--

INSERT INTO `db_setting` (`id`, `machine_id`, `is_setting_changed`, `is_pwp_enabled`, `mode`, `main_lifter_enable`, `sub_lifter_enable`, `credit`, `refunding_status`, `password`, `admin_pw`, `api_key`, `gkash_username`, `gkash_pw`) VALUES
(6, 'NVMMAA100003', NULL, 1, 'Online', 0, 0, 755.06, 0, 'vending8888', 'vending8888', 'fb1e7477b4dabe7d278634dccd4b2585e83425e2cf94c23f', 'nuvendingmalaysia@gmail.com', 'Nuvending1234@@');

-- --------------------------------------------------------

--
-- Table structure for table `db_splash_screen_image`
--

CREATE TABLE `db_splash_screen_image` (
  `id` int(11) NOT NULL,
  `image_url` varchar(255) NOT NULL,
  `firebase_image_url` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `db_splash_screen_image`
--

INSERT INTO `db_splash_screen_image` (`id`, `image_url`, `firebase_image_url`) VALUES
(12, '', '');

-- --------------------------------------------------------

--
-- Table structure for table `db_transaction_flow`
--

CREATE TABLE `db_transaction_flow` (
  `id` int(11) NOT NULL,
  `transaction_flow` int(11) NOT NULL,
  `motor_label` varchar(5) NOT NULL,
  `quantity` int(11) NOT NULL,
  `drop_success` int(11) NOT NULL,
  `payment_method` int(11) NOT NULL,
  `order_number` int(11) NOT NULL,
  `record_time` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `db_transaction_flow`
--

INSERT INTO `db_transaction_flow` (`id`, `transaction_flow`, `motor_label`, `quantity`, `drop_success`, `payment_method`, `order_number`, `record_time`) VALUES
(1, 23, 'A1', 3, 1, 1, 932323, '2020-11-19 02:47:45'),
(2, 223, 'B1', 1, 1, 1, 932323, '2020-11-24 19:00:21'),
(3, 3, 'C2', 1, 1, 3, 932323, '2020-10-24 19:01:18');

-- --------------------------------------------------------

--
-- Table structure for table `db_usb_configuration`
--

CREATE TABLE `db_usb_configuration` (
  `id` int(11) NOT NULL,
  `device` text DEFAULT NULL,
  `port` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `db_usb_configuration`
--

INSERT INTO `db_usb_configuration` (`id`, `device`, `port`) VALUES
(7, 'Discount Card', '/dev/input/by-id/usb-Sycreader_RFID_Technology_Co.__Ltd_SYC_ID_IC_USB_Reader_08FF20140315-event-kbd'),
(8, 'TNG Pay', '/dev/serial/by-id/usb-FalconPro_FP-YMTX_02-200604_00000000-if00'),
(9, 'GHL Pay', '-'),
(10, 'Cash and Coin', '/dev/serial/by-id/usb-FTDI_FT232R_USB_UART_AD0JVSPE-if00-port0');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `db_ads_video`
--
ALTER TABLE `db_ads_video`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `db_motor_capacity`
--
ALTER TABLE `db_motor_capacity`
  ADD PRIMARY KEY (`motor_number`);

--
-- Indexes for table `db_motor_diagnose`
--
ALTER TABLE `db_motor_diagnose`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `db_payment_selection`
--
ALTER TABLE `db_payment_selection`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `db_payment_template`
--
ALTER TABLE `db_payment_template`
  ADD PRIMARY KEY (`payment_id`);

--
-- Indexes for table `db_product`
--
ALTER TABLE `db_product`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `db_promotion_image`
--
ALTER TABLE `db_promotion_image`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `db_rfid_card`
--
ALTER TABLE `db_rfid_card`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `db_row_and_column`
--
ALTER TABLE `db_row_and_column`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `db_row_in_machine`
--
ALTER TABLE `db_row_in_machine`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `db_row_step`
--
ALTER TABLE `db_row_step`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `db_sales_record`
--
ALTER TABLE `db_sales_record`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `db_select_payment`
--
ALTER TABLE `db_select_payment`
  ADD PRIMARY KEY (`auto_id`);

--
-- Indexes for table `db_sensor_data`
--
ALTER TABLE `db_sensor_data`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `db_setting`
--
ALTER TABLE `db_setting`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `db_splash_screen_image`
--
ALTER TABLE `db_splash_screen_image`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `db_transaction_flow`
--
ALTER TABLE `db_transaction_flow`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `db_usb_configuration`
--
ALTER TABLE `db_usb_configuration`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `db_ads_video`
--
ALTER TABLE `db_ads_video`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=289;
--
-- AUTO_INCREMENT for table `db_motor_capacity`
--
ALTER TABLE `db_motor_capacity`
  MODIFY `motor_number` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT for table `db_motor_diagnose`
--
ALTER TABLE `db_motor_diagnose`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=195;
--
-- AUTO_INCREMENT for table `db_payment_selection`
--
ALTER TABLE `db_payment_selection`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `db_product`
--
ALTER TABLE `db_product`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12294;
--
-- AUTO_INCREMENT for table `db_promotion_image`
--
ALTER TABLE `db_promotion_image`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
--
-- AUTO_INCREMENT for table `db_rfid_card`
--
ALTER TABLE `db_rfid_card`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;
--
-- AUTO_INCREMENT for table `db_row_and_column`
--
ALTER TABLE `db_row_and_column`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1781;
--
-- AUTO_INCREMENT for table `db_row_in_machine`
--
ALTER TABLE `db_row_in_machine`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=61;
--
-- AUTO_INCREMENT for table `db_row_step`
--
ALTER TABLE `db_row_step`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;
--
-- AUTO_INCREMENT for table `db_sales_record`
--
ALTER TABLE `db_sales_record`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=998;
--
-- AUTO_INCREMENT for table `db_select_payment`
--
ALTER TABLE `db_select_payment`
  MODIFY `auto_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=62;
--
-- AUTO_INCREMENT for table `db_sensor_data`
--
ALTER TABLE `db_sensor_data`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT for table `db_setting`
--
ALTER TABLE `db_setting`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
--
-- AUTO_INCREMENT for table `db_splash_screen_image`
--
ALTER TABLE `db_splash_screen_image`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;
--
-- AUTO_INCREMENT for table `db_transaction_flow`
--
ALTER TABLE `db_transaction_flow`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT for table `db_usb_configuration`
--
ALTER TABLE `db_usb_configuration`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
