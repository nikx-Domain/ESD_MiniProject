package com.example.jpas.entity;

import jakarta.persistence.*;

@Entity
public class schedule {
    public schedule() {

    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public schedule( String time, String day, String room) {

        this.time = time;
        this.day = day;
        this.room = room;
    }
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long id;
    @Column(nullable = false)
    private String time;
    @Column(nullable = false)
    private String day;
    @Column(nullable = false)
    private String room;

    public String getTime() {
        return time;
    }

    public void setTime(String time) {
        this.time = time;
    }

    public String getDay() {
        return day;
    }

    public void setDay(String day) {
        this.day = day;
    }

    public String getRoom() {
        return room;
    }

    public void setRoom(String room) {
        this.room = room;
    }
    @OneToOne
    @JoinColumn(name = "course_id")
    private com.example.jpas.entity.course course;


}
