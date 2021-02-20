package myshop.goods;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import myshop.alldb.DBCon;


public class GoodsDAO {

	private Connection conn = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;

	private static final GoodsDAO instance = new GoodsDAO();

	public static GoodsDAO getInstance() {
		return instance;
	}

	private GoodsDAO() {}

	public int getGoodsCount() {
		int goodscount = 0;

		try {
			conn = DBCon.getConnection();

			String sql = "select count(*) from Goods";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();

			if(rs.next())
				goodscount = rs.getInt(1);

		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			closeAll();
		}
		return goodscount;
	}

	public void insertGoods(GoodsDTO dto) {
	      try {
	         conn =DBCon.getConnection();

	         String sql = "insert into Goods values(goods_seq.nextval, ?, ?, ?, ?, ?, ?, ?, ?, ?,?)";
	         
	         pstmt = conn.prepareStatement(sql);
	         pstmt.setString(1, dto.getGoods_brand());
	         pstmt.setString(2, dto.getGoods_name());
	         pstmt.setInt(3, dto.getGoods_price());
	         pstmt.setInt(4, dto.getGoods_delivery());
	         pstmt.setInt(5, dto.getGoods_state());
	         pstmt.setString(6, dto.getGoods_option());
	         pstmt.setString(7, dto.getGoods_img());
	         pstmt.setString(8, dto.getGoods_msg());
	         pstmt.setInt(9, dto.getGoods_count());
	         pstmt.setInt(10, 0);
	         pstmt.executeUpdate();

	      } catch (Exception ex) {
	         ex.printStackTrace();
	      } finally {
	         closeAll();
	      }
	   }


	public List getGoodsList(int start, int end) {
		List goodsList=null;
		try {
			conn = DBCon.getConnection();

			String sql = "select goods_code, goods_img, goods_name, goods_price, rownum ";
			sql+= "from (select * from Goods order by goods_code desc) ";
			sql+= "where rownum >= ? and rownum <= ?";

			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, start);
			pstmt.setInt(2, end);
			rs = pstmt.executeQuery();

			if(rs.next()) {
				goodsList = new ArrayList(end);
				do {
					GoodsDTO dto = new GoodsDTO();

					dto.setGoods_code(rs.getInt("goods_code"));
					dto.setGoods_img(rs.getString("goods_img"));
					dto.setGoods_name(rs.getString("goods_name"));
					dto.setGoods_price(rs.getInt("goods_price"));

					goodsList.add(dto);

				}while(rs.next());
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			closeAll();
		}	
		return goodsList;
	}


	public GoodsDTO goodsDetail(int code) { //
		GoodsDTO dto = null;
		try {
			conn = DBCon.getConnection();

			String sql = "select * from goods where Goods_code = ?";

			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, code);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				dto = new GoodsDTO();
				dto.setGoods_code(rs.getInt("goods_code"));
				dto.setGoods_brand(rs.getString("goods_brand"));
				dto.setGoods_name(rs.getString("goods_name"));
				dto.setGoods_price(rs.getInt("goods_price"));
				dto.setGoods_delivery(rs.getInt("goods_delivery"));
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

	public String code2name(int code) throws Exception {
		String goods_name = null;
		try
		{
			String sql = "select goods_name from Goods where goods_code = ?";
			DBCon dbConn = new DBCon();
			conn = dbConn.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, code);
			rs = pstmt.executeQuery();
			goods_name = rs.getString(1);
		}
		catch (Exception ex) 
		{
			ex.printStackTrace();
		}
		finally
		{
			closeAll();
		}

		return goods_name;
	}

	public String code2brand(int code) throws Exception {
		String goods_brand = null;
		try
		{
			String sql = "select goods_brand from goods where goods_code = ?";
			DBCon dbConn = new DBCon();
			conn = dbConn.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, code);
			rs = pstmt.executeQuery();
			goods_brand = rs.getString(1);
		}
		catch (Exception ex) 
		{
			ex.printStackTrace();
		}
		finally
		{
			closeAll();
		}

		return goods_brand;
	}

	public int myGoodsCount(String goods_brand) {
		int x = 0;
		try
		{
			String sql = "select count(*) from goods where goods_brand = ?";
			DBCon dbConn = new DBCon();
			conn = dbConn.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, goods_brand);
			rs = pstmt.executeQuery();
			if(rs.next()) {
					x=rs.getInt(1);
			}
		}
		catch (Exception ex) 
		{
			ex.printStackTrace();
		}
		finally
		{
			closeAll();
		}

		return x;
	}
	
	public List myGoods(String goods_brand) {
		List list = null;
		try {
			int x=myGoodsCount(goods_brand); 
			if(x>0) {
				list = new ArrayList();
				String sql = "select goods_code from goods where goods_brand = ?";
				conn = DBCon.getConnection();
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, goods_brand);
				rs = pstmt.executeQuery();
				while(rs.next()) {
					list.add(rs.getInt(1));
				}
			}
		}
		catch (Exception ex) 
		{
			ex.printStackTrace();
		}
		finally
		{
			closeAll();
		}

		return list;
	}

	public GoodsDTO updateGetAlbum(int code) {
	      GoodsDTO gdto = null;   
	         try {
	            String sql = "select * from Goods where goods_code =?";
	            DBCon dbConn = new DBCon();
	            conn = dbConn.getConnection();
	              pstmt = conn.prepareStatement(sql);
	              pstmt.setInt(1, code);
	              rs = pstmt.executeQuery();
	              
	              if(rs.next()) {
	                 gdto = new GoodsDTO();
	    
	               gdto.setGoods_code(rs.getInt("goods_code"));
	               gdto.setGoods_brand(rs.getString("goods_brand"));
	               gdto.setGoods_name(rs.getString("goods_name"));
	               gdto.setGoods_price(rs.getInt("goods_price"));
	               gdto.setGoods_delivery(rs.getInt("goods_delivery"));
	               gdto.setGoods_state(rs.getInt("goods_state"));
	               gdto.setGoods_option(rs.getString("goods_option"));
	               gdto.setGoods_img(rs.getString("goods_img"));
	               gdto.setGoods_msg(rs.getString("goods_msg"));
	               gdto.setGoods_count(rs.getInt("goods_count"));
	               
	                 
	              }
	         }catch (Exception ex) 
	         {
	            ex.printStackTrace();
	         }
	         finally
	         {
	            closeAll();
	         }
	         return gdto;
	   }

	  
	public GoodsDTO albumUpdate(GoodsDTO dto) {
		try {
			conn = DBCon.getConnection();
			String sql = "update Goods set goods_name=?,goods_img=?,goods_price=?,goods_count=?,goods_option=?,goods_delivery=?,goods_msg=? where goods_code=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getGoods_name());
			pstmt.setString(2, dto.getGoods_img());
			pstmt.setInt(3, dto.getGoods_price());
			pstmt.setInt(4, dto.getGoods_count());
			pstmt.setString(5, dto.getGoods_option());
			pstmt.setInt(6, dto.getGoods_delivery());
			pstmt.setString(7, dto.getGoods_msg());
			pstmt.setInt(8, dto.getGoods_code());
			rs = pstmt.executeQuery();
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			closeAll();
		}
		return dto;
	}
	private void closeAll() {
		if(rs != null) {try {rs.close();}catch(SQLException s) {} }
		if(pstmt != null) {try{pstmt.close();}catch(SQLException s) {} }
		if(conn != null) {try{conn.close();}catch(SQLException s) {} }
	}

}
