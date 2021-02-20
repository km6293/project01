package myshop.shopuser;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import myshop.alldb.DBCon;

public class UserDAO {

	private static UserDAO instance = new UserDAO();
	public static UserDAO getInstance() {
		return instance;
	}

	private Connection conn = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	

	public ArrayList selectAll() { //모든회원 조회
		ArrayList list = new ArrayList();	
		try {
			conn = DBCon.getConnection();
			pstmt = conn.prepareStatement("select * from shopUser");
			rs = pstmt.executeQuery();
			while(rs.next()) {
				UserDTO dto = new UserDTO();
				dto.setJoin(rs.getInt("join"));
				dto.setRating(rs.getString("rating"));
				dto.setUser_id(rs.getString("user_id"));
				dto.setUser_pw(rs.getString("user_pw"));
				dto.setUser_name(rs.getString("user_name"));
				dto.setUser_phone(rs.getString("user_phone"));
				dto.setUser_address(rs.getString("user_address"));
				dto.setUser_date(rs.getTimestamp("user_date"));
				dto.setUser_cash(rs.getString("user_cash"));
				dto.setUser_cash(rs.getString("business_num"));
				dto.setUser_cash(rs.getString("bank_num"));
				list.add(dto);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	public UserDTO usersselect(String rating, String user_id) { //판매자 회원 정보 찾기
		UserDTO dto = new UserDTO();
		try {
			conn = DBCon.getConnection();
			pstmt = conn.prepareStatement("select * from shopUser where rating=? and user_id=? and join ='1'");
			 pstmt.setString(1, rating);
			 pstmt.setString(2, user_id);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				dto.setJoin(rs.getInt("join"));
				dto.setRating(rs.getString("rating"));
				dto.setUser_id(rs.getString("user_id"));
				dto.setUser_pw(rs.getString("user_pw"));
				dto.setUser_name(rs.getString("user_name"));
				dto.setUser_phone(rs.getString("user_phone"));
				dto.setUser_address(rs.getString("user_address"));
				dto.setUser_date(rs.getTimestamp("user_date"));
				dto.setUser_cash(rs.getString("user_cash"));
				dto.setUser_cash(rs.getString("business_num"));
				dto.setUser_cash(rs.getString("bank_num"));
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			closeAll();
		}
		return dto;
	}
	public int getcompany() {//판매자(회사) 수
		int getcompany = 0;
		
		try {
			conn = DBCon.getConnection();
			
			String sql = "select count(*) from shopUser where rating='2' and join ='1'";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if(rs.next())
				getcompany = rs.getInt(1);
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			closeAll();
		}
		return getcompany;
	}
	public ArrayList selectcompany() { //회사 조회
		ArrayList list = new ArrayList();	
		try {
			conn = DBCon.getConnection();
			pstmt = conn.prepareStatement("select * from shopUser where rating='2' and join ='1'");
			rs = pstmt.executeQuery();
			while(rs.next()) {
				UserDTO dto = new UserDTO();
				dto.setJoin(rs.getInt("join"));
				dto.setRating(rs.getString("rating"));
				dto.setUser_id(rs.getString("user_id"));
				dto.setUser_pw(rs.getString("user_pw"));
				dto.setUser_name(rs.getString("user_name"));
				dto.setUser_phone(rs.getString("user_phone"));
				dto.setUser_address(rs.getString("user_address"));
				dto.setUser_date(rs.getTimestamp("user_date"));
				dto.setUser_cash(rs.getString("user_cash"));
				dto.setUser_cash(rs.getString("business_num"));
				dto.setUser_cash(rs.getString("bank_num"));
				list.add(dto);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			closeAll();
		}
		return list;
	}
	public void insert(UserDTO dto) {
	      try {
	         conn = DBCon.getConnection();
	         String sql = "insert into shopUser values(?,?,?,?,?,?,?,sysdate,?,?,?,?,?,?)";
	         pstmt = conn.prepareStatement(sql);
	         pstmt.setInt(1, dto.getJoin());
	         pstmt.setString(2, dto.getRating());
	         pstmt.setString(3, dto.getUser_id());
	         pstmt.setString(4, dto.getUser_pw());
	         pstmt.setString(5, dto.getUser_name());
	         pstmt.setString(6, dto.getUser_phone());
	         pstmt.setString(7, dto.getUser_address());
	         pstmt.setString(8, dto.getUser_cash());
	         pstmt.setString(9, dto.getBusiness_num());
	         pstmt.setString(10, dto.getBank_num());
	         pstmt.setString(11, dto.getUser_birthday());
	         pstmt.setString(12, dto.getUser_gender());
	         pstmt.setString(13, dto.getUser_email());
	         pstmt.executeUpdate();
	      }catch(Exception e) {
	         e.printStackTrace();
	      }finally {
				closeAll();
		}
	   }
	
	public boolean loginCheck(UserDTO dto) {
		boolean result = false;
		try {
			conn = DBCon.getConnection();
			String sql = "select * from shopUser where user_id=? and user_pw=? and join=1";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getUser_id());
			pstmt.setString(2, dto.getUser_pw());
			rs = pstmt.executeQuery();
			if(rs.next()) {
				result = true;
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			closeAll();
		}
		return result;
	}
	   public int waitingSellerCount() {// Ǹ   (ȸ  )   
		      int x = 0;
		      
		      try {
		         conn = DBCon.getConnection();
		         
		         String sql = "select count(*) from shopUser where rating='3' and join ='0'";
		         pstmt = conn.prepareStatement(sql);
		         rs = pstmt.executeQuery();
		         
		         if(rs.next()) {
		            x = rs.getInt(1);
		         }
		      }catch(Exception e) {
		         e.printStackTrace();
		      }finally {
		         closeAll();
		      }
		      return x;
		   }
		   
		   public void authorizeSeller(String user_id) {
		      try{
		         conn = DBCon.getConnection();
		         pstmt = conn.prepareStatement("update shopuser set join = '1', rating = '2' where user_id = ?");
		         pstmt.setString(1, user_id);
		         pstmt.executeUpdate();
		      }catch(Exception e) {
		         e.printStackTrace();
		      }finally {
		         closeAll();
		      }
		   }   
		   
		   public ArrayList waitingSeller() { //ȸ     ȸ
		      ArrayList list = new ArrayList();   
		      try {
		         conn = DBCon.getConnection();
		         pstmt = conn.prepareStatement("select * from shopUser where rating='3' and join ='0'");
		         rs = pstmt.executeQuery();
		         while(rs.next()) {
		            UserDTO dto = new UserDTO();
		            dto.setJoin(rs.getInt("join"));
		            dto.setRating(rs.getString("rating"));
		            dto.setUser_id(rs.getString("user_id"));
		            dto.setUser_pw(rs.getString("user_pw"));
		            dto.setUser_name(rs.getString("user_name"));
		            dto.setUser_phone(rs.getString("user_phone"));
		            dto.setUser_address(rs.getString("user_address"));
		            dto.setUser_date(rs.getTimestamp("user_date"));
		            dto.setUser_cash(rs.getString("user_cash"));
		            dto.setUser_cash(rs.getString("business_num"));
		            dto.setUser_cash(rs.getString("bank_num"));
		            list.add(dto);
		         }
		      }catch(Exception e) {
		         e.printStackTrace();
		      }finally {
		         closeAll();
		      }
		      return list;
		   }
		   
	public String searchId(String user_name, String user_phone){ 
		String sId=null; 
		try {
			conn = DBCon.getConnection();  
			String sql="select user_id from shopUser where user_name=? and user_phone=?";
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, user_name);
			pstmt.setString(2, user_phone);
			rs = pstmt.executeQuery();
				while(rs.next()){ 
					sId=rs.getString("user_id");
				}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			closeAll();
		}
		return sId;
	}	
	
	public String searchPw(String user_id, String user_name, String user_phone){  
		String sPw=null; 
		try {
			conn = DBCon.getConnection();  
			String sql="select user_pw from shopUser where user_id=? and user_name=? and user_phone=?";
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, user_id);
			pstmt.setString(2, user_name);
			pstmt.setString(3, user_phone);
			rs = pstmt.executeQuery();
				while(rs.next()){ 
					sPw=rs.getString("user_pw");
				}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			closeAll();
		}
		return sPw;
	}	
			
	public UserDTO myInfo(String session_id) {
		UserDTO dto = new UserDTO();
		try {
			conn = DBCon.getConnection();
			String sql = "select * from shopUser where user_id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, session_id);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				dto.setJoin(rs.getInt("join"));
				dto.setRating(rs.getString("rating"));
				dto.setUser_id(rs.getString("user_id"));
				dto.setUser_pw(rs.getString("user_pw"));
				dto.setUser_name(rs.getString("user_name"));
				dto.setUser_phone(rs.getString("user_phone"));
				dto.setUser_address(rs.getString("user_address"));
				dto.setUser_date(rs.getTimestamp("user_date"));
				dto.setUser_cash(rs.getString("user_cash"));
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			closeAll();
		}
		return dto;
	}
	
	public boolean userselId(String user_id) {
		boolean result = false;
		try {
			conn = DBCon.getConnection();
			String sql = "select * from shopUser where user_id=?";
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, user_id);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				result = true;
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			closeAll();
		}
		return result;
	}
	

	public void update(UserDTO dto) {
		try {
			conn = DBCon.getConnection();
			String sql = "update shopUser set user_pw=? , user_name=? , user_phone=? , user_address=? where user_id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getUser_pw());
			pstmt.setString(2, dto.getUser_name());
			pstmt.setString(3, dto.getUser_phone());
			pstmt.setString(4, dto.getUser_address());
			pstmt.setString(5, dto.getUser_id());
			pstmt.executeQuery();
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			closeAll();
		}
	}
				
	public void userDelete(String user_id) {
		try {
			conn = DBCon.getConnection();
			String sql = "update shopUser set join=0 where user_id=?";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, user_id);
			pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			closeAll();
		}
	}
	
	private void closeAll() {
		if(rs != null) {try {rs.close();}catch(SQLException s) {}}
		if(pstmt != null) {try {pstmt.close();}catch(SQLException s) {}}
		if(conn != null) {try {conn.close();}catch(SQLException s) {}}
	}
	
	public void cashUpdate(UserDTO dto) {
		try {
			conn = DBCon.getConnection();
			String sql = "update shopUser set user_cash=? where user_id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getUser_cash());
			pstmt.setString(2, dto.getUser_id());
			pstmt.executeQuery();
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			closeAll();
		}
	}
	
}

