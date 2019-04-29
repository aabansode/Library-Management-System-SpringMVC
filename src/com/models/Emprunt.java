package com.models;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.IdClass;
import javax.persistence.Table;

@Entity
@Table(name="emprunt")
@IdClass(EmpruntKey.class)
public class Emprunt {
	
	@Id
	@Column(name="codexp")
	private String codexp;
	
	@Id 
	@Column(name="dateEmp")
	private Date deteEmp;
	
	@Id
	@Column(name="noAdh")
	private Integer noAdh;
	
	@Column(name="dateRprevue")
	private Date dateRprevue;
	
	@Column(name="datereffective")
	private Date dateReffective;
	

}
