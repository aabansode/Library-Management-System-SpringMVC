package com.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dao.AdherentDAO;
import com.models.Adherent;

@Service
public class AdherentServiceImpl implements AdherentService {

	@Autowired
	AdherentDAO adherentDAO;

	@Override
	public void saveAdherent(Adherent newAdherent) {
		System.out.println("Service IMPL");
		adherentDAO.saveAdherent(newAdherent);
	}
	
	@Override
	public List<Adherent> getAdherents() {
		return adherentDAO.getAdherents();
	}

	@Override
	public void editAdherent(Adherent a) {

		adherentDAO.editAdherent(a);
	}

	@Override
	public void deleteAdherent(Integer ncin) {

		adherentDAO.deleteAdherent(ncin);
	}

	@Override
	public Adherent getAdherentByCin(Integer ncin) {
		return adherentDAO.getAdherentByCin(ncin);
	}



}
