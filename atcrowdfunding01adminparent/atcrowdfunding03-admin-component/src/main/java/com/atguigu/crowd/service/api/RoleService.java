package com.atguigu.crowd.service.api;


import com.atguigu.crowd.entity.Role;
import com.github.pagehelper.PageInfo;

import java.util.List;

/**
 * role操作接口
 * @author binjiewang
 */
public interface RoleService {
    void saveRole(Role role);

    PageInfo<Role> getRolePage(String keyword, Integer pageNum, Integer pageSize);

    void updateRole(Role role);

    public void removeRole(List<Integer> roleIdList);
}
