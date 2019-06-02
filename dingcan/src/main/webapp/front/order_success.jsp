<%@page pageEncoding="UTF-8" contentType="text/html; UTF-8" %>
<%@include file="../basic/basic.jsp"%>
<!doctype html>
<html>
<head>
    <title>下单成功</title>
    <%--引入资源--%>
    <%@include file="../basic/resources.jsp"%>
    <link rel="stylesheet" href="frontbasic/basic.css">
    <style>
        td a{
            margin-left: 15px;
        }
        #dropul{
            min-width: 0px;
        }
        #dropul a{
            color: gray;
            line-height: 25px !important;
            font-size: 14px;
        }
        #main{
            margin-top: 30px;
            border: 1px solid #eee;
            background-color: #fff;
            min-height: 150px;
            padding: 20px 18px;
            border-radius: 5px;
        }
        .hint{
            text-align: center;
            font-size: 16px;
        }
    </style>
    <script>
        $(function () {
            //判断是否登录
            $.post("${app}/user/judge",function (result) {
                if(result == ""){
                    window.location.href="${app}/front/login.jsp"
                }
            })
           var second = $("#second");
            var m = 5;
            var timers = window.setInterval(function() {
                second.text(m-=1);
            }, 1000)

            window.setTimeout(function() {
                clearInterval(timers);
                window.location.href = "${app}/front/index.jsp";
            }, 5000)
        })
    </script>
</head>
<body>

<div class="Wrapper">
<%--导航--%>
<%@include file="frontbasic/header.jsp" %>
<div class="container">
    <div class="col-sm-8 col-sm-offset-2" id="main">
        <div class="page-header" style="margin-top: 0px">
            <h3  style="margin-top: 0px">下单成功</h3>
        </div>
        <div class="hint">
            <p class="text-muted">还有 <strong id="second" style="color:red;">5</strong> 秒,回到首页</p>
            <p class="text-muted"><a href="${app}/front/index.jsp">继续浏览并选购商品</a></p>
        </div>
    </div>
</div>
    <%--选择地址模态框--%>


<div class="FooterPush"></div>
</div>

<%--页脚--%>
</body>
</html>

<%--专辑管理 章节管理--%>