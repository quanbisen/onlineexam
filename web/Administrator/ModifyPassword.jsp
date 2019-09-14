<%--
  Created by IntelliJ IDEA.
  User: 17691
  Date: 6/3/2019
  Time: 17:01
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<html>
<head>
    <link rel="shortcut icon"  href="../Images/ExamTitleIcon.ico">
    <title>This is ModifyPassword</title>
    <link href="../CSS/ManagementMainStyle.css" type="text/css" rel="stylesheet">
    <link href="../CSS/ModifyPasswordFormStyle.css" type="text/css" rel="stylesheet">
    <script type="text/javascript">
        function onLoad() {
            var message ='<%=request.getParameter("message")%>';
            if(message=='success'){
                alert("密码修改成功");
                window.location.href = 'ModifyPassword.jsp';
            }
            else if(message=='fail'){
                alert("密码修改失败");
                window.location.href = 'ModifyPassword.jsp';
            }
            //确认弹框初始化不显示
            var PauseAreaHtml = document.getElementById("PauseAreaHtml");
            PauseAreaHtml.style.display = 'none';
        }
        function onSubmit() {
            var password = document.getElementById('password');
            var repeat_password = document.getElementById('repeat_password');
            if (repeat_password.value==""||repeat_password.value==null||password.value==""||password.value==null){
                alert("请完整密码和确认密码！");
                return false;
            }
            else if(password.value!=repeat_password.value){
                alert("两次输入的密码不一致，请重新输入！");
                return false;
            }
            else {
                return true;
            }
        }
    </script>
</head>
<body onload="onLoad();">
<div class="title">在线考试系统
    <span class="userinfo">用户名：<c:out value="${user}"></c:out>(<c:out value="${role}"></c:out>)&nbsp;&nbsp;&nbsp;&nbsp;<a href="ModifyPassword.jsp">修改密码</a>&nbsp;&nbsp;&nbsp;&nbsp;<a href="handleAdministratorExit">退出</a> </span>
</div>
<div class="centerContainer">
    <div class="leftBar">
        <ul>
            <li class="negative"><a href="AdministratorIndex.jsp">首页导航</a></li>
            <li class="negative"><a href="GradeStatistic.jsp">成绩统计</a></li>
            <li class="negative"><a href="QuestionsManagement.jsp">试题管理</a></li>
            <li class="negative"><a href="StudentManagement.jsp">考生管理</a></li>
        </ul>
    </div>
    <div class="main">
        <div class="div_form">
            <form action="ModifyPassword" id="form" method="post" name="form" onsubmit="return onSubmit()">
                <table>
                    <tr><td colspan="2"><div class="info">修改密码&nbsp/&nbsp<strong>Modify Password</strong></div></td></tr>
                    <tr>
                    <c:choose>
                        <c:when test="${role eq '管理者'}">
                            <c:forEach var="row" items="${administrators.rows}" begin="0" end="1" step="1">
                                <c:set var="password" value="${row.password}"></c:set>
                            </c:forEach>
                        </c:when>
                    </c:choose>
                        <td width="90px"><img src="../Images/UserPasswordIcon.png" width="20px" height="20px"><span>新&nbsp&nbsp密&nbsp&nbsp码：</span></td>
                        <td><input id="password" type="password" name="password" value="<c:out value="password"></c:out>"></td>
                    </tr>
                    <tr>
                        <td><img src="../Images/UserPasswordIcon.png" width="20px" height="20px"><span>确定密码：</span></td>
                        <td><input id="repeat_password" type="password" name="repeat_password" value="<c:out value="password"></c:out>"></td>
                    </tr>
                    <tr>
                        <td colspan="2"><input class="button" type="submit" value="确定"  name="submit"><input class="button" type="reset" name="reset" value="重置"></td>
                    </tr>
                </table>
            </form>
        </div>
    </div>
</div>
<div class="footer">Copyright&nbsp;&copy;&nbsp;lollipop</div>
</body>
</html>