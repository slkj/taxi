package cn.slkj.taxi.entity;

/**
 * 
 * @ClassName:  EmployeeReplaceSign   
 * @Description:从业资格证换证   
 * @author: wangling 
 * @date:   2018年12月9日 上午10:09:56   
 *
 */
public class EmployeeReplaceSign
{
	  private String id;
	  private String name;
	  private String nationality;
	  private String cyzgCard;
	  private String sex;
	  private String borndate;
	  private String idcard;
	  private String address;
	  private String phone;
	  private String driveType;
	  private String driveStartDate;
	  private String company;
	  private String carid;
	  private String oldSignId;
	  private String firstSignDate;
	  private String firstSignDateFormat;
	  private String passtime;
	  private String passtimeFormat;
	  private String status;
	  private String addtime;
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getNationality() {
		return nationality;
	}
	public void setNationality(String nationality) {
		this.nationality = nationality;
	}
	public String getCyzgCard() {
		return cyzgCard;
	}
	public void setCyzgCard(String cyzgCard) {
		this.cyzgCard = cyzgCard;
	}
	public String getSex() {
		return sex;
	}
	public void setSex(String sex) {
		this.sex = sex;
	}
	public String getBorndate() {
		return borndate;
	}
	public void setBorndate(String borndate) {
		this.borndate = borndate;
	}
	public String getIdcard() {
		return idcard;
	}
	public void setIdcard(String idcard) {
		this.idcard = idcard;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getDriveType() {
		return driveType;
	}
	public void setDriveType(String driveType) {
		this.driveType = driveType;
	}
	public String getDriveStartDate() {
		return driveStartDate;
	}
	public void setDriveStartDate(String driveStartDate) {
		this.driveStartDate = driveStartDate;
	}
	public String getCompany() {
		return company;
	}
	public void setCompany(String company) {
		this.company = company;
	}
	public String getCarid() {
		return carid;
	}
	public void setCarid(String carid) {
		this.carid = carid;
	}
	public String getOldSignId() {
		return oldSignId;
	}
	public void setOldSignId(String oldSignId) {
		this.oldSignId = oldSignId;
	}
	public String getFirstSignDate() {
		return firstSignDate;
	}
	public void setFirstSignDate(String firstSignDate) {
		this.firstSignDate = firstSignDate;
	}
	public String getFirstSignDateFormat() {
		return firstSignDateFormat;
	}
	public void setFirstSignDateFormat(String firstSignDateFormat) {
		this.firstSignDateFormat = firstSignDateFormat;
	}
	public String getPasstime() {
		return passtime;
	}
	public void setPasstime(String passtime) {
		this.passtime = passtime;
	}
	public String getPasstimeFormat() {
		return passtimeFormat;
	}
	public void setPasstimeFormat(String passtimeFormat) {
		this.passtimeFormat = passtimeFormat;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getAddtime() {
		return addtime;
	}
	public void setAddtime(String addtime) {
		this.addtime = addtime;
	}
	@Override
	public String toString() {
		return "EmployeeReplaceSign [id=" + id + ", name=" + name
				+ ", nationality=" + nationality + ", cyzgCard=" + cyzgCard
				+ ", sex=" + sex + ", borndate=" + borndate + ", idcard="
				+ idcard + ", address=" + address + ", phone=" + phone
				+ ", driveType=" + driveType + ", driveStartDate="
				+ driveStartDate + ", company=" + company + ", carid=" + carid
				+ ", oldSignId=" + oldSignId + ", firstSignDate="
				+ firstSignDate + ", firstSignDateFormat="
				+ firstSignDateFormat + ", passtime=" + passtime
				+ ", passtimeFormat=" + passtimeFormat + ", status=" + status
				+ ", addtime=" + addtime + "]";
	}
  
	  
}
