package com.models;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Id;

public class EmpruntKey implements Serializable{

	protected String codexp;
	
	protected Date deteEmp;

	public EmpruntKey() {
	}

	public EmpruntKey(String codexp, Date deteEmp) {
		this.codexp = codexp;
		this.deteEmp = deteEmp;
	}
	
	
	
	
}
