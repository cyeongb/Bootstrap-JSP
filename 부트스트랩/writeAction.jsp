
<%@page import="bbs.BbsDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page import="java.io.PrintWriter"%>
<%
	//자바스크립트를 사용하기 위한 것.
%>
<%//--------------------------------- writeAction.jsp -------------------------------------
	request.setCharacterEncoding("utf-8");
%>
<%
	//건너오는 모든 데이터를 utf-8로 쓰도록.
%>
<%
	// Bbs 클래스를 자바 빈즈로써 사용한다. 
	//여기는 write.jsp에서 받은 값들을  저장해서 페이지에 뿌려주는 역할.
%>
<%
	//각각의 변수의 값들을 다 입력받아서 하나의 bbs라는  게시글 인스턴스 만듬.
%>
<jsp:useBean id="bbs" class="bbs.Bbs" scope="page" />
<jsp:setProperty name="bbs" property="bbsTitle" />
<jsp:setProperty name="bbs" property="bbsContent" />


<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset= UTF-8">
<title>jsp게시판 웹 사이트</title>
</head>
<body>
	<%
		//joinAction.jsp에서는 회원가입할 때 입력한 데이터들이 다 정확하게 들어왔는지 확인 할 필요가 있다.
	%>
	<%
		//사용자가 입력한 값이 모두 널 값일때 제어해 줄 필요가 있다.
		String userID = null;
		if (session.getAttribute("userID") != null) {
	%>
	<script>
		alert("회원가입 완료 되었습니다.");
	</script>
	<%
		userID = (String) session.getAttribute("userID");
		}
		if (userID == null) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인을 해 주세요 ')");
			script.println("location.href='login.jsp'");
			script.println("</script>");
		} else {
			if (bbs.getBbsTitle() == null || bbs.getBbsContent() == null) { //게시판 제목 혹은 글 입력을 안하면 실행되는 문장.
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('입력이 안된 사항이 있습니다.')");
				script.println("history.back()");
				script.println("</script>");
			} else {
				BbsDAO bbsDAO = new BbsDAO();
				int result = bbsDAO.wirte(bbs.getBbsTitle(), userID, bbs.getBbsContent());
				if (result == -1) { //디비에  오류는 -1 반환  	                  
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('글 작성 오류')");
					script.println("history.back()");
					script.println("</script>");

				} else {
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('글 작성 성공!')");
					script.println("location.href='bbs.jsp'");
					script.println("</script>");

				}
			}
		}
	%>

</body>
</html>


