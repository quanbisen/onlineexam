package servlet;

import bean.OnlineExamBean;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.*;

public class HandleChoose extends HttpServlet {
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
        String url = this.getServletContext().getInitParameter("url");
        String user = this.getServletContext().getInitParameter("user");
        String pwd = this.getServletContext().getInitParameter("password");
        String exam_description_idStr = request.getParameter("exam_description_id");
        int exam_description_id = Integer.parseInt(exam_description_idStr);  //试题的唯一性标识
        String chose = request.getParameter("chose");  //取出参数chose，chose表是选择的选项ABCD或True/False
        String currentQuestion =(String) session.getAttribute("currentquestion");  //取出当前的题目索引
        Integer current = Integer.parseInt(currentQuestion);   //转换成int类型
        OnlineExamBean onlineExamBean = (OnlineExamBean)session.getAttribute("onlineExamBean");  //取出数据模型bean
        if (onlineExamBean==null){
            onlineExamBean = new OnlineExamBean();  //创建记录考试题目信息的bean
            int row = (Integer)session.getAttribute("totalquestions");  //取出总的题目数量
            onlineExamBean.setAnswer(new String[row]);
            try { //连接数据库，查询数据库记录问题的questions表
                Connection connection = DriverManager.getConnection(url, user, pwd);
                PreparedStatement preparedStatement = connection.prepareStatement("select * from" +
                        " questions where exam_description_id=? order by id; ");
                preparedStatement.setInt(1,exam_description_id);  //设置参数
                ResultSet resultSet = preparedStatement.executeQuery();   //执行查询
                String[] correctAnswer = new String[row];   //实例化记录正确回答的数组
                String[] score = new String[row];    //实例化记录分值的数组
                int i = 0;
                while (resultSet.next()){  //遍历取出各题的分值和正确答案
                    correctAnswer[i] = resultSet.getString(5);
                    score[i] = resultSet.getString(6);
                    i++;
                }
                connection.close();  //关闭数据库连接
                onlineExamBean.setCorrectAnswer(correctAnswer);   //设置bean中各个题目对应的正确答案
                onlineExamBean.setScore(score);  //设置bean中各个题目对应的分值
                session.setAttribute("onlineExamBean",onlineExamBean);  //存储到session对象中
        }
            catch (SQLException e){
                e.printStackTrace();
            }
        }
        onlineExamBean.getAnswer()[current-1]=chose;  //设置存储的bean的对应题目的回答
        response.sendRedirect("OnlineExam.jsp?currentquestion="+current);  //重定向到当前的问题
    }
}

