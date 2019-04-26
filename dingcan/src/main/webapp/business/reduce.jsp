<%@page pageEncoding="UTF-8" contentType="text/html; UTF-8" %>
<%@include file="../basic/basic.jsp" %>
<!doctype html>
<html>
<head>
    <title>满减信息管理</title>
    <%--引入资源--%>
    <%@include file="../basic/resources.jsp" %>
    <style>
        td a {
            margin-left: 15px;
        }

        .optionBtn {
            padding: 3px 20px;
        }
    </style>
    <script>
        $(function () {
            //当浏览器大小变化时
            $(window).resize(function () {
                $("#albumList").setGridWidth($("#main").width())
            });


            $("#albumList").jqGrid({
                url: "${app}/reduce/findAll",
                colNames: ["所达金额", "所减少金额", "操作"],
                autowidth: true,
                styleUI: "Bootstrap",
                height: "100%",
                datatype: "json",
                viewrecords: true,//是否显示总记录数
                colModel: [
                    {"name": "achieveMoney"},
                    {"name": "reduceMoney"},
                    {
                        formatter: function (value, options, row) {
                            var content = "<button class=\"btn btn-danger optionBtn\" onclick=\"del(\'" + row.id + "\')\">删 除</button>"
                            return content;
                        }
                    }
                ]
            })
        })

        //添加类别
        function addReduce() {
            var achieve = $("#achieve").val();
            var reduce = $("#reduce").val();
            $.post("${app}/reduce/add", {"achieveMoney": achieve,"reduceMoney":reduce}, function () {
                $("#albumList").trigger("reloadGrid");
                $("#myModal").modal("hide");
                $("#codeForm")[0].reset();
            })
        }

        //删除以及类别
        function del(id) {
            var b = window.confirm("确定要删除？");
            if (b == true) {
                $.post("${app}/reduce/delete", {"id": id}, function () {
                    $("#albumList").trigger("reloadGrid");
                })
            }
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
                    <h2 style="margin-top: 0px">满减信息管理</h2>
                </div>
                <ul class="nav nav-tabs">
                    <li class="active"><a href="#">满减列表</a></li>
                    <li><a href="#myModal" data-toggle="modal">类别满减信息</a></li>
                </ul>

                <%--列表--%>
                <table id="albumList"></table>
            </div>
        </div>
    </div>

    <%-- 模态框 --%>
    <div class="modal fade bs-example-modal-sm" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
         aria-hidden="true">
        <div class="modal-dialog modal-sm">
            <div class="modal-content ">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <h4 class="modal-title" id="myModalLabel">添加满减信息</h4>
                </div>
                <div class="modal-body">
                    <form class="form-horizontal" role="form" id="codeForm">
                        <div class="form-group">
                            <div class="col-sm-12">
                                <input type="text" style="height: 40px" class="form-control" id="achieve" name="achieveMoney" placeholder="请输入基础金额">
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="col-sm-12">
                                <input type="text" style="height: 40px" class="form-control" id="reduce" name="reduceMoney" placeholder="请输入减少金额">
                            </div>
                        </div>

                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                    <button type="button" class="btn btn-primary" id="addCate" onclick="addReduce()">添加</button>
                </div>
            </div><!-- /.modal-content -->
        </div><!-- /.modal -->
    </div>


    <%--页脚--%>
    <%--<%@include file="../basic/footer.jsp" %>--%>
</body>
</html>

<%--专辑管理 章节管理--%>