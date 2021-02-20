<%@ page contentType = "text/html; charset=UTF-8" %>
<%@ page import = "myshop.community.CommunityDAO" %>
<%@ page import = "myshop.community.CommunityDTO" %>
<%@ page import = "java.util.List" %>
<%@ page import = "java.text.SimpleDateFormat" %>

<%
	//날짜 표기법 설정
    SimpleDateFormat sdf = 
        new SimpleDateFormat("yyyy-MM-dd HH:mm");
    
    //보던 페이지 가져오기
    String pageNum = request.getParameter("pageNum");
	
    //최초접속시 1번 페이지 보여줌
    if (pageNum == null) {
        pageNum = "1";
    }
//변수 및 객체 선언
  	//한페이지에 보여줄 글 개수
    int pageSize = 10;
  	//현재 페이지
    int currentPage = Integer.parseInt(pageNum);
  	//표시할 목록의 맨 위 아래 글 번호
    int startRow = (currentPage - 1) * pageSize + 1; 
    int endRow = currentPage * pageSize;	
    int count = 0;
    int number = 0;
	List commuList = null;
	
    //COMMUNITY DB에 접근할 DAO 인스턴스 호출
    CommunityDAO cmdao = CommunityDAO.getInstance();
    //사용자id를 세션에서 가져옵니다.
	String sessionId = (String)session.getAttribute("sessionId");
    //내가 작성한 모든 글 개수를 셉니다.
    count = cmdao.getMyCommuCount(sessionId); 
    //글이 있을 경우 목록을 가져옵니다.
    if (count > 0) {
    	commuList = cmdao.getMyCommuList(sessionId,startRow, endRow); 
    }						
%>
<html>
<head>
</head>
<body>
<%@ include file="/include/top.jsp"%>
<center><b>내가 쓴 글</b> 
<table width="700">
<tr>
    <td align="right">
<%
	//로그인 되어있는 경우
    if(sessionId != null){
%>
    <a href="/myShop/community/commuWrite.jsp">
    	글쓰기
    </a>
<%
	//로그인 안 되어있을 경우
	}else{
%>
    <a href="/myShop/login/loginForm.jsp">
    	로그인
    </a>
<%
	}
%>
    </td>
</tr> 
</table>
<%
	//글이 없을 경우
    if (count == 0) { 
%>
<table width="700" border="1" cellpadding="0" cellspacing="0">
<tr>
    <td align="center">
    	게시판에 저장된 글이 없습니다.
    </td>
</tr>
</table>

<%
	//글이 있을 경우
	}else{
%> 
<table border="1" width="700" cellpadding="0" cellspacing="0" align="center"> 
    <tr height="30"> 
      <td align="center"  width="70"  >
      	회원등급
      </td> 
      <td align="center"  width="250" >
      	제   목
      </td> 
      <td align="center"  width="100" >
      	작성자
      </td>
      <td align="center"  width="150" >
      	작성일
      </td> 
      <td align="center"  width="30" >
     	조회수
      </td>  
    </tr>
<%
		for (int i = 0 ; i < commuList.size() ; i++) {
			CommunityDTO cmdto = new CommunityDTO();
			cmdto = (CommunityDTO)commuList.get(i);
          
       		String c_rating = "";
  			String rating = cmdao.getRating(cmdto.getWriter());
  			if(rating.equals("1")){
  				c_rating = "일반회원";
  			}else if(rating.equals("2")){
  				c_rating= "관리자";
  			}else if(rating.equals("5")){
  				c_rating= "판매자";
  			}
    		if(cmdto.getState() == 1){
%>
    <tr height="30">
		<td align="center"  width="50" >
			<%=c_rating%>
		</td>
		<td  width="250" align="center">           
			<a href="/myShop/community/community.jsp?num=<%=cmdto.getNum()%>&pageNum=<%=currentPage%>">
            	<%=cmdto.getSubject()%>
            </a> 
<% 
				if(cmdto.getReadcount()>=50){
%>
            <img src="dev_img/hot.gif" border="0"  height="16">
<%
				}
%> 
		</td>
    	<td align="center"  width="100">
    		<%=cmdto.getWriter()%>
    	</td> 	
    	<td align="center"  width="150">
    		<%= sdf.format(cmdto.getReg_date())%>
    	</td> 
    	<td align="center"  width="50">
    		<%=cmdto.getReadcount()%>
    	</td>					
 	 </tr>
<%
			}
		}
%>
</table>
<%
	}
    if (count > 0) { 
        int pageCount = count / pageSize + ( count % pageSize == 0 ? 0 : 1); 
		 
        int startPage = (int)(currentPage/10)*10+1; 
		int pageBlock=10;
        int endPage = startPage + pageBlock-1;
        
        if (endPage > pageCount) endPage = pageCount;
        
        if (startPage > 10) {  %>
        <a href="myCommuList.jsp?pageNum=<%= startPage - 10 %>">[이전]</a>
<%      }
        for (int i = startPage ; i <= endPage ; i++) { %>
        <a href="myCommuList.jsp?pageNum=<%= i %>">[<%= i %>]</a>
<%
        }
        if (endPage < pageCount) { %>
        <a href="myCommuList.jsp?pageNum=<%= startPage + 10 %>">[다음]</a>
<%
        }
    }
%>
</center>
</body>
</html>