package com.PartsList.dao;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import com.PartsList.model.Part;

import java.util.Comparator;
import java.util.List;

@Repository
public class PartDaoImpl implements PartDao {

    @Autowired
    private SessionFactory factory;

    private int pageSize = 10;



    @Override
    public void addPart(Part part) {
        Session session = factory.getCurrentSession();
        session.saveOrUpdate(part);
    }

    @Override
    public void removePart(int partId) {
        Session session = factory.getCurrentSession();
        Part part = session.get(Part.class, partId);
        session.delete(part);
    }

    @Override
    public List<Part> getListOfParts() {
        Session session = factory.getCurrentSession();
        List<Part> list = session.createQuery("from com.PartsList.model.Part", Part.class).getResultList();
        return list;
    }
    @Override
    public Part getPartFromDataBase(int partId) {
        Session session = factory.getCurrentSession();
        Part part = session.get(Part.class, partId);
        return part;
    }

    @Override
    public List<Part> getListOfSearchPart(String searchName) {
        Session session = factory.getCurrentSession();
        Query<Part> query;
        if (searchName != null && searchName.trim().length() > 0) {
            query = session.createQuery("from com.PartsList.model.Part where lower(namePart) like :name", Part.class);
            query.setParameter("name", "%" + searchName.toLowerCase() + "%");

            System.out.println(query.toString());
        } else {
            query = session.createQuery("from com.PartsList.model.Part", Part.class);
        }

        List<Part> list = query.getResultList();

        return list;
    }

    @Override
    public List<Part> getListOfPartPerUse(String filter) {
        Session session = factory.getCurrentSession();
        List<Part> list;
        Query<Part> query;
        if (filter.equals("use")) {
            query = session.createQuery("from com.PartsList.model.Part where isBuild=:use",Part.class);
            query.setParameter("use", '1');
            list = query.getResultList();
        } else {
            query = session.createQuery("from com.PartsList.model.Part where isBuild is null", Part.class);
            list = query.getResultList();
        }
        return list;
    }

    public int getCountUseComputers() {
        List<Part> list = getListOfPartPerUse("use");
        Part part = list.stream().min(Comparator.comparing(Part::getQuantity)).get();
        return part.getQuantity();
    }

    @Override
    public long getCustomersCount() {
        Session session = factory.getCurrentSession();
        Query<Long> query = session.createQuery("select count(*) from com.PartsList.model.Part", Long.class);
        long count = query.getSingleResult();
        return count;
    }

    @Override
    public List<Part> getPartsByPage(int pageNumber) {
        Session currentSession = factory.getCurrentSession();

        Query<Part> query = currentSession.createQuery("From com.PartsList.model.Part", Part.class);
        query.setFirstResult((pageNumber-1) * pageSize);
        query.setMaxResults(pageSize);

        List<Part> list = query.getResultList();

        return list;
    }
}
