/*
 Navicat Premium Data Transfer

 Source Server         : localhost
 Source Server Type    : MySQL
 Source Server Version : 50740
 Source Host           : localhost:3306
 Source Schema         : thinkadmin

 Target Server Type    : MySQL
 Target Server Version : 50740
 File Encoding         : 65001

 Date: 17/02/2025 15:19:52
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for migrations
-- ----------------------------
DROP TABLE IF EXISTS `migrations`;
CREATE TABLE `migrations`  (
  `version` bigint(20) NOT NULL,
  `migration_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `start_time` timestamp(0) NULL DEFAULT NULL,
  `end_time` timestamp(0) NULL DEFAULT NULL,
  `breakpoint` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`version`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of migrations
-- ----------------------------
INSERT INTO `migrations` VALUES (20221013031925, 'InstallAdmin', '2024-08-07 21:45:09', '2024-08-07 21:45:09', 0);
INSERT INTO `migrations` VALUES (20221013031926, 'InstallAdminData', '2024-08-07 21:45:09', '2024-08-07 21:45:10', 0);
INSERT INTO `migrations` VALUES (20221013031927, 'InstallAdmin20230325', '2024-08-07 21:45:10', '2024-08-07 21:45:10', 0);
INSERT INTO `migrations` VALUES (20221013031928, 'InstallAdmin20230621', '2024-08-07 21:45:10', '2024-08-07 21:45:10', 0);
INSERT INTO `migrations` VALUES (20221013045829, 'InstallWechat', '2024-08-07 21:45:10', '2024-08-07 21:45:10', 0);
INSERT INTO `migrations` VALUES (20221013045830, 'InstallWechatData', '2024-08-07 21:45:10', '2024-08-07 21:45:10', 0);
INSERT INTO `migrations` VALUES (20221013045832, 'InstallWechat20230628', '2024-08-07 21:45:10', '2024-08-07 21:45:10', 0);

-- ----------------------------
-- Table structure for system_auth
-- ----------------------------
DROP TABLE IF EXISTS `system_auth`;
CREATE TABLE `system_auth`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `title` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '权限名称',
  `utype` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '身份权限',
  `desc` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '备注说明',
  `sort` bigint(20) NULL DEFAULT 0 COMMENT '排序权重',
  `status` int(1) NULL DEFAULT 1 COMMENT '权限状态(1使用,0禁用)',
  `create_at` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `i73a781d61_sort`(`sort`) USING BTREE,
  INDEX `i73a781d61_title`(`title`) USING BTREE,
  INDEX `i73a781d61_status`(`status`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '系统-权限' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of system_auth
-- ----------------------------
INSERT INTO `system_auth` VALUES (1, 'user', '', '', 0, 1, '2024-08-11 14:14:20');

-- ----------------------------
-- Table structure for system_auth_node
-- ----------------------------
DROP TABLE IF EXISTS `system_auth_node`;
CREATE TABLE `system_auth_node`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `auth` bigint(20) NULL DEFAULT 0 COMMENT '角色',
  `node` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '节点',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `i4cd9aaff6_auth`(`auth`) USING BTREE,
  INDEX `i4cd9aaff6_node`(`node`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 26 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '系统-授权' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of system_auth_node
-- ----------------------------
INSERT INTO `system_auth_node` VALUES (18, 1, 'admin');
INSERT INTO `system_auth_node` VALUES (19, 1, 'admin/recharge_task');
INSERT INTO `system_auth_node` VALUES (20, 1, 'admin/recharge_task/index');
INSERT INTO `system_auth_node` VALUES (21, 1, 'admin/recharge_task/list');
INSERT INTO `system_auth_node` VALUES (22, 1, 'admin/recharge_task/add');
INSERT INTO `system_auth_node` VALUES (23, 1, 'admin/recharge_task/edit');
INSERT INTO `system_auth_node` VALUES (24, 1, 'admin/recharge_task/remove');
INSERT INTO `system_auth_node` VALUES (25, 1, 'admin/recharge_task/state');

-- ----------------------------
-- Table structure for system_base
-- ----------------------------
DROP TABLE IF EXISTS `system_base`;
CREATE TABLE `system_base`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '数据类型',
  `code` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '数据代码',
  `name` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '数据名称',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '数据内容',
  `sort` bigint(20) NULL DEFAULT 0 COMMENT '排序权重',
  `status` int(1) NULL DEFAULT 1 COMMENT '数据状态(0禁用,1启动)',
  `deleted` int(1) NULL DEFAULT 0 COMMENT '删除状态(0正常,1已删)',
  `deleted_at` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '删除时间',
  `deleted_by` bigint(20) NULL DEFAULT 0 COMMENT '删除用户',
  `create_at` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `i2a29c450f_type`(`type`) USING BTREE,
  INDEX `i2a29c450f_code`(`code`) USING BTREE,
  INDEX `i2a29c450f_name`(`name`) USING BTREE,
  INDEX `i2a29c450f_sort`(`sort`) USING BTREE,
  INDEX `i2a29c450f_status`(`status`) USING BTREE,
  INDEX `i2a29c450f_deleted`(`deleted`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '系统-字典' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of system_base
-- ----------------------------

-- ----------------------------
-- Table structure for system_config
-- ----------------------------
DROP TABLE IF EXISTS `system_config`;
CREATE TABLE `system_config`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '配置分类',
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '配置名称',
  `value` varchar(2048) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '配置内容',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `i48e345b98_type`(`type`) USING BTREE,
  INDEX `i48e345b98_name`(`name`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 16 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '系统-配置' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of system_config
-- ----------------------------
INSERT INTO `system_config` VALUES (1, 'base', 'app_name', 'ThinkAdmin');
INSERT INTO `system_config` VALUES (2, 'base', 'app_version', 'v6');
INSERT INTO `system_config` VALUES (3, 'base', 'editor', 'ckeditor5');
INSERT INTO `system_config` VALUES (4, 'base', 'login_name', '系统管理');
INSERT INTO `system_config` VALUES (5, 'base', 'site_copy', '©版权所有 2014-2024 ThinkAdmin');
INSERT INTO `system_config` VALUES (6, 'base', 'site_icon', 'https://thinkadmin.top/static/img/logo.png');
INSERT INTO `system_config` VALUES (7, 'base', 'site_name', 'ThinkAdmin');
INSERT INTO `system_config` VALUES (8, 'base', 'site_theme', 'default');
INSERT INTO `system_config` VALUES (9, 'storage', 'allow_exts', 'doc,gif,ico,jpg,mp3,mp4,p12,pem,png,zip,rar,xls,xlsx');
INSERT INTO `system_config` VALUES (10, 'storage', 'type', 'local');
INSERT INTO `system_config` VALUES (11, 'wechat', 'type', 'api');
INSERT INTO `system_config` VALUES (12, 'base', 'site_host', 'http://localhost');
INSERT INTO `system_config` VALUES (13, 'storage', 'link_type', 'none');
INSERT INTO `system_config` VALUES (14, 'storage', 'name_type', 'xmd5');
INSERT INTO `system_config` VALUES (15, 'storage', 'local_http_protocol', 'follow');

-- ----------------------------
-- Table structure for system_data
-- ----------------------------
DROP TABLE IF EXISTS `system_data`;
CREATE TABLE `system_data`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '配置名',
  `value` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '配置值',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `icbccedc16_name`(`name`) USING BTREE,
  INDEX `icbccedc16_create_time`(`create_time`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '系统-数据' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of system_data
-- ----------------------------

-- ----------------------------
-- Table structure for system_file
-- ----------------------------
DROP TABLE IF EXISTS `system_file`;
CREATE TABLE `system_file`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '上传类型',
  `hash` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '文件哈希',
  `tags` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '文件标签',
  `name` varchar(180) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '文件名称',
  `xext` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '文件后缀',
  `xurl` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '访问链接',
  `xkey` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '文件路径',
  `mime` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '文件类型',
  `size` bigint(20) NULL DEFAULT 0 COMMENT '文件大小',
  `uuid` bigint(20) NULL DEFAULT 0 COMMENT '用户编号',
  `unid` bigint(20) NULL DEFAULT 0 COMMENT '会员编号',
  `isfast` int(1) NULL DEFAULT 0 COMMENT '是否秒传',
  `issafe` int(1) NULL DEFAULT 0 COMMENT '安全模式',
  `status` int(1) NULL DEFAULT 1 COMMENT '上传状态(1悬空,2落地)',
  `create_at` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_at` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `i738a363ca_type`(`type`) USING BTREE,
  INDEX `i738a363ca_hash`(`hash`) USING BTREE,
  INDEX `i738a363ca_uuid`(`uuid`) USING BTREE,
  INDEX `i738a363ca_xext`(`xext`) USING BTREE,
  INDEX `i738a363ca_unid`(`unid`) USING BTREE,
  INDEX `i738a363ca_tags`(`tags`) USING BTREE,
  INDEX `i738a363ca_name`(`name`) USING BTREE,
  INDEX `i738a363ca_status`(`status`) USING BTREE,
  INDEX `i738a363ca_issafe`(`issafe`) USING BTREE,
  INDEX `i738a363ca_isfast`(`isfast`) USING BTREE,
  INDEX `i738a363ca_create_at`(`create_at`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 14 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '系统-文件' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of system_file
-- ----------------------------
INSERT INTO `system_file` VALUES (1, 'local', 'd04c8b8c321f1baedec90a9db1d155ee', '', '充值任务模板.xlsx', 'xlsx', 'http://localhost/upload/d0/4c8b8c321f1baedec90a9db1d155ee.xlsx', 'd0/4c8b8c321f1baedec90a9db1d155ee.xlsx', 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet', 8867, 10000, 0, 0, 0, 2, '2024-08-12 23:35:38', '2024-08-12 23:35:38');
INSERT INTO `system_file` VALUES (2, 'local', 'd04c8b8c321f1baedec90a9db1d155ee', '', '充值任务模板.xlsx', 'xlsx', 'http://localhost/upload/d0/4c8b8c321f1baedec90a9db1d155ee.xlsx', 'd0/4c8b8c321f1baedec90a9db1d155ee.xlsx', 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet', 8867, 10000, 0, 1, 0, 2, '2024-08-12 23:37:23', '2024-08-12 23:37:23');
INSERT INTO `system_file` VALUES (3, 'local', 'd04c8b8c321f1baedec90a9db1d155ee', '', '充值任务模板.xlsx', 'xlsx', 'http://localhost/upload/d0/4c8b8c321f1baedec90a9db1d155ee.xlsx', 'd0/4c8b8c321f1baedec90a9db1d155ee.xlsx', 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet', 8867, 10000, 0, 1, 0, 2, '2024-08-13 00:07:39', '2024-08-13 00:07:39');
INSERT INTO `system_file` VALUES (4, 'local', 'd04c8b8c321f1baedec90a9db1d155ee', '', '充值任务模板.xlsx', 'xlsx', 'http://localhost/upload/d0/4c8b8c321f1baedec90a9db1d155ee.xlsx', 'd0/4c8b8c321f1baedec90a9db1d155ee.xlsx', 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet', 8867, 10000, 0, 1, 0, 2, '2024-08-13 00:09:28', '2024-08-13 00:09:28');
INSERT INTO `system_file` VALUES (5, 'local', 'd04c8b8c321f1baedec90a9db1d155ee', '', '充值任务模板.xlsx', 'xlsx', 'http://localhost/upload/d0/4c8b8c321f1baedec90a9db1d155ee.xlsx', 'd0/4c8b8c321f1baedec90a9db1d155ee.xlsx', 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet', 8867, 10000, 0, 1, 0, 2, '2024-08-13 00:12:10', '2024-08-13 00:12:10');
INSERT INTO `system_file` VALUES (6, 'local', 'd04c8b8c321f1baedec90a9db1d155ee', '', '充值任务模板.xlsx', 'xlsx', 'http://localhost/upload/d0/4c8b8c321f1baedec90a9db1d155ee.xlsx', 'd0/4c8b8c321f1baedec90a9db1d155ee.xlsx', 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet', 8867, 10000, 0, 1, 0, 2, '2024-08-13 00:12:19', '2024-08-13 00:12:19');
INSERT INTO `system_file` VALUES (7, 'local', 'd04c8b8c321f1baedec90a9db1d155ee', '', '充值任务模板.xlsx', 'xlsx', 'http://localhost/upload/d0/4c8b8c321f1baedec90a9db1d155ee.xlsx', 'd0/4c8b8c321f1baedec90a9db1d155ee.xlsx', 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet', 8867, 10000, 0, 1, 0, 2, '2024-08-13 00:12:56', '2024-08-13 00:12:56');
INSERT INTO `system_file` VALUES (8, 'local', 'd04c8b8c321f1baedec90a9db1d155ee', '', '充值任务模板.xlsx', 'xlsx', 'http://localhost/upload/d0/4c8b8c321f1baedec90a9db1d155ee.xlsx', 'd0/4c8b8c321f1baedec90a9db1d155ee.xlsx', 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet', 8867, 10000, 0, 1, 0, 2, '2024-08-13 00:17:23', '2024-08-13 00:17:23');
INSERT INTO `system_file` VALUES (9, 'local', 'd04c8b8c321f1baedec90a9db1d155ee', '', '充值任务模板.xlsx', 'xlsx', 'http://localhost/upload/d0/4c8b8c321f1baedec90a9db1d155ee.xlsx', 'd0/4c8b8c321f1baedec90a9db1d155ee.xlsx', 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet', 8867, 10000, 0, 1, 0, 2, '2024-08-13 00:17:34', '2024-08-13 00:17:34');
INSERT INTO `system_file` VALUES (10, 'local', 'd04c8b8c321f1baedec90a9db1d155ee', '', '充值任务模板.xlsx', 'xlsx', 'http://localhost/upload/d0/4c8b8c321f1baedec90a9db1d155ee.xlsx', 'd0/4c8b8c321f1baedec90a9db1d155ee.xlsx', 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet', 8867, 10000, 0, 1, 0, 2, '2024-08-13 00:17:40', '2024-08-13 00:17:40');
INSERT INTO `system_file` VALUES (11, 'local', 'd04c8b8c321f1baedec90a9db1d155ee', '', '充值任务模板.xlsx', 'xlsx', 'http://localhost/upload/d0/4c8b8c321f1baedec90a9db1d155ee.xlsx', 'd0/4c8b8c321f1baedec90a9db1d155ee.xlsx', 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet', 8867, 10000, 0, 1, 0, 2, '2024-08-13 00:59:08', '2024-08-13 00:59:08');
INSERT INTO `system_file` VALUES (12, 'local', 'd04c8b8c321f1baedec90a9db1d155ee', '', '充值任务模板.xlsx', 'xlsx', 'http://localhost/upload/d0/4c8b8c321f1baedec90a9db1d155ee.xlsx', 'd0/4c8b8c321f1baedec90a9db1d155ee.xlsx', 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet', 8867, 10000, 0, 1, 0, 2, '2024-08-13 00:59:49', '2024-08-13 00:59:49');
INSERT INTO `system_file` VALUES (13, 'local', 'd04c8b8c321f1baedec90a9db1d155ee', '', '充值任务模板.xlsx', 'xlsx', 'http://localhost/upload/d0/4c8b8c321f1baedec90a9db1d155ee.xlsx', 'd0/4c8b8c321f1baedec90a9db1d155ee.xlsx', 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet', 8867, 10000, 0, 1, 0, 2, '2024-08-13 01:00:12', '2024-08-13 01:00:12');

-- ----------------------------
-- Table structure for system_menu
-- ----------------------------
DROP TABLE IF EXISTS `system_menu`;
CREATE TABLE `system_menu`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `pid` bigint(20) NULL DEFAULT 0 COMMENT '上级ID',
  `title` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '菜单名称',
  `icon` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '菜单图标',
  `node` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '节点代码',
  `url` varchar(400) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '链接节点',
  `params` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '链接参数',
  `target` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '_self' COMMENT '打开方式',
  `sort` bigint(20) NULL DEFAULT 0 COMMENT '排序权重',
  `status` int(1) NULL DEFAULT 1 COMMENT '状态(0:禁用,1:启用)',
  `create_at` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `i29b9da675_pid`(`pid`) USING BTREE,
  INDEX `i29b9da675_sort`(`sort`) USING BTREE,
  INDEX `i29b9da675_status`(`status`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 30 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '系统-菜单' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of system_menu
-- ----------------------------
INSERT INTO `system_menu` VALUES (1, 0, 'System Manage', '', '', '#', '', '_self', 100, 1, '2024-08-07 21:45:10');
INSERT INTO `system_menu` VALUES (2, 1, 'System Config', '', '', '#', '', '_self', 0, 1, '2024-08-07 21:45:10');
INSERT INTO `system_menu` VALUES (3, 2, '系统参数配置', 'layui-icon layui-icon-set', 'admin/config/index', 'admin/config/index', '', '_self', 0, 0, '2024-08-07 21:45:10');
INSERT INTO `system_menu` VALUES (4, 2, '系统任务管理', 'layui-icon layui-icon-log', 'admin/queue/index', 'admin/queue/index', '', '_self', 0, 0, '2024-08-07 21:45:10');
INSERT INTO `system_menu` VALUES (5, 2, 'System Log Manage', 'layui-icon layui-icon-form', 'admin/oplog/index', 'admin/oplog/index', '', '_self', 0, 1, '2024-08-07 21:45:10');
INSERT INTO `system_menu` VALUES (6, 2, '数据字典管理', 'layui-icon layui-icon-code-circle', 'admin/base/index', 'admin/base/index', '', '_self', 0, 0, '2024-08-07 21:45:10');
INSERT INTO `system_menu` VALUES (7, 2, '系统文件管理', 'layui-icon layui-icon-carousel', 'admin/file/index', 'admin/file/index', '', '_self', 0, 0, '2024-08-07 21:45:10');
INSERT INTO `system_menu` VALUES (8, 2, 'System Menu Manage', 'layui-icon layui-icon-layouts', 'admin/menu/index', 'admin/menu/index', '', '_self', 0, 1, '2024-08-07 21:45:10');
INSERT INTO `system_menu` VALUES (9, 1, 'Authority Manage', '', '', '#', '', '_self', 0, 1, '2024-08-07 21:45:10');
INSERT INTO `system_menu` VALUES (10, 9, 'System Authority Manage', 'layui-icon layui-icon-vercode', 'admin/auth/index', 'admin/auth/index', '', '_self', 0, 1, '2024-08-07 21:45:10');
INSERT INTO `system_menu` VALUES (11, 9, 'User', 'layui-icon layui-icon-username', 'admin/user/index', 'admin/user/index', '', '_self', 0, 1, '2024-08-07 21:45:10');
INSERT INTO `system_menu` VALUES (25, 1, 'Recharge System', '', '', '#', '', '_self', 0, 1, '2024-08-08 12:46:59');
INSERT INTO `system_menu` VALUES (26, 25, 'Equipment Manage', 'layui-icon layui-icon-layer', 'admin/equipment/index', 'admin/equipment/index', '', '_self', 0, 1, '2024-08-08 12:47:43');
INSERT INTO `system_menu` VALUES (27, 25, 'Equipment User Bind', 'layui-icon layui-icon-lock', 'admin/equipment_user_bind/index', 'admin/equipment_user_bind/index', '', '_self', 0, 1, '2024-08-11 15:42:01');
INSERT INTO `system_menu` VALUES (28, 25, 'Recharge Task', 'layui-icon layui-icon-email', 'admin/recharge_task/index', 'admin/recharge_task/index', '', '_self', 0, 1, '2024-08-11 15:43:36');
INSERT INTO `system_menu` VALUES (29, 9, 'IP Manage', 'layui-icon layui-icon-leaf', '', 'admin/WhiteAddress/index', '', '_self', 0, 1, '2024-09-12 12:57:07');

-- ----------------------------
-- Table structure for system_oplog
-- ----------------------------
DROP TABLE IF EXISTS `system_oplog`;
CREATE TABLE `system_oplog`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `node` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '当前操作节点',
  `geoip` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '操作者IP地址',
  `action` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '操作行为名称',
  `content` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '操作内容描述',
  `username` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '操作人用户名',
  `create_at` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `id7cb1c775_create_at`(`create_at`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 177 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '系统-日志' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of system_oplog
-- ----------------------------
INSERT INTO `system_oplog` VALUES (1, 'admin/login/index', '127.0.0.1', '系统用户登录', '登录系统后台成功', 'admin', '2024-08-08 12:44:36');
INSERT INTO `system_oplog` VALUES (2, 'admin/menu/state', '127.0.0.1', '系统菜单管理', '修改系统菜单[,12,13,14,15,16,17,18,19,20,21,22,23,24,]状态', 'admin', '2024-08-08 12:46:36');
INSERT INTO `system_oplog` VALUES (3, 'admin/menu/add', '127.0.0.1', '系统菜单管理', '增加系统菜单[25]成功', 'admin', '2024-08-08 12:46:59');
INSERT INTO `system_oplog` VALUES (4, 'admin/menu/add', '127.0.0.1', '系统菜单管理', '增加系统菜单[26]成功', 'admin', '2024-08-08 12:47:43');
INSERT INTO `system_oplog` VALUES (5, 'admin/menu/edit', '127.0.0.1', '系统菜单管理', '更新系统菜单[26]记录', 'admin', '2024-08-08 12:52:45');
INSERT INTO `system_oplog` VALUES (6, 'admin/menu/remove', '127.0.0.1', '系统菜单管理', '删除系统菜单[,12,13,14,15,16,17,18,19,20,21,22,23,24,]成功', 'admin', '2024-08-08 12:56:35');
INSERT INTO `system_oplog` VALUES (7, 'admin/menu/edit', '127.0.0.1', '系统菜单管理', '更新系统菜单[26]记录', 'admin', '2024-08-08 13:02:33');
INSERT INTO `system_oplog` VALUES (8, 'admin/login/index', '127.0.0.1', '系统用户登录', '登录系统后台成功', 'admin', '2024-08-08 13:56:17');
INSERT INTO `system_oplog` VALUES (9, 'admin/login/index', '127.0.0.1', '系统用户登录', '登录系统后台成功', 'admin', '2024-08-08 15:57:17');
INSERT INTO `system_oplog` VALUES (10, 'admin/login/index', '127.0.0.1', '系统用户登录', '登录系统后台成功', 'admin', '2024-08-09 18:24:51');
INSERT INTO `system_oplog` VALUES (11, 'admin/login/index', '127.0.0.1', '系统用户登录', '登录系统后台成功', 'admin', '2024-08-09 19:02:34');
INSERT INTO `system_oplog` VALUES (12, 'admin/api.system/clear', '127.0.0.1', '系统运维管理', '清理网站日志缓存', 'admin', '2024-08-09 19:15:53');
INSERT INTO `system_oplog` VALUES (13, 'admin/menu/edit', '127.0.0.1', '系统菜单管理', '更新系统菜单[26]记录', 'admin', '2024-08-09 19:50:45');
INSERT INTO `system_oplog` VALUES (14, 'admin/menu/state', '127.0.0.1', '系统菜单管理', '修改系统菜单[,3,]状态', 'admin', '2024-08-09 19:51:32');
INSERT INTO `system_oplog` VALUES (15, 'admin/menu/state', '127.0.0.1', '系统菜单管理', '修改系统菜单[,4,]状态', 'admin', '2024-08-09 19:51:35');
INSERT INTO `system_oplog` VALUES (16, 'admin/menu/state', '127.0.0.1', '系统菜单管理', '修改系统菜单[,5,]状态', 'admin', '2024-08-09 19:51:37');
INSERT INTO `system_oplog` VALUES (17, 'admin/menu/state', '127.0.0.1', '系统菜单管理', '修改系统菜单[,6,]状态', 'admin', '2024-08-09 19:51:41');
INSERT INTO `system_oplog` VALUES (18, 'admin/menu/state', '127.0.0.1', '系统菜单管理', '修改系统菜单[,7,]状态', 'admin', '2024-08-09 19:51:42');
INSERT INTO `system_oplog` VALUES (19, 'admin/menu/state', '127.0.0.1', '系统菜单管理', '修改系统菜单[,1,2,5,]状态', 'admin', '2024-08-09 19:51:48');
INSERT INTO `system_oplog` VALUES (20, 'admin/menu/edit', '127.0.0.1', '系统菜单管理', '更新系统菜单[26]记录', 'admin', '2024-08-09 19:55:22');
INSERT INTO `system_oplog` VALUES (21, 'admin/login/index', '127.0.0.1', '系统用户登录', '登录系统后台成功', 'admin', '2024-08-10 09:07:44');
INSERT INTO `system_oplog` VALUES (22, 'admin/login/index', '127.0.0.1', '系统用户登录', '登录系统后台成功', 'admin', '2024-08-10 14:45:16');
INSERT INTO `system_oplog` VALUES (23, 'admin/user/edit', '127.0.0.1', '系统用户管理', '更新系统用户[10000]记录', 'admin', '2024-08-10 16:01:33');
INSERT INTO `system_oplog` VALUES (24, 'admin/user/edit', '127.0.0.1', '系统用户管理', '更新系统用户[10000]记录', 'admin', '2024-08-10 17:43:15');
INSERT INTO `system_oplog` VALUES (25, 'admin/login/index', '127.0.0.1', '系统用户登录', '登录系统后台成功', 'admin', '2024-08-10 21:04:47');
INSERT INTO `system_oplog` VALUES (26, 'admin/login/index', '127.0.0.1', '系统用户登录', '登录系统后台成功', 'admin', '2024-08-11 13:02:21');
INSERT INTO `system_oplog` VALUES (27, 'admin/login/indexpost', '127.0.0.1', '系统用户登录', '登录系统后台成功', 'admin', '2024-08-11 13:37:40');
INSERT INTO `system_oplog` VALUES (28, 'admin/login/index', '127.0.0.1', '系统用户登录', '登录系统后台成功', 'admin', '2024-08-11 13:39:14');
INSERT INTO `system_oplog` VALUES (29, 'admin/auth/add', '127.0.0.1', '系统权限管理', '增加系统权限[1]成功', 'admin', '2024-08-11 14:14:20');
INSERT INTO `system_oplog` VALUES (30, 'admin/auth/add', '127.0.0.1', '系统权限管理', '配置系统权限[1]授权成功', 'admin', '2024-08-11 14:14:20');
INSERT INTO `system_oplog` VALUES (31, 'admin/user/add', '127.0.0.1', '系统用户管理', '增加系统用户[10001]成功', 'admin', '2024-08-11 14:14:48');
INSERT INTO `system_oplog` VALUES (32, 'admin/auth/edit', '127.0.0.1', '系统权限管理', '更新系统权限[1]记录', 'admin', '2024-08-11 15:40:48');
INSERT INTO `system_oplog` VALUES (33, 'admin/auth/edit', '127.0.0.1', '系统权限管理', '配置系统权限[1]授权成功', 'admin', '2024-08-11 15:40:48');
INSERT INTO `system_oplog` VALUES (34, 'admin/menu/add', '127.0.0.1', '系统菜单管理', '增加系统菜单[27]成功', 'admin', '2024-08-11 15:42:01');
INSERT INTO `system_oplog` VALUES (35, 'admin/menu/edit', '127.0.0.1', '系统菜单管理', '更新系统菜单[27]记录', 'admin', '2024-08-11 15:43:07');
INSERT INTO `system_oplog` VALUES (36, 'admin/menu/add', '127.0.0.1', '系统菜单管理', '增加系统菜单[28]成功', 'admin', '2024-08-11 15:43:35');
INSERT INTO `system_oplog` VALUES (37, 'admin/menu/edit', '127.0.0.1', '系统菜单管理', '更新系统菜单[28]记录', 'admin', '2024-08-11 15:43:55');
INSERT INTO `system_oplog` VALUES (38, 'admin/login/index', '127.0.0.1', '系统用户登录', '登录系统后台成功', 'admin', '2024-08-12 10:07:03');
INSERT INTO `system_oplog` VALUES (39, 'admin/login/index', '127.0.0.1', '系统用户登录', '登录系统后台成功', 'admin', '2024-08-12 10:09:38');
INSERT INTO `system_oplog` VALUES (40, 'admin/login/index', '127.0.0.1', '系统用户登录', '登录系统后台成功', 'admin', '2024-08-12 10:17:49');
INSERT INTO `system_oplog` VALUES (41, 'admin/menu/edit', '127.0.0.1', '系统菜单管理', 'Update: Menus [ 28 ]', 'admin', '2024-08-12 10:21:52');
INSERT INTO `system_oplog` VALUES (42, 'admin/menu/edit', '127.0.0.1', '系统菜单管理', 'Update: Menus [ 27 ]', 'admin', '2024-08-12 10:22:18');
INSERT INTO `system_oplog` VALUES (43, 'admin/menu/edit', '127.0.0.1', '系统菜单管理', 'Update: Menus [ 26 ]', 'admin', '2024-08-12 10:22:34');
INSERT INTO `system_oplog` VALUES (44, 'admin/menu/edit', '127.0.0.1', '系统菜单管理', 'Update: Menus [ 25 ]', 'admin', '2024-08-12 10:24:44');
INSERT INTO `system_oplog` VALUES (45, 'admin/menu/state', '127.0.0.1', 'System Menu Manage', 'Modify: Menus [ ,1,2,3,4,5,6,7,8,9,10,11,25,26,27,28, ]', 'admin', '2024-08-12 11:46:42');
INSERT INTO `system_oplog` VALUES (46, 'admin/menu/state', '127.0.0.1', 'System Menu Manage', 'Modify: Menus [ ,1,2,3,4,5,6,7,8,9,10,11,25,26,27,28, ]', 'admin', '2024-08-12 11:46:46');
INSERT INTO `system_oplog` VALUES (47, 'admin/menu/edit', '127.0.0.1', 'System Menu Manage', 'Update: Menus [ 26 ]', 'admin', '2024-08-12 11:47:30');
INSERT INTO `system_oplog` VALUES (48, 'admin/login/index', '127.0.0.1', '系统用户登录', '登录系统后台成功', 'admin', '2024-08-12 14:36:16');
INSERT INTO `system_oplog` VALUES (49, 'admin/login/index', '127.0.0.1', '系统用户登录', '登录系统后台成功', 'admin', '2024-08-12 20:54:15');
INSERT INTO `system_oplog` VALUES (50, 'admin/user/edit', '127.0.0.1', 'Users', 'Update: System User [ 10000 ]', 'admin', '2024-08-13 02:35:15');
INSERT INTO `system_oplog` VALUES (51, 'admin/auth/edit', '127.0.0.1', 'System Authority Manage', 'Update: 系统权限 [ 1 ]', 'admin', '2024-08-13 02:38:28');
INSERT INTO `system_oplog` VALUES (52, 'admin/auth/edit', '127.0.0.1', 'System Authority Manage', '配置系统权限[1]授权成功', 'admin', '2024-08-13 02:38:28');
INSERT INTO `system_oplog` VALUES (53, 'admin/user/pass', '127.0.0.1', 'Users', '修改用户[10001]密码成功', 'admin', '2024-08-13 02:39:12');
INSERT INTO `system_oplog` VALUES (54, 'admin/login/index', '127.0.0.1', '系统用户登录', '登录系统后台成功', 'user', '2024-08-13 02:39:31');
INSERT INTO `system_oplog` VALUES (55, 'admin/login/index', '127.0.0.1', '系统用户登录', '登录系统后台成功', 'admin', '2024-08-13 02:45:00');
INSERT INTO `system_oplog` VALUES (56, 'admin/login/index', '127.0.0.1', '系统用户登录', '登录系统后台成功', 'user', '2024-08-13 02:45:19');
INSERT INTO `system_oplog` VALUES (57, 'admin/login/index', '127.0.0.1', '系统用户登录', '登录系统后台成功', 'admin', '2024-08-13 03:14:15');
INSERT INTO `system_oplog` VALUES (58, 'admin/menu/state', '127.0.0.1', '系统菜单管理', '修改系统菜单[,2,3,4,5,6,7,8,]状态', 'admin', '2024-08-13 03:16:25');
INSERT INTO `system_oplog` VALUES (59, 'admin/login/index', '127.0.0.1', '系统用户登录', '登录系统后台成功', 'admin', '2024-08-13 03:25:11');
INSERT INTO `system_oplog` VALUES (60, 'admin/login/index', '::1', '系统用户登录', '登录系统后台成功', 'user', '2024-08-13 04:11:58');
INSERT INTO `system_oplog` VALUES (61, 'admin/login/index', '::1', '系统用户登录', '登录系统后台成功', 'admin', '2024-08-13 04:32:07');
INSERT INTO `system_oplog` VALUES (62, 'admin/login/index', '::1', '系统用户登录', '登录系统后台成功', 'admin', '2024-08-13 04:35:22');
INSERT INTO `system_oplog` VALUES (63, 'admin/menu/state', '::1', '系统菜单管理', '修改系统菜单[,3,]状态', 'admin', '2024-08-13 04:36:51');
INSERT INTO `system_oplog` VALUES (64, 'admin/menu/state', '::1', '系统菜单管理', '修改系统菜单[,4,]状态', 'admin', '2024-08-13 04:36:55');
INSERT INTO `system_oplog` VALUES (65, 'admin/menu/state', '::1', '系统菜单管理', '修改系统菜单[,6,]状态', 'admin', '2024-08-13 04:37:05');
INSERT INTO `system_oplog` VALUES (66, 'admin/menu/state', '::1', '系统菜单管理', '修改系统菜单[,7,]状态', 'admin', '2024-08-13 04:37:06');
INSERT INTO `system_oplog` VALUES (67, 'admin/login/index', '::1', '系统用户登录', '登录系统后台成功', 'admin', '2024-08-13 04:40:08');
INSERT INTO `system_oplog` VALUES (68, 'admin/login/index', '::1', '系统用户登录', '登录系统后台成功', 'admin', '2024-08-13 04:47:36');
INSERT INTO `system_oplog` VALUES (69, 'admin/login/index', '::1', '系统用户登录', '登录系统后台成功', 'admin', '2024-08-13 04:54:02');
INSERT INTO `system_oplog` VALUES (70, 'admin/login/index', '::1', '系统用户登录', '登录系统后台成功', 'admin', '2024-08-13 04:59:05');
INSERT INTO `system_oplog` VALUES (71, 'admin/login/index', '::1', '系统用户登录', '登录系统后台成功', 'admin', '2024-08-13 05:00:52');
INSERT INTO `system_oplog` VALUES (72, 'admin/login/index', '::1', '系统用户登录', '登录系统后台成功', 'admin', '2024-08-13 13:18:38');
INSERT INTO `system_oplog` VALUES (73, 'admin/login/index', '::1', '系统用户登录', '登录系统后台成功', 'admin', '2024-08-13 14:58:31');
INSERT INTO `system_oplog` VALUES (74, 'admin/login/index', '::1', '系统用户登录', '登录系统后台成功', 'admin', '2024-08-13 15:09:50');
INSERT INTO `system_oplog` VALUES (75, 'admin/login/index', '::1', '系统用户登录', '登录系统后台成功', 'admin', '2024-08-13 15:12:09');
INSERT INTO `system_oplog` VALUES (76, 'admin/menu/state', '::1', 'System Menu Manage', 'Modify: Menus [ ,1,2,3,4,5,6,7,8,9,10,11,25,26,27,28, ]', 'admin', '2024-08-13 15:12:34');
INSERT INTO `system_oplog` VALUES (77, 'admin/menu/state', '::1', 'System Menu Manage', 'Modify: Menus [ ,1,2,3,4,5,6,7,8,9,10,11,25,26,27,28, ]', 'admin', '2024-08-13 15:12:39');
INSERT INTO `system_oplog` VALUES (78, 'admin/menu/state', '::1', 'System Menu Manage', 'Modify: Menus [ ,3, ]', 'admin', '2024-08-13 15:12:44');
INSERT INTO `system_oplog` VALUES (79, 'admin/menu/state', '::1', 'System Menu Manage', 'Modify: Menus [ ,5, ]', 'admin', '2024-08-13 15:12:45');
INSERT INTO `system_oplog` VALUES (80, 'admin/menu/state', '::1', 'System Menu Manage', 'Modify: Menus [ ,4, ]', 'admin', '2024-08-13 15:12:47');
INSERT INTO `system_oplog` VALUES (81, 'admin/menu/state', '::1', 'System Menu Manage', 'Modify: Menus [ ,6, ]', 'admin', '2024-08-13 15:12:48');
INSERT INTO `system_oplog` VALUES (82, 'admin/menu/state', '::1', 'System Menu Manage', 'Modify: Menus [ ,1,2,5, ]', 'admin', '2024-08-13 15:12:54');
INSERT INTO `system_oplog` VALUES (83, 'admin/menu/state', '::1', 'System Menu Manage', 'Modify: Menus [ ,7, ]', 'admin', '2024-08-13 15:12:57');
INSERT INTO `system_oplog` VALUES (84, 'admin/menu/edit', '::1', 'System Menu Manage', 'Update: Menus [ 1 ]', 'admin', '2024-08-13 15:14:04');
INSERT INTO `system_oplog` VALUES (85, 'admin/menu/edit', '::1', 'System Menu Manage', 'Update: Menus [ 2 ]', 'admin', '2024-08-13 15:14:18');
INSERT INTO `system_oplog` VALUES (86, 'admin/menu/edit', '::1', 'System Menu Manage', 'Update: Menus [ 5 ]', 'admin', '2024-08-13 15:14:35');
INSERT INTO `system_oplog` VALUES (87, 'admin/menu/edit', '::1', 'System Menu Manage', 'Update: Menus [ 8 ]', 'admin', '2024-08-13 15:14:50');
INSERT INTO `system_oplog` VALUES (88, 'admin/menu/edit', '::1', 'System Menu Manage', 'Update: Menus [ 9 ]', 'admin', '2024-08-13 15:15:07');
INSERT INTO `system_oplog` VALUES (89, 'admin/menu/edit', '::1', 'System Menu Manage', 'Update: Menus [ 10 ]', 'admin', '2024-08-13 15:15:28');
INSERT INTO `system_oplog` VALUES (90, 'admin/menu/edit', '::1', 'System Menu Manage', 'Update: Menus [ 11 ]', 'admin', '2024-08-13 15:15:47');
INSERT INTO `system_oplog` VALUES (91, 'admin/menu/state', '::1', 'System Menu Manage', 'Modify: Menus [ d.initiate_state ]', 'admin', '2024-08-13 15:35:25');
INSERT INTO `system_oplog` VALUES (92, 'admin/menu/state', '::1', 'System Menu Manage', 'Modify: Menus [ d.initiate_state ]', 'admin', '2024-08-13 15:35:27');
INSERT INTO `system_oplog` VALUES (93, 'admin/menu/state', '::1', 'System Menu Manage', 'Modify: Menus [ d.initiate_state ]', 'admin', '2024-08-13 15:36:22');
INSERT INTO `system_oplog` VALUES (94, 'admin/auth/edit', '::1', 'System Authority Manage', 'Update: 系统权限 [ 1 ]', 'admin', '2024-08-13 16:04:49');
INSERT INTO `system_oplog` VALUES (95, 'admin/auth/edit', '::1', 'System Authority Manage', '配置系统权限[1]授权成功', 'admin', '2024-08-13 16:04:49');
INSERT INTO `system_oplog` VALUES (96, 'admin/login/index', '::1', '系统用户登录', '登录系统后台成功', 'admin', '2024-08-14 16:51:23');
INSERT INTO `system_oplog` VALUES (97, 'admin/login/index', '112.0.23.72', '系统用户登录', '登录系统后台成功', 'admin', '2024-08-15 22:51:25');
INSERT INTO `system_oplog` VALUES (98, 'admin/login/index', '112.47.136.47', '系统用户登录', '登录系统后台成功', 'admin', '2024-08-15 22:52:59');
INSERT INTO `system_oplog` VALUES (99, 'admin/login/index', '113.211.208.13', '系统用户登录', '登录系统后台成功', 'admin', '2024-08-16 08:31:42');
INSERT INTO `system_oplog` VALUES (100, 'admin/login/index', '113.211.208.13', '系统用户登录', '登录系统后台成功', 'admin', '2024-08-16 12:12:36');
INSERT INTO `system_oplog` VALUES (101, 'admin/login/index', '112.21.254.36', '系统用户登录', '登录系统后台成功', 'admin', '2024-08-28 14:10:50');
INSERT INTO `system_oplog` VALUES (102, 'admin/login/index', '112.21.254.36', '系统用户登录', '登录系统后台成功', 'admin', '2024-08-28 21:43:15');
INSERT INTO `system_oplog` VALUES (103, 'admin/login/index', '159.89.196.117', '系统用户登录', '登录系统后台成功', 'admin', '2024-08-29 13:45:48');
INSERT INTO `system_oplog` VALUES (104, 'admin/login/index', '113.211.208.99', '系统用户登录', '登录系统后台成功', 'admin', '2024-08-29 22:55:38');
INSERT INTO `system_oplog` VALUES (105, 'admin/login/index', '112.21.254.36', '系统用户登录', '登录系统后台成功', 'user', '2024-08-29 22:56:20');
INSERT INTO `system_oplog` VALUES (106, 'admin/login/index', '175.145.86.93', '系统用户登录', '登录系统后台成功', 'admin', '2024-08-30 10:27:20');
INSERT INTO `system_oplog` VALUES (107, 'admin/user/pass', '175.145.86.93', 'Users', '修改用户[10001]密码成功', 'admin', '2024-08-30 10:31:13');
INSERT INTO `system_oplog` VALUES (108, 'admin/login/index', '175.145.86.93', '系统用户登录', '登录系统后台成功', 'admin', '2024-08-30 10:31:50');
INSERT INTO `system_oplog` VALUES (109, 'admin/user/pass', '175.145.86.93', 'Users', '修改用户[10001]密码成功', 'admin', '2024-08-30 10:32:10');
INSERT INTO `system_oplog` VALUES (110, 'admin/login/index', '175.145.86.93', '系统用户登录', '登录系统后台成功', 'user', '2024-08-30 10:32:27');
INSERT INTO `system_oplog` VALUES (111, 'admin/login/index', '175.145.86.93', '系统用户登录', '登录系统后台成功', 'user', '2024-08-30 10:38:07');
INSERT INTO `system_oplog` VALUES (112, 'admin/login/index', '175.145.86.93', '系统用户登录', '登录系统后台成功', 'admin', '2024-08-30 10:38:28');
INSERT INTO `system_oplog` VALUES (113, 'admin/login/index', '112.21.254.36', '系统用户登录', '登录系统后台成功', 'admin', '2024-08-30 21:25:22');
INSERT INTO `system_oplog` VALUES (114, 'admin/login/index', '113.211.208.99', '系统用户登录', '登录系统后台成功', 'admin', '2024-08-30 21:36:48');
INSERT INTO `system_oplog` VALUES (115, 'admin/login/index', '113.211.208.99', '系统用户登录', '登录系统后台成功', 'user', '2024-08-30 22:35:13');
INSERT INTO `system_oplog` VALUES (116, 'admin/user/add', '113.211.208.99', 'Users', 'Added: System User [ 10002 ]', 'admin', '2024-08-30 23:24:29');
INSERT INTO `system_oplog` VALUES (117, 'admin/user/edit', '113.211.208.99', 'Users', 'Update: System User [ 10001 ]', 'admin', '2024-08-30 23:25:44');
INSERT INTO `system_oplog` VALUES (118, 'admin/user/pass', '113.211.208.99', 'Users', '修改用户[10002]密码成功', 'admin', '2024-08-30 23:26:02');
INSERT INTO `system_oplog` VALUES (119, 'admin/login/index', '113.211.208.99', '系统用户登录', '登录系统后台成功', 'user1', '2024-08-30 23:26:40');
INSERT INTO `system_oplog` VALUES (120, 'admin/login/index', '113.211.208.99', '系统用户登录', '登录系统后台成功', 'user', '2024-08-30 23:49:45');
INSERT INTO `system_oplog` VALUES (121, 'admin/login/index', '113.211.208.99', '系统用户登录', '登录系统后台成功', 'user1', '2024-08-30 23:50:11');
INSERT INTO `system_oplog` VALUES (122, 'admin/login/index', '113.211.208.99', '系统用户登录', '登录系统后台成功', 'admin', '2024-09-02 07:55:36');
INSERT INTO `system_oplog` VALUES (123, 'admin/login/index', '113.211.208.99', '系统用户登录', '登录系统后台成功', 'user', '2024-09-02 09:40:10');
INSERT INTO `system_oplog` VALUES (124, 'admin/login/index', '210.186.153.159', '系统用户登录', '登录系统后台成功', 'admin', '2024-09-03 23:36:26');
INSERT INTO `system_oplog` VALUES (125, 'admin/user/add', '210.186.153.159', 'Users', 'Added: System User [ 10003 ]', 'admin', '2024-09-03 23:42:00');
INSERT INTO `system_oplog` VALUES (126, 'admin/user/add', '210.186.153.159', 'Users', 'Added: System User [ 10004 ]', 'admin', '2024-09-03 23:42:29');
INSERT INTO `system_oplog` VALUES (127, 'admin/user/add', '210.186.153.159', 'Users', 'Added: System User [ 10005 ]', 'admin', '2024-09-03 23:42:55');
INSERT INTO `system_oplog` VALUES (128, 'admin/user/pass', '210.186.153.159', 'Users', '修改用户[10003]密码成功', 'admin', '2024-09-03 23:43:42');
INSERT INTO `system_oplog` VALUES (129, 'admin/user/pass', '210.186.153.159', 'Users', '修改用户[10005]密码成功', 'admin', '2024-09-03 23:43:59');
INSERT INTO `system_oplog` VALUES (130, 'admin/user/pass', '210.186.153.159', 'Users', '修改用户[10004]密码成功', 'admin', '2024-09-03 23:44:21');
INSERT INTO `system_oplog` VALUES (131, 'admin/login/index', '113.211.208.99', '系统用户登录', '登录系统后台成功', 'MR-1', '2024-09-04 00:03:04');
INSERT INTO `system_oplog` VALUES (132, 'admin/login/index', '113.211.208.99', '系统用户登录', '登录系统后台成功', 'MR-1', '2024-09-04 00:03:35');
INSERT INTO `system_oplog` VALUES (133, 'admin/login/index', '183.78.121.170', '系统用户登录', '登录系统后台成功', 'MR-1', '2024-09-04 14:23:48');
INSERT INTO `system_oplog` VALUES (134, 'admin/login/index', '183.78.121.170', '系统用户登录', '登录系统后台成功', 'admin', '2024-09-04 14:30:07');
INSERT INTO `system_oplog` VALUES (135, 'admin/login/index', '183.78.121.170', '系统用户登录', '登录系统后台成功', 'MR-1', '2024-09-04 14:32:58');
INSERT INTO `system_oplog` VALUES (136, 'admin/login/index', '112.21.254.36', '系统用户登录', '登录系统后台成功', 'admin', '2024-09-05 01:16:58');
INSERT INTO `system_oplog` VALUES (137, 'admin/login/index', '113.211.210.35', '系统用户登录', '登录系统后台成功', 'MR-1', '2024-09-09 11:43:47');
INSERT INTO `system_oplog` VALUES (138, 'admin/login/index', '113.211.210.127', '系统用户登录', '登录系统后台成功', 'MS-1', '2024-09-09 11:55:29');
INSERT INTO `system_oplog` VALUES (139, 'admin/login/index', '183.171.74.90', '系统用户登录', '登录系统后台成功', 'MR-1', '2024-09-09 12:48:21');
INSERT INTO `system_oplog` VALUES (140, 'admin/login/index', '210.186.153.159', '系统用户登录', '登录系统后台成功', 'MS-1', '2024-09-09 13:07:43');
INSERT INTO `system_oplog` VALUES (141, 'admin/login/index', '210.186.153.159', '系统用户登录', '登录系统后台成功', 'MS-1', '2024-09-09 13:29:52');
INSERT INTO `system_oplog` VALUES (142, 'admin/login/index', '115.134.96.33', '系统用户登录', '登录系统后台成功', 'admin', '2024-09-09 15:02:06');
INSERT INTO `system_oplog` VALUES (143, '\\admin/login/index', '127.0.0.1', '系统用户登录', '登录系统后台成功', 'admin', '2024-09-09 16:52:56');
INSERT INTO `system_oplog` VALUES (144, '\\admin/menu/state', '127.0.0.1', 'System Menu Manage', 'Modify: Menus [ ,26, ]', 'admin', '2024-09-09 16:58:53');
INSERT INTO `system_oplog` VALUES (145, 'admin/menu/state', '127.0.0.1', 'System Menu Manage', 'Modify: Menus [ ,1,25,26, ]', 'admin', '2024-09-09 17:01:35');
INSERT INTO `system_oplog` VALUES (146, 'admin/login/index', '127.0.0.1', '系统用户登录', '登录系统后台成功', 'admin', '2024-09-10 12:49:42');
INSERT INTO `system_oplog` VALUES (147, 'admin/login/index', '127.0.0.1', '系统用户登录', '登录系统后台成功', 'admin', '2024-09-11 13:33:07');
INSERT INTO `system_oplog` VALUES (148, 'admin/user/edit', '127.0.0.1', 'Users', 'Update: System User [ 10004 ]', 'admin', '2024-09-11 14:55:20');
INSERT INTO `system_oplog` VALUES (149, 'admin/user/edit', '127.0.0.1', 'Users', 'Update: System User [ 10005 ]', 'admin', '2024-09-11 15:08:47');
INSERT INTO `system_oplog` VALUES (150, 'admin/user/edit', '127.0.0.1', 'Users', 'Update: System User [ 10004 ]', 'admin', '2024-09-11 15:08:58');
INSERT INTO `system_oplog` VALUES (151, 'admin/user/add', '127.0.0.1', 'Users', 'Added: System User [ 10006 ]', 'admin', '2024-09-11 15:09:26');
INSERT INTO `system_oplog` VALUES (152, 'admin/user/state', '127.0.0.1', 'Users', 'Modify: System User [ 10006 ]', 'admin', '2024-09-11 15:09:51');
INSERT INTO `system_oplog` VALUES (153, 'admin/user/remove', '127.0.0.1', 'Users', 'Remove: System User [ 10006 ]', 'admin', '2024-09-11 15:09:55');
INSERT INTO `system_oplog` VALUES (154, 'admin/user/add', '127.0.0.1', 'Users', 'Added: System User [ 10007 ]', 'admin', '2024-09-11 15:28:38');
INSERT INTO `system_oplog` VALUES (155, 'admin/user/edit', '127.0.0.1', 'Users', 'Update: System User [ 10007 ]', 'admin', '2024-09-11 15:51:22');
INSERT INTO `system_oplog` VALUES (156, 'admin/user/edit', '127.0.0.1', 'Users', 'Update: System User [ 10007 ]', 'admin', '2024-09-11 15:51:32');
INSERT INTO `system_oplog` VALUES (157, 'admin/login/index', '127.0.0.1', '系统用户登录', '登录系统后台成功', 'admin', '2024-09-11 21:11:11');
INSERT INTO `system_oplog` VALUES (158, 'admin/login/index', '127.0.0.1', '系统用户登录', '登录系统后台成功', 'admin', '2024-09-12 12:44:19');
INSERT INTO `system_oplog` VALUES (159, 'admin/user/edit', '127.0.0.1', 'Users', 'Update: System User [ 10007 ]', 'admin', '2024-09-12 12:44:43');
INSERT INTO `system_oplog` VALUES (160, 'admin/menu/add', '127.0.0.1', 'System Menu Manage', 'Added: Menus [ 29 ]', 'admin', '2024-09-12 12:57:07');
INSERT INTO `system_oplog` VALUES (161, 'admin/menu/edit', '127.0.0.1', 'System Menu Manage', 'Update: Menus [ 29 ]', 'admin', '2024-09-12 12:57:28');
INSERT INTO `system_oplog` VALUES (162, 'admin/menu/edit', '127.0.0.1', 'System Menu Manage', 'Update: Menus [ 29 ]', 'admin', '2024-09-12 13:29:39');
INSERT INTO `system_oplog` VALUES (163, 'admin/menu/edit', '127.0.0.1', 'System Menu Manage', 'Update: Menus [ 29 ]', 'admin', '2024-09-12 13:30:22');
INSERT INTO `system_oplog` VALUES (164, 'admin/menu/edit', '127.0.0.1', 'System Menu Manage', 'Update: Menus [ 29 ]', 'admin', '2024-09-12 13:31:14');
INSERT INTO `system_oplog` VALUES (165, 'admin/white_mac_address/add', '127.0.0.1', 'Users', 'Added: System User [ 10008 ]', 'admin', '2024-09-12 14:09:36');
INSERT INTO `system_oplog` VALUES (166, 'admin/white_mac_address/add', '127.0.0.1', 'Users', 'Added: System User [ 10009 ]', 'admin', '2024-09-12 14:10:01');
INSERT INTO `system_oplog` VALUES (167, 'admin/login/index', '127.0.0.1', '系统用户登录', '登录系统后台成功', 'admin', '2024-09-12 20:53:47');
INSERT INTO `system_oplog` VALUES (168, 'admin/login/index', '127.0.0.1', '系统用户登录', '登录系统后台成功', 'admin', '2024-09-12 22:01:09');
INSERT INTO `system_oplog` VALUES (169, 'admin/login/index', '127.0.0.1', '系统用户登录', '登录系统后台成功', 'admin', '2024-09-13 10:59:57');
INSERT INTO `system_oplog` VALUES (170, 'admin/login/index', '127.0.0.1', '系统用户登录', '登录系统后台成功', 'admin', '2024-09-19 15:57:08');
INSERT INTO `system_oplog` VALUES (171, 'admin/login/index', '127.0.0.1', '系统用户登录', '登录系统后台成功', 'admin', '2024-10-02 12:59:30');
INSERT INTO `system_oplog` VALUES (172, 'admin/user/state', '127.0.0.1', 'Users', 'Modify: System User [ 10007 ]', 'admin', '2024-10-02 13:03:02');
INSERT INTO `system_oplog` VALUES (173, 'admin/user/remove', '127.0.0.1', 'Users', 'Remove: System User [ 10007 ]', 'admin', '2024-10-02 13:03:08');
INSERT INTO `system_oplog` VALUES (174, 'admin/user/add', '127.0.0.1', 'Users', 'Added: System User [ 10008 ]', 'admin', '2024-10-02 13:03:30');
INSERT INTO `system_oplog` VALUES (175, 'admin/login/index', '127.0.0.1', '系统用户登录', '登录系统后台成功', 'admin', '2024-10-11 11:03:19');
INSERT INTO `system_oplog` VALUES (176, 'admin/login/index', '127.0.0.1', '系统用户登录', '登录系统后台成功', 'admin', '2024-10-11 11:22:15');

-- ----------------------------
-- Table structure for system_queue
-- ----------------------------
DROP TABLE IF EXISTS `system_queue`;
CREATE TABLE `system_queue`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '任务编号',
  `title` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '任务名称',
  `command` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '执行指令',
  `exec_pid` bigint(20) NULL DEFAULT 0 COMMENT '执行进程',
  `exec_data` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '执行参数',
  `exec_time` bigint(20) NULL DEFAULT 0 COMMENT '执行时间',
  `exec_desc` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '执行描述',
  `enter_time` decimal(20, 4) NULL DEFAULT 0.0000 COMMENT '开始时间',
  `outer_time` decimal(20, 4) NULL DEFAULT 0.0000 COMMENT '结束时间',
  `loops_time` bigint(20) NULL DEFAULT 0 COMMENT '循环时间',
  `attempts` bigint(20) NULL DEFAULT 0 COMMENT '执行次数',
  `message` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '最新消息',
  `rscript` int(1) NULL DEFAULT 1 COMMENT '任务类型(0单例,1多例)',
  `status` int(1) NULL DEFAULT 1 COMMENT '任务状态(1新任务,2处理中,3成功,4失败)',
  `create_at` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `if64376974_code`(`code`) USING BTREE,
  INDEX `if64376974_title`(`title`) USING BTREE,
  INDEX `if64376974_status`(`status`) USING BTREE,
  INDEX `if64376974_rscript`(`rscript`) USING BTREE,
  INDEX `if64376974_create_at`(`create_at`) USING BTREE,
  INDEX `if64376974_exec_time`(`exec_time`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '系统-任务' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of system_queue
-- ----------------------------

-- ----------------------------
-- Table structure for system_user
-- ----------------------------
DROP TABLE IF EXISTS `system_user`;
CREATE TABLE `system_user`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `usertype` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '用户类型',
  `username` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '用户账号',
  `password` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '用户密码',
  `nickname` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '用户昵称',
  `headimg` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '头像地址',
  `authorize` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '权限授权',
  `contact_qq` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '联系QQ',
  `contact_mail` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '联系邮箱',
  `contact_phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '联系手机',
  `login_ip` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '登录地址',
  `login_at` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '登录时间',
  `login_num` bigint(20) NULL DEFAULT 0 COMMENT '登录次数',
  `describe` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '备注说明',
  `sort` bigint(20) NULL DEFAULT 0 COMMENT '排序权重',
  `status` int(1) NULL DEFAULT 1 COMMENT '状态(0禁用,1启用)',
  `is_deleted` int(1) NULL DEFAULT 0 COMMENT '删除(1删除,0未删)',
  `create_at` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `daily_limit` int(1) NULL DEFAULT NULL COMMENT '每日充值金额上限',
  `daily_limit_remain` int(1) NULL DEFAULT NULL COMMENT '每日剩余充值金额',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `i34b957835_sort`(`sort`) USING BTREE,
  INDEX `i34b957835_status`(`status`) USING BTREE,
  INDEX `i34b957835_username`(`username`) USING BTREE,
  INDEX `i34b957835_is_deleted`(`is_deleted`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10009 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '系统-用户' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of system_user
-- ----------------------------
INSERT INTO `system_user` VALUES (10000, '', 'admin', '21232f297a57a5a743894a0e4a801fc3', 'super-admin', 'https://thinkadmin.top/static/img/head.png', ',,', '', '', '', '127.0.0.1', '2024-10-11 11:22:15', 61, '', 0, 1, 0, '2024-08-07 21:45:10', 1000, 1000);
INSERT INTO `system_user` VALUES (10001, '', 'user', 'b5b73fae0d87d8b4e2573105f8fbe7bc', 'user', 'http://43.134.191.143/static/theme/img/headimg.png', ',1,', '', '', '', '113.211.208.99', '2024-09-02 09:40:10', 9, '', 0, 1, 0, '2024-08-11 14:14:49', 1000, 1000);
INSERT INTO `system_user` VALUES (10002, '', 'user1', 'b5b73fae0d87d8b4e2573105f8fbe7bc', 'user1', '', ',1,', '', '', '', '113.211.208.99', '2024-08-30 23:50:11', 2, '', 0, 1, 0, '2024-08-30 23:24:29', 1000, 1000);
INSERT INTO `system_user` VALUES (10003, '', 'MR-1', '6b62b326a022b13d34dcbbdf8833d9fc', 'MR', '', ',1,', '', '', '', '183.171.74.90', '2024-09-09 12:48:21', 6, '', 0, 1, 0, '2024-09-03 23:42:01', 1000, 1000);
INSERT INTO `system_user` VALUES (10004, '', 'MS-2', 'a395a6211f5604092e217750e78f72c4', 'MS2', 'http://localhost/static/theme/img/headimg.png', ',1,', '', '', '', '', '', 0, '', 0, 1, 0, '2024-09-03 23:42:30', 1000, 1000);
INSERT INTO `system_user` VALUES (10005, '', 'MS-1', 'a395a6211f5604092e217750e78f72c4', 'MS1', 'http://localhost/static/theme/img/headimg.png', ',1,', '', '', '', '210.186.153.159', '2024-09-09 13:29:52', 3, '', 0, 1, 0, '2024-09-03 23:42:55', 1000, 1000);
INSERT INTO `system_user` VALUES (10006, '', 'test', '098f6bcd4621d373cade4e832627b4f6', 'test', '', ',1,', '', '', '', '', '', 0, '', 0, 0, 1, '2024-09-11 15:09:26', 1000, 1000);
INSERT INTO `system_user` VALUES (10007, '', 'test', '098f6bcd4621d373cade4e832627b4f6', 'test', 'http://localhost/static/theme/img/headimg.png', ',1,', '', '', '', '', '', 0, '', 0, 0, 1, '2024-09-11 15:28:39', 1000, 1000);
INSERT INTO `system_user` VALUES (10008, '', 'Test', '0cbc6611f5540bd0809a388dc95a615b', 'Test', '', ',1,', '', '', '', '', '', 0, '', 0, 1, 0, '2024-10-02 13:03:31', 100, 95);

-- ----------------------------
-- Table structure for t4391_equipment
-- ----------------------------
DROP TABLE IF EXISTS `t4391_equipment`;
CREATE TABLE `t4391_equipment`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `equipment_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '设备名称',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `account` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '充值账号',
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '充值账号登录密码',
  `recharge_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '充值id',
  `recharge_password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '充值密码',
  `initiate_state` tinyint(1) NULL DEFAULT 0 COMMENT '启动状态：停用0，启用1',
  `equipment_state` tinyint(1) NULL DEFAULT 0 COMMENT '设备状态：掉线0，在线1',
  `equipment_task_state` tinyint(1) NULL DEFAULT 0 COMMENT '设备任务的执行状态：空闲0，充值中1',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 23 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t4391_equipment
-- ----------------------------
INSERT INTO `t4391_equipment` VALUES (20, 'LT', '2024-09-03 23:39:38', 'MLJ18782_010', 'HMhm@6011018', 'MLJ18782', 'RY1YU7o^', 0, 0, 0, 'LT MAIN');
INSERT INTO `t4391_equipment` VALUES (21, 'HM', '2024-09-03 23:40:23', 'MLJ18782_001', 'HM@HM@018011', 'MLJ18782', 'RY1YU7o^', 0, 0, 0, 'HM MAIN');
INSERT INTO `t4391_equipment` VALUES (22, 'Test', '2024-10-02 13:01:26', 'MLJ18782_010 ', 'HMHM@6011018', 'MLJ18782', 'RY1YU7o^', 0, 0, 0, '');

-- ----------------------------
-- Table structure for t4391_equipment_user_bind
-- ----------------------------
DROP TABLE IF EXISTS `t4391_equipment_user_bind`;
CREATE TABLE `t4391_equipment_user_bind`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `equipment_id` int(11) NOT NULL COMMENT '设备列表id',
  `system_user_id` int(11) NOT NULL COMMENT '系统账号',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '绑定时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 15 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Fixed;

-- ----------------------------
-- Records of t4391_equipment_user_bind
-- ----------------------------
INSERT INTO `t4391_equipment_user_bind` VALUES (12, 21, 10000, '2024-09-03 23:45:47');
INSERT INTO `t4391_equipment_user_bind` VALUES (11, 21, 10005, '2024-09-03 23:45:32');
INSERT INTO `t4391_equipment_user_bind` VALUES (10, 20, 10003, '2024-09-03 23:45:18');
INSERT INTO `t4391_equipment_user_bind` VALUES (14, 22, 10008, '2024-10-02 13:04:35');

-- ----------------------------
-- Table structure for t4391_recharge_task
-- ----------------------------
DROP TABLE IF EXISTS `t4391_recharge_task`;
CREATE TABLE `t4391_recharge_task`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `state` tinyint(1) NULL DEFAULT 0 COMMENT '0待分配，1执行中，2执行完成，-1错误信息',
  `state_msg` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '状态对应的信息',
  `create_time` datetime(0) NULL DEFAULT NULL,
  `system_user_id` int(11) NULL DEFAULT NULL,
  `recharge_tel` varchar(12) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `amount` float NULL DEFAULT NULL,
  `begin_time` datetime(0) NULL DEFAULT NULL,
  `equipment_id` int(11) NULL DEFAULT NULL COMMENT '设备管理的id',
  `recharge_time` datetime(0) NULL DEFAULT NULL,
  `recharge_result` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '充值结果',
  `transaction_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '订单号',
  `balance` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `result_msg` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '充值结果消息',
  `username` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '用户名',
  `equipment_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '设备名',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 105 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t4391_recharge_task
-- ----------------------------
INSERT INTO `t4391_recharge_task` VALUES (101, -1, '待分配', '2024-09-19 15:58:09', 10000, '0186609800', 5, '2024-09-19 17:35:34', 20, NULL, 'search is none', NULL, NULL, NULL, 'admin', 'LT');
INSERT INTO `t4391_recharge_task` VALUES (102, -1, '待分配', '2024-09-19 17:40:42', 10000, '0186609800', 5, '2024-09-19 17:40:43', 20, NULL, 'Please enter a valid MSISDN.', NULL, NULL, NULL, 'admin', 'LT');
INSERT INTO `t4391_recharge_task` VALUES (103, -1, '待分配', '2024-09-19 17:42:28', 10000, '0186609800', 5, '2024-09-19 17:42:30', 20, NULL, 'Please enter a valid MSISDN.', NULL, NULL, NULL, 'admin', 'LT');
INSERT INTO `t4391_recharge_task` VALUES (104, 0, '待分配', '2024-10-02 13:04:58', 10000, '123456789', 5, NULL, 22, NULL, NULL, NULL, NULL, NULL, 'admin', 'Test');

-- ----------------------------
-- Table structure for t4391_task_unique
-- ----------------------------
DROP TABLE IF EXISTS `t4391_task_unique`;
CREATE TABLE `t4391_task_unique`  (
  `task_id` int(11) NOT NULL COMMENT '任务id',
  PRIMARY KEY (`task_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t4391_task_unique
-- ----------------------------
INSERT INTO `t4391_task_unique` VALUES (36);
INSERT INTO `t4391_task_unique` VALUES (37);
INSERT INTO `t4391_task_unique` VALUES (38);
INSERT INTO `t4391_task_unique` VALUES (39);
INSERT INTO `t4391_task_unique` VALUES (40);
INSERT INTO `t4391_task_unique` VALUES (41);
INSERT INTO `t4391_task_unique` VALUES (42);
INSERT INTO `t4391_task_unique` VALUES (43);
INSERT INTO `t4391_task_unique` VALUES (44);
INSERT INTO `t4391_task_unique` VALUES (45);
INSERT INTO `t4391_task_unique` VALUES (46);
INSERT INTO `t4391_task_unique` VALUES (47);
INSERT INTO `t4391_task_unique` VALUES (48);
INSERT INTO `t4391_task_unique` VALUES (49);
INSERT INTO `t4391_task_unique` VALUES (50);
INSERT INTO `t4391_task_unique` VALUES (51);
INSERT INTO `t4391_task_unique` VALUES (53);
INSERT INTO `t4391_task_unique` VALUES (56);
INSERT INTO `t4391_task_unique` VALUES (57);
INSERT INTO `t4391_task_unique` VALUES (58);
INSERT INTO `t4391_task_unique` VALUES (59);
INSERT INTO `t4391_task_unique` VALUES (60);
INSERT INTO `t4391_task_unique` VALUES (61);
INSERT INTO `t4391_task_unique` VALUES (62);
INSERT INTO `t4391_task_unique` VALUES (63);
INSERT INTO `t4391_task_unique` VALUES (64);
INSERT INTO `t4391_task_unique` VALUES (65);
INSERT INTO `t4391_task_unique` VALUES (66);
INSERT INTO `t4391_task_unique` VALUES (67);
INSERT INTO `t4391_task_unique` VALUES (68);
INSERT INTO `t4391_task_unique` VALUES (69);
INSERT INTO `t4391_task_unique` VALUES (70);
INSERT INTO `t4391_task_unique` VALUES (71);
INSERT INTO `t4391_task_unique` VALUES (72);
INSERT INTO `t4391_task_unique` VALUES (73);
INSERT INTO `t4391_task_unique` VALUES (74);
INSERT INTO `t4391_task_unique` VALUES (75);
INSERT INTO `t4391_task_unique` VALUES (76);
INSERT INTO `t4391_task_unique` VALUES (77);
INSERT INTO `t4391_task_unique` VALUES (78);
INSERT INTO `t4391_task_unique` VALUES (79);
INSERT INTO `t4391_task_unique` VALUES (80);
INSERT INTO `t4391_task_unique` VALUES (81);
INSERT INTO `t4391_task_unique` VALUES (82);
INSERT INTO `t4391_task_unique` VALUES (83);
INSERT INTO `t4391_task_unique` VALUES (84);
INSERT INTO `t4391_task_unique` VALUES (85);
INSERT INTO `t4391_task_unique` VALUES (86);
INSERT INTO `t4391_task_unique` VALUES (87);
INSERT INTO `t4391_task_unique` VALUES (88);
INSERT INTO `t4391_task_unique` VALUES (89);
INSERT INTO `t4391_task_unique` VALUES (90);
INSERT INTO `t4391_task_unique` VALUES (91);
INSERT INTO `t4391_task_unique` VALUES (92);
INSERT INTO `t4391_task_unique` VALUES (93);

-- ----------------------------
-- Table structure for t4391_white_ip
-- ----------------------------
DROP TABLE IF EXISTS `t4391_white_ip`;
CREATE TABLE `t4391_white_ip`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ip` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t4391_white_ip
-- ----------------------------
INSERT INTO `t4391_white_ip` VALUES (1, '127.0.0.1');

-- ----------------------------
-- Table structure for wechat_auto
-- ----------------------------
DROP TABLE IF EXISTS `wechat_auto`;
CREATE TABLE `wechat_auto`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '类型(text,image,news)',
  `time` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '延迟时间',
  `code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '消息编号',
  `appid` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '公众号APPID',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '文本内容',
  `image_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '图片链接',
  `voice_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '语音链接',
  `music_title` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '音乐标题',
  `music_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '音乐链接',
  `music_image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '缩略图片',
  `music_desc` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '音乐描述',
  `video_title` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '视频标题',
  `video_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '视频URL',
  `video_desc` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '视频描述',
  `news_id` bigint(20) NULL DEFAULT 0 COMMENT '图文ID',
  `status` int(1) NULL DEFAULT 1 COMMENT '状态(0禁用,1启用)',
  `create_by` bigint(20) NULL DEFAULT 0 COMMENT '创建人',
  `create_at` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `i15cee0aa7_code`(`code`) USING BTREE,
  INDEX `i15cee0aa7_type`(`type`) USING BTREE,
  INDEX `i15cee0aa7_time`(`time`) USING BTREE,
  INDEX `i15cee0aa7_appid`(`appid`) USING BTREE,
  INDEX `i15cee0aa7_status`(`status`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '微信-回复' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of wechat_auto
-- ----------------------------

-- ----------------------------
-- Table structure for wechat_fans
-- ----------------------------
DROP TABLE IF EXISTS `wechat_fans`;
CREATE TABLE `wechat_fans`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `appid` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '公众号APPID',
  `unionid` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '粉丝unionid',
  `openid` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '粉丝openid',
  `tagid_list` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '粉丝标签id',
  `is_black` int(1) NULL DEFAULT 0 COMMENT '是否为黑名单状态',
  `subscribe` int(1) NULL DEFAULT 0 COMMENT '关注状态(0未关注,1已关注)',
  `nickname` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '用户昵称',
  `sex` int(1) NULL DEFAULT 0 COMMENT '用户性别(1男性,2女性,0未知)',
  `country` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '用户所在国家',
  `province` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '用户所在省份',
  `city` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '用户所在城市',
  `language` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '用户的语言(zh_CN)',
  `headimgurl` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '用户头像',
  `subscribe_time` bigint(20) NULL DEFAULT 0 COMMENT '关注时间',
  `subscribe_at` datetime(0) NULL DEFAULT NULL COMMENT '关注时间',
  `remark` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '备注',
  `subscribe_scene` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '扫码关注场景',
  `qr_scene` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '二维码场景值',
  `qr_scene_str` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '二维码场景内容',
  `create_at` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `ic99bc7baf_appid`(`appid`) USING BTREE,
  INDEX `ic99bc7baf_openid`(`openid`) USING BTREE,
  INDEX `ic99bc7baf_unionid`(`unionid`) USING BTREE,
  INDEX `ic99bc7baf_is_black`(`is_black`) USING BTREE,
  INDEX `ic99bc7baf_subscribe`(`subscribe`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '微信-粉丝' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of wechat_fans
-- ----------------------------

-- ----------------------------
-- Table structure for wechat_fans_tags
-- ----------------------------
DROP TABLE IF EXISTS `wechat_fans_tags`;
CREATE TABLE `wechat_fans_tags`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `appid` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '公众号APPID',
  `name` varchar(35) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '标签名称',
  `count` bigint(20) NULL DEFAULT 0 COMMENT '粉丝总数',
  `create_at` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建日期',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `i1e2a8a9a3_id`(`id`) USING BTREE,
  INDEX `i1e2a8a9a3_appid`(`appid`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '微信-标签' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of wechat_fans_tags
-- ----------------------------

-- ----------------------------
-- Table structure for wechat_keys
-- ----------------------------
DROP TABLE IF EXISTS `wechat_keys`;
CREATE TABLE `wechat_keys`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `appid` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '公众号APPID',
  `type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '类型(text,image,news)',
  `keys` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '关键字',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '文本内容',
  `image_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '图片链接',
  `voice_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '语音链接',
  `music_title` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '音乐标题',
  `music_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '音乐链接',
  `music_image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '缩略图片',
  `music_desc` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '音乐描述',
  `video_title` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '视频标题',
  `video_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '视频URL',
  `video_desc` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '视频描述',
  `news_id` bigint(20) NULL DEFAULT 0 COMMENT '图文ID',
  `sort` bigint(20) NULL DEFAULT 0 COMMENT '排序字段',
  `status` int(1) NULL DEFAULT 1 COMMENT '状态(0禁用,1启用)',
  `create_by` bigint(20) NULL DEFAULT 0 COMMENT '创建人',
  `create_at` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `i23d2c7f47_type`(`type`) USING BTREE,
  INDEX `i23d2c7f47_keys`(`keys`) USING BTREE,
  INDEX `i23d2c7f47_sort`(`sort`) USING BTREE,
  INDEX `i23d2c7f47_appid`(`appid`) USING BTREE,
  INDEX `i23d2c7f47_status`(`status`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '微信-规则' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of wechat_keys
-- ----------------------------

-- ----------------------------
-- Table structure for wechat_media
-- ----------------------------
DROP TABLE IF EXISTS `wechat_media`;
CREATE TABLE `wechat_media`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `md5` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '文件哈希',
  `type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '媒体类型',
  `appid` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '公众号ID',
  `media_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '永久素材MediaID',
  `local_url` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '本地文件链接',
  `media_url` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '远程图片链接',
  `create_at` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `i7f6418618_md5`(`md5`) USING BTREE,
  INDEX `i7f6418618_type`(`type`) USING BTREE,
  INDEX `i7f6418618_appid`(`appid`) USING BTREE,
  INDEX `i7f6418618_media_id`(`media_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '微信-素材' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of wechat_media
-- ----------------------------

-- ----------------------------
-- Table structure for wechat_news
-- ----------------------------
DROP TABLE IF EXISTS `wechat_news`;
CREATE TABLE `wechat_news`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `media_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '永久素材MediaID',
  `local_url` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '永久素材外网URL',
  `article_id` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '关联图文ID(用英文逗号做分割)',
  `is_deleted` int(1) NULL DEFAULT 0 COMMENT '删除状态(0未删除,1已删除)',
  `create_at` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `create_by` bigint(20) NULL DEFAULT 0 COMMENT '创建人',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `ib3c69027e_media_id`(`media_id`) USING BTREE,
  INDEX `ib3c69027e_article_id`(`article_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '微信-图文' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of wechat_news
-- ----------------------------

-- ----------------------------
-- Table structure for wechat_news_article
-- ----------------------------
DROP TABLE IF EXISTS `wechat_news_article`;
CREATE TABLE `wechat_news_article`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `title` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '素材标题',
  `local_url` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '永久素材URL',
  `show_cover_pic` int(4) NULL DEFAULT 0 COMMENT '显示封面(0不显示,1显示)',
  `author` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '文章作者',
  `digest` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '摘要内容',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '图文内容',
  `content_source_url` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '原文地址',
  `read_num` bigint(20) NULL DEFAULT 0 COMMENT '阅读数量',
  `create_at` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '微信-文章' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of wechat_news_article
-- ----------------------------

-- ----------------------------
-- Table structure for wechat_payment_record
-- ----------------------------
DROP TABLE IF EXISTS `wechat_payment_record`;
CREATE TABLE `wechat_payment_record`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '交易方式',
  `code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '发起支付号',
  `appid` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '发起APPID',
  `openid` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '用户OPENID',
  `order_code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '原订单编号',
  `order_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '原订单标题',
  `order_amount` decimal(20, 2) NULL DEFAULT 0.00 COMMENT '原订单金额',
  `payment_time` datetime(0) NULL DEFAULT NULL COMMENT '支付完成时间',
  `payment_trade` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '平台交易编号',
  `payment_status` int(1) NULL DEFAULT 0 COMMENT '支付状态(0未付,1已付,2取消)',
  `payment_amount` decimal(20, 2) NULL DEFAULT 0.00 COMMENT '实际到账金额',
  `payment_bank` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '支付银行类型',
  `payment_notify` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '支付结果通知',
  `payment_remark` varchar(999) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '支付状态备注',
  `refund_status` int(1) NULL DEFAULT 0 COMMENT '退款状态(0未退,1已退)',
  `refund_amount` decimal(20, 2) NULL DEFAULT 0.00 COMMENT '退款金额',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `i43926536a_type`(`type`) USING BTREE,
  INDEX `i43926536a_code`(`code`) USING BTREE,
  INDEX `i43926536a_appid`(`appid`) USING BTREE,
  INDEX `i43926536a_openid`(`openid`) USING BTREE,
  INDEX `i43926536a_order_code`(`order_code`) USING BTREE,
  INDEX `i43926536a_create_time`(`create_time`) USING BTREE,
  INDEX `i43926536a_payment_trade`(`payment_trade`) USING BTREE,
  INDEX `i43926536a_payment_status`(`payment_status`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '微信-支付-行为' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of wechat_payment_record
-- ----------------------------

-- ----------------------------
-- Table structure for wechat_payment_refund
-- ----------------------------
DROP TABLE IF EXISTS `wechat_payment_refund`;
CREATE TABLE `wechat_payment_refund`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '发起支付号',
  `record_code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '子支付编号',
  `refund_time` datetime(0) NULL DEFAULT NULL COMMENT '支付完成时间',
  `refund_trade` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '平台交易编号',
  `refund_status` int(1) NULL DEFAULT 0 COMMENT '支付状态(0未付,1已付,2取消)',
  `refund_amount` decimal(20, 2) NULL DEFAULT 0.00 COMMENT '实际到账金额',
  `refund_account` varchar(180) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '退款目标账号',
  `refund_scode` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '退款状态码',
  `refund_remark` varchar(999) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '支付状态备注',
  `refund_notify` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '退款交易通知',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `i5a815074f_code`(`code`) USING BTREE,
  INDEX `i5a815074f_record_code`(`record_code`) USING BTREE,
  INDEX `i5a815074f_create_time`(`create_time`) USING BTREE,
  INDEX `i5a815074f_refund_trade`(`refund_trade`) USING BTREE,
  INDEX `i5a815074f_refund_status`(`refund_status`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '微信-支付-退款' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of wechat_payment_refund
-- ----------------------------

SET FOREIGN_KEY_CHECKS = 1;
