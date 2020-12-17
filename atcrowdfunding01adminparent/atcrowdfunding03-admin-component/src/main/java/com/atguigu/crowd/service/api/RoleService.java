package com.atguigu.crowd.service.api;


import com.atguigu.crowd.entity.Role;
import com.github.pagehelper.PageInfo;

public interface RoleService {
    void saveRole(Role role);

    PageInfo<Role> getRolePage(String keyword, Integer pageNum, Integer pageSize);

    void updateRole(Role role);
}
