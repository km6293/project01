<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="myshop.goods.*" %>
<%@ page import = "java.sql.*" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<h1>writePro page</h1>
   <% 
	  request.setCharacterEncoding("UTF-8"); 
      String save = request.getRealPath("/imgsave/sellerimg");
      int size = 512*512*100;
      String enc = "UTF-8";
      DefaultFileRenamePolicy dp = new DefaultFileRenamePolicy();
      MultipartRequest mr = new MultipartRequest(request,save,size,enc,dp);
      
      //String code = mr.gew]tParameter("goods_code");
      
      GoodsDTO dto = new GoodsDTO();
      
      dto.setGoods_name(mr.getParameter("goods_name"));
      //dto.setGoods_brand(mr.getParameter("goods_brand"));
      //String goods_brand = (String)session.getAttribute("user_id");
      dto.setGoods_brand(mr.getParameter("goods_brand"));
      dto.setGoods_price(Integer.parseInt(mr.getParameter("goods_price")));
      dto.setGoods_delivery(Integer.parseInt(mr.getParameter("goods_delivery")));
      dto.setGoods_option(mr.getParameter("goods_option"));
      dto.setGoods_count(Integer.parseInt(mr.getParameter("goods_count")));
      dto.setGoods_msg(mr.getParameter("goods_msg"));
      
      String systemFileName = null;
      if(systemFileName == null)
        systemFileName = "default.jpg";
      dto.setGoods_img(mr.getFilesystemName("file1"));
      
      GoodsDAO dao = GoodsDAO.getInstance();
      //myshopDAO dbPro = new myshopDAO();
      dao.insertGoods(dto);
       
       response.sendRedirect("sellerStore.jsp");
%>
