package util;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import java.io.FileInputStream;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;

public final class ReadExcelUtil {
    //读取excel文件的函数，返回一个ListList<List<String>>类型
    public static List<List<String>> readExcelList(String filePath){
        List<List<String>> rowList = null;  //Excel文件行记录集合
        Workbook workbook = ReadExcelUtil.readExcel(filePath);  //获取Excel文件Workbook对象
        if (workbook!=null){
            rowList = new ArrayList<>();
            Sheet sheet = workbook.getSheetAt(0);  //取第一个工作本
            int rowCount = sheet.getPhysicalNumberOfRows();   //取行记录数
            int columnCount = sheet.getRow(0).getPhysicalNumberOfCells();  //取列记录数
            for (int i = 1;i<rowCount;i++){   //循环遍历每一行
                Row row = sheet.getRow(i);
                List<String> cellList = new ArrayList();  //记录一行的所有的单元格集合
                for (int j = 0;j<columnCount;j++){  //遍历一行所有的列（单元格）
                    String cellValue = ReadExcelUtil.getCellFormatValue(row.getCell(j)); //取出单元格的值
                    cellList.add(cellValue);  //添加到cellList中
                }
                rowList.add(cellList);  //把记录一行中所有单元格的cellList添加到行记录集合中
            }
        }
        return rowList;  //返回行记录集合
    }
    //读取excel文件的函数，返回一个workbook工作本
    public static Workbook readExcel(String filePath){
        Workbook workbook = null;
        if(filePath==null){  //文件不存在，返回为空
            return null;
        }
        try {
            String extString = filePath.substring(filePath.lastIndexOf("."));  //定位到扩展名处
            InputStream is = null;
            is = new FileInputStream(filePath);
            if(".xls".equals(extString)){  //扩展名为.xls的处理
                workbook = new HSSFWorkbook(is);
            }
            else if(".xlsx".equals(extString)){  //扩展名为.xlsx的处理
                workbook = new XSSFWorkbook(is);
            }
            else{
                workbook = null;
            }
            return workbook;
        }
        catch (Exception e){
            e.printStackTrace();
        }
        return workbook;
    }
    public static String getCellFormatValue(Cell cell){
        String cellValue = null;
        if(cell!=null){
            //判断cell类型
            switch(cell.getCellType()){
                case Cell.CELL_TYPE_NUMERIC:{
                    cellValue = String.valueOf(cell.getNumericCellValue());
                    break;
                }
                case Cell.CELL_TYPE_STRING:{
                    cellValue = cell.getRichStringCellValue().getString();
                    break;
                }
                default:
                    cellValue = "";
            }
        }
        else{
            cellValue = "";
        }
        return cellValue;
    }
}
