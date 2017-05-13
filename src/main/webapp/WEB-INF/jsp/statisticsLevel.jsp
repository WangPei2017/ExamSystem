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
			    url:path+"/statistics/statisticsByLevel.do",
			    fitColumns: true,
			    rownumbers: true,
			    singleSelect: true,
			    toolbar:'#u_toolbar',
			    pagination:false,//设置是否分页
			    pageList:[10,20,30,50],
			    pageSize:10,
			    columns: [[  

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
				            { title: '计数', field: 'levelcount', width: 100}
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
            var levelcount=0;  
            //累加  
            for( var i= 0; i < arr.length; i++) {  
            	levelcount += arr[i].levelcount;  
             }
             //新增一行显示统计信息  
              $('#userGird').datagrid('appendRow', { levelcount: '<b>统计：</b>', levelcount: levelcount });
     } 
        
         

	</script>     
</body>
</html>