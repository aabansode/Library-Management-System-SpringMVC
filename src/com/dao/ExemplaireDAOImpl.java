package com.dao;

import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.models.Emprunt;
import com.models.exemplaire;


@Repository
public class ExemplaireDAOImpl implements ExemplaireDAO{
	
	@Autowired
	SessionFactory sessionFactory;

	@Override
	public void saveExemplaire(exemplaire exp) {
		System.out.println(">>ExemplaireDAOImpl>>saveExemplaire : "+exp);
		Session currentSession=sessionFactory.getCurrentSession();
		currentSession.saveOrUpdate(exp);
		
	}

	@Override
	public exemplaire getExemplaire(String codexp) {
		Session currentSession=sessionFactory.getCurrentSession();
		return currentSession.get(exemplaire.class,codexp);
	}


	@Override
	public List<exemplaire> getExemplaires() {
		Session currentSession=sessionFactory.getCurrentSession();
		Query<exemplaire> theQuery=currentSession.createQuery("from exemplaire", exemplaire.class);
		List<exemplaire> lexemp= theQuery.getResultList();
		return lexemp;
	}

	@Override
	public void deleteExemplaire(exemplaire exp) {
		Session currentSession=sessionFactory.getCurrentSession();
		//Query<Emprunt> theQuery=currentSession.createQuery("from emprunt e where e.codexp=codexp1", Emprunt.class).setParameter("codexp1", exp.getCodexp());
		//Query<Emprunt> theQuery=currentSession.createQuery("from emprunt", Emprunt.class);
		//List<Emprunt> theEmprunts= theQuery.getResultList();
		//List<Emprunt> theEmprunts=currentSession.createQuery("from emprunt e where e.codexp=codexp1").setParameter("codexp1",exp.getCodexp()).list();
		//System.out.println("Emprunts "+theEmprunts);
		currentSession.delete(exp);
		
	}

}
