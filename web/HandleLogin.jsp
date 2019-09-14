<%--
  Created by IntelliJ IDEA.
  User: 17691
  Date: 6/3/2019
  Time: 10:58
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <link rel="shortcut icon"  href="Images/ExamTitleIcon.ico">
    <title>Handle Login</title>
</head>
<body>

    <fmt:requestEncoding value="utf-8"></fmt:requestEncoding>
    <c:set var="user" scope="session" value="${param.username}"></c:set>  <!--取出登录功能页面输入的信息-->
    <c:set var="password" scope="session" value="${param.password}"></c:set>
    <c:set var="role" scope="session" value="${param.role}"></c:set>
    <sql:setDataSource var="onlineexam" scope="session" driver="com.mysql.jdbc.Driver" user="${initParam.user}" password="${initParam.password}" url="jdbc:mysql://127.0.0.1:3306/onlineexam?characterEncoding=utf8"></sql:setDataSource>
    <c:choose>
        <c:when test="${role eq '管理者'}">  <!--如果角色是管理者角色，查询数据库服务器记录管理者角色的数据表administrators-->
            <sql:query var="administrators" scope="session" dataSource="${onlineexam}" >
                select * from administrators where id=? and password=?;
                <sql:param value="${user}"></sql:param>
                <sql:param value="${password}"></sql:param>
            </sql:query>
            <c:if test="${administrators.rowCount>=1}"><!--行数大于等于1，证明存在id和password符合的记录，重定向到管理者角色首页-->
                <c:redirect url="/Administrator/AdministratorIndex.jsp"></c:redirect>
            </c:if>
            <c:if test="${administrators.rowCount<1}"><!--行数小于1，证明账号不存在，重定向到登录功能页面-->
                <c:redirect url="Login.jsp?message=fail"></c:redirect>
            </c:if>
        </c:when>
        <c:when test="${role eq '考生'}"> <!--如果角色是考生角色，查询数据库服务器记录考生角色的数据表users-->
            <c:out value="${role}"></c:out>
            <sql:query var="users" scope="session"  dataSource="${onlineexam}" sql="select * from users where id=? and password=?;">
                <sql:param value="${user}"></sql:param>
                <sql:param value="${password}"></sql:param>
            </sql:query>
            <c:if test="${users.rowCount>=1}"><!--行数大于等于1，证明存在id和password符合的记录，重定向到考生角色首页-->
                <c:redirect url="/Student/StudentIndex.jsp"></c:redirect>
            </c:if>
            <c:if test="${users.rowCount<1}">
                <c:redirect url="Login.jsp?message=fail"></c:redirect><!--行数小于1，证明账号不存在，重定向到登录功能页面-->
            </c:if>
        </c:when>
        <c:otherwise>
            <c:redirect url="Login.jsp"></c:redirect>
        </c:otherwise>
    </c:choose>
</body>
</html>
