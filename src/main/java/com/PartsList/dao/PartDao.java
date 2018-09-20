package com.PartsList.dao;

import com.PartsList.model.Part;

import java.util.List;

public interface PartDao {

    void addPart(Part part);
    void removePart(int partId);
    List<Part> getListOfParts();
    Part getPartFromDataBase(int partId);
    List<Part> getListOfSearchPart(String searchName);
    List<Part> getListOfPartPerUse(String filter);
    int getCountUseComputers();
    long getCustomersCount();
    List<Part> getPartsByPage(int pageNumber);

}
