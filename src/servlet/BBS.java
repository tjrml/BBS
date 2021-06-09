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
	int numPerPage;
	int startPage = 0;
	int endPage = 0;
	int prevPage = 0;
	int nextPage = 0;
	int totalPage = 0;
	
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// 페이징 처리
		BoardDAO dao = BoardDAO.getInstance();
		int totalCount;
		int titleCount;
		int writerCount;
		
		List<Board> list = new ArrayList<Board>();
		try {
			String key = request.getParameter("selectbox");
			String value = request.getParameter("search_content");
			int paramPage = request.getParameter("page") == null ? 1 : Integer.parseInt(request.getParameter("page"));
			Paging paging = new Paging(); // get방식의 parameter값으로 반은 page변수, 현재 페이지 번호
			paging.setPageNo(paramPage); // 한페이지에 불러낼 게시물의 개수 지정
			paging.setPageSize(10);
			if ((key == null || key.equals("")) && (value == null || value.equals(""))) {
				totalCount = dao.totalCount();
				count(totalCount, paramPage);
				list = dao.boardPrint(numPerPage, paging.getPageSize());
				System.out.println(totalCount);
			} else if (key.equals("title")) {
				titleCount = dao.titleCount(key, value);
				count(titleCount, paramPage);
				list = dao.titleSearch(key, value, numPerPage, paging.getPageSize());
				System.out.println(titleCount);
			} else if (key.equals("writer")) {
				writerCount = dao.writerCount(key, value);
				paging.setTotalCount(writerCount);
				count(writerCount, paramPage);
				list = dao.writerSearch(key, value, numPerPage, paging.getPageSize());
				System.out.println(writerCount);
			}
//			System.out.println(key);
//			System.out.println(value);
			request.setAttribute("list", list);
			request.setAttribute("paramPage", paramPage);
			request.setAttribute("startPage", startPage);
			request.setAttribute("endPage", endPage);
			request.setAttribute("prevPage", prevPage);
			request.setAttribute("nextPage", nextPage);
			request.setAttribute("totalPage", totalPage);
			request.setAttribute("key", key);
			request.setAttribute("value", value);
			
			request.getRequestDispatcher("/bbs.jsp").forward(request, response);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
	}
	private void count(int count, int paramPage) {
		Paging paging = new Paging();
		paging.setTotalCount(count);
		numPerPage = (paramPage - 1) * 10; // (1 -> 0) (2 -> 10) (3 -> 20) 페이지당 불러낼 게시물 수
		startPage = paging.getStartPageNo();
		endPage = paging.getEndPageNo();
		prevPage = paging.getPrevPageNo();
		nextPage = paging.getNextPageNo();
		totalPage = (int) Math.ceil((double) count / paging.getPageSize()); // 전체페이지
	}
}
