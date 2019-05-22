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
    <title>商家注册</title>
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
    </style>

    <script>
        $(function () {
            /*设置号码*/
            var phone = ${param.phone}
            $("#phone").val(phone);

            /*设置省份*/
            $.post("${app}/address/findAllProvince",function (result) {
                for(var i =0; i<result.length; i++){
                    var option = $("<option>").val(result[i].code).text(result[i].name);
                    $("#provinceSelect").append(option);
                }
            })

            /*省份改变获取市区*/
            $("#provinceSelect").on("change",function () {
                $("#citySelect").empty();
                $.post("${app}/address/findCity",{"provinceId":this.value},function (result) {
                    for(var i =0; i<result.length; i++){
                        var option = $("<option>").val(result[i].code).text(result[i].name);
                        $("#citySelect").append(option);
                    }
                    changeArea(result[0].code)
                })
            })

            /*市区改变获取区县*/
            $("#citySelect").on("change",function () {
                changeArea(this.value)
            })

            //提交注册表单
            $("#register").on("click",function () {
                $.post("${app}/business/register",$("#businessForm").serialize(),function (result) {
                    alert("提交完成~~等待管理员审核")
                    window.location.href="${app}/business/login.jsp";
                })
            })



        })
        function changeArea(cityCode) {
            $("#areaSelect").empty();
            $.post("${app}/address/findArea",{"cityCode":cityCode},function (result) {
                for(var i =0; i<result.length; i++){
                    var option = $("<option>").val(result[i].code).text(result[i].name);
                    $("#areaSelect").append(option);
                }
            })
        }
    </script>
</head>
<body>
<nav class="navbar navbar-inverse" role="navigation" style="background-color: #337ab7; border-color: #337ab7;">
    <div class="container-fluid">
        <div class="collapse navbar-collapse text-center"  id="example-navbar-collapse">
            <span class="navbar-text" style="color: white; font-weight: bold; font-size: 20px">商家注册中心</span>
        </div>
    </div>
</nav>
<div class="container-fluid">
    <div class="row text-center"style="padding-top: 30px">
        <div class="col-sm-6 col-sm-offset-3">
            <div class="col-sm-10 col-sm-offset-1">
                <div class="panel panel-default">
                    <div class="panel-body">
                        <p><h4>商家注册</h4></p>
                        <p class="text-muted" >填写您的店铺信息</p>
                        <div class="col-sm-10 col-sm-offset-1">
                            <hr>
                        </div>
                        <form id="businessForm" class="form-horizontal" role="form">
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
                                <label  class="col-sm-2 control-label">店铺名</label>
                                <div class="col-sm-9">
                                    <input type="text" class="form-control" name="name" placeholder="请输入店铺名">
                                </div>
                            </div>
                            <div class="form-group">
                                <label  class="col-sm-2 control-label">选择地址</label>
                                <div class="col-sm-3">
                                    <select class="form-control" id="provinceSelect" name="provinceCode">
                                        <option selected disabled>省份</option>
                                    </select>
                                </div>
                                <div class="col-sm-3">
                                    <select class="form-control" id="citySelect" name="cityCode">
                                        <option>城市</option>
                                    </select>
                                </div>
                                <div class="col-sm-3">
                                    <select class="form-control" id="areaSelect" name="areaCode">
                                        <option>区县</option>
                                    </select>
                                </div>
                            </div>
                            <div class="form-group">
                                <label  class="col-sm-2 control-label">详细地址</label>
                                <div class="col-sm-9">
                                    <input type="text" name="address" class="form-control" placeholder="请输入详细地址">
                                </div>
                            </div>
                            <div class="form-group">
                                <label  class="col-sm-2 control-label">联系方式</label>
                                <div class="col-sm-9">
                                    <input type="text" class="form-control" name="phone" id="phone" placeholder="请输入联系方式" readonly>
                                </div>
                            </div>


                            <div class="form-group">
                                <div class="col-sm-4 col-sm-offset-4">
                                    <a id="register" class="btn btn-primary btn-block"  style="height: 40px;line-height: 28px">提交申请</a>
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