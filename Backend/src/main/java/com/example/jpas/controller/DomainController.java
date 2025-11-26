package com.example.jpas.controller;

import com.example.jpas.entity.domain;
import com.example.jpas.service.DomainService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/api/v1")
//@RequiredArgsConstructor
@CrossOrigin(origins = "http://localhost:3000/")
public class DomainController {
    private final DomainService domainservice;

    @Autowired
    public DomainController(DomainService domainservice) {
        this.domainservice = domainservice;
    }

    @GetMapping("/domain")
    public ResponseEntity<List<domain>> getAllEntities() {
        List<domain> entities = domainservice.getAllEntities();
        return new ResponseEntity<>(entities, HttpStatus.OK);
    }
}