<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
function checkForm(form){
	if(form.answer.value==""){
		alert("请输入密码提示问题答案！");
		form.answer.focus();
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
            <form name="form_findUpwd" method="post" action="UserServlet?action=findUpwd2"
                onsubmit="return checkForm(this)">
                <ul id="findUpwd2">
                    <li style="padding-top:5px;">密码提示问题： <input type="hidden" name="uname"
                            value="${requestScope.uname}">
                        <input type="text" name="question" value="${requestScope.question}" readonly="readonly"></li>
                    <li>提示问题答案：
                        <input type="text" name="answer" value=""></li>
                    <li style="padding-left:100px;">
                        <input name="Submit" type="submit" value="下一步">
                    </li>
                </ul>


            </form>
        </div>
        <%@ include file="bottom.jsp" %>
    </div>
</body>
</html>