<%@page import="school.SchoolDAO"%>
<%@page import="java.util.List"%>
<%@page import="school.SchoolVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
 <%
 String esname=request.getParameter("esname");
 SchoolDAO schoolDB= SchoolDAO.getInstance();
 List List=null;
 List=schoolDB.getSchools(esname,"초등학교"); 
 %>
<body>





<div id="id02" class="w3-modal">
    <div class="w3-modal-content w3-card-4 w3-animate-zoom" style="max-width:600px">
  
      <div class="w3-center"><br>
        <span onclick="document.getElementById('id02').style.display='none'" class="w3-button w3-xlarge w3-transparent w3-display-topright" title="Close Modal">×</span>
      </div>
<form class="w3-container" action="">
        <div class="w3-section">
          <label><b>학교검색</b></label>
          <input class="w3-input w3-border w3-margin-bottom" type="text" placeholder="Enter Username" name="esname" required>
          <input type="hidden" value="<%=esname %>" >
          <input type="button" onclick="window.location.reload()" value="찾기">
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
		      <td><a href=""><%=esname %></a></td>
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
       
        </div>
      </form>
      <div class="w3-container w3-border-top w3-padding-16 w3-light-grey">
        <button onclick="document.getElementById('id02').style.display='none'" type="button" class="w3-button w3-red w3-right">Cancel</button>
        <span class="w3-right w3-padding w3-hide-small">Forgot <a href="#">password?</a></span>
      </div>

    </div>
  </div>




 	
</body>
</html>