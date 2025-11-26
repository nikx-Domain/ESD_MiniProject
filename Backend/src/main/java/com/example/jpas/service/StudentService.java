package com.example.jpas.service;

import com.example.jpas.entity.student;
import com.example.jpas.repo.Studentrepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class StudentService {
    private final Studentrepo studentrepo;

    @Autowired
    public StudentService(Studentrepo studentrepo) {
        this.studentrepo = studentrepo;
    }

    public List<student> getStudentsByCourseId(Long courseId) {
        return studentrepo.findByCoursesId(courseId);
    }

    // Other methods...

}
