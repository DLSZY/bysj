<%@page pageEncoding="UTF-8" contentType="text/html; UTF-8" %>
<%@include file="../basic/basic.jsp" %>
<!doctype html>
<html>
<head>
    <title>食品管理</title>
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
                url: "${app}/goods/findAll",
                colNames: ["食品名","所属商家", "食品价格","所属类别","操作"],
                autowidth: true,
                styleUI: "Bootstrap",
                rowNum: 6,
                height: "100%",
                datatype: "json",
                viewrecords: true,//是否显示总记录数
                pager: "#pager",
                colModel: [
                    {"name": "name"},
                    {"name": "businessName"},
                    {"name": "price"},
                    {"name": "cateName"},
                    {
                        formatter: function (value, options, row) {
                            var content = "<button class=\"btn btn-primary optionBtn\" onclick=\"show(\'"+row.id+"\')\">查看详情</button>"
                            return content;
                        }
                    }
                ]
            })
        })




        //展示详情
        function show(id) {
            $("#showModel input").attr({"readonly":true});
            //console.log($("#showModel input"))
            $.post("${app}/goods/findOneNoOther",{"id":id},function (result){
                $("#id1").val(result.id);
                $("#name1").val(result.name);
                $("#price1").val(result.price);
                $("#businessName1").val(result.businessName);
                $("#description1").val(result.description);
                $("#saleCount1").val(result.saleCount);
                $("#cate1").val(result.cateName);
                $("#cateinstore1").val(result.cateinstoreName);
                var imgUrl = "../upload/goodsImg/"+result.imgUrl;
                $("#goodsImg").attr({"src":imgUrl})
            });
            $("#showModel").modal("show");
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
                    <h2 style="margin-top: 0px">食品管理</h2>
                </div>
                <ul class="nav nav-tabs">
                    <li class="active"><a href="#">食品列表</a></li>
                </ul>

                <%--列表--%>
                <table id="albumList"></table>
                <%--分页--%>
                <div id="pager"></div>
            </div>
        </div>
    </div>

    <%-- 展示详情改模态框 --%>
    <div class="modal fade bs-example-modal-sm" id="showModel" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
             aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content ">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        <h4 class="modal-title" id="myModalLabel1">添加本店类别</h4>
                    </div>
                    <div class="modal-body">
                        <form class="form-horizontal" role="form" id="fileForm1">
                            <div class="form-group">
                                <label class="col-sm-2 control-label">食品名称</label>
                                <div class="col-sm-6">
                                    <input type="hidden" id="id1" class="form-control"  name="id">
                                    <input type="text" class="form-control" id="name1" name="name" placeholder="请输入食品名">
                                </div>
                                <div class="col-sm-3" id="imgDiv">
                                    <img src="" class="img-thumbnail" id="goodsImg">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label">食品价格</label>
                                <div class="col-sm-6">
                                    <input type="text" class="form-control" id="price1" name="price" placeholder="请输入食品价格">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label">食品销量</label>
                                <div class="col-sm-6">
                                    <input type="text" class="form-control" id="saleCount1" name="saleCount" placeholder="请输入食品价格">
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-sm-2 control-label">所属商家</label>
                                <div class="col-sm-9">
                                    <input type="text" class="form-control" id="businessName1" name="businessName1">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label">所属类别</label>
                                <div class="col-sm-9">
                                    <input type="text" class="form-control" id="cate1" name="cate1">
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-sm-2 control-label">本店类别</label>
                                <div class="col-sm-9">
                                    <input type="text" class="form-control" id="cateinstore1" name="cateinstore1">
                                </div>
                            </div>

                            <div class="form-group">
                                <label for="description" class="col-sm-2 control-label">食品描述</label>
                                <div class="col-sm-9">
                                    <input type="text" class="form-control" name="description" id="description1" placeholder="请输入食品描述">
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