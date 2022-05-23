<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE>
<html>

<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<link rel="stylesheet" type="text/css" href="css/register.css"/>
</head>

<body>
	<script type="text/javascript" src="JS/AjaxRequest.js"></script>
	<script type="text/javascript" src="JS/wghFunction.js"></script>
	<script type="text/javascript">
		//显示用户注册页面
		function Regopen(divID) {
			divID = document.getElementById(divID); //根据传递的参数获取操作的对象
			divID.style.display = 'block'; //显示用户注册页面
			divID.style.left = (document.body.clientWidth - 663) / 2; //设置页面的左边距
			divID.style.top = (document.body.clientHeight - 441) / 2; //设置页面的顶边距
		}
		//隐藏用户注册页面
		function Myclose(divID) {
			document.getElementById(divID).style.display = 'none'; //隐藏用户注册页面
			//设置id为notClickDiv的层隐藏
		}
	</script>
	<script type="text/javascript">
		var flag_user = true; //记录用户是否合法
		var flag_pwd = true; //记录密码是否合法
		var flag_repwd = true; //确认密码是否通过
		var flag_email = true; //记录E-mail地址是否合法
		var flag_question = true; //记录密码提示问题是否输入
		var flag_answer = true; //记录提示问题答案是否输入
		//验证用户名是否合法，并且未被注册
		function checkUser(str) {
			if (str == "") { //当用户名为空时
				flag_user = false;
			} else { //进行异步操作，判断用户名是否被注册
				var loader = new net.AjaxRequest("UserServlet?action=checkUser&uname=" + str + "&nocache=" +
					new Date().getTime(), deal, onerror, "GET");
			}
		}

		function deal() {
			result = this.req.responseText; //获取返回的检测结果
			result = result.replace(/\s/g, ""); //去除Unicode空白符
			if (result == "1") { //当用户名没有被注册
				flag_user = true;
			} else { //当用户名已经被注册
				alert(result);
				flag_user = false;
			}

		}

		/*************************************************************************************************************/
		//验证密码
		function checkPwd(str) {
			if (str == "") { //当密码为空时
				document.getElementById("div_pwd").innerHTML = "请输入密码！"; //设置提示文字
				document.getElementById("tr_pwd").style.display = 'block'; //显示提示信息
				flag_pwd = false;
			} else if (!checkePwd(str)) { //当密码不合法时
				document.getElementById("div_pwd").innerHTML = "您输入的密码不合法！"; //设置提示文字
				document.getElementById("tr_pwd").style.display = 'block'; //显示提示信息
				flag_pwd = false;
			} else { //当密码合法时
				document.getElementById("div_pwd").innerHTML = ""; //清空提示文字
				document.getElementById("tr_pwd").style.display = 'none'; //隐藏提示信息显示行
				flag_pwd = true;
			}
		}
		//验证确认密码是否正确
		function checkRepwd(str) {
			if (str == "") { //当确认密码为空时
				document.getElementById("div_pwd").innerHTML = "请确认密码！"; //设置提示文字
				document.getElementById("tr_pwd").style.display = 'block'; //显示提示信息
				flag_repwd = false;
			} else if (form1.pwd.value != str) { //当确认密码与输入的密码不一致时
				document.getElementById("div_pwd").innerHTML = "两次输入的密码不一致！"; //设置提示文字
				document.getElementById("tr_pwd").style.display = 'block'; //显示提示信息
				flag_repwd = false;
			} else { //当两次输入的密码一致时
				document.getElementById("div_pwd").innerHTML = ""; //清空提示文字
				document.getElementById("tr_pwd").style.display = 'none'; //隐藏提示信息显示行
				flag_repwd = true;
			}
		}
		//验证E-mail地址
		function checkEmail(str) {
			if (str == "") { //当E-mail地址为空时
				document.getElementById("div_email").innerHTML = "请输入E-mail地址！"; //设置提示信息
				document.getElementById("tr_email").style.display = 'block'; //显示提示信息
				flag_email = false;
			} else if (!checkemail(str)) { //当E-mail地址不合法时
				document.getElementById("div_email").innerHTML = "您输入的E-mail地址不正确！"; //设置提示信息
				document.getElementById("tr_email").style.display = 'block'; //显示提示信息
				flag_email = false;
			} else {
				document.getElementById("div_email").innerHTML = ""; //清空提示信息
				document.getElementById("tr_email").style.display = 'none'; //不显示提示信息
				flag_email = true;
			}
		}
		//验证提示问题答案
		function checkQuestion(str_q, str_a) {
			if (str_q != "" && str_a == "") { //当密码提示问题不为空，而提示问题答案为空时
				document.getElementById("div_answer").innerHTML = "请输入提示问题答案！"; //设置提示信息
				document.getElementById("tr_answer").style.display = 'block'; //显示提示信息
				flag_answer = false;
			} else if (str_q == "" && str_a != "") { //当密码提示问题为空，而提示问题答案不为空时
				document.getElementById("div_question").innerHTML = "请输入密码提示问题！"; //设置提示信息
				document.getElementById("tr_question").style.display = 'block'; //显示提示信息
				flag_question = false;
			} else {
				document.getElementById("div_answer").innerHTML = ""; //清空提示信息
				document.getElementById("div_question").innerHTML = ""; //清空提示信息
				document.getElementById("tr_answer").style.display = 'none'; //不显示提示信息
				document.getElementById("tr_question").style.display = 'none'; //不显示提示信息
				flag_answer = true;
				flag_question = true;
			}
		}
	</script>
	<script type="text/javascript">
		//保存用户注册信息
		function save() {
			if (form1.user.value == "") { //当用户名为空时
				alert("请输入用户名！");
				form1.user.focus();
				return;
			}
			if (form1.pwd.value == "") { //当密码为空时
				alert("请输入密码！");
				form1.pwd.focus();
				return;
			}
			if (form1.repwd.value == "") { //当没有输入确认密码时
				alert("请确认密码！");
				form1.repwd.focus();
				return;
			}
			if (form1.email.value == "") { //当E-mail地址为空时
				alert("请输入E-mail地址！");
				form1.email.focus();
				return;
			}
			if (flag_user && flag_pwd && flag_repwd && flag_email && flag_question && flag_answer) { //所有数据都符合要求时
				var param = "uname=" + form1.user.value + "&upwd=" + form1.pwd.value + "&email=" + form1.email.value +
					"&question=" +
					form1.question.value + "&answer=" + form1.answer.value; //组合参数
				var loader = new net.AjaxRequest("UserServlet?action=save&nocache=" + new Date().getTime(), deal_save,
					onerror, "POST", param);
			} else {
				alert("您填写的注册信息不合法，请确认！");
			}
		}

		function deal_save() {
			alert(this.req.responseText); //弹出提示信息
			form_reset(form1); //重置表单
			Myclose("register"); //隐藏用户注册页面

		}
		/*************************************************************************************************************/
		function onerror() { //错误处理函数
			alert("出错了");
		}
		//重置表单函数
		function form_reset(form) {
			form.reset(); //重置表单
		}
	</script>

	<div id="register">
			<form action="" method="post" name="form1">
				<table>
					<tr><th colspan="2" align="center">用户注册</th></tr>
					<tr>
						<td align="right"><span id="c">*</span>用户名：</td>
						<td align="left"><input name="user" type="text"  placeholder="请输入用户名" size="35" onBlur="checkUser(this.value)"></td>
					</tr>
					<tr>
						<td align="right"><span id="c">*</span>请设置密码：</td>
						<td align="left"><input name="pwd" type="password" placeholder="请输入密码" size="35" onBlur="checkPwd(this.value)"></td>
					</tr>
					<tr>
						<td align="right"><span id="c">*</span>请确认密码：</td>
						<td align="left"><input name="repwd" type="password" placeholder="请再次输入密码" size="35" onBlur="checkRepwd(this.value)"></tr>
					<tr>
						<td align="right"><span id="c">*</span>E-mail地址：</td>
						<td align="left"><input name="email" type="text" placeholder="请输入E-mail地址" size="35" onBlur="checkEmail(this.value)"></td>
					</tr>
					<tr>
						<td align="right"><span id="c">*</span>密码提示问题：</td>
						<td align="left"><input name="question" type="text" placeholder="请输入密码提示问题" id="question" size="35" 
						onBlur="checkQuestion(this.value,this.form.answer.value)"></td>
					</tr>
					<tr>
						<td align="right"><span id="c">*</span>提示问题答案：</td>
						<td align="left"><input name="answer" placeholder="请输入提示问题答案" type="text" id="answer" size="35" 
						onBlur="checkQuestion(this.form.question.value,this.value)"></td>
					</tr>
					<tr>
						<td colspan="2" align="center">
							<input name="btn_sumbit" type="button" class="btn_grey" value="提交" onClick="save()">
							<input name="btn_reset" type="button" class="btn_grey" value="重置" onClick="form_reset(this.form)">
							<input name="btn_close" type="button" class="btn_grey" value="关闭" onClick="Myclose('register')">
						</td>
					</tr>
				</table>
			</form>
		</div>
</body>

</html>