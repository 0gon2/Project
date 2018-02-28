<%@page import="member.relationVO"%>
<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<%
	String myId = request.getParameter("myId");
	String pageId=request.getParameter("pageId");
%>
</head>
<body>
	<%
	
		relationVO requestFriend = new relationVO();
	requestFriend.setMyId(myId);
	requestFriend.setOtherId(pageId);
		
		MemberDAO dbPro = MemberDAO.getInstance();
		dbPro.requestFriend(requestFriend);
		//response.sendRedirect("/Project/mainPage/main.jsp");%>
	
		
	<%-- 	"/Project/mainPage/main.jsp?pageId=<%=Memberid() %>
		&scname=<%=article.getName() %>
		&schemt=<%=article.getSch_emt() %>
		&schmid=<%=article.getSch_mid()%>&schhigh=<%=article.getSch_high() %>"
		
	 --%>	
	
</body>
</html>