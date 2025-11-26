package com.example.jpas.repo;

import com.example.jpas.entity.schedule;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface ScheduleRepo extends JpaRepository<schedule,Integer> {
    Optional<schedule> findByCourseId(Long courseId);

}
