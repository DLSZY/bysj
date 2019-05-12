<%@page pageEncoding="UTF-8" contentType="text/html; UTF-8" %>
<%@include file="../basic/basic.jsp"%>
<!doctype html>
<html>
<head>
    <title>确认订单</title>
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
            min-height: 350px;
            padding: 20px 18px;
            border-radius: 5px;
        }
        .bode{
            border: 1px solid rgb(19,209,190);
            border-radius: 0px;
            margin-bottom: 5px;
        }
        .addressinfo{
            display: inline-block;
            padding-left: 10px;
            border-left: 1px solid #f5f5f5;
        }
        .addressinfo1{
            display: inline-block;
            padding: 0px 10px;
            width: 100%;
            cursor: pointer;
            padding-top: 10px;
        }
        .addressinfo p{
            margin: 0;
        }
        .l{
            margin-bottom: 10px;
            font-size: 16px;
        }
        #otheraddress{
            display: block;
        }
        .form-group{
            margin-bottom: 0px;
        }
        #otheraddress{
            margin-bottom: 15px;
            color: #8c8c8c;
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

        .count1{
            position: relative;
            top: 2px;
            margin: 0 5px;
        }
        .zongqian{
            color: #f74342;
            font-weight: bold;
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
        .th1{
            padding-left: 35px !important;
        }
        .th2{
            text-align: center;
        }
        .chooseAdd{
            padding: 5px ;
            border-color: rgb(19,209,190);
            background-color: rgb(19,209,190);
        }
        .chooseAdd:hover,
        .chooseAdd:focus,
        .chooseAdd:active{
            background-color: rgb(115,225,206) !important;
            border-color: rgb(115,225,206) !important;
            box-shadow: none;
        }
    </style>
    <script>
        $(function () {
            //查询该用户的地址
            $.post("${app}/userAddress/selectByUser",function (result) {
                console.log(result);
                if(result.length == 0){
                    $("#ap2").hide()
                    $("#ap1").hide()
                    $("#sureOrder").addClass("disabled");
                }else{
                    $("#ap3").hide()
                    for(var i = 0;i<result.length;i++){
                        /*模态框显示所有地址*/
                        var span1 = $("<span>").css({"display":"none"}).text(result[i].id);
                        if(result[i].sex == 1){
                            shenfen = "先生"
                        }else{
                            身份 = "女士"
                        }
                        var pp1 = $("<p>").text(result[i].name +" "+shenfen +" "+ result[i].phone)
                        var pp2 = $("<p>").text(result[i].address +result[i].houseNum);
                        var selectAdd = $("<div>").addClass("addressinfo1 bode").append(span1).append(pp1).append(pp2);
                        $("#alladd").append(selectAdd)
                        /*显示用户默认地址*/
                        if(result[i].def == 1){
                            showAdd(result[i]);
                        }
                    }
                }

            })

            $(".modal-content").on("click",".addressinfo1",function () {
                var id = $(this).find("span").text();
                $.post("${app}/userAddress/selectById",{"id":id},function (result) {
                    showAdd(result);
                    $("#myModal").modal("hide")
                })
            })

            //订单详情显示
            var bid = '${param.bid}';
            $.post("${app}/cart/findByUserAndBuss",{"bid":bid},function (result) {
                console.log(result);
                var thead = $("thead");
                for(var i = 0; i<result.length; i++){
                    var td1  = $("<td>").css({"width":"72%"}).text(result[i].goodsName);
                    var span = $("<span>").addClass("count1").text(result[i].goodsCount);
                    var td2 = $("<td>").addClass("td2").append(span);
                    var price = result[i].goodsCount*result[i].goodsPrice;
                    var td3 = $("<td>").addClass("td2").text("￥"+price);
                    var tr = $("<tr>").append(td1).append(td2).append(td3);
                    thead.append(tr);
                }
            })


            //确认订单
            $("#sureOrder").on("click",function () {
                var addressId = $("#aid").text();
                var userRemarks = $("#remake").val();
                $.post("${app}/orderMaster/add",{"addressId":addressId,"userRemarks":userRemarks,"bid":bid},function (result) {
                    window.location.href="${app}/front/order_success.jsp"
                })
            })
        })
        function showAdd(address) {
            var re = address;
            $("#aid").text(re.id);
            var shenfen = "";
            if(re.sex == 1){
                shenfen = "先生"
            }else{
                身份 = "女士"
            }
            var p1 = re.name +" "+shenfen +" "+ re.phone;
            $("#ap1").text(p1);
            var p2 = re.address +re.houseNum;
            $("#ap2").text(p2);
        }
    </script>
</head>
<body>

<div class="Wrapper">
<%--导航--%>
<%@include file="frontbasic/header.jsp" %>
<div class="container">
    <div class="col-sm-8 col-sm-offset-2" id="main">
        <div class="page-header" style="margin-top: 0px">
            <h3  style="margin-top: 0px">确认订单</h3>
        </div>
        <form role="form">
            <div class="form-group">
                <label class="l">收货地址</label>
                <div class="panel panel-default bode">
                    <div class="panel-body">
                        <i class="glyphicon glyphicon-map-marker" style="font-size: 30px;margin-right: 5px; color: #8c8c8c"></i>
                        <div class="addressinfo">
                            <span style="display: none" id="aid">12321</span>
                            <p id="ap3" style="position: relative;top: -6px"><a href="${app}/front/address.jsp">点击添加地址</a></p>
                            <p id="ap1">张岩 先生 13253356287</p>
                            <p id="ap2">郑州大学工学院文化路97号 3号楼寝室</p>
                        </div>
                    </div>
                </div>
            </div>
            <a id="otheraddress" data-toggle="modal" data-target="#myModal">选择更多地址</a>

            <div class="form-group">
                <label class="l">订单详情</label>
                <table class="table table-bordered">
                    <thead>
                    <tr>
                        <th class="th1">商品</th>
                        <th class="th2">份数</th>
                        <th class="th2">小计</th>
                    </tr>
                    </thead>
                    <tbody>
                    <tr class="tfooter">
                        <td class="td2 ftd1" >
                            配送费 <span>${sessionScope.disfee}</span>
                        </td>
                        <td class="td2" colspan="2">总餐费 <span class="zongqian">￥${sessionScope.allPrice} </span></td>
                    </tr>
                    </tbody>
                </table>
            </div>

            <div class="form-group">
                <label>订单备注</label>
                <textarea rows="3" class="form-control" placeholder="请输入备注..." id="remake"></textarea>
            </div>
            <a class="btn btn-danger pull-right" style="border-radius: 0;margin-top: 15px" id="sureOrder">确认下单</a>
        </form>
    </div>
</div>
    <%--选择地址模态框--%>
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="myModalLabel">选择送餐地址</h4>
            </div>
            <div class="modal-body" id="alladd">
                <%--<div class="addressinfo1 bode">
                    <span style="display: none">12321</span>
                    <p >张岩 先生 13253356287</p>
                    <p >郑州大学工学院文化路97号 3号楼寝室</p>
                </div>--%>
            </div>

        </div><!-- /.modal-content -->
    </div><!-- /.modal -->
</div>


<div class="FooterPush"></div>
</div>

<%--页脚--%>
</body>
</html>

<%--专辑管理 章节管理--%>