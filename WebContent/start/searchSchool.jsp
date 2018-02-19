<%@page import="school.SchoolVO"%>
<%@page import="java.util.List"%>
<%@page import="school.SchoolDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<style>
body {
    font-family: Arial;
}


form.example input[type=text] {
    padding: 6px;
    font-size: 17px;
    border: 1px solid grey;
    float: left;
    width: 80%;
    background: #f1f1f1;
}

form.example button {
    float: left;
    width: 20%;
    padding: 10px;
    background: #2196F3;
    color: white;
    font-size: 17px;
    border: 1px solid grey;
    border-left: none;
    cursor: pointer;
}

form.example button:hover {
    background: #0b7dda;
}

form.example::after {
    content: "";
    clear: both;
    display: table;
}
</style>
</head>
<body>
<%
	request.setCharacterEncoding("UTF-8");
	String esname=null;
	esname=request.getParameter("esname");
	String msname=null;
	msname=request.getParameter("msname");
	String hsname=null;
	hsname=request.getParameter("hsname");
	String index=request.getParameter("index");

%>
 <%
SchoolDAO schoolDB= SchoolDAO.getInstance();
 List List=null;
 
/*초등학교  */ 
if(index.equals("1")){
 List=schoolDB.getSchools(esname,"초등학교"); 
 %>
 
<h2>Search School</h2>

<p>Enter your School name:</p>
<form class="example" action="" style="margin:auto;max-width:300px">
  <input type="text" placeholder="Search.." name="esname">
  <input type="hidden" name="index" value=<%=index %>>
  <button type="submit"><i class="fa fa-search"></i></button>
</form>

 <% if(esname!=null){ %>
<div class="w3-container">
  <h2>School List</h2>

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
		      <td><a href="signup.jsp?esname=<%=esname%>
		      &msname=<%=msname%>&hsname=<%=hsname%>"><%=esname %></a></td>
		      <td><%=school.getSaddress() %></td>
		      <td></td>
		    </tr>
    <%
    }
  %>  
  </table>
</div>
	<%
    }
  %>
 
 
 <% 
 
}

/*중학교  */
if(index.equals("2")){
 List=schoolDB.getSchools(msname,"중학교");
 %>
 <h2>Search School</h2>


 <p>Enter your School name:</p>
 <form class="example" action="" style="margin:auto;max-width:300px">
   <input type="text" placeholder="Search.." name="msname">
   <input type="hidden" name="index" value=<%=index %>>
   <button type="submit"><i class="fa fa-search"></i></button>
 </form>

  <% if(msname!=null){ %>
 <div class="w3-container">
   <h2>School List</h2>

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
 		       <td><a href="signup.jsp?esname=<%=esname%>
		      &msname=<%=msname%>&hsname=<%=hsname%>"><%=msname %></a></td>
 		      <td><%=school.getSaddress() %></td>
 		      <td></td>
 		    </tr>
     <%
     }
   %>  
   </table>
 </div>
 	<%
     }
   %>
  <% 
}

/*고등학교  */
if(index.equals("3")){
 List=schoolDB.getSchools(hsname,"고등학교");
 %>
 
 <h2>Search School</h2>


 <p>Enter your School name:</p>
 <form class="example" action="" style="margin:auto;max-width:300px">
   <input type="text" placeholder="Search.." name="hsname">
   <input type="hidden" name="index" value=<%=index %>>
   <button type="submit"><i class="fa fa-search"></i></button>
 </form>

  <% if(hsname!=null){ %>
 <div class="w3-container">
   <h2>School List</h2>

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
 		       <td><a href="signup.jsp?esname=<%=esname%>
		      &msname=<%=msname%>&hsname=<%=hsname%>"><%=hsname %></a></td>
 		      <td><%=school.getSaddress() %></td>
 		      <td></td>
 		    </tr>
     <%
     }
   %>  
   </table>
 </div>
 	<%
     }
   %>
  <% 
}
%>








<!-- 검색 초기 화면 -->
 <% if(List!=null&&esname==null&&msname==null&&hsname==null){ %>
<div class="w3-container">
  <h2>Search result</h2>

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
    	%>
		    <tr>
		      <td><%=school.getSname() %></td>
		      <td><%=school.getSaddress() %></td>
		      <td></td>
		    </tr>
    <%
    }
  %>  
  </table>
</div>
	<%
    }
  %>
 
 



</body>
</html> 