package com.atguigu.crowd.handler;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class PortalHandler {

    @RequestMapping("/")
    public String showPortalPage() {
        // 实际开发为加载数据，加载数据省略
        return "portal";
    }
}
