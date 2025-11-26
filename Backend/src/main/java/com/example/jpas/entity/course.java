package com.example.jpas.entity;

import jakarta.persistence.*;
import org.springframework.data.annotation.Id;

import java.util.List;

@Entity
public class course {
    @jakarta.persistence.Id
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long id;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public course(){
      super();
    }
    public course( int credit, String name, String c_code) {
        super();

        this.credit = credit;
        this.name = name;
        this.c_code = c_code;
    }



    public int getCredit() {
        return credit;
    }

    public void setCredit(int credit) {
        this.credit = credit;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getC_code() {
        return c_code;
    }

    public void setC_code(String c_code) {
        this.c_code = c_code;
    }
     @Column(nullable = false)
    private int credit;
    @Column(nullable = false)
    private String name;
    @Column(nullable = false,unique = true)
    private String c_code;


    @OneToOne
    @JoinColumn(name = "faculty_id")
    private com.example.jpas.entity.faculty faculty;
    @ManyToMany(mappedBy = "courses")
    private List<domain> domains;
    @OneToOne(mappedBy = "course")
    private com.example.jpas.entity.schedule schedule;
    @ManyToMany(mappedBy = "courses")
    private List<student> students;


    public faculty getFaculty() {
        return faculty;
    }
    public schedule getSchedule() {
        return schedule;
    }
    public List<student> getStudents() {
        return students;
    }
}
