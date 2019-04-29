package com.testjdbc;

import java.io.PrintWriter;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;

import javax.servlet.ServletException;

import com.mchange.v2.c3p0.ComboPooledDataSource;
import com.mchange.v2.c3p0.impl.NewProxyCallableStatement;

import oracle.jdbc.OracleConnection;
import oracle.jdbc.OracleTypes;
import oracle.jdbc.internal.OracleCallableStatement;

public class test {
	
	public static void main(String[]args) throws SQLException {
		System.out.println("test");
		
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
			
			/*
			CallableStatement cst = myConn.prepareCall("{call Pa_Adherent.deleteAdherent(?)}");
			//CallableStatement cst = myConn.prepareCall("{begin Pa_Adherent.deleteAdherent(?);end;}");
			cst.setInt(1,1);
		    cst.execute();
			*/
			
			/*
			String myDate="31-JUL-2016"; // notice JUL, instead of JULY
			// or use some other date string like yyyy-MM-dd
			SimpleDateFormat sdf = new SimpleDateFormat("1-1-2001");
			java.util.Date date = sdf.parse(myDate);
			java.sql.Date d = new java.sql.Date(date.getTime());*/
			
			
			
			
			
			/*
			String date="Sat Jun 01 12:53:10 IST 2017";
			SimpleDateFormat sdf = new SimpleDateFormat("EE MMM dd HH:mm:ss z yyyy",
                    Locale.ENGLISH);
	        java.util.Date currentdate=sdf.parse(date);
	        java.sql.Date d = new java.sql.Date(currentdate.getTime());
	        
			CallableStatement cst = 
	myConn.prepareCall("{call Pa_Adherent.addAdherent(?,?,?,?,?,?,?,?)}");
			cst.setInt(1,10);
			cst.setString(2, "nom2");
			cst.setString(3,"prenom2");
			cst.setString(4,"adr2");
			cst.setInt(5,22222191);
			cst.setInt(6, 27222222);
			cst.setDate(7, d);
			cst.setString(8,"nom2@gmail.com");
			cst.execute();
			
			//Pa_Adherent.addAdherent(1,'nom1','prenom1','adr1',111111,27111111,'8/8/2001','nom1@gmail.com');
			cst.close();
			cst=null;*/
			
			
			
			/*
			CallableStatement cst = 
					myConn.prepareCall("{call Pa_Adherent.searchAdherentByCin(?,?,?,?,?,?,?)}");
			cst.registerOutParameter(2, Types.VARCHAR);
			cst.registerOutParameter(3,Types.VARCHAR);
			cst.registerOutParameter(4, Types.VARCHAR);
			cst.registerOutParameter(5, Types.INTEGER);
			cst.registerOutParameter(6, Types.DATE);
			cst.registerOutParameter(7, Types.VARCHAR);
			cst.setInt(1,333331);
			cst.execute();
			String nom=cst.getString(2);
			String pnom=cst.getString(3);
			String adr=cst.getString(4);
			Integer tel=cst.getInt(5);
			
			String email=cst.getString(7);
			System.out.println("nom : "+nom+" pnom : "+pnom+" adr : "+adr
					+"tel : "+tel+" email: "+email);*/
			
			
			/*
			CallableStatement cst = 
					myConn.prepareCall("{call Pa_Adherent.modifyAdherent(?,?,?,?)}");
			cst.setInt(1,22222);
			cst.setString(2,"newadr2");
			cst.setInt(3,27222221);
			cst.setString(4,"newwnom2@gmail.com");
			cst.execute();
		    System.out.println("done"); */
			
			
			//don't try to cast it to OracleCallableStatement ==> error 
			//CallableStatement cst = 
				//	myConn.prepareCall("{call getAdherents(?)}");
			CallableStatement cst = myConn.prepareCall("BEGIN getAdherents(?); END;");
			//OracleCallableStatement cs = null;
			//cs=(OracleCallableStatement)cst;
			cst.registerOutParameter(1,OracleTypes.CURSOR);
			cst.execute();
			
			ResultSet rs=(ResultSet) cst.getObject(1);
			while(rs.next()) {
				System.out.println(rs.getString("nom")+" "+rs.getString("prenom")+" "+rs.getString("adresse")+" "
			+rs.getInt("ncin")+" "+rs.getInt("tel")+rs.getString("email")+" "+rs.getDate("dateadh")+"\n");
				
			}
			
			System.out.println("done"); 
			myConn.close();
			
			
		}catch(Exception e) {
			e.printStackTrace();
			
			 
		}
		
		   
		
	}

}
