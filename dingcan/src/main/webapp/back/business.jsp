<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="basic/basic.jsp"%>
<!doctype html>
<html>
<head>
    <title>商家管理</title>
    <%--引入资源--%>
    <%@include file="basic/resources.jsp"%>
    <style>
        td a{
            margin-left: 15px;
        }
        #imgDiv{
            position: absolute;
            right: 50px;
        }

    </style>
    <script>
        $(function () {
            //当浏览器大小变化时
            $(window).resize(function () {
                $("#albumList").setGridWidth($("#main").width())
            });
            //文件上传
            $("#editBtn").on("click",function () {
                var formData = new FormData($("#fileForm")[0]);
                $.ajax({
                    url:"${app}/album/edit",
                    type:"POST",
                    data:formData,
                    processData: false,  // 告诉jQuery不要去处理发送的数据
                    contentType: false,   // 告诉jQuery不要去设置Content-Type请求头
                    success: function(result){
                        $("#albumList").trigger("reloadGrid");
                        $("#myModal").modal("hide");
                    }
                });
            })


            $("#albumList").jqGrid({
                url:"${app}/album/findByPage",
                colNames:["专辑名称","专辑分数","专辑播音","专辑作者","专辑描述","上传时间","章节数量","专辑封面","专辑状态","操作"],
                autowidth:true,
                styleUI:"Bootstrap",
                rowNum:2,
                height:"100%",
                datatype:"json",
                viewrecords:true,//是否显示总记录数
                pager:"#pager",
                colModel:[
                    {"name":"title"},
                    {"name":"grade"},
                    {"name":"broadcast"},
                    {"name":"author"},
                    {"name":"description"},
                    {"name":"publishDate",width: "210px"},
                    {"name":"count"},
                    {"name":"coverImg","width":"200px"},
                    {"name":"status",
                        formatter:function (value, options, row) {
                            if(value == 1) return "激活"
                            else return "冻结"
                        }
                    },
                    {
                        formatter:function (value, options, row) {
                            var path = row.coverImg.replace(/\\/g,"/");
                            var content = ""
                            content += "<a href=\"javascript:show(\'"+path+"\',\'"+row.id+"\')\" ><span class='glyphicon glyphicon-search'></span></a>"
                            content += "<a href=\"javascript:findOne(\'"+row.id+"\')\"><span class=\"glyphicon glyphicon-pencil\"></span></a>"
                            content += "<a href=\"javascript:deleteAlbum(\'"+row.id+"\',\'"+row.coverImg+"\')\"><span class=\"glyphicon glyphicon-remove\"></span></a>"
                            return content;
                        }
                    }
                ]
            })
        })


        //添加
        function addModel() {
            //添加时让分数显示的为请选择分数
            $("#sele").attr({"selected":true,"disabled":true})
            var goptions = $("#grade option");
            for(var i = 1; i<goptions.length;i++){
                $(goptions[i]).attr("selected",false)
            }

            $("#fileForm")[0].reset();
            $("#fileForm input").attr("disabled",false);
            $("#fileForm select").attr("disabled",false);
            $("#titleDiv,#gradeDiv,#broadcastDiv").removeClass("col-sm-6").addClass("col-sm-9");

            $("#imgDiv").hide();
            $("#publishDateDiv").hide();
            $("#countDiv").hide();
            $("#id").val("");
            $("#statusDiv").hide()
            $("#fileDiv").show()
            $("#editBtn").show().text("添加");
            $("#delBtn").show();

            $("#myModalLabel").text("添加专辑")
            $('#myModal').modal('show')
        }
        //显示详情
        function show(path,id) {
            $("#fileForm input").attr("disabled",true);
            $("#fileForm select").attr("disabled",true);
            $("#myModalLabel").text("显示专辑信息")
            $("#titleDiv,#gradeDiv,#broadcastDiv").removeClass("col-sm-3").addClass("col-sm-6");

            $("#statusDiv").show();
            $("#fileDiv").hide();
            $("#imgDiv").show();
            $("#publishDateDiv").show();
            $("#countDiv").show();
            $("#editBtn").hide();
            $("#delBtn").hide();

            $.post("${app}/album/findOne",{"id":id},function (result) {
                $("#title").val(result.title);
                $("#broadcast").val(result.broadcast);
                $("#author").val(result.author);
                $("#description").val(result.description);
                $("#publishDate").val(result.publishDate);
                $("#count").val(result.count);
                $("#albumImg").attr("src","./upload/albumImg/"+result.coverImg)
                var goptions = $("#grade option");
                for(var i = 1; i<goptions.length;i++){
                    if(result.grade == $(goptions[i]).val())
                        $(goptions[i]).attr("selected",true)
                    else $(goptions[i]).attr("selected",false)
                }
                var soptions = $("#status option");
                for(var i = 1; i<soptions.length;i++){
                    if(result.status == $(soptions[i]).val())
                        $(soptions[i]).attr("selected",true)
                    else $(soptions[i]).attr("selected",false)
                }
                $("#myModal").modal('show')
            })
        }
        //修改时回显
        function findOne(id) {
            $("#myModalLabel").text("修改专辑信息")
            $("#fileForm input").attr("disabled",false);
            $("#fileForm select").attr("disabled",false);
            $("#titleDiv,#gradeDiv,#broadcastDiv").removeClass("col-sm-6").addClass("col-sm-9");

            $("#imgDiv").hide();
            $("#fileDiv").show();
            $("#statusDiv").show();
            $("#publishDateDiv").hide();
            $("#countDiv").hide();
            $("#editBtn").show().text("修改");
            $("#delBtn").show();

            $.post("${app}/album/findOne",{"id":id},function (result) {
                $("#id").val(result.id)
                $("#title").val(result.title);
                $("#broadcast").val(result.broadcast);
                $("#author").val(result.author);
                $("#description").val(result.description);
                $("#publishDate").val(result.publishDate);
                $("#count").val(result.count);
                var goptions = $("#grade option");
                for(var i = 1; i<goptions.length;i++){
                    if(result.grade == $(goptions[i]).val())
                        $(goptions[i]).attr("selected",true)
                    else $(goptions[i]).attr("selected",false)
                }
                var soptions = $("#status option");
                for(var i = 1; i<soptions.length;i++){
                    if(result.status == $(soptions[i]).val())
                        $(soptions[i]).attr("selected",true)
                    else $(soptions[i]).attr("selected",false)
                }
                $("#myModal").modal('show')
            })
        }
        //删除
        function deleteAlbum(id,imgPath) {
            var b = window.confirm("是否要删除?");
            if(b == true){
                $.post("${app}/album/delete",{"id":id,"imgPath":imgPath});
                $("#albumList").trigger("reloadGrid");
            }
        }
    </script>
</head>
<body>

<div class="Wrapper">
<%--导航--%>
<%@include file="basic/nav.jsp" %>
<div class="container-fluid">
    <div class="row">
        <%--左--%>
        <%@include file="basic/left.jsp" %>
        <%--右--%>
        <div class="col-sm-10" id="main">
            <div class="page-header" style="margin-top: 0px">
                <h2  style="margin-top: 0px">商家管理</h2>
            </div>
            <ul class="nav nav-tabs">
                <li class="active"><a href="#">专辑列表</a></li>
                <li><a href="javascript:addModel()">专辑添加</a></li>
            </ul>

            <%--列表--%>
            <table id="albumList"></table>
            <%--分页--%>
            <div id="pager"></div>

        </div>
    </div>
</div>

<!-- 添加修改模态框（Modal） -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog" id="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="myModalLabel">添加专辑</h4>
            </div>

            <div class="modal-body">
                <form class="form-horizontal" role="form" id="fileForm">
                    <div class="form-group">
                        <label for="title" class="col-sm-2 control-label">专辑名称</label>
                        <div class="col-sm-6" id="titleDiv">
                            <input type="hidden" id="id" class="form-control"  name="id">
                            <input type="text" class="form-control" id="title" name="title" placeholder="请输入专辑名称">
                        </div>
                        <div class="col-sm-3" id="imgDiv">
                            <img src="" alt="" class="img-thumbnail" id="albumImg">
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="grade" class="col-sm-2 control-label">专辑分数</label>
                        <div class="col-sm-6" id="gradeDiv">
                            <select  class="form-control" name="grade" id="grade">
                                <option id="sele" value="0" selected="selected" disabled="disabled">请选择专辑分数</option>
                                <option value="1">1</option>
                                <option value="2">2</option>
                                <option value="3">3</option>
                                <option value="4">4</option>
                                <option value="5">5</option>
                                <option value="6">6</option>
                                <option value="7">7</option>
                                <option value="8">8</option>
                                <option value="9">9</option>
                                <option value="10">10</option>
                            </select>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="broadcast" class="col-sm-2 control-label">专辑播音</label>
                        <div class="col-sm-6" id="broadcastDiv">
                            <input type="text" class="form-control" name="broadcast" id="broadcast" placeholder="请输入专辑播音">
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="author" class="col-sm-2 control-label">专辑作者</label>
                        <div class="col-sm-9">
                            <input type="text" class="form-control" name="author" id="author" placeholder="请输入专辑作者">
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="description" class="col-sm-2 control-label">专辑描述</label>
                        <div class="col-sm-9">
                            <input type="text" class="form-control" name="description" id="description" placeholder="请输入图片描述">
                        </div>
                    </div>

                    <div class="form-group" id="publishDateDiv">
                        <label for="publishDate" class="col-sm-2 control-label">上传时间</label>
                        <div class="col-sm-9">
                            <input type="text" class="form-control" id="publishDate" placeholder="请输入图片描述">
                        </div>
                    </div>

                    <div class="form-group" id="countDiv">
                        <label for="count" class="col-sm-2 control-label">章节数量</label>
                        <div class="col-sm-9">
                            <input type="text" class="form-control" name="count" id="count" placeholder="请输入章节数量">
                        </div>
                    </div>
                    <div class="form-group" id="statusDiv">
                        <label for="status" class="col-sm-2 control-label">专辑状态</label>
                        <div class="col-sm-9">
                            <select class="form-control" id="status" name="status">
                                <option value="1">激活</option>
                                <option value="0">冻结</option>
                            </select>
                        </div>
                    </div>

                    <div class="form-group" id="fileDiv">
                        <label for="coverImg" class="col-sm-2 control-label">专辑封面</label>
                        <div class="col-sm-9">
                            <input type="file" id="coverImg" name="multipartFile">
                        </div>
                    </div>

                </form>
            </div>
            <div class="modal-footer" id="butDiv">
                <button type="button" class="btn btn-default" data-dismiss="modal" id="delBtn">关闭</button>
                <button type="button" class="btn btn-primary" id="editBtn">添加</button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal -->
</div>

<!-- 显示详情模态框（Modal） -->
<div class="modal fade" id="MyModal1" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title">查看轮播图</h4>
            </div>
            <div class="modal-body">
                <div class="form-group">
                    <label class="col-sm-2 control-label">Email</label>
                    <div class="col-sm-10">
                        <p class="form-control-static" id="showTitle">email@example.com</p>
                    </div>
                </div>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal -->
</div>

<div class="FooterPush"></div>

</div>

<%--页脚--%>
<%@include file="basic/footer.jsp" %>
</body>
</html>

<%--专辑管理 章节管理--%>