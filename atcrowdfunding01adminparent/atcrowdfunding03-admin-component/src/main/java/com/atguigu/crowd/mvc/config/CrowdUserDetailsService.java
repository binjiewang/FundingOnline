package com.atguigu.crowd.mvc.config;

import com.atguigu.crowd.entity.Admin;
import com.atguigu.crowd.entity.Role;
import com.atguigu.crowd.service.api.AdminService;
import com.atguigu.crowd.service.api.AuthService;
import com.atguigu.crowd.service.api.RoleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.List;

@Component
public class CrowdUserDetailsService implements UserDetailsService {
    @Autowired
    private AdminService adminService;
    @Autowired
    private RoleService roleService;
    @Autowired
    private AuthService authService;

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        //根据username查找admin
        Admin admin = adminService.getAdminByLoginAcct(username);
        Integer adminId = admin.getId();

        //根据adminId查找用户所拥有的role
        List<Role> assignedRoles = roleService.getAssignedRole(adminId);

        //根据adminId查找用户所拥有的auth
        List<String> assignedAuthNames = authService.getAssignedAuthNameByAdminId(adminId);

        List<GrantedAuthority> grantedAuthorities = new ArrayList<>();
        for (Role assignedRole : assignedRoles) {
            String roleName = "ROLE_"+assignedRole.getName();
            grantedAuthorities.add(new SimpleGrantedAuthority(roleName));
        }

        for (String assignedAuthName : assignedAuthNames) {
            grantedAuthorities.add(new SimpleGrantedAuthority(assignedAuthName));
        }

        SecurityAdmin securityAdmin = new SecurityAdmin(admin, grantedAuthorities);
        return securityAdmin;
    }
}
