<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
String path=request.getContextPath();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="<%=path %>/js/easyUI/themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="<%=path %>/js/easyUI/themes/icon.css">
<script type="text/javascript" src="<%=path %>/js/easyUI/jquery.min.js"></script>
<script type="text/javascript" src="<%=path %>/js/easyUI/jquery.easyui.min.js"></script>
<script type="text/javascript" src="<%=path %>/js/easyUI/easyui-lang-zh_CN.js"></script>
<script type="text/javascript" src="<%=path %>/js/easyUI/jquery.cookie.js"></script>
</head>

<body style="background: url('<%=path %>/images/005.jpg') repeat">  
    
    <div  class="easyui-window" title="登录" data-options="modal:true,iconCls:'icon-man',closable:false,collapsible:false,minimizable:false,maximizable:false" style="width:360px;padding:20px 70px 20px 70px;">
        <div style="margin-bottom:10px">
            <input class="easyui-textbox" id="logname" style="height:30px;padding:12px" data-options="prompt:'系统登陆用户',iconCls:'icon-man',iconWidth:38" required="true">
            <span id="u_span"></span>
        </div>
        <div style="margin-bottom:20px">
            <input class="easyui-textbox" id="logpass" type="password" style="height:30px;padding:12px" data-options="prompt:'登录密码',iconCls:'icon-lock',iconWidth:38" required="true">
        </div>
        <div style="margin-bottom:20px">
            <input type="checkbox" id="logrem">
            <span>记住我</span>
        </div>
        <div>
            <a href="javascript:;" onclick="dologin()" class="easyui-linkbutton" data-options="iconCls:'icon-ok'" style="padding:3px 0px;width:79%;">
                <span style="font-size:13px;">登录</span>
            </a>
        </div>
    </div> 
    <script type="text/javascript">
	    document.onkeydown=function(event){ 
	        var e = event || window.event || arguments.callee.caller.arguments[0]; 
	        if(e && e.keyCode==13){
	        	dologin();
	        }
	    }
        $(function(){
        	$("input",$("#logname").next("span")).focus(function(){
        		$("#u_span").empty();
        	});
        	$("#logrem").click(function(){
        		if($("#logrem").attr("checked")){
        			$("#logrem").removeAttr("checked");
        		}else{
        			$("#logrem").attr("checked","checked");
        		}
        	})
        	if( $.cookie("username") ){ 
        		
				$("input",$("#logname").next("span")).val($.cookie("username"));  
		    }
        	if( $.cookie("password") ){  
				$("input",$("#logpass").next("span")).val($.cookie("password"));  
		    }
        	if( $.cookie("logrem") ){ 
				$("#logrem").attr("checked","checked");  
		    }
        })
        //$("#logname").val();
        //$.cookie("username") 取值
        //$.cookie("username","马云")//赋值
        function setCookie(){
        	if($("#logrem").attr("checked")){
    			//如果选中，则将用户名、密码、是否记住放到cookie中
    			$.cookie("username",$("#logname").textbox('getValue'),{
    				path: "/", express: 7
    			});
    			$.cookie("password",$("#logpass").textbox('getValue'),{
    				path: "/", express: 7
    			});
    			$.cookie("logrem",$("#logrem").val(),{
    				path: "/", express: 7
    			});
    		}else{
    			$.cookie('username', null,{path: "/"});
    			$.cookie('password', null,{path: "/"});
    			$.cookie('logrem', null,{path: "/"});
    		}
        }
		function dologin(){
			setCookie();
			var reqdata={"username":$("#logname").textbox('getValue'),"password":$("#logpass").textbox('getValue')};
			$.ajax({
				type:"post",
				url:"<%=path %>/system/sysdologin.do",
				data:reqdata,
				dataType:"text",
				success:function(res){
					if(res!="ok"){
						$("#u_span").html("<font color='red'>"+res+"</font>");
					}else{
						location.href="<%=path%>/system/main.do";
					}
				}
			})
		}
	</script> 
</body>
</html>