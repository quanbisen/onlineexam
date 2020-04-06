package servlet;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;

public class ModifyPassword extends HttpServlet {
    @Override
    public void init(ServletConfig config) throws ServletException {
        super.init(config);
        try {
            Class.forName("com.mysql.jdbc.Driver");
        }
        catch (Exception e){
            e.printStackTrace();
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        this.doPost(req,resp);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        HttpSession session = request.getSession(true);
        String id =(String) session.getAttribute("user");  //见HandleLogin.jsp存储的session会话的user属性，即是登录时输入的用户名
        String role = (String) session.getAttribute("role");  //取出角色
        String password = request.getParameter("password");   //取出输入的密码
        String repeat_password = request.getParameter("repeat_password");  //取出输入的重复密码
        if(password.equals(repeat_password)){  //如果两次密码相同，执行数据库服务器更新操作
            String url = this.getServletContext().getInitParameter("url");  //数据库连接的url
            String user = this.getServletContext().getInitParameter("user");  //数据库连接的用户名
            String pwd = this.getServletContext().getInitParameter("password");  //数据库连接的密码
            try {
                Connection connection = DriverManager.getConnection(url,user,pwd);  //获取数据库连接connection对象
                Statement statement = connection.createStatement();  //创建Statement报表
                if (role.equals("管理者")){  //管理者修改密码处理的部分
                    int row = statement.executeUpdate("update administrators set password='"+password+"' where id ='"+id+"';");
                    if (row == 1){  //如果更新执行返回值为1，证明更新成功，带成功参数返回，参数用作客户端浏览器的信息提示
                        response.sendRedirect("ModifyPassword.jsp?message=success");
                    }
                    else {  //否则，带失败参数返回，参数用作客户端浏览器的信息提示
                        response.sendRedirect("ModifyPassword.jsp?message=fail");
                    }
                }
                else if(role.equals("考生")){  //考生修改密码处理的部分
                    int row = statement.executeUpdate("update users set password='"+password+"' where id ='"+id+"';");
                    if (row == 1){  //如果更新执行返回值为1，证明更新成功，带成功参数返回，参数用作客户端浏览器的信息提示
                        response.sendRedirect("ModifyPassword.jsp?message=success");
                    }
                    else {   //否则，带失败参数返回，参数用作客户端浏览器的信息提示
                        response.sendRedirect("ModifyPassword.jsp?message=fail");
                    }
                }
                connection.close();  //数据库连接关闭
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        else{
            response.sendRedirect("ReRectifyPassword.jsp?message=fail");
        }
    }
}
