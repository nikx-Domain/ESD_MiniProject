package com.example.jpas.repo;

import com.example.jpas.entity.faculty;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface FacultyRepo extends JpaRepository<faculty,Integer> {
    Optional<faculty> findById(int id);
}
