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

public class HandleScore extends HttpServlet {
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
        String user_id =(String) session.getAttribute("user");   //取出用户唯一性标识
        String exam_description_idStr = (String) session.getAttribute("exam_description_id") ;//取出试题的唯一性标识
        int exam_description_id = Integer.parseInt(exam_description_idStr);
        OnlineExamBean onlineExamBean =(OnlineExamBean)session.getAttribute("onlineExamBean");//取出记录答案、正确答案和分数的bean
        double total_score=0; //记录试题总分的变量
        double obtain_score=0;//记录考生的得分的变量
        //连接数据库
        String url = this.getServletContext().getInitParameter("url");
        String user = this.getServletContext().getInitParameter("user");
        String pwd = this.getServletContext().getInitParameter("password");
        try {
            Connection connection = DriverManager.getConnection(url,user,pwd);
            PreparedStatement preparedStatement = null;
            if (onlineExamBean==null){  //bean为空，此时为交白卷，直接更新得分为0分，总分为根据题目id查询数据库题目的总分
                preparedStatement = connection.prepareStatement("select SUM(min_score) sum from questions where exam_description_id=?");
                preparedStatement.setInt(1,exam_description_id);
                ResultSet resultSet = preparedStatement.executeQuery();
                resultSet.next();
                total_score = resultSet.getInt(1);
            }
            else if(onlineExamBean!=null){  //bean不为空，证明有选择答案。取出bean记录的数据处理分数。
                String[] answer = onlineExamBean.getAnswer();  //取出记录考生回答的数组
                String[] scoreStr = onlineExamBean.getScore(); //取出问题分值的数组
                for (int j=0;j<scoreStr.length;j++){   //循环计算试题的总分
                    total_score=total_score+Integer.parseInt(scoreStr[j]);
                }
                String[] correctAnswer = onlineExamBean.getCorrectAnswer();  //取出记录题目正确回答的数组
                for (int i=0;i<correctAnswer.length;i++){  //循环计算考生得分
                    if (correctAnswer[i].equalsIgnoreCase(answer[i])){
                        obtain_score = obtain_score + Integer.parseInt(scoreStr[i]);
                    }
                }
            }
            //更新数据库服务器信息
            preparedStatement = connection.prepareStatement("update examrecord set" +
                    " total_score=?,obtain_score=? where user_id=? and exam_description_id=?");
            preparedStatement.setString(1,String.valueOf(total_score));
            preparedStatement.setString(2,String.valueOf(obtain_score));
            preparedStatement.setString(3,user_id);
            preparedStatement.setInt(4,exam_description_id);
            if (preparedStatement.executeUpdate()==1){  //插入成功，带成功提示参数重定向
                response.sendRedirect("MyExam.jsp?message=success");
            }
            else {  //插入失败，带失败提示参数重定向
                response.sendRedirect("MyExam.jsp?message=fail");
            }
            connection.close(); //关闭数据库连接
            session.removeAttribute("onlineExamBean");  //移除session对象中相关的属性
            session.removeAttribute("currentquestion");
            session.removeAttribute("picture");
            session.removeAttribute("exam_reason");
            session.removeAttribute("questions");
            session.removeAttribute("exam_description_id");
            session.removeAttribute("exam_description");
            session.removeAttribute("totalquestions");
            session.removeAttribute("name");
            session.removeAttribute("studentinfo");

        }
        catch (SQLException e){
            e.printStackTrace();
        }
    }
}
