    <%@page pageEncoding="UTF-8" contentType="text/html; UTF-8" %>
    <%@include file="../basic/basic.jsp"%>
    <!doctype html>
    <html>
    <head>
        <title>本店订单管理</title>
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
                    url:"${app}/orderMaster/findByBusinessPage",
                    colNames:["订单号","用户名","创建时间","订单金额","订单状态","操作"],
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
                        {"name":"createDate"},
                        {"name":"orderAmount"},
                        {
                            formatter:function (value, options, row) {
                                if(row.status == 1){
                                    return"正常"
                                }else {
                                    return "删除"
                                }
                            }
                        },
                        {
                            formatter:function (value, options, row) {
                                var content = "<button class=\"btn btn-danger optionBtn\" onclick=\"showDetail(\'"+row.id+"\')\">查看详情</button>"
                                return content;
                            }
                        }
                    ]
                })
            })

            //弹出模态框
            function showDetail(oid) {
                /*查询订单详情*/
                $.post("${app}/orderMaster/findDetail",{"oid":oid},function (result) {
                    console.log(result);
                    var dateils = result.details;
                    var tbody = $("#ttt");
                    tbody.empty();
                    for(var i = 0; i<dateils.length; i++){
                        var td1 = $("<td>").text(dateils[i].goodsName);
                        var td2 = $("<td>").text(dateils[i].goodsCount);
                        var td3 = $("<td>").text(dateils[i].goodsCount*dateils[i].goodsPrice);
                        var tr = $("<tr>").append(td1).append(td2).append(td3);
                        tbody.append(tr)
                    }

                    $("#remark").text(result.master.userRemarks)
                })
                /*查询地址*/
                $.post("${app}/userAddress/findByOrder",{"oid":oid},function (result) {
                    console.log(result);
                    var s = "";
                    if(result.sex == 1){
                        s="先生"
                    }else{
                        s="女士"
                    }
                    $("#tname").text(result.name+s)
                    $("#tphone").text(result.phone)
                    $("#taddress").text(result.address+result.houseNum)
                })
                $("#myModal").modal("show")
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
                        <h2 style="margin-top: 0px">订单管理</h2>
                    </div>
                    <ul class="nav nav-tabs">
                        <li class="active"><a href="#">订单列表</a></li>
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


        <%--页脚--%>
    <%--<%@include file="../basic/footer.jsp" %>--%>
    </body>
    </html>

    <%--专辑管理 章节管理--%>