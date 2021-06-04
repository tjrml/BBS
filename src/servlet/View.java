package servlet;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import board.Board;
import board.BoardDAO;

@WebServlet("/View")
public class View extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		int idx = Integer.valueOf(request.getParameter("idx"));
		int hit = Integer.valueOf(request.getParameter("hit"));
		BoardDAO dao = BoardDAO.getInstance();
		try {
			Board board = dao.seleteOne(idx);
			hit++;
			dao.hitUP(idx, hit);
			request.setAttribute("board", board);
			request.setAttribute("idx", idx);
			request.setAttribute("hit", hit);
			request.getRequestDispatcher("/view.jsp").forward(request, response);
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
}
