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
    <title>用户登录</title>
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
        #forget,#sendCode{
            position: absolute;
            top: 11px;
            right: 30px;
        }
        #forget:hover{
            text-decoration: none;
        }
        .color{
            color: rgb(19,209,190);
        }
        .color:hover{
            color: rgb(115,225,206) !important;
        }
        .btn-primary{
            border-color: rgb(19,209,190);
            background-color: rgb(19,209,190);
            line-height: 25px;
        }
        .btn-primary:hover,
        .btn-primary:active{
            border-color: rgb(115,225,206) !important;
            background-color: rgb(115,225,206) !important;
        }
    </style>
    <script>
        $(function () {
            $("#sendCode").on("click",function () {
                $.post("${app}/business/sendPhoneCode",{"phone":$("#phone").val()},function (result) {
                })
            })

            //登录
            $("#login").on("click",function(){
                $.post("${app}/user/login",$("#infoFrom").serialize(),function (result) {
                    if(result.success == 1){
                        window.location.href = "${app}/front/index.jsp"
                    }else{
                        alert(result.msg);
                    }
                })
            })

            $("#checkCode").on("click",function () {
                window.location.href = "${app}/business/register.jsp?phone="+$("#phone").val();
            })
        })
    </script>
</head>
<body>
<div class="container-fluid">
    <div class="row text-center"style="padding-top: 110px">
        <div class="col-sm-4 col-sm-offset-4">
            <div class="col-sm-10 col-sm-offset-1">
                <div class="panel panel-default">
                    <div class="panel-body">
                        <p><h4>用户登录</h4></p>
                        <p class="text-muted" >选择你喜欢的食物</p>
                        <!--<div class="col-sm-10 col-sm-offset-1" id="select" style="padding: 0px">
                            <div class="col-sm-6" style="border-width: 2px"><p>账号密码登录</p></div>
                            <div class="col-sm-6"><p>手机验证登录</p></div>
                        </div>-->
                        <div class="col-sm-10 col-sm-offset-1">
                            <hr>
                        </div>
                        <form class="form-horizontal" role="form" id="infoFrom">
                            <div class="form-group">
                                <div class="col-sm-10 col-sm-offset-1">
                                    <input type="text" class="form-control" name="username" placeholder="请输入账号">
                                </div>
                            </div>

                            <div class="form-group">
                                <div class="col-sm-10 col-sm-offset-1">
                                    <input type="text" class="form-control" name="password" placeholder="请输入密码" style="padding-right: 90px">
                                    <a href="updatepass.jsp" id="forget" class="color">忘记密码?</a>
                                </div>
                            </div>

                            <div class="form-group">
                                <div class="col-sm-offset-1 col-sm-10">
                                    <a class="btn btn-primary btn-block" id="login" style="height: 40px">登录</a>
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

                <div class="panel panel-default">
                    <div class="panel-body" style="padding: 20px 0px">
                        <form class="form-horizontal" role="form">
                                <div class="col-sm-offset-1 col-sm-10">
                                    <span style="color: #878d99;">没有账号？</span>
                                    <a href="./register.jsp" data-toggle="modal" class="color">去注册</a>
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