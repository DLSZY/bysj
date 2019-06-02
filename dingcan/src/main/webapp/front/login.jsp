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
        #checkCode{
            height: 34px;
        }
    </style>
    <script>
        $(function () {
            $("#sendCode").on("click",function () {
                $.post("${app}/user/sendPhoneCode",{"phone":$("#phone").val()},function (result) {
                })
            })

            //登录
            $("#login").on("click",function(){
                var username = $("#username").val();
                if(username == ""){
                    alert("用户名不能为空")
                }else{
                    $.post("${app}/user/login",$("#infoFrom").serialize(),function (result) {
                        if(result.success == 1){
                            window.location.href = "${app}/front/index.jsp"
                        }else{
                            alert(result.msg);
                        }
                    })
                }
            })

            //发送手机验证码
            $("#sendCode").on("click",function () {
                var phone = $("#phone").val();
                var reg = /^1[34578]\d{9}$/;//正则表达式
                if (!reg.test(phone)){
                    alert("手机号格式错误");
                }else{
                    $.post("${app}/user/sendPhoneCode",{"phone":phone},function (result) {
                        if (result == 0){
                            alert("该手机号还未注册~!")
                        }else {
                            alert("验证码已发送~~")
                        }
                    })
                }

            })

            //检验手机验证码
            $("#checkCode").on("click",function () {
                $.post("${app}/user/checkPhoneCode",$("#codeForm").serialize(),function (result) {
                    console.log(result);
                    if (result == "2"){
                        alert("请点击发送验证码~~")
                    }else if (result == "0"){
                        alert("验证码错误")
                    }else{
                        window.location.href = "${app}/front/updatepass.jsp";
                    }
                })
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
                                    <input type="text" id="username" class="form-control" name="username" placeholder="请输入账号">
                                </div>
                            </div>

                            <div class="form-group">
                                <div class="col-sm-10 col-sm-offset-1">
                                    <input type="text" class="form-control" name="password" placeholder="请输入密码" style="padding-right: 90px">
                                    <a href="#myModal" data-toggle="modal" id="forget">忘记密码</a>
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

    <%--短信验证模态框--%>
    <div class="modal fade bs-example-modal-sm" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-sm">
            <div class="modal-content ">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <h4 class="modal-title" id="myModalLabel">手机验证</h4>
                </div>
                <div class="modal-body">
                    <form class="form-horizontal" role="form" id="codeForm">
                        <div class="form-group">
                            <div class="col-sm-12">
                                <input type="text" class="form-control" id="phone" name="phone" placeholder="输入注册时手机号">
                                <a href="javascript:void(0);" id="sendCode" >发送验证码</a>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="col-sm-12">
                                <input type="text" class="form-control" maxlength="4" id="code" name="phoneCode" placeholder="请输入验证码">
                            </div>
                        </div>

                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal" >关闭</button>
                    <button type="button" class="btn btn-primary" id="checkCode">确认</button>
                </div>
            </div><!-- /.modal-content -->
        </div><!-- /.modal -->
    </div>
</div>
</body>
</html>