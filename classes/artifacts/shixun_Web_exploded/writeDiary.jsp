<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:if test="${empty sessionScope.uname}">
	<c:redirect url="index.jsp"/>
</c:if>
<!DOCTYPE>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- 使用JQuery解决PNG图片背景不透明的问题 -->
	<script type="text/javascript" src="JS/jquery-1.3.2.min.js"></script>
	<script type="text/javascript" src="JS/pluginpage.js"></script>
	<script type="text/javascript" src="JS/jquery.pngFix.pack.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		$('div.examples').pngFix( );
	});
</script>
<!-- ******************************* -->
<title>写九宫格日记</title>
<style>
#submit input{
width: 100%;
height: 50px;
}
#gridLayout { /*设置写日记的九宫格的<ul>标记的样式*/
	float: left; /*设置浮动方式*/
	list-style: none; /*不显示项目符号*/
	width: 100%; /*设置宽度为100%*/
	margin: 0px; /*设置外边距*/
	padding: 0px; /*设置内边距*/
	display: inline; /*设置显示方式*/
}

#gridLayout li { /*设置写日记的九宫格的<li>标记的样式*/
	width: 33%; /*设置宽度*/
	float: left; /*设置浮动方式*/
	height: 198px; /*设置高度*/
	padding: 0px; /*设置内边距*/
	margin: 0px; /*设置外边距*/
	display: inline; /*设置显示方式*/
}
#opt{									/*设置默认选项相关的<ul>标记的样式 */
	padding:0px 0px 0px 10px;	/*设置上、右、下内边距为0，左内边距为10*/
	margin:0px;					/*设置外边距*/
}
#opt li{								/*设置默认选项相关的<li>标记的样式 */
	width:99%;
	padding:2px 0px 0px 10px;
	font-size:14px;				/*设置字体大小为14像素*/
	height:25px;				/*设置高度*/
	clear:both;					/*左、右两侧不包含浮动内容*/
}
.cssContent{							/*设置内容的样式*/
	float:left;
	padding:35px 0px;					/*设置上、下内边距为40，左、右内边距为0*/
	display:inline;						/*设置显示方式*/
}
#weather{								/*设置天气相关<ul>标记的样式*/
	border:0px;
	padding:15px 0px 0px 30px;
	margin:20px;
	display:inline;

}
#weather li{							/*设置天气相关<li>标记的样式*/
	border:0px;
	width:90%;
	padding:10px;
	margin:0px;
	display:inline;	
}
input{									/*设置输入框的样式*/
	font-size:12px;
}
.title{									/*设置标题的样式*/
color:#0F6548;
font-weight:bold;
}
#writeDiary_bg{							/*设置日记背景的样式*/
width:800px;							/*设置宽度*/
height:730px;						/*设置高度*/
background-repeat:no-repeat;							/*设置背景不重复*/
background-image:url(images/diaryBg_00.png);						/*设置默认的背景图片*/
padding-top:80px;						/*设置顶边距*/
padding-left:60px;						/*设置左边距*/
}
#box form{
background-image: url("images/from_bg.png");
}
</style>
<script type="text/javascript">
function setTemplate(style){
	if(style=="默认"){
		document.getElementById("writeDiary_bg").style.backgroundImage="url(images/diaryBg_00.png)";
		document.getElementById("template").value="默认";
	}else if(style=="样式一"){
		document.getElementById("writeDiary_bg").style.backgroundImage="url(images/diaryBg_01.png)";
		document.getElementById("writeDiary_bg").style.paddingTop="115px";//顶边距
		document.getElementById("template").value="样式一";
	}else{
		document.getElementById("writeDiary_bg").style.backgroundImage="url(images/diaryBg_02.png)";
		document.getElementById("writeDiary_bg").style.paddingTop="115px";//顶边距
		document.getElementById("template").value="样式二";
	}
}
window.onload=function(){
	var date=new Date();		//创建日期对象
	year=date.getFullYear();	//获取当前日期中的年份
	month=date.getMonth();		//获取当前日期中的月份
	day=date.getDate();			//获取当时日期中的日
	week=date.getDay();			//获取当前日期中的星期
	var arr=new Array("星期日","日期一","星期二","星期三","星期四","星期五","星期六");
	document.getElementById("now").innerHTML=year+"年"+(month+1)+"月"+day+"日 "+arr[week];
}

</script>
</head>
<body  bgcolor="#F0F0F0">
<div id="box">
<%@ include file="top.jsp" %>
<c:if test="${empty sessionScope.uname}">
	<c:redirect url="index.jsp"/>
</c:if>
<form name="form1" method="post" action="DiaryServlet?action=preview">
<div style="margin:10px;"><span class="title">请选择模板：</span><a href="#" onClick="setTemplate('默认')">默认</a> <a href="#" onClick="setTemplate('样式一')">样式一</a> <a href="#" onClick="setTemplate('样式二')">样式二</a>
	<input id="template" name="template" type="hidden" value="默认">
</div>
<div style="padding:10px;" class="title">请输入日记标题： <input name="title" type="text" size="30" maxlength="30" value="请在此输入标题" onFocus="this.select()"></div>
<div id="writeDiary_bg">




<div style="width:700px; height:600px; ">
<ul id="gridLayout">
<li>
	<div class="cssContent">
		<ul id="opt">
		<li>
	 	 <input name="content" type="text" size="30" maxlength="15" value="请在此输入文字" onFocus="this.select()">
	  	</li>
	   	<li><input type="radio" onClick="document.getElementsByName('content')[0].value='活着'" name="0" />活着</li>
		<li><input type="radio" onClick="document.getElementsByName('content')[0].value='吃饱了'" name="0" />吃饱了</li>
		<li><input type="radio" onClick="document.getElementsByName('content')[0].value='开心的事'" name="0" />开心的事</li>
		<li><input type="radio" onClick="document.getElementsByName('content')[0].value='无'" name="0" />无</li>
	  	</ul>
	</div>
</li>
<li>
	<div class="cssContent">
		<ul id="opt">
		<li>
	  <input name="content" type="text" size="30" maxlength="15" value="请在此输入文字" onFocus="this.select()">
	  </li>
	   <li><input type="radio" onClick="document.getElementsByName('content')[1].value='活着'" name="1" />活着</li>
		<li><input type="radio" onClick="document.getElementsByName('content')[1].value='吃饱了'" name="1" />吃饱了</li>
		<li><input type="radio" onClick="document.getElementsByName('content')[1].value='开心的事'" name="1" />开心的事</li>
		<li><input type="radio" onClick="document.getElementsByName('content')[1].value='无'" name="1" />无</li>
	   </ul>
	</div>
</li>
<li>
	<div class="cssContent">
		<ul id="opt">
		<li>
	  <input name="content" type="text" size="30" maxlength="15" value="请在此输入文字" onFocus="this.select()">
	  </li>
	   <li><input type="radio" onClick="document.getElementsByName('content')[2].value='活着'" name="2" />活着</li>
		<li><input type="radio" onClick="document.getElementsByName('content')[2].value='吃饱了'" name="2" />吃饱了</li>
		<li><input type="radio" onClick="document.getElementsByName('content')[2].value='开心的事'" name="2" />开心的事</li>
		<li><input type="radio" onClick="document.getElementsByName('content')[2].value='无'" name="2" />无</li>
	   </ul>
	</div>
</li>
<li>
	<div class="cssContent">
		<ul id="opt">
		<li>
	  <input name="content" type="text" size="30" maxlength="15" value="请在此输入文字" onFocus="this.select()">
	  </li>
	    <li><input type="radio" onClick="document.getElementsByName('content')[3].value='活着'" name="3" />活着</li>
		<li><input type="radio" onClick="document.getElementsByName('content')[3].value='吃饱了'" name="3" />吃饱了</li>
		<li><input type="radio" onClick="document.getElementsByName('content')[3].value='开心的事'" name="3" />开心的事</li>
		<li><input type="radio" onClick="document.getElementsByName('content')[3].value='无'" name="3" />无</li>
	   </ul>
	</div>
</li>
<li>
	<ul id="weather"><li style="height:27px;"> <span id="now" style="font-size: 14px;font-weight:bold;padding-left:5px;">正在获取日期</span>
		<input name="content" type="hidden" value="weathervalue"><br></br>
		<div class="examples">
		<input name="weather" type="radio" value="1">
		<img src="images/1.png" width="30" height="30">
		<input name="weather" type="radio" value="2">
  		<img src="images/2.png" width="30" height="30">
		<input name="weather" type="radio" value="3">
  		<img src="images/3.png" width="30" height="30"><br>
		<input name="weather" type="radio" value="4">
  		<img src="images/4.png" width="30" height="30">
		<input name="weather" type="radio" value="5" checked="checked">
  		<img src="images/5.png" width="30" height="30">
		<input name="weather" type="radio" value="6">
  		<img src="images/6.png" width="30" height="30"><br>
		<input name="weather" type="radio" value="7">
  		<img src="images/7.png" width="30" height="30">
		<input name="weather" type="radio" value="8">
  		<img src="images/8.png" width="30" height="30">
		<input name="weather" type="radio" value="9">
  		<img src="images/9.png" width="30" height="30">
  		</div> 
	</li>
  	</ul>
</li>
<li>
	<div class="cssContent">
		<ul id="opt">
		<li>
	  <input name="content" type="text" size="30" maxlength="15" value="请在此输入文字" onFocus="this.select()">
	  </li>
	    <li><input type="radio" onClick="document.getElementsByName('content')[5].value='活着'" name="5" />活着</li>
		<li><input type="radio" onClick="document.getElementsByName('content')[5].value='吃饱了'" name="5" />吃饱了</li>
		<li><input type="radio" onClick="document.getElementsByName('content')[5].value='开心的事'" name="5" />开心的事</li>
		<li><input type="radio" onClick="document.getElementsByName('content')[5].value='无'" name="5" />无</li>
	   </ul>
	</div>
</li>
<li>
	<div class="cssContent">
		<ul id="opt">
		<li>
	  <input name="content" type="text" size="30" maxlength="15" value="请在此输入文字" onFocus="this.select()">
	  </li>
	    <li><input type="radio" onClick="document.getElementsByName('content')[6].value='活着'" name="6" />活着</li>
		<li><input type="radio" onClick="document.getElementsByName('content')[6].value='吃饱了'" name="6" />吃饱了</li>
		<li><input type="radio" onClick="document.getElementsByName('content')[6].value='开心的事'" name="6" />开心的事</li>
		<li><input type="radio" onClick="document.getElementsByName('content')[6].value='无'" name="6" />无</li>
	   </ul>
	</div>
</li>
<li>
	<div class="cssContent">
		<ul id="opt">
		<li>
	  <input name="content" type="text" size="30" maxlength="15" value="请在此输入文字" onFocus="this.select()">
	  </li>
	    <li><input type="radio" onClick="document.getElementsByName('content')[7].value='活着'" name="7" />活着</li>
		<li><input type="radio" onClick="document.getElementsByName('content')[7].value='吃饱了'" name="7" />吃饱了</li>
		<li><input type="radio" onClick="document.getElementsByName('content')[7].value='开心的事'" name="7" />开心的事</li>
		<li><input type="radio" onClick="document.getElementsByName('content')[7].value='无'" name="7" />无</li>
	   </ul>
	</div>
</li>
<li>
	<div class="cssContent">
		<ul id="opt">
		<li>
	  <input name="content" type="text" size="30" maxlength="15" value="请在此输入文字" onFocus="this.select()">
	  </li>
	    <li><input type="radio" onClick="document.getElementsByName('content')[8].value='活着'" name="8" />活着</li>
		<li><input type="radio" onClick="document.getElementsByName('content')[8].value='吃饱了'" name="8" />吃饱了</li>
		<li><input type="radio" onClick="document.getElementsByName('content')[8].value='开心的事'" name="8" />开心的事</li>
		<li><input type="radio" onClick="document.getElementsByName('content')[8].value='无'" name="8" />无</li>
	   </ul>
	</div>
</li>
</ul>
</div>



</div>
<div style="height:50px;" id="submit"><input type="submit" value="预览"></div>
</form>
 <%@ include file="bottom.jsp" %> 
</div>
</body>
</html>