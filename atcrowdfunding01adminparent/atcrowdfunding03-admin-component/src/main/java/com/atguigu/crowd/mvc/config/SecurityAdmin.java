package com.atguigu.crowd.mvc.config;

import com.atguigu.crowd.entity.Admin;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.User;

import java.util.List;

/**
 * 加密角色，包含原始用户信息和权限信息
 * @author binjiewang
 */
public class SecurityAdmin extends User {

    private Admin originalAdmin;

    public SecurityAdmin(Admin originalAdmin, List<GrantedAuthority> authorities){
        super(originalAdmin.getUserName(),originalAdmin.getUserPswd(),authorities);
        this.originalAdmin=originalAdmin;

        //框架只擦出了父类User中的password,自定义的类需要手动擦除
        originalAdmin.setUserPswd(null);
    }

    public Admin getOriginalAdmin() {
        return originalAdmin;
    }

    public void setOriginalAdmin(Admin originalAdmin) {
        this.originalAdmin = originalAdmin;
    }
}
