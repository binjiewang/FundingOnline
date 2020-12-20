package com.atguigu.crowd.service.api;

import com.atguigu.crowd.entity.Menu;

import java.util.List;

/**
 * @author binjiewang
 */
public interface MenuService {
    /**
     * 获取所有菜单
     * @return
     */
    List<Menu> getAll();
}
