package com.university;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DatabaseUtil {

    private static final String URL = "jdbc:mysql://localhost:3306/university_db";

    private static final String USER = "root";

    // Real password comes from the UNIVERSITY_DB_PASSWORD environment variable, never from the repo
    private static final String PASSWORD =
            System.getenv().getOrDefault("UNIVERSITY_DB_PASSWORD", "your_password");

    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(URL, USER, PASSWORD);
    }
}
