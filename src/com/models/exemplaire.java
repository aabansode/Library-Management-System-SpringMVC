package com.models;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import org.springframework.stereotype.Component;

@Entity
@Table(name="exemplaire")
public class exemplaire {
	
	@Id
	//@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name="codexp")
	private String codexp;
	
	@Column(name="codeg")
	private Integer codeg;
	
	@Column(name="etat")
	private String etat;
	
	@Column(name="disp")
	private String disp;
	
	public exemplaire() {
		
	}

	public String getCodexp() {
		return codexp;
	}

	public void setCodexp(String codexp) {
		this.codexp = codexp;
	}

	public Integer getCodeg() {
		return codeg;
	}

	public void setCodeg(Integer codeg) {
		this.codeg = codeg;
	}

	public String getEtat() {
		return etat;
	}

	public void setEtat(String etat) {
		this.etat = etat;
	}

	public String getDisp() {
		return disp;
	}

	public void setDisp(String disp) {
		this.disp = disp;
	}

	@Override
	public String toString() {
		return "exemplaire [codexp=" + codexp + ", codeg=" + codeg + ", etat=" + etat + ", disp=" + disp + "]";
	}


	
	

}
