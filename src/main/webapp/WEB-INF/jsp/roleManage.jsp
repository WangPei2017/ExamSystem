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

<body >
    <div  class="easyui-layout" style="width:700px;height:500px">
        <div id="toolbar">
		     <a href="javascript:openAddRoleDialog()" class="easyui-linkbutton c6" iconCls="icon-add">增加</a> 
	    </div> 
        <div id="roleGird" style="height:480px"></div> 
        <div id="addRoleDialog" class="easyui-dialog" style="width:300px;height:150px;padding:30px 20px" closed="true" buttons="#addRoleButtons">
			<form id="addRoleForm" method="post">
				<div class="fitem">
					<label>角色名称:</label> <input name="name" class="easyui-textbox" required="true">
				</div>
			</form>
		</div>
		<div id="addRoleButtons">
			<a href="javascript:addRole()" class="easyui-linkbutton" iconCls="icon-save">保存</a> 
			<a href="javascript:$('#addRoleDialog').dialog('close')" class="easyui-linkbutton" iconCls="icon-clear">取消</a>
		</div>
		<div id="menuAuthTreeDialog" class="easyui-dialog" title="权限列表" style="width:400px;height:90%;" closed="true">
			<ul id="menuAuthTree" class="easyui-tree"></ul>
			<a href="javascript:saveMenuAuthority()" class="easyui-linkbutton" iconCls="icon-save">保存</a> 
		</div>
    </div>
    
    <script type="text/javascript">
        var path = '<%=path%>';
        var currentRoleId;
		$(function(){   
			$('#roleGird').datagrid({
			    loadMsg: "正在加载数据，请稍等...",  
			    url : path+"/role/getAllRole.do",
			    fitColumns: true,
			    rownumbers: true,
			    singleSelect: true,
			    toolbar:'#toolbar',
			    pagination:true,
			    pageList:[10,20,30,50],
			    pageSize:10,
			    columns: [[  
			            { title: '角色名称', field: 'name', width: 100, editor: 'text'},  
			            { title: '操作', field: 'id', width: 100,
			            	formatter: function(value,row,index){
			            		var str = "";
			            		str +="  <a href=\"javascript:loadMenuAuthority('"+value+"')\">菜单权限</a>";
			            		str +="  <a href=\"javascript:deleteRoleById('"+value+"')\">删除</a>";
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
		//打开添加角色的dialog
		function openAddRoleDialog(){
			$('#addRoleForm').form('clear');
			$('#addRoleDialog').dialog('open').dialog('setTitle','添加角色');
		}
		//保存添加的角色
		function addRole(){
			 $('#addRoleForm').form('submit',{
			 	url: path+"/role/saveOrUpdate.do",
			 	onSubmit: function(){
			 		return $(this).form('validate');
			 	},
				success: function(data){
					$('#addRoleDialog').dialog('close'); 
					$('#roleGird').datagrid('reload'); 
				}
		 	});
		}
		//删除角色
		function deleteRoleById(roleId){
			$.ajax({
		        type: "POST",
		        url: path+"/role/deleteRole.do",
		        data: {"id":roleId},
		        dataType : 'text',
		        success: function(data){
		        	$.messager.alert('提示', '操作成功', 'info');
		        	$('#roleGird').datagrid('reload'); 
		        },
		        error: function(e){
		        	$.messager.alert('提示', '操作失败', 'error');
		        }
		    });
		}
		//加载指定角色的菜单权限
		function loadMenuAuthority(roleId){
			currentRoleId=roleId;
			//var data=[{'id':1,'text':'aa', 'children':[{'text':'bb','checked':true},{'text':'dd','checked':true}]},{ 'text':'cc','state':'open','children':[{'text':'Java'},{ 'text':'C'}] }];
			$('#menuAuthTreeDialog').dialog('open').dialog('setTitle','菜单权限');
			$('#menuAuthTree').tree({
				lines: true,
				checkbox: true,
				//data:data,
				url:path+"/role/getMenuAuthTree.do?roleId="+roleId+" ",
			});
			//展开
			//$('#menuAuthTree').tree('expandAll');
// 			var node = $('#menuAuthTree').tree('getSelected');
//             if (node) {
//                 $('#menuAuthTree').tree('expandAll', node.target);
//             }else {
//                 $('#menuAuthTree').tree('expandAll');
//             }
		}
		//保存修改好后的角色菜单权限
		function saveMenuAuthority(){
			var nodes = $('#menuAuthTree').tree('getChecked');
			var indeterminate = $('#menuAuthTree').tree('getChecked', 'indeterminate');
			var menuIds="";
			if(currentRoleId != null){
				if(nodes.length > 0){
					for (var i=0;i<nodes.length;i++){
						if(menuIds==""){
							menuIds+=nodes[i].id;
						}else{
							menuIds+="|"+nodes[i].id;
						}
					}
					for (var i=0;i<indeterminate.length;i++){
						if(menuIds==""){
							//menuIds+=indeterminate[i].id;
						}else{
							//menuIds+="|"+indeterminate[i].id;
						}
					}
				}
				$.ajax({
			        type: "POST",
			        url: path+"/role/updateRoleMenu.do",
			        data: {'menuId':menuIds,'roleId':currentRoleId},
			        dataType : 'text',
			        success: function(data){
			        	if("true"==data){
			        		$.messager.alert('提示', '操作成功', 'info');
			        	}else{
			        		$.messager.alert('提示', '操作失败', 'info');
			        	}
			        },
			        error: function(e){
			        	$.messager.alert('提示', '操作失败', 'error');
			        }
			    });
			}
		}
	</script>     
    
</body>
</html>