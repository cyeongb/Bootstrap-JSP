<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
  
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset= UTF-8">
<title>jsp게시판 웹 사이트</title>
</head>
<body>
<%   //현재 페이지에 접속한 회원의 세션이 빼앗기도록 만들어서 로그아웃 시켜준다. 
		session.invalidate();
		//로그아웃하고 다시 메인페이지로 접속하게 한다. 
%>
	<script>
			location.href='main.jsp';
	</script>


</body>
</html>