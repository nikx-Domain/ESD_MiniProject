package com.example.jpas.mapper;


import com.example.jpas.dto.UserRequest;
import com.example.jpas.entity.User;
import org.springframework.stereotype.Service;

@Service
public class CustomerMapper {
    public User toCustomer(UserRequest request) {
        return User.builder()
                .name(request.name())
                .email(request.email())
                .password(request.password())
                .role(request.role())
                .build();
    }
}
