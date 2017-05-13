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
<script type="text/javascript" src="<%=path%>/js/easyUI/jquery.min.js"></script>
<script type="text/javascript" src="<%=path%>/js/easyUI/jquery.easyui.min.js"></script>
<script type="text/javascript" src="<%=path%>/js/easyUI/easyui-lang-zh_CN.js"></script>
</head>

<body>
    <div style="height:490px">
        <div id="u_toolbar">
             <label>学生姓名:</label> <input id="s_username" name="sname" class="easyui-textbox">
             <a href="javascript:void()" class="easyui-linkbutton" iconCls="icon-search" onclick="searchUser()">查询</a>
             <a href="javascript:reSet();" class="easyui-linkbutton" iconCls="icon-clear">重置</a> 
             <a href="javascript:openAddUserDialog()" class="easyui-linkbutton" iconCls="icon-add">增加</a>
	    	<a href="javascript:void()" class="easyui-linkbutton" iconCls="icon-print" id="download" >下载学生信息</a>
	    </div>
	    <!-- 定义数据列表 -->
        <div id="userGird" style="height:100%"></div> 
        <!-- 修改对话框 -->
		<div id="updateDialog" class="easyui-dialog" style="width: 350px; height: 400px; padding: 30px 20px" closed="true">
			<form id="updateForm">
				 <input type="hidden" id="sid" name="sid"/>
				<input type="hidden" id="password" name="password"/> 
				<!--<div style="height: 30px;">
					<label>学生用户名:</label> <input id="sid" name="sid" class="easyui-textbox" required="true">
				</div> 
				<div style="height: 30px;">
					<label>学生登录密码:</label> <input id="password" name="password" class="easyui-textbox" required="true" >
				</div> 
				-->
				<div style="height: 30px;">
					<label>学生姓名:</label> <input id="sname" name="sname" class="easyui-textbox" required="true">
				</div>
				<div style="height: 200px;">
					<label>照片:</label> <input id="photo" name="photo" type="hidden" class="easyui-textbox"  >
					<img alt=""  height="180" width="150"/> 
				 <label class="upload" >点我上传</label>
				</div>
				<div style="height: 30px;">
					<label>身份证号码:</label> <input id="idNumber" name="idNumber" class="easyui-textbox" readOnly="readonly">
					<span id="idNum_span"></span>
				</div>
				<div style="height: 30px;">
					<label>出生日期:</label> <input id="birthday" name="birthday" class="easyui-datebox" required="true">
				</div>
				<div style="height: 30px;">
					<label>报考级别:</label>
					<select id="level" name="level" class="easyui-combobox" required="true">
						<option  value="1">一级</option>
						<option  value="2">二级</option>
						<option  value="3">三级</option>
						<option  value="4">四级</option>
					</select>
				</div>
				<div style="height: 30px;">
					<label>性别:</label>
					<select id="sex" name="sex" class="easyui-combobox">
						<option  value="2">女</option>
						<option  value="1">男</option>
					</select>
				</div>
				<div style="height: 30px;">
					<label>手机号:</label> <input id="phone" name="phone" class="easyui-textbox" required="true">
				</div>
				<div style="height: 30px;">
					<label>邮箱:</label> <input id="email" name="email" class="easyui-textbox" required="true" >
				</div>
				<div style="height: 30px;">
					<label>报考省份:</label> <input id="province" name="province" class="easyui-textbox" required="true">
				</div>
				 <div style="height: 30px;">
					<label>审核状态:</label> <select id="status" name="status" class="easyui-combobox" >
						<option  value="0">未提交</option>
						<option  value="1">未审核</option>
						<option  value="2">审核通过</option>
						<option  value="3">审核未通过</option>
					</select>
				</div>
				<div style="height: 30px;">
					<label>审核未通过原因:</label> <input id="reason" name="reason" class="easyui-textbox" >
				</div> 
			</form>
			<div>
			<a href="javascript:submitUpdateForm()" class="easyui-linkbutton" iconCls="icon-save" >保存</a>
			<a href="javascript:dialogUpdateClose()" class="easyui-linkbutton" iconCls="icon-clear">取消</a>
			</div>
		</div>
		
    </div>
   <div id="exportDialog" class="easyui-dialog" style="width: 350px; height: 400px; padding: 30px 20px" closed="true"> 
   <span id="exportspan"></span>
   </div>
   <div id="addGird" style="height:100%"></div>
        <!-- 添加对话框 -->
		<div id="addDialog" class="easyui-dialog" style="width: 350px; height: 400px; padding: 30px 20px" closed="true">
			<form id="addForm">
				<div style="height: 30px;">
					<label>学生用户名:</label> <input id="sid_add" name="sid" class="easyui-validatebox" required="true" onChange="dovalidate()">
					<span id="sid_span"></span>
				</div> 
				<div style="height: 30px;">
					<label>学生登录密码:</label> <input id="password_add" name="password" class="easyui-textbox" required="true" >
				</div> 
				<div style="height: 30px;">
					<label>学生姓名:</label> <input id="sname_add" name="sname" class="easyui-textbox" required="true">
				</div>
				<div style="height: 200px;">
					<label>照片:</label> <input id="photo_add" name="photo" type="hidden" class="easyui-textbox"  >
					<img alt=""  height="180" width="150"/> 
				 <label class="upload" >点我上传</label>
				</div>
				<div style="height: 30px;">
					<label>身份证号码:</label> <input id="idNumber_add" name="idNumber" class="easyui-validatebox" required="true" onChange="valiNumber()">
					<span id="idNum_addspan"></span>
				</div>
				<div style="height: 30px;">
					<label>出生日期:</label> <input id="birthday_add" name="birthday" class="easyui-datebox" required="true">
				</div>
				<div style="height: 30px;">
					<label>报考级别:</label>
					<select id="level_add" name="level" class="easyui-combobox">
						<option  value="1">一级</option>
						<option  value="2">二级</option>
						<option  value="3">三级</option>
						<option  value="4">四级</option>
					</select>
				</div>
				<div style="height: 30px;">
					<label>性别:</label>
					<select id="sex_add" name="sex" class="easyui-combobox">
						<option  value="0">女</option>
						<option  value="1">男</option>
					</select>
				</div>
				<div style="height: 30px;">
					<label>手机号:</label> <input id="phone_add" name="phone" class="easyui-textbox" required="true">
				</div>
				<div style="height: 30px;">
					<label>邮箱:</label> <input id="email_add" name="email" class="easyui-textbox" required="true" >
				</div>
				<div style="height: 30px;">
					<label>报考省份:</label> <input id="province_add" name="province" class="easyui-textbox" required="true">
				</div>
				 <div style="height: 30px;">
					<label>审核状态:</label> <select id="status_add" name="status" class="easyui-combobox" >
						<option  value="0">未提交</option>
						<option  value="1">未审核</option>
						<option  value="2">审核通过</option>
						<option  value="3">审核未通过</option>
					</select>
				</div>
				<div style="height: 30px;">
					<label>审核未通过原因:</label> <input id="reason_add" name="reason" class="easyui-textbox" >
				</div> 
			</form>
			<div>
				<a href="javascript:submitAddForm()" class="easyui-linkbutton" iconCls="icon-save" >保存</a>
				<a href="javascript:dialogAddClose()" class="easyui-linkbutton" iconCls="icon-clear">取消</a>
			</div>
		</div>
    
    <script type="text/javascript">
        var path = '<%=path%>';
		$(function(){   
			$('#userGird').datagrid({
			    loadMsg: "正在加载数据，请稍等...", 
			    url:path+"/student/getAllStudent.do",
			    fitColumns: true,
			    rownumbers: true,
			    singleSelect: true,
			    toolbar:'#u_toolbar',
			    pagination:true,//设置是否分页
			    pageList:[10,20,30,50],
			    pageSize:10,
			    columns: [[  

				           /*  { title: '学生登录密码', field: 'password', width: 100},   */  
				            { title: '学生姓名', field: 'sname', width: 100},  
				            { title: '身份证号码', field: 'idNumber', width: 100},  
				            { title: '出生日期', field: 'birthday', width: 100},  
				            { title: '报考级别', field: 'level', width: 100,
				            	formatter: function(value,row,index){
				            		if(value==1)
				            			return "一级";
				            		else if(value==2)
				            			return "二级";
				            		else if(value==3)
				            			return "三级";
				            		else if(value==4)
					            			return "四级";
				                }
				            },
				            { title: '性别', field: 'sex', width: 100,
				            	formatter: function(value,row,index){
				            		return value=="1"?"男":"女"
				                }
				            },
				            { title: '手机号', field: 'phone', width: 100},  
				            { title: '邮箱', field: 'email', width: 100},  
				            { title: '报考省份', field: 'province', width: 100},  
				            { title: '照片', field: 'photo', align:'center',

				                formatter:function(value,row,index){   //关键：格式化，并返回一个img标签

				                	return '<img  height="180" width="150" src="'+path+row.photo+'"/>';
				                }
				            },  
				            { title: '审核状态', field: 'status', width: 100,
					            formatter: function(value,row,index){
					            		if(value==0)
					            			return "未提交";
					            		else if(value==1)
					            			return "未审核";
					            		else if(value==2)
					            			return "审核通过";
					            		else if(value==3)
						            			return "审核未通过";
					                }
				            },  
				            { title: '审核未通过原因  ', field: 'reason', width: 100}, 
				            { title: '操作', field: 'sid', width: 100,
				            	formatter: function(value,row,index){
				            		var str = "";
				            		str +="  <a href=\"javascript:deleteUser('"+value+"')\">删除</a>  ";
				            		str +="  <a href=\"javascript:updateUser('"+value+"')\">修改</a>  ";
				            		return str;
				    			}
							}
				        ]],
			});
			/* var p = $('#roleGird').datagrid('getPager');
            $(p).pagination({
                pageSize: 10,//每页显示的记录条数，默认为10  
                pageList: [10,20,30,50],//可以设置每页记录条数的列表  
                beforePageText: '第',//页数文本框前显示的汉字  
                afterPageText: '页    共 {pages} 页',
                displayMsg: '当前显示 {from} - {to} 条记录   共 {total} 条记录'
            }); */

		});
		

		//打开添加用户的dialog
		function openAddUserDialog(){
			$('#addForm').form('clear');
			$('#addDialog').dialog('open').dialog('setTitle', '新增学生');
		}
		//关闭添加用户
		function dialogAddClose(){
			$('#addDialog').dialog('close');
		}
		//打开修改窗口
		function updateUser(sid){
			$('#updateForm').form('clear');
			$.ajax({
		        type: "POST",
		        url: path+"/student/getStudentById.do",
		        data: {"sid":sid},
		        dataType : 'json',
		        success: function(data){
		        	$("#sid").val(data.sid);
		        	$("#password").val(data.password);
		        	$("#sname").textbox('setValue',data.sname);
 		        	$("#idNumber").textbox('setValue',data.idNumber);
		        	$("#birthday").textbox('setValue',data.birthday);
		        	$("#level").textbox('setValue',data.level);
 		        	$("#sex").combobox('setValue',data.sex);
		        	$("#phone").textbox('setValue',data.phone);
		        	$("img").attr('src',path+data.photo);
		        	$("#email").textbox('setValue',data.email);
 		        	$("#photo").textbox('setValue',data.photo);
		        	$("#province").textbox('setValue',data.province);
 		        	$("#status").combobox('setValue',data.status);
 		        	$('#updateDialog').dialog('open').dialog('setTitle', '修改用户');
		        },
		        error: function(e){
		        	$.messager.alert('提示', '操作失败', 'error');
		        }
		    });
		}
		
		//关闭修改用户
		function dialogUpdateClose(){
			$('#updateDialog').dialog('close');
		}
		//删除用户
		function deleteUser(sid){
			$.ajax({
		        type: "POST",
		        url: path+"/student/deletestuById.do",
		        data: {"id":sid},
		        dataType : 'text',
		        success: function(data){
		        	if(data==1){
		        		$.messager.alert('提示', '操作成功', 'info');
			        	$('#userGird').datagrid('reload'); 
		        	}
		        },
		        error: function(e){
		        	$.messager.alert('提示', '操作失败', 'error');
		        }
		    });
		}
		//查询用户
		function searchUser() {
			var sname=$("#s_username").textbox('getValue');
			var url=path+"/student/getAllStudent.do";
			$('#userGird').datagrid({
				url:url,
				queryParams:{"sname":sname}
			});
	    }
		//重置查询条件
		function reSet() {
			$("#s_username").textbox('setValue',"");
		}
		//保存添加内容
		function saveUser() {
			url = path+"/student/saveStudent.do";
			$.ajax({
		        type: "POST",
		        url: url,
		        data: $('#addForm').serialize(),
		        dataType : 'text',
		        success: function(data){
		        	if("ok"==data){
		        		$.messager.alert('提示', '操作成功', 'info');
		        		$('#addDialog').dialog('close');
		        		$('#addGird').datagrid('reload'); 
		        	}else{
		        		$.messager.alert('提示', '操作失败', 'info');
		        	}
		        },
		        error: function(e){
		        	$.messager.alert('提示', '操作失败', 'error');
		        }
		    });
		}
		//添加
		function submitAddForm(){
			$('#addForm').form('submit',{
				onSubmit:function(){
					return $(this).form('enableValidation').form('validate');
				},    
			    success:function(data){    
			    	saveUser();
			    }
			});
		}
		//保存修改内容
		function UpdateUser() {
			url = path+"/student/modify.do";
			$.ajax({
		        type: "POST",
		        url: url,
		        data: $('#updateForm').serialize(),
		        dataType : 'text',
		        success: function(data){
		        	if(1==data){
		        		$.messager.alert('提示', '操作成功', 'info');
		        		$('#updateDialog').dialog('close');
		        		$('#userGird').datagrid('reload'); 
		        	}else{
		        		 $.messager.alert('提示', '操作失败', 'info'); 
		        	}
		        },
		        error: function(e){
		        	$.messager.alert('提示', '操作失败', 'error');
		        }
		    });
		}
		function submitUpdateForm(){
			$('#updateForm').form('submit',{
				onSubmit:function(){
					return $(this).form('enableValidation').form('validate');
				},    
			    success:function(data){    
			    	UpdateUser();
			    }
			});
		}	
		
		//验证用户名是否可用
		function dovalidate(){
			var reqdata={"sid":$("#sid_add").val()};
			$.ajax({
				type:"post",
				url:"<%=path%>/student/countStudentById.do",
				data:reqdata,
				dataType:"text",
				success:function(res){
						$("#sid_span").html("<font color='red'>"+res+"</font>");
				}
			});
		}
		//保存验证身份证信息用户
		function valiNumber(){
			var reqdata={"idNumber":$("#idNumber_add").val()};
				$.ajax({
			        type: "POST",
			        url: path+"/student/countIdNumber.do",
			        data: reqdata,
			        dataType : 'text',
			        success:function(res){
		        		$("#idNum_addspan").html("<font color='red'>"+res+"</font>");
					}
		        });
		    }

		//下载学生信息
		$('#download').bind('click',function(){
			var downloadfiledir=$('#downloadfiledir').val()
			window.location.href = path+"/exportstu/exportstudentinfo.do";
		});	
		//上传照片
		$('.upload').bind('click',function(){
			alert(/upload/+$("#sid").val()+".jpg")
			window.open(path+"/upload/uploadPicture.do","upload","width=531,height=402,top=50,left=800");
			$("#photo").textbox('setValue',/upload/+$("#sid").val()+".jpg");
			$("#photo_add").textbox('setValue',/upload/+$("#sid").val()+".jpg");
		});
		
	</script>     
</body>
</html>