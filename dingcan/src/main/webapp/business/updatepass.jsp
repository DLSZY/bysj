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
    <title>修改密码</title>
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
        #order li{
            width: 128px;
        }
        .showf{
            display: block !important;
        }
        .nonef{
            display: none !important;
        }
        .nav>li>a:focus, .nav>li>a:hover {
            text-decoration: none;
            background-color: white;
            color: #337ab7;
        }
    </style>
    <script>
        $(function () {
            var step = 1;
            var isCode = 0;
            //校验验证码
            $("#inputCode").on("change",function () {
                var code = $(this).val();
                $.post("${app}/business/checkCode",{"code":code},function (result) {
                    var codeDiv = $("#codeDiv").addClass("has-feedback");
                    $("#codeSpan").remove();
                    var span = $("<span>").addClass("glyphicon form-control-feedback").css({"height":"40px","line-height":"40px"}).attr({"id":"codeSpan"});

                    if(result == 0){
                        codeDiv.addClass("has-error").removeClass("has-success");
                        span.addClass("glyphicon-remove").removeClass("glyphicon-ok");
                        $("#nextBtn").attr({"disabled":true})
                        isCode = 0;
                    }else{
                        codeDiv.addClass("has-success").removeClass("has-error");
                        span.addClass("glyphicon-ok").removeClass("glyphicon-remove");
                        $("#nextBtn").attr({"disabled":false})
                        isCode = 1;
                    }
                    $("#codeDiv").append(span);
                })
            })

            //判断账号是否存在
            $("#firstBtn").on("click",function () {
                if(step == 1){
                    console.log(step);
                    var username = $("#username").val();
                    $.post("${app}/business/checkExist",{"username":username},function (result) {
                        if(result == 0){
                            alert("用户名不存在！");
                        }
                        else if(result == 1){
                            alert("用户名被冻结,请联系管理员解冻");
                        }
                        else if(isCode == 0){
                            alert("验证码错误");
                        }
                        if(result == 2 && isCode == 1){
                            $(".first").removeClass("showf").addClass("nonef");
                            $(".second").removeClass("nonef").addClass("showf");

                            $("#fistSpan").removeClass("active");
                            $("#secondSpan").addClass("active");

                            //$("#firstBtn").attr({"id":"secondBtn"})
                            step = 2;
                            console.log("修改为"+step)
                        }

                    })
                }
                else if(step == 2){  //检验手机号验证码
                    console.log(step);
                    //测试
                   /* $(".second").removeClass("showf").addClass("nonef");
                    $(".three").removeClass("nonef").addClass("showf");
                    $("#secondSpan").removeClass("active");
                    $("#threeSpan").addClass("active");
                    step = 3;
                    console.log("修改为"+step)*/

                   //正式
                    var phone = $("#phone").val();
                    var phoneCode = $("#phoneCode").val();
                    $.post("${app}/business/checkUpdatePhoneCode",{"phone":phone,"phoneCode":phoneCode},function (result) {
                        if(result == 0){
                            alert("验证码错误！")
                        }else{
                            $(".second").removeClass("showf").addClass("nonef");
                            $(".three").removeClass("nonef").addClass("showf");

                            $("#secondSpan").removeClass("active");
                            $("#threeSpan").addClass("active");
                            step = 3;
                            console.log("修改为"+step)
                        }
                    })

                }
                else if(step == 3){      //修改密码页面
                    console.log(step+"-----");
                    var username = $("#username").val();
                    var newPassword = $("#newPass").val();
                    var reNewPass = $("#reNewPass").val();
                    if(newPassword.length<6){
                        alert("密码长度不能小于6位~~")
                    }else if(newPassword == reNewPass){
                        $.post("${app}/business/changePass",{"username":username,"newPassword":newPassword},function () {
                            $(".three").removeClass("showf").addClass("nonef");
                            $("#threeSpan").removeClass("active");
                            $("#fourSpan").addClass("active");
                            $("#fourSpan").addClass("active");
                            $("#firstBtn").hide();
                            $("#msg").show()
                        })
                    }else{
                        alert("两次输入密码不正确~！")
                    }
                    console.log(newPassword);
                }
            })


            //判断手机号是否和用户名匹配
            $("#sendCode").on("click",function () {
                var username = $("#username").val();
                var phone = $("#phone").val();
                $.post("${app}/business/checkUserPhone",{"username":username,"phone":phone},function (result) {
                    console.log(result);
                    if(result == 0){
                        alert("手机号和用户名不匹配！");
                    }else{
                        alert("验证码已发送~~");
                    }
                })
            });


            //刷新验证码
            $("#code").on("click",function () {
                this.src = "${app}/business/updateCode?u="+Math.random();
            })
        })
    </script>
</head>
<body>

<div class="container-fluid">
    <div class="row"style="padding-top: 110px">
        <div class="col-sm-6 col-sm-offset-3">
            <div class="col-sm-10 col-sm-offset-1">
                <div class="panel panel-default">
                    <div class="panel-body">
                        <div class="col-sm-12" style="padding-left: 0px">
                            <div class="col-sm-4" style="padding-left: 0px">
                                <h4 style="margin-bottom: 20px">找回密码</h4>
                            </div>
                            <div class="col-sm-2 col-sm-offset-6" style="margin-top: 12px">
                                <a href="login.jsp">返回登录</a>
                            </div>
                        </div>

                        <ul class="nav nav-pills" role="tablist" id="order">
                            <li role="presentation" class="active" id="fistSpan"><a> <span class="badge">1</span> 填写用户名</a></li>
                            <li role="presentation" id="secondSpan"><a ><span class="badge">2</span> 验证身份</a></li>
                            <li role="presentation" id="threeSpan"><a ><span class="badge">3</span> 设置新密码 </a></li>
                            <li role="presentation" id="fourSpan"><a ><span class="badge">4</span> 完成 </a></li>
                        </ul>
                        <hr>
                        <form class="form-horizontal" role="form">

                            <!--第一-->
                            <div class="form-group first showf">
                                <label for="username" class="col-sm-2 control-label">用户名</label>
                                <div class="col-sm-7">
                                    <input type="text" class="form-control" id="username" placeholder="请输入用户名">
                                </div>
                            </div>
                            <div class="form-group first showf">
                                <label class="col-sm-2 control-label">验证码</label>
                                <div class="col-sm-7" id="codeDiv">
                                    <input type="text" class="form-control" id="inputCode" maxlength="4" placeholder="请输入右侧验证码">
                                </div>

                                <div class="col-sm-2">
                                    <img src="${app}/business/updateCode" id="code">
                                </div>
                            </div>

                            <!--第二-->
                            <div class="form-group second nonef">
                                <label class="col-sm-2 control-label">手机号</label>
                                <div class="input-group col-sm-8 " style="padding: 0 15px">
                                    <input type="text" class="form-control" id="phone" placeholder="请输入注册手机号">
                                    <span class="input-group-btn">
                                        <button class="btn btn-info" id="sendCode" style="height: 40px;line-height: 30px" type="button">
                                            发送验证码
                                        </button>
                                    </span>
                                </div>
                            </div>
                            <div class="form-group second nonef">
                                <label class="col-sm-2 control-label">验证码</label>
                                <div class="col-sm-8">
                                    <input type="text" class="form-control" id="phoneCode" placeholder="请输入收到验证码">
                                </div>
                            </div>

                            <!--第三-->
                            <div class="form-group three nonef">
                                <label class="col-sm-3 control-label">输入新密码</label>
                                <div class="col-sm-8">
                                    <input type="text" class="form-control" id="newPass" placeholder="请输入新密码">
                                </div>
                            </div>
                            <div class="form-group three nonef">
                                <label class="col-sm-3 control-label">确认密码</label>
                                <div class="col-sm-8">
                                    <input type="text" class="form-control" id="reNewPass" placeholder="再次输入新密码">
                                </div>
                            </div>

                            <%--第四--%>
                            <div class="alert alert-info" id="msg" style="display: none;">
                                <a href="#" class="close" data-dismiss="alert">
                                    &times;
                                </a>
                                <strong>修改密码成功！</strong>
                            </div>



                            <div class="form-group">
                                <div class="col-sm-4 col-sm-offset-4">
                                    <a id="firstBtn" class="btn btn-primary btn-block"  style="height: 40px;line-height: 30px">下一步</a>
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