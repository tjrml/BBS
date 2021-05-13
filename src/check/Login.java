package check;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import user.MemberDAO;

@WebServlet("/Login")
public class Login extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType("text/html; charset=UTF-8"); // 한글로변환
		String id = request.getParameter("id");
		String password = request.getParameter("password");
		PrintWriter out = response.getWriter();
		HttpSession session = request.getSession(true); // 세션생성
		MemberDAO dao = new MemberDAO();
		boolean check = false;
		try {
			check = dao.login(id, password);
			if (check) {
				session.setAttribute("id", id);
				out.println("<script>");
				out.println("location.href='/index.jsp'"); 
				out.println("</script>");
				out.flush();
			} else {
				out.println("<script>");
				out.println("alert('아이디 또는 비밀번호가 잘못되었습니다.')");
				out.println("location.href='/login.jsp'");
				out.println("</script>");
				out.flush();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
}
