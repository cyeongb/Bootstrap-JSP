<%@page import="java.io.PrintWriter"%>
<%@page import="user.UserDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
    <%@ page import ="user.UserDAO" %>
    <%@ page import ="java.io.PrintWriter" %> <%//자바스크립트를 사용하기 위한 것. %>
    <% request.setCharacterEncoding("utf-8");%><%//건너오는 모든 데이터를 utf-8로 쓰도록. %> 
    <%// User클래스를 자바 빈즈로써 사용한다. %>
    <jsp:useBean id="user" class= "user.User" scope="page" />
    <jsp:setProperty name="user" property="userID" />
    <jsp:setProperty name="user" property="userPassword"/>
    
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset= UTF-8">
<title>jsp게시판 웹 사이트</title>
</head>
<body>
<%
//사용자에게 로그인 결과를 알려주는 loginAction페이지.
%>
<%    
// 		request.setCharacterEncoding("utf-8");
// 		String userID="";
// 		String userPassword="";
// 		if(request.getParameter("userID")!=""){
// 			userID=(String)request.getParameter("userID");
// 		}
// 		if(request.getParameter("userPassword")!=""){
// 			userPassword=(String)request.getParameter("userPassword");
// 		}
         
    //로그인이 된 유저는 로그인페이지와 회원가입 페이지에 들어갈 수 없도록 제어해 준다.
		String userID=null;
     if(session.getAttribute("userID")!=null){
    	 userID=(String)session.getAttribute("userID");
     }
     if(userID !=null){
    	  PrintWriter script=response.getWriter();
   	   script.println("<script>");
   	   script.println("alert('이미 로그인이 되어 있습니다.')");
   	   script.println("location.href='main.jsp'");
   	   script.println("</script>");   
        }
       //userDAO라는 인스턴스 생성.
		UserDAO userDAO=new UserDAO();
       // 회원가입시 입력한 데이터를 로그인 결과 페이지에 들고와서 result라는 변수에 저장해서 구현 해 줄 예정임.
		//UserDAO에서 입력했던 -2부터..1까지의 값들이 모두 result에 담길 예정이다.
       int result=userDAO.login(user.getUserID(), user.getUserPassword());
       if(result==1){  //로그인이 성공한 경우
    	   session.setAttribute("userID",user.getUserID());
    	   PrintWriter script=response.getWriter();
    	   script.println("<script>");
    	   script.println("alert('로그인 성공!')");
    	   script.println("location.href='main.jsp' ");
    	   script.println("</script>");
    	   
       }else if(result==0) {//비번이 틀린 경우
    	   PrintWriter script=response.getWriter();
    	   script.println("<script>");
    	   script.println("alert('비밀번호가 틀립니다.')");
    	   script.println("history.back()");  //다시 로그인 페이지로 돌려 보낸다. 
    	   script.println("</script>");   
    	   script.close();
    	 }else if(result==-1) {//아이디가 없을 떄,
      	   PrintWriter script=response.getWriter();
      	   script.println("<script>");
      	   script.println("alert('아이디가 없습니다.')");
      	   script.println("history.back()");  //다시 로그인 페이지로 돌려 보낸다. 
      	   script.println("</script>");    
      	   script.close();
    	 }else if(result==-2) {//데이터베이스 오류
      	   PrintWriter script=response.getWriter();
      	   script.println("<script>");
      	   script.println("alert('데이터베이스에 오류가 발생했습니다.')");
      	   script.println("history.back()");  //다시 로그인 페이지로 돌려 보낸다. 
      	   script.println("</script>");   
      	   script.close();
    	 }
%>

</body>
</html>
