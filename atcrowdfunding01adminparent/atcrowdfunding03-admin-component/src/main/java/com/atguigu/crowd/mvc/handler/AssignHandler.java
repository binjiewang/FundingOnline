package com.atguigu.crowd.mvc.handler;

import com.atguigu.crowd.entity.Role;
import com.atguigu.crowd.service.api.AdminService;
import com.atguigu.crowd.service.api.RoleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@Controller
public class AssignHandler {

    @Autowired
    private RoleService roleService;
    @Autowired
    private AdminService adminService;

    @RequestMapping("/assign/to/assign/role/page.html")
    public String toAssignRolePage(@RequestParam("adminId")Integer adminId, ModelMap modelMap){
        List<Role> assignedRoleList =  roleService.getAssignedRole(adminId);
        List<Role> unAssignedRoleList =  roleService.getUnAssignedRole(adminId);
        modelMap.addAttribute("assignedRoleList",assignedRoleList);
        modelMap.addAttribute("unAssignedRoleList",unAssignedRoleList);
        return "assign-role";
    }

    @RequestMapping("/assign/do/role/assign.html")
    public String  saveAdminRoleRelationship(
            @RequestParam("adminId")Integer adminId,
            @RequestParam("pageNum")Integer pageNum,
            @RequestParam("keyword")Integer keyword,
            @RequestParam(value = "roleIdList",required = false)List<Integer> roleIdList){

        adminService.saveAdminRoleRelationship(adminId,roleIdList);

        return "redirect:/admin/get/page.html?pageNum="+pageNum+"&keyword="+keyword;
    }
}
