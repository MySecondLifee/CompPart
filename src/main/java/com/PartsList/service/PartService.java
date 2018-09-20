package com.PartsList.service;

import com.PartsList.model.Part;

import java.util.List;

public interface PartService {

    void addPart(Part part);
    void removePart(int partId);
   // List<Part> getListOfParts();
    Part getPartFromDataBase(int partId);
    List<Part> getListOfSearchPart(String searchName);
    List<Part> getListOfPartPerUse(String filter);
    int getCountUseComputers();
    long getPartCount();
    List<Part> getPartsByPage(int pageNumber);
}
