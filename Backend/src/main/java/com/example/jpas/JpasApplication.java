package com.example.jpas;

import com.example.jpas.config.GoogleOAuthProperties;
import com.example.jpas.config.JwtProperties;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.security.servlet.SecurityAutoConfiguration;
import org.springframework.boot.context.properties.EnableConfigurationProperties;

//entity
@SpringBootApplication(exclude = { SecurityAutoConfiguration.class })
@EnableConfigurationProperties({ GoogleOAuthProperties.class, JwtProperties.class })
public class JpasApplication {

    public static void main(String[] args) {
        SpringApplication.run(JpasApplication.class, args);
    }

}
