package myshop.cmu_comment;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import javax.sql.DataSource;
import myshop.alldb.DBCon;

public class CommentDAO {
	private static CommentDAO instance = new CommentDAO();
	public static CommentDAO getInstance() {
		return instance;
	}
	private CommentDAO() {
	}

	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	public void insertCmt(int num, CommentDTO comment) throws Exception{
		try {
			conn = DBCon.getConnection();
			String sql = "insert into cmu_comment(num,cmt_num,cmt_writer,cmt_content,cmt_date,cmt_state) "
					+ "values(?,cmt_seq.nextval,?,?,?,1)";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, num);
            pstmt.setString(2, comment.getCmt_writer());
            pstmt.setString(3, comment.getCmt_content());
            pstmt.setTimestamp(4, comment.getCmt_date());
            pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			closeAll();
		}
	}
	
	public int getCommentCount(int num) throws Exception{
		int x = 0;
		try {
			conn = DBCon.getConnection();
			String sql = "select count(*) from cmu_comment where num=? and cmt_state=1";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				x = rs.getInt(1);
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally {
			closeAll();
		}
		return x;
	}

	public List getComments(int num, int start, int end) throws Exception{
		List commentList = null;
		try {
			conn = DBCon.getConnection();
			String sql = "select num,cmt_num,cmt_writer,cmt_content,cmt_date,cmt_state,r "
					+ "from (select num,cmt_num,cmt_writer,cmt_content,cmt_date,cmt_state,rownum r "
					+ "from (select * from cmu_comment where num=? order by cmt_date) order by cmt_date) where r >= ? and r <= ? ";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.setInt(2, start);
			pstmt.setInt(3, end);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				commentList = new ArrayList(end);
				do {
					CommentDTO comment = new CommentDTO();
					comment.setNum(num);
					comment.setCmt_num(rs.getInt("cmt_num"));
					comment.setCmt_writer(rs.getString("cmt_writer"));
					comment.setCmt_content(rs.getString("cmt_content"));
					comment.setCmt_date(rs.getTimestamp("cmt_date"));
					comment.setCmt_state(rs.getInt("cmt_state"));
					
					commentList.add(comment);
					
				}while(rs.next());
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			closeAll();
		}
		return commentList;
	}
	   public void deleteComment(int cmt_num) throws Exception {
	        try {
				conn = DBCon.getConnection();
				String sql = "update cmu_comment set cmt_state=0 where cmt_num=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, cmt_num);
				pstmt.executeUpdate();
			}catch(Exception e) {
				e.printStackTrace();
			}finally {
				closeAll();
			}
		}   
	   
	    public int getDelCount(int num) throws Exception {
	    	int x = 0;
	    	try {
	    		conn = DBCon.getConnection();
	    		String sql = "select count(*) from cmu_comment where cmt_state=0 and num=?";
	    		pstmt = conn.prepareStatement(sql);
	    		pstmt.setInt(1, num);
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
	    
	private void closeAll() {
		if (rs != null) {try {rs.close();}catch(SQLException s) {}}
		if (pstmt != null) {try {pstmt.close();}catch(SQLException s) {}}
		if (conn != null) {try {conn.close();}catch(SQLException s) {}}
	}
}
