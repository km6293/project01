package myshop.notice;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import myshop.alldb.DBCon;

public class NoticeDAO {
	private static NoticeDAO instance = new NoticeDAO();

	public static NoticeDAO getInstance() {
		return instance;
	}
	private NoticeDAO() {
	}

	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;

    public void insertNotice(NoticeDTO notice) throws Exception { 
       
        try {
            conn = DBCon.getConnection();
			String sql = "insert into notice(noti_num,noti_writer,noti_subject,noti_date,noti_file,noti_content,noti_readcount) "
					+ "values(notice_seq.nextval,?,?,?,?,?,?)";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, notice.getNoti_writer());
            pstmt.setString(2, notice.getNoti_subject());
			pstmt.setTimestamp(3, notice.getNoti_date());
			pstmt.setString(4, notice.getNoti_file());
			pstmt.setString(5, notice.getNoti_content());
			pstmt.setInt(6, notice.getNoti_readcount());
            pstmt.executeUpdate();
        }catch(Exception e) {
        	e.printStackTrace();
        }finally {
        	closeAll();
        }
    }
		   
	public int getNoticeCount() throws Exception {
		int x = 0;

		try {
			conn = DBCon.getConnection();
			pstmt = conn.prepareStatement("select count(*) from notice");
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
	public List getNotices(int start, int end) throws Exception{
		List noticeList = null;
		try {
			conn = DBCon.getConnection();
			String sql = "select noti_num,noti_writer,noti_subject,noti_file,noti_content,noti_passwd,noti_date,noti_readcount,r "
					+ "from (select noti_num,noti_writer,noti_subject,noti_file,noti_content,noti_passwd,noti_date,noti_readcount,rownum r "
					+ "from (select * "
					+ "from notice order by noti_date desc) order by noti_date desc ) where r >= ? and r <= ? ";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, start);
			pstmt.setInt(2, end);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				noticeList = new ArrayList(end);
				do {
					NoticeDTO notice = new NoticeDTO();
					notice.setNoti_num(rs.getInt("noti_num"));
					notice.setNoti_writer(rs.getString("noti_writer"));
					notice.setNoti_subject(rs.getString("noti_subject"));
					notice.setNoti_file(rs.getString("noti_file"));
					notice.setNoti_content(rs.getString("noti_content"));					
					notice.setNoti_passwd(rs.getString("noti_passwd"));
					notice.setNoti_date(rs.getTimestamp("noti_date"));
					notice.setNoti_readcount(rs.getInt("noti_readcount"));
					noticeList.add(notice);
				}while(rs.next());
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			closeAll();
		}
		return noticeList;
	}
	public NoticeDTO getNotice(int num) throws Exception {
		NoticeDTO notice = null;
		try {
			conn = DBCon.getConnection();
			String sql = "update notice set noti_readcount=noti_readcount+1 where noti_num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.executeUpdate();
			
			sql = "select * from notice where noti_num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				notice = new NoticeDTO();
				notice.setNoti_num(rs.getInt("noti_num"));
				notice.setNoti_writer(rs.getString("noti_writer"));
				notice.setNoti_subject(rs.getString("noti_subject"));
				notice.setNoti_file(rs.getString("noti_file"));
				notice.setNoti_content(rs.getString("noti_content"));					
				notice.setNoti_passwd(rs.getString("noti_passwd"));
				notice.setNoti_date(rs.getTimestamp("noti_date"));
				notice.setNoti_readcount(rs.getInt("noti_readcount"));
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			closeAll();
		}
		return notice;
	}
	public void deleteArticle(int num) throws Exception {

		try {
			conn = DBCon.getConnection();
			String sql = "delete from notice where noti_num = ?";
					pstmt = conn.prepareStatement(sql);
					pstmt.setInt(1, num);
					pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			closeAll();
		}
	}
	public NoticeDTO updateGetNotice(int num) throws Exception {
		NoticeDTO notice = null;
		try {
			conn = DBCon.getConnection();
			String sql = "select * from notice where noti_num = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				notice = new NoticeDTO();
				notice.setNoti_num(rs.getInt("noti_num"));
				notice.setNoti_writer(rs.getString("noti_writer"));
				notice.setNoti_subject(rs.getString("noti_subject"));
				notice.setNoti_file(rs.getString("noti_file"));
				notice.setNoti_content(rs.getString("noti_content"));					
				notice.setNoti_passwd(rs.getString("noti_passwd"));
				notice.setNoti_date(rs.getTimestamp("noti_date"));
				notice.setNoti_readcount(rs.getInt("noti_readcount"));
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			closeAll();
		}
		return notice;
	}
	
	public void updateNotice(NoticeDTO notice) throws Exception {
		try {
			conn = DBCon.getConnection();
			String sql = "update notice set noti_subject=?, noti_file=?, noti_content=?, noti_passwd=?"
							+ "where noti_num=?";
					pstmt = conn.prepareStatement(sql);
		            pstmt.setString(1, notice.getNoti_subject());
					pstmt.setString(2, notice.getNoti_file());
					pstmt.setString(3, notice.getNoti_content());
		            pstmt.setString(4, notice.getNoti_passwd());
		            pstmt.setInt(5, notice.getNoti_num());
		            pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			closeAll();
		}
	}

	private void closeAll() {
		if (rs != null) {try {rs.close();}catch(SQLException s) {}}
		if (pstmt != null) {try {pstmt.close();}catch(SQLException s) {}}
		if (conn != null) {try {conn.close();}catch(SQLException s) {}}
	}
}
