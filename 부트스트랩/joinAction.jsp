<%@page import="java.io.PrintWriter"%>
<%@page import="user.UserDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
    <%@ page import ="user.UserDAO" %>
    <%@ page import ="java.io.PrintWriter" %> <%//자바스크립트를 사용하기 위한 것. %>
    <% request.setCharacterEncoding("utf-8");%><%//건너오는 모든 데이터를 utf-8로 쓰도록. %> 
    <%// User클래스를 자바 빈즈로써 사용한다. 
    	//여기는 회원가입 join.jsp의 데이터를 받아서 회원가입을 할 수 있게 해주는 페이지 작성문이다.
    %>
    <% //각각의 변수의 값들을 다 입력받아서 하나의 user라는 인스턴스 만듬.
    %>
    <jsp:useBean id="user" class= "user.User" scope="page" />
    <jsp:setProperty name="user" property="userID" />
    <jsp:setProperty name="user" property="userPassword"/>
    <jsp:setProperty name="user" property="userName"/>
    <jsp:setProperty name="user" property="userGender"/>
    <jsp:setProperty name="user" property="userEmail"/>
    
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
<%    //사용자가 입력한 값이 모두 널 값일때 제어해 줄 필요가 있다.
				String userID=null;
				if(session.getAttribute("userID")!=null){
%>			<script>
					alert("회원가입 완료 되었습니다.");
    			</script>	
<%  				userID=(String)session.getAttribute("userID");
				}
				if(userID !=null){
	  				PrintWriter script=response.getWriter();
	   				script.println("<script>");
	   				script.println("alert('이미 회원가입이 되어 있습니다.')");
	   				script.println("location.href='main.jsp'");
	   				script.println("</script>");   
   				}


		if(user.getUserID()==null || user.getUserPassword()==null || user.getUserName()==null || 
		user.getUserGender()==null || user.getUserEmail()==null){
			 PrintWriter script=response.getWriter();
	    	   script.println("<script>");
	    	   script.println("alert('입력이 안된 사항이 있습니다.')");
	    	   script.println("history.back()");  
	    	   script.println("</script>");   
		}else{
		UserDAO userDAO=new UserDAO();
       int result=userDAO.join(user);
       if(result==-1){   //디비에 아이디를 기본키로 설정 해 놓았는데 중복이되면
    	                   // 데이터베이스 오류가 생긴다. 그래서 디비 오류가생기는 -1 반환은
    	                   //아이디 중복현상이라고 볼 수 있다.
    	   PrintWriter script=response.getWriter();
    	   script.println("<script>");
    	   script.println("alert('이미 존재하는 아이디입니다.')");
    	   script.println("history.back()");
    	   script.println("</script>");
    	   
       }else {//회원가입 성공하게되면, UserDAO에 값이 저장되고 
    	      //세션에 값이 저장된 후 main.jsp로 이동하게 된다. 
    	   session.setAttribute("userID",user.getUserID());   
    	   PrintWriter script=response.getWriter();
    	   script.println("<script>");
    	   script.println("location.href='main.jsp'");
    	   script.println("</script>");   
    	   script.close();
    	 }
		}
%>

</body>
</html>
