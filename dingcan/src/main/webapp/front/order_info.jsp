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
    </style>
    <script>
        $(function () {
            //查询该用户的地址
            $.post("${app}/userAddress/selectByUser",function (result) {
                for(var i = 0;i<result.length;i++){
                    if(result[i].def == 1){
                        
                    }
                }
            })
        })
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
                            <p>张岩 先生 13253356287</p>
                            <p>郑州大学工学院文化路97号 3号楼寝室</p>
                        </div>
                    </div>
                </div>
            </div>
            <a href="" id="otheraddress">选择更多地址</a>

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
                    <tr>
                        <td style="width: 72%;"><a>鹅肝寿司</a></td>
                        <td class="td2">
                            <span class="count1"> 12 </span>
                        </td>
                        <td class="td2">￥33</td>
                    </tr>
                    <tr>
                        <td style="width: 68%;"><a >三明治</a></td>
                        <td class="td2">
                            <span class="count1"> 12 </span>
                        </td>
                        <td class="td2">￥33</td>
                    </tr>
                    <tr class="tfooter">
                        <td class="td2 ftd1" >
                            配送费 <span>￥5</span>
                        </td>
                        <td class="td2" colspan="2">总餐费 <span class="zongqian">￥64</span></td>
                    </tr>
                    </tbody>
                </table>
            </div>

            <div class="form-group">
                <label>订单备注</label>
                <textarea rows="3" class="form-control" placeholder="请输入备注..."></textarea>
            </div>
            <button type="submit" class="btn btn-danger pull-right" style="border-radius: 0;margin-top: 15px">确认下单</button>
        </form>
    </div>
</div>

<div class="FooterPush"></div>
</div>

<%--页脚--%>
</body>
</html>

<%--专辑管理 章节管理--%>