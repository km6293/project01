package myshop.goods;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import myshop.alldb.DBCon;


public class MyShopDAO {
   
   private static MyShopDAO instance = new MyShopDAO();
   private MyShopDAO() {}
   
   public static MyShopDAO getInstance() { return instance; }
   
   private Connection conn = null;
   private PreparedStatement pstmt = null;
   private ResultSet rs = null;
 
   public MyShopDTO detailGoods(int code) {
      MyShopDTO dto = null;
      try {
         conn = DBCon.getConnection();
         String sql = "select * from Goods where goods_code = ?";
         pstmt = conn.prepareStatement(sql);
         pstmt.setInt(1, code);
         rs = pstmt.executeQuery();
         if(rs.next()) {
            dto = new MyShopDTO();
            dto.setGoods_code(rs.getInt("goods_code"));
            dto.setGoods_brand(rs.getString("goods_brand"));
            dto.setGoods_name(rs.getString("goods_name"));
            dto.setGoods_price(rs.getInt("goods_price"));
            dto.setGoods_delivery(rs.getString("goods_delivery"));
            dto.setGoods_state(rs.getInt("goods_state"));
            dto.setGoods_option(rs.getString("goods_option"));
            dto.setGoods_img(rs.getString("goods_img"));
            dto.setGoods_msg(rs.getString("goods_msg"));
            dto.setGoods_count(rs.getInt("goods_count"));
            
            }
         
         }catch(Exception e) {
            e.printStackTrace();
         }finally {
            closeAll();
         }
         return dto;
         }
   
   public int getAlbumCount() {
      int totalAlbumCount = 0;
      
      try {
         conn = DBCon.getConnection();
         
         String sql = "select count(*) from Goods";
         pstmt = conn.prepareStatement(sql);
         rs = pstmt.executeQuery();
         
         if(rs.next())
            totalAlbumCount = rs.getInt(1);
         
      }catch(Exception e) {
         e.printStackTrace();
      }finally {
         closeAll();
      }
      return totalAlbumCount;
   }
   
   
   
   public int getAlbumCount(String choice,String search) {
      int totalAlbumCount = 0;
      
      try {
         conn = DBCon.getConnection();
         
         String sql = "select count(*) from Goods where " + choice + " like'%"+ search +"%'";
         pstmt = conn.prepareStatement(sql);
         rs = pstmt.executeQuery();
         
         if(rs.next())
            totalAlbumCount = rs.getInt(1);
         
      }catch(Exception e) {
         e.printStackTrace();
      }finally {
         closeAll();
      }
      return totalAlbumCount;
   }
   
      
   public List getAlbums(int start, int end) {
      List albumList=null;
      try {
         conn = DBCon.getConnection();
         
         String sql;
         sql = "select * from (select goods_code, goods_img, goods_name, goods_price, rownum r from (select * from Goods order by goods_code desc)) where r>=? and r<=?";
         pstmt = conn.prepareStatement(sql);
         pstmt.setInt(1, start);
         pstmt.setInt(2, end);
         rs = pstmt.executeQuery();
         albumList = new ArrayList();
         while(rs.next()) {
            MyShopDTO dto = new MyShopDTO();
            dto.setGoods_code(rs.getInt("goods_code"));
            dto.setGoods_img(rs.getString("goods_img"));
            dto.setGoods_name(rs.getString("goods_name"));
            dto.setGoods_price(rs.getInt("goods_price"));
               
            albumList.add(dto);
            
         }
      }catch(Exception e) { 
         e.printStackTrace();
      }finally {
         closeAll();
      }   
      return albumList;
   }
   
   
   public List getAlbums(int start, int end,String filter) {
      List albumList=null;
      try {
         conn = DBCon.getConnection();
         
         
         if (filter.equals("lowPrice")) {
         String sql;
         sql = "select * from (select goods_code, goods_img, goods_name, goods_price, rownum r from (select * from (select * from Goods order by goods_code desc) order by goods_price asc)) where r>=? and r<=?";
         pstmt = conn.prepareStatement(sql);
         pstmt.setInt(1, start);
         pstmt.setInt(2, end);
         rs = pstmt.executeQuery();
         
         }else {
         String sql;
         sql = "select * from (select goods_code, goods_img, goods_name, goods_price, rownum r from (select * from (select * from Goods order by goods_code desc) order by goods_price desc)) where r>=? and r<=?";
         pstmt = conn.prepareStatement(sql);
         pstmt.setInt(1, start);
         pstmt.setInt(2, end);
         rs = pstmt.executeQuery();   
         }
         
         
         if(rs.next()) {
            albumList = new ArrayList(end);
            do {
               MyShopDTO dto = new MyShopDTO();
               dto.setGoods_code(rs.getInt("goods_code"));
               dto.setGoods_img(rs.getString("goods_img"));
               dto.setGoods_name(rs.getString("goods_name"));
               dto.setGoods_price(rs.getInt("goods_price"));
               
               albumList.add(dto);
            
            }while(rs.next());
         }
      }catch(Exception e) { 
         e.printStackTrace();
      }finally {
         closeAll();
      }   
      return albumList;
   }
   
   
   
   public List getAlbums(int start, int end,String choice,String search) {
      List albumList=null;
      try {
         conn = DBCon.getConnection();
         
         String sql;
         sql = "select * from (select goods_code, goods_img, goods_name, goods_price, rownum r from (select * from Goods where " +choice+ " like'%"+search+"%'order by goods_code desc)) where r>=? and r<=?";
         pstmt = conn.prepareStatement(sql);
         pstmt.setInt(1, start);
         pstmt.setInt(2, end);
         rs = pstmt.executeQuery();
         
         if(rs.next()) {
            albumList = new ArrayList(end);
            do {
               MyShopDTO dto = new MyShopDTO();
               dto.setGoods_code(rs.getInt("goods_code"));
               dto.setGoods_img(rs.getString("goods_img"));
               dto.setGoods_name(rs.getString("goods_name"));
               dto.setGoods_price(rs.getInt("goods_price"));
               
               albumList.add(dto);
            
            }while(rs.next());
         }
      }catch(Exception e) {
         e.printStackTrace();
      }finally {
         closeAll();
      }
      return albumList;
   }   
   

      private void closeAll() {
      if(rs != null) {try {rs.close();}catch(SQLException s) {} }
      if(pstmt != null) {try{pstmt.close();}catch(SQLException s) {} }
      if(conn != null) {try{conn.close();}catch(SQLException s) {} }
   
 }

}