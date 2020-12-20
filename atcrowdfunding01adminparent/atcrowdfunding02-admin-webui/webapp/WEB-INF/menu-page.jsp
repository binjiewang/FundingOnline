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

        $.ajax({
            url: "menu/get/whole/tree.json",
            type: "post",
            dataType: "json",
            success: function (response) {
                var result = response.result;
                if (result == "SUCCESS") {
                    var setting = {
                        view: {addDiyDom: myAddDiyDom,
                            addHoverDom: myAddHoverDom,
                            removeHoverDom: myRemoveHoverDom},
                        data: {key: {url: "noUrl"}}
                    };
                    $.fn.zTree.init($("#treeDemo"), setting, response.data);
                }

                if (result == "FAILED") {
                    layer.msg("初始化失败！" + response.message);
                }
            }
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
</body>
</html>