create database project_crowd character set utf8;
use project_crowd;
drop table if exists t_admin;

CREATE TABLE t_admin  (
  id int NOT NULL AUTO_INCREMENT,
  login_acct varchar(255)  NOT NULL,
  user_pswd char(32) NOT NULL,
  user_name varchar(255) NOT NULL,
  email varchar(255) NOT NULL,
  create_time char(19),
  PRIMARY KEY (id)
);