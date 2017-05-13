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

<body class="easyui-layout">  
    <div data-options="region:'north',split:true">
          <div class="banner-font-left">
             ${userinfo.name}&nbsp;您好，欢迎使用本考试系统系统
          </div>
          <div class="banner-font-right" >
              <span  id="curruntTime"></span>
              <span class="banner-login"><a href="javascript:logout()" >退出</a>&nbsp;&nbsp;&nbsp;<a href="javascript:updateUserDialog(${userinfo.id})" >修改密码</a></span>
          </div>
        </div> 
    </div>  
    <div data-options="region:'west',title:'菜单',split:true" style="width:200px;">
       <ul id="tt" class="easyui-tree"></ul>
    </div>  
    <div  data-options="region:'center'" style="padding:5px;background:#eee;">
        <div class="easyui-tabs" fit="true" border="false" id="tabs">
	      <div title="首页"></div>
	    </div>
    </div> 
    
 	 <!-- 修改密码对话框 -->
			<div id="UpdatepasswordDialog" class="easyui-dialog" style="width: 350px; height: 400px; padding: 30px 20px" closed="true">
				<form id="UpdatepasswordForm">
					<input type="hidden" id="u_id" name="id"/>
					<div style="height: 30px;">
						<label>用户姓名:</label> <input id="u_name" name="name" class="easyui-textbox" required="true">
					</div>
					<div style="height: 30px;">
						<label>用户密码:</label> <input id="u_password" name="password" class="easyui-textbox" required="true">
					</div>
				</form>
				<div>
				<a href="javascript:UpdatepasswordForm()" class="easyui-linkbutton" iconCls="icon-save" >保存</a>
				<a href="javascript:dialogUpdateClose()" class="easyui-linkbutton" iconCls="icon-clear">取消</a>
			</div>
			</div>
				
    <script type="text/javascript">
        var path = '<%=path%>';
		$('#tt').tree({
			//data:[{"id":1,"text":"Folder1","iconCls":"icon-save", "children":[{"text":"File1", "checked":true }]}]
			type: "POST",
			url:path+"/menu/getMenuTree.do",
		    onClick: function(node){
		    	if (node.attributes) {
	                Open(node.text, node.attributes,node.icons);
	            }
			}
		});
		function Open(text, url,icons) {
			if ($("#tabs").tabs('exists', text)) {
	            $('#tabs').tabs('select', text);
	        } else {
	            $('#tabs').tabs('add', {
	                title : text,
	                content:'<iframe  src="'+path+url+'" frameBorder="0" border="0" marginheight=0 marginwidth=0 scrolling= "no" style="width: 100%; height: 100%;" noResize/>',
	                closable : true,
	                iconCls:icons
	                //href:path+url
	            });
	        }
	    }
		function currentTime(){
			var curruntDate=new Date();
			var year=curruntDate.getFullYear();
			var moth=curruntDate.getMonth()+1;
			moth=moth<10?"0"+moth:moth;
			var date=curruntDate.getDate();
			date=date<10?"0"+date:date;
			var hour = curruntDate.getHours(); 
			hour=hour<10?"0"+hour:hour;
			var minute = curruntDate.getMinutes(); 
			minute=minute<10?"0"+minute:minute;
			var second = curruntDate.getSeconds(); 
			second=second<10?"0"+second:second;
			var week = curruntDate.getDay(); 
			var str="";
			if (week == 0) {  
			        str = "星期日";  
			} else if (week == 1) {  
			        str = "星期一";  
			} else if (week == 2) {  
			        str = "星期二";  
			} else if (week == 3) {  
			        str = "星期三";  
			} else if (week == 4) {  
			        str = "星期四";  
			} else if (week == 5) {  
			        str = "星期五";  
			} else if (week == 6) {  
			        str = "星期六";  
			} 
            $("#curruntTime").html(year+"-"+moth+"-"+date+"&nbsp;&nbsp;"+str+"&nbsp;&nbsp;"+hour+":"+minute+":"+second);
		}
		setInterval(currentTime,1000);
		
		function logout(){
			location.href=path+"/system/syslogout.do";
		}
		
		
	
		//打开修改密码
		function updateUserDialog(userId){
			$.ajax({
		        type: "POST",
		        url: path+"/user/getUserById.do",
		        data: {"id":userId},
		        dataType : 'json',
		        success: function(data){
		        	$("#u_id").val(data.id);
		        	$("#u_name").textbox('setValue',data.name);
		        	$("#u_password").textbox('setValue',data.password);
		        	$('#UpdatepasswordDialog').dialog('open').dialog('setTitle', '修改密码');
		        },
		        error: function(e){
		        	$.messager.alert('提示', '操作失败', 'error');
		        }
		    });
		}
		//保存修改的密码
		function UpdatepasswordForm(){
			$('#UpdatepasswordForm').form('submit',{
				onSubmit:function(){
					return $(this).form('enableValidation').form('validate');
				},    
			    success:function(data){    
			    	UpdateUser();
			    }
			});
		}	
		
		//保存修改内容
		function UpdateUser() {
			url = path+"/user/saveOrUpdateUser.do";
			$.ajax({
		        type: "POST",
		        url: url,
		        data: $('#UpdatepasswordForm').serialize(),
		        dataType : 'text',
		        success: function(data){
		        	if(1==data){
		        		$.messager.alert('提示', '操作成功', 'info');
		        		$('#UpdatepasswordDialog').dialog('close');
		        	}else{
		        		$.messager.alert('提示', '操作失败', 'info');
		        	}
		        },
		        error: function(e){
		        	$.messager.alert('提示', '操作失败', 'error');
		        }
		    });
		}
		//关闭修改密码对话框
		function dialogAddClose(){
			$('#UpdatepasswordDialog').dialog('close');
		}
	</script> 
</body>
</html>