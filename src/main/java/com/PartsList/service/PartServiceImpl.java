package com.PartsList.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.PartsList.dao.PartDao;
import com.PartsList.model.Part;

import java.util.List;

@Service
@Transactional
public class PartServiceImpl implements PartService {

    @Autowired
    private PartDao partDao;

    @Override
    public void addPart(Part part) {
        partDao.addPart(part);
    }

    @Override
    public void removePart(int partId) {
        partDao.removePart(partId);
    }

   /* @Override
    public List<Part> getListOfParts() {
        return partDao.getListOfParts();
    }*/

    @Override
    public Part getPartFromDataBase(int partId) {
        return partDao.getPartFromDataBase(partId);
    }

    @Override
    public List<Part> getListOfSearchPart(String searchName) {
        return partDao.getListOfSearchPart(searchName);
    }

    @Override
    public List<Part> getListOfPartPerUse(String filter) {
        return partDao.getListOfPartPerUse(filter);
    }

    @Override
    public int getCountUseComputers() {
        return partDao.getCountUseComputers();
    }

    @Override
    public long getPartCount() {
        return partDao.getCustomersCount();
    }

    @Override
    public List<Part> getPartsByPage(int pageNumber) {
        return partDao.getPartsByPage(pageNumber);
    }
}
