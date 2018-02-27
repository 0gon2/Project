<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>



	<jsp:useBean id="article" class="member.MemberVO" />
	<jsp:setProperty property="*" name="article" />

	<%
		// System.out.println(article);
	%>
	<%
		MemberDAO dbPro = MemberDAO.getInstance();
		int updateCount = dbPro.updateArticle(article);
		
		String aaa= article.getSch_emt();
		String bbb= article.getSch_mid();
		String ccc= article.getSch_high();
		if (updateCount == 1) {
			  session.setAttribute("schemt", aaa);	
			  session.setAttribute("schmid", bbb);	
			  session.setAttribute("schhigh", ccc);
			
	%>
	<script>
		alert("수정 완료");
	</script>
	<meta http-equiv="Refresh" content="0;url=main.jsp">

	<%
		} else {
	%>

	<script>
		alert("뭔가 잘못된거라네, 친구");
		history.go(-1);
	</script>

	<%
		}
	%>






</body>
</html>