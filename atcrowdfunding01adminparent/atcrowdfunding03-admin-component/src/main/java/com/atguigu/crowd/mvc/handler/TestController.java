package com.atguigu.crowd.mvc.handler;

import com.atguigu.crowd.entity.Admin;
import com.atguigu.crowd.service.api.AdminService;
import com.atguigu.crowd.util.CrowdUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

@Controller
public class TestController {

    Logger logger = LoggerFactory.getLogger(TestController.class);

    @Autowired
    private AdminService adminService;

    @RequestMapping("/test/ssm")
    public String testSsm(ModelMap modelMap, HttpServletRequest httpServletRequest){
        boolean b = CrowdUtil.judgeRequestType(httpServletRequest);
        logger.info("是否为json请求："+b);
        List<Admin> adminList = adminService.getAll();
//        System.out.println(10/0);
        modelMap.addAttribute(adminList);
        return "target";
    }

    @ResponseBody
    @RequestMapping("/test/testJson")
    public String testJson(@RequestBody List<Integer> array,HttpServletRequest httpServletRequest) {
        boolean b = CrowdUtil.judgeRequestType(httpServletRequest);
        logger.info("是否为json请求："+b);
        for (Integer i : array) {
            logger.debug("array=" + i);
        }
        return "target";
    }
}
