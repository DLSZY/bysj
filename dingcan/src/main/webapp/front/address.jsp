<%@page pageEncoding="UTF-8" contentType="text/html; UTF-8" %>
<%@include file="../basic/basic.jsp"%>
<!doctype html>
<html>
<head>
    <title>我的地址</title>
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
            min-height: 550px;
            padding: 20px 18px;
            border-radius: 5px;
        }
        .editBtn{
            border-color: rgb(19,209,190);
            background-color: rgb(19,209,190);
        }
        .editBtn:hover,
        .editBtn:active{
            border-color: rgb(115,225,206) !important;
            background-color: rgb(115,225,206) !important;
        }
        td a{
            color: rgb(19,209,190);
        }
        td a:hover,
        td a:focus{
            color: rgb(115,225,206) !important;
        }
    </style>
    <script>
        $(function () {
            //当浏览器大小变化时
            $(window).resize(function () {
                $("#jq").setGridWidth($("#main").width())
            });

            $("#jq").jqGrid({
                url:"${app}/userAddress/selectByUser",
                colNames:["姓名","身份","联系方式","地址","门牌号","操作"],
                autowidth:true,
                styleUI:"Bootstrap",
                height:"100%",
                datatype:"json",
                viewrecords:true,//是否显示总记录数
                pager:"#pager",
                colModel:[
                    {"name":"name"},
                    {
                        formatter:function (value, options, row) {
                            if(row.sex == 1){
                                return "先生"
                            }else{
                                return "女士"
                            }
                        }
                    },
                    {"name":"phone"},
                    {"name":"address"},
                    {"name":"houseNum"},
                    {
                        formatter:function (value, options, row) {
                            var content = ""
                            content += "<a href=\"javascript:select(\'"+row.id+"\')\" ><span class='glyphicon glyphicon-pencil'></span></a>"
                            content += "<a href=\"javascript:del(\'"+row.id+"\')\"><span class=\"glyphicon glyphicon-remove\"></span></a>"
                            return content;
                        }
                    }
                ]
            })
            //添加
            $("#addBtn").on("click",function () {
                $.post("${app}/userAddress/edit",$("#itemForm").serialize(),function () {
                    $("#myModal").modal("hide");
                    $("#jq").trigger("reloadGrid");
                })
            })
            //修改
            $("#editBtn").on("click",function () {
                $.post("${app}/userAddress/edit",$("#itemForm1").serialize(),function () {
                    $("#myModal1").modal("hide");
                    $("#jq").trigger("reloadGrid");
                })
            })
        })
        //查询
        function select(id) {
            $.post("${app}/userAddress/selectById",{"id":id},function (result) {
                console.log(result);
                $("#id1").val(result.id);
                $("#name1").val(result.name);
                $("#address1").val(result.address);
                $("#houseNum1").val(result.houseNum);
                $("#phone1").val(result.phone);
                var redios = $("#sexRe").find("input");
                for(var i = 0; i<redios.length; i++){
                    if(result.sex == $(redios[i]).val()){
                        $(redios[i]).attr({"checked":true});
                    }
                }
                $("#myModal1").modal("show");
            })
        }
        //删除
        function del(id) {
            var b = window.confirm("是否要删除此地址？");
            if(b){
                $.post("${app}/userAddress/del",{"id":id},function () {
                    $("#jq").trigger("reloadGrid");
                })
            }
        }

    </script>
</head>
<body>

<div class="Wrapper">
<%--导航--%>
<%@include file="frontbasic/header.jsp" %>
<div class="container">
    <div class="row" id="main">
        <div class="page-header" style="margin-top: 0px">
            <h3  style="margin-top: 0px">地址管理</h3>
        </div>
        <ul class="nav nav-tabs">
            <li class="active"><a href="#">我的地址</a></li>
            <li><a href="#" data-toggle="modal" data-target="#myModal">添加地址</a></li>
        </ul>
        <%--列表--%>
        <table id="jq"></table>
        <%--分页--%>
      <%--  <div id="pager"></div>--%>

        <!-- 添加修态框（Modal） -->
        <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content ">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        <h4 class="modal-title" id="myModalLabel">添加新地址</h4>
                    </div>
                    <div class="modal-body">
                        <form class="form-horizontal" role="form" id="itemForm">
                            <div class="form-group">
                                <label class="col-sm-2 control-label">姓名</label>
                                <div class="col-sm-9">
                                    <input type="hidden" id="id" class="form-control"  name="id">
                                    <input type="text" class="form-control" id="name" name="name" placeholder="请输入您的姓名">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label">身份</label>
                                <div class="col-sm-9">
                                    <label class="radio-inline">
                                        <input type="radio" name="sex" id="inlineRadio1" value="1"> 先生
                                    </label>
                                    <label class="radio-inline">
                                        <input type="radio" name="sex" id="inlineRadio2" value="2"> 女士
                                    </label>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-sm-2 control-label">手机号</label>
                                <div class="col-sm-9">
                                    <input type="text" class="form-control" name="phone" placeholder="请输入您的手机号">
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-sm-2 control-label">位置</label>
                                <div class="col-sm-9">
                                    <input type="text" class="form-control" name="address" placeholder="请输入位置">
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-sm-2 control-label">详细地址</label>
                                <div class="col-sm-9">
                                    <input type="text" class="form-control" name="houseNum" placeholder="单元、门牌号">
                                </div>
                            </div>
                        </form>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                        <button type="button" class="btn btn-primary editBtn" id="addBtn">添加</button>
                    </div>
                </div><!-- /.modal-content -->
            </div><!-- /.modal -->
        </div>
        <%--修改模态框--%>
        <div class="modal fade" id="myModal1" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content ">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        <h4 class="modal-title" id="myModalLabel1">修改地址</h4>
                    </div>
                    <div class="modal-body">
                        <form class="form-horizontal" role="form" id="itemForm1">
                            <div class="form-group">
                                <label class="col-sm-2 control-label">姓名</label>
                                <div class="col-sm-9">
                                    <input type="hidden" id="id1" class="form-control"  name="id">
                                    <input type="text" class="form-control" id="name1" name="name" placeholder="请输入您的姓名">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label">身份</label>
                                <div class="col-sm-9" id="sexRe">
                                    <label class="radio-inline">
                                        <input type="radio" name="sex" id="inlineRadio3" value="1"> 先生
                                    </label>
                                    <label class="radio-inline">
                                        <input type="radio" name="sex" id="inlineRadio4" value="2"> 女士
                                    </label>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-sm-2 control-label">手机号</label>
                                <div class="col-sm-9">
                                    <input type="text" class="form-control" name="phone" id="phone1" placeholder="请输入您的手机号">
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-sm-2 control-label">位置</label>
                                <div class="col-sm-9">
                                    <input type="text" class="form-control" id="address1" name="address" placeholder="请输入位置">
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-sm-2 control-label">详细地址</label>
                                <div class="col-sm-9">
                                    <input type="text" class="form-control" id="houseNum1" name="houseNum" placeholder="单元、门牌号">
                                </div>
                            </div>
                        </form>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                        <button type="button" class="btn btn-primary  editBtn" id="editBtn">修改</button>
                    </div>
                </div><!-- /.modal-content -->
            </div><!-- /.modal -->
        </div>

    </div>
</div>

<div class="FooterPush"></div>
</div>

<%--页脚--%>
</body>
</html>

<%--专辑管理 章节管理--%>