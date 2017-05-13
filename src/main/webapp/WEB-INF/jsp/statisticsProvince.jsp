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
        <div id="u_toolbar"> </div>
	    <!-- 定义数据列表 -->
        <div id="userGird" style="height:100%"></div> 
        
    
    <script type="text/javascript">
        var path = '<%=path%>';
		$(function(){   
			$('#userGird').datagrid({
			    loadMsg: "正在加载数据，请稍等...", 
			    url:path+"/statistics/statisticsByProvince.do",
			    fitColumns: true,
			    rownumbers: true,
			    singleSelect: true,
			    toolbar:'#u_toolbar',
			    pagination:false,//设置是否分页
			    pageList:[10,20,30,50],
			    pageSize:10,
			    columns: [[  

				            { title: '省份', field: 'province', width: 100},
				            { title: '计数', field: 'provincecount', width: 100}
				        ]],
				onLoadSuccess:function(data){compute();},  
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
        
        function compute() {//计算函数  
            //返回当前页的所有行  
            var arr =$("#userGird").datagrid("getRows");  
            var provincecount=0;  
            //累加  
            for( var i= 0; i < arr.length; i++) {  
            	provincecount += arr[i].provincecount;  
             }
            
             //新增一行显示统计信息  
              $('#userGird').datagrid('appendRow', { statisticsProvince: '<b>统计：</b>', provincecount: provincecount });
     } 
        
         

	</script>     
</body>
</html>