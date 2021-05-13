<%@page import="java.sql.Timestamp"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="board.Board"%>
<%@page import="board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	PrintWriter pw = response.getWriter();
	String title = request.getParameter("title");
	String content = request.getParameter("contents");
	String writer = (String) session.getAttribute("id");
	Timestamp time = new Timestamp(System.currentTimeMillis());
	BoardDAO dao = new BoardDAO();
	if (session.getAttribute("id") != null) {
		dao.writing(new Board(title, content, writer, time));
		pw.println("<script>");
		pw.println("location.href = 'index.jsp';");
		pw.println("</script>");
		pw.flush();
	} else {
		pw.println("<script>");
		pw.println("alert('로그인을 해주세요')");
		pw.println("location.href = 'login.jsp';");
		pw.println("</script>");
		pw.flush();
	}
%>

	
