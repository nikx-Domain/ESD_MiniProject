package com.example.jpas.repo;

import com.example.jpas.entity.student;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface Studentrepo extends JpaRepository<student,Integer> {
    List<student> findByCoursesId(Long courseId);
}
