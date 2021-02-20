<%@page import="myshop.goods.GoodsDAO"%>
<%@page import="myshop.goods.GoodsDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>  

<html>
<head>
<title>상품상세 수정</title>
</head>
<body>
<%
	request.setCharacterEncoding("UTF-8");
	String save = request.getRealPath("/imgsave/sellerimg");
	int size = 512*512*100;
	String enc = "UTF-8";
	DefaultFileRenamePolicy dp = new DefaultFileRenamePolicy();
	MultipartRequest mr = new MultipartRequest(request,save,size,enc,dp);
    
	GoodsDTO dto = new GoodsDTO();
	dto.setGoods_brand((String)session.getAttribute("sessionId"));
	
	dto.setGoods_name(mr.getParameter("goods_name"));
	dto.setGoods_price(Integer.parseInt(mr.getParameter("goods_price")));
	dto.setGoods_count(Integer.parseInt(mr.getParameter("goods_count")));
	dto.setGoods_option(mr.getParameter("goods_option"));
	dto.setGoods_delivery(Integer.parseInt(mr.getParameter("goods_delivery")));
	dto.setGoods_code(Integer.parseInt(mr.getParameter("goods_code")));
	dto.setGoods_msg(mr.getParameter("goods_msg"));
	
	//String systemFileName = null;
	//if(systemFileName == null){
	//	systemFileName = "default.jpg";}
	//dto.setGoods_img(mr.getFilesystemName("goods_img"));
	
	String img = mr.getFilesystemName("img");
	String sysImg = mr.getParameter("sysImg");
	if(img == null){
		dto.setGoods_img(sysImg);
	}else{
		dto.setGoods_img(img);
	}
	
	GoodsDAO dao = GoodsDAO.getInstance();
	dao.albumUpdate(dto);
	
	String goods_code = mr.getParameter("goods_code");
%>	
	
<script>
	alert("수정되었습니다.")
</script>
	
	<meta http-equiv="Refresh" content="0;url=/myShop/board/goodsDetail.jsp?goods_code=<%=goods_code%>">

</body>
</html>      
