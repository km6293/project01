package myshop.notice;

import java.sql.Timestamp;

public class NoticeDTO {

		private int noti_num;
		private String noti_writer;
		private String noti_subject;
		private String noti_file;
		private String noti_content;
		private String noti_passwd;
		private Timestamp noti_date;
		private int noti_readcount;
		
		public int getNoti_num() {
			return noti_num;
		}
		public void setNoti_num(int noti_num) {
			this.noti_num = noti_num;
		}
		public String getNoti_writer() {
			return noti_writer;
		}
		public void setNoti_writer(String noti_writer) {
			this.noti_writer = noti_writer;
		}
		public String getNoti_subject() {
			return noti_subject;
		}
		public void setNoti_subject(String noti_subject) {
			this.noti_subject = noti_subject;
		}
		public String getNoti_file() {
			return noti_file;
		}
		public void setNoti_file(String noti_file) {
			this.noti_file = noti_file;
		}
		public String getNoti_content() {
			return noti_content;
		}
		public void setNoti_content(String noti_content) {
			this.noti_content = noti_content;
		}
		public String getNoti_passwd() {
			return noti_passwd;
		}
		public void setNoti_passwd(String noti_passwd) {
			this.noti_passwd = noti_passwd;
		}
		public Timestamp getNoti_date() {
			return noti_date;
		}
		public void setNoti_date(Timestamp noti_date) {
			this.noti_date = noti_date;
		}
		public int getNoti_readcount() {
			return noti_readcount;
		}
		public void setNoti_readcount(int noti_readcount) {
			this.noti_readcount = noti_readcount;
		}	
}
