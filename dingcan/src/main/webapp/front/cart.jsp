<%@page pageEncoding="UTF-8" contentType="text/html; UTF-8" %>
<%@include file="../basic/basic.jsp" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>我的购物车</title>
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
            border-right: 0!important;
            border-left: 0!important;
        }
        .td2{
            text-align: center;

        }
        .count{
            font-size: 16px;
            font-weight: bold;
            line-height: 10px;
            border-radius: 50%;
        }
        .addCount,
        .suan{
            padding: 5px ;
            border-color: rgb(19,209,190);
            background-color: rgb(19,209,190);
        }
        .suan{
            padding: 5px 10px;
        }
        .delCount{
            line-height: 9px;
            padding: 5px 7px;
            color: rgb(19,209,190);
            border-color:rgb(19,209,190);
            background-color: white;
        }
        .suan:hover,
        .suan:focus,
        .suan:active,
        .addCount:hover,
        .addCount:focus,
        .addCount:active{
            background-color: rgb(115,225,206) !important;
            border-color: rgb(115,225,206) !important;
            box-shadow: none;
        }
        .delCount:hover,
        .delCount:focus,
        .delCount:active{
            background-color: #f8f8f8 !important;
            border-color: rgb(115,225,206) !important;
            box-shadow: none;
            color: rgb(19,209,190);
        }
        h5{
            font-size: 1.2em;
            cursor: pointer;
        }
        .count1{
            position: relative;
            top: 2px;
            margin: 0 5px;
        }
        .zongqian{
            color: #f74342;
            font-weight: bold;
        }
        .countSpan{
            padding: 0 5px;
        }
        .jian{
            padding-top: 10px;
            font-weight: normal;
            font-size: 12px;
            text-align: center;
        }
        .jian span{
            color: rgb(19,209,190);
            line-height: 34px;
            height: 55px;
            border: 1px solid rgb(19,209,190);
            padding: 2px 3px;
            border-radius: 2px;
            margin-left: 10px;
        }
        .ftd1{
            text-align: left;
        }
        .ftd1 span{
            font-weight: bold;
            color: #f74342;
        }
        .qs1{
            margin-left: 10px;
            font-size: 13px;
        }
        .qs1 span{
            color: #f74342;
        }
        .fname:hover{
            text-decoration: none;
            color: #337ab7;;
        }
        #isEmpty{
            background-color: white;
            text-align: center;
            padding-top: 10px;
            padding-bottom:10px;
        }

    </style>
    <script>
        $(function () {
            getCart()
            //点击添加数量按钮
            $("#list").on("click",".addc",function () {
                //购物车商品数量
                var cspan = $(this).prev();
                var count = cspan.text()-1+2
                cspan.text(count);

                //此食品总数的价格
                var pspan = $(this).parent().prev().children();
                var price = pspan.text();
                var oneprice = price / (count-1);
                pspan.text(oneprice*count)


                var tbody = $(this).parent().parent().parent();
                var table = tbody.parent();
                var aspan = tbody.find(".aspan");
                var pspans = tbody.find(".pspan");

                //计算总价格
                var allPrice = 0;
                for(var i = 0; i<pspans.length;i++){
                    allPrice =  (allPrice-1+1) + ($(pspans[i]).text()-1+1);
                }

                var js = table.find(".jian").children();
                var jians = new Array()
                for(var i = 0; i<js.length; i++){
                    var ts = $(js[i]).text();
                    var s = ts.split("减");
                    jians[i]=s;
                }

                var shao = 0 ;      //计算满减钱数
                for(var z = 0; z<jians.length; z++){
                    var da = jians[z][0];
                    var jian = jians[z][1];
                    if(allPrice>=da){
                        jian = parseInt(jian)
                        shao = parseInt(shao)
                        if(jian > shao){
                            shao = jian;
                        }
                    }
                }
                //减去满减
                var allPrice1 = allPrice;
                allPrice-=shao;

                //加上配送费
                var find = table.find(".fee");
                var fee = find.text()-1+1;
                allPrice+=fee;

                aspan.text(allPrice);

        //判断是否到起送金额
                var suan = table.find(".suan");
                console.log(suan);
                var startPrice = table.find(".qspan2").text();
                var businessId = table.find("h5").attr("id");
                console.log(allPrice1);
                console.log(startPrice);
                if(allPrice1 < startPrice){
                    var cha = startPrice - allPrice1;
                    suan.text("还差"+cha+"起送").attr({"href":"javascript:void(0)","disabled":true});
                }else{
                    suan.text("去结算").attr({"href":"javascript:order('"+businessId+"')","disabled":false});
                }

                //修改数据库
                addCount(this.id)
            })

            //点击减少按钮
            $("#list").on("click",".reducec",function () {
                var tr = $(this).parent().parent();
                var tbody = tr.parent();
                var table = tbody.parent();
                var cspan = $(this).next();
                var count = cspan.text()-1
                if(count != 0){         //当数量不为0时数量减1

                }else{
                    tr.remove()
                    if(tbody.children().length == 1){
                        tbody.parent().remove();
                    }
                }
                //购物车商品数量
                cspan.text(count);

                //此食品总数的价格
                var pspan = $(this).parent().prev().children();
                var price = pspan.text();
                var oneprice = price / (count+1);
                pspan.text(oneprice*count)

                var aspan = tbody.find(".aspan");
                var pspans = tbody.find(".pspan");

                //计算总价格
                var allPrice = 0;
                for(var i = 0; i<pspans.length;i++){
                    allPrice =  (allPrice-1+1) + ($(pspans[i]).text()-1+1);
                }

                //获取满减信息
                var js = table.find(".jian").children();
                var jians = new Array()
                for(var i = 0; i<js.length; i++){
                    var ts = $(js[i]).text();
                    var s = ts.split("减");
                    jians[i]=s;
                }

                //计算满减钱数
                var shao = 0 ;
                for(var z = 0; z<jians.length; z++){
                    var da = jians[z][0];
                    var jian = jians[z][1];
                    if(allPrice>=da){
                        jian = parseInt(jian)
                        shao = parseInt(shao)
                        if(jian > shao){
                            shao = jian;
                        }
                    }
                }
                var allPrice1 = allPrice;
                allPrice-=shao; //减去满减

                //加上配送费
                var find = table.find(".fee");
                var fee = find.text()-1+1;
                allPrice+=fee;

                aspan.text(allPrice);
            //判断是否到起送金额
                var suan = table.find(".suan");
                console.log(suan);
                var startPrice = table.find(".qspan2").text();
                var businessId = table.find("h5").attr("id");
                console.log(allPrice1);
                console.log(startPrice);
                if(allPrice1 < startPrice){
                    var cha = startPrice - allPrice1;
                    suan.text("还差"+cha+"起送").attr({"href":"javascript:void(0)","disabled":true});
                }else{
                    suan.text("去结算").attr({"href":"javascript:order('"+businessId+"')","disabled":false});
                }

                //修改数据库
                reduceCount(this.id)
            })

            //点击跳转到商家
            $("#list").on("click","h5",function () {
                window.location.href="${app}/front/busuness.jsp?bid="+this.id;
            })
        })

        //数量加一
        function addCount(cid) {
            $.post("${app}/cart/editCount",{"cid":cid,"option":"add"});
        }
        //数量减一
        function reduceCount(cid) {
            $.post("${app}/cart/editCount",{"cid":cid,"option":"reduce"});
        }

        //获取当前用户的购物车
        function getCart() {
            $.post("${app}/cart/findByUser",function (result) {
                console.log(result);
                if(result == ""){
                    window.location.href="${app}/front/login.jsp"
                }
                var isEmpty = result[0].businessId;
                console.log(isEmpty);

                //判断当前用户购物车中是否有食品
                if(isEmpty != null){
                    $("#isEmpty").hide();
                    for(var i = 0; i<result.length; i++){
                        //thead 1
                        var qspan1 = $("<span>").text("￥");
                        var qspan2 = $("<span>").text(result[i].startPrice).addClass("qspan2");
                        var qspan = $("<span>").addClass("qs1").text("起送").append(qspan1).append(qspan2);
                        var h5 = $("<h5>").css({"font-size":"1.2em"}).text(result[i].businessName).attr({"id":result[i].businessId}).append(qspan);
                        //var th1 = $("<th>").attr({"colspan":"2"}).append(h5).css({"width":"60%"});
                        var th1 = $("<th>").append(h5);

                        //tbody 购物车项
                        var allPrice = 0;
                        var tbody = $("<tbody>");
                        var items = result[i].items;
                        for(var j = 0; j<items.length; j++){
                            var item = items[j];
                            var aname = $("<a>").text(item.goodsName).addClass("fname");
                            var td1 = $("<td>").css({"width":"72%"}).append(aname);
                            //var td2 = $("<td>").text("x"+item.goodsCount);
                            var price = item.goodsPrice*item.goodsCount;
                            allPrice+=price;
                            var pspan = $("<span>").text(price).addClass("pspan");
                            var td3 = $("<td>").text("￥").addClass("td2").append(pspan);
                            var ajian = $("<a>").addClass("btn btn-primary delCount count reducec").text("-").attr({"id":item.id});
                            var ajia = $("<a>").addClass("btn btn-primary addCount count addc").text("+").attr({"id":item.id});
                            var countSpan = $("<span>").addClass("count1").text(item.goodsCount).addClass("countSpan");
                            var td4 = $("<td>").append(ajian).append(countSpan).append(ajia).addClass("td2");
                            var tr2 = $("<tr>").append(td1).append(td3).append(td4);
                            tbody.append(tr2);
                        }

                        //计算满减信息
                        var th2 = $("<th>").addClass("jian").attr({"colspan":"2"});
                        var shao = 0 ;      //计算满减钱数
                        var reduces = result[i].reduces;
                        for(var z = 0; z<reduces.length; z++){
                            var da = reduces[z].achieveMoney;
                            var jian = reduces[z].reduceMoney;
                            var span = $("<span>").text(da+"减"+jian)

                            if(allPrice>=da){
                                if(jian > shao){
                                    shao = jian;
                                }
                            }
                            th2.append(span)
                        }

                        //脚
                        var span12 = $("<span>").text("￥");
                        var dfee = result[i].distributeFee;
                        var span11 = $("<span>").text(dfee).addClass("fee");
                        var ftd1 = $("<td>").addClass("td2 ftd1").text("配送费").append(span12).append(span11);

                        var allPrice1 = allPrice;
                        allPrice-=shao; //减去满减
                        allPrice+=dfee//加上配送费
                        var aspan = $("<span>").text(allPrice).addClass("aspan");
                        var ftd3 = $("<td>").addClass("td2 zongqian").text("￥").append(aspan);
                        //var suana = $("<a>").addClass("btn btn-primary suan").text("去结算").attr({"href":"${app}/front/order_info.jsp?bid="+result[i].businessId});
                        var startPrice = result[i].startPrice;
                        var suana;
                        if(allPrice1 < startPrice){
                            var cha = startPrice - allPrice1;
                            suana = $("<a>").addClass("btn btn-primary suan").text("还差"+cha+"起送").attr({"href":"javascript:void(0)","disabled":true});
                        }else{
                            suana = $("<a>").addClass("btn btn-primary suan").text("去结算").attr({"href":"javascript:order('"+result[i].businessId+"')"});
                        }
                        var ftd4 = $("<td>").addClass("td2").append(suana)

                        var tr1 = $("<tr>").append(th1).append(th2);
                        var thead = $("<thead>").append(tr1);
                        var foot = $("<tr>").addClass("tfooter").append(ftd1).append(ftd3).append(ftd4);
                        var table = $("<table>").addClass("table table-bordered").append(thead).append(tbody).append(foot);
                        var list = $("#list").append(table);
                    }
                }else{
                    $("#isEmpty").show();
                }
            })
        }

        function order(bid) {
            var allPrice = $("#"+bid).parent().parent().parent().parent().find(".aspan").text();
            var disfee = $("#"+bid).parent().parent().parent().parent().find(".fee").text();
            $.post("${app}/cart/allPrice",{"allPrice":allPrice,"disfee":disfee},function () {
                window.location="${app}/front/order_info.jsp?bid="+bid;
            })
        }
    </script>
</head>
<body>
<%--header--%>
<%@include file="frontbasic/header.jsp" %>

<div id="main" style="margin-top: 30px">
    <%--搜索列表--%>
    <div class="container" id="list">

        <div class="col-sm-6 col-sm-offset-3" id="isEmpty">
            <div class="page-header" style="margin-top: 0px">
                <h3>您的购物车为空</h3>
            </div>
            <div class="hint">
                <p class="text-muted"><a href="${app}/front/index.jsp">浏览并选购商品</a></p>
            </div>
        </div>
       <%--<table class="table table-bordered">
            <thead>
            <tr>
                <th colspan="2">
                    <h5 style="font-size: 1.2em;">晓寿司(建国门店) <span class="qs1"> 起送:<span>￥</span><span>34</span> </span></h5>
                </th>
                <th class="jian">
                   <span>40减5</span>
                   <span>50减10</span>
                   <span>50减10</span>
                </th>
            </tr>
            </thead>
            <tbody>
                <tr>
                    <td style="width: 72%;"><a>鹅肝寿司</a></td>
                    <td class="td2">￥33</td>
                    <td class="td2">
                        <a class="btn btn-primary delCount count">-</a>
                        <span class="count1"> 12 </span>
                        <a class="btn btn-primary addCount count">+</a>
                    </td>
                </tr>
                <tr>
                    <td style="width: 68%;"><a >三明治</a></td>
                    <td class="td2">￥33</td>
                    <td class="td2">
                        <a class="btn btn-primary delCount count">-</a>
                        <span class="count1"> 12 </span>
                        <a class="btn btn-primary addCount count">+</a>
                    </td>
                </tr>
                <tr class="tfooter">
                    <td class="td2 ftd1" >
                        配送费 <span>￥5</span>
                    </td>
                    <td class="td2 zongqian">￥64</td>
                    <td class="td2">
                        <a href="" class="btn btn-primary suan">去结算</a>
                    </td>
                </tr>
            </tbody>
        </table>--%>
    </div>
</div>
</body>
</html>