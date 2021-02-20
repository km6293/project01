package myshop.cmu_comment;

import java.sql.Timestamp;

public class CommentDTO {

	private int num;
	private int cmt_num;
	private String cmt_writer;
	private String cmt_content;
	private Timestamp cmt_date;
	private int cmt_state;
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public int getCmt_num() {
		return cmt_num;
	}
	public void setCmt_num(int cmt_num) {
		this.cmt_num = cmt_num;
	}
	public String getCmt_writer() {
		return cmt_writer;
	}
	public void setCmt_writer(String cmt_writer) {
		this.cmt_writer = cmt_writer;
	}
	public String getCmt_content() {
		return cmt_content;
	}
	public void setCmt_content(String cmt_content) {
		this.cmt_content = cmt_content;
	}
	public Timestamp getCmt_date() {
		return cmt_date;
	}
	public void setCmt_date(Timestamp cmt_date) {
		this.cmt_date = cmt_date;
	}
	public int getCmt_state() {
		return cmt_state;
	}
	public void setCmt_state(int cmt_state) {
		this.cmt_state = cmt_state;
	}

}
