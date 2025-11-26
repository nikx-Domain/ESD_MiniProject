package com.example.jpas.controller;
import com.example.jpas.entity.faculty;
import com.example.jpas.entity.schedule;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.*;
import com.example.jpas.entity.course;
import com.example.jpas.service.CourseService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;
@CrossOrigin(origins = "http://localhost:3000/")
@RestController
@RequestMapping("/api/v1")
public class CourseController {
    private final CourseService courseService;

    @Autowired
    public CourseController(CourseService courseService) {
        this.courseService = courseService;
    }

    @GetMapping("/courses")
    public ResponseEntity<List<course>> getAllCourses() {
        List<course> courses = courseService.getAllCourses();
        return new ResponseEntity<>(courses, HttpStatus.OK);
    }
    @GetMapping("/{courseId}/faculty")
    public ResponseEntity<faculty> getFacultyByCourseId(@PathVariable Long courseId) {
        faculty faculty = courseService.getFacultyByCourseId(courseId);

        if (faculty != null) {
            return new ResponseEntity<>(faculty, HttpStatus.OK);
        } else {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }
    }
    @GetMapping("/schedule/{courseId}")
    public ResponseEntity<schedule> getScheduleByCourseId(@PathVariable Long courseId) {
        schedule schedule = courseService.getScheduleByCourseId(courseId);

        if (schedule != null) {
            return new ResponseEntity<>(schedule, HttpStatus.OK);
        } else {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }
    }




}
