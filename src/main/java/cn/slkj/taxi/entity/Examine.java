/**  
 * @Title:  Examine.java   
 * @Package cn.slkj.taxi.entity   
 * @Description:    TODO(用一句话描述该文件做什么)   
 * @author: maxh     
 * @date:   2018年11月22日 上午9:36:25   
 * @version V1.0 
 */
package cn.slkj.taxi.entity;

/**   
 * @ClassName:  Examine   
 * @Description:考核 
 * @author: maxh 
 * @date:   2018年11月22日 上午9:36:25   
 *     
 */
public class Examine {

	private String empId;
	private String ordinalId;
	private String ordinal;
	private String scoring;
	private String examineTime;
	private String remark;
	public String getEmpId() {
		return empId;
	}
	public void setEmpId(String empId) {
		this.empId = empId;
	}
	public String getOrdinalId() {
		return ordinalId;
	}
	public void setOrdinalId(String ordinalId) {
		this.ordinalId = ordinalId;
	}
	public String getScoring() {
		return scoring;
	}
	public void setScoring(String scoring) {
		this.scoring = scoring;
	}
	 
	public String getExamineTime() {
		return examineTime;
	}
	public void setExamineTime(String examineTime) {
		this.examineTime = examineTime;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
		
	}
	public String getOrdinal() {
		return ordinal;
	}
	public void setOrdinal(String ordinal) {
		this.ordinal = ordinal;
	}
	
}
