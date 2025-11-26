package com.example.jpas.repo;

import com.example.jpas.entity.course;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface CourseRepo extends JpaRepository<course,Long> {

    Optional<course> findById(Long id);

}
