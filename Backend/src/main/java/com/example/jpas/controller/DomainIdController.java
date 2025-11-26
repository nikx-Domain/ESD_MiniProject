package com.example.jpas.controller;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;

import com.example.jpas.service.DomainIdService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.*;
import com.example.jpas.entity.course;

import java.util.List;

@RestController
@RequestMapping("/api/v1")
@CrossOrigin(origins = "http://localhost:3000/")
public class DomainIdController {
    private final DomainIdService domainIdService;

    @Autowired
    public DomainIdController(DomainIdService domainIdService) {
        this.domainIdService = domainIdService;
    }

    @GetMapping("/byDomain/{domainId}")
    public ResponseEntity<List<course>> getCoursesByDomain(@PathVariable("domainId") int domainId) {
        List<course> courses = domainIdService.getCoursesByDomainId(domainId);
        return new ResponseEntity<>(courses, HttpStatus.OK);
    }
}

