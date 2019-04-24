<%@page contentType="text/html; UTF-8" pageEncoding="UTF-8" %>
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
    </style>
    <script>
        $(function () {

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
                    }else{
                        codeDiv.addClass("has-success").removeClass("has-error");
                        span.addClass("glyphicon-ok").removeClass("glyphicon-remove");
                    }
                    $("#codeDiv").append(span);
                })
            })

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
                            <li role="presentation" class="active"><a href="#"> <span class="badge">1</span> 填写用户名</a></li>
                            <li role="presentation"><a href="#"><span class="badge">2</span> 验证身份</a></li>
                            <li role="presentation"><a href="#"><span class="badge">3</span> 设置新密码 </a></li>
                            <li role="presentation"><a href="#"><span class="badge">4</span> 完成 </a></li>
                        </ul>
                        <hr>
                        <form class="form-horizontal" role="form">

                            <!--第一-->
                            <div class="form-group">
                                <label for="username" class="col-sm-2 control-label">用户名</label>
                                <div class="col-sm-7">
                                    <input type="text" class="form-control" id="username" placeholder="请输入用户名">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label">验证码</label>
                                <div class="col-sm-7" id="codeDiv">
                                    <input type="text" class="form-control" id="inputCode" maxlength="4" placeholder="请输入右侧验证码">
                                </div>

                                <div class="col-sm-2">
                                    <img src="${app}/business/updateCode" id="code">
                                </div>
                            </div>

                            <!--第二-->
                            <!--<div class="form-group">
                                <label for="username" class="col-sm-2 control-label">手机号</label>
                                <div class="col-sm-8">
                                    <input type="text" class="form-control" id="username" placeholder="请输入注册手机号">
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="lastname" class="col-sm-2 control-label">验证码</label>
                                <div class="col-sm-8">
                                    <input type="text" class="form-control" id="lastname" placeholder="请输入收到验证码">
                                    <img src="" alt="">
                                </div>
                            </div>-->

                            <!--第三-->
                            <!--<div class="form-group">
                                <label for="username" class="col-sm-3 control-label">输入新密码</label>
                                <div class="col-sm-8">
                                    <input type="text" class="form-control" id="username" placeholder="请输入新密码">
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="lastname" class="col-sm-3 control-label">确认密码</label>
                                <div class="col-sm-8">
                                    <input type="text" class="form-control" id="lastname" placeholder="再次输入新密码">
                                    <img src="" alt="">
                                </div>
                            </div>-->

                            <div class="form-group">
                                <div class="col-sm-4 col-sm-offset-4">
                                    <button type="submit" class="btn btn-primary btn-block"  style="height: 40px">下一步</button>
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