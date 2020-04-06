package servlet;

import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.sql.*;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.LinkedList;
import java.util.List;

/**
 * @author super lollipop
 * @date 4/6/20
 */
public class HandleExportStudentScore extends HttpServlet {

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
        String uploadPath = getServletContext().getRealPath("/") + TARGET_DIRECTORY;
        String exam_description_id = request.getParameter("exam_description_id");
        String message = "";  //用作重定向提示参数
        if (exam_description_id != null){
            try {//连接数据库
                String url = this.getServletContext().getInitParameter("url");
                String user = this.getServletContext().getInitParameter("user");
                String pwd = this.getServletContext().getInitParameter("password");
                Connection connection = DriverManager.getConnection(url, user, pwd);
                PreparedStatement preparedStatement = connection.prepareStatement("SELECT users_information.id,users_information.`name`,exam_description,total_score,obtain_score\n" +
                        "                FROM users_information, exams_description,examrecord where users_information.id=examrecord.user_id\n" +
                        "                and exams_description.id=examrecord.exam_description_id and examrecord.exam_description_id=?\n" +
                        "                order by users_information.id;");
                preparedStatement.setInt(1,Integer.parseInt(exam_description_id));
                ResultSet resultSet = preparedStatement.executeQuery();
                List<List<Object>> rowList = new LinkedList<>();
                while (resultSet.next()){
                    List<Object> columnList = new LinkedList<>();
                    System.out.println(resultSet.getString(1));
                    columnList.add(resultSet.getString(1));
                    System.out.println(resultSet.getString(2));
                    columnList.add(resultSet.getString(2));
                    System.out.println(resultSet.getString(3));
                    columnList.add(resultSet.getString(3));
                    System.out.println(resultSet.getFloat(4));
                    columnList.add(resultSet.getFloat(4));
                    System.out.println(resultSet.getFloat(5));
                    columnList.add(resultSet.getFloat(5));
                    rowList.add(columnList);
                }
                //创建工作薄对象
                HSSFWorkbook workbook=new HSSFWorkbook();//这里也可以设置sheet的Name
                //创建工作表对象
                HSSFSheet sheet = workbook.createSheet();
                workbook.setSheetName(0,"sheet1");//设置sheet的Name
                //创建工作表的行
                HSSFRow headRow = sheet.createRow(0);//设置第一行，从零开始
                headRow.createCell(0).setCellValue("考生号");
                headRow.createCell(1).setCellValue("姓名");
                headRow.createCell(2).setCellValue("试题描述");
                headRow.createCell(3).setCellValue("总分");
                headRow.createCell(4).setCellValue("得分");
                for (int i = 0; i < rowList.size(); i++) {
                    HSSFRow row = sheet.createRow(i + 1);
                    System.out.println((String) rowList.get(i).get(0));
                    row.createCell(0).setCellValue((String) rowList.get(i).get(0));
                    row.createCell(1).setCellValue((String) rowList.get(i).get(1));
                    row.createCell(2).setCellValue((String) rowList.get(i).get(2));
                    row.createCell(3).setCellValue((Float) rowList.get(i).get(3));
                    row.createCell(4).setCellValue((Float) rowList.get(i).get(4));
                }
                //文档输出
                FileOutputStream out = new FileOutputStream(uploadPath + File.separator + exam_description_id + ".xls");
                workbook.write(out);
                out.close();
                System.out.println(uploadPath + File.separator + exam_description_id + ".xls");
                response.sendRedirect("../excelfile/" + exam_description_id + ".xls");
            }catch (SQLException e){
                e.printStackTrace();
            }
        }else {

        }
    }
}