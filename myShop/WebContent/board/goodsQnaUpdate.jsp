<%@page import="myshop.qnaboard.QnaDTO"%>
<%@page import="myshop.qnaboard.QnaDAO"%>
<%@page import="myshop.goods.MyShopDTO"%>
<%@page import="myshop.goods.MyShopDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" 
	pageEncoding="UTF-8"%>

    
<%
	String sessionId = (String) session.getAttribute("sessionId");

	String goods_code = request.getParameter("goods_code");
	int code = 0;

	MyShopDAO goodsDAO = MyShopDAO.getInstance();//new myshopDAO();
	MyShopDTO dto = null;
	if(goods_code != null)
	{
		code = Integer.parseInt(goods_code);
		dto = goodsDAO.detailGoods(code);
	}
	
  	int num = Integer.parseInt(request.getParameter("num"));
  	String pageNum = request.getParameter("pageNum");
  	try{
     	QnaDAO dao = QnaDAO.getInstance();
     	QnaDTO dto2 =  dao.updateGetQna(num);
%>

<b>글수정</b>
<br>
<script>
   function formCheck(frm) {
   if (frm.subject.value == "") {
      alert("제목을 입력해 주세요!");
      frm.subject.focus();
       return false;
   }
    if (frm.content.value == "") {
        alert("내용을 입력해 주세요!!");
        frm.content.focus();
        return false;
    }
   }
</script>
<form method="post" name="goodsQnaUpdate" action="goodsQnaUpdatePro.jsp" onsubmit="return formCheck(this)">
<table width="400" border="1" cellspacing="0" cellpadding="0" align="center">
  <tr>
    <td  width="70" align="center">이 름</td>
    <td align="left" width="330">
       &nbsp;<%=sessionId%><input type="hidden" size="10" maxlength="10" name="writer" value="<%=sessionId%>">
	   <input type="hidden" name="num" value="<%=dto2.getNum()%>">
	   <input type="hidden" name="goods_code" value="<%= code %>">
	   <input type="hidden" name="pageNum" value="<%= pageNum %>">
	   </td>
 </tr>
  <tr>
    <td  width="70" align="center" >제 목</td>
    <td align="left" width="330">
       <input type="text" size="40" maxlength="50" name="subject" value="<%=dto2.getSubject()%>"></td>
  </tr>
  <tr>
    <td  width="70" align="center" >내 용</td>
    <td align="left" width="330">
     <textarea name="content" rows="13" cols="40"><%=dto2.getContent()%></textarea></td>
  </tr>
  <tr>      
   <td colspan=2 align="center"> 
     <input type="submit" value="글수정" >  
     <input type="reset" value="다시작성">
     <input type="button" value="목록보기" 
       onclick="document.location.href='goodsDetail.jsp?goods_code=<%=goods_code%>&pageNum=<%=pageNum%>'">
   </td>
 </tr>
 </table>
</form>
<%
	}catch(Exception e){}
  %>
    