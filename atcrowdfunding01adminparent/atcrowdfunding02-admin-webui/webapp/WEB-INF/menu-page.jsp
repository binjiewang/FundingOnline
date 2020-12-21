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

        $("#treeDemo").on("click", ".addBtn", function () {
            $("#menuAddModal").modal("show");
            window.pid = this.id;
            return false;
        });

        $("#menuSaveBtn").click(function () {
            debugger;
            var pid = window.pid;
            var name = $.trim($("#menuAddModal [name=name]").val());
            var url =$.trim($("#menuAddModal [name=url]").val());
            var icon = $("#menuAddModal [name=icon]:checked").val();

            if(name=="" || url=="" ||icon==""||icon == undefined){
                layer.msg("名称、地址或图标不可为空!!!")
                return ;
            }

            $.ajax({
                url:"menu/save.json",
                type:"post",
                data:{
                    pid:pid,
                    name:name,
                    url:url,
                    icon:icon
                },
                dataType:"json",
                success: function (response) {
                    var result = response.result;
                    if (result == "SUCCESS") {
                        layer.msg("添加权限成功");
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
</body>
</html>