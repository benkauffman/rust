package com.example;

import io.micrometer.core.instrument.MeterRegistry;
import java.util.Collections;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.actuate.autoconfigure.metrics.MeterRegistryCustomizer;
import org.springframework.context.annotation.Bean;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@SpringBootApplication
public class Application {

    public static void main(String[] args) {
        SpringApplication.run(Application.class, args);
    }

    @Bean
    public MeterRegistryCustomizer<MeterRegistry> metricsCommonTags() {
        return registry -> registry.config()
                .commonTags("project_name", "java_hello_world", "project_type", "test_metrics_labels");
    }

    @RestController
    public class HelloController {

        @GetMapping("/")
        public String hello() {
            return "Hello, World!";
        }

        @GetMapping("/_health")
        public String health() {
            return "Healthy!";
        }
    }
}
