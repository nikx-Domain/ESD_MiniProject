package com.example.jpas.entity;

import jakarta.persistence.*;

@Entity
public class faculty {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private int id;
    @Column(nullable = false)
    private String f_name;
    @Column(nullable = false,unique = true)
    private String f_email;

    public faculty() {
        super();
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getF_name() {
        return f_name;
    }

    public void setF_name(String f_name) {
        this.f_name = f_name;
    }

    public String getF_email() {
        return f_email;
    }

    public void setF_email(String f_email) {
        this.f_email = f_email;
    }

    public faculty( String f_name, String f_email) {

        this.f_name = f_name;
        this.f_email = f_email;
    }
    @OneToOne(mappedBy = "faculty")
    private com.example.jpas.entity.course course;
}
