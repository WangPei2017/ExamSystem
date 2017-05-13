package com.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.entity.Student;
import com.service.IExportService;
//下载学生信息
@Controller
@RequestMapping(value="/exportstu")
public class ExportContoller extends HttpServlet{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 8380263720008661974L;
	@Autowired
	private IExportService exportService;
	@RequestMapping(value="/exportstudentinfo",method=RequestMethod.GET )
	public void exportPersonInfoForAuth(HttpServletRequest request,HttpServletResponse response){
		SimpleDateFormat f = new SimpleDateFormat("yyyy-MM-dd");
		String filename = "student"+f.format(new Date())+".xls";
		String mimeType = request.getSession().getServletContext().getMimeType(filename);
		response.setContentType(mimeType);
		HSSFWorkbook workbook = null;
		ServletOutputStream bos = null;
		try {
			filename = new String(filename.getBytes("GBK"),"ISO-8859-1");
			response.setHeader("Content-Disposition", "attachment;filename="+filename);
			workbook = new HSSFWorkbook();
			HSSFSheet sheet = workbook.createSheet("学生报名信息");
			//查询学生记录
			List<Student> list = exportService.getStudentList();
			int rolnum = 0;
			createhssfRow(sheet,rolnum++);
			for (Student student : list) {
				HSSFRow row = sheet.createRow(rolnum++);
				createRow(sheet,row,student);
			}
			bos = response.getOutputStream();
			workbook.write(bos);
			bos.flush();
			bos.close();
		} catch (Exception e) {
			e.printStackTrace();
		} 
	}

	public void createRow(HSSFSheet sheet,HSSFRow row,Student st){
		int colnum = 0;
		row.createCell(colnum++).setCellValue(st.getSid());
		row.createCell(colnum++).setCellValue(st.getPassword());
		row.createCell(colnum++).setCellValue(st.getSname());
		row.createCell(colnum++).setCellValue(st.getIdNumber());
		row.createCell(colnum++).setCellValue(st.getBirthday());
		row.createCell(colnum++).setCellValue(st.getLevel());
		row.createCell(colnum++).setCellValue(st.getSex());
		row.createCell(colnum++).setCellValue(st.getPhone());
		row.createCell(colnum++).setCellValue(st.getEmail());
		row.createCell(colnum++).setCellValue(st.getProvince());
		row.createCell(colnum++).setCellValue(st.getPhoto());
		row.createCell(colnum++).setCellValue(st.getStatus());
		row.createCell(colnum++).setCellValue(st.getReason());
	}
	
	public void createhssfRow(HSSFSheet sheet,int rolnum){
		HSSFRow hssfRow = sheet.createRow(rolnum);
		int colnum = 0;
		hssfRow.createCell(colnum++).setCellValue("学生用户名"); ;
		hssfRow.createCell(colnum++).setCellValue("学生密码");
		hssfRow.createCell(colnum++).setCellValue("学生姓名");
		hssfRow.createCell(colnum++).setCellValue("身份证号码");
		hssfRow.createCell(colnum++).setCellValue("出生日期");
		hssfRow.createCell(colnum++).setCellValue("报考级别");
		hssfRow.createCell(colnum++).setCellValue("性别");
		hssfRow.createCell(colnum++).setCellValue("手机");
		hssfRow.createCell(colnum++).setCellValue("邮箱");
		hssfRow.createCell(colnum++).setCellValue("报考省份");
		hssfRow.createCell(colnum++).setCellValue("照片");
		hssfRow.createCell(colnum++).setCellValue("审核状态");
		hssfRow.createCell(colnum++).setCellValue("审核未通过原因");
	}
}