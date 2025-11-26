package com.example.jpas.entity;

import jakarta.persistence.*;

@Entity

    public class Domain_course {
        public Domain_course(){
            super();
        }
        @Id
        @GeneratedValue (strategy = GenerationType.AUTO)
        private int id;

        @ManyToOne
        @JoinColumn(name = "domain_id")
        private com.example.jpas.entity.domain domain;

        @ManyToOne
        @JoinColumn(name = "course_id")
        private com.example.jpas.entity.course course;

    public course getCourse() {
        return course;
    }


    // Constructors, getters, and setters
    }


