<%@page import="user.User"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="user.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<%
	String id = request.getParameter("id");
	String password = request.getParameter("password");
	String pwconfirm = request.getParameter("pwconfirm");
	String name = request.getParameter("name");
	int age = Integer.valueOf(request.getParameter("age"));
		MemberDAO dao = new MemberDAO();
		//dao.join(new User(id, password, name, age));
%>
<script>
	alert("가입완료")
	location.href = '/login.jsp';
</script>
