package com.food.config;

import java.sql.Connection;

public class Test {
    public static void main(String[] args) {
        Connection conn = DBConfig.getConnection();

        if (conn == null) {
            System.out.println("Connection is NULL ");
        } else {
            System.out.println("Connection is WORKING ");
        }
    }
}
