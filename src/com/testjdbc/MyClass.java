package com.testjdbc;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.text.SimpleDateFormat;
import java.util.Locale;

import com.utils.Conn;

public class MyClass extends Thread{
	CallableStatement cst;
	Connection myConn;
	@Override
	public void run() {
		try {
			
			Conn c=new Conn();
			myConn=
			myConn=c.getInstance();
			CallableStatement cst = myConn.prepareCall("{call Pa_Adherent.addAdherent(?,?,?,?,?,?,?,?)}");
			System.out.println("cst is "+ cst);
			/*cst.setInt(1,21);
			cst.setString(2, "nomwass");
			cst.setString(3,"prenom2");
			cst.setString(4,"adr2");
			cst.setInt(5,1737883);
			cst.setInt(6, 1990);
			cst.setDate(7, null);
			cst.setString(8,"nom2@gmail.com");
			cst.execute();*/
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	public void setCst(CallableStatement cst) {
		this.cst = cst;
	}
	public void setMyConn(Connection myConn) {
		this.myConn = myConn;
	}
	
	

}
