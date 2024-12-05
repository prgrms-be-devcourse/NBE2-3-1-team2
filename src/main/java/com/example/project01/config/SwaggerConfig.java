package com.example.project01.config;

import io.swagger.v3.oas.models.Components;
import io.swagger.v3.oas.models.OpenAPI;
import io.swagger.v3.oas.models.info.Info;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class SwaggerConfig {
    private Info info() {
        return new Info()
                .title("Coffee API Documentation")
                .version("0.1")
                .description("API Documentation");
    }

    @Bean
    public OpenAPI coffeeOpenAPI() {
        return new OpenAPI()
                .components(new Components())
                .info(info());
    }
}