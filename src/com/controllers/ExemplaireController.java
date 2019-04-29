package com.controllers;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.models.exemplaire;
import com.services.ExemplaireService;

@Controller
@RequestMapping("/exemplaire")
public class ExemplaireController {
	
	@Autowired
	ExemplaireService exemplaireService;
	
	@RequestMapping("/list")
	public String getExemplaires(Model theModel) {
		List<exemplaire> l =exemplaireService.getExemplaires();
		System.out.println(">>ExemplaireController "+l);
		theModel.addAttribute("exemplaires",l);
		return "list-exemplaires";
	}
	
	@RequestMapping("/showform")
	public String showSaveForm(Model theModel) {
		theModel.addAttribute("exemplaire",new exemplaire());
		theModel.addAttribute("enter",1);
		return "exemplaire-form";
	}
	

	@RequestMapping("/saveorupdate")
	public String saveOrUpdate(@ModelAttribute("exemplaire") exemplaire exp) {
		System.out.println(">>ExemplaireController>>saveOrUpdate : "+exp);
		exemplaireService.saveExemplaire(exp);
		return "redirect:/exemplaire/list";
	}
	
	@RequestMapping("/showformupdate")
	public String showUpdateForm(@ModelAttribute("codexp") String codexp,Model theModel) {
		// @ModelAttribute or @RequestParam both work fine
		System.out.println(">>ExemplaireController>>showupdateform : "+codexp);
		exemplaire exp = exemplaireService.getExemplaire(codexp);
		System.out.println(">>exemplaireController>>showformupdate :"+exp);
		theModel.addAttribute("exemplaire",exp);
		theModel.addAttribute("enter",2);
		return "exemplaire-form";
		
	}
	
	@RequestMapping("/delete")
	public String deleteExp(@RequestParam("codexp") String codexp) {
		exemplaire exp = exemplaireService.getExemplaire(codexp);
		System.out.println(">>exemplaireController>>delete :"+exp);
		exemplaireService.deleteExemplaire(exp);
		return "redirect:/exemplaire/list";

	}


}
