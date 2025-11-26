package com.example.jpas;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.security.servlet.SecurityAutoConfiguration;

//entity
@SpringBootApplication(exclude = {SecurityAutoConfiguration.class})
public class JpasApplication {

    public static void main(String[] args) {
        SpringApplication.run(JpasApplication.class, args);
    }

}
