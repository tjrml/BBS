package servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import board.BoardDAO;

@WebServlet("/Delete")
public class Delete extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html; charset=UTF-8");
		HttpSession session = request.getSession(true);
		String idx = request.getParameter("idx");
		String writer = request.getParameter("writer");
		BoardDAO dao = BoardDAO.getInstance();
		String id = (String) session.getAttribute("id");
		PrintWriter out = response.getWriter();
		if (session.getAttribute("id") == null) {
			out.println("<script>");
			out.println("alert('로그인 해주세요.')");
			out.println("location.href = 'login.jsp';");
			out.println("</script>");
		} else if (id.equals(writer)) {
			dao.delete(Integer.valueOf(idx));
			out.println("<script>");
			out.println("alert('삭제되었습니다.')");
			out.println("location.href='/BBS'");
			out.println("</script>");
		} else {
			out.println("<script>");
			out.println("alert('작성자가 아닙니다.')");
			out.println("history.back()");
			out.println("</script>");
		}
	}

}
