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
	
	int pageSize = 10;
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd hh:mm");
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
		<span class="w3-center  w3-large">
  <h4 class="w3-opacity"><i class="fa fa-male"></i>&nbsp;(총 회원수:<%=count%>)</h4>
		</span>
		
		<%
			if (count == 0) {
		%>
		<table class="w3-table-all" >
			<tr class="w3-blue">
				<td align="center">회원이 없을리가...</td>
		</table>
		<%
			} else {
		%>
		
		
		<table width="100%" border="1" bordercolor="w3-blue" style="border-collapse:collapse;">
			<tr height="30" class="w3-blue" align="center" >
				<td align="center" width="6%">번호</td>
				<td align="center" width="16%" >이름</td>
				<td align="center" width="11%">생년월일</td>
				<td align="center" width="18%" >아이디</td>
				<td align="center" width="18%" >비밀번호</td>
				<td align="center" width="24%">가입일자</td>
				<td align="center" width="7%" >퇴학</td>
			</tr>
			<%
				for (int i = 0; i < articleList.size(); i++) {
						MemberVO article = (MemberVO) articleList.get(i);
			%>
			<tr height="30" align="center" >
				<td align="center" width="6%"><%=number--%></td>
				<td align="center" width="16%"><%=article.getName()%></td>
				<td align="center" width="11%"><%=article.getBirthday()%></td>
				<td align="center" width="18%"><%=article.getMemberid()%></td>
				<td align="center" width="18%"><%=article.getPassword()%></td>
				<td align="center" width="24%"><%=sdf.format(article.getJoindate())%></td>
				<td align="center" width="7%" ><a href="/Project/List/leavePro.jsp?pageNum=<%=pageNum %>&memberid=<%=article.getMemberid()%>" ><i class="fa fa-trash"></i></a></td>
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
				int bottomLine = 5;
				if (count > 0) {
					int pageCount = count / pageSize + (count % pageSize == 0 ? 0 : 1);
					int startPage = 1 + (currentPage - 1) / bottomLine * bottomLine;
					int endPage = startPage + bottomLine - 1;
					if (endPage > pageCount)
						endPage = pageCount;
					if (startPage > bottomLine) {
			%>
			<a href="admin.jsp?pageNum=<%=startPage - bottomLine%>">[이전]</a>
			<%
					}
			%>
			<%
				for (int i = startPage; i <= endPage; i++) {
			%>
			<a href="admin.jsp?pageNum=<%=i%>"> <%
 				if (i != currentPage)
 				out.print("[" + i + "]");
 				else
 				out.print("<font color='red'>[" + i + "]</font>");
 			%></a>
			<%
				}
					if (endPage < pageCount) {
			%>
			<a href="admin.jsp?pageNum=<%=startPage + bottomLine%>">[다음]</a>
			<%
					}
				}
			%>
		</div>


</body>
</html>