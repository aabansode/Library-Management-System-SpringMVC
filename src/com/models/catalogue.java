package com.models;

import java.util.Date;

import org.springframework.stereotype.Component;

@Component
public class catalogue {

	private String codeg;
	
	private String titre;
	
	private String nomAut;
	
	private String prenomAut;
	
	private Date anEd;
	
	private String editeur;
	
	private float prix;
	
	public catalogue() {
		
	}

	public String getCodeg() {
		return codeg;
	}

	public void setCodeg(String codeg) {
		this.codeg = codeg;
	}

	public String getTitre() {
		return titre;
	}

	public void setTitre(String titre) {
		this.titre = titre;
	}

	public String getNomAut() {
		return nomAut;
	}

	public void setNomAut(String nomAut) {
		this.nomAut = nomAut;
	}

	public String getPrenomAut() {
		return prenomAut;
	}

	public void setPrenomAut(String prenomAut) {
		this.prenomAut = prenomAut;
	}

	public Date getAnEd() {
		return anEd;
	}

	public void setAnEd(Date anEd) {
		this.anEd = anEd;
	}

	public String getEditeur() {
		return editeur;
	}

	public void setEditeur(String editeur) {
		this.editeur = editeur;
	}

	public float getPrix() {
		return prix;
	}

	public void setPrix(float prix) {
		this.prix = prix;
	}
	
	
	
	
}
