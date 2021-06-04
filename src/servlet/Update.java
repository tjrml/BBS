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

@WebServlet("/Update")
public class Update extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html; charset=UTF-8");
		HttpSession session = request.getSession(true);
		int idx = Integer.valueOf(request.getParameter("idx"));
		PrintWriter out = response.getWriter();
		String title = request.getParameter("title");
		String content = request.getParameter("content");
		String writer = request.getParameter("writer");
		String id = (String) session.getAttribute("id");
	 	if (session.getAttribute("id") == null) {
			out.println("<script>");
			out.println("alert('로그인 해주세요.')");
			out.println("location.href = 'login.jsp'");
			out.println("</script>");
		} else if (!id.equals(writer)) {
			out.println("<script>");
			out.println("alert('작성자가 아닙니다.')");
			out.println("history.back()");
			out.println("</script>");
		} else {
			request.setAttribute("title", title);
			request.setAttribute("content", content);
			request.setAttribute("idx", idx);
			request.getRequestDispatcher("/update.jsp").forward(request, response);
		}
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html; charset=UTF-8");
		int idx = Integer.valueOf(request.getParameter("idx"));
		System.out.println(idx);
		PrintWriter out = response.getWriter();
		String title = request.getParameter("title");
		String contents = request.getParameter("contents");
		BoardDAO dao = BoardDAO.getInstance();
		if (title.length() == 0 || contents.length() == 0) {
			out.println("<script>");
			out.println("alert('제목 또는 내용을 입력해주세요')");
			out.println("history.back()");
			out.println("</script>");
		} else {
			dao.update(title, contents, idx);
			out.println("<script>");
			out.println("alert('수정되었습니다.')");
			out.println("location.href ='/View?idx=" + idx +"'");
			out.println("</script>");
		}
		out.flush();
	
	}

}
