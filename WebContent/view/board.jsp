<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<body>

<!-- 

	0. 해당하는 학교에 게시판이 없다면 인서트
	1. 맴버db에 저장되어 있는 id에 해당하는 초등학교 중학교 고등학교를 가지고 온다음
	2. a태그의 이름으로 넣어주고 href는? 게시판 링크(schoolboard.jsp)로 보내주고
	3. where sname= 학교이름 해서  
	
	게시판 링크에서는 학교 id기준으로 if문 써야겠다.
	학교db에 학교id를 가지고와야돼 뭐를 기준으로? 학교 id가 보드id가 되겠네 
	

 -->
<div class="w3-sidebar w3-bar-block w3-collapse w3-animate-left" style="z-index:3;width:270px" id="mySidebar">

  <div class="myMenu" >
  <div class="w3-container">
    <h4>학생 명단</h4>
  </div>
    <a class="w3-bar-item w3-button" href="">(…)초등학교</a>
  <a class="w3-bar-item w3-button" href="">(…)중학교</a>
  <a class="w3-bar-item w3-button" href="">(…)고등학교</a>
  <br>
    <div class="w3-container">
     <h4>자유 게시판</h4>	
    </div>
  </div>
  
 </div>
<!-- Overlay effect when opening sidebar on small screens -->
<div class="w3-overlay w3-hide-large" onclick="w3_close()" style="cursor:pointer" title="close side menu" id="myOverlay"></div>

<!-- Main content: shift it to the right by 270 pixels when the sidebar is visible -->
<div class="w3-main w3-container" style="margin-left:270px;margin-top:117px;">


<p class="w3-xlarge">(……)학교 학생들</p>
<div class="w3-panel w3-padding-large w3-card-4 ">
              <img src="/Project/images/ex.png" style="width:70%" alt="Northern Lights" class="w3-margin-bottom">
    
</div>


</div>
</body>
</html>