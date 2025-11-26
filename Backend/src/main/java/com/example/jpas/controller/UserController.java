package com.example.jpas.controller;

import com.example.jpas.dto.UserRequest;
import com.example.jpas.service.UserService;
import com.example.jpas.service.AdminService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("api/v1/user")

@RequiredArgsConstructor
public class UserController {
    private final UserService userservice;
    @PostMapping
    public ResponseEntity<String> createCustomer(@RequestBody @Valid UserRequest request) {
        return ResponseEntity.ok(userservice.createUser(request));
    }
}
