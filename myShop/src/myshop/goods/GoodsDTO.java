package myshop.goods;

public class GoodsDTO {

	private int goods_code;
	private String goods_brand;
	private String goods_name;
	private int goods_price;
	private int goods_delivery;
	private int goods_state;
	private String goods_option;
	private String goods_img;
	private String goods_msg;
	private int goods_count;
	private int Goods_amount;
	
		public int getGoods_amount() {
		return Goods_amount;
	}

	public void setGoods_amount(int goods_amount) {
		Goods_amount = goods_amount;
	}

		public int getGoods_code() {
		return goods_code;
	}

	public void setGoods_code(int goods_code) {
		this.goods_code = goods_code;
	}

	public String getGoods_img() {
		return goods_img;
	}

	public void setGoods_img(String goods_img) {
		this.goods_img = goods_img;
	}

	public String getGoods_brand() {
		return goods_brand;
	}

	public void setGoods_brand(String goods_brand) {
		this.goods_brand = goods_brand;
	}

	public String getGoods_name() {
		return goods_name;
	}

	public void setGoods_name(String goods_name) {
		this.goods_name = goods_name;
	}

	public int getGoods_price() {
		return goods_price;
	}

	public void setGoods_price(int goods_price) {
		this.goods_price = goods_price;
	}

	public int getGoods_delivery() {
		return goods_delivery;
	}

	public void setGoods_delivery(int goods_delivery) {
		this.goods_delivery = goods_delivery;
	}

	public String getGoods_option() {
		return goods_option;
	}

	public void setGoods_option(String goods_option) {
		this.goods_option = goods_option;
	}

	public String getGoods_msg() {
		return goods_msg;
	}

	public void setGoods_msg(String goods_msg) {
		this.goods_msg = goods_msg;
	}

	public int getGoods_state() {
		return goods_state;
	}

	public void setGoods_state(int goods_state) {
		this.goods_state = goods_state;
	}
	
	public int getGoods_count() {
		return goods_count;
	}

	public void setGoods_count(int goods_count) {
		this.goods_count = goods_count;
	}

	
}
