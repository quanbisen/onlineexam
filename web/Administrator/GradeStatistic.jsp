<%--
  Created by IntelliJ IDEA.
  User: 17691
  Date: 6/3/2019
  Time: 16:26
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<html>
<head>
    <link rel="shortcut icon"  href="../Images/ExamTitleIcon.ico">
    <title>This is GradeStatistic</title>
    <link href="../CSS/ManagementMainStyle.css" type="text/css" rel="stylesheet">
    <link href="../CSS/TableStyle.css" type="text/css" rel="stylesheet">
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
            <li><a style="background-color: #c8c8dc" href="GradeStatistic.jsp">成绩统计</a></li>
            <li class="negative"><a href="QuestionsManagement.jsp">试题管理</a></li>
            <li class="negative"><a href="StudentManagement.jsp">考生管理</a></li>
        </ul>
    </div>
    <div class="main">
        <sql:query var="exams_description1" dataSource="${onlineexam}" scope="page">
            select * from exams_description order by id;
        </sql:query>
        <h4 style="text-align: center;">已发布的试题&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;总数：<c:out value="${exams_description1.rowCount}"></c:out>个</h4>
        <div style="overflow: auto;height: 220px;">
            <table class="table" style="margin: 0 auto;text-align: center;">
                <tr><th style="width: 142px;text-align: center;">索引（唯一自增）</th><th style="width: 142px;text-align: center;">试题描述</th><th style="width: 142px;text-align: center;">考试时间(分钟)</th><th style="width: 60px;text-align: center;">管理</th></tr>
                <c:forEach var="row" items="${exams_description1.rows}">
                    <tr>
                        <td><c:out value="${row.id}"></c:out></td>
                        <td><c:out value="${row.exam_description}"></c:out></td>
                        <td><c:out value="${row.exam_time}"></c:out></td>
                        <td>
                            <form action="GradeStatistic.jsp" method="get">
                                <input type="hidden" value="<c:out value="${row.id}"></c:out>" name="exam_description_id">
                                <input type="hidden" value="<c:out value="${row.exam_description}"></c:out>" name="exam_description">
                                <input type="submit" value="查询">
                            </form>
                    </tr>
                </c:forEach>
            </table>
        </div>
        <h4 style="text-align: center;">查询结果</h4>
        <!--这里是处理根据试题号索引唯一索引ID查询数据库的统计数据做查询结果显示的-->
        <c:if test="${not empty param.exam_description_id}">
            <!--查询已完成考试的成绩统计-->
            <sql:query var="statistic" scope="page" dataSource="${onlineexam}">
                SELECT examrecord.exam_description_id,exam_description,total_score,MAX(obtain_score) maximum,
                MIN(obtain_score) minimum,AVG(obtain_score) average FROM examrecord,exams_description where
                examrecord.exam_description_id=exams_description.id group by exam_description_id,
                exam_description,total_score having exam_description_id=?;
                <sql:param value="${param.exam_description_id}"></sql:param>
            </sql:query>
            <!--查询已完成考试的考生得分-->
            <sql:query var="exam_finished_info" scope="page" dataSource="${onlineexam}">
                SELECT users_information.id,users_information.`name`,exam_description,total_score,obtain_score
                FROM users_information, exams_description,examrecord where users_information.id=examrecord.user_id
                and exams_description.id=examrecord.exam_description_id and examrecord.exam_description_id=?
                order by users_information.id;
                <sql:param value="${param.exam_description_id}"></sql:param>
            </sql:query>
            <!--查询未完成发布试题的考生信息-->
            <sql:query var="exam_unfinished_info" scope="page" dataSource="${onlineexam}">
                select id,`name`,sex FROM users_information WHERE id not in(SELECT user_id FROM examrecord)
                UNION ALL
                SELECT users_information.id,users_information.`name`,sex FROM users_information,
                exams_description, examrecord where users_information.id=examrecord.user_id and
                exams_description.id=examrecord.exam_description_id AND users_information.id not
                in(SELECT user_id FROM examrecord where exam_description_id=?) ORDER BY id;
                <sql:param value="${param.exam_description_id}"></sql:param>
            </sql:query>
        </c:if>
        <div style="height: 520px;overflow: auto;">
            <table class="table" style="margin: 0 auto;text-align: center;">
                <tr><th style="width: 120px;text-align: center;">索引（唯一自增）</th><th style="width: 120px;text-align: center;">试题描述</th><th style="width: 60px;text-align: center;">总分</th><th style="width: 60px;text-align: center;">最高分</th><th style="width: 60px;text-align: center;">最低分</th><th style="width: 60px;text-align: center;">平均分</th></tr>
                <c:forEach var="row" items="${statistic.rows}">
                    <tr><td><c:out value="${row.exam_description_id}"></c:out></td><td><c:out value="${row.exam_description}"></c:out></td><td><c:out value="${row.total_score}"></c:out></td><td><c:out value="${row.maximum}"></c:out></td><td><c:out value="${row.minimum}"></c:out></td><td><c:out value="${row.average}"></c:out></td></tr>
                </c:forEach>
            </table>
            <table class="table" style="margin: 20px auto;text-align: center;">
                <tr><th style="width: 120px;text-align: center;">考生号</th><th style="width: 120px;text-align: center;">姓名</th><th style="width: 120px;text-align: center;">试题描述</th><th style="width: 60px;text-align: center;">总分</th><th style="width: 60px;text-align: center;">得分</th></tr>
                <c:forEach var="row" items="${exam_finished_info.rows}">
                    <tr><td><c:out value="${row.id}"></c:out></td><td><c:out value="${row.name}"></c:out></td><td><c:out value="${row.exam_description}"></c:out></td><td><c:out value="${row.total_score}"></c:out></td><td><c:out value="${row.obtain_score}"></c:out></td></tr>
                </c:forEach>
            </table>
            <h4 style="text-align: center;">未参加考试的考生</h4>
            <table class="table" style="margin: 20px auto;text-align: center;">
                <tr><th style="width: 136px;text-align: center;">考生号</th><th style="width: 136px;text-align: center;">姓名</th><th style="width: 76px;text-align: center;">性别</th><th style="width: 136px;text-align: center;">试题描述</th></tr>
                <c:forEach var="row" items="${exam_unfinished_info.rows}">
                    <tr><td><c:out value="${row.id}"></c:out></td><td><c:out value="${row.name}"></c:out></td><td><c:out value="${row.sex}"></c:out></td><td><c:out value="${param.exam_description}"></c:out></td></tr>
                </c:forEach>
            </table>
        </div>
    </div>
</div>
<div class="footer">Copyright&nbsp;&copy;&nbsp;lollipop</div>
</body>
</html>
