package myshop.goodscmt;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import javax.sql.DataSource;
import myshop.alldb.DBCon;

public class CmtDAO {
    
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
 	private static CmtDAO instance = new CmtDAO();
    
    public static CmtDAO getInstance() {
    	return instance;
    	}
    
    private CmtDAO() {}
    
    public void insertCmt(CmtDTO dto) {
    	
        try {
            conn = DBCon.getConnection();
            
            String sql = "insert into goodscmt values (goodscmt_seq.nextval,?,?,?,sysdate)";
            
		    pstmt = conn.prepareStatement(sql);
		    pstmt.setInt(1, dto.getGoods_code());
		    pstmt.setString(2, dto.getWriter());
			pstmt.setString(3, dto.getContent());
            
			pstmt.executeUpdate();
        } catch(Exception e) {
            e.printStackTrace();
        }finally {
			closeAll();
		}
    }

	public List<CmtDTO> getList(){
    	List<CmtDTO> list = new ArrayList<CmtDTO>();
	
        try {
        	conn = DBCon.getConnection();
            
        	String sql = "SELECT num, goods_code, writer, content, reg_date" +
                    " FROM goodscmt" +
                    " ORDER BY num desc";
        	 pstmt = conn.prepareStatement(sql);
             rs = pstmt.executeQuery();
             
             while(rs.next()) {
                 CmtDTO dto = new CmtDTO();
                 dto.setNum(rs.getInt(1));
                 dto.setGoods_code(rs.getInt(2));
                 dto.setWriter(rs.getString(3));
                 dto.setContent(rs.getString(4));
                 dto.setReg_date(rs.getTimestamp(5));
               
                 list.add(dto);
             }
       
        } catch(Exception e) {
            e.printStackTrace();
        } finally {
            closeAll();
        }
		return list;
}

	public List<CmtDTO> getList(int goods_code, int start, int end)
	{
    	List<CmtDTO> list = new ArrayList<CmtDTO>();
	
        try 
        {
        	String sql ="select * from (select num,goods_code,writer,content,reg_date, rownum r from" + 
        			" (select * from goodscmt where goods_code = ? order by num desc) order by num desc)" + 
        			" where r >= ? and r <= ?";
        	
        	conn = DBCon.getConnection();
        	
        	pstmt = conn.prepareStatement(sql);
        	pstmt.setInt(1, goods_code);
        	pstmt.setInt(2, start);
        	pstmt.setInt(3, end);
        	rs = pstmt.executeQuery(); 
             
             while( rs.next() ) 
             {
                 CmtDTO dto = new CmtDTO();
                 dto.setNum(rs.getInt(1));
                 dto.setGoods_code(rs.getInt(2));
                 dto.setWriter(rs.getString(3));
                 dto.setContent(rs.getString(4));
                 dto.setReg_date(rs.getTimestamp(5));
                 
                 list.add(dto);
             }
       
        } 
        catch(Exception e) 
        {
            e.printStackTrace();
        } 
        finally 
        {
            closeAll();
        }
		return list;
}
	
	public List<CmtDTO> getList(int goodscode){
    	List<CmtDTO> list = new ArrayList<CmtDTO>();
	
        try {
        	conn = DBCon.getConnection();
            
        	String sql = "select * from goodscmt where goods_code = ?"+
        			"order by num desc";
        	 pstmt = conn.prepareStatement(sql);
        	 pstmt.setInt(1, goodscode);
             rs = pstmt.executeQuery();
             
             while(rs.next()) {
                 CmtDTO dto = new CmtDTO();
                 dto.setNum(rs.getInt(1));
                 dto.setGoods_code(rs.getInt(2));
                 dto.setWriter(rs.getString(3));
                 dto.setContent(rs.getString(4));
                 dto.setReg_date(rs.getTimestamp(5));
                 
                 list.add(dto);
             }
       
        } catch(Exception e) {
            e.printStackTrace();
        } finally {
            closeAll();
        }
		return list;
}	
	public void deleteCmt(int num) throws Exception
	{
		
	   try 
	   {
	      conn = DBCon.getConnection();
	      pstmt = conn.prepareStatement("delete goodsCmt where num = ?");
	      pstmt.setInt(1, num);
	      pstmt.executeUpdate();
	      
	   } 
	   catch(Exception ex)
	   {
	      ex.printStackTrace();
	   } 
	 finally {
			closeAll();
		}

}

    
	private void closeAll() {
	      if (rs != null) {
	         try {
	            rs.close();
	         } catch (SQLException s) {
	         }
	      }
	      if (pstmt != null) {
	         try {
	            pstmt.close();
	         } catch (SQLException s) {
	         }
	      }
	      if (conn != null) {
	         try {
	            conn.close();
	         } catch (SQLException s) {
	         }
	      }
	   }
	}
