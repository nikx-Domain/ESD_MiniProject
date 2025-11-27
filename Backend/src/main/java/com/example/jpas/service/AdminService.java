package com.example.jpas.service;

import com.example.jpas.dto.GoogleLoginRequest;
import com.example.jpas.dto.LoginResponse;
import com.example.jpas.dto.TraditionalLoginRequest;
import com.example.jpas.entity.User;
import com.example.jpas.repo.CustomerRepo;
import com.google.api.client.googleapis.auth.oauth2.GoogleIdToken;
import lombok.RequiredArgsConstructor;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class AdminService {

    private final CustomerRepo customerRepo;
    private final GoogleOAuthService googleOAuthService;
    private final JwtUtil jwtUtil;
    private final PasswordEncoder passwordEncoder;

    public LoginResponse login(GoogleLoginRequest request) {
        // Step 1: Verify Google OAuth token
        GoogleIdToken.Payload payload = googleOAuthService.verify(request.credential());

        // Step 2: Get or create user
        User user = getOrCreateUser(payload);

        // Step 3: Generate custom JWT token
        String jwtToken = jwtUtil.generateToken(user);

        // Step 4: Return response with JWT token
        return new LoginResponse(
                user.getUser_id(),
                user.getEmail(),
                user.getRole(),
                user.getName(),
                payload.get("picture") != null ? payload.get("picture").toString() : null,
                jwtToken);
    }

    public LoginResponse loginWithPassword(TraditionalLoginRequest request) {
        // Step 1: Find user by email
        User user = customerRepo.findByEmail(request.email())
                .orElseThrow(() -> new IllegalArgumentException("Invalid email or password"));

        // Step 2: Verify password
        if (!passwordEncoder.matches(request.password(), user.getPassword())) {
            throw new IllegalArgumentException("Invalid email or password");
        }

        // Step 3: Generate JWT token
        String jwtToken = jwtUtil.generateToken(user);

        // Step 4: Return response with JWT token
        return new LoginResponse(
                user.getUser_id(),
                user.getEmail(),
                user.getRole(),
                user.getName(),
                null, // No picture for traditional login
                jwtToken);
    }

    private User getOrCreateUser(GoogleIdToken.Payload payload) {
        String email = payload.getEmail();
        return customerRepo.findByEmail(email)
                .orElseGet(() -> {
                    User newUser = User.builder()
                            .email(email)
                            .name((String) payload.get("name"))
                            .password("oauth_user") // Dummy password for OAuth users
                            .role("Student") // Default role
                            .build();
                    return customerRepo.save(newUser);
                });
    }
}
