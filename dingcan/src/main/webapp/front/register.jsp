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
    <script src="../statics/js/jquery.validate.min.js" type="text/javascript"></script>
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
        $(function() {
            $("#userForm").validate({
                rules: {　　
                    username:{
                        required: true, minlength: 6, maxlength:15,
                        remote: {
                            type: "post",
                            url: "/user/findByUsername",
                            data: {
                                username: function() {
                                    return $("#username").val();
                                }
                            },
                            dataType: "json",
                            dataFilter: function(data, type) {
                                if (data == 1)
                                    return false;
                                else
                                    return true;
                            }
                        }
                    },
                    password:{
                        required:true, minlength:6, maxlength:20,
                    },
                    repassword:{
                        required:true, equalTo: "#password"
                    },
                    phone:{
                        phone: true,
                        remote: {
                            type: "post",
                            url: "/user/findByPhone",
                            data: {
                                username: function() {
                                    return $("#phone").val();
                                }
                            },
                            dataType: "json",
                            dataFilter: function(data, type) {
                                if (data == 1)
                                    return false;
                                else
                                    return true;
                            }
                        }
                    },

                },
                messages:{　　　　
                    username:{
                        required: "用户名不能为空",
                        minlength: "用户名最小长度为6位",
                        maxlength: "用户名最大长度为15位",
                        remote: "该用户名已存在",
                    },
                    password:{
                        required:"密码不能为空",
                        minlength:"密码最小长度为6位",
                        maxlength:"密码最大长度为20位"
                    },
                    repassword:{
                        required:"确认密码不能为空",
                        equalTo: "两次输入密码不同"
                    },
                    phone:{
                        remote:"该手机号已经被注册"
                    }
                },

                submitHandler: function(form) { //通过之后回调
                    console.log($(form).serialize());
                    //进行ajax传值
                   $.post("${app}/user/register",$("#userForm").serialize(),function (result) {
                        alert("注册成功，请回登录页面登录~~")
                        window.location.href="${app}/front/login.jsp"
                    })
                },
                invalidHandler: function(form, validator) { //没有通过时的回调函数
                    return false;
                }
            });

            //扩展默认验证规则
            //参数1:验证规则 phone  参数2:验证时触发回调函数  参数3:验证不通过的提示信息
            $.validator.addMethod("phone",function(value,element,params){
                var reg = /^1[34578]\d{9}$/;//正则表达式
                return reg.test(value);
            },"手机号码格式不正确");
        });


       /* $(function () {
            //提交注册表单
            $("#register").on("click",function () {

                /!*$.post("${app}/user/register",$("#userForm").serialize(),function (result) {
                    alert("注册成功，请回登录页面登录~~")
                    window.location.href="${app}/front/login.jsp"
                })*!/
            })
        })*/
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
                                    <input type="text" class="form-control" id="username" name="username" placeholder="请输入用户名">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label">密码</label>
                                <div class="col-sm-9">
                                    <input type="text" class="form-control" id="password" name="password" placeholder="密码">
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
                                    <%--<a id="register" class="btn btn-primary btn-block editBtn"  style="height: 40px;line-height: 28px">确认注册</a>--%>
                                    <input type="submit" id="register" class="btn btn-primary btn-block editBtn"  style="height: 40px;line-height: 28px" value="确认注册"/>
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

    <!-- Modal -->
    <div class="modal fade bs-example-modal-sm" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
        <div class="modal-dialog modal-sm" role="document">
            <div class="modal-content">
                <div class="modal-body" style="text-align: center">
                    用户名不能为空
                </div>
            </div>
        </div>
    </div>

</div>
</body>
</html>