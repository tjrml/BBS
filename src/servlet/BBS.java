package servlet;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import board.Board;
import board.BoardDAO;
import board.Paging;

@WebServlet("/BBS")
public class BBS extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// 페이징 처리
		BoardDAO dao = BoardDAO.getInstance();
		int totalCount;
		List<Board> list = new ArrayList<Board>();
		try {
			totalCount = dao.totalCount();
			String key = request.getParameter("selectbox");
			String value = request.getParameter("search_content");
			int paramPage = request.getParameter("page") == null ? 1 : Integer.parseInt(request.getParameter("page"));
			Paging paging = new Paging(); // get방식의 parameter값으로 반은 page변수, 현재 페이지 번호
			paging.setPageNo(paramPage); // 한페이지에 불러낼 게시물의 개수 지정
			paging.setPageSize(10);
			paging.setTotalCount(totalCount);

			int numPerPage = (paramPage - 1) * 10; // (1 -> 0) (2 -> 10) (3 -> 20) 페이지당 불러낼 게시물 수
			int startPage = paging.getStartPageNo();
			int endPage = paging.getEndPageNo();
			int prevPage = paging.getPrevPageNo();
			int nextPage = paging.getNextPageNo();
			int totalPage = (int) Math.ceil((double) totalCount / paging.getPageSize()); // 전체페이지
			
			if (key == null && value == null) {
				list = dao.boardPrint(numPerPage, paging.getPageSize());
				System.out.println(list.size());
			} else {
				list = dao.search(key, value, numPerPage, paging.getPageSize());
				System.out.println(list.size());
			}
			System.out.println(key);
			System.out.println(value);
			request.setAttribute("list", list);
			request.setAttribute("paramPage", paramPage);
			request.setAttribute("startPage", startPage);
			request.setAttribute("endPage", endPage);
			request.setAttribute("prevPage", prevPage);
			request.setAttribute("nextPage", nextPage);
			request.setAttribute("totalPage", totalPage);
//			request.setAttribute("key", key);
			request.setAttribute("value", value);
			
			request.getRequestDispatcher("/bbs.jsp").forward(request, response);
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
}
