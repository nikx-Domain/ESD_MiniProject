package com.example.jpas.service;
import com.example.jpas.entity.course;
import com.example.jpas.entity.faculty;
import com.example.jpas.entity.schedule;
import com.example.jpas.repo.CourseRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class CourseService {
    private final CourseRepo courserepo;


    @Autowired
    public CourseService(CourseRepo courserepo) {
        this.courserepo = courserepo;

    }

    public List<course> getAllCourses() {
        return courserepo.findAll();
    }
    public faculty getFacultyByCourseId(Long courseId) {
        Optional<course> courseOptional = courserepo.findById(courseId);

        return courseOptional.map(course -> course.getFaculty()).orElse(null);
    }
    public schedule getScheduleByCourseId(Long courseId) {
        Optional<course> courseOptional = courserepo.findById(courseId);

        return courseOptional.map(course::getSchedule).orElse(null);
    }




}
