package com.models;

import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import org.hibernate.annotations.ValueGenerationType;
import org.springframework.stereotype.Component;

import oracle.sql.DATE;


@Component
public class Adherent {
	
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private Integer noAdh;
	
	private String nom;
	
	private String lastName;
	
	private String adress;
	
	private Integer ncin;
	
	private Integer tel;
	
	private String mail;
	
	@Temporal(TemporalType.DATE)
	private Date dateAdh;

	public Adherent() {
	}

	public Integer getNoAdh() {
		return noAdh;
	}

	public void setNoAdh(Integer noAdh) {
		this.noAdh = noAdh;
	}

	public String getNom() {
		return nom;
	}

	public void setNom(String nom) {
		this.nom = nom;
	}

	public String getLastName() {
		return lastName;
	}

	public void setLastName(String lastName) {
		this.lastName = lastName;
	}

	public String getAdress() {
		return adress;
	}

	public void setAdress(String adress) {
		this.adress = adress;
	}

	public Integer getNcin() {
		return ncin;
	}

	public void setNcin(Integer ncin) {
		this.ncin = ncin;
	}

	public Integer getTel() {
		return tel;
	}

	public void setTel(Integer tel) {
		this.tel = tel;
	}

	public Date getDateAdh() {
		return dateAdh;
	}

	public void setDateAdh(Date dateAdh) {
		this.dateAdh = dateAdh;
	}

	public String getMail() {
		return mail;
	}

	public void setMail(String mail) {
		this.mail = mail;
	}

	public Adherent(String nom, String lastName, String adress, Integer ncin, Integer tel, Date dateAdh,String mail
			) {
		this.nom = nom;
		this.lastName = lastName;
		this.adress = adress;
		this.ncin = ncin;
		this.tel = tel;
		this.mail = mail;
		this.dateAdh = dateAdh;
	}

	@Override
	public String toString() {
		return "Adherent [noAdh=" + noAdh + ", nom=" + nom + ", lastName=" + lastName + ", adress=" + adress + ", ncin="
				+ ncin + ", tel=" + tel + ", mail=" + mail + ", dateAdh=" + dateAdh + "]";
	}

	public Adherent(Integer noAdh, String nom, String lastName, String adress, Integer ncin, Integer tel, Date dateAdh,String mail
			) {
		this.noAdh = noAdh;
		this.nom = nom;
		this.lastName = lastName;
		this.adress = adress;
		this.ncin = ncin;
		this.tel = tel;
		this.dateAdh = dateAdh;
		this.mail = mail;
		
	}
	
	
	
	
	
	


}
