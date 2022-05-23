<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
*{
    margin: 0;
    padding: 0;
}
.t_title{
    width: 1920px;
    height: 300px;
    background-image: url("images/bg_top.png");
    text-align: center;
}
h1{
    line-height: 220px;
    letter-spacing: 80px;
    font-size: 50px;
}
.top{
    height: 30px;
    background-image: linear-gradient(#FFFFFF,#DDDDDD);
    border-bottom: #BDBDBD solid 2px;
    border-top: #BDBDBD solid 2px;
    display: flex;
    justify-content: space-between;
    align-items: flex-end;
    padding:0px 10px 4px 20px;
}
#title{
    display: inline-block;
    margin: 35px 0 15px 10px;
    font-size: 20px;
}
.main{
    width: auto;
    height: auto;
    padding: 0 30px 0 30px;
}
.img{
    width: 160px;
    height: 160px;
    background-color: palevioletred;
}
#time{
    width: 100%;
    display: inline-block;
    text-align: right;
    padding-top: 30px;
}
.dairy{
    border-top: 1px dashed #888888;
    padding: 20px 20px 20px 0;
    border-bottom: 1px dashed #888888;
}
a{
	text-decoration: none;
}
a:hover{
	color: #FF4400; 
}
#login {
			position: absolute;
			width: 360px;
			height: 200px;
			display: none;
			z-index: 100;
			background-color: #B6D2EA;
			border: 4px solid #87CEEB;
}
#login table{
	background-color: white;
	width: 100%;
	height: auto;
}
#login_title{
	height: 57px;
	text-align: center;
	letter-spacing: 30px;
	font-size: 24px;
	line-height: 57px;
}
#login{
	
}
#login input[type="text"],#login input[type="password"]{
	height: 26px;
	width: 200px;
	margin: 8px;
}
#login input[type="button"]{
	width: 60px;
	height: 32px;
	margin: 5px;
	color: #574736;
}
#login input[type="button"]:hover{
	background-color: #DE575A;
	color: white;
	border: none;
}
		

</style>
<script type="text/javascript">
var net=new Object();		//定义一个全局的变量
//编写构造函数
net.AjaxRequest=function(url,onload,onerror,method,params){
this.req=null;
this.onload=onload;
this.onerror=(onerror) ? onerror : this.defaultError;
this.loadDate(url,method,params);
}
//编写用于初始化XMLHttpRequest对象并指定处理函数，最后发送HTTP请求的方法
net.AjaxRequest.prototype.loadDate=function(url,method,params){
if (!method){
  method="GET";	//设置默认的请求方式为GET
}
if (window.XMLHttpRequest){	//非IE浏览器
  this.req=new XMLHttpRequest();	//创建XMLHttpRequest对象
} else if (window.ActiveXObject){//IE浏览器
  this.req=new ActiveXObject("Microsoft.XMLHTTP");	//创建XMLHttpRequest对象
}
if (this.req){
  try{
    var loader=this;
    this.req.onreadystatechange=function(){
      net.AjaxRequest.onReadyState.call(loader);
    }

    this.req.open(method,url,true);		// 建立对服务器的调用
	  if(method=="POST"){		// 如果提交方式为POST
		this.req.setRequestHeader("Content-Type","application/x-www-form-urlencoded"); 	// 设置请求的内容类型
		this.req.setRequestHeader("x-requested-with", "ajax");	//设置请求的发出者
	  }
    this.req.send(params);			// 发送请求
  }catch (err){
    this.onerror.call(this);//调用错误处理函数
  }
}
}

//重构回调函数
net.AjaxRequest.onReadyState=function(){
var req=this.req;
var ready=req.readyState;		//获取请求状态
if (ready==4){							//请求完成
	    if (req.status==200 ){					//请求成功
	    	this.onload.call(this);
	    }else{
  		this.onerror.call(this);		//调用错误处理函数
  		alert(req.status);
	    }
}
}
//重构默认的错误处理函籹
net.AjaxRequest.prototype.defaultError=function(){
	alert("错误数据\n\n回调状态:" + this.req.readyState + "\n状态: " + this.req.status);
}

</script>
<script type="text/javascript">
	function loginShow(dev){
			document.getElementById(dev).style.display='block';							//设置由divID所指定的层显示	 
			document.getElementById(dev).style.left=(document.body.clientWidth-140)/2+"px";		//使盒子居中
		    document.getElementById(dev).style.top=(document.body.clientHeight-139)/2+"px";
	}
	function loginClose(dev){
		dev.style.display='none';
	}
	function loginCheck(form2){
		if(form2.uname.value==""){		//验证用户名是否为空
				alert("请输入用户名！");
				form2.uname.focus();
				return false;
			}
			if(form2.upwd.value==""){		//验证密码是否为空
				alert("请输入密码！");
				form2.upwd.focus();
				return false;
			}	
			var params="uname="+form2.uname.value+"&upwd="+form2.upwd.value; 	//将登录信息连接成字符串，作为发送请求的参数
			var loader=new net.AjaxRequest("UserServlet?action=login",login_deal,onerror,"POST",encodeURI(params));
	}
	function login_deal(){
		var h=this.req.responseText;
		h=h.replace(/\s/g,"");	//去除字符串中的Unicode空白 
		alert(h); 
		if(h=="登录成功！"){
			window.location.href="DiaryServlet?action=listAllDiary";
		}else{
			form2.uname.value="";//清空用户名文本框 
			form2.upwd.value="";//清空密码文本框
			form2.uname.focus();//让用户名文本框获得焦点
		}
	}
	function onerror(){
		alert("您的操作有误");
	}
</script>
</head>
<body>
	<div id="notClickDiv"></div>
    <div class="t_title">
    </div>
    <div class="box">
        <div class="top">
            <span>欢迎${sessionScope.uname}光临九宫格日记网！</span>
            <span id="no">
                <a href="DiaryServlet?action=listAllDiary">首页</a>|
                <c:if test="${empty sessionScope.uname}">
                <a href="#" onclick="loginShow('login')">登陆</a>|
                <a href="#" onclick="Regopen('register')">注册</a>|
                <a href="findUpwd_1.jsp">找回密码</a>
                </c:if>
                <c:if test="${!empty sessionScope.uname}">		
				&nbsp;| &nbsp;<a href="DiaryServlet?action=listMyDiary">我的日记</a>
				&nbsp; | &nbsp;<a href="writeDiary.jsp">写九宫格日记</a>
				&nbsp; | &nbsp;<a href="UserServlet?action=exit">退出登录</a>
				</c:if>
            </span>
        </div>
        
    </div>
	<div id="login">
		<div id="login_title">
			用户登录
		</div>
		<form name="form2" method="post" action="" id="form2">
			<table>
				<tr>
					<td align="right">用户名：</td>
					<td align="left"><input type="text" name="uname" /></td>
				</tr>
				<tr>
					<td align="right">密 码：</td>
					<td align="left"><input type="password" name="upwd" /></td>
				</tr>
				<tr>
					<td align="center" colspan="2">
						<input type="button" name="submit" value="登陆" onclick="loginCheck(this.form)" />
						<input type="button" name="submit2" value="退出" onclick="loginClose(login)" />
					</td>
	
				</tr>
			</table>
		</form>
	</div>
</body>

</html>