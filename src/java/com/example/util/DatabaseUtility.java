package com.example.util;


import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DatabaseUtility {
    
    private static final String DB_URL = "jdbc:mysql://localhost:3306/citycabdb"; 
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "12345"; 

   
    public static Connection getConnection() throws SQLException {
        
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            System.out.println("JDBC Driver not found!");
            e.printStackTrace();
            throw new SQLException("JDBC Driver not found", e);
        }

        
        try {
            return DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
        } catch (SQLException e) {
            System.out.println("Connection failed!");
            e.printStackTrace();
            throw e;
        }
    }
}
