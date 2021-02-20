package myshop.shopuser;

import java.sql.Timestamp;

public class UserDTO {

	private int join;
	private String rating;
	private String user_id;
	private String user_pw;
	private String user_name;
	private String user_phone;
	private String user_address;
	private String user_address1;
	private String user_address2;
	private String user_address3;
	private Timestamp user_date;
	private String auto;
	private String user_cash;
	private String business_num;
	private String bank_num;
	private String user_birthday;
	private String user_gender;
	private String user_email;

	public String getUser_address1() {
		return user_address1;
	}

	public void setUser_address1(String user_address1) {
		this.user_address1 = user_address1;
	}

	public String getUser_address2() {
		return user_address2;
	}

	public void setUser_address2(String user_address2) {
		this.user_address2 = user_address2;
	}

	public String getUser_address3() {
		return user_address3;
	}

	public void setUser_address3(String user_address3) {
		this.user_address3 = user_address3;
	}

	public String getUser_birthday() {
		return user_birthday;
	}

	public void setUser_birthday(String user_birthday) {
		this.user_birthday = user_birthday;
	}

	public String getUser_gender() {
		return user_gender;
	}

	public void setUser_gender(String user_gender) {
		this.user_gender = user_gender;
	}

	public String getUser_email() {
		return user_email;
	}

	public void setUser_email(String user_email) {
		this.user_email = user_email;
	}

	public String getBusiness_num() {
		return business_num;
	}

	public void setBusiness_num(String business_num) {
		this.business_num = business_num;
	}

	public String getBank_num() {
		return bank_num;
	}

	public void setBank_num(String bank_num) {
		this.bank_num = bank_num;
	}

	public int getJoin() {
		return join;
	}

	public void setJoin(int join) {
		this.join = join;
	}

	public String getRating() {
		return rating;
	}

	public void setRating(String rating) {
		this.rating = rating;
	}

	public String getUser_id() {
		return user_id;
	}

	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}

	public String getUser_pw() {
		return user_pw;
	}

	public void setUser_pw(String user_pw) {
		this.user_pw = user_pw;
	}

	public String getUser_name() {
		return user_name;
	}

	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}

	public String getUser_phone() {
		return user_phone;
	}

	public void setUser_phone(String user_phone) {
		this.user_phone = user_phone;
	}

	public String getUser_address() {
		   return user_address;
		}

	public void setUser_address(String user_address) {
        this.user_address = user_address;
     }

	public Timestamp getUser_date() {
		return user_date;
	}

	public void setUser_date(Timestamp user_date) {
		this.user_date = user_date;
	}

	public String getAuto() {
		return auto;
	}

	public void setAuto(String auto) {
		this.auto = auto;
	}

	public String getUser_cash() {
		return user_cash;
	}

	public void setUser_cash(String user_cash) {
		this.user_cash = user_cash;
	}

}
