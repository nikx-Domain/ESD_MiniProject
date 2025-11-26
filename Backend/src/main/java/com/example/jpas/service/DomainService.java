package com.example.jpas.service;


import com.example.jpas.entity.domain;
import com.example.jpas.repo.DomainRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class DomainService {
    private final DomainRepo DomainRepo;

    @Autowired
    public DomainService(DomainRepo DomainRepo) {
        this.DomainRepo = DomainRepo;
    }

    public List<domain> getAllEntities() {
        return DomainRepo.findAll();
    }
}
