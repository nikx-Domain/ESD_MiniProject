package com.example.jpas.service;


import com.example.jpas.dto.UserRequest;
import com.example.jpas.mapper.CustomerMapper;
import com.example.jpas.repo.CustomerRepo;
import jakarta.validation.Valid;
import com.example.jpas.entity.User;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class UserService {
    private final CustomerMapper customerMapper;
    private final CustomerRepo userRepo;
    private final EncryptionService encryptionService;

    public String createUser(UserRequest request) {
        User user = customerMapper.toCustomer(request);
        user.setPassword(encryptionService.encode(user.getPassword()));
        userRepo.save(user);
        return "User Created Successfully";
    }
}
