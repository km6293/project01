package myshop.qnaboard;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import javax.sql.DataSource;
import myshop.alldb.DBCon;

public class QnaDAO {

   private static QnaDAO instance = new QnaDAO();

   public static QnaDAO getInstance() {
      return instance;
   }

   private QnaDAO() {
   }

   Connection conn = null;
   PreparedStatement pstmt = null;
   ResultSet rs = null;

   public void insertQna(QnaDTO dto) {

      int num = dto.getNum();
      int ref = dto.getRef();
      int re_step = dto.getRe_step();
      int re_level = dto.getRe_level();
      int number = 0;
      String sql = "";

      try {
         conn = DBCon.getConnection();

         pstmt = conn.prepareStatement("select max(num) from qnaboard");
         rs = pstmt.executeQuery();

         if (rs.next())
            number = rs.getInt(1) + 1;
         else
            number = 1;

         if (num != 0) {
            sql = "update qnaboard set re_step=re_step+1 where ref= ? and re_step> ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, ref);
            pstmt.setInt(2, re_step);
            pstmt.executeUpdate();
            re_step = re_step + 1;
            re_level = re_level + 1;
         } else {
            ref = number;
            re_step = 0;
            re_level = 0;
         }
         sql = "insert into qnaboard values(qnaboard_seq.nextval,?,?,?,?,?,?,0,?,?,?,?)";

         pstmt = conn.prepareStatement(sql);
         pstmt.setString(1, dto.getWriter());
         pstmt.setString(2, dto.getSubject());
         pstmt.setString(3, dto.getEmail());
         pstmt.setString(4, dto.getContent());
         pstmt.setString(5, dto.getPasswd());
         pstmt.setTimestamp(6, dto.getReg_date());
         pstmt.setInt(7, ref);
         pstmt.setInt(8, re_step);
         pstmt.setInt(9, re_level);
         pstmt.setInt(10, dto.getGoods_code());
         pstmt.executeUpdate();
      } catch (Exception ex) {
         ex.printStackTrace();
      } finally {
         closeAll();
      }
   }

   public int getQnaCount() throws Exception {

      int x = 0;

      try {
         conn = DBCon.getConnection();
         pstmt = conn.prepareStatement("select count(*) from qnaboard");
         rs = pstmt.executeQuery();

         if (rs.next()) {
            x = rs.getInt(1);
         }
      } catch (Exception e) {
         e.printStackTrace();
      } finally {
         closeAll();
      }
      return x;
   }

   public int getQnaCount(int goods_code) throws Exception {
      int x = 0;

      try {
         conn = DBCon.getConnection();

         pstmt = conn.prepareStatement("select count(*) from qnaboard where goods_code=?");
         pstmt.setInt(1, goods_code);
         rs = pstmt.executeQuery();

         if (rs.next()) {
            x = rs.getInt(1);
         }
      } catch (Exception ex) {
         ex.printStackTrace();
      } finally {
         closeAll();
      }
      return x;
   }

   public List getQnas(int start, int end) throws Exception {
      List QnaList = null;
      try {
         conn = DBCon.getConnection();

         pstmt = conn.prepareStatement(
               "select num,writer,email,subject,passwd,reg_date,ref,re_step,re_level,content,goods_code,readcount,r "
                     + "from (select num,writer,email,subject,passwd,reg_date,ref,re_step,re_level,content,goods_code,readcount,rownum r "
                     + "from (select * from qnaboard order by ref desc, re_step asc) order by ref desc, re_step asc ) where r >= ? and r <= ?");

         pstmt.setInt(1, start);
         pstmt.setInt(2, end);
         rs = pstmt.executeQuery();

         if (rs.next()) {
            QnaList = new ArrayList(end);
            do {
               QnaDTO dto = new QnaDTO();
               dto.setNum(rs.getInt("num"));
               dto.setWriter(rs.getString("writer"));
               dto.setEmail(rs.getString("email"));
               dto.setSubject(rs.getString("subject"));
               dto.setPasswd(rs.getString("passwd"));
               dto.setReg_date(rs.getTimestamp("reg_date"));
               dto.setReadcount(rs.getInt("readcount"));
               dto.setRef(rs.getInt("ref"));
               dto.setRe_step(rs.getInt("re_step"));
               dto.setRe_level(rs.getInt("re_level"));
               dto.setContent(rs.getString("content"));
               dto.setGoods_code(rs.getInt("goods_code"));

               QnaList.add(dto);
            } while (rs.next());
         }
      } catch (Exception e) {
         e.printStackTrace();
      } finally {
         closeAll();
      }
      return QnaList;
   }

   public List getQnas(int start, int end, int goods_code) // goodscode
         throws Exception {
      List QnaList = null;
      try {
         conn = DBCon.getConnection();

         pstmt = conn.prepareStatement(
               "select num,writer,email,subject,passwd,reg_date,ref,re_step,re_level,content,goods_code,readcount,r "
                     + "from (select num,writer,email,subject,passwd,reg_date,ref,re_step,re_level,content,goods_code,readcount,rownum r "
                     + "from (select * from qnaboard where goods_code = ? order by ref desc, re_step asc) order by ref desc, re_step asc ) where r >= ? and r <= ?");
         pstmt.setInt(1, goods_code);
         pstmt.setInt(2, start);
         pstmt.setInt(3, end);

         rs = pstmt.executeQuery();

         if (rs.next()) {
            QnaList = new ArrayList(end);
            do {
               QnaDTO dto = new QnaDTO();
               dto.setNum(rs.getInt("num"));
               dto.setWriter(rs.getString("writer"));
               dto.setEmail(rs.getString("email"));
               dto.setSubject(rs.getString("subject"));
               dto.setPasswd(rs.getString("passwd"));
               dto.setReg_date(rs.getTimestamp("reg_date"));
               dto.setReadcount(rs.getInt("readcount"));
               dto.setRef(rs.getInt("ref"));
               dto.setRe_step(rs.getInt("re_step"));
               dto.setRe_level(rs.getInt("re_level"));
               dto.setContent(rs.getString("content"));
               dto.setGoods_code(rs.getInt("goods_code"));

               QnaList.add(dto);
            } while (rs.next());
         }
      } catch (Exception e) {
         e.printStackTrace();
      } finally {
         closeAll();
      }
      return QnaList;
   }

   public List getQnas(int start, int end, String writer) throws Exception {
      List QnaList = null;
      try {
         conn = conn = DBCon.getConnection();
         pstmt = conn.prepareStatement(
               "select num,writer,email,subject,passwd,reg_date,ref,-re_step,re_level,content,goods_code,readcount,r "
                     + "from (select num,writer,email,subject,passwd,reg_date,ref,re_step,re_level,content,goods_code,readcount,rownum r "
                     + "from (select num,writer,email,subject,passwd,reg_date,ref,re_step,re_level,content,goods_code,readcount "
                     + "from qnaboard where writer=? order by ref desc, re_step asc) order by ref desc, re_step asc ) where r >= ? and r <= ? ");
         pstmt.setString(1, writer);
         pstmt.setInt(2, start);
         pstmt.setInt(3, end);
         rs = pstmt.executeQuery();

         if (rs.next()) {
            QnaList = new ArrayList(end);
            do {
               QnaDTO dto = new QnaDTO();
               dto.setNum(rs.getInt("num"));
               dto.setWriter(rs.getString("writer"));
               dto.setEmail(rs.getString("email"));
               dto.setSubject(rs.getString("subject"));
               dto.setPasswd(rs.getString("passwd"));
               dto.setReg_date(rs.getTimestamp("reg_date"));
               dto.setReadcount(rs.getInt("readcount"));
               dto.setRef(rs.getInt("ref"));
               dto.setRe_step(rs.getInt("re_step"));
               dto.setRe_level(rs.getInt("re_level"));
               dto.setContent(rs.getString("content"));
               dto.setGoods_code(rs.getInt("goods_code"));
               QnaList.add(dto);
            } while (rs.next());
         }
      } catch (Exception ex) {
         ex.printStackTrace();
      } finally {
         closeAll();
      }
      return QnaList;
   }

   public QnaDTO getQna(int num) throws Exception {
      QnaDTO dto = null;
      try {
         conn = DBCon.getConnection();
         pstmt = conn.prepareStatement("update qnaboard set readcount=readcount+1 where num = ?");
         pstmt.setInt(1, num);
         pstmt.executeUpdate();

         pstmt = conn.prepareStatement("select * from qnaboard where num = ?");
         pstmt.setInt(1, num);
         rs = pstmt.executeQuery();

         if (rs.next()) {
            dto = new QnaDTO();
            dto.setNum(rs.getInt("num"));
            dto.setWriter(rs.getString("writer"));
            dto.setEmail(rs.getString("email"));
            dto.setSubject(rs.getString("subject"));
            dto.setPasswd(rs.getString("passwd"));
            dto.setReg_date(rs.getTimestamp("reg_date"));
            dto.setReadcount(rs.getInt("readcount"));
            dto.setRef(rs.getInt("ref"));
            dto.setRe_step(rs.getInt("re_step"));
            dto.setRe_level(rs.getInt("re_level"));
            dto.setContent(rs.getString("content"));
            dto.setGoods_code(rs.getInt("goods_code"));
         }
      } catch (Exception e) {
         e.printStackTrace();
      } finally {
         closeAll();
      }
      return dto;
   }

   public QnaDTO updateGetQna(int num) throws Exception {
      QnaDTO dto = null;
      try {
         conn = DBCon.getConnection();

         pstmt = conn.prepareStatement("select * from qnaboard where num = ?");
         pstmt.setInt(1, num);
         rs = pstmt.executeQuery();

         if (rs.next()) {
            dto = new QnaDTO();
            dto.setNum(rs.getInt("num"));
            dto.setWriter(rs.getString("writer"));
            dto.setEmail(rs.getString("email"));
            dto.setSubject(rs.getString("subject"));
            dto.setReg_date(rs.getTimestamp("reg_date"));
            dto.setReadcount(rs.getInt("readcount"));
            dto.setRef(rs.getInt("ref"));
            dto.setRe_step(rs.getInt("re_step"));
            dto.setRe_level(rs.getInt("re_level"));
            dto.setContent(rs.getString("content"));
            dto.setGoods_code(rs.getInt("goods_code"));
         }
      } catch (Exception e) {
         e.printStackTrace();
      } finally {
         closeAll();
      }
      return dto;
   }

   public int updateQna(QnaDTO dto) throws Exception {
      String sql = "";
      int x = -1;
      try {
         conn = DBCon.getConnection();

         pstmt = conn.prepareStatement("select * from qnaboard where num = ?");
         pstmt.setInt(1, dto.getNum());
         rs = pstmt.executeQuery();

         if (rs.next()) {
               sql = "update qnaboard set writer=?,subject=?,email=?,content=?"
                     + ",goods_code=? where num=?";
               pstmt = conn.prepareStatement(sql);

               pstmt.setString(1, dto.getWriter());
               pstmt.setString(2, dto.getSubject());
               pstmt.setString(3, dto.getEmail());
               pstmt.setString(4, dto.getContent());
               pstmt.setInt(5, dto.getGoods_code());
               pstmt.setInt(6, dto.getNum());
               pstmt.executeUpdate();
               x = 1;
            } else {
               x = 0;
            }
      } catch (Exception e) {
         e.printStackTrace();
      } finally {
         closeAll();
      }
      return x;
   }

   public int deleteQna(int num) throws Exception {
      int x = -1;
      try {
         conn = DBCon.getConnection();

         pstmt = conn.prepareStatement("select * from qnaboard where num = ?");
         pstmt.setInt(1, num);
         rs = pstmt.executeQuery();

         if (rs.next()) {
               pstmt = conn.prepareStatement("delete from qnaboard where num=?");
               pstmt.setInt(1, num);
               pstmt.executeUpdate();
               x = 1;
            } else
               x = 0;
      
      } catch (Exception e) {
         e.printStackTrace();
      } finally {
         closeAll();
      }
      return x;
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