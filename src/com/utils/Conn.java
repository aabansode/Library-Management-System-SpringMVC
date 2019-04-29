package com.utils;

import java.sql.Connection;
import java.sql.SQLException;

import com.mchange.v2.c3p0.ComboPooledDataSource;

public class Conn {
	
	private static Connection myconn;
	
	public Conn() {
		
		
	}
	
	public static Connection getInstance() throws SQLException {
		
		String user="myproject";
		String pass="myproject";
		String jdbcUrl="jdbc:oracle:thin:@localhost:1521:orcl";
		//At first it didn't work 
		// I executed dbms_xdb.sethttpport('1158'); , but tnsnames port stayed the same , I thought it's the one 
		//not database url control , it's the port in ..tnsnames.ora in APP directory
		String driver="oracle.jdbc.driver.OracleDriver";
		try {
		Class.forName(driver);
		/*Connection myConn=DriverManager.getConnection(jdbcUrl, user, pass);
		System.out.println("Connection successful "+user+" "+pass);*/
		
		
		ComboPooledDataSource cpds = new ComboPooledDataSource();
		cpds.setDriverClass( "oracle.jdbc.driver.OracleDriver" ); //loads the jdbc driver
		cpds.setJdbcUrl( "jdbc:oracle:thin:@localhost:1521:orcl" );
		cpds.setUser("myproject");
		cpds.setPassword("myproject");
		Connection myConn=cpds.getConnection();
		System.out.println("Connection successful Pooling Done"+user+" "+pass);
		if(myConn==null)
			System.out.println("failed");
		else
			System.out.println("succeded");
		return myConn;
		
		}
		catch(Exception e){
			e.printStackTrace();
			return null;
		}
		
			
		
		
	}
	

}
