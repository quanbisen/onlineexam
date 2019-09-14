<%--
  Created by IntelliJ IDEA.
  User: 17691
  Date: 6/2/2019
  Time: 17:23
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <link rel="shortcut icon"  href="Images/ExamTitleIcon.ico">
    <title>This is Login Page</title>
</head>
<link rel="stylesheet" href="CSS/LoginStyle.css" type="text/css">
<script type="text/javascript">
    function  onLoad() {
        var message = '<%=request.getParameter("message")%>';
        if (message == 'fail'){
            alert('用户名或密码错误！');
            window.location.href='Login.jsp';
        }
    }
    function onSubmit() {
        var username = document.getElementById('username');
        var password = document.getElementById('password');
        if (username.value==""||username.value==null||password.value==""||username.value==null){
            alert("请完整输入用户名和密码");
            return false;
        }
        else {
            return true;
        }
    }
</script>
<body onload="onLoad()">
    <div class="title">在线考试系统</div>
    <div class="main">
        <form action="HandleLogin.jsp" method="post" name="form" onsubmit="return onSubmit()">
            <table>
                <tr><td colspan="2"><div class="info">用户登录&nbsp/&nbsp<strong>LOGIN</strong></div></td></tr>
                <tr>
                    <td width="70px"><img src="Images/UserNameIcon.png" width="20px" height="20px"><span>用户名：</span></td>
                    <td><input id="username" type="text" name="username"></td>
                </tr>
                <tr>
                    <td><img src="Images/UserPasswordIcon.png" width="20px" height="20px"><span>密&nbsp&nbsp&nbsp&nbsp码：</span></td>
                    <td><input id="password" type="password" name="password"></td>
                </tr>
                <tr>
                    <td colspan="2"><input class="radio" type="radio" checked name="role" value="管理者">管理者<input class="radio" type="radio" name="role" value="考生">考生</td>
                </tr>
                <tr>
                    <td colspan="2"><input class="button" type="submit" value="登录" name="submit"><input class="button" type="reset" name="reset" value="重置"></td>
                </tr>
            </table>
        </form>
    </div>
    <div class="footer">Copyright&nbsp;&copy;&nbsp;lollipop</div>
</body>
</html>
