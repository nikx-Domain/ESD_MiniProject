package com.example.jpas.service;

import com.example.jpas.config.GoogleOAuthProperties;
import com.google.api.client.googleapis.auth.oauth2.GoogleIdToken;
import com.google.api.client.googleapis.auth.oauth2.GoogleIdToken.Payload;
import com.google.api.client.googleapis.auth.oauth2.GoogleIdTokenVerifier;
import com.google.api.client.googleapis.javanet.GoogleNetHttpTransport;
import com.google.api.client.json.jackson2.JacksonFactory;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import java.io.IOException;
import java.security.GeneralSecurityException;
import java.util.Collections;

@Service
public class GoogleOAuthService {

    private final GoogleIdTokenVerifier verifier;

    public GoogleOAuthService(GoogleOAuthProperties properties) throws GeneralSecurityException, IOException {
        if (!StringUtils.hasText(properties.clientId())) {
            // Allow application context to start (e.g. tests) even if not configured.
            this.verifier = null;
        } else {
            this.verifier = new GoogleIdTokenVerifier.Builder(
                    GoogleNetHttpTransport.newTrustedTransport(),
                    JacksonFactory.getDefaultInstance())
                    .setAudience(Collections.singletonList(properties.clientId()))
                    .build();
        }
    }

    public Payload verify(String credential) {
        if (!StringUtils.hasText(credential)) {
            throw new IllegalArgumentException("Google credential cannot be empty");
        }

        try {
            if (verifier == null) {
                throw new IllegalStateException("Missing google.oauth.client-id configuration");
            }

            GoogleIdToken token = verifier.verify(credential);
            if (token == null) {
                throw new IllegalArgumentException("Invalid Google ID token");
            }
            return token.getPayload();
        } catch (GeneralSecurityException | IOException e) {
            throw new IllegalStateException("Unable to verify Google token", e);
        }
    }
}

