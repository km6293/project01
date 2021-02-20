package myshop.cart;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import myshop.alldb.DBCon;


public class CartDAO {
 	private static CartDAO instance = new CartDAO();
    
    public static CartDAO getInstance() {
        return instance;
    }
    
    private CartDAO() {
    }
    
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs= null;	
	
	
	public void insertCart(CartDTO cart) throws Exception{
		try {
			conn = DBCon.getConnection();
			String sql = "insert into cart values(?,?,?,?,?,?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, cart.getUser_id());
			pstmt.setInt(2, cart.getGoods_code());
			pstmt.setString(3,cart.getGoods_name());
			pstmt.setInt(4, cart.getAmount());
			pstmt.setInt(5, cart.getGoods_price());
			pstmt.setString(6, cart.getGoods_brand());
			
			pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			closeAll();
		}
	}
	
	public int getCartCount(String sessionId) throws Exception{
		int x=0;
		try {
			conn = DBCon.getConnection();
			String sql = "select count(*) from cart where user_id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, sessionId);
			rs = pstmt.executeQuery();
			if (rs.next())
			{
				x= rs.getInt(1);
			}
		}catch(Exception e){
			
		}finally {
			closeAll();
		}
		return x;
	}

	public List getCartList(String sessionId, int start, int end) throws Exception{
		List cartList = null;		
		try {
		    conn = DBCon.getConnection();
		    String sql = "select user_id,goods_code,goods_name,amount,goods_price,goods_brand,r "+
			"from (select user_id,goods_code,goods_name,amount,goods_price,goods_brand,rownum r " +
			"from (select * from cart where user_id=? order by user_id) order by user_id) where r >= ? and r <= ? ";
		    
		        pstmt = conn.prepareStatement(sql);
		        pstmt.setString(1, sessionId);
		        pstmt.setInt(2, start);
		        pstmt.setInt(3, end);
		        rs = pstmt.executeQuery();
		        
		        if(rs.next()) {
				cartList = new ArrayList(end);
				do {
					CartDTO cart = new CartDTO();
					cart.setUser_id(rs.getString("user_id"));
					cart.setGoods_code(rs.getInt("goods_code"));
					cart.setGoods_name(rs.getString("goods_name"));
					cart.setAmount(rs.getInt("amount"));
					cart.setGoods_price(rs.getInt("goods_price"));
					cart.setGoods_brand(rs.getString("goods_brand"));
					
					cartList.add(cart);
					}while(rs.next());
				}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			closeAll();
		}
		return cartList;
	}
	public List getCartList(String sessionId) throws Exception{
		List cartList = null;		
		try {
		    conn = DBCon.getConnection();
		    String sql = "select user_id,goods_code,goods_name,amount,goods_price,goods_brand,r "+
			"from (select user_id,goods_code,goods_name,amount,goods_price,goods_brand,rownum r " +
			"from (select * from cart where user_id=? order by user_id) order by user_id)";
		    
		        pstmt = conn.prepareStatement(sql);
		        pstmt.setString(1, sessionId);

		        rs = pstmt.executeQuery();
		        
		        if(rs.next()) {
				cartList = new ArrayList();
				do {
					CartDTO cart = new CartDTO();
					cart.setUser_id(rs.getString("user_id"));
					cart.setGoods_code(rs.getInt("goods_code"));
					cart.setGoods_name(rs.getString("goods_name"));
					cart.setAmount(rs.getInt("amount"));
					cart.setGoods_price(rs.getInt("goods_price"));
					cart.setGoods_brand(rs.getString("goods_brand"));
					
					cartList.add(cart);
					}while(rs.next());
				}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			closeAll();
		}
		return cartList;
	}
	public void deleteCart(String sessionId, int goods_code) {
		try {
			conn = DBCon.getConnection();
			String sql = "delete from cart where user_id=? and goods_code=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, sessionId);
			pstmt.setInt(2, goods_code);
			pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			closeAll();
		}
	}
	
	
	public int cartCheck(String sessionId, int goods_code) {
		int x = 0;
		try {
			conn = DBCon.getConnection();
			String sql = "select count(*) from cart where user_id=? and goods_code=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, sessionId);
			pstmt.setInt(2, goods_code);
			rs = pstmt.executeQuery();
			if (rs.next()) {
	               x= rs.getInt(1); 
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			closeAll();
		}
		return x;
	}
	public int getDelivery(int goods_code) {
		int delivery=0;
		try {
			conn=DBCon.getConnection();
			String sql = "select goods_delivery from goods where goods_code=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, goods_code);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				delivery = rs.getInt(1);
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally {
			closeAll();
		}
		return delivery;
	}
    private void closeAll() {
		if (rs != null) {
			try { rs.close(); } catch (SQLException s) { }}
		if (pstmt != null) {
			try { pstmt.close(); } catch (SQLException s) { }}
		if (conn != null) {
			try {conn.close(); } catch (SQLException s) { }}
    } 
}
