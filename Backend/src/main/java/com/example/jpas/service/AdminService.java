package com.example.jpas.service;

import com.example.jpas.dto.GoogleLoginRequest;
import com.example.jpas.dto.LoginResponse;
import com.example.jpas.entity.User;
import com.example.jpas.repo.CustomerRepo;
import com.google.api.client.googleapis.auth.oauth2.GoogleIdToken;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class AdminService {

    private final CustomerRepo customerRepo;
    private final GoogleOAuthService googleOAuthService;

    public LoginResponse login(GoogleLoginRequest request) {
        GoogleIdToken.Payload payload = googleOAuthService.verify(request.credential());
        User user = getOrCreateUser(payload);

        return new LoginResponse(
                user.getUser_id(),
                user.getEmail(),
                user.getRole(),
                user.getName(),
                payload.get("picture") != null ? payload.get("picture").toString() : null);
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
