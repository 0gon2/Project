<%@page import="member.SmemberVO"%>
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
	String index= request.getParameter("index");
	if (index==null){
		index="1";
	}
	String pageNum = request.getParameter("pageNum");
	if (pageNum == null || pageNum == "") {
		pageNum = "1";
	}
%>

<%
	String hakmungu=null;
	int pageSize = 5;
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd hh:mm");
	int currentPage = Integer.parseInt(pageNum);
	int startRow = (currentPage - 1) * pageSize + 1;
	int endRow = currentPage * pageSize;
	int count = 0;
	int number = 0;
	List articleList = null;
	MemberDAO dbPro = MemberDAO.getInstance();
	if(index.equals("1")){
		hakmungu=schemt;
		count=dbPro.getSchoolmateCount("초등학교", schemt, schmid, schhigh);
		if(count>0){
		articleList = dbPro.getSchoolmate(startRow, endRow, schemt, "초등학교");
		}
	}
	if(index.equals("2")){
		hakmungu=schmid;
		count=dbPro.getSchoolmateCount("중학교", schemt, schmid, schhigh);
		if(count>0){
		articleList = dbPro.getSchoolmate(startRow, endRow, schmid, "중학교");
		}
	}
	if(index.equals("3")){
		hakmungu=schhigh;
		count=dbPro.getSchoolmateCount("고등학교", schemt, schmid, schhigh);
		if(count>0){
		articleList = dbPro.getSchoolmate(startRow, endRow, schhigh, "고등학교");
		}
	}
	number = count - (currentPage - 1) * pageSize;
%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<!-- Overlay effect when opening sidebar on small screens -->
<div class="w3-overlay w3-hide-large" onclick="w3_close()" style="cursor:pointer" title="close side menu" id="myOverlay"></div>

<!-- Main content: shift it to the right by 270 pixels when the sidebar is visible -->
<div class="w3-main w3-container" style="margin-left:270px;margin-top:117px;">


<div class="w3-panel w3-padding-large w3-card-4 w3-light-grey">
	

		<span class="w3-center  w3-large">
		</span>
		
		<%
			if (count == 0) {
		%>
		<table class="w3-table-all" >
			<tr class="w3-blue">
				<td align="center">한명도 없을리가...</td>
		</table>
		<%
			} else {
		%>
		
		<p class="w3-large" style="font-style:italic;"><%=hakmungu %> 학생명단</p>
		<table width="100%" bordercolor="w3-blue" style="border-collapse:collapse;">
			<tr height="30" class="w3-blue" align="center" >
				<td align="center" width="6%">번호</td>
				<td align="center" width="16%" >이름</td>
				<td align="center" width="11%">생년월일</td>
				<td align="center" width="24%">가입일자</td>
			</tr>
			<%
				String name= (String)session.getAttribute("name");
				for (int i = 0; i < articleList.size(); i++) {
						SmemberVO article = (SmemberVO) articleList.get(i);
						String gname=article.getName();
			%>
			<tr height="30" align="center" >
			
			
		
				<td align="center" width="6%"><%=number--%></td>
				<td class="w3-dropdown-hover " align="center" style=" width:100%;">
				<%=article.getName()%>
				
				 <%if(!gname.equals(name)){
				 %>
				 
					<div class="w3-dropdown-content w3-bar-block w3-card-4" style="right:10px">
<a href="/Project/mainPage/main.jsp?pageId=<%=article.getMemberid() %>&scname=<%=article.getName() %>&schemt=<%=article.getSch_emt() %>&schmid=<%=article.getSch_mid()%>&schhigh=<%=article.getSch_high() %>" class="w3-bar-item w3-button">'<%=article.getName()%>'님 페이지</a>
<a href="#" class="w3-bar-item w3-button">친구추가</a>
<a href="#" class="w3-bar-item w3-button">쪽지보내기</a>
                    </div></td>
				 
				 <%
				 	 }
				 %>
				<td align="center" width="11%"><%=article.getBirthday()%></td>
				<td align="center" width="24%"><%=sdf.format(article.getJoindate())%></td>
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
			<a href="schoolmateList.jsp?pageNum=<%=startPage - bottomLine%>&index=<%=index%>">[이전]</a>
			<%
					}
			%>
			<%
				for (int i = startPage; i <= endPage; i++) {
			%>
			<a href="schoolmateList.jsp?pageNum=<%=i%>&index=<%=index%>"> <%
 				if (i != currentPage)
 				out.print("[" + i + "]");
 				else
 				out.print("<font color='red'>[" + i + "]</font>");
 			%></a>
			<%
				}
					if (endPage < pageCount) {
			%>
			<a href="schoolmateList.jsp?pageNum=<%=startPage + bottomLine%>&index=<%=index%>">[다음]</a>
			<%
					}
				}
			%>
		</div>
		<div class="w3-right">
		  <form action="">
     		 <input type="text" placeholder="Friend name" name="search">
     		 <button type="submit"><i class="fa fa-search" style="font-size:20px"></i></button>
   		 </form>
		</div>	
</div>


<!-- END MAIN -->
</div>

<script>
// Script to open and close the sidebar
function w3_open() {
    document.getElementById("mySidebar").style.display = "block";
    document.getElementById("myOverlay").style.display = "block";
}
 
function w3_close() {
    document.getElementById("mySidebar").style.display = "none";
    document.getElementById("myOverlay").style.display = "none";
}
function w3_show_nav(name) {
    document.getElementById("menuTut").style.display = "none";
    document.getElementById("menuRef").style.display = "none";
    document.getElementById(name).style.display = "block";
    w3-open();
}
</script>
<script src="https://www.w3schools.com/lib/w3codecolor.js"></script>
<script>
w3CodeColor();
</script>

</body>
</html>