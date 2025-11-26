package com.example.jpas.repo;


import org.springframework.data.jpa.repository.JpaRepository;
import com.example.jpas.entity.User;
import java.util.Optional;

public interface CustomerRepo extends JpaRepository<User,Long> {
    Optional<User> findByEmail(String email);
}
