<%@page pageEncoding="UTF-8" contentType="text/html; UTF-8" %>
<%@include file="../basic/basic.jsp" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>商家</title>
    <%--引入资源--%>
    <%@include file="../basic/resources.jsp" %>
    <link rel="stylesheet" href="frontbasic/basic.css">
    <style>
        #dropul{
            min-width: 0px;
        }
        #dropul a{
            color: gray;
            line-height: 25px !important;
            font-size: 14px;
        }
        #header{
            position: absolute;
            width: 100%;
        }
        .shop{

        }

    </style>
    <script>
        $(function () {

        })
    </script>
</head>
<body>
<%--header--%>
<nav class="navbar" role="navigation" id="header" style="background-color: rgba(19,209,190,.4);; border: none; margin-bottom: 8px">
    <div class="container">
        <!-- Brand and toggle get grouped for better mobile display -->
        <div class="navbar-header">
            <a class="navbar-brand" href="./index.jsp" id="logo1">DLSZ</a>
        </div>

        <!-- Collect the nav links, forms, and other content for toggling -->
        <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
            <ul class="nav navbar-nav navul1">
                <li class="active"><a href="#">首页</a></li>
                <li><a href="#">我的购物车</a></li>
                <li><a href="#">我的订单</a></li>
            </ul>
        </div>
    </div>
</nav>

<div id="main">
    <div class="shop">

    </div>
</div>
</body>
</html>