/*
 Navicat Premium Data Transfer

 Source Server         : KiemThu
 Source Server Type    : MySQL
 Source Server Version : 100136
 Source Host           : localhost:3306
 Source Schema         : tmdt

 Target Server Type    : MySQL
 Target Server Version : 100136
 File Encoding         : 65001

 Date: 05/11/2018 12:27:55
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for admin_user
-- ----------------------------
DROP TABLE IF EXISTS `admin_user`;
CREATE TABLE `admin_user`  (
  `ad_username` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `ad_password` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `ad_phone` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `ad_email` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `ad_img` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  PRIMARY KEY (`ad_username`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for bk_status
-- ----------------------------
DROP TABLE IF EXISTS `bk_status`;
CREATE TABLE `bk_status`  (
  `bk_status_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `bk_status_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  PRIMARY KEY (`bk_status_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for booking
-- ----------------------------
DROP TABLE IF EXISTS `booking`;
CREATE TABLE `booking`  (
  `bk_id` int(11) NOT NULL,
  `bk_status` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `bk_detail_id` int(11) NULL DEFAULT NULL,
  `bk_created` date NULL DEFAULT NULL,
  `user_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  PRIMARY KEY (`bk_id`) USING BTREE,
  INDEX `user_name`(`user_name`) USING BTREE,
  INDEX `bk_detail_id`(`bk_detail_id`) USING BTREE,
  INDEX `bk_status`(`bk_status`) USING BTREE,
  CONSTRAINT `booking_ibfk_1` FOREIGN KEY (`user_name`) REFERENCES `users` (`user_name`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `booking_ibfk_2` FOREIGN KEY (`bk_status`) REFERENCES `bk_status` (`bk_status_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for booking_details
-- ----------------------------
DROP TABLE IF EXISTS `booking_details`;
CREATE TABLE `booking_details`  (
  `booking_id` int(11) NOT NULL,
  `room_id` int(11) NOT NULL,
  `check_in` date NULL DEFAULT NULL COMMENT 'ngày nhận',
  `check_out` date NULL DEFAULT NULL COMMENT 'ngày trả',
  `customer_fullname` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT 'tiền cọc',
  `customer_phone` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `customer_card_number` varchar(11) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `customer_date_of_birth` date NULL DEFAULT NULL,
  `bk_detail_price` int(255) NULL DEFAULT NULL,
  PRIMARY KEY (`room_id`, `booking_id`) USING BTREE,
  INDEX `booking_id`(`booking_id`) USING BTREE,
  CONSTRAINT `booking_details_ibfk_1` FOREIGN KEY (`booking_id`) REFERENCES `booking` (`bk_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `booking_details_ibfk_2` FOREIGN KEY (`room_id`) REFERENCES `room` (`room_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for homestay
-- ----------------------------
DROP TABLE IF EXISTS `homestay`;
CREATE TABLE `homestay`  (
  `homestay_id` int(11) NOT NULL AUTO_INCREMENT,
  `homestay_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `homestay_image` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `homestay_description` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `homestay_location` int(255) NULL DEFAULT NULL,
  `homestay_master` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `homestay_reviews` int(255) NULL DEFAULT NULL,
  `homestay_number_reviews` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`homestay_id`) USING BTREE,
  INDEX `homestay_master`(`homestay_master`) USING BTREE,
  INDEX `homestay_location`(`homestay_location`) USING BTREE,
  CONSTRAINT `homestay_ibfk_1` FOREIGN KEY (`homestay_master`) REFERENCES `users` (`user_name`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `homestay_ibfk_2` FOREIGN KEY (`homestay_location`) REFERENCES `location` (`location_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Compact;

-- ----------------------------
-- Records of homestay
-- ----------------------------
INSERT INTO `homestay` VALUES (1, 'Family Room Terra Cotta Homestay', 'http://localhost:8080/static/homestay_images/homestay_images_1.jpg', 'Đang cập nhật', 2, NULL, 5, 100);
INSERT INTO `homestay` VALUES (2, 'Deluxe Triple Room (B&B) – Dragon Đà Lạt Villa ', 'http://localhost:8080/static/homestay_images/homestay_images_2.jpg', 'Đang cập nhật', 1, NULL, 5, 51);

-- ----------------------------
-- Table structure for location
-- ----------------------------
DROP TABLE IF EXISTS `location`;
CREATE TABLE `location`  (
  `location_id` int(255) NOT NULL AUTO_INCREMENT,
  `location_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  PRIMARY KEY (`location_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Compact;

-- ----------------------------
-- Records of location
-- ----------------------------
INSERT INTO `location` VALUES (1, 'Nha Trang');
INSERT INTO `location` VALUES (2, 'Đà Lạt');
INSERT INTO `location` VALUES (3, 'Đà Nẵng');

-- ----------------------------
-- Table structure for register_service
-- ----------------------------
DROP TABLE IF EXISTS `register_service`;
CREATE TABLE `register_service`  (
  `homestay_id` int(11) NOT NULL,
  `service_id` int(11) NOT NULL,
  `date_started` date NULL DEFAULT NULL,
  `date_finished` date NULL DEFAULT NULL,
  PRIMARY KEY (`homestay_id`, `service_id`) USING BTREE,
  INDEX `service_id`(`service_id`) USING BTREE,
  CONSTRAINT `register_service_ibfk_2` FOREIGN KEY (`service_id`) REFERENCES `service` (`service_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `register_service_ibfk_3` FOREIGN KEY (`homestay_id`) REFERENCES `homestay` (`homestay_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for room
-- ----------------------------
DROP TABLE IF EXISTS `room`;
CREATE TABLE `room`  (
  `room_id` int(11) NOT NULL,
  `room_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `room_status` int(255) NULL DEFAULT NULL COMMENT 'trạng thái phòng(1 trống 0 đã cho thuê )',
  `room_number_guest` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT 'số lượng khách',
  `room_reviews` int(255) NULL DEFAULT NULL COMMENT 'đánh giá',
  `room_number_reviews` int(11) NULL DEFAULT NULL,
  `room_address` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT 'địa chỉ phòng(số nhà đường ....)',
  `room_price` int(10) NULL DEFAULT NULL COMMENT 'giá phòng',
  `room_describe` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT 'mô tả phòng',
  `room_information` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT 'thông tin phòng',
  `room_type` int(255) NULL DEFAULT NULL COMMENT 'loại phòng(tình nhân, bạn bè, cặp đôi)',
  `homestay_id` int(255) NULL DEFAULT NULL,
  `room_image` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  PRIMARY KEY (`room_id`) USING BTREE,
  INDEX `room_type`(`room_type`) USING BTREE,
  INDEX `homestay_id`(`homestay_id`) USING BTREE,
  CONSTRAINT `room_ibfk_2` FOREIGN KEY (`room_type`) REFERENCES `room_type` (`room_type_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `room_ibfk_3` FOREIGN KEY (`homestay_id`) REFERENCES `homestay` (`homestay_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for room_type
-- ----------------------------
DROP TABLE IF EXISTS `room_type`;
CREATE TABLE `room_type`  (
  `room_type_id` int(11) NOT NULL,
  `room_type_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  PRIMARY KEY (`room_type_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for service
-- ----------------------------
DROP TABLE IF EXISTS `service`;
CREATE TABLE `service`  (
  `service_id` int(11) NOT NULL,
  `service_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `service_price` int(10) NULL DEFAULT NULL,
  PRIMARY KEY (`service_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for user_type
-- ----------------------------
DROP TABLE IF EXISTS `user_type`;
CREATE TABLE `user_type`  (
  `user_type_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `user_type_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '(khách hàng hay chủ homestay)',
  PRIMARY KEY (`user_type_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users`  (
  `user_email` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `user_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `user_password` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `user_created` date NULL DEFAULT NULL,
  `user_fullname` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `user_phone` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `user_address` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `user_type` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `user_card_number` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `user_date_of_birth` date NULL DEFAULT NULL,
  PRIMARY KEY (`user_name`) USING BTREE,
  INDEX `user_name`(`user_name`) USING BTREE,
  INDEX `user_type`(`user_type`) USING BTREE,
  CONSTRAINT `users_ibfk_1` FOREIGN KEY (`user_type`) REFERENCES `user_type` (`user_type_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Compact;

SET FOREIGN_KEY_CHECKS = 1;
