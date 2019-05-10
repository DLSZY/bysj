<%@page pageEncoding="UTF-8" contentType="text/html; UTF-8" %>
<%@include file="../basic/basic.jsp"%>
<!doctype html>
<html>
<head>
    <title>我的信息</title>
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
            min-height: 350px;
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
    </style>
    <script>
        $(function () {

        })
        function upload_review() {
            var img = document.getElementById("uploadimg");
            var input = document.getElementById("file_upload1");
            var tip = document.getElementById("uploadtip");

            var file = input.files.item(0);
            var freader = new FileReader();
            freader.readAsDataURL(file);
            freader.onload = function(e) {
                img.src = e.target.result;
                tip.style.display = "none";
            };
        }
    </script>
</head>
<body>

<div class="Wrapper">
<%--导航--%>
<%@include file="frontbasic/header.jsp" %>
<div class="container">
    <div class="col-sm-6 col-sm-offset-3" id="main">
        <div class="page-header" style="margin-top: 0px">
            <h3  style="margin-top: 0px">我的信息</h3>
        </div>
        <form class="form-horizontal" role="form">
            <div class="form-group">
                <label class="col-sm-3 control-label">头像</label>
                <div class="col-sm-8">
                    <label id="file_upload1_label" for="file_upload1">
                        <span id="uploadtip"></span>
                        <img id="uploadimg" src="../statics/img/cs.png" width="100" height="100" class="img-thumbnail"/>
                    </label>
                    <input type="file" name="cover" class="" id="file_upload1"	onchange="upload_review()">
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-3 control-label">用户名</label>
                <div class="col-sm-8">
                    <p class="form-control-static">xiaohei</p>
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-3 control-label">手机号</label>
                <div class="col-sm-8">
                    <p class="form-control-static">13253356287</p>
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