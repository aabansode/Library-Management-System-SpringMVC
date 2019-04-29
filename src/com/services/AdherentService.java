package com.services;

import java.util.List;

import com.models.Adherent;

public interface AdherentService {
	
	public void saveAdherent(Adherent newAdherent);
	
	public List<Adherent> getAdherents();
	
	public void editAdherent(Adherent a);
	
	public void deleteAdherent(Integer ncin);
	
	public Adherent getAdherentByCin(Integer ncin);

}
