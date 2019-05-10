    <%@page pageEncoding="UTF-8" contentType="text/html; UTF-8" %>
    <%@include file="../basic/basic.jsp"%>
    <!doctype html>
    <html>
    <head>
        <title>商家管理</title>
        <%--引入资源--%>
        <%@include file="../basic/resources.jsp"%>
        <style>
            td a{
                margin-left: 15px;
            }
            .optionBtn{
                padding: 3px 6px;
            }
        </style>
        <script>
            $(function () {
                //当浏览器大小变化时
                $(window).resize(function () {
                    $("#albumList").setGridWidth($("#main").width())
                });

                $("#albumList").jqGrid({
                    url:"${app}/business/findBusiness",
                    colNames:["用户名","密码","店铺名","省份编号","城市编号","区县编号","详细地址","手机号","注册时间","图标路径","状态","操作"],
                    autowidth:true,
                    styleUI:"Bootstrap",
                    rowNum:5,
                    height:"100%",
                    datatype:"json",
                    viewrecords:true,//是否显示总记录数
                    pager:"#pager",
                    colModel:[
                        {"name":"username"},
                        {"name":"password"},
                        {"name":"name"},
                        {"name":"provinceCode"},
                        {"name":"cityCode"},
                        {"name":"areaCode"},
                        {"name":"address"},
                        {"name":"phone"},
                        {"name":"registerTime"},
                        {"name":"imgUrl"},
                        {"name":"status",
                            formatter:function (value,option,row) {
                                if(row.status == 0) return "冻结";
                                else return "正常";
                            }
                        },
                        {
                            formatter:function (value, options, row) {
                                var content = "<button class=\"btn btn-danger optionBtn\" onclick=\"change(\'"+row.id+"\',\'"+row.status+"\')\">修改状态</button>"
                                return content;
                            }
                        }
                    ]
                })
            })
            function change(id,status) {
                $.post("${app}/business/changeStatus",{"id":id,"status":status},function (result) {
                    $("#albumList").trigger("reloadGrid");
                })
            }
        </script>
    </head>
    <body>

    <div class="Wrapper">
        <%--导航--%>
        <%@include file="backbasic/nav.jsp" %>
        <div class="container-fluid">
            <div class="row">
                <%--左--%>
                <%@include file="backbasic/left.jsp" %>
                <%--右--%>
                <div class="col-sm-10" id="main">
                    <div class="page-header" style="margin-top: 0px">
                        <h2  style="margin-top: 0px">商家管理</h2>
                    </div>
                    <ul class="nav nav-tabs">
                        <li class="active"><a href="#">商家列表</a></li>
                    </ul>

                    <%--列表--%>
                    <table id="albumList"></table>
                    <%--分页--%>
                    <div id="pager"></div>
                </div>
            </div>
        </div>


    <%--页脚--%>
    <%--<%@include file="../basic/footer.jsp" %>--%>
    </body>
    </html>

    <%--专辑管理 章节管理--%>