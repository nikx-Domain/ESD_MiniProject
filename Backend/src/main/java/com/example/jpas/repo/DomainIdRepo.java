package com.example.jpas.repo;

import com.example.jpas.entity.Domain_course;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface DomainIdRepo extends JpaRepository<Domain_course,Integer> {
    List<Domain_course> findByDomainId(int domain_id);
}
