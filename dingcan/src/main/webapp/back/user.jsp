<%@page pageEncoding="UTF-8" contentType="text/html; UTF-8" %>
<%@include file="../basic/basic.jsp" %>
<!doctype html>
<html>
<head>
    <title>用户管理</title>
    <%--引入资源--%>
    <%@include file="../basic/resources.jsp" %>
    <style>
        td a {
            margin-left: 15px;
        }
        #imgDiv{
            position: absolute;
            right: 50px;
        }
        .optionBtn{
            padding: 5px 15px;
        }
    </style>
    <script>
        $(function () {
            //当浏览器大小变化时
            $(window).resize(function () {
                $("#albumList").setGridWidth($("#main").width())
            });


            $("#albumList").jqGrid({
                url: "${app}/user/findAll",
                colNames: ["用户名","密码", "手机号","头像路径","注册时间","状态","操作"],
                autowidth: true,
                styleUI: "Bootstrap",
                rowNum: 6,
                height: "100%",
                datatype: "json",
                viewrecords: true,//是否显示总记录数
                pager: "#pager",
                colModel: [
                    {"name": "username"},
                    {"name": "password"},
                    {"name": "phone"},
                    {"name": "imgUrl"},
                    {"name": "register"},
                    {
                        formatter:function (value,options,rows) {
                            if(rows.status == 1){
                                return "正常"
                            }else{
                                return "冻结"
                            }
                        }
                    },
                    {
                        formatter: function (value, options, row) {
                            var content = "<button class=\"btn btn-primary optionBtn\" onclick=\"change(\'"+row.id+"\',\'"+row.status+"\')\">修改状态</button>"
                            return content;
                        }
                    }
                ]
            })
        })
        function change(id,status) {
            $.post("${app}/user/changeStatus",{"id":id,"status":status},function () {
                $("#albumList").trigger("reloadGrid");
            });
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
                    <h2 style="margin-top: 0px">用户管理</h2>
                </div>
                <ul class="nav nav-tabs">
                    <li class="active"><a href="#">用户列表</a></li>
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