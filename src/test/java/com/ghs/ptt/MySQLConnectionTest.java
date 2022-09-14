package com.ghs.ptt;

import java.sql.Connection;
import java.sql.DriverManager;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.junit.Test;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.PropertySource;

@Configuration
@PropertySource("classpath:/application.properties") //mysql
public class MySQLConnectionTest {
    
    private static final String DRIVER = "com.mysql.jdbc.Driver";
    private static final String URL = "jdbc:mysql://211.119.132.242:3306/lte_ptt?serverTimezone=UTC&useUnicode=true&characterEncoding=utf8&useSSL=false";
    private static final String USER = "pttadmin";
    private static final String PW = "Ksr5544!";
    
    @Inject
    private SqlSessionFactory sqlFactory;
    
    @Test
    public void testConnection() throws Exception {
        Class.forName(DRIVER);
        
        try(Connection conn = DriverManager.getConnection(URL, USER, PW)) {
            System.out.println(conn);
        } catch(Exception e) {
            e.printStackTrace();
        }
    }


    
}