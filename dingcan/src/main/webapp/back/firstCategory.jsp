    <%@page pageEncoding="UTF-8" contentType="text/html; UTF-8" %>
    <%@include file="../basic/basic.jsp"%>
    <!doctype html>
    <html>
    <head>
        <title>一级类别管理</title>
        <%--引入资源--%>
        <%@include file="../basic/resources.jsp"%>
        <style>
            td a{
                margin-left: 15px;
            }
            .optionBtn{
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
                    url:"${app}/category/selectByLevelAndPage?level=1",
                    colNames:["类别id","类别名","操作"],
                    autowidth:true,
                    styleUI:"Bootstrap",
                    rowNum:2,
                    height:"100%",
                    datatype:"json",
                    viewrecords:true,//是否显示总记录数
                    pager:"#pager",
                    colModel:[
                        {"name":"id"},
                        {"name":"name"},
                        {
                            formatter:function (value, options, row) {
                                var content = "<button class=\"btn btn-danger optionBtn\" onclick=\"del(\'"+row.id+"\')\">删 除</button>"
                                return content;
                            }
                        }
                    ]
                })
            })

            //弹出模态框
            function showModal() {
                $("#codeForm")[0].reset();
                $("#myModal").modal("show");
            }


            //添加类别
            function addCate() {
                var name = $("#name").val();
                $.post("${app}/category/add",{"name":name,"level":1},function () {
                    $("#albumList").trigger("reloadGrid");
                    $("#myModal").modal("hide");
                })
            }
            //删除以及类别
            function del(id) {
                var b = window.confirm("删除此一级类别也会删除此一级类别下的二级类别，是否要删除？");
                if(b == true){
                    $.post("${app}/category/deleteFirst",{"id":id},function () {
                        $("#albumList").trigger("reloadGrid");
                    })
                }
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
                        <h2 style="margin-top: 0px">一级类别管理</h2>
                    </div>
                    <ul class="nav nav-tabs">
                        <li class="active"><a href="#">一级类别列表</a></li>
                        <li><a href="javascript:showModal()">类别添加</a></li>
                    </ul>

                    <%--列表--%>
                    <table id="albumList"></table>
                    <%--分页--%>
                    <div id="pager"></div>
                </div>
            </div>
        </div>

        <%-- 模态框 --%>
        <div class="modal fade bs-example-modal-sm" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-sm">
                <div class="modal-content ">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        <h4 class="modal-title" id="myModalLabel">添加一级类别</h4>
                    </div>
                    <div class="modal-body">
                        <form class="form-horizontal" role="form" id="codeForm">
                            <div class="form-group">
                                <div class="col-sm-12">
                                    <input type="text" style="height: 40px" class="form-control" id="name" name="name" placeholder="请输入类别名">
                                </div>
                            </div>

                        </form>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal" >关闭</button>
                        <button type="button" class="btn btn-primary" id="addCate" onclick="addCate()">添加</button>
                    </div>
                </div><!-- /.modal-content -->
            </div><!-- /.modal -->
        </div>


        <%--页脚--%>
    <%--<%@include file="../basic/footer.jsp" %>--%>
    </body>
    </html>

    <%--专辑管理 章节管理--%>