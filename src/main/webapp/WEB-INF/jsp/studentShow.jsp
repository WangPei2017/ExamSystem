<%@ page language="java" import="com.entity.Student" contentType="text/html; charset=UTF-8" 
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="pageurl" value="${pageContext.request.contextPath}"></c:set>
<!DOCTYPE HTML>
<html>
<head>
<meta charset="utf-8">
<meta name="renderer" content="webkit|ie-comp|ie-stand">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
<meta http-equiv="Cache-Control" content="no-siteapp" />
<!--[if lt IE 9]>
<script type="text/javascript" src="lib/html5.js"></script>
<script type="text/javascript" src="lib/respond.min.js"></script>
<script type="text/javascript" src="lib/PIE_IE678.js"></script>
<![endif]-->
<link href="${pageurl }/js/v2.3/css/H-ui.min.css" rel="stylesheet" type="text/css" />
<link href="${pageurl }/js/v2.3/css/H-ui.admin.css" rel="stylesheet" type="text/css" />
<link href="${pageurl }/js/v2.3/lib/icheck/icheck.css" rel="stylesheet" type="text/css" />
<link href="${pageurl }/js/v2.3/css/style.css" rel="stylesheet" type="text/css" />
<link href="${pageurl }/js/v2.3/lib/Hui-iconfont/1.0.1/iconfont.css" rel="stylesheet" type="text/css" />
<link href="${pageurl }/js/v2.3/lib/lightbox2/2.8.1/css/lightbox.css" rel="stylesheet" type="text/css" >
<!--[if IE 6]>
<script type="text/javascript" src="http://lib.h-ui.net/DD_belatedPNG_0.0.8a-min.js" ></script>
<script>DD_belatedPNG.fix('*');</script>
<![endif]-->
<title>学生报名信息</title>
<script type="text/javascript">
</script>
</head>
<body>

<div class="pd-20">
	<form action="${pageurl }/student/upateStudent.do" method="post" class="form form-horizontal" id="form-admin-add">
		<input type="hidden" id="sid" name="sid" value="${stuinfo.sid }"/>
		<input type="hidden" id="password" name="password"/> 
		<div class="row cl">
			<label class="form-label col-3"><span class="c-red">*</span>姓名：</label>
			<div class="formControls col-5">
				<input type="text" class="input-text" value="" placeholder="" id="sname" name="sname" datatype="*2-16" nullmsg="姓名不能为空">
			</div>
			<div class="col-4"> </div>
		</div>
	<div class="row cl">
			<label class="form-label col-3"><span class="c-red">*</span>照片：</label>
			<input type="hidden" id ="photo" name="photo"/>
			<img alt=""  height="180" width="150"/>
		</div>
	<div class="row cl">
      <label class="form-label col-3">上传jpg格式的照片：</label>
    	<div class="formControls col-5">
		 <label id="upload" >点我上传</label>
		</div>
    </div>
		<div class="row cl">
			<label class="form-label col-3"><span class="c-red">*</span>身份证号码：</label>
			<div class="formControls col-5">
				<input type="text" class="input-text" value="" placeholder="" id="idNumber" name="idNumber"  datatype="*15-18" nullmsg="手机不能为空"  onChange="valiNumber()"  />
				<span id="idNum_span"></span>
			</div>
			<div class="col-4"> </div>
		</div>
		<div class="row cl">
			<label class="form-label col-3"><span class="c-red">*</span>出生日期：</label>
			<div class="formControls col-5">
				<input type="text" onfocus="WdatePicker({})" id="birthday" name="birthday" class="input-text Wdate" style="width:120px;">
			</div>
			<div class="col-4"> </div>
		</div>
		
		<div class="row cl">
			<label class="form-label col-3">报考级别：</label>
			<div class="formControls col-5"> <span class="select-box" style="width:150px;">
				<select class="select" id="level" name="level" size="1">
					<option  value="1">一级</option>
					<option  value="2">二级</option>
					<option  value="3">三级</option>
					<option  value="4">四级</option>
				</select>
				</span> </div>
		</div>
		<div class="row cl">
			<label class="form-label col-3">性别：</label>
			<div class="formControls col-5"> <span class="select-box" style="width:150px;">
				<select class="select" id="sex" name="sex" size="1">
					<option  value="1">男</option>
					<option  value="2">女</option>
				</select>
				</span> </div>
		</div>
		<div class="row cl">
			<label class="form-label col-3"><span class="c-red">*</span>手机：</label>
			<div class="formControls col-5">
				<input type="text" class="input-text" value="" placeholder="" id="phone" name="phone" datatype="m" nullmsg="手机不能为空">
			</div>
			<div class="col-4"> </div>
		</div>
		<div class="row cl">
			<label class="form-label col-3"><span class="c-red">*</span>邮箱：</label>
			<div class="formControls col-5">
				<input type="text" class="input-text" placeholder="@" name="email" id="email" datatype="e" nullmsg="请输入邮箱！">
			</div>
			<div class="col-4"> </div>
		</div>
		<div class="row cl">
			<label class="form-label col-3"><span class="c-red">*</span>报考省份：</label>
			<div class="formControls col-5">
				<input type="text" class="input-text" value="" placeholder="" id="province" name="province"  datatype="s" nullmsg="报考省份不能为空">
			</div>
			<div class="col-4"> </div>
		</div>
		<div class="row cl">
			<label class="form-label col-3">审核状态：</label>
			<div class="formControls col-5"> <span class="select-box" style="width:150px;">
				<select class="select" id="status" name="status" size="1" disabled="disabled">
					<option  value="0">未提交</option>
					<option  value="1">未审核</option>
					<option  value="2">审核通过</option>
					<option  value="3">审核未通过</option>
				</select>
				</span> </div>
			<input type="hidden" id="status1" name="status"/>
		</div>
		<div class="row cl">
			<label class="form-label col-3"><span class="c-red"></span>审核未通过原因：</label>
			<div class="formControls col-5">
				<input type="text" class="input-text" value="" readonly="readonly" placeholder="" id="reason" name="reason"readOnly="readOnly">
			</div>
			<div class="col-4"> </div>
		</div>
		<div class="row cl">
			<div class="col-9 col-offset-3">
				<input class="btn btn-primary radius" id="submit" type="submit" value="&nbsp;&nbsp;提交&nbsp;&nbsp;">
			</div>
		</div>
	</form>
</div>
<script type="text/javascript" src="${pageurl }/js/v2.3/lib/jquery/1.9.1/jquery.min.js"></script> 
<script type="text/javascript" src="${pageurl }/js/v2.3/lib/icheck/jquery.icheck.min.js"></script> 
<script type="text/javascript" src="${pageurl }/js/v2.3/lib/My97DatePicker/WdatePicker.js"></script> 
<script type="text/javascript" src="${pageurl }/js/v2.3/lib/Validform/5.3.2/Validform.min.js"></script> 
<script type="text/javascript" src="${pageurl }/js/v2.3/lib/layer/1.9.3/layer.js"></script> 
<script type="text/javascript" src="${pageurl }/js/v2.3/js/H-ui.js"></script> 
<script type="text/javascript" src="${pageurl }/js/v2.3/js/H-ui.admin.js"></script> 
<script type="text/javascript">
$(document).ready(function(){
	var path="${pageurl }";
	var sid = $("#sid").val();
	$("#form-admin-add").Validform({
		tiptype:2,
		callback:function(form){
			
			
		}
	});
	$('#upload').bind('click',function(){
		window.open(path+"/upload/uploadPicture.do","upload","width=531,height=402,top=50,left=800");
		$("#photo").val("/upload/"+sid+".jpg");
	});
	$.ajax({
        type: "POST",
        url: path+"/student/getStudentById.do",
        data: {"sid":sid},
        dataType : 'json',
        success: function(data){
        	$("#sid").val(data.sid);
        	$("#password").val(data.password);
        	$("#sname").val(data.sname);
        	$("#photo").val(data.photo);
        	$("img").attr('src',path+data.photo);
	        $("#idNumber").val(data.idNumber);
        	$("#birthday").val(data.birthday);
        	$("#level").val(data.level);
	        $("#sex").val(data.sex);
        	$("#phone").val(data.phone);
        	$("#email").val(data.email);
        	$("#province").val(data.province);
	        $("#status").val(data.status);
	        $("#status1").val(data.status); 
	       	if(data.status == 0){
	       		$('#submit').val('提交');
	       	} else if(data.status == 1 || data.status == 3){
	       		$('#submit').val('修改');
	       		$("#idNumber").attr('readonly','readonly');
	       	} else if (data.status == 2){
	       		$('#submit').remove();
	       		$("#idNumber").attr('readonly','readonly');
	       	}
	        
        }
    });
});
//保存验证身份证信息不能重复
function valiNumber(){
	var path="${pageurl }";
	var reqdata={"idNumber":$("#idNumber").val()};
		$.ajax({
	        type: "POST",
	        url: path+"/student/countIdNumber.do",
	        data: reqdata,
	        dataType : 'text',
	        success:function(res){
        		$("#idNum_span").html("<font color='red'>"+res+"</font>");
			}
        });
    }
</script>
</body>
</html>