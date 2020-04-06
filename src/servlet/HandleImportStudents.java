package servlet;

import util.ReadExcelUtil;
import util.UploadFileUtil;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import java.sql.*;
import java.util.List;

/**
 * @author super lollipop
 * @date 4/6/20
 */
public class HandleImportStudents extends HttpServlet {

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

        String TARGET_DIRECTORY="excelfile";        //上传文件的目录*
        String uploadPath = this.getServletContext().getRealPath("/")+ File.separator+TARGET_DIRECTORY;
        String fileName = UploadFileUtil.uploadFile(uploadPath,request);
        String message = "";  //用作重定向提示参数
        if (fileName != null){//如果上传文件成功，读取文件写入数据库
            String excelFilePath = uploadPath + File.separator + fileName;
            List<List<String>> rowList = ReadExcelUtil.readExcelList(excelFilePath);  //读取Excel文件
            int totalRow = rowList.size();
            int successRow = 0;
            try {//连接数据库
                String url = this.getServletContext().getInitParameter("url");
                String user = this.getServletContext().getInitParameter("user");
                String pwd = this.getServletContext().getInitParameter("password");
                Connection connection = DriverManager.getConnection(url, user, pwd);
                //把数据插入到数据表格
                for (int i = 0; i < rowList.size(); i++) {
                    try {
                        PreparedStatement preparedStatement = connection.prepareStatement("insert into" +
                                " users(id,password) values(?,?)");
                        preparedStatement.setString(1,rowList.get(i).get(0));
                        preparedStatement.setString(2,rowList.get(i).get(1));
                        preparedStatement.executeUpdate();
                        preparedStatement = connection.prepareStatement("insert into" +
                                " users_information(id,name,sex,exam_reason) values(?,?,?,?)");
                        preparedStatement.setString(1,rowList.get(i).get(0));
                        preparedStatement.setString(2,rowList.get(i).get(2));
                        preparedStatement.setString(3,rowList.get(i).get(3));
                        preparedStatement.setString(4,rowList.get(i).get(4));
                        preparedStatement.executeUpdate();
                        successRow ++;
                    }catch (Exception e){
                        e.printStackTrace();
                    }
                }
                //存储完成，把上传的excel文件删除
                File excelFile = new File(excelFilePath);
                if (excelFile.exists()){
                    excelFile.delete();
                }
                message = "?importmessage=success" + "&totalRow=" + totalRow + "&successRow=" + successRow;
                System.out.println(message);
            }
            catch (SQLException e){
                File excelFile = new File(excelFilePath);
                if (excelFile.exists()){
                    excelFile.delete();
                }
                message = "?importmessage=error";
                e.printStackTrace();
            }
        }
        else {
            message = "?importmessage=error";
        }
        response.sendRedirect("StudentManagement.jsp"+message);
    }
}