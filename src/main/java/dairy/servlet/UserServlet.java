package dairy.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dairy.dao.UserDao;
import dairy.model.User;



public class UserServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private UserDao userDao = null; 
    
    public UserServlet() {
        super();
        userDao = new UserDao();
        // TODO Auto-generated constructor stub
    }

    /**
	 * 用户登录
	 * @param request
	 * @param response
	 * @throws ServletException
	 * @throws IOException
	 */
	private void login(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		User u = new User();
		u.setUname(request.getParameter("uname"));
		u.setUpwd(request.getParameter("upwd"));
		int reg = userDao.login(u);
		if (reg > 0) {// 当用户登录成功时
			HttpSession session = request.getSession();// 获取HttpSession的对象
			session.setAttribute("uname", u.getUname());// 保存用户名
			session.setAttribute("uid", reg);// 保存用户ID
			request.setAttribute("returnValue", "登录成功！");// 保存提示信息
			request.getRequestDispatcher("message.jsp").forward(request,
					response);// 重定向页面
		} 
	}
	/**
	 * 用户登出
	 * @param request
	 * @param response
	 * @throws ServletException
	 * @throws IOException
	 */
	private void exit(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession();// 获取HttpSession的对象
		session.invalidate();// 销毁session
		request.getRequestDispatcher("DiaryServlet?action=listAllDiary")
				.forward(request, response);// 重定向页面
	}
	/**
	 * 检测用户名是否占用
	 * @param request
	 * @param response
	 * @throws ServletException
	 * @throws IOException
	 */
	public void checkUser(HttpServletRequest request,HttpServletResponse response) 
			throws ServletException, IOException {
		String username = request.getParameter("uname");		//获取用户名
		String sql = "SELECT * FROM dy_user WHERE uname='" + username + "'";
		String result = userDao.checkUser(sql);		//判断用户是否被注册
		response.setContentType("text/html;charset=UTF-8");	// 设置响应的类型
		PrintWriter out = response.getWriter();		//获取输出流
		out.print(result); 							// 输出结果
		out.close();// 关闭输出流对象
	}
	/**
	 * 保存用户信息
	 * @param request
	 * @param response
	 * @throws ServletException
	 * @throws IOException
	 */
	public void add(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String username = request.getParameter("uname"); // 获取用户名
		String pwd = request.getParameter("upwd"); // 获取密码
		String email = request.getParameter("email"); // 获取E-mail地址
		String question = request.getParameter("question"); // 获取密码提示问题
		String answer = request.getParameter("answer"); // 获取密码提示问题答案
		String sql = "INSERT INTO dy_user (uname,upwd,email,question,answer) VALUE ('"
				+ username+ "','"+ pwd+ "','"+ email+ "','"+ question
				+ "','" + answer + "')";	//定义SQL语句
		String result = userDao.add(sql);// 保存用户信息
		response.setContentType("text/html;charset=UTF-8"); // 设置响应的类型
		PrintWriter out = response.getWriter();		//获取输出流
		out.print(result); // 输出结果
		out.close();// 关闭输出流对象
	}
	/**
	 * 找回密码第一步
	 * @param request
	 * @param response
	 * @throws ServletException
	 * @throws IOException
	 */
	private void findUpwd1(HttpServletRequest request,HttpServletResponse response) 
			throws ServletException, IOException {
		String username = request.getParameter("uname"); // 获取用户名
		String question = userDao.findUpwd_1(username);// 获取密码提示问题
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
		if ("".equals(question)) {// 判断密码提示问题是否为空
			out.println("<script>alert('您没有设置密码提示问题，无法找回密码！');history.back();</script>");
		} else if ("您输入的用户名不存在！".equals(question)) {
			out.println("<script>alert('您输入的用户名不存在！');history.back();</script>");
		} else {// 获取密码提示问题成功
			request.setAttribute("question", question);// 保存密码提示问题
			request.setAttribute("uname", username);// 保存用户名
			request.getRequestDispatcher("findUpwd_2.jsp").forward(request,response);// 重定向页面
		}
	}
	/**
	 * 找回密码第二步
	 * @param request
	 * @param response
	 * @throws ServletException
	 * @throws IOException
	 */
	private void findUpwd2(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		String username = request.getParameter("uname"); // 获取用户名
		String question = request.getParameter("question");// 获取密码提示问题
		String answer = request.getParameter("answer"); // 获取提示问题答案
		String pwd = userDao.findUpwd_2(username, question, answer);// 判断提示问题答案是否正确
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();

		if ("您输入的密码提示问题答案错误！".equals(pwd)) {// 提示问题答案错误
			out.println("<script>alert('您输入的密码提示问题答案错误！');history.back();</script>");
		} else {// 提示问题答案正确，返回密码
			out.println("<script>alert('您的密码是："+ pwd
				+ "');window.location.href='DiaryServlet?action=listAllDiary';</script>");
		}
	}
	protected void doGet(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		String action = request.getParameter("action");
		if ("login".equals(action)) { // 用户登录
			this.login(request, response);
		} else if ("exit".equals(action)) {// 用户退出
			this.exit(request, response);
		} else if ("save".equals(action)) { // 保存用户注册信息
			this.add(request, response);
		} else if ("checkUser".equals(action)) {// 检测用户名是否存在
			this.checkUser(request, response);
		} else if ("findUpwd1".equals(action)) { // 找回密码第一步
			this.findUpwd1(request, response);
		} else if ("findUpwd2".equals(action)) { // 找回密码第二步
			this.findUpwd2(request, response);
		}
	}
	
}
