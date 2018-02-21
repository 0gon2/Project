<%@page import="member.MemberVO"%>
<%@page import="member.MemberDAO"%>
<%@page import="java.util.List"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<%
	int pageSize = 5;
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	String pageNum = request.getParameter("pageNum");
	if (pageNum == null || pageNum == "") {
		pageNum = "1";
	}
	int currentPage = Integer.parseInt(pageNum);
	int startRow = (currentPage - 1) * pageSize + 1;
	int endRow = currentPage * pageSize;
	int count = 0;
	int number = 0;
	List articleList = null;
	MemberDAO dbPro = MemberDAO.getInstance();
	count = dbPro.getMemberCount();
	if (count > 0) {
		articleList = dbPro.getAllmember(startRow, endRow);
	}
	number = count - (currentPage - 1) * pageSize;
%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

<p class="w3-left" style="padding-left: 30px;"></p>
	<div class="w3-container">
		<span class="w3-center  w3-large">
			<h3>(전체 회원수:<%=count%>)</h3>
		</span>
		<p class="w3-right w3-padding-right-large">
			<a href="writeForm.jsp">글쓰기</a>
		</p>
		
		
		<%
			if (count == 0) {
		%>
		<table class="table-bordered" width="700">
			<tr class="w3-grey">
				<td align="center">게시판에 저장된 글이 없습니다.</td>
		</table>
		<%
			} else {
		%>
		
		
		<table class="w3-table-all" width="525">
			<tr class="w3-grey">
				<td align="center" width="50">번호</td>
				<td align="center" width="100">아이디</td>
				<td align="center" width="100">비밀번호</td>
				<td align="center" width="100">이름</td>
				<td align="center" width="75">생년월일</td>
				<td align="center" width="100">가입일자</td>
			</tr>
			<%
				for (int i = 0; i < articleList.size(); i++) {
						MemberVO article = (MemberVO) articleList.get(i);
			%>
			<tr height="30">
				<td align="center" width="50"><%=number--%></td>
				<td width="100"><%=article.getMemberid()%></td>
				<td align="center" width="100"><%=article.getPassword()%></td>
				<td align="center" width="100"><%=article.getName()%></td>
				<td align="center" width="75"><%=article.getBirthday()%></td>
				<td align="center" width="100"><%=sdf.format(article.getJoindate())%></td>
			</tr>
			<%
				}
			%>
		</table>
		
		
		<%
			}
		%>


		<div class="w3-center">
			<%
				int bottomLine = 3;
				if (count > 0) {
					int pageCount = count / pageSize + (count % pageSize == 0 ? 0 : 1);
					int startPage = 1 + (currentPage - 1) / bottomLine * bottomLine;
					int endPage = startPage + bottomLine - 1;
					if (endPage > pageCount)
						endPage = pageCount;
					if (startPage > bottomLine) {
			%>
			<a href="list.jsp?pageNum=<%=startPage - bottomLine%>">[이전]</a>
			<%
					}
			%>
			<%
				for (int i = startPage; i <= endPage; i++) {
			%>
			<a href="list.jsp?pageNum=<%=i%>"> <%
 				if (i != currentPage)
 				out.print("[" + i + "]");
 				else
 				out.print("<font color='red'>[" + i + "]</font>");
 			%></a>
			<%
				}
					if (endPage < pageCount) {
			%>
			<a href="list.jsp?pageNum=<%=startPage + bottomLine%>">[다음]</a>
			<%
					}
				}
			%>
		</div>
	</div>




</body>
</html>