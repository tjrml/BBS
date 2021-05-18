<%@page import="board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
	String idx = request.getParameter("idx");
	String writer = request.getParameter("writer");
	BoardDAO dao = BoardDAO.getInstance();
	String id = (String) session.getAttribute("id");
	if (session.getAttribute("id") == null) {
		out.println("<script>");
		out.println("alert('로그인 해주세요.')");
		out.println("location.href = 'login.jsp';");
		out.println("</script>");
	} else if (id.equals(writer)) {
		dao.delete(Integer.valueOf(idx));
		out.println("<script>");
		out.println("alert('삭제되었습니다.')");
		out.println("location.href='/index.jsp'");
		out.println("</script>");
	} else {
		out.println("<script>");
		out.println("alert('작성자가 아닙니다.')");
		out.println("history.back()");
		out.println("</script>");
	}
%>
