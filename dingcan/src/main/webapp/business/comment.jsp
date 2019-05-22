    <%@page pageEncoding="UTF-8" contentType="text/html; UTF-8" %>
    <%@include file="../basic/basic.jsp"%>
    <!doctype html>
    <html>
    <head>
        <title>本店评论</title>
        <%--引入资源--%>
        <%@include file="../basic/resources.jsp"%>
        <style>
            td a{
                margin-left: 15px;
            }
            .optionBtn{
                padding: 3px 20px;
            }
            #otable td,
            #otable th {
                border-left: none;
                border-right: none;
            }
            #aaa td{
                border: none;
            }
            #aaa .t1{
                width: 65px;
            }
        </style>
        <script>
            $(function () {
                //当浏览器大小变化时
                $(window).resize(function () {
                    $("#albumList").setGridWidth($("#main").width())
                });

                $("#albumList").jqGrid({
                    loadError:function(){   //请求失败时，触发事件
                        window.location.href="${app}/business/login.jsp"
                    },
                    url:"${app}/comment/findByBusiness",
                    colNames:["订单号","用户名","综合分","评论时间","操作"],
                    autowidth:true,
                    styleUI:"Bootstrap",
                    rowNum:5,
                    height:"100%",
                    datatype:"json",
                    viewrecords:true,//是否显示总记录数
                    pager:"#pager",
                    colModel:[
                        {"name":"orderNum"},
                        {"name":"username"},
                        {"name":"average"},
                        {"name":"createDate"},
                        {
                            formatter:function (value, options, row) {
                                var content = "<button class=\"btn btn-danger optionBtn\" onclick=\"showDetail(\'"+row.orderId+"\')\">查看详情</button>"
                                return content;
                            }
                        }
                    ]
                })
            })

            //弹出模态框
            function showDetail(oid) {
                //判断订单是否评论
                $.post("${app}/comment/findByOrder",{"oid":oid},function (result) {
                    $("#kou").text(result.goodsGrade);
                    $("#bao").text(result.packageGrade);
                    $("#pei").text(result.distributeGrade);
                    $("#comment").text(result.content);
                    $("#myModal1").modal("show")
                })
            }


        </script>
    </head>
    <body>

    <div class="Wrapper">
        <%--导航--%>
        <%@include file="businessbasic/nav.jsp" %>
        <div class="container-fluid">
            <div class="row">
                <%--左--%>
                <%@include file="businessbasic/left.jsp" %>
                <%--右--%>
                <div class="col-sm-10" id="main">
                    <div class="page-header" style="margin-top: 0px">
                        <h2 style="margin-top: 0px">本店评论</h2>
                    </div>
                    <ul class="nav nav-tabs">
                        <li class="active"><a href="#">评论列表</a></li>
                    </ul>

                    <%--列表--%>
                    <table id="albumList"></table>
                    <%--分页--%>
                    <div id="pager"></div>
                </div>
            </div>
        </div>

        <%-- 模态框 --%>
        <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content ">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        <h4 class="modal-title" id="myModalLabel">订单详情</h4>
                    </div>
                    <div class="modal-body">
                        <form role="form">
                            <div class="form-group">
                                <label>订单食品</label>
                                <table class="table table-bordered" id="otable">
                                    <thead>
                                    <tr>
                                        <th>食品名</th>
                                        <th>数量</th>
                                        <th>金额</th>
                                    </tr>
                                    </thead>
                                    <tbody id="ttt">

                                    </tbody>
                                </table>
                            </div>

                            <div class="form-group">
                                <label>订单地址</label>
                                <table class="table table-bordered">
                                    </thead>
                                    <tbody id="aaa">
                                        <tr>
                                            <td class="t1">姓名:</td>
                                            <td  id="tname">小黑</td>
                                        </tr>
                                        <tr>
                                            <td class="t1" >手机号:</td>
                                            <td id="tphone">14251542341</td>
                                        </tr>
                                        <tr>
                                            <td class="t1">地址:</td>
                                            <td  id="taddress">郑州市金水区</td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                            <div class="form-group">
                                <label>订单备注</label>
                                <div class="panel panel-default" style="border-radius: 0px">
                                    <div class="panel-body" id="remark">

                                    </div>
                                </div>
                            </div>
                        </form>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal" >关闭</button>
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


        <%--页脚--%>
    <%--<%@include file="../basic/footer.jsp" %>--%>
    </body>
    </html>

    <%--专辑管理 章节管理--%>