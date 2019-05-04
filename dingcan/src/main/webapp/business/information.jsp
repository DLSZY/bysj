<%@page pageEncoding="UTF-8" contentType="text/html; UTF-8" %>
<%@include file="../basic/basic.jsp" %>
<!doctype html>
<html>
<head>
    <title>我的信息</title>
    <%--引入资源--%>
    <%@include file="../basic/resources.jsp" %>
    <style>
        td a {
            margin-left: 15px;
        }
        form input{
            height: 40px !important;
        }
        form label{
            height: 40px !important;
            line-height: 30px !important;
        }
    </style>
    <script>
        $(function () {
            $.post("${app}/business/showInfo",function (result) {
                $("#id").val(result.id);
                $("#name").val(result.name);
                $("#phone").val(result.phone);
                $("#startPrice").val(result.startPrice);
                $("#distributionFee").val(result.distributionFee    );
                $("#address").val(result.address);
                $("#notice").val(result.notice);
            })

            $("#change").on("click",function () {
                $.post("${app}/business/changeInfo",$("#info").serialize(),function (result) {
                    alert("修改成功")
                })
            })
        })

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
            <div class="col-sm-8" id="main">
                <div class="page-header" style="margin-top: 0px">
                    <h2 style="margin-top: 0px">个人中心</h2>
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h3 class="panel-title">
                            我的信息
                        </h3>
                    </div>
                    <div class="panel-body">
                        <%--表单--%>
                        <form class="form-horizontal" role="form" id="info">
                            <div class="form-group">
                                <label class="col-sm-2 control-label" style="height: 40px; line-height: 30px">店名：</label>
                                <div class="col-sm-8">
                                    <input type="text" class="form-control" id="name" name="name">
                                    <input type="hidden" class="form-control" id="id" name="id">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label">联系方式：</label>
                                <div class="col-sm-8">
                                    <input type="text" class="form-control" id="phone" name="phone">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label">起送价格：</label>
                                <div class="col-sm-8">
                                    <input type="text" class="form-control" id="startPrice" name="startPrice">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label">配送费：</label>
                                <div class="col-sm-8">
                                    <input type="text" class="form-control" id="distributionFee" name="distributionFee">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label">详细地址：</label>
                                <div class="col-sm-8">
                                    <input type="text" class="form-control" id="address" name="address">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label">公告：</label>
                                <div class="col-sm-8">
                                   <textarea rows="3" class="form-control" name="notice" id="notice" placeholder="请输入本店公告..."></textarea>
                                </div>
                            </div>


                            <div class="form-group">
                                <div class="col-sm-offset-2 col-sm-10">
                                    <a class="btn btn-primary" id="change">确认修改</a>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>

            </div>
        </div>
    </div>



    <%--页脚--%>
    <%--<%@include file="../basic/footer.jsp" %>--%>
</body>
</html>

<%--专辑管理 章节管理--%>