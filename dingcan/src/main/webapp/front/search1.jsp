<%@page pageEncoding="UTF-8" contentType="text/html; UTF-8" %>
<%@include file="../basic/basic.jsp" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>搜索结果</title>
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

        #searchBtn{
            height: 40px;
            line-height: 30px;
            border-left: none;
            box-shadow: inset 0 1px 1px rgba(0,0,0,.075);
            color: gray;
        }
        #searchBtn:active,
        #searchBtn:hover,
        #searchBtn:focus{
            background: white;
            border: 1px solid #ccc;
            border-left: none;
            color: rgb(255,150,0);
        }
        #searchinput:focus{
            box-shadow: none;
        }
        #searchUl{
            min-width: 50px;
        }
        .rstblock{
            width: 25%;
            background-color: #fff;
            border-bottom: 1px #f5f5f5 solid;
            height: 100px;
        }
        .rstblock, .rstblock-logo {
            float: left;
            font-size: 12px;
            position: relative;
        }
        .rstblock-logo {
            padding: 20px;
            color: #999;
            text-align: center;
        }
        .rstblock-content {
            padding: 20px;
        }
        .rstblock-title {
            font-size: 16px;
            margin-bottom: 6px;
            font-weight: 600;
            overflow: hidden;
            white-space: nowrap;
            text-overflow: ellipsis;
            color: #333;
        }
        .rstblock:hover,
        .rstblock:focus{
            background-color: #f7f7f7;
            text-decoration: none;
        }
        .rstblock-cost {
            color: #999;
            margin-top: 3px;
        }
        #add{
            padding: 1px 3px;
            font-size: 12px;
        }
        #jia{
            font-size: 14px;
        }
    </style>
    <script>
        $(function () {
            var item = "${param.item}"
            var cate = "${param.cate}"
            $.post("${app}/business/findBySearch",{"item":item,"cate":cate},function (result) {
                console.log(result);
            })

            $(".searcha").on("click",function () {
                if($("#searchinput").val() == ""){
                    //window.location.href="${app}/front/index.jsp?";
                }else{
                    window.location.href="${app}/front/search.jsp?item="+$("#searchinput").val()+"&cate="+$(this).text();
                }
            })
        })
    </script>
</head>
<body>
<%--header--%>
<%@include file="frontbasic/header.jsp" %>

<div id="main">
    <%--搜索--%>
    <div class="container">
        <form class="navbar-form navbar-left pull-right" style="padding: 0px; margin-bottom: 10px">
            <div class="form-group input-group" style="position: relative">
                <input type="text" class="form-control" placeholder="搜索商家或美食..." id="searchinput">
                <div class="input-group-btn">
                    <button type="button" id="searchBtn" class="btn btn-default dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"> <span class="glyphicon glyphicon-search" aria-hidden="true"></span></button>
                    <ul class="dropdown-menu dropdown-menu-right" id="searchUl">
                        <li><a class="searcha">商家</a></li>
                        <li><a class="searcha">美食</a></li>
                    </ul>
                </div><!-- /btn-group -->
            </div>
        </form>
    </div>
    <%--搜索列表--%>
    <div class="container">
        <div class="panel panel-default">
            <div class="panel-heading"></div>
            <div class="panel-body" style="padding: 0px" id="panel">
                <a href="" class="rstblock" >
                    <div class="rstblock-logo" >
                        <img src="../upload/goodsImg/1556981387992.jpeg" width="70" height="70" alt="晓寿司(建国门店)" class="rstblock-logo-icon">
                    </div>
                    <div class="rstblock-content">
                        <div class="rstblock-title">猪软骨面</div>
                        <div class="rstblock-cost"><span style="color: red" id="jia">￥45</span></div>
                        <div class="rstblock-cost"><span class="btn btn-primary" id="add">加入购物车</span> </div>
                    </div>
                </a>
            </div>
        </div>
    </div>
</div>
</body>
</html>