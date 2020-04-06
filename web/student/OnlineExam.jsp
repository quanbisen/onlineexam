<%@ page import="bean.OnlineExamBean" %><%--
  Created by IntelliJ IDEA.
  User: 17691
  Date: 6/7/2019
  Second: 17:49
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html>
<head>
    <link rel="shortcut icon"  href="../image/ExamTitleIcon.ico">
    <title>This is OnlineExam</title>
    <link href="../css/ManagementMainStyle.css" type="text/css" rel="stylesheet">
</head>
<style type="text/css">
    .main-box{
        width: 1000px;
        padding: 10px;
        margin: 0 auto;
        border: 1px solid #DCDCDC;
        background: #F2F2F2;
    }
    .item{
        text-align: center;
        margin: 5px;
        float: left;
        width: 30px;
        height: 30px;
        border-style: solid;
        border-width: 1px;
        border-radius: 15px;
    }
    .item-navigator{
        text-decoration: none;
        line-height: 30px;
    }
    form{
        margin-block-end: 0em;
        display: inline;
    }
    .options{
        font-size: 20px;
        padding: 7px 12px 5px 12px;
        margin: 0 0 0 7px;
    }
    #currentflag{
        background-color: #F5F5DC;
    }
</style>
<script type="text/javascript">
    var timer;      //存储定时器的ID值，可以控制停止
    function onLoad() {
        //如果浏览器session存储了time，处理页面刷新设置显示时间
        if (window.sessionStorage.getItem("Second") != null) {
            var Second = window.sessionStorage.getItem("Second");
            var minutes = Math.floor(Second/60);
            var seconds = Second%60;
            var secondsStr = seconds.toString();
            if (seconds<10){
                secondsStr = "0"+secondsStr;
            }
            var show_time = document.getElementById("show_time");
            show_time.innerText=minutes+':'+secondsStr;  //设置网页的事件显示
        }
        //设置定时器，每一秒钟执行一次
        timer = setInterval(function () {
            var exam_minutes = '<%=request.getParameter("exam_time")%>';  //exam_time是从数据库服务器查询到的考题时间限制
            var Second = exam_minutes*60;  //时间，单位：秒
            if (window.sessionStorage.getItem("Second")!=null){  //判断浏览器的session存储的“Second”属性变量是否存在，存在则取出
                Second = window.sessionStorage.getItem("Second");
            }
            if (Second<=0){  //如果时间的秒数小于等于0，停止计时器，自动交卷
                clearInterval(timer);
                window.sessionStorage.removeItem("Second");
                var submit_to_handleScore = document.getElementById("submit_to_handleScore");
                alert("时间到，自动交卷");
                submit_to_handleScore.submit();
            }
            else {  //否则秒数减1，并把秒数转话成mm：ss的格式显示给考生
                Second=Second-1;
                window.sessionStorage.setItem("Second",Second);
                var minutes = Math.floor(Second/60);
                var seconds = Second%60;
                var secondsStr = seconds.toString();
                if (seconds<10){
                    secondsStr = "0"+secondsStr;
                }
                var show_time = document.getElementById("show_time");
                show_time.innerText=minutes+':'+secondsStr;  //设置网页的时间显示
            }
        },1000);
    }
    function navigatorClick(i) {
        i = i-1;//由于数组从0开始，所以这个索引需要减一
        var items = document.getElementsByClassName('item');
        for (var j=0;j<items.length;j++){
            if (j==i) {
                items[j].style.backgroundColor='#00FFFF';
            }
            else {
                items[j].style.backgroundColor='#F2F2F2';
            }
        }
    }
    function showConfirmDialog() {
        if(confirm("你还没有交卷，确定退出考试吗？须知：退出没有成绩。")){
            //页面离开清除本地浏览器的session存储
            clearInterval(timer);
            window.sessionStorage.removeItem("Second");
            return true;
        }
        else {
            return false;
        }
    }
</script>
<body onload="onLoad();">
<div class="title">在线考试系统
    <span class="userinfo">用户名：<c:out value="${user}"></c:out>(<c:out value="${role}"></c:out>)&nbsp;&nbsp;&nbsp;&nbsp;<a href="ModifyPassword.jsp" onclick="return showConfirmDialog();">修改密码</a>&nbsp;&nbsp;&nbsp;&nbsp;<a href="handleStudentExit" onclick="return showConfirmDialog();">退出</a> </span>
</div>
<div class="centerContainer">
    <div class="leftBar">
        <ul>
            <li class="negative"><a href="StudentIndex.jsp" onclick="return showConfirmDialog();">首页导航</a></li>
            <li class="negative"><a href="MyExam.jsp" onclick="return showConfirmDialog();">我的考试</a></li>
            <li class="negative"><a href="MyInformation.jsp" onclick="return showConfirmDialog();">我的信息</a></li>
        </ul>
    </div>
    <div class="main">
        <div style="text-align: center;">
            <h1>注意：单击交卷按钮之前离开本页面没成绩！</h1>
        </div>
        <!--先取出考生的ID号-->
        <c:forEach var="row" items="${users.rows}" begin="0" end="1">
            <c:set var="id" value="${row.id}"></c:set>
        </c:forEach>

        <!--如果第一次进入此页面，sessionScope.questions是为空的，执行插入数据操作，标记此考生已经考了这个考试，防止重复考刷分-->
        <c:if test="${empty sessionScope.questions}">
            <c:set var="exam_description_id" value="${param.exam_description_id}" scope="session"></c:set>
            <c:set var="exam_description" value="${param.exam_description}" scope="session"></c:set>
            <!--执行插入数据操作，插入到examrecord表，标记此考生已经考了这个考试-->
            <sql:update var="count" scope="page" dataSource="${onlineexam}">
                insert into examrecord(user_id,exam_description_id) values(?,?);
                <sql:param value="${id}"></sql:param>
                <sql:param value="${exam_description_id}"></sql:param>
            </sql:update>

            <!--查询数据库表的试题-->
            <sql:query var="questions" scope="session" dataSource="${onlineexam}">
                select * from questions where exam_description_id=? order by id;
                <sql:param value="${param.exam_description_id}"></sql:param>
            </sql:query>


            <!--设置所有的题目数量-->
            <c:set var="totalquestions" value="${questions.rowCount}" scope="session"></c:set>
            <!--初始化当前的题目号-->
            <c:set var="currentquestion" value="1" scope="session"></c:set>
        </c:if>

        <c:if test="${not empty param.currentquestion}">
            <c:choose>
                <c:when test="${param.currentquestion>totalquestions}">
                    <c:set var="currentquestion" value="1" scope="session"></c:set>
                </c:when>
                <c:when test="${param.currentquestion<1}">
                    <c:set var="currentquestion" value="${totalquestions}" scope="session"></c:set>
                </c:when>
                <c:otherwise>
                    <c:set var="currentquestion" value="${param.currentquestion}" scope="session"></c:set>
                </c:otherwise>
            </c:choose>
        </c:if>
        <div class="main-box">
            <table width="100%" border="0" cellpadding="0" cellspacing="0">
                <tr valign="top">
                    <td width="140" id="stuInfo">
                        <fieldset>
                            <legend>考号</legend>
                            <span><c:out value="${id}"></c:out></span>
                        </fieldset>
                        <div class="Space8" style="height: 10px;"></div>
                        <fieldset style="height: 265px;">
                            <legend>考生信息</legend>
                            <!--根据ID查询数据库中的考生信息，定义变量保存在session范围内-->
                            <sql:query var="studentinfo" scope="session" dataSource="${onlineexam}">
                                select * from users_information where id=?;
                                <sql:param value="${id}"></sql:param>
                            </sql:query>
                            <!--存储到session变量中去-->
                            <c:forEach var="row" items="${studentinfo.rows}">
                                <c:set var="name" scope="session" value="${row.name}"></c:set>
                                <c:set var="sex" scope="session" value="${row.sex}"></c:set>
                                <c:set var="exam_reason" scope="session" value="${row.exam_reason}"></c:set>
                                <c:set var="picture" scope="session" value="${row.picture}"></c:set>
                            </c:forEach>
                            <div><img src="<c:out value="${picture}"></c:out>" width="100px" height="100px"></div>
                            <p style="font-size: 12px;line-height: 2em;">考生姓名：<c:out value="${name}"></c:out><br>
                                性　　别：<c:out value="${sex}"></c:out><br>
                                考试原因：<c:out value="${exam_reason}"></c:out><br>
                                试题描述：<c:out value="${exam_description}"></c:out>
                            </p>
                        </fieldset>
                        <div style="height: 10px;"></div>
                        <div id="timeInfo">
                            <fieldset>
                                <legend>剩余时间</legend>
                                <div id="show_time" style="text-align: center;color: red;">&nbsp;</div>
                            </fieldset>
                        </div>
                    </td>
                    <td width="10px"></td>
                    <td width="598px">
                        <c:forEach var="row" begin="${currentquestion-1}" end="${currentquestion-1}" items="${questions.rows}" step="1">
                        <!--如果是判断题，输出判断题的格式-->
                        <c:if test="${row.type eq 'judgement'}">
                        <div>
                            <fieldset>
                                <legend>考试题目</legend>
                                <div style="height: 274px;">
                                    <div style="display: inline;">
                                        <b><c:out value="${currentquestion}"></c:out>.&nbsp;</b>&nbsp;<c:out value="${row.question}"></c:out>
                                        <span style="float: right;"><c:out value="${row.min_score}"></c:out>分</span>
                                    </div>
                                    <div >
                                        <br>
                                        <div >
                                            <c:forEach var="option" items="${fn:split(row.options, '@')}" begin="0" end="1" step="1">
                                                ${option}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                            </c:forEach>
                                        </div>
                                    </div>
                                </div>
                                <div style="font-weight: bold;font-family: 宋体;">
                                    <div style="float: left;line-height: 39px;width: 200px;">您的答案：&nbsp;
                                        <%
                                            HttpSession session1 = request.getSession(true);
                                            OnlineExamBean onlineExamBean = (OnlineExamBean)session1.getAttribute("onlineExamBean") ;  //取出记录的bean
                                            if (onlineExamBean!=null){
                                                String[] answer = onlineExamBean.getAnswer();  //取得记录回答的数组
                                                try {
                                                    String currentQuestion = (String) session1.getAttribute("currentquestion");
                                                    Integer current = Integer.parseInt(currentQuestion);  //取出当前题目的索引
                                                    if (answer[current-1]!=null){  //不为空，显示
                                        %><%=answer[current-1]%>
                                        <%
                                            }
                                        }
                                        catch (Exception e){
                                            Integer current = (Integer)session1.getAttribute("currentquestion");
                                            if (answer[current-1]!=null){
                                        %><%=answer[current-1]%>
                                        <%
                                                    }
                                                }
                                            }
                                        %>
                                    </div>
                                    <div style="float: right;"><table border="0" cellpadding="0" cellspacing="0">
                                        <tr>
                                            <td width="66" style="font-weight: bold;">选择：</td>
                                            <td> <div  style=""><form action="handleChoose" name="form" method="get"><input type="hidden" name="exam_description_id" value="<c:out value="${exam_description_id}"></c:out>"/><input type="submit" value="True" name="chose" class="options"><input type="submit" value="False" name="chose" class="options"></form></div></td>
                                        </tr>
                                    </table>
                                    </div>
                                </div>
                            </fieldset>
                        </div>
                        <div style="height: 63px;position: relative;top: 13px;">
                            <div id="tipInfo" style="float: left;">
                                <fieldset>
                                    <legend>提示信息</legend>
                                    <div class="fcc" style="font-size: 12px;">判断题，请选择True或False</div>
                                </fieldset>
                            </div>
                            </c:if>
                            <!--如果是选择题，输出选择题的样式-->
                            <c:if test="${row.type eq 'choice'}">
                            <div>
                                <fieldset>
                                    <legend>考试题目</legend>
                                    <div style="height: 274px;">
                                        <div style="display: inline;">
                                            <b><c:out value="${currentquestion}"></c:out>.&nbsp;</b>&nbsp;<c:out value="${row.question}"></c:out>
                                        </div>
                                        <span style="float: right;"><c:out value="${row.min_score}"></c:out>分</span>
                                        <div>
                                            <br>
                                            <div>
                                                <c:forEach var="option" items="${fn:split(row.options, '@')}" begin="0" end="3" step="1">
                                                    ${option}<br>
                                                </c:forEach>
                                            </div>
                                        </div>
                                    </div>
                                    <div style="font-weight: bold;font-family: 宋体;">
                                        <div style="float: left;line-height: 39px; width: 200px;" >您的答案：&nbsp;
                                            <%
                                                HttpSession session1 = request.getSession(true);
                                                OnlineExamBean onlineExamBean = (OnlineExamBean)session1.getAttribute("onlineExamBean") ;
                                                if (onlineExamBean!=null){
                                                    String[] answer = onlineExamBean.getAnswer();
                                                    try {
                                                        String currentQuestion = (String) session1.getAttribute("currentquestion");
                                                        Integer current = Integer.parseInt(currentQuestion);
                                                        if (answer[current-1]!=null){
                                            %><%=answer[current-1]%>
                                            <%
                                                }
                                            }
                                            catch (Exception e){
                                                Integer current = (Integer)session1.getAttribute("currentquestion");
                                                if (answer[current-1]!=null){
                                            %><%=answer[current-1]%>
                                            <%
                                                        }
                                                    }
                                                }
                                            %>
                                        </div>
                                        <div style="float: right;">
                                            <table border="0" cellpadding="0" cellspacing="0">
                                                <tr>
                                                    <td width="66" style="font-weight: bold;">选择：</td>
                                                    <td ><div  style=""><form action="handleChoose" name="form" method="get"><input type="hidden" name="exam_description_id" value="<c:out value="${exam_description_id}"></c:out>"/><input type="submit" value="A" name="chose" class="options"><input type="submit" value="B" name="chose" class="options"><input type="submit" value="C" name="chose" class="options"><input type="submit" value="D" name="chose" class="options"></form></div></td>
                                                </tr>
                                            </table>
                                        </div>
                                    </div>
                                </fieldset>
                            </div>
                            <div style="height: 63px;position: relative;top: 13px;">
                                <div id="tipInfo" style="float: left;">
                                    <fieldset>
                                        <legend>提示信息</legend>
                                        <div class="fcc" style="font-size: 12px;">选择题，请选择您认为正确的选项</div>
                                    </fieldset>
                                </div>
                                </c:if>
                                </c:forEach>

                                <div id="actArea" style="float: right;margin-top: 20px;">
                                    <div>
                                        <form action="OnlineExam.jsp" name="form" method="get"><input type="hidden" name="currentquestion" value="<c:out value="${currentquestion-1}"></c:out>"><input type="submit"  value="上一题"></form>
                                        <form action="OnlineExam.jsp" name="form" method="get"><input type="hidden" name="currentquestion" value="<c:out value="${currentquestion+1}"></c:out>"><input type="submit"  value="下一题"></form>
                                        <form action="handleScore" name="form" method="get" id="submit_to_handleScore"><input type="submit" value="交 卷"></form>
                                    </div>
                                </div>
                            </div>
                    </td>
                    <td width="10px"></td>
                    <td style="width: 242px;">
                        <fieldset style="height: 330px;overflow: auto">
                            <legend>题目号</legend>
                            <c:forEach var="row" items="${questions.rows}" begin="0" end="${totalquestions-1}" step="1" varStatus="status">
                                <!--如果当前的题目号等于当前的题目索引，为其添加class名，用作css样式显示-->
                                <c:if test="${status.count eq currentquestion}">
                                    <div class="item" id="currentflag">
                                        <a href="OnlineExam.jsp?currentquestion=<c:out value="${status.count}"></c:out>" class="item-navigator">
                                            <c:out value="${status.count}"></c:out>
                                        </a>
                                    </div>
                                </c:if>
                                <!--当前的题目号不等于当前的题目索引，默认显示即可-->
                                <c:if test="${status.count ne currentquestion}">
                                    <div class="item" >
                                        <a href="OnlineExam.jsp?currentquestion=<c:out value="${status.count}"></c:out>" class="item-navigator"  >
                                            <c:out value="${status.count}"></c:out>
                                        </a>
                                    </div>
                                </c:if>
                                <!--控制每行输出五个题目-->
                                <c:if test="${(status.count+1 mod 5) eq 0}"><div style="clear:both"></div></c:if>
                            </c:forEach>
                        </fieldset>
                    </td>
                </tr>
            </table>
        </div>
    </div>
</div>
<div class="footer">Copyright&nbsp;&copy;&nbsp;lollipop</div>
<div id="confirm_dialog">

</div>
</body>
</html>
