package com.example.jpas.controller;

import com.example.jpas.service.StudentService;
import com.example.jpas.entity.student;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

// StudentController.java
@CrossOrigin(origins = "http://localhost:3000/")

@RestController
@RequestMapping("/api/courses")
public class StudentController {
    private final StudentService studentService;

    @Autowired
    public StudentController(StudentService studentService) {
        this.studentService = studentService;
    }

    @GetMapping("/{courseId}/students")
    public ResponseEntity<List<student>> getStudentsByCourseId(@PathVariable Long courseId) {
        List<student> students = studentService.getStudentsByCourseId(courseId);
        return ResponseEntity.ok(students);
    }
}
