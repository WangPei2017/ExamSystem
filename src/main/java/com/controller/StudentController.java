package com.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.entity.PageBean;
import com.entity.Student;
import com.service.IStudentService;
import com.util.JsonUtil;

import net.sf.json.JSONObject;

@Controller
@RequestMapping(value="/student")
public class StudentController {
	@Autowired
	private IStudentService studentService;
	
	@RequestMapping("/studentManage")
    public String auditManage(){
		return "studentManage";
	}
	
	@RequestMapping("/studentShow")
    public String studentShow(){
		return "studentShow";
	}
//	学生更改完信息后的响应页面
	@RequestMapping("/stuResponseMessage")
    public String stuResponseMessage(){
		return "stuResponseMessage";
	}
	@RequestMapping("/studentRegister")
	public String studentRegister(){
		return "studentRegister";
	}
	//注册,学生
	@RequestMapping(value="/register",method=RequestMethod.POST)
	@ResponseBody()
	public String register(String sid,String password,HttpSession session){
		String mess="";
		Student stu = new Student();
		stu.setSid(sid);
		stu.setPassword(password);
		Student findStu = studentService.findStudentById(stu);
		if(findStu==null&&sid!=null&&!("".equals(sid))){
			studentService.addStudent(stu);
			session.setAttribute("stuinfo", stu);
			mess = "ok" ;
		}else {
			mess = "此用户名不可用" ;
		}
		return mess;
	}
	//考务增加学生
	@RequestMapping(value="/saveStudent",method=RequestMethod.POST)
	@ResponseBody()
	public String saveStudent(Student student,HttpSession session) {
		String mess="";
		Student findStu = studentService.findStudentById(student);
		if(findStu==null&&student!=null&&!("".equals(student.getSid()))){
			studentService.addStudent(student);
			session.setAttribute("stuinfo", student);
			mess = "ok" ;
		}
		return mess;
	}
	//考务修改学生信息
	@RequestMapping(value="/modify",method=RequestMethod.POST)
	@ResponseBody()
	public String modify(Student student) {
		int n = studentService.modifyStudent(student);
		return String.valueOf(n);
	}
	
	@RequestMapping(value="/deletestuById",method=RequestMethod.POST)
	@ResponseBody
	public String deletestuById(String id){
		Integer n=studentService.deleteStudent(id);
		return String.valueOf(n);
	}
	//学生更改基本信息
	@RequestMapping(value="/upateStudent",method=RequestMethod.POST)
	public ModelAndView upateStudent(Student student){
		ModelAndView mv = new ModelAndView();
		String mess="操作失败!";
		//审核过（状态为2）不能修改
		if ("2"!=student.getStatus()) {
			//提交后审核状态变更为待审核状态1
			if("0".equals(student.getStatus())||student.getStatus()==""||student.getStatus()==null){
				student.setStatus("1");
			}
			Integer n = studentService.modifyStudent(student);
			if(n>0){
				switch(Integer.parseInt(student.getStatus().trim())){
					case 0:
						mess="提交成功!";
						break;
					default:
						mess="更改成功!";
				}
			}
		}
		mv.addObject("mess", mess);
		mv.setViewName("stuResponseMessage");
		return mv;
	}
	
	@RequestMapping(value="/getStudentById",method=RequestMethod.POST)
	@ResponseBody
	public String getStudentById(String sid){
		Student student = null;
		if (sid!=null&&""!=sid) {
			student = new Student();
			student.setSid(sid);
		}
		Student stu = studentService.findStudentById(student);
		JSONObject jsonObj = JsonUtil.bean2Json(stu);
		return jsonObj.toString();
	}

	@RequestMapping(value="/countStudentById",method=RequestMethod.POST)
	@ResponseBody
	public String countStudentById(String sid){
		Integer n = studentService.countStudentById(sid);
		return n>0?"此用户名已占用":"此用户名可以用";
	}
	
	@RequestMapping(value="/getAllStudent",method=RequestMethod.POST)
	@ResponseBody
	public String getAllStudent(HttpServletRequest request) {
		//查询参数
		String name = request.getParameter("sname");
		//分页第几页
		String pageNumber = request.getParameter("page");
		//每页记录数
		String pageSize = request.getParameter("rows");
		PageBean pageBean = new PageBean();
		//分页统一设置
		pageBean.setPagein(Integer.parseInt(pageNumber),Integer.parseInt(pageSize));
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("name", name);
		pageBean.setMap(map);
		//查询用户记录
		List<Student> list = studentService.getAllStudent(pageBean);
		//查询总记录数
		int rowcount = studentService.getStudentCount(pageBean);
		//放到分页组件中
		JSONObject jsonObj = new JSONObject();
		jsonObj.accumulate("total", rowcount);
		jsonObj.accumulate("rows", list);
		return jsonObj.toString();
	}
	
	
	
	@RequestMapping(value="/countIdNumber",method=RequestMethod.POST)
	@ResponseBody
	public String countIdNumber(String idNumber,String sid){
		Student student = studentService.findStudentById(sid);
		Integer n = studentService.countIdNumber(idNumber);
		if (student!=null) {
			return n > 1 ? "身份证号码重复" : "  ";
		}else{
			return n > 0 ? "身份证号码重复" : "  ";
		}
	}
	
	
}
