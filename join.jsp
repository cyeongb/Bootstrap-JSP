<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width", initial-scale="1">
<link rel="stylesheet" href="css/bootstrap.css">
<title>jsp 게시판 웹 사이트</title>
</head>
<body>
<%
/* utf-8 은 요즘에많이 쓰이는 국제적인 인코딩 언어로 한글,영어 다 포함한다.
* 로그인 페이지는 보통 처음에 디자인을 먼저 하고 기능을 입히는 경우가 많다.
* 1. 디자인 작업 --디자인을 빠르게 할 수 있는 프레임 워크인 '부트스트랩'
*  --> 부트스트랩은 기기에 따라 해상도에 맞게 알아서 잘 디자인 해 준다.
*       그래서 반응형 웹에 사용하는 부트스트랩을 사용해서 meta 태그를 넣어준다.
*/
//nav --> 네비게이션은 하나의 웹 사이트에 전반적인 구성을 보여주는 역할을 한다.
%>
		<nav class="navbar navbar-default">
				<div class "navbar-header">
						<button type="button" class="navbar-toggle collapsed"
								data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
								aria-expended="false">
								<span class="icon-bar"></span>
								<span class="icon-bar"></span>
								<span class="icon-bar"></span>
								</button>
								<a class="navnar-brand" href="main.jsp">게시판 웹 사이트</a>
				</div>
				<div class ="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
					<ul class="nav navbar-nav">
						<li><a href="main.jsp">메인가기</a>
						<li><a href="bbs.jsp">게시판 가기 </a>
					</ul>
					<ul class="nav navbar-nav navbar-right">
						<li class="dropdown">
							<a href="#" class="dropdown-toggle"
							     data-toggle="dropdown" role="button"  aria-haspopup="true"
							     aria-expanded="false">접속하기 <span class="caret"></span></a>
							<ul class="Dropdown-menu">
								<li class="active"><a href="login.jsp">로그인하기</a></li>
								<li ><a  href="join.jsp">회원가입하기</a></li>
							</ul>
						</li>
					</ul>
				</div>
		</nav>
		<%
		//로그인 양식 만들기
		//container -->감쌀 수 있다. 하나의 컨테이너처럼..
		%>
		<div class="container">
			<div class="col-lg-4"></div>
			<div class="col-lg-4">
				<div class="jumbotron" style="padding-top:20px;">
				 	<form method="post" action="loginAction.jsp">
				 		<h3 style="text-align:center;">로그인 창</h3>
				 		<div class="form-group">
				 			<input type="text"  class="form-control" placeholder="아이디" name="userID" maxlength="20">
				 		</div>
				 			<div class="form-group">
				 			<input type="password"  class="form-control" placeholder="비밀번호" name="userPassword" maxlength="20">
				 			</div>
				 				<input type="submit" class="btn btn-primary form-control" value="로그인">
				 		
				 	</form>
				 </div>		
			</div>
			<div class="col-lg-4"></div>
		</div>
		<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
		<script src="js/bootstrap.js"></script>




</body>
</html>
