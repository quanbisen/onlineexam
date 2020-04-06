package servlet;

import util.UploadFileUtil;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.sql.*;

public class HandleUploadImage extends HttpServlet {

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
        HttpSession session = request.getSession();
        String TARGET_DIRECTORY="image";   /**上传文件的目录**/
        String uploadPath = this.getServletContext().getRealPath("/")+ File.separator+TARGET_DIRECTORY;
        String message="";
        String fileName =UploadFileUtil.uploadFile(uploadPath,request);  //调用自定义的工具类处理文件上传
        if (fileName!=null&&fileName.length()>0){  //如果上传文件成功，连接数据库更新数据库记录为新的图片
            try {
                String url = this.getServletContext().getInitParameter("url");
                String user = this.getServletContext().getInitParameter("user");
                String pwd = this.getServletContext().getInitParameter("password");
                Connection connection = DriverManager.getConnection(url, user, pwd);
                PreparedStatement preparedStatement = connection.prepareStatement("select picture from " +
                        "users_information where id=?");  //查询先前头像文件的url
                String id = (String) session.getAttribute("user");
                preparedStatement.setString(1, id);
                ResultSet resultSet = preparedStatement.executeQuery();  //执行查询操作
                resultSet.next();
                String pictureUrl = resultSet.getString(1);  //取出url地址
                String previousFileName = pictureUrl.substring(pictureUrl.lastIndexOf("/")+1,pictureUrl.length());
                File previousFile = new File(uploadPath,previousFileName);  //创建文件对象
                if (previousFile.exists()){  //文件存在，删除。
                    previousFile.delete();
                }
                //更新数据库中的图片url
                preparedStatement = connection.prepareStatement("update users_information set picture=? where id=?");
                preparedStatement.setString(1,"../"+TARGET_DIRECTORY+"/"+fileName);
                preparedStatement.setString(2,id);  //设置参数
                preparedStatement.executeUpdate();  //执行更新操作
                connection.close();  //关闭数据库连接
                message="success";
            }
            catch (SQLException e){
                message="error";
                e.printStackTrace();
            }
        }
        else {  //文件名为空上传失败
            message="error";
        }
        response.sendRedirect("MyInformation.jsp?message="+message);
    }

}
