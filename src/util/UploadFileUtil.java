package util;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.UnsupportedEncodingException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public final class UploadFileUtil {

    /**
     * 最大文件上传值
     **/
    private static int UPLOAD_MAX_FILE_SIZE = 1024 * 1024 * 5;  //默认5Mb
    /**
     * 内存临界值
     **/
    private static int MEMORY_THRESHOLD = 1024 * 1024 * 2;      //默认2Mb

    //单独上传文件的表单调用的处理函数，调用成功返回一个文件名
    public static String uploadFile(String uploadPath, HttpServletRequest request) {
        String fileName = null;  //初始化文件名为null
        DiskFileItemFactory factory = new DiskFileItemFactory();  //创建上传文件配置对象
        factory.setSizeThreshold(MEMORY_THRESHOLD);  //设置上传的文件的服务器内存临界值
        //设置存储的目录为JVM虚拟机运行的临时文件目录
        factory.setRepository(new File(System.getProperty("java.io.tmpdir")));
        ServletFileUpload fileUpload = new ServletFileUpload(factory);  //创建ServletFileUpload对象
        fileUpload.setFileSizeMax(UPLOAD_MAX_FILE_SIZE);  //设置上传文件的最大值
        fileUpload.setHeaderEncoding("utf-8"); //设置文件名编码
        //如果目录不存在，创建目录
        File uploadPathDir = new File(uploadPath);
        if (!uploadPathDir.exists()){
            uploadPathDir.mkdir();
        }
        try {
            List<FileItem> fileItems = fileUpload.parseRequest(request);  //解析请求
            for (FileItem item : fileItems) {
                if (!item.isFormField()) {  //只处理是文件类型的fileItems
                    fileName = new File(item.getName()).getName();  //取出文件名存储在fileName
                    File absoluteFilePath = new File(uploadPath, fileName);
                    item.write(absoluteFilePath);  //写入文件到目录路径
                }
            }
            return fileName;
        }
        catch (Exception e) {
            fileName = null;
            return fileName;
        }
    }
    //带有文件的表单上传，需要取表单的中其它的参数调用的函数，调用成功返回一个记录表单信息的哈希映射
    public static Map<String,String> uploadFileForm(String uploadPath, HttpServletRequest request, int UPLOAD_MAX_FILE_SIZE, int MEMORY_THRESHOLD){
        UploadFileUtil.UPLOAD_MAX_FILE_SIZE = UPLOAD_MAX_FILE_SIZE;
        UploadFileUtil.MEMORY_THRESHOLD = MEMORY_THRESHOLD;
        Map<String,String> map = new HashMap();
        DiskFileItemFactory factory = new DiskFileItemFactory();
        factory.setSizeThreshold(MEMORY_THRESHOLD);
        factory.setRepository(new File(System.getProperty("java.io.tmpdir")));
        ServletFileUpload fileUpload = new ServletFileUpload(factory);
        fileUpload.setHeaderEncoding("utf-8"); //设置文件名编码
        fileUpload.setFileSizeMax(UPLOAD_MAX_FILE_SIZE);
        //如果目录不存在，创建目录
        File uploadPathDir = new File(uploadPath);
        if (!uploadPathDir.exists()){
            uploadPathDir.mkdir();
        }
        String fileName = null;
        try {
            List<FileItem> fileItems = fileUpload.parseRequest(request);
            for (FileItem item : fileItems) {
                if (item.isFormField()) {
                    String str = item.getString("utf-8");
                    map.put(item.getFieldName(),str);
                }
                else if(!item.isFormField()){
                    map.put("fileName",item.getName());
                    fileName = new File(item.getName()).getName();
                    File absoluteFilePath = new File(uploadPath, fileName);
                    item.write(absoluteFilePath);
                    item.delete();
                }
            }
        }
        catch (FileNotFoundException e){
            return null;
        } catch (FileUploadException e) {
            e.printStackTrace();
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return map;
    }

}
