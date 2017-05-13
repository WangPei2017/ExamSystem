<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="refresh" content="时间;url=地址">
<title>学生信息更改响应</title>
 <script>
var flag = true;
document.onmousemove = new Function("flag = false;");
function judgeMouse() {
if(flag) {
location.href = "${pageContext.request.contextPath}/login/tologin.do";
} else {
flag = true;
}
}
setInterval("judgeMouse()", 1000);//超时返回时间数（毫秒）
</script>
</head>
<body>
${mess}
<br/>
<a href="${pageContext.request.contextPath}/login/tologin.do">如没跳转，点击此处返回登录页面</a>
</body>
</html>