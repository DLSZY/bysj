<%@page pageEncoding="UTF-8" contentType="text/html; UTF-8" %>
<%@include file="../basic/basic.jsp"%>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>管理员登录</title>
    <%--引入资源--%>
    <%@include file="../basic/resources.jsp"%>
    <style>
        body{
            background-color: #f5f5f5;
        }
        input{
            height: 40px !important;
        }
    </style>
    <script>
        $(function () {
            $("#loginBtn").on("click",function () {
                console.log($("#infoForm").serialize());
                var username = $("#username").val();
                var password = $("#password").val();
                console.log(username);
                console.log(password);

                $.post("${app}/admin/login",{"username":username,"password":password},function (result) {
                //$.post("${app}/admin/login",$("#infoFrom").serialize(),function (result) {
                   if(result.isLogin == true){
                      window.location.href = "${app}/back/business.jsp"
                   }else{
                       alert(result.msg);
                   }
                })
            })
        })
    </script>
</head>
<body>
<div class="container-fluid">
    <div class="row text-center"style="padding-top: 130px">
        <div class="col-sm-4 col-sm-offset-4">
            <div class="col-sm-10 col-sm-offset-1">
                <div class="panel panel-default">
                    <div class="panel-body">
                        <p><h4>管理员登录</h4></p>
                        <p class="text-muted">管理商家和用户等信息</p>
                        <div class="col-sm-10 col-sm-offset-1">
                            <hr>
                        </div>

                        <form class="form-horizontal" role="form" id="infoForm">
                            <div class="form-group">
                                <div class="col-sm-10 col-sm-offset-1">
                                    <input type="text" class="form-control" name="username" id="username" placeholder="请输入账号">
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="col-sm-10 col-sm-offset-1">
                                    <input type="password" class="form-control" name="password" id="password" placeholder="请输入密码">
                                </div>
                            </div>

                            <div class="form-group">
                                <div class="col-sm-offset-1 col-sm-10">
                                    <a type="submit" id="loginBtn" class="btn btn-primary btn-block" style="height: 40px">登录</a>
                                </div>
                            </div>
                            <div class="form-group text-left">
                                <div class="col-sm-10 col-sm-offset-1">
                                    <a href="#" style="color: gray;font-size: 12px">登录遇到问题</a>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>

        </div>
    </div>
</div>
</body>
</html>