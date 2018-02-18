package member;

public class MemberVO {
	private String password;
	private String name;
	private String email;
	private String sch_emt;
	private String sch_mid;
	private String sch_high;
	private int birthday;
	private String content;
	private int num;
	
	
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getSch_emt() {
		return sch_emt;
	}
	public void setSch_emt(String sch_emt) {
		this.sch_emt = sch_emt;
	}
	public String getSch_mid() {
		return sch_mid;
	}
	public void setSch_mid(String sch_mid) {
		this.sch_mid = sch_mid;
	}
	public String getSch_high() {
		return sch_high;
	}
	public void setSch_high(String sch_high) {
		this.sch_high = sch_high;
	}
	public int getBirthday() {
		return birthday;
	}
	public void setBirthday(int birthday) {
		this.birthday = birthday;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	@Override
	public String toString() {
		return "MemberVO [password=" + password + ", name=" + name + ", email=" + email + ", sch_emt=" + sch_emt
				+ ", sch_mid=" + sch_mid + ", sch_high=" + sch_high + ", birthday=" + birthday + ", content=" + content
				+ ", num=" + num + "]";
	}
	
}
