<%@page pageEncoding="UTF-8" contentType="text/html; UTF-8" %>
<%@include file="../basic/basic.jsp"%>
<!doctype html>
<html>
<head>
    <title>安全设置</title>
    <%--引入资源--%>
    <%@include file="../basic/resources.jsp"%>
    <link rel="stylesheet" href="frontbasic/basic.css">
    <style>
        td a{
            margin-left: 15px;
        }
        #dropul{
            min-width: 0px;
        }
        #dropul a{
            color: gray;
            line-height: 25px !important;
            font-size: 14px;
        }
        #main{
            margin-top: 30px;
            border: 1px solid #eee;
            background-color: #fff;
            min-height: 300px;
            padding: 20px 18px;
            border-radius: 5px;
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
        td a{
            color: rgb(19,209,190);
        }
        td a:hover,
        td a:focus{
            color: rgb(115,225,206) !important;
        }
        #file_upload1 {
            display: none;
        }
        #file_upload1_label {
            display: inline-block;
            text-align: center;
            cursor: pointer;
        }
        #uploadimg{
            width: 100px;
            height: 100px;
        }
        .btn-primary{
            background-color: rgb(19,209,190);
            border-color: rgb(19,209,190);
            width: 150px;
        }
        .btn-primary:hover,
        .btn-primary:active{
            background-color: rgb(115,225,206) !important;
            border-color: rgb(115,225,206) !important;
        }
    </style>
    <script>
        $(function () {
            $.post("${app}/user/judge",function (result) {
                if(result == ""){
                    window.location.href="${app}/front/login.jsp"
                }
            })
            $("#changeBtn").on("click",function () {
                var oldPass = $("#oldPass").val();
                var newPass = $("#newPass").val();
                var reNewPass = $("#reNewPass").val();
                var reg = /^[A-Za-z0-9]+$/;//正则表达式
                console.log(reg.test(newPass));
                if(oldPass == ""){
                    alert("请输入原密码~_~")
                }else{
                    if(newPass == ""){
                        alert("请输入新密码~_~")
                    }else if(!reg.test(newPass)){
                        alert("密码中不能包括中文或特殊字符")
                    } else if(newPass.length < 6){
                        alert("密码长度不能小于6")
                    }else if(newPass == reNewPass){
                        $.post("${app}/user/changePass",$("#iofoFrom").serialize(),function (result) {
                            if(result.success == true){
                                alert(result.msg);
                                $('#iofoFrom')[0].reset();
                            }else{
                                alert(result.msg);
                            }
                        })
                    }else{
                        alert("两次输入密码不正确~~")
                    }
                }


            })
        })

    </script>
</head>
<body>

<div class="Wrapper">
<%--导航--%>
<%@include file="frontbasic/header.jsp" %>
<div class="container">
    <div class="col-sm-6 col-sm-offset-3" id="main">
        <div class="page-header" style="margin-top: 0px">
            <h3  style="margin-top: 0px">修改密码</h3>
        </div>
        <form class="form-horizontal" role="form" id="iofoFrom">
            <div class="form-group">
                <label class="col-sm-3 control-label">原始密码</label>
                <div class="col-sm-8">
                    <input type="text" name="oldPassword" class="form-control" id="oldPass" placeholder="请输入原始密码">
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-3 control-label">新密码</label>
                <div class="col-sm-8">
                    <input type="text" name="newPassword" class="form-control" id="newPass" placeholder="请输入新密码">
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-3 control-label">确认密码</label>
                <div class="col-sm-8">
                    <input type="text"  class="form-control" id="reNewPass" placeholder="再次输入新密码">
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-3 control-label"></label>
                <div class="col-sm-12">
                    <td id="p" ><a class="btn btn-primary center-block" id="changeBtn">确认修改</a> </td>
                </div>
            </div>

        </form>
    </div>
</div>

<div class="FooterPush"></div>
</div>

<%--页脚--%>
</body>
</html>

<%--专辑管理 章节管理--%>