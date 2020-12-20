<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="zh-CN">
<%@include file="/WEB-INF/include-head.jsp" %>
<link rel="stylesheet" href="css/pagination.css"/>
<script type="text/javascript" src="jquery/jquery.pagination.js"></script>
<script type="text/javascript" src="crowd/my-role.js"></script>
<script type="text/javascript">
    $(function () {
            //初始化加载
            window.pageNum = 1;
            window.pageSize = 5;
            window.keyword = "";

            generatePage();

            $("#searchBtn").click(function () {
                window.keyword = $("#keywordInput").val();
                generatePage();
            });

            //弹出新增模态框
            $("#showAddModalBtn").click(function () {
                //点击模态框外的地方不会消失
                $("#addModal").modal({backdrop: "static"});
                $("#addModal").modal("show");
            });

            //新增模态框保存按钮
            $("#saveRoleBtn").click(function () {
                debugger;
                var roleName = $.trim($("#addModal [name=roleName]").val());

                if (roleName == "") {
                    layer.msg("角色名不能为空");
                    return false;
                }

                $.ajax({
                    url: "role/save.json",
                    type: "post",
                    data: {name: roleName},
                    dataType: "json",
                    success: function (response) {
                        console.log(response);
                        var result = response.result;
                        if (result == "SUCCESS") {
                            layer.msg("添加角色成功");
                            window.pageNum = 9999999;
                            generatePage();
                        }

                        if (result == "FAILED") {
                            layer.msg("操作失败！" + response.message);
                        }
                    },
                    error: function (response) {
                        layer.msg(response.status + " " + response.statusText);
                    }
                })

                $("#addModal").modal("hide");
                //情况模态框Input数据
                $("#addModal [name=roleName]").val("");
            });

            //解决动态绑定用on
            //编辑时回显值
            $("#rolePageBody").on("click", ".pencilBtn", function () {
                //点击模态框外的地方不会消失
                $("#editModal").modal({backdrop: "static"});
                $("#editModal").modal("show");
                var roleName = $(this).parent().prev().text();
                window.roleId = this.id;
                $("#editModal [name=roleName]").val(roleName);
            });

            //更新模态框更新按钮
            $("#updateRoleBtn").click(function () {

                var roleName = $("#editModal [name=roleName]").val();

                $.ajax({
                    url: "role/update.json",
                    type: "post",
                    dataType: "json",
                    data: {
                        id: window.roleId,
                        name: roleName
                    },
                    success: function (response) {
                        console.log(response);
                        var result = response.result;
                        if (result == "SUCCESS") {
                            layer.msg("修改角色成功");
                            generatePage();
                        }

                        if (result == "FAILED") {
                            layer.msg("操作失败！" + response.message);
                        }
                    },
                    error: function (response) {
                        layer.msg(response.status + " " + response.statusText);
                    }
                })

                $("#editModal").modal("hide");
            });

            // 全选/全不选按钮
            $("#summaryBox").click(function () {
                debugger;
                $(".itemBox").prop("checked", this.checked);
            });

            //全选选择时，全选按钮点亮
            $("#rolePageBody").on("click", ".itemBox", function () {
                debugger;
                var itemBoxLength = $(".itemBox").length;
                var itemBoxCheckedLength = $(".itemBox:checked").length;
                $("#summaryBox").prop("checked", itemBoxCheckedLength == itemBoxLength);
            });

            //单项删除按钮
            $("#rolePageBody").on("click", ".removeBtn", function () {
                debugger;
                var roleName = $(this).parent().prev().text();
                var roleArray = [{roleId: this.id, roleName: roleName}];
                showConfirmModal(roleArray);
            });

            //批量删除按钮
            $("#batchRemoveBtn").click(function () {
                debugger;
                var roleArray=[];
                $(".itemBox:checked").each(function () {
                    var roleId=this.id;
                    var roleName = $(this).parent().next().text();
                    roleArray.push({roleId:roleId,roleName:roleName})
                });

                if(roleArray.length==0){
                    layer.msg("至少选择一个人进行删除");
                    return;
                }

                showConfirmModal(roleArray);
            });

            //删除确认按钮
            $("#removeRoleBtn").click(function () {
                var requestBody = JSON.stringify(window.roleIdArray);
                $.ajax({
                        url: "/role/remove/by/role/id/array.json",
                        type: "post",
                        data: requestBody,
                        contentType: "application/json;charset=utf-8",
                        dataType: "json",
                        success: function (response) {
                            console.log(response);
                            var result = response.result;
                            if (result == "SUCCESS") {
                                layer.msg("删除角色成功");
                                generatePage();
                                $("#summaryBox").prop("checked",false);
                            }

                            if (result == "FAILED") {
                                layer.msg("操作失败！" + response.message);
                            }
                        },
                        error: function (response) {
                            layer.msg(response.status + " " + response.statusText);
                        }
                    }
                );

                $("#confirmModal").modal("hide");
            });

        }
    )

</script>
<body>

<%@ include file="/WEB-INF/include-nav.jsp" %>
<div class="container-fluid">
    <div class="row">
        <%@ include file="/WEB-INF/include-sidebar.jsp" %>
        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h3 class="panel-title">
                        <i class="glyphicon glyphicon-th"></i> 数据列表
                    </h3>
                </div>
                <div class="panel-body">
                    <form class="form-inline" role="form" style="float: left;">
                        <div class="form-group has-feedback">
                            <div class="input-group">
                                <div class="input-group-addon">查询条件</div>
                                <input id="keywordInput" name="keyword" class="form-control has-success" type="text"
                                       placeholder="请输入查询条件">
                            </div>
                        </div>
                        <%--type如果为submi会执行两次，导致查询错误--%>
                        <button id="searchBtn" type="button" class="btn btn-warning">
                            <i class="glyphicon glyphicon-search"></i> 查询
                        </button>
                    </form>
                    <button id="batchRemoveBtn" type="button" class="btn btn-danger"
                            style="float: right; margin-left: 10px;">
                        <i class=" glyphicon glyphicon-remove"></i> 删除
                    </button>
                    <!--
                    旧代码
                    <button type="button" class="btn btn-primary"
                        style="float: right;" onclick="window.location.href='add.html'">
                        <i class="glyphicon glyphicon-plus"></i> 新增
                    </button> -->
                    <!-- 新代码 -->
                    <a style="float: right;" id="showAddModalBtn" class="btn btn-primary"><i
                            class="glyphicon glyphicon-plus"></i> 新增</a>
                    <br>
                    <hr style="clear: both;">
                    <div class="table-responsive">
                        <table class="table  table-bordered">
                            <thead>
                            <tr>
                                <th width="30">#</th>
                                <th width="30"><input id="summaryBox" type="checkbox"></th>
                                <th>名称</th>
                                <th width="100">操作</th>
                            </tr>
                            </thead>
                            <tbody id="rolePageBody"></tbody>
                            <tfoot>
                            <tr>
                                <td colspan="6" align="center">
                                    <div id="Pagination" class="pagination"><!-- 这里显示分页 --></div>
                                </td>
                            </tr>
                            </tfoot>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<%@include file="/WEB-INF/modal-role-add.jsp" %>
<%@include file="/WEB-INF/modal-role-edit.jsp" %>
<%@include file="/WEB-INF/modal-role-confirm.jsp" %>
</body>
</html>