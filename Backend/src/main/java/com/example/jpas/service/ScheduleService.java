package com.example.jpas.service;

// ScheduleService.java
import com.example.jpas.repo.ScheduleRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.example.jpas.entity.schedule;
import java.util.Optional;

@Service
public class ScheduleService {

    private final ScheduleRepo schedulerepo;

    @Autowired
    public ScheduleService(ScheduleRepo schedulerepo) {
        this.schedulerepo= schedulerepo;
    }

    public Long getScheduleIdByCourseId(Long courseId) {
        Optional<schedule> scheduleOptional = schedulerepo.findByCourseId(courseId);
        return scheduleOptional.map(schedule::getId).orElse(null);
    }

    // Other methods for CRUD operations...

}
