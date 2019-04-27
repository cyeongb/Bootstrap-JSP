
<%@page import="bbs.Bbs"%>
<%@page import="bbs.BbsDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page import="java.io.PrintWriter"%>
<%
	//------------------------ updateAction.jsp -------------------------------------------
%>
<%
	request.setCharacterEncoding("utf-8");
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset= UTF-8">
<title>jsp게시판 웹 사이트</title>
</head>
<body>
	
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
		} 
		int bbsID=0;
		if(request.getParameter("bbsID")!=null){
			bbsID=Integer.parseInt(request.getParameter("bbsID"));
		}
		if(bbsID==0){
			PrintWriter script=response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 글입니다.')");
			script.println("location.href='bbs.jsp'");
			script.println("</script>");
		}
		Bbs bbs=new BbsDAO().getBbs(bbsID); //id로 해당 글을 가져온다.
		if(!userID.equals(bbs.getUserID())){
			PrintWriter script=response.getWriter();
			script.println("<script>");
			script.println("alert('권한이 없습니다.')");
			script.println("history.back()");
			script.println("</script>");
		}
		else {//제목과 내용이 빈칸이거나, 널값이 하나라도 있는 경우.
			if (request.getParameter("bbsTitle") == null || request.getParameter("bbsContent") == null 
			|| request.getParameter("bbsTitle").equals(" ") || request.getParameter("bbsTitle").equals(" ")){ 
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('입력이 안된 사항이 있습니다.')");
				script.println("history.back()");
				script.println("</script>");
			} else {
				BbsDAO bbsDAO = new BbsDAO();
				int result = bbsDAO.update(bbsID, request.getParameter("bbsTitle"),request.getParameter("bbsContent"));
				if (result == -1) { //디비에  오류는 -1 반환  	                  
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('글 수정 오류')");
					script.println("history.back()");
					script.println("</script>");

				} else {
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('글 수정 성공!')");
					script.println("location.href='bbs.jsp'");
					script.println("</script>");

				}
			}
		}
	%>

</body>
</html>


