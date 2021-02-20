package myshop.goods;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import myshop.alldb.DBCon;


public class StoreDAO {
	
	private static StoreDAO instance = new StoreDAO();
	private StoreDAO() {}
	
	public static StoreDAO getInstance() { return instance; }
	
	private Connection conn = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
 
	public StoreDTO detailProduct(int code,String goods_brand) {
		StoreDTO dto = null;
		try {
			conn = DBCon.getConnection();
			String sql = "select * from (select * from Goods where goods_code = ?) where goods_brand =? ";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, code);
			pstmt.setString(2, goods_brand);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				dto = new StoreDTO();
				dto.setGoods_code(rs.getInt("goods_code"));
				dto.setGoods_brand(rs.getString("goods_brand"));
				dto.setGoods_name(rs.getString("goods_name"));
				dto.setGoods_price(rs.getInt("goods_price"));
				dto.setGoods_delivery(rs.getInt("goods_delivery"));
				dto.setGoods_state(rs.getInt("goods_state"));
				dto.setGoods_option(rs.getString("option"));
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
	
	
	public int getAlbumCount(String goods_brand) {
		int totalAlbumCount = 0;
		
		try {
			conn = DBCon.getConnection();
			
			String sql = "select count(*) from goods where goods_brand=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, goods_brand);
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
	
	
	public int getAlbumCount(String goods_brand, String choice,String search) {
		int totalAlbumCount = 0;
		
		try {
			conn = DBCon.getConnection();
			
			String sql = "select count(*) from (select count(*) from goods where " + choice + " like'%"+ search +"%') where goods_brand =?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, goods_brand);
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
	
		
	public List getAlbums(String goods_brand, int start, int end) {
		List albumList=null;
		try {
			conn = DBCon.getConnection();
			
			String sql;
			sql = "select goods_code, goods_img, goods_name, goods_price,goods_count, goods_amount, rownum from (select * from (select * from Goods order by goods_code desc) where goods_brand =?) where rownum>=? and rownum<=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, goods_brand);
			pstmt.setInt(2, start);
			pstmt.setInt(3, end);
			rs = pstmt.executeQuery();
			albumList = new ArrayList();
			while(rs.next()) {
				
				
					StoreDTO dto = new StoreDTO();
					dto.setGoods_code(rs.getInt("goods_code"));
					dto.setGoods_img(rs.getString("goods_img"));
					dto.setGoods_name(rs.getString("goods_name"));
					dto.setGoods_price(rs.getInt("goods_price"));
					dto.setGoods_count(rs.getInt("goods_count"));
					dto.setGoods_amount(rs.getInt("goods_amount"));
					albumList.add(dto);
				
				
			}
		}catch(Exception e) { 
			e.printStackTrace();
		}finally {
			closeAll();
		}	
		return albumList;
	}
	
	
	public List getAlbums(int start, int end,String goods_brand, String choice,String search) {//¼öÁ¤
		List albumList=null;
		try {
			conn = DBCon.getConnection();
			
			String sql;
			sql = "select goods_code, goods_img, goods_name, goods_price, goods_count, goods_amount, rownum from select * from (select * from Goods where " +choice+ " like'%"+search+"%'order by goods_brand desc) where goods_code =? ) where rownum>=? and rownum<=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, start);
			pstmt.setInt(2, end);
			pstmt.setString(3, goods_brand);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				albumList = new ArrayList(end);
				do {
					StoreDTO dto = new StoreDTO();
					dto.setGoods_code(rs.getInt("goods_code"));
					dto.setGoods_img(rs.getString("goods_img"));
					dto.setGoods_name(rs.getString("goods_name"));
					dto.setGoods_price(rs.getInt("goods_price"));
					dto.setGoods_count(rs.getInt("goods_count"));
					dto.setGoods_amount(rs.getInt("goods_amount"));
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
	
	public int sumAmount(int goods_code) {
		int a=0;
		try {
			conn = DBCon.getConnection();
		    pstmt = conn.prepareStatement("select goods_amount from goods where goods_code=?");
		    pstmt.setInt(1, goods_code);
		    rs = pstmt.executeQuery();
		    if (rs.next()) {
		        a= rs.getInt(1);
			}
		} catch(Exception ex) {
		     ex.printStackTrace();
		} finally {
			 closeAll();
		}
		return a;
	}
   
   
	public void updateAmount(int sum,int goods_code) {
		try {
			conn = DBCon.getConnection();
			String sql ="update Goods set Goods_amount=? where goods_code=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, sum);
			pstmt.setInt(2, goods_code);
			rs = pstmt.executeQuery();
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			closeAll();
		}
	}

	public void updateCount(int sum,int goods_code) {
		try {
			conn = DBCon.getConnection();
			String sql ="update Goods set Goods_count=Goods_count-? where goods_code=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, sum);
			pstmt.setInt(2, goods_code);
			rs = pstmt.executeQuery();
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			closeAll();
		}
	}
	
		private void closeAll() {
		if(rs != null) {try {rs.close();}catch(SQLException s) {} }
		if(pstmt != null) {try{pstmt.close();}catch(SQLException s) {} }
		if(conn != null) {try{conn.close();}catch(SQLException s) {} }
	
 }

}
