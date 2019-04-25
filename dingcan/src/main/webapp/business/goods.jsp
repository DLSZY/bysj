<%@page pageEncoding="UTF-8" contentType="text/html; UTF-8" %>
<%@include file="../basic/basic.jsp" %>
<!doctype html>
<html>
<head>
    <title>本店食品管理</title>
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

            //文件上传
            $("#addBtn").on("click",function () {
                var formData = new FormData($("#fileForm")[0]);
                $.ajax({
                    url:"${app}/goods/add",
                    type:"POST",
                    data:formData,
                    processData: false,  // 告诉jQuery不要去处理发送的数据
                    contentType: false,   // 告诉jQuery不要去设置Content-Type请求头
                    success: function(result){
                        $("#albumList").trigger("reloadGrid");
                        $("#addModel").modal("hide");
                    }
                });
            })

            $("#albumList").jqGrid({
                url: "${app}/cateInStore/findAll",
                colNames: ["食品名", "食品价格","本店类别","月销售量","操作"],
                autowidth: true,
                styleUI: "Bootstrap",
                rowNum: 2,
                height: "100%",
                datatype: "json",
                viewrecords: true,//是否显示总记录数
                pager: "#pager",
                colModel: [
                    {"name": "name"},
                    {"name": "price"},
                    {"name": "cateinstoreId"},
                    {"name": "saleCount"},
                    {
                        formatter: function (value, options, row) {
                            var content = "<button class=\"btn btn-danger optionBtn\" onclick=\"del(\'\')\">删 除</button>"
                            return content;
                        }
                    }
                ]
            })
        })

        //添加类别
        function addCate() {
            var name = $("#name").val();
            $.post("${app}/cateInStore/add", {"name": name}, function () {
                $("#albumList").trigger("reloadGrid");
                $("#myModal").modal("hide");
            })
        }

        //删除以及类别
        function del(id) {
            var b = window.confirm("删除此类别时该类别下的商品也会被删除，是否要删除？");
            if (b == true) {
                $.post("${app}/category/deleteFirst", {"id": id}, function () {
                    $("#albumList").trigger("reloadGrid");
                })
            }
        }

        //弹出模态框
        function showAddModel() {
            $("#addModel").modal("show");
            $.post("${app}/goods/findCate",function (result) {
                var cate = $("#cate");
                cate.empty();
                var option1 = $("<option>").text("请选择所属类别").attr({"disabled":true,"selected":true})
                cate.append(option1);
                for(var i = 0; i<result.length; i++){
                    var option = $("<option>").text(result[i].name).val(result[i].id);
                    cate.append(option);
                }
            });

            $.post("${app}/goods/findCateInStore",function (result) {
                var cateinstore = $("#cateinstore");
                cateinstore.empty();
                var option1 = $("<option>").text("请选择本店类别").attr({"disabled":true,"selected":true})
                cateinstore.append(option1);
                for(var i = 0; i<result.length; i++){
                    var option = $("<option>").text(result[i].name).val(result[i].id);
                    cateinstore.append(option);
                }
            });

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
                    <h2 style="margin-top: 0px">食品管理</h2>
                </div>
                <ul class="nav nav-tabs">
                    <li class="active"><a href="#">食品列表</a></li>
                    <li><a href="javascript:showAddModel()">添加食品</a></li>
                </ul>

                <%--列表--%>
                <table id="albumList"></table>
                <%--分页--%>
                <div id="pager"></div>
            </div>
        </div>
    </div>

    <%-- 模态框 --%>
    <div class="modal fade bs-example-modal-sm" id="addModel" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
         aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content ">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <h4 class="modal-title" id="myModalLabel">添加本店类别</h4>
                </div>
                <div class="modal-body">
                    <form class="form-horizontal" role="form" id="fileForm">
                        <div class="form-group">
                            <label class="col-sm-2 control-label">食品名称</label>
                            <div class="col-sm-9">
                                <input type="hidden" id="id" class="form-control"  name="id">
                                <input type="text" class="form-control" id="name" name="name" placeholder="请输入食品名">
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label">食品价格</label>
                            <div class="col-sm-9">
                                <input type="text" class="form-control" id="price" name="price" placeholder="请输入食品价格">
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-sm-2 control-label">所属类别</label>
                            <div class="col-sm-9">
                                <select  class="form-control" name="cateId" id="cate">

                                </select>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-sm-2 control-label">本店类别</label>
                            <div class="col-sm-9">
                                <select  class="form-control" name="cateinstoreId" id="cateinstore">

                                </select>
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="description" class="col-sm-2 control-label">食品描述</label>
                            <div class="col-sm-9">
                                <input type="text" class="form-control" name="description" id="description" placeholder="请输入食品描述">
                            </div>
                        </div>

                        <div class="form-group" id="fileDiv">
                            <label for="coverImg" class="col-sm-2 control-label">食品图片</label>
                            <div class="col-sm-9">
                                <input type="file" id="coverImg" name="multipartFile">
                            </div>
                        </div>

                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                    <button type="button" class="btn btn-primary" id="addBtn">添加</button>
                </div>
            </div><!-- /.modal-content -->
        </div><!-- /.modal -->
    </div>


    <%--页脚--%>
    <%--<%@include file="../basic/footer.jsp" %>--%>
</body>
</html>

<%--专辑管理 章节管理--%>