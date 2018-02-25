<%@page import="school.SchoolVO"%>
<%@page import="java.util.List"%>
<%@page import="school.SchoolDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

 <%
 String esname=request.getParameter("esname");
 String msname=request.getParameter("msname");
 String hsname=request.getParameter("hsname");
 String index= request.getParameter("index");
 SchoolDAO schoolDB= SchoolDAO.getInstance();
 List List=null;
 %>
</head>
<body>
 <% 
 if(index.equals("1")){
 List=schoolDB.getSchools(esname,"초등학교");
		 if(esname!=null){ %>
		 <table class="w3-table-all">
		   <thead>
		     <tr class="w3-blue">
		       <th>School Name</th>
		       <th>Address</th>
		       <th>blank</th>
		     </tr>
		   </thead>
		     <%
		     for(int i=0;i<List.size();i++){
		   	SchoolVO school=(SchoolVO)List.get(i);
		   	esname=school.getSname();
		   	%>
				    <tr>
				      <td><a href="/Project/mainPage/updateForm.jsp?esname=<%=esname%>&msname=<%=msname%>&hsname=<%=hsname%>"><%=esname %></a></td>
				      <td><%=school.getSaddress() %></td>
				      <td></td>
				    </tr>
		   <%
		   }
		 %>  
		 </table>
	<%
   }
 }
 if(index.equals("2")){
 List=schoolDB.getSchools(msname,"중학교");
		 if(msname!=null){ %>
		 <table class="w3-table-all">
		   <thead>
		     <tr class="w3-blue">
		       <th>School Name</th>
		       <th>Address</th>
		       <th>blank</th>
		     </tr>
		   </thead>
		     <%
		     for(int i=0;i<List.size();i++){
		   	SchoolVO school=(SchoolVO)List.get(i);
		   	msname=school.getSname();
		   	%>
				    <tr>
				      <td><a href="/Project/mainPage/updateForm.jsp?esname=<%=esname%>&msname=<%=msname%>&hsname=<%=hsname%>"><%=msname %></a></td>
				      <td><%=school.getSaddress() %></td>
				      <td></td>
				    </tr>
		   <%
		   }
		 %>  
		 </table>
		<%
		}
 }
 if(index.equals("3")){
 List=schoolDB.getSchools(hsname,"고등학교");
		 if(hsname!=null){ %>
		 <table class="w3-table-all">
		   <thead>
		     <tr class="w3-blue">
		       <th>School Name</th>
		       <th>Address</th>
		       <th>blank</th>
		     </tr>
		   </thead>
		     <%
		     for(int i=0;i<List.size();i++){
		   	SchoolVO school=(SchoolVO)List.get(i);
		   	hsname=school.getSname();
		   	%>
				    <tr>
				      <td><a href="/Project/mainPage/updateForm.jsp?esname=<%=esname%>&msname=<%=msname%>&hsname=<%=hsname%>"><%=hsname %></a></td>
				      <td><%=school.getSaddress() %></td>
				      <td></td>
				    </tr>
		   <%
		   }
		 %>  
		 </table>
		<%
		}
 }
 
 %>
</body>
</html>