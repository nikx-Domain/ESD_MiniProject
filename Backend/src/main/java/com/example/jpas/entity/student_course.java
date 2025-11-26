package com.example.jpas.entity;


import jakarta.persistence.*;

@Entity

    public class student_course {
        @Id
        @GeneratedValue(strategy = GenerationType.AUTO)
        private int id;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    @ManyToOne
        @JoinColumn(name = "student_id")
        private com.example.jpas.entity.student student;

        @ManyToOne
        @JoinColumn(name = "course_id")
        private com.example.jpas.entity.course course;

        // Constructors, getters, and setters
    }


