<%--
  Created by IntelliJ IDEA.
  User: 17691
  Date: 6/3/2019
  Time: 12:43
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <link rel="shortcut icon"  href="../image/ExamTitleIcon.ico">
    <title>This is AdministratorIndex</title>
    <link href="../css/ManagementMainStyle.css" type="text/css" rel="stylesheet">
</head>
<body>
    <div class="title">在线考试系统
        <span class="userinfo">用户名：<c:out value="${user}"></c:out>(<c:out value="${role}"></c:out>)&nbsp;&nbsp;&nbsp;&nbsp;<a href="ModifyPassword.jsp">修改密码</a>&nbsp;&nbsp;&nbsp;&nbsp;<a href="handleTeacherExit">退出</a> </span>
    </div>
    <div class="centerContainer">
        <div class="leftBar">
            <ul>
                <li><a style="background-color: #c8c8dc" href="TeacherIndex.jsp">首页导航</a></li>
                <li class="negative"><a href="GradeStatistic.jsp">成绩统计</a></li>
                <li class="negative"><a href="QuestionsManagement.jsp">试题管理</a></li>
                <li class="negative"><a href="StudentManagement.jsp">考生管理</a></li>
            </ul>
        </div>
        <div class="main">
            <div style="text-align: center;">
                <h1>欢迎来到在线考试系统！</h1>
            </div>
        </div>
    </div>
    <div class="footer">Copyright&nbsp;&copy;&nbsp;lollipop</div>
</body>
</html>
