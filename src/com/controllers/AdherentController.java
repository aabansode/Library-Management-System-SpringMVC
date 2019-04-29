package com.controllers;

import java.util.List;
import java.util.concurrent.atomic.AtomicInteger;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.dao.AdherentDAO;
import com.dao.AdherentDAOImpl;
import com.models.Adherent;
import com.services.AdherentService;
import com.services.AdherentServiceImpl;


@Controller
@RequestMapping("/adherent")
public class AdherentController {
	
	AtomicInteger ID_GENERATOR = new AtomicInteger(1);
	
	@Autowired
	private AdherentService adherentService;
	
	@RequestMapping("/save")
	public String saveAdherent(@ModelAttribute("adherent") Adherent adherent) {
		
		adherent.setNoAdh(ID_GENERATOR.getAndIncrement());
		System.out.println(adherent);
		adherentService.saveAdherent(adherent);
		return "redirect:/adherent/list";
		
	}
	
	@RequestMapping("/list")
	public String ShowAdherents(Model theModel) {
		List<Adherent> aList=adherentService.getAdherents();
		theModel.addAttribute("adherents", aList);
		return "list-adherents";
		
	}
	
	@RequestMapping("/showform")
	public String showFormAdherent(Model theModel) {
		Adherent a = new Adherent();
		theModel.addAttribute("adherent", a);
		return "adherent-form";
		
	}
	
	@RequestMapping("/delete")
	public String deleteAdherent(@RequestParam("ncin") Integer ncin) {
		System.out.println(">>AdherentController:deleteAdherent , ncin= "+ncin);
		adherentService.deleteAdherent(ncin);
		//System.out.println(">>AherentController "+adherentService.getAdherentByCin(ncin));
		return "redirect:/adherent/list";
	}
	
	@RequestMapping("/showformupdate")
	public String showFormUpdateAdherent(@ModelAttribute("ncin") Integer ncin,Model theModel) {
		//adherentService.editAdherent(a);
		Adherent a =adherentService.getAdherentByCin(ncin);
		System.out.println(">>AdherentCOntroller>>showformupdate ::"+a);
		theModel.addAttribute("adherent", a);
		return "updateForm";
		
	}
	
	@RequestMapping("/updateAdherent")
	public String updateAdherent(@ModelAttribute("adherent") Adherent a) {
		System.out.println(">>AdherentController>>UpdateAdherent :"+a);
		adherentService.editAdherent(a);
		return "redirect:/adherent/list";
	}

}
