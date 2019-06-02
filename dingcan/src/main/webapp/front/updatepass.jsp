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
    <title>用户修改密码</title>
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
            $.post("${app}/user/judge",function (result) {
                console.log(result);
                //判断是否登录
                if(result == ""){
                    window.location.href="${app}/front/login.jsp"
                }
            });

            $("#userForm").validate({
                rules: {
                    password:{
                        required:true, minlength:6, maxlength:20,
                        chinese:true,
                    },
                    repass:{
                        required:true, equalTo: "#password"
                    },
                },
                messages:{
                    password:{
                        required:"密码不能为空",
                        minlength:"密码最小长度为6位",
                        maxlength:"密码最大长度为20位"
                    },
                    repass:{
                        required:"确认密码不能为空",
                        equalTo: "两次输入密码不同"
                    }
                },
                submitHandler: function(form) { //通过之后回调
                    console.log($(form).serialize());
                    //进行ajax传值
                   $.post("${app}/user/forgetPass",$("#userForm").serialize(),function (result) {
                        alert("修改成功，点击确定跳到登录页面~~")
                        window.location.href="${app}/front/login.jsp"
                    })
                },
                invalidHandler: function(form, validator) { //没有通过时的回调函数
                    return false;
                }

            });
            $.validator.addMethod("chinese",function(value,element,params){
                var reg = /^[A-Za-z0-9]+$/;//正则表达式
                return reg.test(value);
            },"不能存在中文或特殊字符");
            //提交注册表单
           /* $("#changeBtn").on("click",function () {
                var password = $("#password").val();
                var rePass = $("#repass").val();
                if(password == rePass){
                    $.post("${app}/user/forgetPass",{"newPass":password},function (result) {
                        alert("修改成功，点击确定跳到登录页面~~")
                        window.location.href="${app}/front/login.jsp"
                    })
                }else{
                    alert("两次输入密码不一致")
                }
            })*/
            $.post("${app}/user/clearPhoneCode");
        })
    </script>
</head>
<body>
<nav class="navbar navbar-inverse" role="navigation" style="background-color: rgb(19,209,190); border-color: rgb(19,209,190);">
    <div class="container-fluid">
        <div class="collapse navbar-collapse text-center"  id="example-navbar-collapse">
            <span class="navbar-text" style="color: white; font-weight: bold; font-size: 20px">用户中心</span>
        </div>
    </div>
</nav>
<div class="container-fluid">
    <div class="row text-center"style="padding-top: 30px">
        <div class="col-sm-6 col-sm-offset-3">
            <div class="col-sm-10 col-sm-offset-1">
                <div class="panel panel-default">
                    <div class="panel-body">
                        <p><h4>用户修改密码</h4></p>
                        <%--<p class="text-muted" >填写您的基本信息</p>--%>
                        <div class="col-sm-10 col-sm-offset-1">
                            <hr>
                        </div>
                        <form id="userForm" class="form-horizontal" role="form">
                            <div class="form-group">
                                <label  class="col-sm-2 col-sm-offset-1 control-label">输入密码</label>
                                <div class="col-sm-8">
                                    <input type="text" class="form-control" name="password" id="password" placeholder="请输入新密码">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 col-sm-offset-1  control-label">确认密码</label>
                                <div class="col-sm-8">
                                    <input type="text" class="form-control" name="repass" id="repass" placeholder="确认新密码">
                                </div>
                            </div>

                            <div class="form-group">
                                <div class="col-sm-4 col-sm-offset-4">
                                    <%--<a id="changeBtn" class="btn btn-primary btn-block editBtn"  style="height: 40px;line-height: 28px">确认修改</a>--%>
                                    <input type="submit" id="changeBtn" class="btn btn-primary btn-block editBtn"  style="height: 40px;line-height: 28px" value="确认修改"/>
                                </div>
                                <div class="col-sm-4" style="padding-top: 17px">
                                    <a href="login.jsp" style="color: gray;font-size: 12px">修改完成，去登陆</a>
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