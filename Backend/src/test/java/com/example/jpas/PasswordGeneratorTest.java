package com.example.jpas;

import com.example.jpas.service.EncryptionService;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

@SpringBootTest
public class PasswordGeneratorTest {

    @Autowired
    private EncryptionService encryptionService;

    @Test
    public void generatePassword() {
        String hash = encryptionService.encode("admin123");
        System.out.println("BCrypt Hash: " + hash);
    }
}
