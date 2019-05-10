<%@page pageEncoding="UTF-8" contentType="text/html; UTF-8" %>
<%@include file="../basic/basic.jsp"%>
<!doctype html>
<html>
<head>
    <title>商家申请管理</title>
    <%--引入资源--%>
    <%@include file="../basic/resources.jsp"%>
    <style>
        td a{
            margin-left: 15px;
        }
    </style>
    <script>
        $(function () {
            //当浏览器大小变化时
            $(window).resize(function () {
                $("#albumList").setGridWidth($("#main").width())
            });


            $("#albumList").jqGrid({
                url:"${app}/business/findRegister",
                colNames:["用户名","密码","店铺名","省份编号","城市编号","区县编号","详细地址","手机号","申请时间","操作"],
                autowidth:true,
                styleUI:"Bootstrap",
                rowNum:2,
                height:"100%",
                datatype:"json",
                viewrecords:true,//是否显示总记录数
                pager:"#pager",
                colModel:[
                    {"name":"username"},
                    {"name":"password"},
                    {"name":"name"},
                    {"name":"provinceCode"},
                    {"name":"cityCode"},
                    {"name":"areaCode"},
                    {"name":"address"},
                    {"name":"phone"},
                    {"name":"registerTime"},
                    {
                        formatter:function (value, options, row) {
                            var content = ""
                            content += "<a href=\"javascript:pass(\'"+row.id+"\')\" ><span class='glyphicon glyphicon-ok'></span></a>"
                            content += "<a href=\"javascript:refuseModel(\'"+row.id+"\',\'"+row.username+"\')\"><span class=\"glyphicon glyphicon-remove\"></span></a>"
                            return content;
                        }
                    }
                ]
            })
        })
        //通过商家申请
        function pass(id) {
            $.post("${app}/business/passRegister",{"id":id},function (result) {
                $("#albumList").trigger("reloadGrid");
            })
        }
        //拒绝商家申请模态框
        function refuseModel(id,username) {
            $("#myModal").modal("show");
            $("#myModalLabel").text("拒绝 "+username+" 的申请")
            $("#businessId").val(id);
        }

        //拒绝商家申请
        function refuse(id){
            var businessId = $("#businessId").val();
            var reason = $("#reason").val();
            $.post("${app}/business/refuseRegister",{"businessId":businessId,reason:reason},function (result) {
                $("#myModal").modal("hide");
                $("#albumList").trigger("reloadGrid");
            })
        }
    </script>
</head>
<body>

<div class="Wrapper">
<%--导航--%>
<%@include file="backbasic/nav.jsp" %>
<div class="container-fluid">
    <div class="row">
        <%--左--%>
        <%@include file="backbasic/left.jsp" %>
        <%--右--%>
        <div class="col-sm-10" id="main">
            <div class="page-header" style="margin-top: 0px">
                <h2  style="margin-top: 0px">商家申请管理</h2>
            </div>
            <ul class="nav nav-tabs">
                <li class="active"><a href="#">申请列表</a></li>
            </ul>
            <%--列表--%>
            <table id="albumList"></table>
            <%--分页--%>
            <div id="pager"></div>

        </div>
    </div>
</div>
    <!-- 模态框（Modal） -->
    <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <h4 class="modal-title" id="myModalLabel"></h4>
                </div>
                <div class="modal-body">
                    <textarea class="form-control" id="reason" rows="4" placeholder="填写拒绝申请的原因..."></textarea>
                    <input type="text"  id="businessId" hidden>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                    <button type="button" class="btn btn-primary" onclick="refuse()">提交原因</button>
                </div>
            </div><!-- /.modal-content -->
        </div><!-- /.modal -->
    </div>
<div class="FooterPush"></div>
</div>

<%--页脚--%>
<%@include file="../basic/footer.jsp" %>
</body>
</html>

<%--专辑管理 章节管理--%>