<%@page import="member.MemberVO"%>
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
<%
	String id=request.getParameter("memberid");
	String pass=request.getParameter("password");
	String pages=request.getParameter("page");
	MemberDAO dbPro = MemberDAO.getInstance();
	
	//로그인
	int pwcheck = dbPro.login(id, pass);
%>
<%	if(pwcheck == -1){ %>
	<script>
      alert("ID가 존재하지 않습니다!");
      history.back();
    </script>
<%
   }
   else if(pwcheck == 0)
   {
%>
     <script>
      alert("비밀번호가 틀립니다!");
      history.back();
     </script>
<%
   }
   else
   {
	  MemberVO mVO=dbPro.getUserInfo(id);
		String name=mVO.getName();
		String schemt=mVO.getSch_emt();
		String schmid=mVO.getSch_mid();
		String schhigh=mVO.getSch_high();
		int birthday=mVO.getBirthday();
	  session.setAttribute("name", name);	
	  session.setAttribute("schemt", schemt);	
	  session.setAttribute("schmid", schmid);	
	  session.setAttribute("schhigh", schhigh);	
	  session.setAttribute("birthday", birthday);	
	  session.setAttribute("id",id);
	  session.setAttribute("password",pass);
	  response.sendRedirect("/Project/mainPage/main.jsp");
   }
%>
</body>
</html>