package servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import board.Board;
import board.BoardDAO;

@WebServlet("/BorderServlet")
public class BorderServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		int idx = Integer.valueOf(request.getParameter("idx"));
		BoardDAO dao = BoardDAO.getInstance();
		try {
			Board board = dao.seleteOne(idx);
			request.setAttribute("board", board);
			request.setAttribute("idx", idx);
			request.getRequestDispatcher("/view.jsp").forward(request, response);
		} catch (SQLException e) {
			e.printStackTrace();
		}
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
		BoardDAO dao = BoardDAO.getInstance();
		if (title.length() == 0 || content.length() == 0) {
			out.println("<script>");
			out.println("alert('제목 또는 내용을 입력해주세요')");
			out.println("location.href = '/writing.jsp';");
			out.println("</script>");
			out.flush();
		} else {
			try {
				dao.writing(new Board(title, content, writer, time));
				out.println("<script>");
				out.println("location.href = '/BBS';");
				out.println("</script>");
				out.flush();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}

	}
}
