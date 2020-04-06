package bean;
/*****
 * 在线考试试题部分信息存储的数据模型
 * **/
public class OnlineExamBean {
    String answer[];    //存储考生回答的数组
    String correctAnswer[];  //存储题目正确答案的数组
    String score[];          //存储每一题分值的数组

    public String[] getAnswer() {
        return answer;
    }

    public void setAnswer(String[] answer) {
        this.answer = answer;
    }

    public String[] getCorrectAnswer() {
        return correctAnswer;
    }

    public void setCorrectAnswer(String[] correctAnswer) {
        this.correctAnswer = correctAnswer;
    }

    public String[] getScore() {
        return score;
    }

    public void setScore(String[] score) {
        this.score = score;
    }
}
