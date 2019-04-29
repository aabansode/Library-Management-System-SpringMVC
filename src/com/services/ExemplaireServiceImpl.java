package com.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.dao.ExemplaireDAO;
import com.models.exemplaire;

@Service
public class ExemplaireServiceImpl implements ExemplaireService{
	
	@Autowired
	ExemplaireDAO exemplaireDAO;

	@Override
	@Transactional
	public void saveExemplaire(exemplaire exp) {
		exemplaireDAO.saveExemplaire(exp);
		
	}

	@Override
	@Transactional
	public exemplaire getExemplaire(String codexp) {
		return exemplaireDAO.getExemplaire(codexp);

	}


	@Override
	@Transactional
	public List<exemplaire> getExemplaires() {
		return exemplaireDAO.getExemplaires();
	}

	@Override
	@Transactional
	public void deleteExemplaire(exemplaire exp) {
		exemplaireDAO.deleteExemplaire(exp);
	}

}
