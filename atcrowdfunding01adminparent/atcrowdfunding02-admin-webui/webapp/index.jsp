<%--
  Created by IntelliJ IDEA.
  User: binjiewang
  Date: 2020-12-08
  Time: 18:30
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <base href="http://${pageContext.request.serverName}:${pageContext.request.serverPort}${pageContext.request.contextPath}">
    <script type="text/javascript" src="jquery/jquery-2.1.1.min.js"></script>
    <script type="text/javascript" src="layer/layer.js"></script>
    <script>
        $(function () {
            $("#btn1").click(function () {
                debugger;
                alert("测试");

                var array = [1,2,3];
                var requestBody = JSON.stringify(array);

                $.ajax({
                    url:"test/testJson.html",
                    type:"post",
                    contentType:"application/json;charset=UTF-8",
                    data:requestBody,
                    dataType:"text",
                    success:function (data) {
                        alert(data);
                    }
                })
            });

            $("#btn2").click(function () {
                layer.msg("这是一个layer测试弹框");
            })

        })
    </script>
</head>

<body>
<a href="test/ssm.html">测试ssm整合环境</a>

<button id="btn1">ajax测试</button>
<button id="btn2">layer弹窗测试</button>
</body>
</html>
