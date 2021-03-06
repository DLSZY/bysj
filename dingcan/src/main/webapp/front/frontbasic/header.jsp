<%@page pageEncoding="UTF-8" contentType="text/html; UTF-8" %>
<nav class="navbar" role="navigation" style="background-color: rgb(19,209,190);; border: none; margin-bottom: 8px">
    <div class="container">
        <!-- Brand and toggle get grouped for better mobile display -->
        <div class="navbar-header" style="margin-right: 20px">
            <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="./index.jsp" id="logo">DLSZ</a>
        </div>

        <!-- Collect the nav links, forms, and other content for toggling -->
        <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
            <ul class="nav navbar-nav navul">
                <li style="height: 100%"><a href="${app}/front/index.jsp">首页</a></li>
                <li style="height: 100%"><a href="${app}/front/cart.jsp">我的购物车</a></li>
                <li style="height: 100%"><a href="${app}/front/order.jsp">我的订单</a></li>
            </ul>
            <ul class="nav navbar-nav navbar-right navul">
                <li class="dropdown" style="height: 100%">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                        ${sessionScope.username} <b class="caret"></b>
                    </a>
                    <ul class="dropdown-menu" id="dropul">
                        <li><a href="${app}/front/information.jsp">个人中心</a></li>
                        <li><a href="${app}/front/address.jsp">我的地址</a></li>
                        <li><a href="${app}/front/change.jsp">安全设置</a></li>
                        <li class="divider"></li>
                        <li><a href="javascript:exit()">退出登录</a></li>
                        <script>
                            function exit() {
                                $.post("${app}/user/exit",function (result) {
                                    window.location.href="${app}/front/login.jsp"
                                })
                            }
                        </script>
                    </ul>
                </li>
            </ul>
        </div>
    </div>
</nav>