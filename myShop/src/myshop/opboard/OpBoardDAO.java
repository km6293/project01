package myshop.opboard;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import myshop.alldb.DBCon;

public class OpBoardDAO {
	private Connection conn = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	
	private static final OpBoardDAO instance = new OpBoardDAO();
    
    public static OpBoardDAO getInstance() {
        return instance;
    }
    
    private OpBoardDAO() {}
	
    public ArrayList selectInquiry(int start, int end) { //답변안한 문의 조회
		ArrayList list = new ArrayList();	
		try {
			conn = DBCon.getConnection();
			pstmt = conn.prepareStatement("select op_idx,op_id,op_phone, op_title, op_content, op_ip, op_email, op_answer,r\r\n" + 
					" from (select op_idx,op_id,op_phone, op_title, op_content, op_ip, op_email, op_answer, rownum r\r\n" + 
					" from OpBoard where op_answer=1 order by op_idx asc) OpBoard where r>=? and r<=?");
			pstmt.setInt(1, start);
			pstmt.setInt(2, end);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				OpBoardDTO dto = new OpBoardDTO();
				dto.setOp_idx(rs.getInt("op_idx"));
				dto.setOp_id(rs.getString("op_id"));
				dto.setOp_phone(rs.getString("op_phone"));
				dto.setOp_title(rs.getString("op_title"));
				dto.setOp_content(rs.getString("op_content"));
				dto.setOp_ip(rs.getString("op_ip"));
				dto.setOp_email(rs.getString("op_email"));
				dto.setOp_answer(rs.getString("op_answer"));
				list.add(dto);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			closeAll();
		}
		return list;
	}
    
    public ArrayList userselect(int start, int end) { //회원이 자신조회
		ArrayList list = new ArrayList();	
		try {
			conn = DBCon.getConnection();
			pstmt = conn.prepareStatement("select * from OpBoard where op_answer='1'and rownum>=? and rownum<=?");
			pstmt.setInt(1, start);
			pstmt.setInt(2, end);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				OpBoardDTO dto = new OpBoardDTO();
				dto.setOp_idx(rs.getInt("op_idx"));
				dto.setOp_id(rs.getString("op_id"));
				dto.setOp_phone(rs.getString("op_phone"));
				dto.setOp_title(rs.getString("Op_title"));
				dto.setOp_content(rs.getString("Op_content"));
				dto.setOp_ip(rs.getString("Op_ip"));
				dto.setOp_email(rs.getString("Op_email"));
				dto.setOp_answer(rs.getString("Op_answer"));
				list.add(dto);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return list;
	}
    
	public int getInquiry() {//답변안한 문의 개수
		int getcompany = 0;
		
		try {
			conn = DBCon.getConnection();
			
			String sql = "select count(*) from OpBoard where op_answer='1'";
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
	public void insertOpBoard(OpBoardDTO dto) { //운영자 문의 추가
		try {
			conn = DBCon.getConnection();
			String sql = "insert into OpBoard values(OpBoard_seq.nextval,?,?,?,?,?,?,?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getOp_id());
			pstmt.setString(2, dto.getOp_phone());
			pstmt.setString(3, dto.getOp_title());
			pstmt.setString(4, dto.getOp_content());
			pstmt.setString(5, dto.getOp_ip());
			pstmt.setString(6, dto.getOp_email());
			pstmt.setString(7, dto.getOp_answer());
			pstmt.executeUpdate();
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			closeAll();
		}
	}
		
	public OpBoardDTO getNotice(int op_idx)
		throws Exception{
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			OpBoardDTO Notice=null;
			try {
				conn = DBCon.getConnection();
				pstmt = conn.prepareStatement(
						"select * from OpBoard where op_idx = ?");
				pstmt.setInt(1, op_idx);
				rs = pstmt.executeQuery();
				
				if(rs.next()) {
					Notice = new OpBoardDTO();
					Notice.setOp_idx(rs.getInt("op_idx"));
					Notice.setOp_id(rs.getString("op_id"));
					Notice.setOp_title(rs.getString("op_title"));
					Notice.setOp_content(rs.getString("op_content"));
					Notice.setOp_email(rs.getString("op_email"));
					Notice.setOp_answer(rs.getString("op_answer"));
				}
			}catch(Exception ex) {
				ex.printStackTrace();
			} finally {
				closeAll();
			}
			return Notice;
		}
	
	public void answerUpdate(int idx) {
		
		try {
			conn = DBCon.getConnection();
			String sql = "update OpBoard set op_answer=0 where op_idx=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, idx);
			pstmt.executeUpdate();
		}catch(Exception ex) {
			ex.printStackTrace();
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
