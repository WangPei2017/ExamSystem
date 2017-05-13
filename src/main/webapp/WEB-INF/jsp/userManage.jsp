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
    <div  style="height:490px">
        <div id="u_toolbar">
             <label>用户名:</label> <input id="s_username" name="s_username" class="easyui-textbox">
             <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-search" onclick="searchUser()">查询</a>
             <a href="javascript:reSet();" class="easyui-linkbutton" iconCls="icon-clear">重置</a> 
             <a href="javascript:openAddUserDialog()" class="easyui-linkbutton" iconCls="icon-add">增加</a>
	    </div>
	    <!-- 定义数据列表 -->
        <div id="userGird" style="height:100%"></div> 
        <!-- 添加/修改对话框 -->
		<div id="addOrUpdateDialog" class="easyui-dialog" style="width: 350px; height: 400px; padding: 30px 20px" closed="true">
			<form id="addOrUpdateForm">
				<input type="hidden" id="u_id" name="id"/>
				<div style="height: 30px;">
					<label>用户姓名:</label> <input id="u_name" name="name" class="easyui-textbox" required="true">
				</div>
				<div style="height: 30px;">
					<label>用户密码:</label> <input id="u_password" name="password" class="easyui-textbox" required="true">
				</div>
				<div style="height: 30px;">
					<label>是否启用:</label>
					<select id="enable" name="enable" class="easyui-combobox">
						<option  value="1">已启用</option>
						<option  value="0">未启用</option>
					</select>
				</div>
			</form>
			<div>
				<a href="javascript:submitForm()" class="easyui-linkbutton" iconCls="icon-save" >保存</a>
				<a href="javascript:dialogClose()" class="easyui-linkbutton" iconCls="icon-clear">取消</a>
			</div>
		</div>

		<div id="roleSelectDialog" class="easyui-dialog" style="width:400px;height:100px;" closed="true">
			<input id="userId" name="userId" type="hidden"/>
			<input id="roleSelect" name="roleSelect"/>
			<input type="button" value="保存" iconCls="icon-save" onclick="saveUserRole()"/>
		</div>
    </div>
    
    <script type="text/javascript">
        var path = '<%=path%>';
		$(function(){   
			$('#userGird').datagrid({
			    loadMsg: "正在加载数据，请稍等...", 
			    type: "POST",
			    url:path+"/user/getAllUser.do",
			    fitColumns: true,
			    rownumbers: true,
			    singleSelect: true,
			    toolbar:'#u_toolbar',
			    pagination:true,//设置是否分页
			    pageList:[10,20,30,50],
			    pageSize:10,
			    columns: [[  
				            { title: '用户名', field: 'name', width: 100},  
				            { title: '是否启用', field: 'enable', width: 100,
				            	formatter: function(value,row,index){
				            		return value=="1"?"已启用":"未启用"
				                }
				            },
				            { title: '操作', field: 'id', width: 100,
				            	formatter: function(value,row,index){
				            		var str = "";
				            		str +="  <a href=\"javascript:loadRoleAuthority('"+value+"')\">角色配置</a>  ";
				            		str +="  <a href=\"javascript:deleteUser('"+value+"')\">删除</a>  ";
				            		str +="  <a href=\"javascript:updateUserDialog('"+value+"')\">修改</a>  ";
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
		//打开添加用户的dialog
		function openAddUserDialog(){
			$('#addOrUpdateForm').form('clear');
			$('#addOrUpdateDialog').dialog('open').dialog('setTitle', '新增用户');
		}
		function dialogClose(){
			$('#addOrUpdateDialog').dialog('close');
		}
		//打开修改窗口
		function updateUserDialog(userId){
			$('#addOrUpdateForm').form('clear');
			$.ajax({
		        type: "POST",
		        url: path+"/user/getUserById.do",
		        data: {"id":userId},
		        dataType : 'json',
		        success: function(data){
		        	$("#u_id").val(data.id);
		        	$("#u_name").textbox('setValue',data.name);
		        	$("#u_password").textbox('setValue',data.password);
 		        	$("#enable").combobox('setValue',data.enable);
		        	$('#addOrUpdateDialog').dialog('open').dialog('setTitle', '修改用户');
		        },
		        error: function(e){
		        	$.messager.alert('提示', '操作失败', 'error');
		        }
		    });
		}
		//删除用户
		function deleteUser(userId){
			$.ajax({
		        type: "POST",
		        url: path+"/user/deleteUser.do",
		        data: {"id":userId},
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
			var url=path+"/user/getAllUser.do";
			$('#userGird').datagrid({
				url:url,
				queryParams:{"sname":sname}
			});
	    }
		//重置查询条件
		function reSet() {
			$("#s_username").textbox('setValue',"");
		}
		//保存添加、修改内容
		function saveOrUpdateUser() {
			url = path+"/user/saveOrUpdateUser.do";
			$.ajax({
		        type: "POST",
		        url: url,
		        data: $('#addOrUpdateForm').serialize(),
		        dataType : 'text',
		        success: function(data){
		        	if(1==data){
		        		$.messager.alert('提示', '操作成功', 'info');
		        		$('#addOrUpdateDialog').dialog('close');
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
		function submitForm(){
			$('#addOrUpdateForm').form('submit',{
				onSubmit:function(){
					return $(this).form('enableValidation').form('validate');
				},    
			    success:function(data){    
			    	saveOrUpdateUser();
			    }
			});
		}
		//配置用户角色
		function loadRoleAuthority(id){
			$('#userId').val(id);
			$('#roleSelectDialog').dialog('open').dialog('setTitle', '角色配置');
			//查询角色列表
			$.ajax({
		        type: "POST",
		        url: path+"/user/getRoleList.do",
		        data: {'id':id},
		        dataType : 'json',
		        success: function(data){
		        	$('#roleSelect').combobox({    
						data:data.rolelist,    
					    valueField:'id',    
					    textField:'name'
					});
		        	$('#roleSelect').combobox('setValue', data.roleid);
		        },
		        error: function(e){
		        	$.messager.alert('提示', '操作失败', 'error');
		        }
		    });
			
		}
		//保存用户角色
		function saveUserRole(){
			var json = {'userId':$('#userId').val(),'roleId':$('#roleSelect').combobox('getValue')};
			$.ajax({
		        type: "POST",
		        url: path+"/user/saveUserRole.do",
		        data: json,
		        dataType : 'text',
		        success: function(data){
		        	if("true"==data){
		        		$.messager.alert('提示', '操作成功', 'info');
		        		$('#roleSelectDialog').dialog('close');
		        	}else{
		        		$.messager.alert('提示', '操作失败', 'info');
		        	}
		        },
		        error: function(e){
		        	$.messager.alert('提示', '操作失败', 'error');
		        }
		    }); 
		}
		
	</script>     
    
</body>
</html>