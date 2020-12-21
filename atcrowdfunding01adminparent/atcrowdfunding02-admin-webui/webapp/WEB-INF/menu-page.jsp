<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="zh-CN">
<%@include file="/WEB-INF/include-head.jsp" %>
<link rel="stylesheet" href="ztree/zTreeStyle.css"/>
<script type="text/javascript" src="ztree/jquery.ztree.all-3.5.min.js"></script>
<script type="text/javascript" src="crowd/my-menu.js"></script>
<script type="text/javascript">
    $(function () {

        generatorZTree();

        //添加角色弹窗
        $("#treeDemo").on("click", ".addBtn", function () {
            $("#menuAddModal").modal("show");
            window.pid = this.id;
            return false;
        });

        //修改角色弹窗
        $("#treeDemo").on("click", ".editBtn", function () {
            $("#menuEditModal").modal("show");
            window.id = this.id;
            var zTreeObj = $.fn.zTree.getZTreeObj("treeDemo");

            debugger;
            //回显数据
            var key="id";
            var currentNode = zTreeObj.getNodeByParam(key, window.id);

            $("#menuEditModal [name=name]").val(currentNode.name);
            $("#menuEditModal [name=url]").val(currentNode.url);
            $("#menuEditModal [name=icon]").val([currentNode.icon]);

            return false;
        });

        //删除角色弹窗
        $("#treeDemo").on("click", ".removeBtn", function () {
            window.id = this.id;
            var zTreeObj = $.fn.zTree.getZTreeObj("treeDemo");
            var key="id";
            var currentNode = zTreeObj.getNodeByParam(key, window.id);

            $("#removeNodeSpan").html(" 【<li class='"+currentNode.icon+"'>"+currentNode.name+"</li>】 ");
            $("#menuConfirmModal").modal("show");
            return false;
        });


        //添加
        $("#menuSaveBtn").click(function () {
            debugger;
            var pid = window.pid;
            var name = $.trim($("#menuAddModal [name=name]").val());
            var url = $.trim($("#menuAddModal [name=url]").val());
            var icon = $("#menuAddModal [name=icon]:checked").val();

            if (name == "" || url == "" || icon == "" || icon == undefined) {
                layer.msg("名称、地址或图标不可为空!!!")
                return;
            }

            $.ajax({
                url: "menu/save.json",
                type: "post",
                data: {
                    pid: pid,
                    name: name,
                    url: url,
                    icon: icon
                },
                dataType: "json",
                success: function (response) {
                    var result = response.result;
                    if (result == "SUCCESS") {
                        layer.msg("操作成功");
                        generatorZTree();
                    }

                    if (result == "FAILED") {
                        layer.msg("操作失败！" + response.message);
                    }
                },
                error: function (response) {
                    layer.msg(response.status + " " + response.statusText);
                }
            });
            $("#menuAddModal").modal("hide");
            //不加function,相当于帮用户点击了一次reset
            $("#menuResetBtn").click();
        });

        //更新
        $("#menuEditBtn").click(function () {

            var name = $("#menuEditModal [name=name]").val();
            var url = $("#menuEditModal [name=url]").val();
            var icon = $("#menuEditModal [name=icon]").val();

            $.ajax({
                url:"menu/update.json",
                type:"post",
                data:{
                    id:window.id,
                    name:name,
                    url:url,
                    icon:icon
                },
                dataType:"json",
                success: function (response) {
                    var result = response.result;
                    if (result == "SUCCESS") {
                        layer.msg("操作成功");
                        generatorZTree();
                    }

                    if (result == "FAILED") {
                        layer.msg("操作失败！" + response.message);
                    }
                },
                error: function (response) {
                    layer.msg(response.status + " " + response.statusText);
                }
            });

            $("#menuEditModal").modal("hide");
        });


        //删除
        $("#confirmBtn").click(function () {

            $.ajax({
                url:"menu/remove.json",
                type:"post",
                data:{
                    id:window.id,
                },
                dataType:"json",
                success: function (response) {
                    var result = response.result;
                    if (result == "SUCCESS") {
                        layer.msg("操作成功");
                        generatorZTree();
                    }

                    if (result == "FAILED") {
                        layer.msg("操作失败！" + response.message);
                    }
                },
                error: function (response) {
                    layer.msg(response.status + " " + response.statusText);
                }
            });

            $("#menuConfirmModal").modal("hide");
        });
    })
</script>
<body>

<%@ include file="/WEB-INF/include-nav.jsp" %>
<div class="container-fluid">
    <div class="row">
        <%@ include file="/WEB-INF/include-sidebar.jsp" %>
        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">

            <div class="panel panel-default">
                <div class="panel-heading">
                    <i class="glyphicon glyphicon-th-list"></i> 权限菜单列表
                    <div style="float: right; cursor: pointer;" data-toggle="modal"
                         data-target="#myModal">
                        <i class="glyphicon glyphicon-question-sign"></i>
                    </div>
                </div>
                <div class="panel-body">
                    <!-- 这个ul标签是zTree动态生成的节点所依附的静态节点 -->
                    <ul id="treeDemo" class="ztree"></ul>
                </div>
            </div>
        </div>
    </div>
</div>

<%@ include file="/WEB-INF/modal-menu-add.jsp" %>
<%@ include file="/WEB-INF/modal-menu-edit.jsp" %>
<%@ include file="/WEB-INF/modal-menu-confirm.jsp" %>
</body>
</html>