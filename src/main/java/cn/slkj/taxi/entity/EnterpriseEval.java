package cn.slkj.taxi.entity;

/**
 * 

* <p>Title: CompanyEval</p>  

* <p>Description: </p>  

* @author wangling  

* @date 2018年10月30日
 */
 
public class EnterpriseEval {
	private String id;
	private String parent_id; 
	private String date; 
	private String project; 
	private String reduction; 
	private String plus; 
	private String note; 
	private String addtime;
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getParent_id() {
		return parent_id;
	}
	public void setParent_id(String parent_id) {
		this.parent_id = parent_id;
	}
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	public String getProject() {
		return project;
	}
	public void setProject(String project) {
		this.project = project;
	}
	public String getReduction() {
		return reduction;
	}
	public void setReduction(String reduction) {
		this.reduction = reduction;
	}
	public String getPlus() {
		return plus;
	}
	public void setPlus(String plus) {
		this.plus = plus;
	}
	public String getNote() {
		return note;
	}
	public void setNote(String note) {
		this.note = note;
	}
	public String getAddtime() {
		return addtime;
	}
	public void setAddtime(String addtime) {
		this.addtime = addtime;
	}
	@Override
	public String toString() {
		return "CompanyEval [id=" + id + ", parent_id=" + parent_id + ", date="
				+ date + ", project=" + project + ", reduction=" + reduction
				+ ", plus=" + plus + ", note=" + note + ", addtime=" + addtime
				+ "]";
	}
	
	

}
