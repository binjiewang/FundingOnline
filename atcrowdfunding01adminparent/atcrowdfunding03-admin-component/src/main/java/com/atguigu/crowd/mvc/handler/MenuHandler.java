package com.atguigu.crowd.mvc.handler;

import com.atguigu.crowd.entity.Menu;
import com.atguigu.crowd.service.api.MenuService;
import com.atguigu.crowd.util.ResultEntity;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 菜单controller
 * @author binjiewang
 */
@Controller
public class MenuHandler {
    @Autowired
    private MenuService menuService;

    @ResponseBody
    @RequestMapping("/menu/get/whole/tree.json")
    public ResultEntity<Menu> getWholeTreeNew(){
        List<Menu> menuList = menuService.getAll();

        Menu root = null;
        Map<Integer, Menu> menuMap = new HashMap<>(16);

        //将所有对象添加到menuMap，减少时间复杂度
        for (Menu menu: menuList) {
            menuMap.put(menu.getId(),menu);
        }
        
        for (Menu menu : menuList) {
            Integer pid = menu.getPid();
            if(pid == null){
                root = menu;
                continue;
            }

            //如果不为空，就将该菜单加入到它的父节点
            Menu parentMenu = menuMap.get(pid);
            parentMenu.getChildren().add(menu);
        }

        return ResultEntity.successWithData(root);
    }
}
