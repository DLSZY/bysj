<%@page pageEncoding="UTF-8" contentType="text/html; UTF-8" %>
<%@include file="../basic/basic.jsp" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>外卖商家</title>
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
        #filter-name{
            position: absolute;
            top: 7px;
            color: #999;
        }
        #cate2{
            border: none;
            background-color: #f7f7f7;
            border-radius: 0px;
            margin: 5px 0px;
        }
        #cate2 a{
            display: inline-block;
            margin: 3px 6px;
            padding: 5px 10px;
            border-radius: 3px;
        }
        #cate2 a:hover,
        #cate2 a:focus{
            text-decoration: none;
            color:white;
            background-color: rgb(255,150,0);
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
            color: rgb(19,209,190);
        }
        #searchinput:focus{
            box-shadow: none;
        }
        #searchUl{
            min-width: 50px;
        }
        .active a{
            background-color: rgb(115,225,206) !important;
        }
    </style>
    <script>
        $(function () {
        /*分类*/
            $("#cate22").hide()
            //查询所有一级分类
            $.post("${app}/category/selectByLevel",{"level":1},function (result) {
                var cate11 = $("#cate11");
                for(var i = 0; i<result.length; i++){
                    var a = $("<a>").text(result[i].name).attr({"href":"#"})
                    cate11.append(a);
                }
            })
            //查询一级分类下的二级分类
            $("#cate11").on("click","a:not(#allStore)",function () {
                var parentName = $(this).text();
                $.post("${app}/category/selectByFirstName",{"firstName":parentName},function (result) {
                    var cate22 = $("#cate22");
                    cate22.empty();
                    cate22.show();
                    var a1 = $("<a>").text("全部").attr({"href":"#","id":"allSecondStore","title":parentName})
                    cate22.append(a1);
                    for(var i = 0; i<result.length; i++){
                        var a = $("<a>").text(result[i].name).attr({"href":"#"})
                        cate22.append(a);
                    }
                })
                //根据一级类别查询商家
                showByFirst(parentName);
            })

        /*商家*/
            showAll();
            //点击所有商家
            $("#allStore").on("click",function () {
                $("#cate22").hide()
                showAll();
            })

            //查询二级分类下商家
            $("#cate22").on("click","a:not(#allSecondStore)",function () {
                var parentName = $(this).text();
                $.post("${app}/business/findBySecond",{"cateName":parentName},function (result) {
                    showBusiness(result)
                })
            })

            //查询当前一级分类下的所有商家
            $("#cate22").on("click","#allSecondStore",function () {
                showByFirst($(this).attr("title"));
            })

            //点击查询
            /* $("#forget").on("click",function () {
                 if($("#searchinput").val() == ""){
                     window.location.href="${app}/front/index.jsp?";
                }else{
                    window.location.href="${app}/front/search.jsp?item="+$("#searchinput").val();
                }
            })*/
            $(".searcha").on("click",function () {
                if($("#searchinput").val() == ""){
                    //window.location.href="${app}/front/index.jsp?";
                }else{
                    window.location.href="${app}/front/search.jsp?item="+$("#searchinput").val()+"&cate="+$(this).text();
                }
            })
        })

    /*方法*/
        //查询所有商家
        function showAll(){
            $.post("${app}/business/findAllNormal",function (result) {
                showBusiness(result)
            })
        }
        //根据一级类别查询商家
        function showByFirst(parentName) {
            $.post("${app}/business/findByFirst",{"cateName":parentName},function (result) {
                showBusiness(result)
            })
        }

        //根据结果显示商家
        function showBusiness(result) {
            console.log(result);
            $("#panel").empty();
            for(var i = 0; i<result.length; i++){
                var a = $("<a>").attr({"href":"${app}/front/business.jsp?bid="+result[i].id}).addClass("rstblock");
                var div1 = $("<div>").addClass("rstblock-logo");
                var img = $("<img>").attr({"src":"../upload/"+result[i].imgUrl}).addClass("rstblock-logo-icon").css({"width":"70","height":"70"})
                div1.append(img);

                var div2 = $("<div>").addClass("rstblock-content");
                var div21 = $("<div>").addClass("rstblock-title").text(result[i].name);
                var div22 = $("<div>").addClass("rstblock-cost").text("起送价格：￥"+result[i].startPrice);
                var div23 = $("<div>").addClass("rstblock-cost").text("配送费：￥"+result[i].distributionFee);
                div2.append(div21).append(div22).append(div23);
                a.append(div1).append(div2);
                $("#panel").append(a);
            }
        }
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
    <%--类别选择--%>
    <div class="container">
        <div class="panel panel-default">
            <div class="panel-body">
                <div class="col-sm-1">
                    <span style="color: gray" id="filter-name">商家分类:</span>
                </div>
                <div class="col-sm-11" id="cate1" style="padding-left: 0px">
                    <%--一级分类--%>
                    <div id="cate11">
                        <a href="javascript:void(0);" id="allStore">全部商家</a>
                    </div>

                    <%--二级分类--%>
                    <div class="panel panel-default" id="cate2">
                        <div class="panel-body" style="padding: 6px 0px" id="cate22">
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <%--商家列表--%>
    <div class="container">
        <div class="panel panel-default">
            <div class="panel-body" style="padding: 0px" id="panel">
                <%--<a href="" class="rstblock" >
                    <div class="rstblock-logo" >
                        <img src="//fuss10.elemecdn.com/b/0e/36095aa428ca1a963ada7e0fa1b4djpeg.jpeg?imageMogr2/thumbnail/140x140/format/webp/quality/85" width="70" height="70" alt="晓寿司(建国门店)" class="rstblock-logo-icon">
                    </div>
                    <div class="rstblock-content">
                        <div class="rstblock-title">晓寿司(建国门店)</div>
                        <div class="rstblock-cost">评分：4.5</div>
                        <div class="rstblock-cost">配送费¥5.5</div>
                    </div>
                </a>--%>
            </div>
        </div>
    </div>

</div>
</body>
</html>