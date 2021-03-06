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
            padding-right: 0px;
        }

        #myTab li a{
            color: black;
            width: 112px;
            text-align: center;
            font-size: 16px;
            height: 55px;
            line-height: 34px;

        }
        #jian{
            padding-top: 10px;
            float: right;
        }
        #jian span{
            color: rgb(19,209,190);
            line-height: 34px;
            height: 55px;
            border: 1px solid rgb(19,209,190);
            padding: 2px 3px;
            border-radius: 2px;
            margin-left: 10px;
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
        .foodmain{
            padding: 0;
        }

        .foodmain .goodtitle{
            padding: 20px 0 10px 15px;
            font-size: 20px;
            font-weight: 400;
            margin: 0;
        }

        .foodmain .fooddiv{
            padding-left: 0px;
            background-color: white;
            margin-bottom: 12px;
            width: calc(50% - 10px);
        }
        .foodmain .fooddiv:nth-child(2n){
            margin-right: 18px;
        }
        .c1 img{
            margin-right: 14px;
            float: left;
        }
        .c2{
            /*width: 70%;*/
            line-height: 20px;
        }
        .c2 h3{
            font-size: 14px;
            font-weight: 700;
            margin: 0px;
            padding-top: 10px;

        }
        .c2 p {
            font-size: 12px;
            margin: 0;
            padding: 0;
            color: #999;
            overflow: hidden;
            white-space: nowrap;
            text-overflow: ellipsis;
        }
        .price{
            font-size: 14px;
            color: #f74342;
            font-weight: 700;
            position: absolute;
            bottom: 10px;
        }
        .c2 .btn{
            float: right;
            position: absolute;
            right: 10px;
            bottom: 10px;
            border: 0;
            cursor: pointer;
            width: 90px;
            height: 26px;
            border-radius: 20px;
            text-align: center;
            outline: 0;
            font-size: 12px;
            background-color: rgb(19,209,190) !important;
            line-height: 14px;
        }
        .commentlist {
            padding: 0 20px 20px 0;
        }
        .commentitem {
            padding: 20px 0;
            margin-left: 130px;
            position: relative;
            border-bottom: 1px solid #eee;
            min-height: 100px;
        }
        .preimg {
            position: absolute;
            left: -130px;
            width: 130px;
            text-align: center;
        }
        ul{
            list-style: none;
        }
        .preimg img {
            width: 60px;
            height: 60px;
            border-radius: 50%;
            position: relative;
            top: 10px;
        }
        .commentbox {
            background-color: #fff;
            border: 1px solid #eee;
        }
        .commentitem-username {
            margin-bottom: 15px;
            font-weight: 400;
            display: block;
            font-size: 14px;
        }
        .comment-main {
            padding-top: 15px;
            padding-bottom: 15px;
            border-top: 1px solid #f7f7f7;
        }
        .comment-date {
            position: absolute;
            top: 28px;
            right: 0;
            font-size: 12px;
            color: #999;
        }
        .order-main {
            margin-bottom: 20px;
        }
        .grade {
            vertical-align: middle;
            color: #999;
        }
        .food{
            color: #eb6643;
            margin-right: 10px;
            line-height: normal;
            vertical-align: middle;
        }
        .iteminfo-imagegroup  {
            white-space: normal;
            display: inline-block;
            vertical-align: top;
            margin-right: 30px;
            width: 360px;
            overflow: auto;
        }
        .iteminfo-info {
            display: inline-block;
            vertical-align: top;
            white-space: normal;
            width: 430px;
        }
        .iteminfo-imagegroup .mainimage {
            width: 360px;
            height: 360px;
        }
        .iteminfo-info h5 {
            font-size: 22px;
            color: #333;
            margin-bottom: .5em;
        }
        .iteminfo-info .description {
             padding: 5px 0;
             border: 1px dashed #ccc;
             border-left: 0;
             border-right: 0;
             color: #aaa;
             line-height: 1.8em;
             font-size: 13px;
         }
        .iteminfo-cartitem {
            position: relative;
            margin: 20px 0 30px;
            height: 35px;
        }
        .iteminfo-price {
            color: #f17530;
            line-height: 1;
            padding-top: 5px;
            display: inline-block;
        }
        .iteminfo-price .price1 {
            font-size: 28px;
            font-weight: 800;
        }
        .yen {
            font-size: 16px;
        }
        .shop-btn{
            background-color: rgb(19,209,190) !important;
            border-color: rgb(19,209,190) !important;
            border-radius: 20px;
        }

        .shop-btn:hover,
        .shop-btn:active{
            border-color: rgb(115,225,206) !important;
            background-color: rgb(115,225,206) !important;
        }
        #alert{
            position: fixed;
            width: 350px;
            left: 560px;
            top: 40px;
            z-index: 10;
            padding: 20px 30px;
        }
    </style>
    <script>
        $(function () {
            $("#alert").hide();
            $('#collapseTwo').collapse('show')
            var bid = "${param.bid}"
            //查询当前商家信息
            $.post("${app}/business/findById",{"bid":bid},function (result,index,xhr) {
                //console.log(result);
                //判断是否登录
                var isLogin = xhr.getResponseHeader('isLogin');
                if(isLogin == "false"){
                    window.location.href="${app}/front/login.jsp"
                }else{
                    $("#bname").text(result.name);
                    $("#blogo").attr("src","/upload/"+result.imgUrl)
                    $("#starPrice").text(result.startPrice)
                    $("#tranPrice").text(result.distributionFee)
                    $("#notice").text(result.notice);
                }
            })

            //查询当前商家满减信息
            $.post("${app}/reduce/findByBusiness",{"bid":bid},function (result) {
                console.log(result);
                var li = $("#jian");
                for(var i = 0; i<result.length; i++){
                    var span = $("<span>").text(result[i].achieveMoney+"减"+result[i].reduceMoney);
                    li.append(span)
                }
            })


            //查询当前商家类别信息
            $.post("${app}/cateInStore/findByBusiness",{"bid":bid},function (result) {
                console.log(result);
                var cate1 = $("#cate1");
                for(var i = 0; i<result.length; i++){
                    var a = $("<a>").text(result[i].name).attr({"href":"#"+result[i].id})
                    cate1.append(a);            //添加本店分类

                    //console.log(result[i])
                    var foodmain = $("<div>").addClass("container-fluid foodmain");
                    var aa = $("<a>").attr({"name":result[i].id});
                    var goodtitle = $("<h3>").addClass("goodtitle").text(result[i].name).append(aa);
                    foodmain.append(goodtitle);     //插入每组分类标题

                    //遍历添加每组分类下食物
                    var goodss = result[i].goodss;
                    for(var j = 0;j<goodss.length;j++){
                        var img =  $("<img>").attr({"src":"../upload/goodsImg/"+goodss[j].imgUrl}).css({"width":"100px","height":"100px"});
                        var a1 = $("<a>").attr({"href":"javascript:showModal('"+goodss[j].id+"','"+bid+"','"+goodss[j].name+"','"+goodss[j].price+"','"+goodss[j].description+"','"+goodss[j].imgUrl+"')"}).append(img);
                        var c1 = $("<div>").addClass("c1").append(a1);

                        var h3 = $("<h3>").text(goodss[j].name);
                        var p1 = $("<p>").text(goodss[j].description);
                        var p2 = $("<p>").text("月售"+goodss[j].saleCount+"份");
                        var sp = $("<span>").text("￥"+goodss[j].price).addClass("price");
                        var a = $("<a>").addClass("btn btn-primary").text("加入购物车").attr({"href":"javascript:addCart('"+goodss[j].id+"','"+bid+"','"+goodss[j].name+"')"});
                        var c2 = $("<div>").addClass("c2").append(h3).append(p1).append(p2).append(sp).append(a);
                        var fooddiv = $("<div>").addClass("col-sm-6 fooddiv").append(c1).append(c2);
                        foodmain.append(fooddiv);
                    }
                    var home = $("#home").append(foodmain);
                }
            })

            //查询该商家下的评论
            $("#commentli").on("click",function () {
                $.post("${app}/comment/findByBuss",{"bid":bid},function (result) {
                    $("#commentlist").empty();
                    console.log(result);
                    for(var i = 0; i<result.length; i++){
                        var comment =  result[i];
                        var img = $("<img>").attr({"src":"../upload/"+comment.imgUrl})
                        var prespan = $("<span>").addClass("preimg").append(img);

                        var username = $("<h4>").addClass("commentitem-username").text(comment.username);
                        var span1 = $("<span>").addClass("food").text(comment.goodNames);
                        var span2 = $("<span>").addClass("grade").text(comment.average+"分")
                        var div1 = $("<div>").addClass("order-main").append(span1).append(span2);
                        var span3 = $("<span>").text(comment.content);
                        var div2 = $("<div>").addClass("comment-main").append(span3);
                        var span4 = $("<span>").addClass("comment-date").text(comment.createDate);
                        var div = $("<div>").addClass("commentitem-content").append(username).append(div1).append(div2).append(span4);

                        var li = $("<li>").addClass("commentitem").append(prespan).append(div);
                        $("#commentlist").append(li);
                    }
                })
            })

        })
        //加入购物车
        function addCart(goodsId,businessId,goodsName) {
            $.post("${app}/cart/add",{"goodsId":goodsId,"businessId":businessId,"goodsName":goodsName})
            $("#alert").show(500).delay(300).hide(500);
        }

        function addCart1(goodsId,businessId,goodsName) {
            $.post("${app}/cart/add",{"goodsId":goodsId,"businessId":businessId,"goodsName":goodsName})
            $("#myModal").modal("hide")
        }

        //显示模态框(显示食品详情)
        function showModal(goodsId,businessId,goodsName,price,description,imgUrl) {
            $("#fhead").text(goodsName)
            $("#fprice").text(price)
            $("#desc").text(description)
            $("#myModal").modal('show');
            $("#fimg").attr({"src":"../upload/goodsImg/"+imgUrl})
            $("#addCartBtn1").attr({"href":"javascript:addCart1('"+goodsId+"','"+businessId+"','"+goodsName+"')"});
        }
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
                <li><a href="${app}/front/index.jsp">首页</a></li>
                <li><a href="${app}/front/cart.jsp">我的购物车</a></li>
                <li><a href="${app}/front/order.jsp">我的订单</a></li>
            </ul>
            <ul class="nav navbar-nav navbar-right navul1">
                <li class="dropdown" style="height: 100%">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                        ${sessionScope.username} <b class="caret"></b>
                    </a>
                    <ul class="dropdown-menu" id="dropul">
                        <li><a href="${app}/front/information.jsp">个人中心</a></li>
                        <li><a href="${app}/front/address.jsp">我的地址</a></li>
                        <li><a href="${app}/front/change.jsp">安全设置</a></li>
                        <li class="divider"></li>
                        <li><a href="javascript:exit()">退出登录</a></li>
                        <script>
                            function exit() {
                                $.post("${app}/user/exit",function (result) {
                                    window.location.href="${app}/front/login.jsp"
                                })
                            }
                        </script>
                    </ul>
                </li>
            </ul>
        </div>
    </div>
</nav>

<div class="alert alert-success" id="alert">
    添加购物车成功~~
</div>

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
            <ul id="myTab" class="nav nav-tabs col-sm-9">
                <li class="active">
                    <a href="#home" data-toggle="tab">
                        所有商品
                    </a>
                </li>
                <li><a href="#ios" data-toggle="tab" id="commentli">评价</a></li>
                <li id="jian">
                   <%-- <span>40减5</span>
                    <span>50减10</span>--%>
                </li>

            </ul>
        </div>
    </div>

    <%--shopmain--%>
    <div class="container" id="shopDiv">
        <div id="myTabContent" class="tab-content col-sm-9 shopleft">
            <%--left--%>
            <div class="tab-pane fade in active" id="home">
                <div class=" panel panel-default" style="margin-bottom: 0">
                    <div class="panel-body">
                        <div id="cate1">
                            <a href="javascript:void(0);" id="allStore">全部</a>
                        </div>
                    </div>
                </div>
               <%-- <div class="container-fluid foodmain">
                    <h3 class="goodtitle">池田单品</h3>
                    <div class="col-sm-6 fooddiv">
                        <div class="c1">
                            <a href="#">
                                <img src="../upload/goodsImg/1556981387992.jpeg" style="width: 100px;height: 100px">
                            </a>
                        </div>
                        <div class="c2">
                            <h3>秋田十味</h3>
                            <p>中华沙律、红蟹子、龙虾沙拉、芝麻八爪鱼、芥末章鱼、香辣海螺、香辣鱿鱼等10款军舰组合</p>
                            <p>月售<span>56</span>份 </p>
                            <span class="price">￥88</span>
                            <a class="btn btn-primary">加入购物车</a>
                        </div>
                    </div>
                    <div class="col-sm-6 fooddiv">
                        <div class="c1">
                            <a href="#">
                                <img src="../upload/goodsImg/1556981387992.jpeg" style="width: 100px;height: 100px">
                            </a>
                        </div>
                        <div class="c2">
                            <h3>秋田十味</h3>
                            <p>中华沙律、红蟹子、龙虾沙拉、芝麻八爪鱼、芥末章鱼、香辣海螺、香辣鱿鱼等10款军舰组合</p>
                            <p>月售<span>56</span>份 </p>
                            <span class="price">￥88</span>
                            <a class="btn btn-primary">加入购物车</a>
                        </div>
                    </div>
                    <div class="col-sm-6 fooddiv">
                        <div class="c1">
                            <a href="#">
                                <img src="../upload/goodsImg/1556981387992.jpeg" style="width: 100px;height: 100px">
                            </a>
                        </div>
                        <div class="c2">
                            <h3>秋田十味</h3>
                            <p>中华沙律、红蟹子、龙虾沙拉、芝麻八爪鱼、芥末章鱼、香辣海螺、香辣鱿鱼等10款军舰组合</p>
                            <p>月售<span>56</span>份 </p>
                            <span class="price">￥88</span>
                            <a class="btn btn-primary">加入购物车</a>
                        </div>
                    </div>

                </div>
                <div class="container-fluid foodmain">
                    <h3 class="goodtitle">池田单品</h3>
                    <div class="col-sm-6 fooddiv">
                        <div class="c1">
                            <a href="#">
                                <img src="../upload/goodsImg/1556981387992.jpeg" style="width: 100px;height: 100px">
                            </a>
                        </div>
                        <div class="c2">
                            <h3>秋田十味</h3>
                            <p>中华沙律、红蟹子、龙虾沙拉、芝麻八爪鱼、芥末章鱼、香辣海螺、香辣鱿鱼等10款军舰组合</p>
                            <p>月售<span>56</span>份 </p>
                            <span class="price">￥88</span>
                            <a class="btn btn-primary">加入购物车</a>
                        </div>
                    </div>
                    <div class="col-sm-6 fooddiv">
                        <div class="c1">
                            <a href="#">
                                <img src="../upload/goodsImg/1556981387992.jpeg" style="width: 100px;height: 100px">
                            </a>
                        </div>
                        <div class="c2">
                            <h3>秋田十味</h3>
                            <p>中华沙律、红蟹子、龙虾沙拉、芝麻八爪鱼、芥末章鱼、香辣海螺、香辣鱿鱼等10款军舰组合</p>
                            <p>月售<span>56</span>份 </p>
                            <span class="price">￥88</span>
                            <a class="btn btn-primary">加入购物车</a>
                        </div>
                    </div>
                    <div class="col-sm-6 fooddiv">
                        <div class="c1">
                            <a href="#">
                                <img src="../upload/goodsImg/1556981387992.jpeg" style="width: 100px;height: 100px">
                            </a>
                        </div>
                        <div class="c2">
                            <h3>秋田十味</h3>
                            <p>中华沙律、红蟹子、龙虾沙拉、芝麻八爪鱼、芥末章鱼、香辣海螺、香辣鱿鱼等10款军舰组合</p>
                            <p>月售<span>56</span>份 </p>
                            <span class="price">￥88</span>
                            <a class="btn btn-primary">加入购物车</a>
                        </div>
                    </div>

                </div>--%>
            </div>

            <%--right--%>
            <div class="tab-pane fade commentbox " id="ios">
                <ul class="commentlist" id="commentlist">
                    <%--<li class="commentitem">
                        <span class="preimg">
                            <img src="../statics/img/header.png" alt="">
                        </span>
                        <div class="commentitem-content" >
                            <h4 class="commentitem-username">xiaohei</h4>
                            <div class="order-main" >
                                <span class="food" >海带寿司</span>
                                <span class="grade">2分</span>
                            </div>
                            <div class="comment-main">
                                <span>好吃</span>
                            </div>
                            <span class="comment-date">
                                2019-05-12 12:00:00
                            </span>
                        </div>
                    </li>--%>

                </ul>
            </div>
        </div>

        <div class="col-sm-3">
            <div class="panel panel-default">
                <div class="panel-heading" style="background-color: rgb(19,209,190); color: white">商家公告</div>
                <div class="panel-body" style="padding: 10px 15px;line-height: 2;">
                    <p id="notice"></p>
                </div>
            </div>
            <%--<div class="panel panel-default">
                <div class="panel-heading" style="background-color: rgb(19,209,190); color: white">满减信息</div>
                <div class="panel-body" style="padding: 10px 15px;line-height: 2;">
                    <p id="manjian"></p>
                </div>
            </div>--%>
        </div>

        <!-- 模态框（Modal） -->
        <div class="modal fade bs-example-modal-lg"  id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg" >
                <div class="modal-content">
                    <div class="modal-body" style="padding: 30px">
                        <div class="iteminfo-imagegroup">
                            <img src="../statics/img/f1.jpeg" alt="" class="mainimage" id="fimg">
                        </div>
                        <div class="iteminfo-info" >
                            <h5 id="fhead">鳗鱼寿司2粒</h5>
                            <p class="description ng-binding" id="desc">每份2粒，寿司饭12-14g 主要原料: 鳗鱼</p>
                            <div class="iteminfo-cartitem">
                                <div class="iteminfo-price">
                                    <span class="price1">
                                        <span class="yen">￥</span><span class="price1 ng-binding" id="fprice">12</span>
                                    </span>
                                </div>
                                <a class="btn btn-primary pull-right shop-btn" id="addCartBtn1">
                                    加入购物车
                                </a>
                            </div>
                        </div>
                    </div>
                </div><!-- /.modal-content -->
            </div><!-- /.modal -->
        </div>

    </div>



</div>

</body>
</html>