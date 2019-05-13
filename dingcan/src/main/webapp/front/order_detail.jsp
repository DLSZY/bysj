<%@page pageEncoding="UTF-8" contentType="text/html; UTF-8" %>
<%@include file="../basic/basic.jsp" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>订单详情</title>
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

        .panel{
            border-radius: 0px;
        }

        .ttt tr td{
            border: none !important;
            text-align: center !important;

        }

        .ttt tr .td1{
            width: 40% !important;
            text-align: left !important;
        }
        .ltr{
            border-top: 1px solid #eee;
        }
        .ttt tr .rtd{
            text-align: right !important;
        }
        .ftd{
            font-size: 12px;
        }
        .tow{
            font-size: 12px;
        }
        .btn-primary{
            background-color: rgb(19,209,190);
            border-color: rgb(19,209,190);
        }
        .btn-primary:hover,
        .btn-primary:active{
            background-color: rgb(115,225,206) !important;
            border-color: rgb(115,225,206) !important;
        }

    </style>
    <script>
        $(function () {
            var oid = '${param.oid}'
            init(oid)

            /*查询地址*/
            $.post("${app}/userAddress/findByOrder",{"oid":oid},function (result) {
                var s = "";
                if(result.sex == 1){
                    s="先生"
                }else{
                    s="女士"
                }
                $("#uname").text(result.name+"("+s+")")
                $("#uphone").text(result.phone)
                $("#uaddr").text(result.address+result.houseNum)
            })
            $("#del").on("click",function () {
                var b = window.confirm("是否要删除此订单");
                if(b){
                    $.post("${app}/orderMaster/del",{"oid":oid},function (result) {
                        alert("删除成功")
                        window.location.href="${app}/front/order.jsp"
                    })
                }
            })
            $("#addComment").on("click",function () {
                $.post("${app}/comment/add",$("#info").serialize(),function (result) {
                    $("#myModal").modal("hide");
                    init(result)
                })
            })
        })
        
        function init(oid) {
            //判断订单是否评论
            $.post("${app}/comment/findByOrder",{"oid":oid},function (result) {
                console.log(result);
                if(result == ""){
                    $("#op").show()
                    $("#p").hide()
                }else{
                    $("#p").show()
                    $("#op").hide()
                    $("#kou").text(result.goodsGrade);
                    $("#bao").text(result.packageGrade);
                    $("#pei").text(result.distributeGrade);
                    $("#comment").text(result.content);
                }
            })

            //查询信息
            $.post("${app}/orderMaster/findDetail",{"oid":oid},function (result) {
                console.log(result);
                //订单详情
                var business = result.business;
                var details = result.details;
                var master = result.master;


                $("#bid").val(business.id);
                var allPrice = 0;
                $("#bname").text(business.name);
                for(var i = 0; i<details.length; i++){
                    var detail = details[i];
                    var td1 = $("<td>").addClass("td1").text(detail.goodsName);
                    var span1 = $("<span>").addClass("two").text("x");
                    var span2 = $("<span>").text(detail.goodsCount);
                    var td2 = $("<td>").append(span1).append(span2);
                    var td3 = $("<td>").text("￥"+detail.goodsPrice).addClass("rtd");
                    var tr = $("<tr>").append(td1).append(td2).append(td3).addClass("iii");
                    $("#foot").before(tr);
                    allPrice = (allPrice-1+1) + (detail.goodsCount*detail.goodsPrice-1+1);
                }
                $("#allPrice").text("￥"+master.orderAmount);
                $("#posifee").text(business.distributionFee);

                $("#jian").text(-(master.orderAmount-allPrice-business.distributionFee).toFixed(0));

                //订单信息
                $("#onum").text(master.orderNum);
                $("#odate").text(master.createDate);
                $("#oid").val(master.id);

            })
        }

    </script>
</head>
<body>
<%--header--%>
<%@include file="frontbasic/header.jsp" %>

<div id="main" style="margin-top: 30px">
    <div class="container" id="list" style="width: 800px">
        <div class="panel panel-default">
            <div class="panel-body">
                <div class="page-header" style="margin-top: 0px;margin-bottom: 10px">
                    <h4 style="margin-top: 0px" id="bname">上师店铺</h4>
                </div>
                <table class="table" class="otable" style="margin: 0px">
                    <tbody class="ttt" id="t1">
                       <%-- <tr>
                            <td class="td1">汉堡</td>
                            <td><span class="tow">x</span><span>1</span> </td>
                            <td class="rtd">￥32</td>
                        </tr>
                        <tr class="ltr">
                            <td class="td1">汉堡</td>
                            <td><span class="tow">x</span>1</td>
                            <td class="rtd">￥32</td>
                        </tr>
                --%>
                    <tr id="foot" class="ltr">
                        <td class="td1 ftd">
                            配送费 <span style="font-size: 10px">￥</span> <span id="posifee">23</span><br>
                            满减 <span style="font-size: 10px">￥</span> <span id="jian">123</span>
                        </td>
                        <td></td>
                        <td class="rtd" style="color: #f74342;font-weight: bold" id="allPrice">￥124</td>
                    </tr>
                    </tbody>
                </table>
            </div>
        </div>

        <div class="panel panel-default">
            <div class="panel-body">
                <div class="page-header" style="margin-top: 0px;margin-bottom: 10px">
                    <h4 style="margin-top: 0px">配送信息</h4>
                </div>
                <table class="table" id="atable" style="margin: 0px">
                   <tbody class="ttt">
                       <tr>
                           <td class="td1" colspan="2">姓名</td>
                           <td class="rtd" id="uname">小黑</td>
                       </tr>
                       <tr>
                           <td class="td1" colspan="2">手机</td>
                           <td class="rtd" id="uphone">14525323425</td>
                       </tr>
                       <tr>
                           <td class="td1" colspan="2">地址</td>
                           <td class="rtd" id="uaddr">郑州市金水区郑州市金水区</td>
                       </tr>
                   </tbody>
                </table>
            </div>
        </div>
        <div class="panel panel-default">
            <div class="panel-body">
                <div class="page-header" style="margin-top: 0px;margin-bottom: 10px">
                    <h4 style="margin-top: 0px" class="oid">订单信息</h4>
                </div>
                <table class="table"  style="margin: 0px">
                   <tbody class="ttt">
                       <tr>
                           <td class="td1" colspan="2">订单号</td>
                           <td class="rtd" id="onum">1231412312</td>
                       </tr>
                       <tr>
                           <td class="td1" colspan="2">下单日期</td>
                           <td class="rtd" id="odate">2015-12-12 12:12:12</td>
                       </tr>
                   </tbody>
                </table>
            </div>
        </div>
        <div class="panel panel-default">
            <div class="panel-body">
                <table class="table"  style="margin: 0px">
                   <tbody class="ttt">
                       <tr>
                           <td id="op"><a class="btn btn-primary pull-left" data-toggle="modal" data-target="#myModal">评 价</a> </td>
                           <td id="p"><a class="btn btn-primary pull-left" data-toggle="modal" data-target="#myModal1">查看评价</a> </td>
                           <td><a class="btn btn-danger pull-right" id="del">删除订单</a> </td>
                       </tr>
                   </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<%--添加评价模态框--%>
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="myModalLabel">编写评价</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal" id="info">
                    <div class="form-group">
                        <input type="text" name="businessId" hidden id="bid" >
                        <input type="text" name="orderId" hidden id="oid">
                        <label class="col-sm-12">评分</label>
                        <div class="col-sm-4">
                            <select class="form-control" name="goodsGrade">
                                <option selected disabled>口味</option>
                                <option>1</option>
                                <option>2</option>
                                <option>3</option>
                                <option>4</option>
                                <option>5</option>
                            </select>
                        </div>
                        <div class="col-sm-4">
                            <select class="form-control"name="packageGrade">
                                <option selected disabled>包装</option>
                                <option>1</option>
                                <option>2</option>
                                <option>3</option>
                                <option>4</option>
                                <option>5</option>
                            </select>
                        </div>
                        <div class="col-sm-4">
                            <select class="form-control" name="distributeGrade" >
                                <option selected disabled>配送</option>
                                <option>1</option>
                                <option>2</option>
                                <option>3</option>
                                <option>4</option>
                                <option>5</option>
                            </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-12">评价</label>
                        <div class="col-sm-12">
                            <textarea rows="3" class="form-control" placeholder="编写您对此订单的评价..." name="content"></textarea>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="addComment">确定</button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal -->
</div>
<%--查看评价--%>
<div class="modal fade" id="myModal1" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title">查看评价</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <div class="col-sm-4">
                            <label>口味:</label> <span id="kou">1</span>分
                        </div>
                        <div class="col-sm-4">
                            <label>包装:</label> <span id="bao">1</span>分
                        </div>
                        <div class="col-sm-4">
                            <label>配送:</label> <span id="pei">1</span>分
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-12">评价</label>
                        <div class="col-sm-12">
                            <div class="panel panel-default">
                                <div class="panel-body" id="comment">
                                    Basic panel example
                                </div>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal -->
</div>
</body>
</html>