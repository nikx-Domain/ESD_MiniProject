package com.example.jpas.entity;

import jakarta.persistence.*;

import java.util.List;
import java.util.Set;

@Entity
public class domain {
    public domain(){

    }
    public domain( String program, String batch) {
        super();

        this.program = program;
        this.batch = batch;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getProgram() {
        return program;
    }

    public void setProgram(String program) {
        this.program = program;
    }

    public String getBatch() {
        return batch;
    }

    public void setBatch(String batch) {
        this.batch = batch;
    }
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private int id;
    @Column(nullable = false)
    private String program;
    @Column(nullable = false)
    private String batch;

    @OneToMany()
    @JoinColumn(name = "domian_id")
    private Set<student> students ;
    @ManyToMany(cascade = CascadeType.ALL)
    @JoinTable(name = "domain_course",
            joinColumns = @JoinColumn(name = "domain_id"),
            inverseJoinColumns = @JoinColumn(name = "course_id"))
    private List<course> courses;

}
