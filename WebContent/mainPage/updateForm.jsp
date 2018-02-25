<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<%	
/* 맴버아이디 해더에 */
	String index=null;
	String esname=request.getParameter("esname");
	if(esname==null){
		esname=(String)session.getAttribute("schemt");
	}
	String msname=request.getParameter("msname");
	if(msname==null){
		msname=(String)session.getAttribute("schmid");
	}
	String hsname=request.getParameter("hsname");
	if(hsname==null){
		hsname=(String)session.getAttribute("schhigh");
	}
%>
</head>
<style type="text/css">
.form-style-2{
	max-width: 500px;
	padding: 15px 12px 10px 20px;
	font: 13px Arial, Helvetica, sans-serif;
}
.form-style-2-heading{
	font-weight: bold;
	font-style: italic;
	border-bottom: 2px solid #ddd;
	margin-bottom: 20px;
	font-size: 15px;
	padding-bottom: 3px;
}
</style>
<style>

.form-style-7{
	max-width:400px;
	margin:10px auto;
	border-radius:2px;
	font-family: Arial, Helvetica, sans-serif;
}
.form-style-7 h1{
	display: block;
	text-align: center;
	padding: 0;
	margin: 0px 0px 20px 0px;
	color: #5C5C5C;
	font-size:x-large;
}
.form-style-7 ul{
	list-style:none;
	padding:0;
	margin:0;	
}
.form-style-7 li{
	display: block;
	padding: 9px;
	border:1px solid #DDDDDD;
	margin-bottom: 30px;
	border-radius: 3px;
}
.form-style-7 li:last-child{
	border:none;
	margin-bottom: 0px;
	text-align: center;
}
.form-style-7 li > label{
	display: block;
	float: left;
	margin-top: -19px;
	height: 14px;
	padding: -5px 5px 2px 5px;
	color: #7f7f7f;
	font-size: 14px;
	overflow: hidden;
	font-family: Arial, Helvetica, sans-serif;
}
.form-style-7 input[type="text"],
.form-style-7 input[type="date"],
.form-style-7 input[type="datetime"],
.form-style-7 input[type="email"],
.form-style-7 input[type="number"],
.form-style-7 input[type="search"],
.form-style-7 input[type="time"],
.form-style-7 input[type="url"],
.form-style-7 input[type="password"],
.form-style-7 textarea,
.form-style-7 select 
{
	box-sizing: border-box;
	-webkit-box-sizing: border-box;
	-moz-box-sizing: border-box;
	width: 100%;
	display: block;
	outline: none;
	border: none;
	height: 25px;
	line-height: 25px;
	font-size: 16px;
	padding: 0;
	font-family: Arial, Helvetica, sans-serif;
}
.form-style-7 input[type="text"]:focus,
.form-style-7 input[type="date"]:focus,
.form-style-7 input[type="datetime"]:focus,
.form-style-7 input[type="email"]:focus,
.form-style-7 input[type="number"]:focus,
.form-style-7 input[type="search"]:focus,
.form-style-7 input[type="time"]:focus,
.form-style-7 input[type="url"]:focus,
.form-style-7 input[type="password"]:focus,
.form-style-7 textarea:focus,
.form-style-7 select:focus 
{
}
.form-style-7 li > span{
	background: #F3F3F3;
	display: block;
	margin: 0 -9px -9px -9px;
	text-align: center;
	color: #C0C0C0;
	font-family: Arial, Helvetica, sans-serif;
	font-size: 11px;
}
.form-style-7 textarea{
	resize:none;
}
.form-style-7 input[type="submit"],
.form-style-7 input[type="button"]{
	background: #2471FF;
	border: none;
	padding: 10px 20px 10px 20px;
	border-bottom: 1px solid #5994FF;
	border-radius: 3px;
	color: #D2E2FF;
}
.form-style-7 input[type="submit"]:hover,
.form-style-7 input[type="button"]:hover{
	background: #6B9FFF;
	color:#fff;
}
</style>
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
	
	function helloToServer(type){
		if(type=='esname'){
		var params ="esname="+encodeURIComponent(document.f.esname.value)+"&index=1&msname=<%=msname%>&hsname=<%=hsname%>";
		sendRequest("/Project/searchList.jsp",params,helloFromServer,"POST");
		}
	 	if(type=='msname'){
		var params ="msname="+encodeURIComponent(document.g.msname.value)+"&index=2&esname=<%=esname%>&hsname=<%=hsname%>";
		sendRequest("/Project/searchList.jsp",params,helloFromServer,"POST");
		}
		if(type=='hsname'){
		var params ="hsname="+encodeURIComponent(document.h.hsname.value)+"&index=3&esname=<%=esname%>&msname=<%=msname%>";
		sendRequest("/Project/searchList.jsp",params,helloFromServer,"POST");
		} 
	}
	
	function helloFromServer(){
		if(httpRequest.readyState==4){
			if(httpRequest.status==200){
				document.getElementById("aaa").innerHTML=httpRequest.responseText
				document.getElementById("bbb").innerHTML=httpRequest.responseText
				document.getElementById("ccc").innerHTML=httpRequest.responseText
			}
		}
	}
	
	
		
</script>

<body>
<div class="w3-overlay w3-hide-large" onclick="w3_close()" style="cursor:pointer" title="close side menu" id="myOverlay"></div>

<!-- Main content: shift it to the right by 270 pixels when the sidebar is visible -->
<div class="w3-main w3-container" style="margin-left:270px;margin-top:117px;">
	 <div class="w3-panel w3-padding-medium w3-card-4 ">
	     
  <h4 class="w3-opacity"><i class="fa fa-male"></i>&nbsp;회원정보</h4>
		  <div class="form-style-2">
		<div class="form-style-2-heading w3-opacity">학교정보 수정</div>
			<form class="form-style-7" method="post" action="updatePro.jsp">
				<input type="hidden" name="memberid" value="<%=memberid%>">
				<ul>
				<li>
				    <label for="name">Elementary School</label>
				    <input style="text-align:center;" type="text" name="sch_emt" value="<%=esname %>" onclick="document.getElementById('id02').style.display='block'" maxlength="100">
				    <span>現:<%=session.getAttribute("schemt") %></span>
				    
				</li>
				<li>
				    <label for="name">Middle School</label>
				    <input style="text-align:center;" type="text" name="sch_mid" value="<%=msname %>" onclick="document.getElementById('id03').style.display='block'" maxlength="100">
				    <span>現:<%=session.getAttribute("schmid") %></span>
				    
				</li>
				<li>
				    <label for="name">High School</label>
				    <input style="text-align:center;" type="text" name="sch_high" value="<%=hsname %>" onclick="document.getElementById('id04').style.display='block'" maxlength="100">
				    <span>現:<%=session.getAttribute("schhigh") %></span>
				    
				</li>
				<li>
				    <input type="submit" value="수정" >
				</li>
				</ul>
			</form>
			
			
  <a href="/Project/mainPage/leavePro.jsp"  >회원탈퇴..</a >
   </div>
</div>

</div>

<!-- 학교 찾는 모달02(초) -->
<div id="id02" class="w3-modal">
    <div class="w3-modal-content w3-card-4 w3-animate-zoom" style="max-width:600px">
  
      <div class="w3-center"><br>
        <span onclick="document.getElementById('id02').style.display='none'" class="w3-button w3-xlarge w3-transparent w3-display-topright" title="Close Modal">×</span>
      </div>
	<form class="w3-container" name="f">
        <div class="w3-section">
          <label><b>학교검색</b></label>
          <input class="w3-input w3-border w3-margin-bottom" type="text" placeholder="Enter Username" name="esname" required>
          <input class="w3-button w3-block w3-blue w3-section w3-padding" type="button" onclick="helloToServer('esname')" value="찾기">
        </div>
      </form>
      <div class="w3-container" id="aaa"></div>
      
      
      <div class="w3-container w3-border-top w3-padding-16 w3-light-grey">
        <button onclick="document.getElementById('id02').style.display='none'" type="button" class="w3-button w3-red w3-right">Cancel</button>
        <span class="w3-right w3-padding w3-hide-small">Forgot <a href="#">password?</a></span>
      </div>

    </div>
  </div>
  <!-- 학교 찾는 모달03(중) -->
<div id="id03" class="w3-modal">
    <div class="w3-modal-content w3-card-4 w3-animate-zoom" style="max-width:600px">
  
      <div class="w3-center"><br>
        <span onclick="document.getElementById('id03').style.display='none'" class="w3-button w3-xlarge w3-transparent w3-display-topright" title="Close Modal">×</span>
      </div>
	<form class="w3-container" name="g">
        <div class="w3-section">
          <label><b>학교검색</b></label>
          <input class="w3-input w3-border w3-margin-bottom" type="text" placeholder="Enter Username" name="msname" required>
          <input class="w3-button w3-block w3-blue w3-section w3-padding" type="button" onclick="helloToServer('msname')" value="찾기">
        </div>
      </form>
      <div class="w3-container" id="bbb"></div>
      
      
      <div class="w3-container w3-border-top w3-padding-16 w3-light-grey">
        <button onclick="document.getElementById('id03').style.display='none'" type="button" class="w3-button w3-red w3-right">Cancel</button>
        <span class="w3-right w3-padding w3-hide-small">Forgot <a href="#">password?</a></span>
      </div>

    </div>
  </div>


<!-- 학교 찾는 모달04(고) -->
<div id="id04" class="w3-modal">
    <div class="w3-modal-content w3-card-4 w3-animate-zoom" style="max-width:600px">
  
      <div class="w3-center"><br>
        <span onclick="document.getElementById('id04').style.display='none'" class="w3-button w3-xlarge w3-transparent w3-display-topright" title="Close Modal">×</span>
      </div>
	<form class="w3-container" name="h">
        <div class="w3-section">
          <label><b>학교검색</b></label>
          <input class="w3-input w3-border w3-margin-bottom" type="text" placeholder="Enter Username" name="hsname" required>
          <input class="w3-button w3-block w3-blue w3-section w3-padding" type="button" onclick="helloToServer('hsname')" value="찾기">
        </div>
      </form>
      <div class="w3-container" id="ccc"></div>
      
      
      <div class="w3-container w3-border-top w3-padding-16 w3-light-grey">
        <button onclick="document.getElementById('id04').style.display='none'" type="button" class="w3-button w3-red w3-right">Cancel</button>
        <span class="w3-right w3-padding w3-hide-small">Forgot <a href="#">password?</a></span>
      </div>

    </div>
  </div>
</body>
</html>