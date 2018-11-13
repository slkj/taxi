package cn.slkj.taxi.entity;

public class EmployeeRank
{
  private String pid;
  private String year;
  private String rank;
  
  public String getYear()
  {
    return this.year;
  }
  
  public void setYear(String year)
  {
    this.year = year;
  }
  
  public void setRank(String rank)
  {
    this.rank = rank;
  }
  
  public String getRank()
  {
    return this.rank;
  }
  
  public String getPid()
  {
    return this.pid;
  }
  
  public void setPid(String pid)
  {
    this.pid = pid;
  }
}
