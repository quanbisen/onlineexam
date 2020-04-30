<%--
  Created by IntelliJ IDEA.
  User: 17691
  Date: 6/3/2019
  Time: 13:04
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt" %>
<html>
<head>
    <link rel="shortcut icon"  href="../image/ExamTitleIcon.ico">
    <title>This is StudentManagement</title>
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
            //下面是处理修改、添加提示的部分代码
            var message = '<%=request.getParameter("message")%>';
            var currentpage = '<%=request.getParameter("currentpage")%>'
            if (message == 'rectifysuccess') {
                alert('修改成功');
                window.location.href = 'StudentManagement.jsp?currentpage=' + currentpage;
            } else if (message == 'rectifyerror') {
                alert('修改失败，检查考生ID是否已经存在');
                window.location.href = 'StudentManagement.jsp?currentpage=' + currentpage;
            } else if (message == 'addstudentsuccess') {
                alert('添加成功');
                window.location.href = 'StudentManagement.jsp?currentpage=' + currentpage;
            } else if (message == 'addstudenterror') {
                alert('添加失败，检查考生ID是否已经存在');
                window.location.href = 'StudentManagement.jsp?currentpage=' + currentpage;
            }

            //用作提交给Servlet后重定向的信息提示，提示发布试题是否成功
            var importmessage = '<%=request.getParameter("importmessage")%>';
            var totalRow = '<%=request.getParameter("totalRow")%>';
            var successRow = '<%=request.getParameter("successRow")%>';
            if (importmessage=='error') {
                alert("批量导入失败");
                window.location.href = 'StudentManagement.jsp';
            } else if (importmessage=='success'){
                alert("总记录：" + totalRow + ".成功导入了" + successRow + "条记录");
                window.location.href = 'StudentManagement.jsp';
            }
        }

        function onSubmit() {
            var id = document.getElementById('id');
            var password = document.getElementById('password');
            var name = document.getElementById('name');
            if (id.value == "" || id.value == null || password.value.trim() == "" || password.value == null || name.value.trim() == "" || name.value == null) {
                alert("请完整输入考生ID、密码和姓名");
                return false;
            } else {
                return true;
            }
        }

        function onRectifySubmit() {
            var form1 = document.getElementById('form1');
            var rectify_id = document.getElementById('rectify_id');
            var rectify_password = document.getElementById('rectify_password');
            var rectify_name = document.getElementById('rectify_name');
            if (rectify_id.value.trim() == "" || rectify_id.value == null || rectify_password.value.trim() == "" || rectify_password.value == null || rectify_name.value.trim() == "" || rectify_name.value == null) {
                alert("考生ID或密码或姓名不能为空");
                return false;
            } else {
                form1.submit();
            }
        }

        function checkForm() {
            var file = document.getElementById('file');
            if (!file.value) {
                alert('请选择学生信息文件！');
                return false;
            }
            return true;
        }

        function downloadStudentsTemplate() {
            window.location.href = '../excelfile/student_template.xlsx';
        }
    </script>
</head>
<fmt:requestEncoding value="utf-8"></fmt:requestEncoding>
<body onload="onLoad();">
<div class="title">在线考试系统
    <span class="userinfo">用户名：<c:out value="${user}"></c:out>(<c:out value="${role}"></c:out>)&nbsp;&nbsp;&nbsp;&nbsp;<a href="ModifyPassword.jsp">修改密码</a>&nbsp;&nbsp;&nbsp;&nbsp;<a href="handleTeacherExit">退出</a> </span>
</div>
<div class="centerContainer">
    <div class="leftBar">
        <ul>
            <li class="negative"><a href="TeacherIndex.jsp">首页导航</a></li>
            <li class="negative"><a href="GradeStatistic.jsp">成绩统计</a></li>
            <li class="negative"><a href="QuestionsManagement.jsp">试题管理</a></li>
            <li><a style="background-color: #c8c8dc" href="StudentManagement.jsp">考生管理</a></li>
        </ul>
    </div>
    <div class="main">
        <div style="text-align: center;" class="studentinfo">
            <!--添加考生处理 -->
            <c:if test="${not empty param.add_student}">
                <c:catch var="error">
                    <!--先插入考生ID 和密码-->
                    <sql:update var="coun3" scope="page" dataSource="${onlineexam}">
                        insert users values(?,?);
                        <sql:param value="${param.id}"></sql:param>
                        <sql:param value="${param.password}"></sql:param>
                    </sql:update>
                    <!--如果输入的“性别“或者”考试理由“有一个是空值时执行插入考生ID、和姓名，其它的使用数据库默认值-->
                    <c:if test="${(empty param.sex)||(empty param.reason)}">
                        <sql:update var="coun4" scope="page" dataSource="${onlineexam}">
                            insert users_information(id,name) values(?,?);
                            <sql:param value="${param.id}"></sql:param>
                            <sql:param value="${param.name}"></sql:param>
                        </sql:update>
                    </c:if>
                    <!--当输入的性别和考试理由都不为空时执行数据库插入操作，这样保证数据库的默认值不生效 -->
                    <c:if test="${(not empty param.sex)&&(not empty param.reason)}">
                        <sql:update var="coun4" scope="page" dataSource="${onlineexam}">
                            insert users_information(id,name,sex,exam_reason) values(?,?,?,?);
                            <sql:param value="${param.id}"></sql:param>
                            <sql:param value="${param.name}"></sql:param>
                            <sql:param value="${param.sex}"></sql:param>
                            <sql:param value="${param.reason}"></sql:param>
                        </sql:update>
                    </c:if>
                    <!--修改成功后带成功参数重定向-->
                    <c:redirect url="StudentManagement.jsp?message=addstudentsuccess">
                        <c:param name="currentpage" value="${currentpage}"></c:param>
                    </c:redirect>
                </c:catch>
                <!--修改异常带失败参数重定向-->
                <c:redirect url="StudentManagement.jsp?message=addstudenterror"></c:redirect>
            </c:if>
            <!--删除考生处理 -->
            <c:if test="${not empty param.delete_id}">
            <sql:update var="count1" scope="page" dataSource="${onlineexam}">
                delete from users_information where id=?;
                <sql:param value="${param.delete_id}"></sql:param>
            </sql:update>
            <sql:update var="count2" scope="page" dataSource="${onlineexam}">
                delete from users where id=?;
                <sql:param value="${param.delete_id}"></sql:param>
            </sql:update>
            <c:redirect url="StudentManagement.jsp">
                <c:param name="currentpage" value="${currentpage}"></c:param>
            </c:redirect>
            </c:if>
            <!--修改考生信息处理，“确定”按钮提交需要处理的部分-->
            <c:if test="${not empty param.pre_id}">
                <!--如果更新的ID和原来的ID相同，通过ID更新其余的信息-->
                <c:if test="${param.pre_id eq param.id}">
                    <c:out value="${param.name}"></c:out>
                    <sql:update var="count1" scope="page" dataSource="${onlineexam}">
                        update users_information set name=?,sex=?,exam_reason=? where id=?;
                        <sql:param value="${param.name}"></sql:param>
                        <sql:param value="${param.sex}"></sql:param>
                        <sql:param value="${param.reason}"></sql:param>
                        <sql:param value="${param.pre_id}"></sql:param>
                    </sql:update>
                    <sql:update var="count2" scope="page" dataSource="${onlineexam}">
                        update users set password=? where id=?
                        <sql:param value="${param.password}"></sql:param>
                        <sql:param value="${param.pre_id}"></sql:param>
                    </sql:update>
                    <c:out value="${param.currentpage}"></c:out>
                    <c:redirect url="StudentManagement.jsp">
                        <c:param name="message" value="rectifysuccess"></c:param>
                        <c:param name="currentpage" value="${currentpage}"></c:param>
                    </c:redirect>
                </c:if>
                <!--如果更新的ID和原来的ID不相同，尝试插入新的ID（主键可能已经存在，会出错，所以使用了catch语句），然后再把旧的ID值数据删除，然后依次根据新的ID值插入新的数据记录-->
                <c:if test="${param.pre_id ne param.id}">
                    <c:catch var="error">
                        <sql:update var="coun3" scope="page" dataSource="${onlineexam}">
                            insert users values(?,?);
                            <sql:param value="${param.id}"></sql:param>
                            <sql:param value="${param.password}"></sql:param>
                        </sql:update>
                        <sql:update var="coun3" scope="page" dataSource="${onlineexam}">
                            insert users_information(id,name,sex,exam_reason) values(?,?,?,?);
                            <sql:param value="${param.id}"></sql:param>
                            <sql:param value="${param.name}"></sql:param>
                            <sql:param value="${param.sex}"></sql:param>
                            <sql:param value="${param.reason}"></sql:param>
                        </sql:update>
                        <sql:update var="count1" scope="page" dataSource="${onlineexam}">
                            delete from users_information where id=?;
                            <sql:param value="${param.pre_id}"></sql:param>
                        </sql:update>
                        <sql:update var="count2" scope="page" dataSource="${onlineexam}">
                            delete from users where id=?;
                            <sql:param value="${param.pre_id}"></sql:param>
                        </sql:update>
                        <c:redirect url="StudentManagement.jsp">
                            <c:param name="message" value="rectifysuccess"></c:param>
                            <c:param name="currentpage" value="${currentpage}"></c:param>
                        </c:redirect>
                    </c:catch>
                    <c:redirect url="StudentManagement.jsp">
                        <c:param name="message" value="rectifyerror"></c:param>
                        <c:param name="currentpage" value="${currentpage}"></c:param>
                    </c:redirect>
                </c:if>
            </c:if>
            <!--查询数据库记录学生信息的userinfo表，范围是page，即能实现页面刷新数据的更新-->
            <sql:query var="usersinfo" scope="page" dataSource="${onlineexam}">
                select users.id,password,name,sex,exam_reason from users_information,users where users_information.id=users.id order BY users.id ASC;
            </sql:query>
            <h4>考生详细信息表:<span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span><span>总人数：<c:out value="${usersinfo.rowCount}"></c:out></span></h4>
            <!--设置页面显示的记录数，最多显示10条-->
            <c:set var="pageSize" value="10" scope="page"></c:set>
            <!--设置查询到的考生记录数-->
            <c:set var="totalRecord" value="${usersinfo.rowCount}"></c:set>

            <%
                //下面是设置总的页数，因为JSTL标签计算时是小数计算的，所以这里使用Java的int类型特性可以很方便地设置页数
                String pageSizeStr = (String)pageContext.getAttribute("pageSize");
                Integer pageSize = Integer.parseInt(pageSizeStr);
                Integer totalRecord = (Integer)pageContext.getAttribute("totalRecord");
                int totalPages;
                if (totalRecord%pageSize==0){
                    totalPages = totalRecord/pageSize;
                }
                else {
                    totalPages = totalRecord/pageSize+1;
                }
                pageContext.setAttribute("totalPages",totalPages);
            %>

            <!--设置当前页-->
            <c:set var="currentpage" value="1" scope="session"></c:set>
            <c:if test="${not empty param.currentpage}">
                <c:choose>
                    <c:when test="${param.currentpage>totalPages}">
                        <c:set var="currentpage" value="1" scope="session"></c:set>
                    </c:when>
                    <c:when test="${param.currentpage<1}">
                        <c:set var="currentpage" value="${totalPages}" scope="session"></c:set>
                    </c:when>
                    <c:otherwise>
                        <c:set var="currentpage" value="${param.currentpage}" scope="session"></c:set>
                    </c:otherwise>
                </c:choose>
            </c:if>

            <c:set var="index" value="${(currentpage-1)*10}"></c:set>
            <!--rectify_id参数为空，证明当前不是修改模式，输出数据库中的表格数据-->
            <c:if test="${empty param.rectify_id}">
                <div style="overflow: auto;height: 270px;">
                    <table style="margin: 0 auto;" id="table">
                        <tr>
                            <th width="150px">考生ID</th>
                            <th width="150px">密码</th>
                            <th width="150px">姓名</th>
                            <th width="150px">性别</th>
                            <th width="150px">考试理由</th>
                            <th width="50px" style="text-align: center;">修改</th>
                            <th width="50px" style="text-align: center;">删除</th>
                        </tr>

                        <c:forEach var="row" items="${usersinfo.rows}" varStatus="status" begin="${index}" end="${index+9}" step="1">
                            <tr>
                                <td width="150px"><c:out value="${row.id}"></c:out></td>
                                <td width="150px"><c:out value="${row.password}"></c:out></td>
                                <td width="150px"><c:out value="${row.name}"></c:out></td>
                                <td width="150px"><c:out value="${row.sex}"></c:out></td>
                                <td width="150px"><c:out value="${row.exam_reason}"></c:out></td>
                                <td width="50px" align="center"><form action="StudentManagement.jsp?currentpage=<c:out value="${currentpage}"></c:out>" method="post"><input type="hidden" name="rectify_id" value="<c:out value='${row.id}'></c:out>"> <input type="submit" value="修改"></form></td>
                                <td width="50px" align="center"><form action="StudentManagement.jsp?currentpage=<c:out value="${currentpage}"></c:out>" method="post"><input type="hidden" name="delete_id" value="<c:out value='${row.id}'></c:out>"> <input type="submit" value="删除"></form></td>
                            </tr>
                        </c:forEach>
                    </table>
                </div>
            </c:if>
            <!--rectify_id参数不为空，证明是修改模式，输出<input>标签供管理者输入数据-->
            <c:if test="${not empty param.rectify_id}">
                <div style="overflow:auto;height: 270px;">
                    <table style="margin: 0 auto;" id="table">
                        <tr>
                            <th width="150px">考生ID(必填)</th>
                            <th width="150px">密码(必填)</th>
                            <th width="150px">姓名(必填)</th>
                            <th width="150px">性别</th>
                            <th width="150px">考试理由</th>
                            <th width="50px" style="text-align: center;">修改</th>
                            <th width="50px" style="text-align: center;">确定</th>
                        </tr>
                        <c:forEach var="row" items="${usersinfo.rows}" varStatus="status" begin="${index}" end="${index+9}" step="1">
                            <c:choose>
                                <c:when test="${row.id eq param.rectify_id}">
                                    <tr>
                                        <form id="form1" name="form1" action="StudentManagement.jsp?currentpage=<c:out value="${currentpage}"></c:out>" method="get">
                                            <td width="150px"><input form="form1" id="rectify_id" name="id" style="width: 150px;" type="text" value="<c:out value="${row.id}"></c:out>"></td>
                                            <td width="150px"><input form="form1" id="rectify_password" name="password" style="width: 150px;" type="text" value="<c:out value="${row.password}"></c:out>"></td>
                                            <td width="150px"><input form="form1" id="rectify_name" name="name" style="width: 150px;" type="text" value="<c:out value="${row.name}"></c:out>"></td>
                                            <td width="150px"><input form="form1" name="sex" style="width: 150px;" type="text" value="<c:out value="${row.sex}"></c:out>"></td>
                                            <td width="150px"><input form="form1" name="reason" style="width: 150px;" type="text" value="<c:out value="${row.exam_reason}"></c:out>"></td>
                                            <td width="50px" align="center"><form id="form2" name="from2" action="StudentManagement.jsp?currentpage=<c:out value="${currentpage}"></c:out>" method="get"><input form="form2" type="hidden" name="rectify_id" value="<c:out value='${row.id}'></c:out>"> <input form="form2" type="button" onclick="alert('已经是修改模式啦！')" value="修改"></form></td>
                                            <td width="50px" align="center"><input form="form1" type="hidden" name="pre_id" value="<c:out value='${row.id}'></c:out>"> <input form="form1" type="button" onclick="onRectifySubmit();" value="确定"></td>
                                        </form>
                                    </tr>
                                </c:when>
                                <c:otherwise>
                                    <tr>
                                        <td width="150px"><c:out value="${row.id}"></c:out></td>
                                        <td width="150px"><c:out value="${row.password}"></c:out></td>
                                        <td width="150px"><c:out value="${row.name}"></c:out></td>
                                        <td width="150px"><c:out value="${row.sex}"></c:out></td>
                                        <td width="150px"><c:out value="${row.exam_reason}"></c:out></td>
                                        <td width="50px" align="center"><form action="StudentManagement.jsp?currentpage=<c:out value="${currentpage}"></c:out>" method="post"><input type="hidden" name="rectify_id" value="<c:out value='${row.id}'></c:out>"> <input type="submit" value="修改"></form></td>
                                        <td width="50px" align="center"><form action="StudentManagement.jsp?currentpage=<c:out value="${currentpage}"></c:out>" method="post"><input type="hidden" name="conform_id" value="<c:out value='${row.id}'></c:out>"> <input type="submit" value="确定"></form></td>
                                    </tr>
                                </c:otherwise>
                            </c:choose>
                        </c:forEach>
                    </table>
                </div>
            </c:if>
            <div style="margin-top: 30px;">
                <form style="display: inline;" action="StudentManagement.jsp" method="get">
                    <input name="currentpage" type="hidden" value="<c:out value="${currentpage-1}"></c:out>">
                    <input type="submit" value="上一页">&nbsp;&nbsp;&nbsp;&nbsp;
                </form>
                总页数：<c:out value="${totalPages}" ></c:out>&nbsp;&nbsp;&nbsp;&nbsp;当前页：<c:out value="${currentpage}"></c:out>&nbsp;&nbsp;&nbsp;&nbsp;
                <form style="display: inline;" action="StudentManagement.jsp" method="get">
                    <input name="currentpage" type="hidden" value="<c:out value="${currentpage+1}"></c:out>">
                    <input type="submit" value="下一页">&nbsp;&nbsp;&nbsp;&nbsp;
                </form>
                <form style="display: inline;" action="StudentManagement.jsp">
                    跳转到<input type="text" size="4px" name="currentpage">页&nbsp;&nbsp;<input type="submit" value="确定">
                </form>
            </div>
        </div>

        <div style="text-align: center;" class="addstudent">
            <h4>添加考生信息:</h4>
            <table style="margin: 0 auto;">
                <tr>
                    <th width="150px">考生ID(必填)</th>
                    <th width="150px">密码(必填)</th>
                    <th width="150px">姓名(必填)</th>
                    <th width="150px">性别</th>
                    <th width="150px">考试理由</th>
                    <th width="50px" style="text-align: center;">添加</th>
                </tr>
                <tr>
                    <form id="form3" name="form3" action="StudentManagement.jsp" method="get" onsubmit="return onSubmit();">
                        <td width="150px"><input form="form3" id="id" name="id" style="width: 150px;" type="text" value="<c:out value="${row.id}"></c:out>"></td>
                        <td width="150px"><input form="form3" id="password" name="password" style="width: 150px;" type="text" value="<c:out value="${row.password}"></c:out>"></td>
                        <td width="150px"><input form="form3" id="name" name="name" style="width: 150px;" type="text" value="<c:out value="${row.name}"></c:out>"></td>
                        <td width="150px"><input form="form3" id="sex" name="sex" style="width: 150px;" type="text" value="<c:out value="${row.sex}"></c:out>"></td>
                        <td width="150px"><input form="form3" id="reason" name="reason" style="width: 150px;" type="text" value="<c:out value="${row.exam_reason}"></c:out>"></td>
                        <td width="50px" align="center"><input type="hidden" name="add_student" value="true"><input type="hidden" name="currentpage" value="<c:out value="${currentpage}"></c:out>"><input form="form3" type="submit" value="添加"></td>
                    </form>
                </tr>
            </table>
            <div style="height: 480px;margin-top: 20px;">
                <table style="text-align: center;margin: 0 auto;">
                    <tr><th style="width: 300px;text-align: center;">如需批量添加考生信息，请下载考生信息模板</th><td width="120px"><input type="button" onclick="downloadStudentsTemplate();" value="下载模板"></td></tr>
                    <tr><td colspan="2"><p style="text-align: left;padding-left: 20px;">模板说明：id是考生登录账号，password是选项考生登录密码<br>,name是姓名，sex是性别，exam_reason是考试理由<br></p></td></tr>
                </table>

                <form action="handleImportStudents" method="post" onsubmit="return checkForm();" enctype="multipart/form-data">
                    <table style="text-align: center;margin: 15px auto;">
                        <tr><th style="width: 120px;text-align: center;">文件</th><th style="width: 120px;text-align: center;">管理</th></tr>
                        <tr><td><input id="file" type="file" accept=".xlsx,.xls" name="excelFile" style="width: 190px;"></td><td><input type="submit" value="批量导入" name="import"></td></tr>
                    </table>
                </form>
            </div>
        </div>
    </div>
</div>
<div class="footer">Copyright&nbsp;&copy;&nbsp;lollipop</div>
</body>
</html>
