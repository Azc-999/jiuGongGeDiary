<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>密码找回一</title>

<script type="text/javascript">
function checkForm(form){
	if(form.username.value==""){
		alert("请输入用户名！");
		form.username.focus();
		return false;
	}
}
</script>
</head>
<body  bgcolor="#F0F0F0">
	<div id="box">
	<%@ include file="top.jsp" %>
	<%@ include file="register.jsp" %>
	 <div id="forgetPwd" style="height:356px;">
	<form name="form_findUpwd" method="post" action="UserServlet?action=findUpwd1" onsubmit="return checkForm(this)">
	<ul id="forgetPwd1">
		<li style="padding-top:5px;">请输入用户名： </li>
		<li><input type="text" name="uname"> </li>
		 <li style="padding-left:10px;">
		 <input name="Submit" type="submit" value="下一步">
		</li>
	</ul>
	</form>
	</div>
	<%@ include file="bottom.jsp" %>
	</div>
</body>
</html>