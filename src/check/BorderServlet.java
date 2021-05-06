package check;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.sql.Timestamp;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import border.Border;
import border.BorderDAO;

@WebServlet("/BorderServlet")
public class BorderServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		HttpSession session = request.getSession(true);
		PrintWriter out = response.getWriter();
		String title = request.getParameter("title");
		String content = request.getParameter("contents");
		String writer = (String) session.getAttribute("id");
		Timestamp time = new Timestamp(System.currentTimeMillis());
		BorderDAO dao = new BorderDAO();
		if (title.length() == 0 || content.length() == 0) {
			out.println("<script>");
			out.println("alert('제목 또는 내용을 입력해주세요')");
			out.println("location.href = 'writing.jsp';");
			out.println("</script>");
		} else {
			try {
				dao.writing(new Border(title, content, writer, time));
				out.println("<script>");
				out.println("location.href = 'index.jsp';");
				out.println("</script>");
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}

	}

	@Override
	protected void doPut(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

	}

	@Override
	protected void doDelete(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		int idx = Integer.valueOf(request.getParameter("idx"));
		String writer = request.getParameter("writer");
		BorderDAO dao = new BorderDAO();
		HttpSession session = request.getSession(true);
		String id = (String) session.getAttribute("id");
		PrintWriter out = response.getWriter();
		if (id.equals(writer)) {
			dao.delete(idx);
			out.println("<script>");
			out.println("alert('삭제되었습니다.')");
			out.println("location.href='index.jsp'");
			out.println("</script>");
		} else {
			out.println("<script>");
			out.println("alert('작성자가 아닙니다.')");
			out.println("history.back()");
			out.println("</script>");
		}
	}
}
