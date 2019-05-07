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
        }
        .count1{
            position: relative;
            top: 2px;
            margin: 0 5px;
        }
        .zongqian{
            color: #f74342;
        }

    </style>
    <script>
        $(function () {


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
                <th colspan="4">
                    <h5 style="font-size: 1.2em;">晓寿司(建国门店)</h5>
                </th>
               <%-- <th>
                    123
                </th>--%>
            </tr>
            </thead>
            <tbody>
                <tr>
                    <td style="width: 68%;"><a id="goodsName">鹅肝寿司</a></td>
                    <td>x1</td>
                    <td class="td2">￥33</td>
                    <td class="td2">
                        <a class="btn btn-primary delCount count">-</a>
                        <span class="count1"> 12 </span>
                        <a class="btn btn-primary addCount count">+</a>
                    </td>
                </tr>
                <tr>
                    <td style="width: 68%;"><a >三明治</a></td>
                    <td>x1</td>
                    <td class="td2">￥33</td>
                    <td class="td2">
                        <a class="btn btn-primary delCount count">-</a>
                        <span class="count1"> 12 </span>
                        <a class="btn btn-primary addCount count">+</a>
                    </td>
                </tr>
                <tr class="tfooter">
                    <td class="td2"></td>
                    <td class="td2"></td>
                    <td class="td2 zongqian">￥64</td>
                    <td class="td2">
                        <a href="" class="btn btn-primary suan">去结算</a>
                    </td>
                </tr>
            </tbody>
        </table>
    </div>
</div>
</body>
</html>