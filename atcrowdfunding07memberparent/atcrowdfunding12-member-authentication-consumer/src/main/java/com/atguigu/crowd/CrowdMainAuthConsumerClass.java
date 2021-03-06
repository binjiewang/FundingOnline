package com.atguigu.crowd;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.client.discovery.EnableDiscoveryClient;

@EnableDiscoveryClient // 当前版本可以不写
@SpringBootApplication
public class CrowdMainAuthConsumerClass {
    public static void main(String[] args) {
        SpringApplication.run(CrowdMainAuthConsumerClass.class,args);
    }
}
