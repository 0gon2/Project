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
 
 <script type="text/javascript">
	var httpRequest = null;
	
	function sendRequest(url, params, callback, method){
		httpRequest = new XMLHttpRequest();   
		var httpMethod = method?method:'GET'; /*='GET'  */
		if(httpMethod!='GET' && httpMethod !='POST'){
			httpMethod='GET';
		}
		
		var httpParams = (params==null || params =='')?null:params; 
		var httpUrl = url;                            /* 포스트 방식일때 url */
		if(httpMethod=='GET' && httpParams !=null){
			httpUrl=httpUrl+"?"+httpParams;           /* 겟 방식일때 url */
		}
		
		httpRequest.open(httpMethod,httpUrl, true);
		httpRequest.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
		httpRequest.onreadystatechange=callback;
		httpRequest.send(httpMethod=='POST'?httpParams:null);
	}
	
	function helloToServer(){
		var params ="name="+encodeURIComponent(document.f.name.value);
		sendRequest("hello.jsp",params,helloFromServer,"POST");
	}
	
	function helloFromServer(){
		if(httpRequest.readyState==4){
			if(httpRequest.status==200){
				alert("서버응답:"+httpRequest.responseText);
				document.getElementById("aaa").innerHTML=httpRequest.responseText
			}
		}
	}
	
</script>
 
 
<body>

<div id="id02" class="w3-modal">
    <div class="w3-modal-content w3-card-4 w3-animate-zoom" style="max-width:600px">
  
      <div class="w3-center"><br>
        <span onclick="document.getElementById('id02').style.display='none'" class="w3-button w3-xlarge w3-transparent w3-display-topright" title="Close Modal">×</span>
      </div>
	<form class="w3-container" name="f">
        <div class="w3-section">
          <label><b>학교검색</b></label>
          <input class="w3-input w3-border w3-margin-bottom" type="text" placeholder="Enter Username" name="esname" required>
          <input type="button" onclick="helloToServer()" value="찾기">
        </div>
      </form>
      <div class="w3-container" id="aaa"></div>
      
      
      <div class="w3-container w3-border-top w3-padding-16 w3-light-grey">
        <button onclick="document.getElementById('id02').style.display='none'" type="button" class="w3-button w3-red w3-right">Cancel</button>
        <span class="w3-right w3-padding w3-hide-small">Forgot <a href="#">password?</a></span>
      </div>

    </div>
  </div>
</body>
</html>