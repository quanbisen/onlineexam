管理者登录账号               	    考生登录账号
用户名：lollipop             	参见users表
密码：10010
也可参见administrators表

主要文件说明：
onlineexam是IntelliJ IDEA的项目文件，如果有IntelliJ IDEA可以使用直接打开，配置Tomcat服务器目
录就可以直接运行.

onlineexam.sql是Navicat数据库管理软件的导出语句，使用Navicat创建名为onlineexam的数据库并设置数据库编码为utf-8后，就可以使用管理软件的Execute SQL File执行onlineexam.sql文件就可以完成数据库表的创建了。


OnlineExam项目数据库配置说明：
本项目的数据库连接url、user和password相关配置存储在web.xml文件中，可以根据具体的数据库服务器
的设置进行更改。这里的设置是
        <param-name>user</param-name>
        <param-value>root</param-value>
        <param-name>password</param-name>
        <param-value>10010</param-value>
        <param-name>url</param-name>
        <param-value>jdbc:mysql://127.0.0.1:3306/onlineexam?characterEncoding=utf-8</param-value>


OnlineExam项目文件说明：

src文件夹:项目的源文件.java，里面有bean(模型)、servlet(控制器)和util(工具)三个package包；

web文件夹:Web应用的相关文件，分为administrator(管理者)、teacher(教师)、student(考生)、css(样式)、excelfile(Excel
文件存放)、image(图片文件存放)、WEB-INF(服务器相关文件存放)文件夹和两个登录相关的.jsp文件。


WEB-INF文件夹下的lib用到的.jar说明：
文件上传：commons-fileupload-1.4.jar、commons-io-2.6.jar
Excel文件的读取：commons-collections-3.2.1-1.0.0.jar、poi-3.6.jar、poi-ooxml-3.6.jar、
poi-ooxml-schemas-3.6.jar、xmlbeans-5.1.3.jar、dom4j-1.6.1.jar
JSTL标签库：taglibs-standard-impl-1.2.5.jar、jstl-1.2.jar
MySQL数据库连接：mysql-connector-java-8.0.19.jar

