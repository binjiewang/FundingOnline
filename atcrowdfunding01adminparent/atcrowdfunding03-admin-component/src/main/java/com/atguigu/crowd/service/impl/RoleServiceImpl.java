package com.atguigu.crowd.service.impl;

import com.atguigu.crowd.entity.Role;
import com.atguigu.crowd.mapper.RoleMapper;
import com.atguigu.crowd.service.api.RoleService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class RoleServiceImpl implements RoleService {
    @Autowired
    private RoleMapper roleMapper;

    @Override
    public void saveRole(Role role) {
        roleMapper.insert(role);
    }

    @Override
    public PageInfo<Role> getRolePage(String keyword, Integer pageNum, Integer pageSize) {
        PageHelper.startPage(pageNum, pageSize);

        List<Role> roleList = roleMapper.selectRoleListByKeyword(keyword);

        PageInfo<Role> pageInfo = new PageInfo<>(roleList);

        return pageInfo;
    }
}
