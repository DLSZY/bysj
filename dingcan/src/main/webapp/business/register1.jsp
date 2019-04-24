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
            //提交注册表单
            $("#re").on("click",function () {
                $.post("${app}/business/register",function (result) {

                })
            })
        })

    </script>
</head>
<body>

<div class="container-fluid">
    <div class="row text-center"style="padding-top: 30px">
        <div class="col-sm-6 col-sm-offset-3">
            <div class="col-sm-10 col-sm-offset-1">
                <div class="panel panel-default">
                    <div class="panel-body">
                        <form id="businessForm" class="form-horizontal" role="form">
                            <div class="form-group">
                                <div class="col-sm-4 col-sm-offset-4">
                                    <a id="re" class="btn btn-primary btn-block"  style="height: 40px;line-height: 28px">提交申请</a>
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