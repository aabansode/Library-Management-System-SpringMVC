package com.testjdbc;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Configurable;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.aspectj.EnableSpringConfigured;
import org.springframework.stereotype.Controller;

import com.controllers.AdherentController;
import com.models.Adherent;
import com.services.AdherentService;
import com.utils.Conn;

@Configuration
@ComponentScan("com")
public class newtest {
	

	public static void main(String[] args) {

		AdherentController ac=new AdherentController();
		//ac.add();
			


}
	
}
