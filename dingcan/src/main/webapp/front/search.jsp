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
            color: rgb(19,209,190);
        }
        #searchinput:focus{
            box-shadow: none;
        }
        #searchUl{
            min-width: 50px;
        }
        table{
            background-color: white;
        }
        th,td{
            border-right: 0px !important;
            border-left: 0px !important;
        }
        td{
            border-top: 1px solid #f5f5f5!important;
            padding: 18px 14px!important;
            border: 0!important;
            border-top: 1px solid #f5f5f5!important;
        }
        th{
            padding: .5em 1em !important;
            border: 1px solid #ddd!important;
            background: #f9f9f9!important;
            border-bottom-width: 1px !important;
        }
        .td2{
            text-align: center;

        }
        .addCart{
            font-size: 14px;
            border-color: rgb(19,209,190);
            padding: 7px 15px;
            background-color: rgb(19,209,190);
            line-height: 10px;
        }
        .addCart:hover,
        .addCart:focus,
        .addCart:active{
            background-color: rgb(115,225,206) !important;
            border-color: rgb(115,225,206) !important;
            box-shadow: none;
        }
        h5{
            font-size: 1.2em;
        }
        .active a{
            background-color: rgb(115,225,206) !important;
        }
        .aname{
            color: #333;
        }
        .aname:hover{
            text-decoration: none;
            color: #333;
        }
        #alert{
            position: fixed;
            width: 350px;
            left: 560px;
            top: 80px;
            z-index: 10;
            padding: 20px 30px;
        }
    </style>
    <script>
        $(function () {

            $("#alert").hide()

            var item = "${param.item}"
            var cate = "${param.cate}"
            $.post("${app}/business/findBySearch",{"item":item,"cate":cate},function (result) {
                console.log(result);
                for(var i = 0; i<result.length; i++){
                    var aname = $("<a>").text(result[i].name).attr({"href":"${app}/front/busuness.jsp?bid="+result[i].id}).addClass("aname");
                    var h5 = $("<h5>").append(aname);
                    var th = $("<th>").attr({"colspan":"4"}).append(h5);
                    var tr1 = $("<tr>").append(th);
                    var thead = $("<thead>").append(tr1);
                    var tbody = $("<tbody>");
                    var goodss = result[i].goodss;
                    var l = 3;              //搜索时显示商家食品的个数
                    if(goodss.length < 3){
                        l = goodss.length
                    }
                    for(var j = 0; j<l; j++){
                        console.log(goodss[j]);
                        var td1 = $("<td>").css({"width":"68%"}).text(goodss[j].name);
                        var td2 = $("<td>").addClass("td2").text("￥"+goodss[j].price);
                        var a = $("<a>").addClass("btn btn-primary addCart").text("添加购物车").attr({"href":"javascript:addCart('"+goodss[j].id+"','"+result[i].id+"','"+goodss[j].name+"')"});
                        var td3 = $("<td>").addClass("td2").append(a);
                        var td4 = $("<td>").text("月售"+goodss [j].saleCount+"份");
                        var tr2 = $("<tr>").append(td1).append(td2).append(td3).append(td4);
                        tbody.append(tr2);
                    }

                    var table = $("<table>").addClass("table table-bordered").append(thead).append(tbody);
                    $("#list").append(table);
                }
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

        //加入购物车
        function addCart(goodsId,businessId,goodsName) {
            $.post("${app}/cart/add",{"goodsId":goodsId,"businessId":businessId,"goodsName":goodsName})
            $("#alert").show(500).delay(300).hide(500);
        }
    </script>
</head>
<body>
<%--header--%>
<%@include file="frontbasic/header.jsp" %>

<div class="alert alert-success" id="alert">
    添加购物车成功~~
</div>

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
    <div class="container" id="list">
        <%--<table class="table table-bordered">
            <thead>
            <tr>
                <th colspan="4">
                    <h5 style="font-size: 1.2em;">村上一屋日料寿司(五道口店)</h5>
                </th>
            </tr>
            </thead>
            <tbody>
            <tr>
                <td style="width: 68%;"><a id="goodsName">鹅肝寿司</a></td>
                <td class="td2">￥33</td>
                <td class="td2"><a class="btn btn-primary addCart">添加购物车</a></td>
                <td>月售332份</td>
            </tr>
            </tbody>
        </table>--%>
    </div>
</div>
</body>
</html>