package com.example.helloworld.config;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

import org.springframework.stereotype.Component;

@Component
public class JdbcConnectionManager {

    private static final String DB_URL = "jdbc:mysql://localhost:3306/StudentDB";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "Priyanshu#123";
    

    public Connection getConnection() throws SQLException {

try {
       Class.forName("com.mysql.cj.jdbc.Driver"); // explicitly load the driver
   } catch (ClassNotFoundException e) {
       throw new SQLException("MySQL Driver not found", e);
   }
        return DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
    }
}
