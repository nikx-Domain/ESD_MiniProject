package com.example.jpas.controller;

// ScheduleController.java

import com.example.jpas.service.ScheduleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/v1")
public class ScheduleController {

    private final ScheduleService scheduleService;

    @Autowired
    public ScheduleController(ScheduleService scheduleService) {
        this.scheduleService = scheduleService;
    }

    @GetMapping("/{courseId}/schedule")
    public ResponseEntity<Long> getScheduleIdByCourseId(@PathVariable Long courseId) {
        Long scheduleId = scheduleService.getScheduleIdByCourseId(courseId);


            return new ResponseEntity<>(scheduleId, HttpStatus.OK);

    }

    // Other endpoints for CRUD operations...

}
