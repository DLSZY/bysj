<%@page pageEncoding="UTF-8" contentType="text/html; UTF-8" %>
<%@include file="../basic/basic.jsp" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>我的订单</title>
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
        tbody tr{
            cursor: pointer;
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
        .tdtext{
            text-overflow: ellipsis;
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
            width: 500px;
            margin: 0px;
            position: absolute;
        }
        h5{
            font-size: 1.2em;
        }
        .pricolor{
           color: #337ab7;;
            width: 28%;
        }
        .ltd{
            width: 20%;
        }

    </style>
    <script>
        $(function () {
            $.post("${app}/orderMaster/findByUser",function (result) {
                console.log(result);
                for(var i = 0; i<result.length; i++){
                    var order = result[i];
                    if(order.status == 1){
                        var td1 = $("<td>").addClass("pricolor").text(order.businessName);
                        var text = "";
                        for(var j=0; j<order.orderdetails.length;j++){
                            var detail = order.orderdetails[j];
                            if(j == order.orderdetails.length-1){
                                text += detail.goodsName
                            }else {
                                text += detail.goodsName+"+"
                            }
                        }
                        var div1 = $("<div>").addClass("tdtext").text(text)
                        var td2 = $("<td>").addClass("td2").append(div1);
                        var td3 = $("<td>").addClass("td2 ltd").text("￥"+order.orderAmount);
                        var tr = $("<tr>").append(td1).append(td2).append(td3).attr({"id":order.id});

                        if(order.isComment == 0){
                            $("#tbody1").append(tr);
                        }else{
                            $("#tbody").append(tr);
                        }
                    }
                }
            })
            $("#tbody").on("click","tr",function () {
                window.location.href="${app}/front/order_detail.jsp?oid="+this.id
            })
            $("#tbody1").on("click","tr",function () {
                window.location.href="${app}/front/order_detail.jsp?oid="+this.id
            })
        })



    </script>
</head>
<body>
<%--header--%>
<%@include file="frontbasic/header.jsp" %>

<div id="main" style="margin-top: 30px">
    <%--搜索列表--%>
    <div class="container" id="list">
        <table class="table table-bordered">
            <thead>
            <tr>
                <th colspan="3">
                    <h5 style="font-size: 1.2em;">已评价</h5>
                </th>
            </tr>
            </thead>
            <tbody id="tbody">
              <%--  <tr>
                    <td class="pricolor">鹅肝寿司鹅肝寿司鹅肝寿司鹅肝寿司鹅肝寿司</td>
                    <td class="td2">鹅肝寿司+三明治</td>
                    <td class="td2">￥33</td>

                </tr>--%>
                <%--<tr>
                    <td class="pricolor">鹅肝寿司</td>
                    <td class="td2">
                        <div class="tdtext">
                            鹅肝寿司+三明治鹅肝寿司+三明治鹅肝寿司+三明治鹅肝寿司+三明治鹅肝寿司+三明治鹅肝寿司+三明治
                        </div>
                    </td>
                    <td class="td2 ltd">￥33</td>
                </tr>--%>

            </tbody>
        </table>
        <table class="table table-bordered">
            <thead>
            <tr>
                <th colspan="3">
                    <h5 style="font-size: 1.2em;">未评价</h5>
                </th>
            </tr>
            </thead>
            <tbody id="tbody1">
            <%--  <tr>
                  <td class="pricolor">鹅肝寿司鹅肝寿司鹅肝寿司鹅肝寿司鹅肝寿司</td>
                  <td class="td2">鹅肝寿司+三明治</td>
                  <td class="td2">￥33</td>

              </tr>--%>
            <%--<tr>
                <td class="pricolor">鹅肝寿司</td>
                <td class="td2">
                    <div class="tdtext">
                        鹅肝寿司+三明治鹅肝寿司+三明治鹅肝寿司+三明治鹅肝寿司+三明治鹅肝寿司+三明治鹅肝寿司+三明治
                    </div>
                </td>
                <td class="td2 ltd">￥33</td>
            </tr>--%>

            </tbody>
        </table>
    </div>
</div>
</body>
</html>