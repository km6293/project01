<%@page import="myshop.shopuser.UserDAO"%>
<%@page import="myshop.shopuser.UserDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
UserDTO udto = new UserDTO();
	//세션이 있을 때만 동작
	if(session.getAttribute("sessionId")!=null){

//세션 불러오기
		String sessionId = (String)session.getAttribute("sessionId");
		String sessionAuto = (String)session.getAttribute("sessionAuto");
	
		//세션ID로 회원정보 dto에 저장
		UserDAO udao = UserDAO.getInstance();
		udto = udao.myInfo(sessionId);

		//로그인 체크
	    boolean result = udao.loginCheck(udto);
	  	
		//sessionAuto가 1이면 쿠키 생성
		if(sessionAuto !=null){ 
	    	if(sessionAuto.equals("1")){
	    		Cookie cid = new Cookie("cid" , sessionId);
	    		Cookie cpw = new Cookie("cpw" , udto.getUser_pw());
	    		Cookie cauto = new Cookie("cauto" , sessionAuto);
	    		cid.setMaxAge(60*60*24);
	    		cpw.setMaxAge(60*60*24);
	    		cauto.setMaxAge(60*60*24);
	    		response.addCookie(cid);
	    		response.addCookie(cpw);
	    		response.addCookie(cauto);
	    	}
		}
	//세션이 없을 때
	}else{
		String id=null,pw=null,auto=null;
		
		//쿠키 불러오기
		Cookie [] cookies = request.getCookies();
		//로그아웃일 경우 로그아웃 파라미터 가져옴
		String logout = request.getParameter("logout");
		
		//로그아웃이 아닐 경우
		if(logout==null){
			//쿠키정보 읽어서 세션에 입력
			if(cookies != null){
				for(Cookie c : cookies){
					if(c.getName().equals("cid")){ id = c.getValue();udto.setUser_id(id);}
					if(c.getName().equals("cpw")){ pw = c.getValue();udto.setUser_pw(pw);}
					if(c.getName().equals("cauto")){ auto = c.getValue();udto.setAuto(auto);}
				}
				session.setAttribute("sessionId",id);
				session.setAttribute("sessionAuto",auto);
			}
		//로그아웃인 경우
		}else{
			//쿠키가 있으면 쿠키 지움
			if(cookies != null){
				for(Cookie c : cookies){
					if(c.getName().equals("cid")){
						c.setMaxAge(0);
						response.addCookie(c);
					}
					if(c.getName().equals("cpw")){
						c.setMaxAge(0);
						response.addCookie(c);
					}
					if(c.getName().equals("cauto")){
						c.setMaxAge(0);
						response.addCookie(c);			
					}
				}
			}
		}
	}
		
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>myShop</title>
</head>
<body>
<div>
<h1>로그인</h1>
<%@ include file="/include/top.jsp"%> <!-- 상단 -->
</div>
<%@ include file="/include/image.jsp" %> <!--image파일 -->
<div>
<%@ include file="/include/mainGoods.jsp" %> 
</div>
<br/><br/><br/>&nbsp;<br/><br/>
<div>
<%@ include file="/include/bottom.jsp" %> <!--하단 -->
</div>
</body>
</html>