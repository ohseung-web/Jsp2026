package model;

public class MemberTestDTO {
//   DB필드명을 멤버변수로 작성한다.
//	단, 접근제어자는 private로 작성한다.
	private String id;
	private String pass;
	private String email;
	private String tel;
	private String address;
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPass() {
		return pass;
	}
	public void setPass(String pass) {
		this.pass = pass;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getTel() {
		return tel;
	}
	public void setTel(String tel) {
		this.tel = tel;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	
	// 반드시 geter/seter한다.
	
	
	
}
