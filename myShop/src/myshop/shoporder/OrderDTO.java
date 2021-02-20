package myshop.shoporder;
import java.sql.Timestamp;

public class OrderDTO 
{
	private int order_pk;
	private int order_number;
	private int goods_code;
	private String user_id;
	private String re_name;
	private String re_phone;
	private String re_address;
	private int amount;
	private int total_price;
	private String track;
	private Timestamp order_date;
	private String goods_brand;
	
	public String getGoods_brand() {
		return goods_brand;
	}
	public void setGoods_brand(String goods_brand) {
		this.goods_brand = goods_brand;
	}
	public void setOrder_pk(int order_pk)
	{
		this.order_pk = order_pk;
	}
	public void setOrder_number(int orderNumber)
	{
		this.order_number = orderNumber;
	}
	public void setGoods_code(int goods_code)
	{
		this.goods_code=goods_code;
	}
	public void setRe_name(String re_name)
	{
		this.re_name = re_name;
	}
	public void setRe_phone(String re_phone)
	{
		this.re_phone = re_phone;
	}
	public void setRe_address(String re_address)
	{
		this.re_address = re_address;
	}
	public void setUser_id(String user_id)
	{
		this.user_id=user_id;
	}
	public void setAmount(int amount)
	{
		this.amount=amount;
	}
	public void setTotal_price(int total_price)
	{
		this.total_price=total_price;
	}
	public void setTrack(String track)
	{
		this.track = track;
	}
	public void setOrderDate(Timestamp orderDate)
	{
		this.order_date=orderDate;
	}
	
	
	public int getOrder_pk()
	{
		return order_pk;
	}
	public int getOrder_number()
	{
		return order_number;
	}
	public int getGoods_code()
	{
		return goods_code;
	}
	public String getUser_id()
	{
		return user_id;
	}
	public String getRe_name() {
		return re_name;
	}
	public String getRe_phone() {
		return re_phone;
	}
	public String getRe_address() {
		return re_address;
	}
	public int getAmount()
	{
		return amount;
	}
	public int getTotal_price()
	{
		return total_price;
	}
	public String getTrack()
	{
		return track;
	}
	public Timestamp getOrder_date()
	{
		return order_date;
	}
	
}
