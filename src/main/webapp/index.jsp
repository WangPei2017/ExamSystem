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
          <div>
            <a href="<%=path %>/login/tologin.do" class="easyui-linkbutton" data-options="iconCls:'icon-ok'" style="padding:3px 0px;width:79%;">
                <span style="font-size:13px;">学生</span>
            </a>
            <a href="<%=path %>/system/systologin.do" onclick="dologin()" class="easyui-linkbutton" data-options="iconCls:'icon-ok'" style="padding:3px 0px;width:79%;">
                <span style="font-size:13px;">考务</span>
            </a>
        </div>
        </div>
      
</body>
</html>