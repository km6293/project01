package myshop.cmu_comment;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import myshop.alldb.DBCon;
import myshop.community.CommunityDTO;

public class CommunityDAO {
	private static CommunityDAO instance = new CommunityDAO();
	public static CommunityDAO getInstance() {
		return instance;
	}
	private CommunityDAO() {
	}
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	public int getCommuCount() throws Exception {
		int x = 0;

		try {
			conn = DBCon.getConnection();
			pstmt = conn.prepareStatement("select count(*) from community where state=1");
			rs = pstmt.executeQuery();

			if (rs.next()) {
				x = rs.getInt(1);
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally{
			closeAll();
		}
		return x;
	}
	
	public List getCommues(int start, int end) throws Exception{
		List commuList = null;
		try {
			conn = DBCon.getConnection();
			String sql = "select num,writer,subject,content,passwd,reg_date,readcount,state,r "+
					"from (select num,writer,subject,content,passwd,reg_date,readcount,state,rownum r " +
					"from (select * " + "from community order by reg_date desc) order by reg_date desc) where r >= ? and r <= ? ";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, start);
			pstmt.setInt(2, end);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				commuList = new ArrayList(end);
				do{
	                  CommunityDTO cm = new CommunityDTO();
	                  cm.setNum(rs.getInt("num"));
	                  cm.setWriter(rs.getString("writer"));
	                  cm.setSubject(rs.getString("subject"));
	                  cm.setContent(rs.getString("content"));
	                  cm.setPasswd(rs.getString("passwd"));
	                  cm.setReg_date(rs.getTimestamp("reg_date"));
	                  cm.setReadcount(rs.getInt("readcount"));		
	                  cm.setState(rs.getInt("state"));
	                  commuList.add(cm);
				    }while(rs.next()); 
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			closeAll();
		}
		return commuList;
	}		  
	
    public void insertCommu(CommunityDTO community) throws Exception { 
		int number=0; 
       
        try {
            conn = DBCon.getConnection();
            pstmt = conn.prepareStatement("select max(num) from community"); 
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
		      number = rs.getInt(1)+1;
			} else {
		      number = 1;
			}
			String sql = "insert into community(num,writer,subject,content,passwd,reg_date,readcount,state) "
					+ "values(notice_seq.nextval,?,?,?,?,?,?,1)";

            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, community.getWriter());
            pstmt.setString(2, community.getSubject());
            pstmt.setString(3, community.getContent());
			pstmt.setString(4, community.getPasswd());
			pstmt.setTimestamp(5, community.getReg_date());
			pstmt.setInt(6, community.getReadcount());
            pstmt.executeUpdate();
        }catch(Exception e) {
        	e.printStackTrace();
        }finally {
        	closeAll();
        }
    }
    
    public CommunityDTO getCommu(int num) throws Exception{
    	CommunityDTO cm = null;
    	try {
    		conn = DBCon.getConnection();
    		String sql = "update community set readcount = readcount+1 where num=?";
    		pstmt = conn.prepareStatement(sql);
    		pstmt.setInt(1, num);
    		pstmt.executeUpdate();
    		
    		sql = "select * from community where num=?";
    		pstmt = conn.prepareStatement(sql);
    		pstmt.setInt(1,num);
    		rs = pstmt.executeQuery();
    		
    		if(rs.next()) {
    			cm = new CommunityDTO();
    			cm.setNum(rs.getInt("num"));
    			cm.setWriter(rs.getString("writer"));
                cm.setSubject(rs.getString("subject"));
                cm.setContent(rs.getString("content"));
                cm.setPasswd(rs.getString("passwd"));
                cm.setReg_date(rs.getTimestamp("reg_date"));
                cm.setReadcount(rs.getInt("readcount"));		
                cm.setState(rs.getInt("state"));
    		}
    	}catch(Exception e) {
    		e.printStackTrace();
    	}finally {
    		closeAll();
    	}
    	return cm;
    }
    
    public CommunityDTO updateGetCommu(int num) {
    	CommunityDTO cm = null;
    	try {
    		conn = DBCon.getConnection();
    		String sql = "select * from community where num=?";
    		pstmt = conn.prepareStatement(sql);
    		pstmt.setInt(1,num);
    		rs = pstmt.executeQuery();
    		if(rs.next()) {
    			cm = new CommunityDTO();
    			cm.setNum(rs.getInt("num"));
    			cm.setWriter(rs.getString("writer"));
                cm.setSubject(rs.getString("subject"));
                cm.setContent(rs.getString("content"));
                cm.setPasswd(rs.getString("passwd"));
                cm.setReg_date(rs.getTimestamp("reg_date"));
                cm.setReadcount(rs.getInt("readcount"));		
                cm.setState(rs.getInt("state"));    			
    		}
    	}catch(Exception e) {
    		e.printStackTrace();
    	}finally {
    		closeAll();
    	}
    	return cm;
    }
    public int updateCommu(CommunityDTO cm) throws Exception{
    	String dbpasswd = "";
    	int x = -1;
    	try {
    		conn = DBCon.getConnection();
    		String sql = "select passwd from community where num=?";
    		pstmt = conn.prepareStatement(sql);
    		pstmt.setInt(1, cm.getNum());
    		rs = pstmt.executeQuery();
    		
    		if(rs.next()) {
    			dbpasswd = rs.getString("passwd");
    			if(dbpasswd.equals(cm.getPasswd())) {
    				sql = "update community set writer=?, subject=?, passwd=?, content=? where num=?";
    				pstmt = conn.prepareStatement(sql);
    				pstmt.setString(1, cm.getWriter());
    				pstmt.setString(2, cm.getSubject());
    				pstmt.setString(3, cm.getPasswd());
    				pstmt.setString(4, cm.getContent());
    				pstmt.setInt(5, cm.getNum());
    				pstmt.executeUpdate();
    				x = 1;
    			}else {
    				x = 0;
    			}
    		}
    	}catch(Exception e) {
    		e.printStackTrace();
    	}finally {
    		closeAll();
    	}
    	return x;
    }
    public int getDelCount() throws Exception {
    	int x = 0;
    	try {
    		conn = DBCon.getConnection();
    		String sql = "select count(*) from community where state=0";
    		pstmt = conn.prepareStatement(sql);
    		rs = pstmt.executeQuery();
    		if(rs.next()){
    			x = rs.getInt(1);
    		}
    	}catch(Exception e) {
    		e.printStackTrace();
    	}finally {
    		closeAll();
    	}
    	return x;
    }
    

    public void deleteCommu(int num) throws Exception {
        try {
			conn = DBCon.getConnection();
			String sql = "update community set state=0 where num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1,num);
			pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			closeAll();
		}
	}    
    
    public String getRating(String user_id) throws Exception {
    	String rating = "";
    	try {
    		conn = DBCon.getConnection();
			String sql = "select rating from shopUser where user_id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1,user_id);
			rs = pstmt.executeQuery();
    		if(rs.next()){
    			rating = rs.getString("rating");		
    		}
    	}catch(Exception e) {
    		
    	}finally {
    		closeAll();
    	}
    	return rating;
    }
	private void closeAll() {
		if (rs != null) {try {rs.close();}catch(SQLException s) {}}
		if (pstmt != null) {try {pstmt.close();}catch(SQLException s) {}}
		if (conn != null) {try {conn.close();}catch(SQLException s) {}}
	}
}


