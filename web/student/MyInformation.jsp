<%--
  Created by IntelliJ IDEA.
  User: 17691
  Date: 6/5/2019
  Time: 13:05
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<html>
<head>
    <link rel="shortcut icon"  href="../image/ExamTitleIcon.ico">
    <title>This is MyInformation</title>
    <link href="../css/ManagementMainStyle.css" type="text/css" rel="stylesheet">
    <link href="../css/TableStyle.css" type="text/css" rel="stylesheet">
</head>
<style type="text/css">
    form{
        margin-block-end: 0px;
    }
</style>
<script type="text/javascript">
    function onLoad() {
        //为奇数、偶数的表格行添加className
        var tables = document.getElementsByClassName('table')
        for (var i = 0; i < tables.length; i++) {
            var rows = tables[i].getElementsByTagName("tr");
            for (var j = 0; j < rows.length; j++) {
                if (j % 2 == 0) {
                    rows[j].className = "evenrow";
                } else {
                    rows[j].className = "oddrow";
                }
            }
        }
        //处理页面提示的部分，上传成功或失败都重定向到本页面，所以添加提示处理
        var message = '<%=request.getParameter("message")%>';
        if (message=='success'){
            alert("头像上传成功");
            window.location.href="MyInformation.jsp";
        }
        else if (message=='error'){
            alert("头像上传失败");
            window.location.href="MyInformation.jsp";
        }
    }
    function checkForm() {
        var file = document.getElementById('file');
        if (!file.value){
            alert('请选择图片文件！');
            return false;
        }
    }
</script>

<body onload="onLoad();">
<div class="title">在线考试系统
    <span class="userinfo">用户名：<c:out value="${user}"></c:out>(<c:out value="${role}"></c:out>)&nbsp;&nbsp;&nbsp;&nbsp;<a href="ModifyPassword.jsp">修改密码</a>&nbsp;&nbsp;&nbsp;&nbsp;<a href="handleStudentExit">退出</a> </span>
</div>
<div class="centerContainer">
    <div class="leftBar">
        <ul>
            <li class="negative"><a href="StudentIndex.jsp">首页导航</a></li>
            <li class="negative"><a href="MyExam.jsp">我的考试</a></li>
            <li ><a style="background-color: #c8c8dc" href="MyInformation.jsp">我的信息</a></li>
        </ul>
    </div>
    <div class="main" style="overflow: auto">
        <h4 style="text-align: center;">如信息有误，请联系管理者更改详细信息</h4>
        <div style="text-align: center;" >
            <!--根据考生id查询数据库中用户的信息-->
            <sql:query var="user_information" scope="page" dataSource="${onlineexam}">
                select id,name,sex,exam_reason,picture from users_information where id=?;
                <sql:param value="${user}"></sql:param>
            </sql:query>
            <!--如果查询的信息不为空，存储在变量中-->
            <c:if test="${not empty user_information}">
                <c:forEach var="row" items="${user_information.rows}" step="1" begin="0" end="0">
                    <c:set var="id" value="${row.id}"></c:set>
                    <c:set var="name" value="${row.name}"></c:set>
                    <c:set var="sex" value="${row.sex}"></c:set>
                    <c:set var="exam_reason" value="${row.exam_reason}"></c:set>
                    <c:set var="picture" value="${row.picture}"></c:set>
                </c:forEach>
            </c:if>
            <table class="table" style="text-align: center;margin: 0 auto;line-height: 2.9em;">
                <tr><th width="120px" style="text-align: center;">考生号：</th><td width="120px"><c:out value="${id}"></c:out></td><th width="120px" style="text-align: center;">姓名：</th><td width="120px"><c:out value="${name}"></c:out></td><td rowspan="3"><img title="头像" style="padding: 1px;" src="<c:out value="${picture}"></c:out>" width="120px" height="120px"></td></tr>
                <tr><th style="text-align: center;">性别：</th><td><c:out value="${sex}"></c:out> </td><th style="text-align: center;">考试理由：</th><td><c:out value="${exam_reason}"></c:out> </td></tr>
                <tr><th style="text-align: center;">头像url：</th><td colspan="3"><c:out value="${picture}"></c:out></td></tr>
            </table>
        </div>
        <div style="text-align: center">
            <h5 style="text-align: center;">头像更改上传(图片比例最好是1：1)</h5>
            <form action="HandleUploadImage" method="post" enctype="multipart/form-data" onsubmit="return checkForm();">
                <input id="file" type="file" accept="image/*" name="uploadFile"><input type="submit" name="submit" value="上传">
            </form>
        </div>
    </div>
</div>
<div class="footer">Copyright&nbsp;&copy;&nbsp;lollipop</div>
</body>
</html>
