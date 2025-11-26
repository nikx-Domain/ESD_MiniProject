package com.example.jpas.service;
import com.example.jpas.entity.course;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.example.jpas.repo.DomainIdRepo;
import com.example.jpas.entity.Domain_course;
import java.util.List;
import java.util.stream.Collectors;

@Service
public class DomainIdService {
    private final DomainIdRepo DomainIdRepo;

    @Autowired
    public DomainIdService(DomainIdRepo DomainIdRepo) {
        this.DomainIdRepo = DomainIdRepo;
    }

    public List<course> getCoursesByDomainId(int domainId) {
        List<Domain_course> domainCourses = DomainIdRepo.findByDomainId(domainId);
        return domainCourses.stream().map(Domain_course::getCourse).collect(Collectors.toList());
    }
}

