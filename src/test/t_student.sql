/*
SQLyog 企业版 - MySQL GUI v8.14 
MySQL - 5.6.35-log : Database - test
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`test` /*!40100 DEFAULT CHARACTER SET utf8 */;

/*Table structure for table `t_student` */

CREATE TABLE `t_student` (
  `sid` varchar(255) NOT NULL,
  `password` varchar(255) DEFAULT NULL,
  `sname` varchar(255) DEFAULT NULL,
  `idNumber` varchar(255) DEFAULT NULL,
  `birthday` date DEFAULT NULL,
  `level` varchar(255) DEFAULT NULL,
  `sex` varchar(255) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `province` varchar(255) DEFAULT NULL,
  `photo` varchar(255) DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  `reason` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`sid`),
  UNIQUE KEY `idNumber` (`idNumber`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `t_student` */

insert  into `t_student`(`sid`,`password`,`sname`,`idNumber`,`birthday`,`level`,`sex`,`phone`,`email`,`province`,`photo`,`status`,`reason`) values ('2','6FF066E2BE719007BCD5A7C8BDA01967','张三','610322200002020204','2017-05-02','3','1','15918883326','11@qq.com','北京市','/upload/2.jpg','1','');
insert  into `t_student`(`sid`,`password`,`sname`,`idNumber`,`birthday`,`level`,`sex`,`phone`,`email`,`province`,`photo`,`status`,`reason`) values ('4','2E4D11FBFB644E21077E3EAA4C4FE707','熊二','610322200002020201','2017-05-11','3','2','15918883327','11@qq.com','山西省','/upload/4.jpg','1','');

/*Table structure for table `t_sys_menu` */

CREATE TABLE `t_sys_menu` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `NAME` varchar(20) DEFAULT NULL,
  `PARENTID` varchar(32) DEFAULT NULL,
  `ICONCLS` varchar(20) DEFAULT NULL,
  `URL` varchar(200) DEFAULT NULL,
  `ENABLE` char(1) DEFAULT NULL,
  `LEVELID` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

/*Data for the table `t_sys_menu` */

insert  into `t_sys_menu`(`ID`,`NAME`,`PARENTID`,`ICONCLS`,`URL`,`ENABLE`,`LEVELID`) values (1,'系统管理','0','','','1','01');
insert  into `t_sys_menu`(`ID`,`NAME`,`PARENTID`,`ICONCLS`,`URL`,`ENABLE`,`LEVELID`) values (2,'用户管理','1','','/user/userManage.do','1','0102');
insert  into `t_sys_menu`(`ID`,`NAME`,`PARENTID`,`ICONCLS`,`URL`,`ENABLE`,`LEVELID`) values (3,'角色管理','1',NULL,'/role/roleManage.do','1','0103');
insert  into `t_sys_menu`(`ID`,`NAME`,`PARENTID`,`ICONCLS`,`URL`,`ENABLE`,`LEVELID`) values (4,'学生管理','1',NULL,'/student/studentManage.do','1','0104');
insert  into `t_sys_menu`(`ID`,`NAME`,`PARENTID`,`ICONCLS`,`URL`,`ENABLE`,`LEVELID`) values (5,'审核管理','1',NULL,'/audit/auditManage.do','1','0105');
insert  into `t_sys_menu`(`ID`,`NAME`,`PARENTID`,`ICONCLS`,`URL`,`ENABLE`,`LEVELID`) values (6,'报名信息统计','1',NULL,'','1','0106');
insert  into `t_sys_menu`(`ID`,`NAME`,`PARENTID`,`ICONCLS`,`URL`,`ENABLE`,`LEVELID`) values (7,'以报名级别统计','6',NULL,'/statistics/statisticsLevel.do','1','0601');
insert  into `t_sys_menu`(`ID`,`NAME`,`PARENTID`,`ICONCLS`,`URL`,`ENABLE`,`LEVELID`) values (8,'以省份统计','6',NULL,'/statistics/statisticsProvince.do','1','0602');
insert  into `t_sys_menu`(`ID`,`NAME`,`PARENTID`,`ICONCLS`,`URL`,`ENABLE`,`LEVELID`) values (9,'以审核统计','6',NULL,'/statistics/statisticsStatus.do','1','0603');

/*Table structure for table `t_sys_role` */

CREATE TABLE `t_sys_role` (
  `ID` int(32) NOT NULL AUTO_INCREMENT,
  `NAME` varchar(60) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

/*Data for the table `t_sys_role` */

insert  into `t_sys_role`(`ID`,`NAME`) values (2,'系统管理');
insert  into `t_sys_role`(`ID`,`NAME`) values (3,'普通管理员');

/*Table structure for table `t_sys_role_menu` */

CREATE TABLE `t_sys_role_menu` (
  `id` int(32) NOT NULL AUTO_INCREMENT,
  `ROLE_ID` int(32) DEFAULT NULL,
  `MENU_ID` int(32) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8;

/*Data for the table `t_sys_role_menu` */

insert  into `t_sys_role_menu`(`id`,`ROLE_ID`,`MENU_ID`) values (1,0,0);
insert  into `t_sys_role_menu`(`id`,`ROLE_ID`,`MENU_ID`) values (15,3,4);
insert  into `t_sys_role_menu`(`id`,`ROLE_ID`,`MENU_ID`) values (32,2,2);
insert  into `t_sys_role_menu`(`id`,`ROLE_ID`,`MENU_ID`) values (33,2,3);
insert  into `t_sys_role_menu`(`id`,`ROLE_ID`,`MENU_ID`) values (34,2,4);
insert  into `t_sys_role_menu`(`id`,`ROLE_ID`,`MENU_ID`) values (35,2,5);

/*Table structure for table `t_sys_user` */

CREATE TABLE `t_sys_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `enable` char(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8;

/*Data for the table `t_sys_user` */

insert  into `t_sys_user`(`id`,`name`,`password`,`enable`) values (1,'admin','011D5F14EB063F992B6316A3A9A71BDD','1');
insert  into `t_sys_user`(`id`,`name`,`password`,`enable`) values (9,'张强','63070E69F35602A8C182D93EE650F8CA','1');
insert  into `t_sys_user`(`id`,`name`,`password`,`enable`) values (10,'李四','B96E2FA33499E41A83783454B0D73A23','1');
insert  into `t_sys_user`(`id`,`name`,`password`,`enable`) values (11,'张丽','30EBCC98ABE88C632A5A74F1927F197D','1');
insert  into `t_sys_user`(`id`,`name`,`password`,`enable`) values (12,'1','5FB810692C0B7B4BC6F6C769668364B2','');
insert  into `t_sys_user`(`id`,`name`,`password`,`enable`) values (13,'2','11CFD2D774B705858EE54AE8925032FB','');
insert  into `t_sys_user`(`id`,`name`,`password`,`enable`) values (16,'3','C4C457D5E1914D63292BF9AA2E5A8003','1');
insert  into `t_sys_user`(`id`,`name`,`password`,`enable`) values (17,'4','0D877E0EF1632E942852217EFFAAAA85','');
insert  into `t_sys_user`(`id`,`name`,`password`,`enable`) values (18,'5','6BA315FF565F4955B8F67B76CFACE180','');
insert  into `t_sys_user`(`id`,`name`,`password`,`enable`) values (27,'12','0ECEA0475DBFB53892B219B8A10197E9','1');

/*Table structure for table `t_sys_user_role` */

CREATE TABLE `t_sys_user_role` (
  `id` int(32) NOT NULL AUTO_INCREMENT,
  `USERID` int(32) DEFAULT NULL,
  `ROLEID` int(32) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

/*Data for the table `t_sys_user_role` */

insert  into `t_sys_user_role`(`id`,`USERID`,`ROLEID`) values (7,1,2);
insert  into `t_sys_user_role`(`id`,`USERID`,`ROLEID`) values (10,9,2);

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
