package com.atguigu.crowd.test;


import com.atguigu.crowd.entity.Admin;
import com.atguigu.crowd.mapper.AdminMapper;
import com.atguigu.crowd.service.api.AdminService;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.SQLException;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:spring-persist-mybatis.xml","classpath:spring-persist-tx.xml"})
public class CrowdTest {
    @Autowired
    private DataSource dataSource;

    @Autowired
    private AdminMapper adminMapper;

    @Autowired
    private AdminService adminService;

    @Test
    public void testConnection() throws SQLException {
        Connection connection = dataSource.getConnection();
        System.out.println(connection);
    }

    @Test
    public void testInsert(){
        Admin admin = new Admin(null,"tom","123123","汤姆","tom@qq.com",null);
        int i = adminMapper.insert(admin);
        System.out.println("插入了"+i+"行");
    }

    @Test
    public void testLog(){
        Logger logger = LoggerFactory.getLogger(CrowdTest.class);
        logger.debug("debug log!");
        logger.debug("debug log!");
        logger.debug("debug log!");
        logger.info("info log");
        logger.info("info log");
        logger.info("info log");
        logger.warn("warn log");
        logger.warn("warn log");
        logger.warn("warn log");
        logger.error("error log");
        logger.error("error log");
        logger.error("error log");

    }

    @Test
    public void testTx(){
        Admin admin = new Admin(null,"jerry","123123","汤姆","tom@qq.com",null);
        adminService.saveAdmin(admin);
    }

}
