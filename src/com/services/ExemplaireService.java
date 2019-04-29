package com.services;

import java.util.List;

import com.models.exemplaire;

public interface ExemplaireService {
	
	public void saveExemplaire(exemplaire exp);
	
	public exemplaire getExemplaire(String codexp);
	
	List<exemplaire> getExemplaires();
	
	public void deleteExemplaire(exemplaire exp);

}
