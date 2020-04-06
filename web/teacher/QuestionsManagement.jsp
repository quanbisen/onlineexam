<%--
  Created by IntelliJ IDEA.
  User: 17691
  Date: 6/3/2019
  Time: 16:27
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<html>
<head>
    <link rel="shortcut icon"  href="../image/ExamTitleIcon.ico">
    <title>This is QuestionsManagement</title>
    <link href="../css/ManagementMainStyle.css" type="text/css" rel="stylesheet">
    <link href="../css/TableStyle.css" type="text/css" rel="stylesheet">
    <script type="text/javascript">
        function onLoad() {
            //为奇数、偶数的表格行添加className
            var table = document.getElementById('table');
            var rows = table.getElementsByTagName("tr");
            for (var i = 0; i < rows.length; i++) {
                if (i % 2 == 0) {
                    rows[i].className = "evenrow";
                } else {
                    rows[i].className = "oddrow";
                }
            }
            //用作提交给Servlet后重定向的信息提示，提示发布试题是否成功
            var message = '<%=request.getParameter("message")%>';
            if (message=='success'){
                alert("发布试题成功");
                window.location.href='QuestionsManagement.jsp';
            }
            else if (message=='error') {
                alert("发布试题失败");
                window.location.href='QuestionsManagement.jsp';
            }
        }
        function downloadQuestionsTemplate() {
            window.location.href = '../excelfile/question_template.xlsx';
        }
        function checkForm() {
            var file = document.getElementById('file');
            var exam_description = document.getElementById('exam_description');
            var exam_time = document.getElementById('exam_time').value;
            if (!file.value){
                alert('请选择试题文件！');
                return false;
            }
            if (exam_description.value==null||exam_description.value.trim().length<=0){
                alert('请填写试题描述');
                return false;
            }
            if (!(/(^[1-9]\d*$)/.test(exam_time))) {
                alert('输入时间不是正整数');
                return false;
            }
            return true;
        }
    </script>
</head>
<body onload="onLoad();">
    <!--本页面处理删除发布的考试的部分-->
    <c:if test="${not empty param.exam_description_id}">  <!--如果页面的参数param.exam_description_id存在，处理删除-->
        <!--删除考试记录-->
        <sql:update var="count" dataSource="${onlineexam}">
            delete from examrecord where exam_description_id=?;
            <sql:param value="${param.exam_description_id}"></sql:param>
        </sql:update>
        <!--删除问题记录-->
        <sql:update var="count" dataSource="${onlineexam}">
            delete from questions where exam_description_id=?;
            <sql:param value="${param.exam_description_id}"></sql:param>
        </sql:update>
        <!--删除试题描述记录-->
        <sql:update var="count" dataSource="${onlineexam}">
            delete from exams_description where id=?;
            <sql:param value="${param.exam_description_id}"></sql:param>
        </sql:update>
    </c:if>

<sql:query var="exams_description" dataSource="${onlineexam}" scope="page">
    select * from exams_description order by id;
</sql:query>
<div class="title">在线考试系统
    <span class="userinfo">用户名：<c:out value="${user}"></c:out>(<c:out value="${role}"></c:out>)&nbsp;&nbsp;&nbsp;&nbsp;<a href="ModifyPassword.jsp">修改密码</a>&nbsp;&nbsp;&nbsp;&nbsp;<a href="handleTeacherExit">退出</a> </span>
</div>
<div class="centerContainer">
    <div class="leftBar">
        <ul>
            <li class="negative"><a href="TeacherIndex.jsp">首页导航</a></li>
            <li class="negative"><a href="GradeStatistic.jsp">成绩统计</a></li>
            <li><a style="background-color: #c8c8dc" href="QuestionsManagement.jsp">试题管理</a></li>
            <li class="negative"><a href="StudentManagement.jsp">考生管理</a></li>
        </ul>
    </div>
    <div class="main">
        <h4 style="text-align: center;">已发布的试题&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;总数：<c:out value="${exams_description.rowCount}"></c:out>个</h4>
        <div style="overflow: auto;height: 260px;">
            <table id="table" style="margin: 0 auto;text-align: center;">
                <tr><th style="width: 120px;text-align: center;">索引（唯一自增）</th><th style="width: 120px;text-align: center;">试题描述</th><th style="width: 120px;text-align: center;">考试时间(分钟)</th><th style="width: 60px;text-align: center;">管理</th></tr>
                <c:forEach var="row" items="${exams_description.rows}">
                    <tr><td><c:out value="${row.id}"></c:out></td><td><c:out value="${row.exam_description}"></c:out></td><td><c:out value="${row.exam_time}"></c:out></td><td><form action="#" method="get"><input type="hidden" value="<c:out value="${row.id}"></c:out>" name="exam_description_id"><input type="submit" value="删除"></form></tr>
                </c:forEach>
            </table>
        </div>
        <h4 style="text-align: center;">发布试题</h4>
        <div style="height: 480px;">
            <table style="text-align: center;margin: 0 auto;">
                <tr><th style="width: 300px;text-align: center;">请下载试题模板，根据模板的格式添加试题</th><td width="120px"><input type="button" onclick="downloadQuestionsTemplate();" value="下载模板"></td></tr>
                <tr><td colspan="2"><p style="text-align: left;padding-left: 20px;">模板说明：question是问题的描述，options是选项（用@分隔开）<br>,correct_answer是正确答案，min_score是占的分值，type是题<br>目的类型（只能是judgement或choice）</p></td></tr>
            </table>

            <form action="handleReleaseQuestions" method="post" onsubmit="return checkForm();" enctype="multipart/form-data">
            <table style="text-align: center;margin: 15px auto;">
                <tr><th style="width: 120px;text-align: center;">文件</th><th style="width: 120px;text-align: center;">试题描述</th><th style="width: 120px;text-align: center;">考试时间(分钟)</th></th><th style="width: 120px;text-align: center;">管理</th></tr>
                <tr><td><input id="file" type="file" accept=".xlsx,.xls" name="excelFile" style="width: 190px;"></td><td><input id="exam_description" type="text" name="exam_description" style="width: 120px;"> </td><td><input id="exam_time" type="text" name="exam_time" style="width: 120px;"> </td><td><input type="submit" value="发布试题" name="release"></td></tr>
            </table>
            </form>
        </div>
    </div>
</div>
<div class="footer">Copyright&nbsp;&copy;&nbsp;lollipop</div>
</body>
</html>
