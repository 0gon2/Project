<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<script >
		
		<%
				String pageNum= request.getParameter("pageNum");
				String memberid= request.getParameter("memberid");
		%>
		var input = confirm('퇴학 시키겠습니까?');
		var pageNu=<%=pageNum%>;
		if(input==true){
			alert('완료');
			<%
				MemberDAO dbPro = MemberDAO.getInstance();
				dbPro.deleteArticle(memberid);
			%>
			
			location.href="/Project/mainPage/admin.jsp?pageNum="+pageNu;
		}

</script>
</body>
</html>