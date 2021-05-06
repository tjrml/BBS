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

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		HttpSession session = request.getSession(true);
		PrintWriter pw = response.getWriter();
		String title = request.getParameter("title");
		String content = request.getParameter("contents");
		String writer = (String) session.getAttribute("id");
		Timestamp time = new Timestamp(System.currentTimeMillis());
		BorderDAO dao = new BorderDAO();
		if (session.getAttribute("id") != null) {
			try {
				dao.writing(new Border(title, content, writer, time));
				pw.println("<script>");
				pw.println("location.href = 'index.jsp';");
				pw.println("</script>");
			} catch (SQLException e) {
				e.printStackTrace();
			}
		} else {
			pw.println("<script>");
			pw.println("alert('로그인을 해주세요')");
			pw.println("location.href = 'login.jsp';");
			pw.println("</script>");
		}
	}

	
	protected void doPut(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
	}


	protected void doDelete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

}
