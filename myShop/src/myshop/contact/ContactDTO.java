package myshop.contact;
import java.sql.Timestamp;

public class ContactDTO{

	private int num; 
	private int goods_code;
    private String writer;
    private String email;
    private String goods_brand;
    private String subject;
    private String content;
    private String filename;
    private int ref;
    private int re_step;
    private int re_level;
    private Timestamp reg_date;

	public void setNum(int num){
    	this.num=num;
    }
	public void setGoods_code(int goods_code) {
		this.goods_code=goods_code;
	}
    public void setWriter (String writer) {
        this.writer = writer;
    }
    public void setGoods_brand(String goods_brand) {
    	this.goods_brand = goods_brand;
    }
    public void setSubject (String subject) {
        this.subject = subject;
    }
    public void setEmail (String email) {
        this.email = email;
    }
    public void setContent (String content) {
        this.content = content;
    }
    public void setFilename (String filename) {
        this.filename = filename;
    }
    public void setReg_date (Timestamp reg_date) {
        this.reg_date = reg_date;
    }
	public void setRef (int ref) {
        this.ref = ref;
    }
	public void setRe_level (int re_level) {
        this.re_level=re_level;
    }
	public void setRe_step (int re_step) {
        this.re_step=re_step;
    }
    
    public int getNum(){
    	return num;
    }
    public int getGoods_code() {
    	return goods_code;
    }
    public String getWriter () {
        return writer;
    }
    public String getGoods_brand() {
    	return goods_brand;
    }
    public String getSubject () {
        return subject;
    }
    public String getEmail () {
        return email;
    }
    public String getContent () {
        return content;
    }
    public String getFilename() {
        return filename;
    }
    public Timestamp getReg_date () {
        return reg_date;
    }
    public int getRef () {
        return ref;
    }
	public int getRe_level () {
        return re_level;
    }
	public int getRe_step () {
        return re_step;
    }
    
}