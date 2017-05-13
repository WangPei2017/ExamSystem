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

<body >
    <div style="height:490px">
        <div id="u_toolbar">
             <label>学生姓名:</label> <input id="s_username" name="sname" class="easyui-textbox">
             <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-search" onclick="searchUser()">查询</a>
             <a href="javascript:reSet();" class="easyui-linkbutton" iconCls="icon-clear">重置</a> 
	    </div>
	    <!-- 定义数据列表 -->
        <div id="userGird" style="height:100%"></div> 
        <!-- 审核对话框 -->
		<div id="auditDialog" class="easyui-dialog" style="width: 350px; height: 400px; padding: 30px 20px" closed="true">
			<form id="auditForm">
				 <input type="hidden" id="sid" name="sid"/>
				<input type="hidden" id="password" name="password"/> 
				<div style="height: 30px;">
					<label>学生姓名:</label> <input id="sname" name="sname" class="easyui-textbox" required="true">
				</div>
				<div style="height: 200px;">
					<label>照片:</label> <input id="photo_add" name="photo" type="hidden" class="easyui-textbox"  >
					<img alt=""  height="180" width="150"/> 
				</div>
				<div style="height: 30px;">
					<label>身份证号码:</label> <input id="idNumber" name="idNumber" class="easyui-textbox" required="true" disabled="disabled">
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
			<a href="javascript:toAudit('2')" class="easyui-linkbutton" iconCls="icon-redo" >通过</a>
			<a href="javascript:toAudit('3')" class="easyui-linkbutton" iconCls="icon-back" >不通过</a>
			<a href="javascript:dialogAuditClose()" class="easyui-linkbutton" iconCls="icon-clear">取消</a>
			</div>
		</div>
		
    </div>
    
    <script type="text/javascript">
        var path = '<%=path%>';
		$(function(){   
			$('#userGird').datagrid({
			    loadMsg: "正在加载数据，请稍等...", 
			    type: "POST",
			    url:path+"/student/getAllStudent.do",
			    fitColumns: true,
			    rownumbers: true,
			    singleSelect: true,
			    toolbar:'#u_toolbar',
			    pagination:true,//设置是否分页
			    pageList:[10,20,30,50],
			    pageSize:10,
			    columns: [[  
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
				            		if(row.status==1||row.status==3){
				            		str +="  <a href=\"javascript:auditUser('"+value+"')\">审核</a>  ";
				            		}
				            		return str;
				    			}
							}
				        ]]
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
		
		//打开审核窗口
		function auditUser(sid){
			$('#auditForm').form('clear');
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
		        	$("#email").textbox('setValue',data.email);
 		        	$("#photo").textbox('setValue',data.photo);
 		        	$("img").attr('src',path+data.photo);
		        	$("#province").textbox('setValue',data.province);
 		        	$("#status").combobox('setValue',data.status);
 		        	$("#reason").textbox('setValue',data.reason);
 		        	$('#auditDialog').dialog('open').dialog('setTitle', '审核学生信息');
		        },
		        error: function(e){
		        	$.messager.alert('提示', '操作失败', 'error');
		        }
		    });
		}
		
		//关闭审核用户
		function dialogAuditClose(){
			$('#auditDialog').dialog('close');
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
		
		//审核
		function toAudit(status){
			var reason=$("#reason").textbox('getValue');
			if(status=="2"){
				reason="";
			}
			$.ajax({
				type:"post",
				url:path+"/audit/toAudit.do",
				data:{"sid":$("#sid").val(),"status":status,"reason":reason},
				dataType:'text',
				success:function(data){
					if(data==1){
						dialogAuditClose();
		        		$.messager.alert('提示', '操作成功', 'info');
			        	$('#userGird').datagrid('reload'); 
		        	}
				},error:function(e){
					$.messager.alert('提示', '操作失败', 'error');
				}
			});
		}

	</script>     
    
</body>
</html>