package servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import user.MemberDAO;
import user.User;

@WebServlet("/Join")
public class Join extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html; charset=UTF-8");
		request.setCharacterEncoding("UTF-8");
		String id = request.getParameter("id");
		MemberDAO dao = new MemberDAO();
		PrintWriter out = response.getWriter();
		try {
			int check = dao.idcheck(id);
			System.out.println(check);
			out.println(check);
			out.flush();
//			request.setAttribute("check", check);
//			request.getRequestDispatcher("/join.jsp").forward(request, response);
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType("text/html; charset=UTF-8");
		request.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		String id = request.getParameter("id");
		String password = request.getParameter("password");
		String pwconfirm = request.getParameter("pwconfirm");
		String name = request.getParameter("name");
		int age = Integer.valueOf(request.getParameter("age"));
		String address = request.getParameter("address");
		String detailed_Address = request.getParameter("detailed_Address");
		MemberDAO dao = new MemberDAO();
		if(id.equals(id)){
			out.println("<script>");
			out.println("alert('중복된 아이디입니다.')");
			out.println("history.back()");
			out.println("</script>");
		}
		
		if (password.equals(pwconfirm)) {
			try {
				dao.join(new User(id, password, name, age, address, detailed_Address));
				out.println("<script>");
				out.println("alert('가입완료')");
				out.println("location.href = 'login.jsp'");
				out.println("</script>");
				request.getRequestDispatcher("/login.jsp").forward(request, response);
			} catch (SQLException e) {
				e.printStackTrace();
			}
		} else {
			out.println("<script>");
			out.println("alert('정보가 잘못되었습니다.')");
			out.println("history.back()");
			out.println("</script>");
		}
		out.flush();
	}
}
