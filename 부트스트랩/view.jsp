
<%@page import="bbs.Bbs"%>
<%@page import="bbs.BbsDAO"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width" initial-scale="1">
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/custom.css">
<title>감비의 게시판 웹 사이트</title>
</head>
<body>
	<h1>게시판 글이다냥</h1>
	<img src="gmbi.gif" width="100" height="180">

	<%
		//------------------------------ view.jsp -------------------------------------------
		String userID = null;
		if (session.getAttribute("userID") != null) {
			userID = (String) session.getAttribute("userID");
		}
		// ************************ 매개변수 및 기본 세팅하기 *****************************
		int bbsID = 0;
		if (request.getParameter("bbsID") != null) {
			bbsID = Integer.parseInt(request.getParameter("bbsID"));
		}
		if (bbsID == 0) { //id가 존재 해야지만 글을 볼 수 있게 제어.
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert ('유효하지 않은 글입니다.')");
			script.println("location.href='bbs.jsp'");
			script.println("</script>");
		}
		Bbs bbs = new BbsDAO().getBbs(bbsID); //유효한 글이면 bbs라는 인스턴스에 담는다.
	%>
	<nav class="navbar navbar-default">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle collapsed"
				data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
				aria-expended="false">
				<span class="icon-bar"></span> <span class="icon-bar"></span> <span
					class="icon-bar"></span>
			</button>
			<a class="navnar-brand" href="main.jsp">감비의 게시판 웹 사이트</a>
		</div>
		<div class="collapse navbar-collapse"
			id="bs-example-navbar-collapse-1">
			<ul class="nav navbar-nav">
				<li><a href="main.jsp">메인가기</a>
				<li class="active"><a href="bbs.jsp">게시판 가기 </a>
			</ul>
			<%
				//아래의 "접속하기" 버튼을 회원가입이 되어 있지 않을 때만 활성화 되게 만들어 준다.
				if (userID == null) { //로그인이 되어있지 않다면,
										//회원가입이나 로그인을 할 수있도록 navi를 만들어 준다.
			%>
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown"><a href="#" class="dropdown-toggle"
					data-toggle="dropdown" role="button" aria-haspopup="true"
					aria-expanded="false">접속하기 <span class="caret"></span></a>
					<ul class="Dropdown-menu">
						<li><a href="login.jsp">로그인하기</a></li>
						<li><a href="join.jsp">회원가입하기</a></li>
					</ul></li>
			</ul>
			<%
				} else { //그렇지 않다면..로그인이 된 사람들이 볼 수있는 화면을 만든다.
			%>
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown"><a href="#" class="dropdown-toggle"
					data-toggle="dropdown" role="button" aria-haspopup="true"
					aria-expanded="false">회원관리 <span class="caret"></span></a>
					<ul class="Dropdown-menu">
						<li><a href="logoutAction.jsp">로그아웃하기</a></li>
					</ul></li>
			</ul>
			<%
				}
			%>

		</div>
	</nav>
	<div class="container">
		<div class="row">

			<table class="table table-striped"
				style="text-align: center; border: 2px solid #ddddd">
				<!--  stripped는 게시판의 글 목록들이 홀짝 번갈아가면서 색상이 변경 된다. -->
				<thead>
					<!--  thead란 가장 윗줄에 위치해서, 각각의 속성들을 알려준다. -->
					<tr>
						<!--  tr은 테이블의 한 행을 의미(한 줄)  th는 속성값-->
						<th colspan="3"
							style="background-color: #eeeeee; text-align: center;">게시판 글보기</th>
					</tr>
				</thead>
				<tbody>
					<!--  body를 이용해서 실제로 적었을 떄, 데이터 확인용으로 테스트 할 수 있다. -->
					<tr>
						<!-- 각각의 목록이 한 줄씩 나올 수 있도록 tr태그를 각각 묶는다. -->
						<td style="width: 20%;">글 제목</td>
						<td colspan="2"><%=bbs.getBbsTitle().replaceAll(" ","&nbsp;").replaceAll("<","&lt;").replaceAll(">","&gt;").replaceAll("\n","<br>") %></td>
					</tr>
					<tr>
						<td>작성자</td>
						<td colspan="2"><%= bbs.getUserID() %></td>
					</tr>
					<tr>
						<td>작성일자</td>
						<td colspan="2"><%=bbs.getDatetime().substring(0, 11) +
								bbs.getDatetime().substring(11, 13) + "시"	
							  + bbs.getDatetime().substring(14, 16) + "분"%></td>
					</tr>
					<tr>
						<td style="text-align:center;">내용</td><!-- replaceAll() -> 특수문자 처리해 줌. 왼쪽 걸 오른쪽 html문자로 치환.-->
						<td colspan="2" style=" min-height:400px; text-align:center;">
						<%=bbs.getBbsContent().replaceAll(" ","&nbsp;").replaceAll("<","&lt;").replaceAll(">","&gt;").replaceAll("\n","<br>") %></td>
					</tr>
				</tbody>
			</table>
			<a href="bbs.jsp" class="btn btn-primary">목록</a>
			<% 
				if(userID !=null && userID.equals(bbs.getUserID())){
			%>	
				<a  href="update.jsp?bbsID=<%=bbsID %>"class="btn btn-primary">글수정</a>
				<a onclick="return confirm('삭제하시겠습니까?')" href="deleteAction.jsp?bbsID=<%=bbsID %>"class="btn btn-primary">글삭제</a>
			<%	
				}
			%>
		</div>
	</div>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>
