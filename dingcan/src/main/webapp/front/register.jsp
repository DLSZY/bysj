<%@page pageEncoding="UTF-8" contentType="text/html; UTF-8" %>
<%@include file="../basic/basic.jsp" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <%@include file="../basic/resources.jsp" %>
    <title>用户注册</title>
    <style>
        body{
            background-color: #f5f5f5;
        }
        input{
            height: 40px !important;
        }
        #select div{
            border-bottom: 1px solid #5a5e66;
            margin-bottom: 20px;
            color: #5a5e66;
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
    </style>

    <script>
        $(function () {
            //提交注册表单
            $("#register").on("click",function () {
                $.post("${app}/user/register",$("#userForm").serialize(),function (result) {
                    alert("注册成功，请回登录页面登录~~")
                    window.location.href="${app}/front/login.jsp"
                })
            })


        })
    </script>
</head>
<body>
<nav class="navbar navbar-inverse" role="navigation" style="background-color: rgb(19,209,190); border-color: rgb(19,209,190);">
    <div class="container-fluid">
        <div class="collapse navbar-collapse text-center"  id="example-navbar-collapse">
            <span class="navbar-text" style="color: white; font-weight: bold; font-size: 20px">用户注册中心</span>
        </div>
    </div>
</nav>
<div class="container-fluid">
    <div class="row text-center"style="padding-top: 30px">
        <div class="col-sm-6 col-sm-offset-3">
            <div class="col-sm-10 col-sm-offset-1">
                <div class="panel panel-default">
                    <div class="panel-body">
                        <p><h4>用户注册</h4></p>
                        <p class="text-muted" >填写您的基本信息</p>
                        <div class="col-sm-10 col-sm-offset-1">
                            <hr>
                        </div>
                        <form id="userForm" class="form-horizontal" role="form">
                            <div class="form-group">
                                <label class="col-sm-2 control-label">用户名</label>
                                <div class="col-sm-9">
                                    <input type="text" class="form-control" name="username" placeholder="请输入用户名">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label">密码</label>
                                <div class="col-sm-9">
                                    <input type="text" class="form-control" name="password" placeholder="密码">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label">确认密码</label>
                                <div class="col-sm-9">
                                    <input type="text" class="form-control" name="repassword" placeholder="确认密码">
                                </div>
                            </div>


                            <div class="form-group">
                                <label  class="col-sm-2 control-label">手机号</label>
                                <div class="col-sm-9">
                                    <input type="text" class="form-control" name="phone" id="phone" placeholder="请输入手机号码">
                                </div>
                            </div>


                            <div class="form-group">
                                <div class="col-sm-4 col-sm-offset-4">
                                    <a id="register" class="btn btn-primary btn-block editBtn"  style="height: 40px;line-height: 28px">确认注册</a>
                                </div>
                                <div class="col-sm-4" style="padding-top: 17px">
                                    <a href="login.jsp" style="color: gray;font-size: 12px">已有账户，去登陆</a>
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