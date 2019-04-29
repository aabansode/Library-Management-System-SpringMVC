package com.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Types;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.Locale;

import org.springframework.stereotype.Repository;

import com.mchange.v2.c3p0.ComboPooledDataSource;
import com.models.Adherent;
import com.testjdbc.MyClass;
import com.utils.Conn;

import oracle.jdbc.OracleTypes;

//I'm going to use PLSQL stored procedures in this stage as a way to enhance performance compared to Hibernate's reliability
//Check PDF file to assimilate the architecture of the Database 

@Repository
public class AdherentDAOImpl implements AdherentDAO {
	
	
	@Override
	public void saveAdherent(Adherent newAdherent) {
		 

		try {
		

			Conn c=new Conn();
			Connection myConn=c.getInstance();
			
			System.out.println(myConn);
			
			/*String date="Sat Jun 01 12:53:10 IST 2017";
			SimpleDateFormat sdf = new SimpleDateFormat("EE MMM dd HH:mm:ss z yyyy",
                    Locale.ENGLISH);
	        java.util.Date currentdate=sdf.parse(date);
	        java.sql.Date d = new java.sql.Date(currentdate.getTime());*/
			
			CallableStatement cst = myConn.prepareCall("{call Pa_Adherent.addAdherent(?,?,?,?,?,?,?,?)}");

			cst.setInt(1,newAdherent.getNoAdh());
			cst.setString(2, newAdherent.getNom());
			cst.setString(3,newAdherent.getLastName());
			cst.setString(4,newAdherent.getAdress());
			cst.setInt(5,newAdherent.getNcin());
			cst.setInt(6, newAdherent.getTel());
			
			//I have the above method Staring from line 49 thats serves to convert the date to a .sql date
			//but the current one is .date so I converted it to a String first then applied the above method 
			
			DateFormat dateFormat = new SimpleDateFormat("EE MMM dd HH:mm:ss z yyyy",Locale.ENGLISH);  
			String strDate = dateFormat.format(newAdherent.getDateAdh());  
			
			SimpleDateFormat sdf1 = new SimpleDateFormat("EE MMM dd HH:mm:ss z yyyy",
                    Locale.ENGLISH);
	        java.util.Date currentdate1=sdf1.parse(strDate);
	        java.sql.Date d1 = new java.sql.Date(currentdate1.getTime());
	        
			cst.setDate(7, d1);
			cst.setString(8,newAdherent.getMail());
			cst.execute();
			
			
			System.out.println("DONE");
		}
		catch(Exception e ) {
			e.printStackTrace();
		}
		
		
	}


	@Override
	public List<Adherent> getAdherents() {
		
		try {
		Conn c=new Conn();
		Connection myConn=c.getInstance();
		System.out.println(myConn);
		
		CallableStatement cst = myConn.prepareCall("BEGIN getAdherents(?); END;");
		cst.registerOutParameter(1,OracleTypes.CURSOR);
		cst.execute();
		
		ResultSet rs=(ResultSet) cst.getObject(1);
		
		List<Adherent> l = new ArrayList<Adherent>();
		
		while(rs.next()) {
			System.out.println(rs.getInt("noadh")+" "+rs.getString("nom")+" "+rs.getString("prenom")+" "+rs.getString("adresse")+" "
		+rs.getInt("ncin")+" "+rs.getInt("tel")+" "+rs.getDate("dateadh")+" "+rs.getString("email")+"\n");
			
			l.add(new Adherent(rs.getInt("noadh"),rs.getString("nom"),rs.getString("prenom"),rs.getString("adresse"),rs.getInt("ncin"),
					rs.getInt("tel"),rs.getDate("dateadh"),rs.getString("email")));
			
			
		}
		return l;
		
		}
		catch(Exception e) {
			e.printStackTrace();
			return null;
		}
		
		
	}

	@Override
	public void editAdherent(Adherent a) {
		
		try {
			
			Conn c=new Conn();
			Connection myConn=c.getInstance();
			System.out.println(">>AdherentDAOImpl>>editAdherent : "+a);
			CallableStatement cst =myConn.prepareCall("{call Pa_Adherent.modifyAdherent(?,?,?,?)}");
			cst.setInt(1,a.getNcin());
			cst.setString(2,a.getAdress());
			cst.setInt(3,a.getTel());
			cst.setString(4,a.getMail());
			cst.execute();
		    System.out.println("done");
			
		}catch(Exception e) {
			e.printStackTrace();
		}

	}

	@Override
	public void deleteAdherent(Integer ncin) {
		
		try{
		Adherent AdherentToDelete=getAdherentByCin(ncin);
		System.out.println(">>AdherentDAOIpml>>deleteAdherent : "+AdherentToDelete);
		Conn c=new Conn();
		Connection myConn=c.getInstance();
		
		CallableStatement cst = myConn.prepareCall("{call Pa_Adherent.deleteAdherent(?)}");
		cst.setInt(1,AdherentToDelete.getNoAdh());
	    cst.execute();
	    
	    System.out.println("DONE");
		
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		
		

	}


	@Override
	public Adherent getAdherentByCin(Integer ncin){
			
		try {
			
			Conn c=new Conn();
			Connection myConn=c.getInstance();
			System.out.println(myConn);
			
			CallableStatement cst = 
					myConn.prepareCall("{call Pa_Adherent.searchAdherentByCin(?,?,?,?,?,?,?,?)}");
			cst.registerOutParameter(2, Types.INTEGER);
			cst.registerOutParameter(3, Types.VARCHAR);
			cst.registerOutParameter(4,Types.VARCHAR);
			cst.registerOutParameter(5, Types.VARCHAR);
			cst.registerOutParameter(6, Types.INTEGER);
			cst.registerOutParameter(7, Types.DATE);
			cst.registerOutParameter(8, Types.VARCHAR);
			cst.setInt(1,ncin);
			cst.execute();
			
			Adherent newAdherent = new Adherent();
			newAdherent.setNoAdh(cst.getInt(2));
			newAdherent.setNom(cst.getString(3));
			newAdherent.setLastName(cst.getString(4));
			newAdherent.setAdress(cst.getString(5));
			newAdherent.setNcin(ncin);
			newAdherent.setTel(cst.getInt(6));
			newAdherent.setDateAdh(cst.getDate(7));
			newAdherent.setMail(cst.getString(8));
			
			return newAdherent;
			
			
		}catch(Exception e) {
			e.printStackTrace();
			return null;
		}
	}


}
