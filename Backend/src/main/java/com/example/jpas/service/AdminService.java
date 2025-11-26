package com.example.jpas.service;

import com.example.jpas.dto.LoginRequest;
import com.example.jpas.entity.User;
import com.example.jpas.helper.JWTHelper;
import com.example.jpas.dto.LoginResponse;
import com.example.jpas.repo.CustomerRepo;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class AdminService {

    private final CustomerRepo customerRepo;
    private final EncryptionService encryptionService;
    private final JWTHelper jwtHelper;


    public LoginResponse login(LoginRequest request) {
        User user = getUser(request.email());
        if (user == null) {
            throw new IllegalArgumentException("User not found");
        }

        if (!user.getRole().equals("Admin")) {
            throw new IllegalArgumentException("Only Admin can Login");
        }

        if (!encryptionService.validates(request.password(), user.getPassword())) {
            throw new IllegalArgumentException("Wrong Password or Email");
        }
        String token = jwtHelper.generateToken(request.email());
        return new LoginResponse(user.getUser_id(), user.getEmail(), user.getRole(), user.getName(),token);
    }

    private User getUser( String email) {
        return customerRepo.findByEmail(email)
                .orElseThrow();
    }
}