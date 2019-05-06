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
            background: url("../statics/img/bg1.jpg") no-repeat;
            background-position: 0px -450px;
            background-size: cover;
            padding-top: 48px;
        }
        /*#shop-content{
            height: 142px;
        }*/

        #myTab{
            border: none;
        }

        #myTab li a{
            color: black;
            width: 112px;
            text-align: center;
            font-size: 16px;
            height: 55px;
            line-height: 34px;

        }
        #myTab li a:hover{
            background-color: white;
            border: none;
        }
        #myTab li.active a{
            color: rgb(19,209,190) !important;
            border:none;
            border-bottom: 2px solid rgb(19,209,190);
        }
        #shopDiv{
            margin-top: 20px;
        }
        .shopleft{
            padding-left: 0px;
            padding-right: 0px;
        }
        #cate1 a{
            color: #666;
            display: inline-block;
            margin: 3px 6px;
            padding: 5px 10px;
            border-radius: 3px;
        }
        #cate1 a:hover,
        #cate1 a:focus,
        #cate1 a:active{
            text-decoration: none;
            background-color: #f7f7f7;
        }
    </style>
    <script>
        $(function () {
            var bid = "${param.bid}"
            $.post("${app}/business/findById",{"bid":bid},function (result) {
                console.log(result);
                $("#bname").text(result.name);
                $("#blogo").attr("src","/upload/"+result.imgUrl)
                $("#starPrice").text(result.startPrice)
                $("#tranPrice").text(result.distributionFee)
                $("#notice").text(result.notice);
            })
            $.post("${app}/cateInStore/findByBusiness",{"bid":bid},function (result) {
                console.log(result);
                var cate11 = $("#cate1");
                for(var i = 0; i<result.length; i++){
                    var a = $("<a>").text(result[i].name).attr({"href":"#"})
                    cate11.append(a);
                }
            })
        })
    </script>
</head>
<body>
<%--header--%>
<nav class="navbar" role="navigation" id="header" style="background-color: rgba(0,0,0,.4); border: none; margin-bottom: 8px">
    <div class="container">
        <div class="navbar-header">
            <a class="navbar-brand" href="./index.jsp" id="logo1">DLSZ</a>
        </div>

        <!-- Collect the nav links, forms, and other content for toggling -->
        <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
            <ul class="nav navbar-nav navul1">
                <li><a href="#">首页</a></li>
                <li><a href="#">我的购物车</a></li>
                <li><a href="#">我的订单</a></li>
            </ul>
            <ul class="nav navbar-nav navbar-right navul1">
                <li class="dropdown" style="height: 100%">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                        xiaohei <b class="caret"></b>
                    </a>
                    <ul class="dropdown-menu" id="dropul">
                        <li><a href="#">个人中心</a></li>
                        <li><a href="#">我的地址</a></li>
                        <li><a href="#">安全设置</a></li>
                        <li class="divider"></li>
                        <li><a href="#">退出登录</a></li>
                    </ul>
                </li>
            </ul>
        </div>
    </div>
</nav>

<%--main--%>
<div id="main">
    <%--shopheader--%>
    <div class="shop">
        <div id="shop-content" class="container" style="padding-left: 0px">
            <div class="col-sm-5" style="padding: 20px 0">
                <img src="../statics/img/cs.png" id="blogo" class="img-circle" width="95px" style="border: 4px solid rgba(255,255,255,.3);vertical-align: middle;margin-right: 15px">
                <div style="    display: inline-block; vertical-align: middle; color: #fff;">
                    <h1 style="max-width: 270px;font-size: 20px" id="bname">焖范儿·三汁焖饭</h1>
                </div>
            </div>
            <div class="col-sm-1 col-sm-offset-3" style="padding: 50px 0;text-align: right">
                <div style="display: inline-block; vertical-align: middle; color: #fff;">
                    <span>起送价</span>
                    <h1 style="max-width: 170px;font-size: 20px;margin-top: 10px"><span id="starPrice">20</span>元</h1>
                </div>
            </div>
            <div class="col-sm-2 col-sm-offset-1" style="padding: 50px 0">
                <div style="display: inline-block; vertical-align: middle; color: #fff;text-align: center" >
                    <span>配送费</span>
                    <h1 style="max-width: 170px;font-size: 20px;margin-top: 10px">配送费￥<span id="tranPrice">5</span></h1>
                </div>
            </div>
        </div>
    </div>

    <%--shopnav--%>
     <div style="background-color: white">
        <div class="container">
            <ul id="myTab" class="nav nav-tabs">
                <li class="active">
                    <a href="#home" data-toggle="tab">
                        所有商品
                    </a>
                </li>
                <li><a href="#ios" data-toggle="tab">评价</a></li>
            </ul>
        </div>
    </div>

    <%--shopmain--%>
    <div class="container" id="shopDiv">
        <div id="myTabContent" class="tab-content col-sm-9 shopleft">
            <div class="tab-pane fade in active panel panel-default" id="home">
                <div class="panel-body">
                    <div id="cate1">
                        <a href="javascript:void(0);" id="allStore">全部</a>
                    </div>
                </div>

            </div>
            <div class="tab-pane fade" id="ios">
                <p>iOS 是一个由苹果公司开发和发布的手机操作系统。最初是于 2007 年首次发布 iPhone、iPod Touch 和 Apple
                    TV。iOS 派生自 OS X，它们共享 Darwin 基础。OS X 操作系统是用在苹果电脑上，iOS 是苹果的移动版本。</p>
            </div>
        </div>

        <div class="col-sm-3">
            <div class="panel panel-default">
                <div class="panel-heading" style="background-color: rgb(19,209,190); color: white">商家公告</div>
                <div class="panel-body" style="padding: 10px 15px;line-height: 2;">
                    <p id="notice"></p>
                </div>
            </div>
        </div>

    </div>



</div>
</body>
</html>