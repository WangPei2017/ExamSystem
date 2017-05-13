<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
String path=request.getContextPath();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="<%=path%>/js/easyUI/themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="<%=path%>/js/easyUI/themes/icon.css">
<link rel="stylesheet" type="text/css" href="<%=path%>/css/main.css">
<script type="text/javascript" src="<%=path%>/js/easyUI/jquery.min.js"></script>
<script type="text/javascript" src="<%=path%>/js/easyUI/jquery.easyui.min.js"></script>
<script type="text/javascript" src="<%=path%>/js/easyUI/easyui-lang-zh_CN.js"></script>
</head>

<body style="background: url('<%=path%>/images/005.jpg') repeat">

	<div class="easyui-window" title="注册"
		data-options="modal:true,iconCls:'icon-man',closable:false,collapsible:false,minimizable:false,maximizable:false"
		style="width:360px;padding:20px 70px 20px 70px;">
		<div style="margin-bottom:10px">
			<input class="easyui-validatebox" id="regname"
				style="height:13px;padding:9px"
				data-options="prompt:'用户',iconCls:'icon-man',iconWidth:38"
				required="true" onChange="dovalidate()"> <span id="u_span"></span>
		</div>
		<div style="margin-bottom:20px">
			密码：<input class="easyui-validatebox" id="regpass" type="password"
				validType="length[4,32]" class="easyui-validatebox"
				style="height:10px;padding:10px"
				required="true">
		</div>
		<div style="margin-bottom:20px">
			确认密码：<input class="easyui-validatebox" id="repassword" type="password"
			class="easyui-validatebox" validType="equals['#regpass']" 
			style="height:10px;padding:10px"
			required="true">		
		</div>
		<div>
			<a href="javascript:;" onclick="doregister()" class="easyui-linkbutton"
				data-options="iconCls:'icon-ok'" style="padding:3px 0px;width:79%;">
				<span style="font-size:13px;">注册</span>
			</a>
		</div>
	</div>
	<script type="text/javascript">
    document.onkeydown=function(event){ 
        var e = event || window.event || arguments.callee.caller.arguments[0]; 
        if(e && e.keyCode==13){
        	doregister();
        }
    };
	function doregister(){
		var reqdata={"sid":$("#regname").val(),"password":$("#regpass").val()};
		$.ajax({
			type:"post",
			url:"<%=path%>/student/register.do",
			data:reqdata,
			dataType:"text",
			success:function(res){
				if(res=="ok"){
					location.href="<%=path%>/student/studentShow.do"; 
				}
			}
		});
	}
	
	function dovalidate(){
		var reqdata={"sid":$("#regname").val()};
		$.ajax({
			type:"post",
			url:"<%=path%>/student/countStudentById.do",
			data:reqdata,
			dataType:"text",
			success:function(res){
					$("#u_span").html("<font color='red'>"+res+"</font>");
			}
		});
	}
	$.extend($.fn.validatebox.defaults.rules, {   
	    equals: {   
	        validator: function(value,param){   
	            return value == $(param[0]).val();   
	        },   
	        message: '两次输入密码不匹配'  
	    	}   
		}); 
	
	</script>
</body>
</html>